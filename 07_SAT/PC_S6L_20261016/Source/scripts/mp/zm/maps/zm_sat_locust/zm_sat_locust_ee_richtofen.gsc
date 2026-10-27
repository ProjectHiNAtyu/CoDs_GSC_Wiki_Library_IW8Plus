// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_richtofen.gsc  (hash_6a27fe92b49f3b45.gscc) (size: 100762 Bytes / 0x1899a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4916d5de (1226233310)
// size ...... 100762 (0x1899a)
// includes .. 32  (offset: 0x17556)
// strings ... 282 (offset: 0x17656)
// dev strs .. 61  (offset: 0x186a6)
// exports ... 169 (offset: 0x114c2)
// cseg ...... 0x1d34 + 0xf78e (0x114c2)
// imports ... 472 (offset: 0x12f2a)
// animtree1 . 0   (offset: 0x1899a)
// animtree2 . 0   (offset: 0x1899a)
#using scripts\anim\dialogue;
#using scripts\anim\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\perk_m_mod;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_ee_richtofen;

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x5
// Checksum 0x3925ff21, Offset: 0x1d52
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_ff7a8692bfd9781d", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x5d300962, Offset: 0x1d7f
// Size: 0x3e3
function private pre_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_627fb37fdb9b935c", 1 ) )
    {
        return;
    }
    
    level._effect[ "richtofen_door_open" ] = loadfxasset( "vfx_sat_levels_zm_locust_ee_room_door_opening_dust" );
    level._effect[ "richtofen_door_close" ] = loadfxasset( "vfx_sat_levels_zm_locust_ee_room_door_closing_dust" );
    level._effect[ "richtofen_door_under_smoke" ] = loadfxasset( "vfx_sat_levels_zm_locust_ee_room_under_door_smoke" );
    level._effect[ "richtofen_prop_spawn" ] = loadfxasset( "vfx_sat_levels_zm_locust_debris_aether_disapper" );
    level._effect[ "richtofen_dig_medal" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_dsm_arm" );
    level._effect[ "richtofen_lid_off" ] = loadfxasset( "vfx_t10_levels_sp_storm_stm_gib_kill_lrg_chunks" );
    utility::add_fx( "richtofen_teleport_out", "vfx_sat_firefly_player_teleporting_out" );
    utility::add_fx( "richtofen_crystal", "vfx_sat_levels_zm_locust_115_motes" );
    utility::add_fx( "richtofen_camera", "vfx_sat_levels_zm_mote_camera_01" );
    level.ee_richtofen = { #var_4a1630a7ec169dff:getdvarint( @"hash_e1b4251909292920", 1 ), #var_cc16d15d20cb8ac5:getdvarint( @"hash_cde979a40ef929f0", 60 ), #var_9483bcaade88c506:getdvarint( @"hash_b3aefde9122e8341", 300 ), #var_f851405bf5428000:getdvarint( @"hash_f33edd5e6333bad3", 15 ), #var_86d2f0958d6cf54b:getdvarfloat( @"hash_658e7814a9dd4fa2", 5 ), #fire_damage_tick_rate:getdvarfloat( @"hash_ad4aaa0aea77c23e", 0.25 ), #var_fd90b188d7de6f4a:getdvarint( @"hash_a8e7811b57fc4623", 1 ), #round_num_to_start:getdvarint( @"hash_a02013c99f639f18", 15 ), #completed_players:[], #zombies:[] };
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"melee_barrel", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"collect_medal", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"read_notes", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_45db1cbd2969cb8a", &function_e963d59dc8feaa07, &function_66f87d6979309cf4 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_45db1bbd2969c9d7", &function_e963d69dc8feac3a, &function_66f880697930a38d );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_45db1abd2969c824", &function_e963d79dc8feae6d, &function_66f87f697930a15a );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_b5d9fdba380d404b", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"room_interactions", &function_7d6d653ab952c93d, &function_60062748e78b81a2 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"balance_scale", &function_3fd49f9e08230205, &function_c0b54769bbf47a32 );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"tune_radio", &function_3fd49c9e0822fb6c, &function_c0b54669bbf477ff );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"return_sword", &function_3fd49d9e0822fd9f, &function_c0b54569bbf475cc );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_872d47032037d8b3", &function_7d6d623ab952c2a4, &function_60062648e78b7f6f );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_87c9b969b79d70ab", &function_7d6d633ab952c4d7, &function_60062548e78b7d3c );
    zm_quest::register_quest_step( #"hash_ff7a8692bfd9781d", #"hash_6db2651f31d07a4c", &function_7d6d583ab952aca6, &function_60062c48e78b8ca1 );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xfccde6e8, Offset: 0x216a
// Size: 0xca
function private post_main()
{
    level thread function_5c745d4d6c8aa887();
    
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_627fb37fdb9b935c", 1 ) )
    {
        level thread init_quest_off();
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    init_dialog();
    level thread function_44f005c492157755();
    level thread function_5431bd441190b0();
    level thread function_b127195ef7ad5ed6();
    level thread function_9fc82136c9f72ab2();
    level thread function_c419e99e4f96232b();
    level thread function_9faf2ce6e7d814da();
    level callback::add( "on_round_start", &function_1c2ab91e77f0c6ae );
    zm_save::function_1f44a48caae2acbf();
    level thread function_de5f58d24b50c16();
    level thread zm_quest::start_quest( #"hash_ff7a8692bfd9781d" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xa91a2116, Offset: 0x223c
// Size: 0x307
function private init_quest_off()
{
    all_doors = [];
    side_door_locs = utility::getstructarray( "rr_3_side" );
    end_door_locs = utility::getstructarray( "rr_3_end" );
    var_ceaa7f1f6b3f547c = arraycombine( side_door_locs, end_door_locs );
    
    foreach ( var_c9d01d7ab0239b9b in var_ceaa7f1f6b3f547c )
    {
        scriptable = getentitylessscriptablearray( %"t10_door_wooden_panel_03_painted_left_mp", undefined, var_c9d01d7ab0239b9b.origin, 100 )[ 0 ];
        
        if ( !scriptable )
        {
            scriptable = getentitylessscriptablearray( %"t10_door_wooden_panel_03_painted_right_mp", undefined, var_c9d01d7ab0239b9b.origin, 100 )[ 0 ];
        }
        
        if ( scriptable )
        {
            all_doors[ all_doors.size ] = scriptable;
        }
    }
    
    var_6aecb96a7229dace = getentarray( "rr_3_clip", #targetname );
    
    foreach ( clip in var_6aecb96a7229dace )
    {
        clip hide();
    }
    
    for ( i = 1; i < 4 ; i++ )
    {
        world_event = "we_rr_3_torch_0" + i;
        activateworldevent( world_event );
    }
    
    banners = getentitylessscriptablearray( %"sat_zm_prop_benjamin" );
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( door in all_doors )
    {
        door scriptabledoorfreeze( 1 );
    }
    
    foreach ( banner in banners )
    {
        banner setscriptablepartstate( #"sat_zm_prop_benjamin", #"disabled" );
        spawnscriptable( %"sat_zm_prop_benjamin", banner.origin, banner.angles, undefined, function_67b78af3c33ac9a8( 0.65 ) );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x3572ef54, Offset: 0x254b
// Size: 0xcd
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
    barrel zm_damage::register_scriptable_damage_callback( &function_f4cdb6cb470e289e );
    barrel callback::add( #"hash_11e40a4909e138f7", &function_e6bb5c321ccf3823 );
    barrel.health = 9999;
    barrel.var_af70f02bb9462edd = 1;
    barrel.var_436fc13baa7377d8 = 1;
    barrel.var_18d4007b123c953a = 0;
    level callback::add( "on_round_end", &function_c61ea7af5e720fa4 );
    level callback::add( "on_round_start", &function_e5304b2df8d77d5d );
    utility::flag_wait( #"hash_69f4598d347b7803" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x3a328854, Offset: 0x2620
// Size: 0x120
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    level callback::remove( #"player_spawned", &function_cb6ed8534a92f413 );
    level callback::remove( "on_round_end", &function_c61ea7af5e720fa4 );
    level callback::remove( "on_round_start", &function_e5304b2df8d77d5d );
    barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
    barrel zm_damage::function_c31f9d79d5ceb7ec( &function_f4cdb6cb470e289e );
    barrel callback::remove( #"hash_11e40a4909e138f7", &function_e6bb5c321ccf3823 );
    
    if ( skipped || save_restored )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b5955f59f59f5cad" ) )
        {
            barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
            barrel.var_af70f02bb9462edd = 0;
            barrel setscriptablepartstate( #"base", #"open" );
            barrel notify( #"barrel_damaged" );
            
            if ( barrel.sound_ent )
            {
                barrel.sound_ent delete();
            }
        }
        
        utility::flag_set( #"hash_69f4598d347b7803" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xc50c1ea4, Offset: 0x2748
// Size: 0x92
function private function_5c745d4d6c8aa887()
{
    barrel = getentitylessscriptablearray( %"sat_zm_prop_barrel_02" )[ 0 ];
    
    if ( !barrel )
    {
        return;
    }
    
    barrel.lid_loc = utility::getstruct( "sean_base" );
    barrel.var_d3a8174f0173cd6b = utility::spawn_model( %"sat_zm_sean_02", barrel.lid_loc.origin, barrel.lid_loc.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_b5955f59f59f5cad", barrel );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xd1224e0d, Offset: 0x27e2
// Size: 0xf8
function private function_de5f58d24b50c16()
{
    if ( !zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    if ( utility::flag( #"hash_69f4598d347b7803" ) )
    {
        while ( !level.players || level.players.size == 0 )
        {
            waitframe();
        }
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b5955f59f59f5cad" ) )
        {
            return;
        }
        
        barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
        players = function_b3370116b1b41c74();
        
        foreach ( player in players )
        {
            barrel.var_d3a8174f0173cd6b hidefromplayer( player );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xbbf5ab4c, Offset: 0x28e2
// Size: 0x25b
function private function_f4cdb6cb470e289e( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return 0;
    }
    
    if ( !is_richtofen_operator( params.eattacker ) && !level.ee_richtofen.var_4f4d1954fb08ab )
    {
        self.var_18d4007b123c953a = 1;
        return 0;
    }
    
    if ( zm_round_logic::get_rb_round_number() < level.ee_richtofen.round_num_to_start && !level.ee_richtofen.var_4f4d1954fb08ab )
    {
        self.var_18d4007b123c953a = 1;
        return 0;
    }
    
    if ( level.ee_richtofen.var_842c2510ee81cb27 )
    {
        self.var_18d4007b123c953a = 1;
        return 0;
    }
    
    if ( params.smeansofdeath != "MOD_MELEE" )
    {
        self.var_18d4007b123c953a = 1;
        return 0;
    }
    
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "mq_encounter_starting" ) )
    {
        self notify( #"barrel_damaged" );
        
        if ( self.sound_ent )
        {
            self.sound_ent stopsounds();
        }
        
        level.ee_richtofen.var_842c2510ee81cb27 = 1;
        level.ee_richtofen.var_230e4882e689d987 = 0;
        self.var_18d4007b123c953a = 1;
        return 0;
    }
    
    self.var_18d4007b123c953a = 0;
    
    if ( !params.eattacker perk_m_mod::function_6755e68908f3fde7() )
    {
        self notify( #"barrel_damaged" );
        
        if ( self.sound_ent )
        {
            self.sound_ent stopsounds();
        }
        
        if ( !level.ee_richtofen.dialog.var_47203fc1e763c413.played )
        {
            level.ee_richtofen.dialog.var_47203fc1e763c413.played = 1;
            params.eattacker thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_47203fc1e763c413 );
        }
        
        level.ee_richtofen.var_842c2510ee81cb27 = 1;
        level.ee_richtofen.var_230e4882e689d987 = 0;
        return 0;
    }
    
    return self.health;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x4e0d3cef, Offset: 0x2b46
// Size: 0x217
function private function_e6bb5c321ccf3823( params )
{
    self notify( #"barrel_damaged" );
    
    if ( self.sound_ent )
    {
        self.sound_ent stopsounds();
    }
    
    self setscriptablepartstate( #"base", #"open" );
    playfx( utility::getfx( "richtofen_lid_off" ), self.var_d3a8174f0173cd6b.origin, undefined, anglestoup( self.var_d3a8174f0173cd6b.angles ), params.eattacker );
    
    foreach ( player in level.players )
    {
        if ( is_richtofen_operator( player ) || level.ee_richtofen.var_4f4d1954fb08ab )
        {
            self.var_d3a8174f0173cd6b hidefromplayer( player );
        }
    }
    
    self.var_d3a8174f0173cd6b notsolid();
    
    if ( self.sound_ent )
    {
        params.eattacker playsoundtoplayer( "evt_ee_barrel_lid_open", params.eattacker, self.sound_ent );
        self.sound_ent utility::delaycall( 1, &delete );
    }
    
    medal_loc = utility::getstruct( "rutherford_pickup" );
    params.eattacker thread focus_view( vectortoangles( medal_loc.origin - params.eattacker utility::get_player_camera_origin() ), 0.5, 1 );
    function_60c1cfc5c448f9aa( params.eattacker, 1, 2 );
    function_6facddde2f4fd0f( params.eattacker, undefined, 0, 1, 1 );
    utility::flag_set( #"hash_69f4598d347b7803" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xeecbb0f0, Offset: 0x2d65
// Size: 0xf0
function private function_c61ea7af5e720fa4( params )
{
    if ( params.roundnumber < level.ee_richtofen.round_num_to_start && !level.ee_richtofen.var_4f4d1954fb08ab || utility::flag( "richtofen_on_cooldown" ) )
    {
        return;
    }
    
    if ( zm_round_spawning::is_special_round( params.roundnumber + 1 ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b5955f59f59f5cad" ) )
        {
            barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
            barrel notify( #"barrel_damaged" );
            
            if ( barrel.sound_ent )
            {
                barrel.sound_ent stopsounds();
            }
            
            level.ee_richtofen.var_842c2510ee81cb27 = 1;
            level.ee_richtofen.var_230e4882e689d987 = 0;
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x69e7c1f9, Offset: 0x2e5d
// Size: 0x140
function private function_e5304b2df8d77d5d( params )
{
    if ( params.roundnumber < level.ee_richtofen.round_num_to_start && !level.ee_richtofen.var_4f4d1954fb08ab || level.ee_richtofen.var_230e4882e689d987 || utility::flag( "richtofen_on_cooldown" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread function_cb6ed8534a92f413();
    }
    
    level.ee_richtofen.var_230e4882e689d987 = 1;
    level.ee_richtofen.var_842c2510ee81cb27 = 0;
    
    if ( !level callback::exists( #"player_spawned", &function_cb6ed8534a92f413 ) )
    {
        level callback::add( #"player_spawned", &function_cb6ed8534a92f413 );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0xc
// Checksum 0xf5f216fe, Offset: 0x2fa5
// Size: 0x14f
function private function_cb6ed8534a92f413( params )
{
    self notify( #"hash_a01da66957bc28cf" );
    self endon( #"hash_a01da66957bc28cf" );
    level endon( #"game_ended", #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || !is_richtofen_operator( self ) && !level.ee_richtofen.var_4f4d1954fb08ab )
    {
        return;
    }
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b5955f59f59f5cad" ) )
    {
        return;
    }
    
    barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
    barrel endon( #"barrel_damaged" );
    
    if ( !barrel.sound_ent || !isent( barrel.sound_ent ) )
    {
        barrel.sound_ent = utility::spawn_model( "tag_origin", barrel.origin, barrel.angles );
    }
    
    while ( true )
    {
        barrel.sound_ent playsoundtoplayer( "evt_ee_people_in_the_barrel", self );
        wait 5;
    }
    
    /#
        debug::print3d( barrel, "<dev string:x24>", ( 0.5, 0, 1 ), undefined, "<dev string:x3f>", "<dev string:x52>", 1, 1, 50 );
    #/
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x3cd17b61, Offset: 0x30fc
// Size: 0x212
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( save_restored )
    {
        reset_quest_data( 0 );
        return;
    }
    
    if ( skipped )
    {
        return;
    }
    
    if ( level.ee_richtofen.var_59e94f68452dd416 )
    {
        utility::flag_wait( "richtofen_reset_quest" );
    }
    
    medal_loc = utility::getstruct( "rutherford_pickup" );
    item = utility::spawn_model( %"sat_zm_quest_locust_rutherford_01", medal_loc.origin, medal_loc.angles );
    item hide();
    item.starting_origin = item.origin;
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c472b033024b546a", item );
    
    foreach ( player in level.players )
    {
        if ( is_richtofen_operator( player ) || level.ee_richtofen.var_4f4d1954fb08ab )
        {
            item showtoplayer( player );
            player thread function_a429aaf9409bfd35( level.ee_richtofen.dialog.medal_attract, 8, 15, item );
        }
    }
    
    item thread function_735c865d2ca55c5a();
    var_2c128fd4a914d93 = interaction::register_interact( item.origin + ( 0, 0, 5 ), 60, &function_d26a6867a3afffdd, &function_6e08b6ac54725861 );
    var_2c128fd4a914d93 setusableenabled( 1 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_db7198a1fb071209", var_2c128fd4a914d93 );
    level callback::add( "on_round_end", &function_744b961dcb8e42ab );
    level callback::add( "on_round_start", &function_b96ff131c6d94bc8 );
    utility::flag_wait( #"hash_69f45a8d347b79b6" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x9d7ae91f, Offset: 0x3316
// Size: 0x19
function private function_735c865d2ca55c5a()
{
    waitframe();
    self playsound( "evt_ee_metal_of_valor_spawn" );
    self playloopsound( "evt_ee_metal_of_valor_attract_lp" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xeb057085, Offset: 0x3337
// Size: 0xf4
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped )
    {
        utility::flag_set( #"hash_69f45a8d347b79b6" );
        function_8729a1d989e9b954( level.players[ 0 ] );
        thread function_8191d57a9d90ae17( level.players[ 0 ] );
        level thread function_a91c5f801cc3a1be( level.players[ 0 ], 0 );
        barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
        barrel.var_d3a8174f0173cd6b hidefromplayer( level.players[ 0 ] );
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_c472b033024b546a" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_db7198a1fb071209" );
    level callback::remove( "on_round_end", &function_744b961dcb8e42ab );
    level callback::remove( "on_round_start", &function_b96ff131c6d94bc8 );
    level.ee_richtofen.var_59e94f68452dd416 = 1;
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x5442541c, Offset: 0x3433
// Size: 0x6c
function private function_d26a6867a3afffdd( player )
{
    if ( !is_richtofen_operator( player ) && !level.ee_richtofen.var_4f4d1954fb08ab )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) || utility::flag( "zm_vote_active" ) || utility::flag( "mq_encounter_starting" ) )
    {
        return;
    }
    
    self setusableenabled( 0 );
    thread function_58d2712a43c3c455( player );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0xc
// Checksum 0xe2c34194, Offset: 0x34a7
// Size: 0x252
function private function_58d2712a43c3c455( player )
{
    self notify( #"hash_55155db56eb8924a" );
    self endon( #"hash_55155db56eb8924a" );
    level endon( #"hash_69f45a8d347b79b6" );
    player endon( #"disconnect" );
    
    if ( !isdefined( self.dig_time_remaining ) )
    {
        self.dig_time_remaining = 4;
    }
    
    player setscriptablepartstate( #"locust_echo_sfx", #"medal_digging" );
    self notify( #"digging_started" );
    self.digging = 1;
    
    if ( self.var_ad1ea99fc9bf2e2d )
    {
        rewind_time = ( gettime() - self.var_ad1ea99fc9bf2e2d ) / 1000;
        self.dig_time_remaining = min( self.dig_time_remaining + rewind_time, 4 );
        self.falling = 0;
    }
    
    thread function_1e036659c8ad1dda();
    params = { #var_27fce690e19877a5:1, #hud_description:&"zm_sat_locust/ee_richtofen_digging", #use_object:self, #hold_time:self.dig_time_remaining, #craft_reason:#"hash_b1865f590cd6184f" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    self.digging = 0;
    
    if ( player )
    {
        player setscriptablepartstate( #"locust_echo_sfx", #"off" );
    }
    
    if ( result )
    {
        medal_loc = utility::getstruct( "rutherford_pickup" );
        medal_end_pos = medal_loc.origin + ( 0, 0, 2 );
        medal_item = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
        medal_item moveto( medal_end_pos, 0.1 );
        interaction::set_interact_use_callback( &function_385940719aeb9403 );
        utility::delaycall( 0.1, &setusableenabled, 1 );
        return;
    }
    
    end_time = gettime();
    use_time = ( end_time - self.start_time ) / 1000;
    self.dig_time_remaining = max( self.dig_time_remaining - use_time + 0.1, 0.1 );
    thread function_236e0c23f7d6a127();
    utility::delaycall( 0.35, &setusableenabled, 1 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x2a62eb6e, Offset: 0x3701
// Size: 0x16a
function private function_385940719aeb9403( player )
{
    if ( !is_richtofen_operator( player ) && !level.ee_richtofen.var_4f4d1954fb08ab )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) || utility::flag( "zm_vote_active" ) || utility::flag( "mq_encounter_starting" ) || utility::flag( "rr_3_is_busy" ) )
    {
        return;
    }
    
    self setusableenabled( 0 );
    utility::flag_set( "rr_3_is_busy" );
    level.ee_richtofen.var_59e94f68452dd416 = 1;
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_artifact_3" );
    level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
    medal = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
    
    if ( medal )
    {
        medal stoploopsound();
    }
    
    medal dialogue::stop_dialogue();
    medal utility::delaycall( level.framedurationseconds, &delete );
    function_8729a1d989e9b954( player );
    thread function_8191d57a9d90ae17( player );
    player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_67304a617ee4886a );
    wait 1;
    level thread function_a91c5f801cc3a1be( player );
    utility::delaycall( 0.5, &delete );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0xc
// Checksum 0x57345bb7, Offset: 0x3873
// Size: 0x153
function private function_1e036659c8ad1dda()
{
    self notify( #"hash_f1dc3bb9a579e228" );
    self endon( #"hash_f1dc3bb9a579e228" );
    level endon( #"hash_69f45a8d347b79b6" );
    medal_item = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
    var_4c1cb74fbd599725 = medal_item;
    self.start_time = gettime();
    
    if ( !isdefined( self.move_ticks ) )
    {
        self.move_ticks = 0;
    }
    
    total_ticks_needed = int( 16 );
    barrel_lid = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" ).var_d3a8174f0173cd6b;
    
    while ( self.digging )
    {
        if ( self.move_ticks < total_ticks_needed && var_4c1cb74fbd599725.origin[ 2 ] < var_4c1cb74fbd599725.starting_origin[ 2 ] + 2 )
        {
            self.move_ticks++;
            var_4c1cb74fbd599725 movez( 0.125, 0.25 );
            
            if ( self.move_ticks % 4 == 0 )
            {
                playfx( utility::getfx( "richtofen_dig_medal" ), barrel_lid.origin + ( 0, 0, -2 ), undefined, anglestoright( barrel_lid.angles ) );
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0xc
// Checksum 0x7dcc2980, Offset: 0x39ce
// Size: 0xc0
function private function_236e0c23f7d6a127()
{
    self notify( #"hash_3e44a20e62406339" );
    self endon( #"hash_3e44a20e62406339" );
    level endon( #"hash_69f45a8d347b79b6" );
    self endon( #"digging_started" );
    medal_item = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
    var_4c1cb74fbd599725 = medal_item;
    self.var_ad1ea99fc9bf2e2d = gettime();
    self.falling = 1;
    
    while ( !self.digging && self.falling )
    {
        self.move_ticks--;
        var_4c1cb74fbd599725 movez( -0.125, 0.25 );
        wait 0.25;
        
        if ( self.move_ticks <= 0 )
        {
            break;
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x3796bae9, Offset: 0x3a96
// Size: 0x36
function private function_6e08b6ac54725861( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x9639bc6e, Offset: 0x3ad5
// Size: 0x13b
function private function_8729a1d989e9b954( player )
{
    player val::set( #"ee_richtofen", "fire", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "weapon_switch", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "killstreaks", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "death", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "weapon_pickup", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "overlord_locked_priority", 150 );
    player val::set( #"hash_90e7a906e736a9ba", "supers", 0 );
    player val::set( #"hash_e5a70e25939f301e", "allow_battlechatter_vo", 0 );
    player val::set( #"hash_d952e388d2ee6de", "interactions", 0 );
    
    if ( !level callback::exists( #"player_disconnect", &on_player_disconnect ) )
    {
        level callback::add( #"player_disconnect", &on_player_disconnect );
    }
    
    if ( !level callback::exists( "zm_exfil_started", &function_69d18e825270af2f ) )
    {
        level callback::add( "zm_exfil_started", &function_69d18e825270af2f );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x4ec1a40e, Offset: 0x3c18
// Size: 0x99
function private function_8191d57a9d90ae17( player )
{
    player endon( #"disconnect" );
    destination = utility::function_f1933af772476229( level.robot_ejection_tubes.narrative_rooms );
    
    if ( !destination )
    {
        return;
    }
    
    if ( destination.in_use && destination.player )
    {
        destination notify( #"remove_player" );
        destination notify( #"rej_completed" );
        waitframe();
    }
    
    destination.in_use = 1;
    destination.player = player;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xa836ea28, Offset: 0x3cb9
// Size: 0x35f
function private function_a91c5f801cc3a1be( player, delay = 2 )
{
    level.ee_richtofen endon( #"player_remove" );
    player endon( #"death_or_disconnect" );
    player thread function_da56c29c7485e84();
    player.var_420915a121e1cc41 = 1;
    player.b_ignore_powerups = 1;
    barrel = zm_sat_locust_util::get_quest_reference( #"hash_b5955f59f59f5cad" );
    barrel.var_d3a8174f0173cd6b solid();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( #"richtofen_player", player );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_player", player );
    }
    
    pbgpostfxbundlestart( player, %"cer_zm_topaz_sam_teleport" );
    player playsoundevent( %"hash_542b4e0e7408edf4", player );
    level musicbank_utility::function_5aca66c390aa347d( player, #"hash_7e0d7f3390bf563e" );
    player setscriptablepartstate( #"locust_echo_sfx", #"trans_in" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    player hud_util::fade_out( 0.5, "white" );
    playfx( utility::getfx( "richtofen_teleport_out" ), player.origin );
    pbgpostfxbundleend( player, %"cer_zm_topaz_sam_teleport" );
    player val::set( #"hash_d952e388d2ee6de", "allow_movement", 0 );
    player val::set( #"hash_90e7a906e736a9ba", "show_hud", 0 );
    player function_347b9b0d161d82a8();
    wait 0.5;
    
    while ( true )
    {
        has_weapon = 0;
        weapons = player getweaponslist( "primary" );
        
        foreach ( weapon in weapons )
        {
            if ( weapon.basename == "sat_sm_mammoth_mp" )
            {
                has_weapon = 1;
                break;
            }
        }
        
        if ( has_weapon )
        {
            break;
        }
        
        waitframe();
    }
    
    player zm_sat_locust_rej::prepare_player();
    function_accbd28aba263c0b();
    destination = utility::function_f1933af772476229( level.robot_ejection_tubes.narrative_rooms );
    player zm_sat_locust_rej::function_6b4a863987e3a49( destination.origin, vectortoangles( destination.origin - player.origin ) );
    player zm_sat_locust_rej::function_241d85333be1a0d8( 1 );
    wait 1;
    player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.intro_sequence );
    player zm_sat_locust_rej::function_5e6fbf9ef5db2557( destination.origin, 0, destination.angles, 1 );
    player val::reset( #"narrative_room", "offhand_weapons" );
    player playsoundevent( %"sndevent_teleportation_end_3d" );
    utility::flag_set( "rr_3_teleport_done" );
    utility::flag_set_delayed( #"hash_69f45a8d347b79b6", 1 );
    player val::reset_all( #"hash_d952e388d2ee6de" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xb1e765cf, Offset: 0x4020
// Size: 0x718
function private function_accbd28aba263c0b()
{
    side_doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" );
    
    foreach ( door_pair in side_doors )
    {
        foreach ( door in door_pair )
        {
            door side_door_open();
        }
    }
    
    all_statues = zm_sat_locust_util::get_quest_reference( #"hash_c1cc810120bdd85" );
    
    foreach ( statue in all_statues )
    {
        statue setscriptablepartstate( #"sat_zm_prop_lysander", #"visible_animated" );
        
        if ( statue.script_noteworthy == "4" )
        {
            statue setscriptablepartstate( #"animation", #"raise_sword" );
            
            if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_f558e8cbd2ac98fd" ) )
            {
                zm_sat_locust_util::function_295a36ef38f5acae( #"hash_f558e8cbd2ac98fd", statue );
            }
            
            continue;
        }
        
        if ( statue.script_noteworthy == "5" )
        {
            statue setscriptablepartstate( #"animation", #"raise_sword" );
            
            if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_5c78c243ae975468" ) )
            {
                zm_sat_locust_util::function_295a36ef38f5acae( #"hash_5c78c243ae975468", statue );
            }
        }
    }
    
    all_sections = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" );
    
    foreach ( section in all_sections )
    {
        foreach ( loc in section.sword_blockers )
        {
            loc.sword = utility::spawn_model( %"sat_zm_prop_lysander_02", loc.origin, loc.angles );
        }
        
        section.clip_blocker show();
        section.clip_blocker disconnectpaths();
    }
    
    activateworldevent( "we_rr_3_cr_torch_01_a" );
    activateworldevent( "we_rr_3_cr_torch_01_b" );
    staged_items = zm_sat_locust_util::get_quest_reference( #"hash_67940ffe36651660" );
    
    foreach ( item in staged_items )
    {
        item setscriptablepartstate( item function_84ad2f70189ee7c3(), #"hidden" );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_wallbuy" ) )
    {
        wallbuy = zm_sat_locust_util::get_quest_reference( #"richtofen_wallbuy" );
        wallbuy.default_origin = wallbuy.origin;
        wallbuy.origin += anglestoleft( wallbuy.angles ) * 100;
    }
    
    var_aff160ea473d073e = [];
    var_5053d22452be47b8 = zm_sat_locust_util::get_quest_reference( #"hash_c5da6c6636303fae" );
    
    foreach ( loc in var_5053d22452be47b8 )
    {
        loc.model = utility::spawn_model( loc.piece_model_name, loc.origin, loc.angles, undefined, loc.piece_scale );
        var_aff160ea473d073e[ var_aff160ea473d073e.size ] = loc.model;
        
        foreach ( piece in loc.other_pieces )
        {
            piece.model = utility::spawn_model( loc.piece_model_name, piece.origin, piece.angles, undefined, loc.piece_scale );
            var_aff160ea473d073e[ var_aff160ea473d073e.size ] = piece.model;
        }
    }
    
    radio = zm_sat_locust_util::get_quest_reference( #"richtofen_radio" );
    radio setscriptablepartstate( #"fx", #"static" );
    sword_loc = zm_sat_locust_util::get_quest_reference( #"richtofen_sword" );
    sword_loc.sword = utility::spawn_model( %"sat_zm_prop_lysander_02", sword_loc.origin, sword_loc.angles );
    var_aff160ea473d073e[ var_aff160ea473d073e.size ] = sword_loc.sword;
    complete_statue = zm_sat_locust_util::get_quest_reference( #"hash_bcf7693ffbf95538" );
    complete_statue.sword = utility::spawn_model( %"sat_zm_prop_lysander_02", complete_statue.origin, complete_statue.angles );
    var_aff160ea473d073e[ var_aff160ea473d073e.size ] = complete_statue.sword;
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_9fd1d446daeec84c", var_aff160ea473d073e );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x19a33c9f, Offset: 0x4740
// Size: 0x7e
function private side_door_open( freeze_delay = 0.3 )
{
    self setscriptablepartstate( #"door", hashcat( #"explode_", self.var_be56ef18c58fe922, "_90_no_audio" ) );
    utility::delaycall( freeze_delay, &scriptabledoorfreeze, 1 );
    earthquake( 0.2, 0.5, self.origin, 600 );
    playsoundatpos( self.origin, "evt_ee_door_wood_heavy_open" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xf6221422, Offset: 0x47c6
// Size: 0x83
function private side_door_close( var_b387fd928fd67691 = 1, freeze_delay = 0.3 )
{
    self setscriptablepartstate( #"door", #"closed_quick_no_audio" );
    utility::delaycall( freeze_delay, &scriptabledoorfreeze, 1 );
    earthquake( 0.2, 0.5, self.origin, 600 );
    
    if ( var_b387fd928fd67691 )
    {
        playsoundatpos( self.origin, "evt_ee_door_wood_heavy_close" );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xb02a986e, Offset: 0x4851
// Size: 0xc7
function private function_744b961dcb8e42ab( params )
{
    if ( zm_round_spawning::is_special_round( params.roundnumber + 1 ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c472b033024b546a" ) )
        {
            medal_item = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
            level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
            
            if ( medal_item dialogue::is_speaking() )
            {
                medal_item dialogue::stop_dialogue();
            }
            
            medal_item stoploopsound();
            medal_item hide();
            medal_item.special_round_hidden = 1;
        }
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_db7198a1fb071209" ) )
        {
            var_2c128fd4a914d93 = zm_sat_locust_util::get_quest_reference( #"hash_db7198a1fb071209" );
            var_2c128fd4a914d93 setusableenabled( 0 );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x19c0e2b8, Offset: 0x4920
// Size: 0x162
function private function_b96ff131c6d94bc8( params )
{
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c472b033024b546a" ) && zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" ).special_round_hidden )
    {
        medal_item = zm_sat_locust_util::get_quest_reference( #"hash_c472b033024b546a" );
        
        foreach ( player in level.players )
        {
            if ( is_richtofen_operator( player ) || level.ee_richtofen.var_4f4d1954fb08ab )
            {
                medal_item showtoplayer( player );
                player thread function_a429aaf9409bfd35( level.ee_richtofen.dialog.medal_attract, 8, 15, medal_item );
            }
        }
        
        medal_item thread function_735c865d2ca55c5a();
        medal_item.special_round_hidden = undefined;
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_db7198a1fb071209" ) )
        {
            var_2c128fd4a914d93 = zm_sat_locust_util::get_quest_reference( #"hash_db7198a1fb071209" );
            var_2c128fd4a914d93 setusableenabled( 1 );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x318b654d, Offset: 0x4a8a
// Size: 0x2d
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xaaa4887c, Offset: 0x4abf
// Size: 0x35
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f45b8d347b7b69" );
        
        /#
        #/
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x97455976, Offset: 0x4afc
// Size: 0x55c
function private function_44f005c492157755()
{
    function_fd187eb0a7a0ab56();
    actual_door_left = getent( "rr_3_door_l", #targetname );
    actual_door_left.rotate_ref = utility::getstruct( "door_rotate_ref_left" );
    actual_door_left.clip = getent( "rr_3_clip_l", #targetname );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_85c40662d036ce09", actual_door_left );
    actual_door_right = getent( "rr_3_door_r", #targetname );
    actual_door_right.rotate_ref = utility::getstruct( "door_rotate_ref_right" );
    actual_door_right.clip = getent( "rr_3_clip_r", #targetname );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_2f43681c3d55276a", actual_door_right );
    var_2a3a20e8a395347 = spawnscriptable( %"sat_zm_prop_dixon", ( actual_door_left.origin + actual_door_right.origin ) / 2, actual_door_right.angles + ( 0, 180, 0 ) );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_11265e48ac939248", var_2a3a20e8a395347 );
    side_door_locs = utility::getstructarray( "rr_3_side" );
    side_doors = [ [], [], [], [] ];
    
    foreach ( var_c9d01d7ab0239b9b in side_door_locs )
    {
        scriptable = getentitylessscriptablearray( %"t10_door_wooden_panel_03_painted_left_mp", undefined, var_c9d01d7ab0239b9b.origin, 100 )[ 0 ];
        
        if ( scriptable )
        {
            scriptable.hall_side = var_c9d01d7ab0239b9b.script_noteworthy;
            
            if ( var_c9d01d7ab0239b9b.script_noteworthy == "left" )
            {
                scriptable.var_be56ef18c58fe922 = "right";
            }
            else
            {
                scriptable.var_be56ef18c58fe922 = "left";
            }
            
            scriptable.linked_structs = utility::getstructarray( var_c9d01d7ab0239b9b.target );
            side_doors[ var_c9d01d7ab0239b9b.script_index - 1 ][ side_doors[ var_c9d01d7ab0239b9b.script_index - 1 ].size ] = scriptable;
        }
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_side_doors", side_doors );
    end_door_locs = utility::getstructarray( "rr_3_end" );
    end_doors = [];
    
    foreach ( var_c9d01d7ab0239b9b in end_door_locs )
    {
        scriptable = getentitylessscriptablearray( %"t10_door_wooden_panel_03_painted_left_mp", undefined, var_c9d01d7ab0239b9b.origin, 100 )[ 0 ];
        
        if ( !scriptable )
        {
            scriptable = getentitylessscriptablearray( %"t10_door_wooden_panel_03_painted_right_mp", undefined, var_c9d01d7ab0239b9b.origin, 100 )[ 0 ];
        }
        
        if ( scriptable )
        {
            scriptable.hall_side = var_c9d01d7ab0239b9b.script_noteworthy;
            
            if ( var_c9d01d7ab0239b9b.script_noteworthy == "left" )
            {
                scriptable.var_be56ef18c58fe922 = "right";
            }
            else
            {
                scriptable.var_be56ef18c58fe922 = "left";
            }
            
            scriptable.linked_structs = utility::getstructarray( var_c9d01d7ab0239b9b.target );
            end_doors[ end_doors.size ] = scriptable;
        }
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_cde847cf5595a493", end_doors );
    utility::flag_wait( "wallbuy_ready" );
    
    foreach ( door_pair in side_doors )
    {
        foreach ( door in door_pair )
        {
            door scriptabledoorfreeze( 1 );
        }
    }
    
    foreach ( door in end_doors )
    {
        door scriptabledoorfreeze( 1 );
    }
    
    wallbuy = getentitylessscriptablearray( %"wallbuy_zm_sat_dm_kara" )[ 0 ];
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_wallbuy", wallbuy );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x39d3b4b3, Offset: 0x5060
// Size: 0x445
function private function_fd187eb0a7a0ab56()
{
    all_statues = getentitylessscriptablearray( %"sat_zm_prop_lysander" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c1cc810120bdd85", all_statues );
    var_6aecb96a7229dace = getentarray( "rr_3_clip", #targetname );
    var_37bcc696b05f8ba7 = utility::getstructarray( "rr_3_block" );
    var_570f7bfa8a60c94c = utility::getstructarray( "rr_3_note" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_428498ec210caeb4", var_570f7bfa8a60c94c );
    hallway_sections = [];
    
    for ( i = 1; i < 4 ; i++ )
    {
        world_event = "we_rr_3_torch_0" + i;
        activateworldevent( world_event );
        section = { #world_event:world_event, #prop_blockers:[], #sword_blockers:[], #clip_blocker:{}, #statues:[] };
        
        foreach ( statue in all_statues )
        {
            if ( int( statue.script_noteworthy ) == i )
            {
                section.statues[ section.statues.size ] = statue;
            }
        }
        
        foreach ( clip in var_6aecb96a7229dace )
        {
            if ( int( clip.script_noteworthy ) == i )
            {
                section.clip_blocker = clip;
                clip hide();
            }
        }
        
        foreach ( prop in var_37bcc696b05f8ba7 )
        {
            if ( prop.script_index == i )
            {
                if ( prop.target )
                {
                    prop.var_7f6133414fdf3b14 = utility::getstruct( prop.target );
                    section.sword_blockers[ section.sword_blockers.size ] = prop;
                    continue;
                }
                
                section.prop_blockers[ section.prop_blockers.size ] = prop;
            }
        }
        
        foreach ( note in var_570f7bfa8a60c94c )
        {
            if ( int( note.script_noteworthy ) == i )
            {
                section.note = note;
                
                switch ( i )
                {
                    case 1:
                        section.note.closed_func = &function_74da4d07ad80a00b;
                        break;
                    case 2:
                        section.note.closed_func = &function_4f51c8e0509721ee;
                        break;
                    case 3:
                        section.note.closed_func = &function_fe17838573e6a091;
                        break;
                }
            }
        }
        
        hallway_sections[ hallway_sections.size ] = section;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c23493f42f049840", hallway_sections );
    utility::add_fx( #"richtofen_prop_spawn", "vfx_sat_gameplay_zm_ai_shade_spawning" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xea7ac29, Offset: 0x54ad
// Size: 0x3cf
function private function_f39526366d5e0086( section )
{
    level endon( #"game_ended" );
    level.ee_richtofen endon( #"player_remove" );
    
    foreach ( sword in section.sword_blockers )
    {
        sword.sword moveto( sword.var_7f6133414fdf3b14.origin, 1 );
        sword.sword rotateto( sword.var_7f6133414fdf3b14.angles, 1 );
    }
    
    wait 0.75;
    
    foreach ( prop in section.prop_blockers )
    {
        prop.scriptable = spawnscriptable( prop.script_noteworthy, prop.origin, prop.angles );
        prop.scriptable setscriptablepartstate( #"base", #"closed" );
        
        if ( issubstr( prop.script_noteworthy, "ashwood" ) )
        {
            playfx( utility::getfx( "richtofen_prop_spawn" ), prop.origin + ( -20, 0, 60 ) );
            earthquake( 0.2, 1, prop.origin + ( -20, 0, 60 ), 800 );
        }
    }
    
    section.sword_blockers[ 0 ].sword waittill( #"movedone" );
    
    foreach ( sword in section.sword_blockers )
    {
        sword.sword bobbing( anglestoup( sword.sword.angles ), randomfloatrange( 0.3, 0.7 ), randomfloatrange( 4, 6 ) );
    }
    
    wait 1.5;
    intel = spawnscriptable( hashcat( %"sat_zm_prop_wesley_0", section.note.script_noteworthy ), section.note.origin, section.note.angles );
    intel setscriptablepartstate( #"fx", #"spawn" );
    intel.closed_func = section.note.closed_func;
    intel.hallway_section = section;
    interaction::register_scriptable_interact( intel, &function_7939c396b26a786a, undefined, undefined, &function_8a7cc71cc7185d8a );
    zm_sat_locust_util::function_295a36ef38f5acae( hashcat( #"hash_65a4a21ef448a606", section.note.script_noteworthy ), intel );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x99164de1, Offset: 0x5884
// Size: 0x8c
function private function_7939c396b26a786a( player )
{
    if ( level.ee_richtofen.dialog_playing )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self setscriptablepartstate( self function_84ad2f70189ee7c3(), #"hidden" );
    self setscriptablepartstate( #"fx", #"pick_up" );
    level thread [[ self.closed_func ]]( self.hallway_section, player );
    utility::delaycall( 0.15, &freescriptable );
    player notify( #"rr_3_interact" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xbbd45420, Offset: 0x5918
// Size: 0x36
function private function_8a7cc71cc7185d8a( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x89750034, Offset: 0x5957
// Size: 0x45
function private function_e963d59dc8feaa07( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_dea3f709d0ce58d9();
    utility::flag_wait( #"hash_124ad1ddc7368f9" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x1c305b9f, Offset: 0x59a4
// Size: 0x35
function private function_66f87d6979309cf4( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_124ad1ddc7368f9" );
        
        /#
        #/
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xd1aa4425, Offset: 0x59e1
// Size: 0x30e
function private function_dea3f709d0ce58d9()
{
    level endon( #"game_ended" );
    level.ee_richtofen endon( #"player_remove" );
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    player endon( #"death_or_disconnect" );
    player setdemeanorviewmodel( "safe", "iw9_ges_demeanor_lowready" );
    player val::set( #"hash_23ed4140309e18d4", "move_speed_scale", 0.05 );
    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave" );
    player player_camera_sway_setup();
    player val::reset_all( #"hash_d952e388d2ee6de" );
    wait 1.5;
    side_doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" );
    side_doors = arrayreverse( side_doors );
    
    for ( i = 0; i < side_doors.size ; i++ )
    {
        foreach ( door in side_doors[ i ] )
        {
            door thread side_door_close();
        }
        
        wait 0.25;
    }
    
    wait 1;
    all_sections = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" );
    deactivateworldevent( all_sections[ 1 ].world_event );
    wait 0.25;
    deactivateworldevent( all_sections[ 0 ].world_event );
    wait 0.25;
    thread door_open( 5, 1, 0, 1 );
    door_left = zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" );
    player thread focus_view( vectortoangles( door_left.origin - player utility::get_player_camera_origin() ), 1, 1 );
    function_60c1cfc5c448f9aa( player, 2, 4.5 );
    function_6facddde2f4fd0f( player );
    section = all_sections[ 0 ];
    
    foreach ( statue in section.statues )
    {
        statue setscriptablepartstate( #"animation", #"raise_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    level function_f39526366d5e0086( section );
    player val::set( #"hash_23ed4140309e18d4", "move_speed_scale", 0.6 );
    player thread function_a429aaf9409bfd35( level.ee_richtofen.dialog.var_97b71099dc4b3a14, 3, 7 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0xddff1f89, Offset: 0x5cf7
// Size: 0x199
function private function_74da4d07ad80a00b( hallway_section, player, skipped = 0 )
{
    level endon( #"game_ended", #"zm_game_over" );
    player endon( #"disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    utility::flag_set( "rr_3_doc_1_collected" );
    
    if ( !skipped )
    {
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_8a91047b83917dd );
        wait 1;
    }
    
    foreach ( statue in hallway_section.statues )
    {
        statue setscriptablepartstate( #"animation", #"salute_no_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    if ( !skipped )
    {
        wait 1;
    }
    
    function_b18910f3ba0d94c1( hallway_section );
    hallway_section.clip_blocker hide();
    hallway_section.clip_blocker connectpaths();
    
    if ( !skipped )
    {
        wait 1;
    }
    
    activateworldevent( hallway_section.world_event );
    utility::flag_set( #"hash_124ad1ddc7368f9" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0xbd3bfea3, Offset: 0x5e98
// Size: 0x77
function private function_de6024fb8f0c9336( doors, num_times = 10, var_297c9b32e17dde0c = 0 )
{
    for ( i = 0; i < doors.size ; i++ )
    {
        doors[ i ] thread function_445e830bd0828581( num_times );
        
        if ( var_297c9b32e17dde0c && i == doors.size - 1 )
        {
            doors[ i ] waittill( #"hash_358b5da3b28929e9" );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x32edb954, Offset: 0x5f17
// Size: 0x67
function private function_445e830bd0828581( num_times = 10 )
{
    for ( i = 0; i < num_times ; i++ )
    {
        thread side_door_open();
        wait randomfloatrange( 0.31, 0.4 );
        thread side_door_close();
        wait randomfloatrange( 0.31, 0.4 );
    }
    
    self notify( #"hash_358b5da3b28929e9" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x53ef2c20, Offset: 0x5f86
// Size: 0x187
function private function_b18910f3ba0d94c1( hallway_section )
{
    level endon( #"game_ended" );
    
    foreach ( prop in hallway_section.prop_blockers )
    {
        if ( prop.scriptable )
        {
            prop.scriptable setscriptablepartstate( #"base", #"opening" );
        }
        
        if ( issubstr( prop.script_noteworthy, "ashwood" ) )
        {
            earthquake( 0.2, 1, prop.origin + ( -20, 0, 60 ), 800 );
        }
    }
    
    foreach ( sword in hallway_section.sword_blockers )
    {
        if ( sword.sword )
        {
            sword.sword delete();
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xeb085581, Offset: 0x6115
// Size: 0x10a
function private function_e963d69dc8feac3a( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    section = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 1 ];
    
    foreach ( statue in section.statues )
    {
        statue setscriptablepartstate( #"animation", #"raise_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    level thread function_f39526366d5e0086( section );
    utility::flag_wait( #"hash_124aa1ddc7363e0" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x8539013c, Offset: 0x6227
// Size: 0x35
function private function_66f880697930a38d( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_124aa1ddc7363e0" );
        
        /#
        #/
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0xffb0c3f3, Offset: 0x6264
// Size: 0x209
function private function_4f51c8e0509721ee( hallway_section, player, skipped = 0 )
{
    level endon( #"game_ended", #"zm_game_over" );
    player endon( #"disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    utility::flag_set( "rr_3_doc_2_collected" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c23493f42f049840" ) )
    {
        if ( zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 0 ].note.note )
        {
            note = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 0 ].note.note;
            note freescriptable();
        }
    }
    
    if ( !skipped )
    {
        wait 1;
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_8a90d47b8391144 );
    }
    
    foreach ( statue in hallway_section.statues )
    {
        statue setscriptablepartstate( #"animation", #"salute_no_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    if ( !skipped )
    {
        wait 1;
    }
    
    function_b18910f3ba0d94c1( hallway_section );
    hallway_section.clip_blocker hide();
    hallway_section.clip_blocker connectpaths();
    
    if ( !skipped )
    {
        wait 1;
    }
    
    activateworldevent( hallway_section.world_event );
    utility::flag_set( #"hash_124aa1ddc7363e0" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x9c0f6367, Offset: 0x6475
// Size: 0x10a
function private function_e963d79dc8feae6d( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    section = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 2 ];
    
    foreach ( statue in section.statues )
    {
        statue setscriptablepartstate( #"animation", #"raise_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    level thread function_f39526366d5e0086( section );
    utility::flag_wait( #"hash_124ab1ddc736593" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xf23e37d9, Offset: 0x6587
// Size: 0x35
function private function_66f87f697930a15a( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_124ab1ddc736593" );
        
        /#
        #/
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0x94aff353, Offset: 0x65c4
// Size: 0x20b
function private function_fe17838573e6a091( hallway_section, player, skipped = 0 )
{
    level endon( #"game_ended", #"zm_game_over" );
    player endon( #"disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    utility::flag_set( "rr_3_doc_3_collected" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c23493f42f049840" ) )
    {
        if ( zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 1 ].note.note )
        {
            note = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 1 ].note.note;
            note freescriptable();
        }
    }
    
    if ( !skipped )
    {
        wait 1;
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_8a90e47b8391377 );
    }
    
    foreach ( statue in hallway_section.statues )
    {
        statue setscriptablepartstate( #"animation", #"salute_no_sword" );
        earthquake( 0.1, 0.75, statue.origin, 75 );
    }
    
    if ( !skipped )
    {
        wait 1;
    }
    
    function_b18910f3ba0d94c1( hallway_section );
    hallway_section.clip_blocker hide();
    hallway_section.clip_blocker connectpaths();
    
    if ( !skipped )
    {
        wait 1;
    }
    
    activateworldevent( hallway_section.world_event );
    utility::flag_set( #"hash_124ab1ddc736593" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 4, eflags: 0x4
// Checksum 0x470b0a2a, Offset: 0x67d7
// Size: 0x2b1
function private door_open( var_45186bee171d12fa = 1, into_room = 1, use_accel = 1, first_time = 0 )
{
    door_left = zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" );
    door_right = zm_sat_locust_util::get_quest_reference( #"hash_2f43681c3d55276a" );
    var_2a3a20e8a395347 = zm_sat_locust_util::get_quest_reference( #"hash_11265e48ac939248" );
    open_state = first_time ? #"open_first_time" : #"open";
    var_2a3a20e8a395347 setscriptablepartstate( #"sat_zm_prop_dixon", open_state );
    var_2a3a20e8a395347.opening = 1;
    
    if ( !door_left.ent )
    {
        var_2d93159ec1b06de1 = utility::spawn_model( "tag_origin", door_left.rotate_ref.origin, door_left.rotate_ref.angles );
        door_left linkto( var_2d93159ec1b06de1, "tag_origin" );
        door_left.clip linkto( var_2d93159ec1b06de1, "tag_origin" );
        var_39d14854483e420a = utility::spawn_model( "tag_origin", door_right.rotate_ref.origin, door_right.rotate_ref.angles );
        door_right linkto( var_39d14854483e420a, "tag_origin" );
        door_right.clip linkto( var_39d14854483e420a, "tag_origin" );
        door_left.ent = var_2d93159ec1b06de1;
        door_right.ent = var_39d14854483e420a;
    }
    
    accel_percent = use_accel ? 0.3 : 0;
    accel_time = var_45186bee171d12fa * accel_percent;
    left_open_yaw = into_room ? 90 : -90;
    right_open_yaw = into_room ? -90 : 90;
    door_left.ent rotateyaw( left_open_yaw, var_45186bee171d12fa, accel_time );
    door_right.ent rotateyaw( right_open_yaw, var_45186bee171d12fa, accel_time );
    door_left.ent waittill( #"rotatedone" );
    door_left connectpaths();
    door_left.clip connectpaths();
    door_right connectpaths();
    door_right.clip connectpaths();
    var_2a3a20e8a395347 setscriptablepartstate( #"sat_zm_prop_dixon", #"open_done" );
    var_2a3a20e8a395347.opening = 0;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 4, eflags: 0x4
// Checksum 0x6ffe317a, Offset: 0x6a90
// Size: 0x220
function private door_close( close_time = 0.5, from_room = 1, use_accel = 1, delete_ents = 0 )
{
    door_left = zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" );
    
    if ( !door_left.ent )
    {
        return;
    }
    
    door_right = zm_sat_locust_util::get_quest_reference( #"hash_2f43681c3d55276a" );
    var_2a3a20e8a395347 = zm_sat_locust_util::get_quest_reference( #"hash_11265e48ac939248" );
    var_2a3a20e8a395347 setscriptablepartstate( #"sat_zm_prop_dixon", #"close" );
    
    if ( var_2a3a20e8a395347.opening )
    {
        door_left.ent waittill( #"rotatedone" );
    }
    
    accel_percent = use_accel ? 0.3 : 0;
    accel_time = close_time * accel_percent;
    left_open_yaw = from_room ? -90 : 90;
    right_open_yaw = from_room ? 90 : -90;
    door_left.ent rotateyaw( left_open_yaw, close_time, accel_time );
    door_right.ent rotateyaw( right_open_yaw, close_time, accel_time );
    door_left.ent waittill( #"rotatedone" );
    door_left disconnectpaths();
    door_left.clip disconnectpaths();
    door_right disconnectpaths();
    door_right.clip disconnectpaths();
    
    if ( var_2a3a20e8a395347 )
    {
        var_2a3a20e8a395347 setscriptablepartstate( #"sat_zm_prop_dixon", #"close_done" );
        earthquake( 0.3, 1, var_2a3a20e8a395347.origin, 200 );
    }
    
    if ( delete_ents )
    {
        waitframe();
        
        if ( door_left.ent )
        {
            door_left.ent delete();
        }
        
        if ( door_right.ent )
        {
            door_right.ent delete();
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xfa52f43b, Offset: 0x6cb8
// Size: 0xd4
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    triggers = zm_sat_locust_util::get_quest_reference( #"hash_eba1fbe833a539a1" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerenable();
        trigger::makeenterexittrigger( trigger, &function_5ec41be097fb963b );
    }
    
    utility::flag_wait( #"hash_69f45c8d347b7d1c" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x568794b, Offset: 0x6d94
// Size: 0xbb
function private function_60062848e78b83d5( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f45c8d347b7d1c" );
    }
    
    triggers = zm_sat_locust_util::get_quest_reference( #"hash_eba1fbe833a539a1" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerdisable();
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x3ee37944, Offset: 0x6e57
// Size: 0x12e
function private function_5431bd441190b0()
{
    triggers = getnoentvolumearray( "rr_3_trigger", #targetname );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_eba1fbe833a539a1", triggers );
    world_events = [ 7:{ #event_name:"we_rr_3_cr_torch_04_b", #on:0 }, 6:{ #event_name:"we_rr_3_cr_torch_04_a", #on:0 }, 5:{ #event_name:"we_rr_3_cr_torch_03_b", #on:0 }, 4:{ #event_name:"we_rr_3_cr_torch_03_a", #on:0 }, 3:{ #event_name:"we_rr_3_cr_torch_02_b", #on:0 }, 2:{ #event_name:"we_rr_3_cr_torch_02_a", #on:0 }, 1:{ #event_name:"we_rr_3_cr_torch_01_b", #on:0 }, 0:{ #event_name:"we_rr_3_cr_torch_01_a", #on:0 } ];
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_2a56ddea91d7853f", world_events );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xc406f0b0, Offset: 0x6f8d
// Size: 0x1e1
function private function_5ec41be097fb963b( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c23493f42f049840" ) )
        {
            if ( zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 2 ].note.note )
            {
                note = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" )[ 2 ].note.note;
                note freescriptable();
            }
        }
        
        thread door_close();
        triggers = zm_sat_locust_util::get_quest_reference( #"hash_eba1fbe833a539a1" );
        
        foreach ( trigger in triggers )
        {
            trigger triggerdisable();
        }
        
        level musicbank_utility::function_5aca66c390aa347d( ent, #"hash_7e0d7e3390bf548b" );
        ent notify( #"rr_3_interact" );
        utility::flag_set( #"hash_69f45c8d347b7d1c" );
        world_events = zm_sat_locust_util::get_quest_reference( #"hash_2a56ddea91d7853f" );
        
        for ( i = 2; i < world_events.size ; i++ )
        {
            event = world_events[ i ];
            activateworldevent( event.event_name );
            event.on = 1;
            
            if ( i % 2 != 0 )
            {
                wait 0.5;
            }
        }
        
        ent thread function_a429aaf9409bfd35( level.ee_richtofen.dialog.var_97b71399dc4b40ad, 3, 7 );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xcc6a4ba3, Offset: 0x7176
// Size: 0x81
function private function_7d6d653ab952c93d( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) )
    {
        player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
        playfxontagforclients( utility::getfx( "richtofen_camera" ), player, "j_head", player );
        player.richtofen_camera_fx = 1;
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x43c728dc, Offset: 0x71ff
// Size: 0x32
function private function_60062748e78b81a2( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f45d8d347b7ecf" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xd575ec30, Offset: 0x7239
// Size: 0xec
function private function_b127195ef7ad5ed6()
{
    interact_locs = utility::getstructarray( "rr_3_intr" );
    
    foreach ( loc in interact_locs )
    {
        if ( loc.script_noteworthy )
        {
            switch ( loc.script_noteworthy )
            {
                case #"hash_31100fbc01bd387c":
                    level thread function_9c7dbacf01b43877( loc );
                    break;
                case #"hash_311012bc01bd3d35":
                    level thread function_916f5f0940e34b29( loc );
                    break;
                case #"hash_311011bc01bd3ba2":
                    level thread function_eff952283339ba2( loc );
                    break;
            }
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xe5b81e87, Offset: 0x732d
// Size: 0x1cc
function private function_3fd49f9e08230205( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level.ee_richtofen.var_1776a6afcae3aee4 = 0;
    level.ee_richtofen.var_dc31f8170bb28e0b = 0;
    level.ee_richtofen.scene_cleaned_up = 0;
    level.ee_richtofen.var_81e9a50c7c19b4b8 = 0;
    side_locs = zm_sat_locust_util::get_quest_reference( #"hash_c5da6c6636303fae" );
    
    foreach ( loc in side_locs )
    {
        loc.var_2c128fd4a914d93 = interaction::register_interact( loc.origin, 50, &function_522e3ea1c12bdd62 );
        loc.var_2c128fd4a914d93.loc = loc;
        
        foreach ( piece in loc.other_pieces )
        {
            piece.placed = 0;
        }
    }
    
    utility::flag_wait( #"hash_124f1b1de6212d23" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x22ef62c4, Offset: 0x7501
// Size: 0x32
function private function_c0b54769bbf47a32( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_124f1b1de6212d23" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x311673b4, Offset: 0x753b
// Size: 0x2a0
function private function_9c7dbacf01b43877( scale_loc )
{
    scale = getentitylessscriptablearray( %"sat_zm_prop_alvis" )[ 0 ];
    
    if ( !scale )
    {
        scale = spawnscriptable( %"sat_zm_prop_alvis", scale_loc.origin, scale_loc.angles );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_scale", scale );
    side_locs = utility::getstructarray( scale_loc.target );
    
    foreach ( loc in side_locs )
    {
        loc.piece_model_name = loc.script_noteworthy == "left" ? %"t10_decor_chess_antique_set_01_bishop_black" : %"vfx_mgl_crystal_tempest_shard_02_blue";
        loc.piece_scale = loc.script_noteworthy == "left" ? 1 : 5;
        loc.other_pieces = [];
        other_pieces = utility::getstructarray( loc.target );
        
        foreach ( piece in other_pieces )
        {
            if ( piece.target )
            {
                piece.placed_loc = utility::getstruct( piece.target );
                loc.other_pieces[ loc.other_pieces.size ] = piece;
                continue;
            }
            
            loc.placed_loc = piece;
        }
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c5da6c6636303fae", side_locs );
    shadow_figure = utility::getstruct( "rr_3_figure" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_b59cdb33fe4c255", shadow_figure );
    utility::add_fx( #"hash_19fab2951ef8c573", "vfx_sat_levels_zm_locust_von_ghost_idle" );
    utility::add_fx( #"hash_570d8eb1b197a74d", "vfx_sat_levels_zm_locust_von_ghost_idle_foot" );
    utility::add_fx( #"hash_56a75eb1b140a28b", "vfx_sat_levels_zm_locust_von_ghost_idle_foot" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xb14d2a28, Offset: 0x77e3
// Size: 0x82b
function private function_522e3ea1c12bdd62( player )
{
    if ( level.ee_richtofen.dialog_playing )
    {
        return;
    }
    
    scale = zm_sat_locust_util::get_quest_reference( #"richtofen_scale" );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    player notify( #"rr_3_interact" );
    side_locs = zm_sat_locust_util::get_quest_reference( #"hash_c5da6c6636303fae" );
    
    foreach ( loc in side_locs )
    {
        if ( loc.var_2c128fd4a914d93 )
        {
            loc.var_2c128fd4a914d93 makeunusable();
        }
    }
    
    room_ents = zm_sat_locust_util::get_quest_reference( #"hash_9fd1d446daeec84c" );
    
    if ( self.loc.script_noteworthy == "left" )
    {
        level.ee_richtofen.var_1776a6afcae3aee4++;
        
        if ( level.ee_richtofen.var_1776a6afcae3aee4 != 3 )
        {
            if ( level.ee_richtofen.var_1776a6afcae3aee4 == 1 )
            {
                player thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_22bad38635ffeff8 );
            }
            
            foreach ( loc in side_locs )
            {
                loc.var_2c128fd4a914d93 utility::delaycall( 2, &makeusable );
            }
            
            foreach ( piece in self.loc.other_pieces )
            {
                if ( !piece.placed )
                {
                    piece.placed = 1;
                    
                    if ( piece.model )
                    {
                        room_ents = arrayremove( room_ents, piece.model );
                        piece.model delete();
                    }
                    
                    break;
                }
            }
        }
        else
        {
            self.loc.model delete();
            room_ents[ room_ents.size ] = self.loc.model;
            
            foreach ( loc in side_locs )
            {
                if ( loc.var_2c128fd4a914d93 && loc.var_2c128fd4a914d93 != self )
                {
                    loc.var_2c128fd4a914d93 utility::delaycall( 2, &makeusable );
                }
            }
            
            self delete();
        }
        
        scale setscriptablepartstate( #"figurines", hashcat( #"show_", level.ee_richtofen.var_1776a6afcae3aee4 ) );
    }
    else
    {
        level.ee_richtofen.var_dc31f8170bb28e0b++;
        
        if ( level.ee_richtofen.var_dc31f8170bb28e0b != 3 )
        {
            if ( level.ee_richtofen.var_dc31f8170bb28e0b == 1 )
            {
                player thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_aadf07e31a3f72a0 );
            }
            
            foreach ( loc in side_locs )
            {
                loc.var_2c128fd4a914d93 utility::delaycall( 2, &makeusable );
            }
            
            foreach ( piece in self.loc.other_pieces )
            {
                if ( !piece.placed )
                {
                    piece.placed = 1;
                    
                    if ( piece.model )
                    {
                        room_ents = arrayremove( room_ents, piece.model );
                        piece.model delete();
                    }
                    
                    break;
                }
            }
        }
        else
        {
            self.loc.model delete();
            room_ents[ room_ents.size ] = self.loc.model;
            
            foreach ( loc in side_locs )
            {
                if ( loc.var_2c128fd4a914d93 && loc.var_2c128fd4a914d93 != self )
                {
                    loc.var_2c128fd4a914d93 utility::delaycall( 2, &makeusable );
                }
            }
            
            self delete();
        }
        
        scale setscriptablepartstate( #"hash_79c30145a71da1ce", hashcat( #"show_", level.ee_richtofen.var_dc31f8170bb28e0b ) );
    }
    
    current_state = scale getscriptablepartstate( #"animation" );
    
    if ( level.ee_richtofen.var_1776a6afcae3aee4 == level.ee_richtofen.var_dc31f8170bb28e0b )
    {
        if ( current_state == "right" || current_state == "right_rest" )
        {
            scale setscriptablepartstate( #"animation", #"right_return" );
        }
        else if ( current_state == "left" || current_state == "left_rest" )
        {
            scale setscriptablepartstate( #"animation", #"left_return" );
        }
    }
    else if ( level.ee_richtofen.var_1776a6afcae3aee4 > level.ee_richtofen.var_dc31f8170bb28e0b )
    {
        if ( current_state == "idle" || current_state == "right_return" || current_state == "left_return" )
        {
            scale setscriptablepartstate( #"animation", #"left" );
        }
    }
    else if ( level.ee_richtofen.var_1776a6afcae3aee4 < level.ee_richtofen.var_dc31f8170bb28e0b )
    {
        if ( current_state == "idle" || current_state == "left_return" || current_state == "right_return" )
        {
            scale setscriptablepartstate( #"animation", #"right" );
        }
    }
    
    if ( level.ee_richtofen.var_1776a6afcae3aee4 == 3 && level.ee_richtofen.var_dc31f8170bb28e0b == 3 )
    {
        level thread function_a1c12a5f67ef7e34( player );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xf8b677e2, Offset: 0x8016
// Size: 0x247
function private function_a1c12a5f67ef7e34( player )
{
    wait 1;
    level.ee_richtofen.dialog_playing = 1;
    function_f8c0e2b699fab9be();
    var_7b40c24d75314d42 = zm_sat_locust_util::get_quest_reference( #"hash_b59cdb33fe4c255" );
    var_7b40c24d75314d42.model = utility::spawn_model( %"xcomposite_sat_zmb_npc_von_list", var_7b40c24d75314d42.origin, var_7b40c24d75314d42.angles );
    var_2bb3c93124521d70 = [ "sitting_01", "idle_01" ];
    scene::add_scene_func( var_7b40c24d75314d42, &play_scene_dialog, "idle_01" );
    var_7b40c24d75314d42 thread scene::play( var_7b40c24d75314d42.model, var_2bb3c93124521d70 );
    playfxontag( utility::getfx( #"hash_19fab2951ef8c573" ), var_7b40c24d75314d42.model, "j_spineupper" );
    playfxontag( utility::getfx( #"hash_570d8eb1b197a74d" ), var_7b40c24d75314d42.model, "j_ankle_le" );
    playfxontag( utility::getfx( #"hash_56a75eb1b140a28b" ), var_7b40c24d75314d42.model, "j_ankle_ri" );
    player thread focus_view( vectortoangles( var_7b40c24d75314d42.origin + ( 0, 0, 30 ) - player utility::get_player_camera_origin() ), 0.5, 1 );
    function_60c1cfc5c448f9aa( player, 1, 1.5 );
    function_6facddde2f4fd0f( player );
    level.ee_richtofen waittill( #"scene_dialog" );
    level.ee_richtofen.dialog_playing = 1;
    function_f8c0e2b699fab9be();
    var_2bb3c93124521d70 = [ "sitting_02", "idle_02" ];
    scene::add_scene_func( var_7b40c24d75314d42, &play_scene_dialog, "idle_02" );
    var_7b40c24d75314d42 thread scene::play( var_7b40c24d75314d42.model, var_2bb3c93124521d70 );
    level.ee_richtofen waittill( #"scene_dialog" );
    level.ee_richtofen.dialog_playing = 1;
    function_f8c0e2b699fab9be();
    scene::add_scene_func( var_7b40c24d75314d42, &scene_cleanup, "callback_done" );
    var_7b40c24d75314d42 thread scene::play( var_7b40c24d75314d42.model, "sitting_03" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x81dfe8e9, Offset: 0x8265
// Size: 0xb3
function private play_scene_dialog()
{
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    
    if ( !level.ee_richtofen.var_81e9a50c7c19b4b8 )
    {
        level.ee_richtofen.var_81e9a50c7c19b4b8 = 1;
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_b5653ee9af45d19a[ 1 ] );
    }
    else
    {
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_b5653ee9af45d19a[ 3 ] );
    }
    
    level.ee_richtofen notify( #"scene_dialog" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x1bb6fbbf, Offset: 0x8320
// Size: 0x171
function private scene_cleanup()
{
    if ( level.ee_richtofen.scene_cleaned_up )
    {
        return;
    }
    
    level.ee_richtofen.scene_cleaned_up = 1;
    level utility::flag_set( "rr_scene_complete" );
    var_7b40c24d75314d42 = zm_sat_locust_util::get_quest_reference( #"hash_b59cdb33fe4c255" );
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    
    if ( var_7b40c24d75314d42.model )
    {
        stopfxontag( utility::getfx( #"hash_19fab2951ef8c573" ), var_7b40c24d75314d42.model, "j_spineupper" );
        stopfxontag( utility::getfx( #"hash_570d8eb1b197a74d" ), var_7b40c24d75314d42.model, "j_ankle_le" );
        stopfxontag( utility::getfx( #"hash_56a75eb1b140a28b" ), var_7b40c24d75314d42.model, "j_ankle_ri" );
        var_7b40c24d75314d42.model utility::delaycall( 0.5, &delete );
    }
    
    dialog = [ level.ee_richtofen.dialog.var_b5653ee9af45d19a[ 5 ], level.ee_richtofen.dialog.var_b5653ee9af45d19a[ 6 ] ];
    player function_5ca0e2e5f6c2bd68( dialog );
    utility::flag_set( #"hash_124f1b1de6212d23" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x47b0dba7, Offset: 0x8499
// Size: 0x95
function private function_3fd49c9e0822fb6c( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    radio = zm_sat_locust_util::get_quest_reference( #"richtofen_radio" );
    
    if ( !radio.var_d8e3b07237845727 )
    {
        interaction::register_scriptable_interact( radio, &function_b87f432fc4ce37fe, undefined, undefined, &function_2a63c8ec9671be26 );
    }
    
    radio setscriptablepartstate( #"usable", #"on" );
    utility::flag_wait( #"hash_124f1c1de6212ed6" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x2f50d3a3, Offset: 0x8536
// Size: 0x66
function private function_c0b54669bbf477ff( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_124f1c1de6212ed6" );
    }
    
    radio = zm_sat_locust_util::get_quest_reference( #"richtofen_radio" );
    radio setscriptablepartstate( #"usable", #"off" );
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x785a35a8, Offset: 0x85a4
// Size: 0x4d
function private function_916f5f0940e34b29( radio_loc )
{
    radio = spawnscriptable( %"sat_zm_prop_otto", radio_loc.origin, radio_loc.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_radio", radio );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x5b3ba2d, Offset: 0x85f9
// Size: 0x202
function private function_b87f432fc4ce37fe( player )
{
    if ( level.ee_richtofen.dialog_playing )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self setscriptablepartstate( #"usable", #"off" );
    
    if ( !utility::flag( #"hash_124f1c1de6212ed6" ) )
    {
        player notify( #"rr_3_interact" );
        self setscriptablepartstate( #"fx", #"static_off" );
        thread function_386554586a3ab9e5( player );
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_d19dad2c7617ec0b, self );
        self setscriptablepartstate( #"fx", #"static" );
        player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_4d1a77577e7fbfd7 );
        self setscriptablepartstate( #"fire_fx", #"off" );
        utility::flag_set( #"hash_124f1c1de6212ed6" );
        utility::delaycall( 5, &setscriptablepartstate, #"usable", #"on" );
        return;
    }
    
    player val::set( #"hash_61ab6a8c8a2761b4", "ignoreme", 1 );
    player val::set( #"hash_61ab6a8c8a2761b4", "show_hud", 0 );
    player val::set( #"hash_61ab6a8c8a2761b4", "freezecontrols", 1 );
    player val::set( #"hash_61ab6a8c8a2761b4", "supers", 0 );
    player notifyonplayercommand( "lock_combo", "+movedown" );
    player notifyonplayercommand( "lock_combo", "+stance" );
    player notifyonplayercommand( "rotate_left", "+smoke" );
    player notifyonplayercommand( "rotate_left_done", "-smoke" );
    player notifyonplayercommand( "rotate_right", "+frag" );
    player notifyonplayercommand( "rotate_right_done", "-frag" );
    thread function_64bb1ec08f372fdb( player );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x3bec3d8b, Offset: 0x8803
// Size: 0x36
function private function_2a63c8ec9671be26( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x472059c9, Offset: 0x8842
// Size: 0x88
function private function_386554586a3ab9e5( player )
{
    level endon( #"game_ended", #"zm_game_over", #"hash_124f1c1de6212ed6" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"hash_8f9c22cfdab164c3", dialog_data );
        
        if ( dialog_data.var_cdc21a4905c4928d == "dx_zm_lors_lpsd_nyrp_rssdtblrdo1intln4" )
        {
            self setscriptablepartstate( #"fire_fx", #"fire" );
            break;
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0xc
// Checksum 0x80584faf, Offset: 0x88d2
// Size: 0x316
function private function_64bb1ec08f372fdb( player )
{
    self notify( #"hash_98e3b4d58b37856b" );
    self endon( #"hash_98e3b4d58b37856b" );
    level endon( #"game_ended" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( level.ee_richtofen.var_711560c12ac2718 ) )
    {
        level.ee_richtofen.var_711560c12ac2718 = 0;
    }
    
    if ( !isdefined( level.ee_richtofen.var_d6d073718d15c783 ) )
    {
        level.ee_richtofen.var_d6d073718d15c783 = 0;
    }
    
    if ( !isdefined( level.ee_richtofen.var_a4fd26a6c50a2ffe ) )
    {
        level.ee_richtofen.var_a4fd26a6c50a2ffe = 0;
    }
    
    if ( !isdefined( level.ee_richtofen.var_ffe96afa3dff5965 ) )
    {
        level.ee_richtofen.var_ffe96afa3dff5965 = 0;
    }
    
    if ( level.ee_richtofen.var_d6d073718d15c783 == 0 )
    {
        code = 10105;
        player setclientomnvar( "ui_safe_combination", code );
    }
    
    if ( level.ee_richtofen.var_a4fd26a6c50a2ffe == 0 )
    {
        code = 90305;
        player setclientomnvar( "ui_safe_combination_2", code );
    }
    
    if ( level.ee_richtofen.var_ffe96afa3dff5965 == 0 )
    {
        code = 70004;
        player setclientomnvar( "ui_safe_combination_3", code );
    }
    
    while ( true )
    {
        player waittill( #"luinotifyserver", message, value );
        
        if ( message == "ui_safe_combination_input" )
        {
            if ( value == 0 )
            {
                thread function_cf322f29678e74a7( player, 1, 0 );
                level.ee_richtofen.var_d6d073718d15c783 = 1;
                player setclientomnvar( "ui_safe_combination", -1 );
                
                /#
                    self notify( #"hash_5275bd9ac9ea5c7f" );
                #/
            }
            else if ( value == 3 )
            {
                thread function_cf322f29678e74a7( player, 1, 1 );
                level.ee_richtofen.var_a4fd26a6c50a2ffe = 1;
                player setclientomnvar( "ui_safe_combination_2", -1 );
                
                /#
                    self notify( #"hash_5275bd9ac9ea5c7f" );
                #/
            }
            else if ( value == 4 )
            {
                thread function_cf322f29678e74a7( player, 1, 2 );
                level.ee_richtofen.var_ffe96afa3dff5965 = 1;
                player setclientomnvar( "ui_safe_combination_3", -1 );
                
                /#
                    self notify( #"hash_5275bd9ac9ea5c7f" );
                #/
            }
            else if ( value == 1 )
            {
                self setscriptablepartstate( #"fx", #"static" );
                thread function_cf322f29678e74a7( player );
                
                /#
                    self notify( #"hash_5275bd9ac9ea5c7f" );
                    debug::print3d( self, "<dev string:x61>", ( 0.5, 0, 1 ), undefined, "<dev string:x3f>", "<dev string:x6e>", 1, 0.4, 10 );
                #/
            }
            else if ( value == 2 )
            {
                thread function_cf322f29678e74a7( player );
            }
            
            break;
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0x27579a02, Offset: 0x8bf0
// Size: 0x1e5
function private function_cf322f29678e74a7( player, complete, dialog )
{
    function_899dac17bef9614a( player );
    
    if ( complete )
    {
        player notify( #"rr_3_interact" );
        self setscriptablepartstate( #"fx", #"static_off" );
        
        switch ( dialog )
        {
            case 0:
                dialog_data = level.ee_richtofen.dialog.var_e6256a914b54ce91;
                break;
            case 1:
                dialog_data = level.ee_richtofen.dialog.var_72958e90f6ce179f;
                break;
            case 2:
                dialog_data = level.ee_richtofen.dialog.var_3dc551918bc60a49;
                break;
        }
        
        player function_5ca0e2e5f6c2bd68( dialog_data, self );
        
        switch ( dialog )
        {
            case 0:
                level utility::flag_set( "115_collected" );
                break;
            case 1:
                level utility::flag_set( "935_collected" );
                break;
            case 2:
                level utility::flag_set( "704_collected" );
                break;
            default:
                break;
        }
        
        level.ee_richtofen.var_711560c12ac2718++;
        
        if ( level.ee_richtofen.var_711560c12ac2718 < 3 )
        {
            self setscriptablepartstate( #"usable", #"on" );
        }
    }
    else
    {
        utility::delaycall( 2, &setscriptablepartstate, #"usable", #"on" );
    }
    
    self setscriptablepartstate( #"fx", #"static" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xccf85358, Offset: 0x8ddd
// Size: 0xae
function private function_899dac17bef9614a( player )
{
    player setclientomnvar( "ui_safe_combination", -1 );
    player setclientomnvar( "ui_safe_combination_2", -1 );
    player setclientomnvar( "ui_safe_combination_3", -1 );
    player val::reset_all( #"hash_61ab6a8c8a2761b4" );
    player notifyonplayercommandremove( "lock_combo", "+movedown" );
    player notifyonplayercommandremove( "lock_combo", "+stance" );
    player notifyonplayercommandremove( "rotate_left", "+smoke" );
    player notifyonplayercommandremove( "rotate_left_done", "-smoke" );
    player notifyonplayercommandremove( "rotate_right", "+frag" );
    player notifyonplayercommandremove( "rotate_right_done", "-frag" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xefba242b, Offset: 0x8e93
// Size: 0x101
function private function_3fd49d9e0822fd9f( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    statue = zm_sat_locust_util::get_quest_reference( #"hash_f558e8cbd2ac98fd" );
    
    if ( !statue.var_d8e3b07237845727 )
    {
        interaction::register_scriptable_interact( statue, &function_68f621d5877c74d0, undefined, undefined, &function_89ff9392d9e45858 );
    }
    
    statue setscriptablepartstate( #"usable", #"on" );
    sword_loc = zm_sat_locust_util::get_quest_reference( #"richtofen_sword" );
    
    if ( !sword_loc.var_d8e3b07237845727 )
    {
        interaction::register_scriptable_interact( sword_loc.sword getlinkedscriptableinstance(), &function_bcdf75e727489b6b, undefined, undefined, &function_b1b5fd45c50f4bc7 );
    }
    
    sword_loc.sword setscriptablepartstate( #"usable", #"on" );
    utility::flag_wait( #"hash_124f1d1de6213089" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x85d9e199, Offset: 0x8f9c
// Size: 0x177
function private function_c0b54569bbf475cc( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_f558e8cbd2ac98fd" ) )
        {
            statue = zm_sat_locust_util::get_quest_reference( #"hash_f558e8cbd2ac98fd" );
            statue setscriptablepartstate( #"usable", #"off" );
        }
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_sword" ) )
        {
            sword = zm_sat_locust_util::get_quest_reference( #"richtofen_sword" );
            
            if ( sword.sword )
            {
                sword.sword delete();
            }
        }
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_5857e4d69cbf7ebf" ) && !zm_sat_locust_util::get_quest_reference( #"hash_5857e4d69cbf7ebf" ).sword )
        {
            incomplete_statue = zm_sat_locust_util::get_quest_reference( #"hash_5857e4d69cbf7ebf" );
            incomplete_statue.sword = utility::spawn_model( %"sat_zm_prop_lysander_02", incomplete_statue.origin, incomplete_statue.angles );
            
            if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_9fd1d446daeec84c" ) )
            {
                var_aff160ea473d073e = zm_sat_locust_util::get_quest_reference( #"hash_9fd1d446daeec84c" );
                var_aff160ea473d073e[ var_aff160ea473d073e.size ] = incomplete_statue.sword;
            }
        }
        
        utility::flag_set( #"hash_124f1d1de6213089" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x718a071, Offset: 0x911b
// Size: 0x7f
function private function_eff952283339ba2( sword_loc )
{
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_sword", sword_loc );
    complete_statue_loc = utility::getstruct( "rr_3_swr_complete" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_bcf7693ffbf95538", complete_statue_loc );
    incomplete_statue_loc = utility::getstruct( "rr_3_swr_incomplete" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_5857e4d69cbf7ebf", incomplete_statue_loc );
    utility::add_fx( "blood_moon_jumpscare", "vfx_sat_levels_zm_locust_ee_jump_scare" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x9030b6ec, Offset: 0x91a2
// Size: 0x122
function private function_68f621d5877c74d0( player )
{
    if ( level.ee_richtofen.dialog_playing || !level.ee_richtofen.has_sword )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    player notify( #"rr_3_interact" );
    self setscriptablepartstate( #"usable", #"off" );
    self setscriptablepartstate( #"sword", #"show" );
    incomplete_statue = zm_sat_locust_util::get_quest_reference( #"hash_5857e4d69cbf7ebf" );
    incomplete_statue.sword = utility::spawn_model( %"sat_zm_prop_lysander_02", incomplete_statue.origin, incomplete_statue.angles );
    incomplete_statue.sword setscriptablepartstate( #"fx", #"place" );
    var_aff160ea473d073e = zm_sat_locust_util::get_quest_reference( #"hash_9fd1d446daeec84c" );
    var_aff160ea473d073e[ var_aff160ea473d073e.size ] = incomplete_statue.sword;
    thread function_3b5b149734a01803( player );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x60d4f86a, Offset: 0x92cc
// Size: 0x36
function private function_89ff9392d9e45858( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xba1d2cf, Offset: 0x930b
// Size: 0xb2
function private function_bcdf75e727489b6b( player )
{
    if ( level.ee_richtofen.dialog_playing )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    player notify( #"rr_3_interact" );
    level.ee_richtofen.has_sword = 1;
    self setscriptablepartstate( #"fx", #"pick_up" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_sword" ) )
    {
        sword_loc = zm_sat_locust_util::get_quest_reference( #"richtofen_sword" );
        sword_loc.sword utility::delaycall( level.framedurationseconds, &delete );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xe07b9207, Offset: 0x93c5
// Size: 0x36
function private function_b1b5fd45c50f4bc7( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x6f2a09e5, Offset: 0x9404
// Size: 0xb6
function private function_3b5b149734a01803( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait 0.2;
    statue_dialog = { #origin:self.origin + ( 0, 0, 65 ) };
    player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_585b4cc83ed3f398, statue_dialog );
    player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_a55d54b8675c37b8 );
    utility::flag_set( #"hash_124f1d1de6213089" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x1aea1356, Offset: 0x94c2
// Size: 0x172
function private function_7d6d623ab952c2a4( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    wait 2;
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
    player function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.post_all_interacts );
    wait 2;
    var_c9d01d7ab0239b9b = zm_sat_locust_util::get_quest_reference( #"richtofen_door_interact" );
    var_2c128fd4a914d93 = interaction::register_interact( var_c9d01d7ab0239b9b.origin, 40, &function_f970cab432569a79 );
    
    /#
        debug::print3d( var_2c128fd4a914d93, "<dev string:x7f>", ( 0.5, 0, 1 ), undefined, "<dev string:x3f>", "<dev string:x8d>", 1, 1, 50 );
    #/
    
    var_2a3a20e8a395347 = zm_sat_locust_util::get_quest_reference( #"hash_11265e48ac939248" );
    var_2a3a20e8a395347 setscriptablepartstate( #"sat_zm_prop_dixon", #"commotion" );
    player thread focus_view( vectortoangles( var_2c128fd4a914d93.origin - player utility::get_player_camera_origin() ), 0.5, 1 );
    function_60c1cfc5c448f9aa( player, 1, 2 );
    function_6facddde2f4fd0f( player );
    utility::flag_wait( #"hash_69f45e8d347b8082" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xdace872b, Offset: 0x963c
// Size: 0x32
function private function_60062648e78b7f6f( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f45e8d347b8082" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x33e15a94, Offset: 0x9676
// Size: 0x48
function private function_9fc82136c9f72ab2()
{
    var_c9d01d7ab0239b9b = utility::getstruct( "rr_3_door_intr" );
    var_c9d01d7ab0239b9b.zmb_spawns = utility::getstructarray( var_c9d01d7ab0239b9b.target );
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_door_interact", var_c9d01d7ab0239b9b );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x46b14efb, Offset: 0x96c6
// Size: 0x149
function private function_5acd195deeabc6d2()
{
    level endon( #"game_ended", #"command_door_opened", #"hash_69f45e8d347b8082" );
    level.ee_richtofen endon( #"player_remove" );
    world_events = zm_sat_locust_util::get_quest_reference( #"hash_2a56ddea91d7853f" );
    
    foreach ( event in world_events )
    {
        deactivateworldevent( event.event_name );
        event.on = 0;
    }
    
    wait 1.5;
    world_events = arrayrandomize( world_events );
    
    foreach ( event in world_events )
    {
        event thread function_803aacd5ef568b6();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xe5bff084, Offset: 0x9817
// Size: 0x95
function private function_803aacd5ef568b6()
{
    level endon( #"game_ended", #"command_door_opened", #"hash_69f45e8d347b8082" );
    level.ee_richtofen endon( #"player_remove" );
    wait randomfloat( 0.2 );
    
    while ( true )
    {
        if ( self.on )
        {
            deactivateworldevent( self.event_name );
            self.on = 0;
        }
        else
        {
            activateworldevent( self.event_name );
            self.on = 1;
        }
        
        wait randomfloatrange( 0.1, 0.5 );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x7449c594, Offset: 0x98b4
// Size: 0xa5
function private function_f970cab432569a79( player )
{
    player endon( #"disconnect" );
    self setusableenabled( 0 );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    player val::set( #"ee_richtofen", "allow_movement", 0 );
    player notify( #"rr_3_interact" );
    wait 0.2;
    level musicbank_utility::function_5aca66c390aa347d( player, #"hash_7e0d7d3390bf52d8" );
    thread function_988b1819d4916a5d( player );
    wait 0.5;
    level notify( #"command_door_opened" );
    thread door_open( 0.25, 0 );
    utility::flag_set( #"hash_69f45e8d347b8082" );
    self delete();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x842119d7, Offset: 0x9961
// Size: 0x615
function private function_7d6d633ab952c4d7( skipped, save_restored )
{
    utility::flag_wait( "rr_3_teleport_done" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    all_statues = zm_sat_locust_util::get_quest_reference( #"hash_c1cc810120bdd85" );
    
    foreach ( statue in all_statues )
    {
        if ( statue.script_noteworthy != "4" && statue.script_noteworthy != "5" )
        {
            statue setscriptablepartstate( #"sat_zm_prop_lysander", #"visible_default" );
        }
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) )
    {
        player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    }
    
    var_c624ae365c2a6062 = zm_sat_locust_util::get_quest_reference( #"hash_c4017038d46041c9" );
    zombies = [];
    
    foreach ( loc in var_c624ae365c2a6062 )
    {
        params = { #difficulty_round_number:20, #forced_move_speed:"sprint", #skip_eyes:1, #var_30085f70fc117162:loc, #spawner_zombie_type:"zombie_base" };
        zombie = zm_sat_locust_util::spawn_quest_zombie( params );
        
        if ( zombie )
        {
            if ( zombie.var_65f584febac9b370 )
            {
                zombie zombie_attractor_manager::function_dcfb4c31f1d97cd2( zombie.var_65f584febac9b370 );
            }
            
            attractor_loc = { #angles:( randomint( 360 ), 0, 0 ), #origin:zombie.origin };
            zombie.var_65f584febac9b370 = zombie zombie_attractor_manager::function_7eb1aaa8bc7cc15( attractor_loc, 4 );
            zombies[ zombies.size ] = zombie;
            level.ee_richtofen.zombies[ level.ee_richtofen.zombies.size ] = zombie;
            zombie callback::add( "on_zombie_ai_killed", &function_582f982b8dbaccaa );
        }
    }
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_2dc4db5f0f23cdca" ) )
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_2dc4db5f0f23cdca", zombies );
    }
    else
    {
        zm_sat_locust_util::function_222215ce3aef9da1( #"hash_2dc4db5f0f23cdca", zombies );
    }
    
    triggers = zm_sat_locust_util::get_quest_reference( #"hash_14a71f50dace4909" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerenable();
        trigger::makeenterexittrigger( trigger, &function_51625909a03e0c32 );
    }
    
    all_fire = zm_sat_locust_util::get_quest_reference( #"hash_df392d2fd685b908" );
    
    foreach ( loc in all_fire )
    {
        loc.scriptable = spawnscriptable( %"sat_zm_prop_fire_puddle", loc.origin, loc.angles );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_banners" ) )
    {
        banners = zm_sat_locust_util::get_quest_reference( #"richtofen_banners" );
        
        foreach ( banner in banners )
        {
            banner setscriptablepartstate( #"sat_zm_prop_benjamin", #"destroyed" );
            banner setscriptablepartstate( #"vfx", #"burning" );
        }
    }
    
    wait 1;
    end_door = zm_sat_locust_util::get_quest_reference( #"hash_4d405c01daacd177" );
    player thread focus_view( vectortoangles( end_door.origin - player utility::get_player_camera_origin() ), 0.5, 1 );
    level thread function_8443692b85e66957( zm_sat_locust_util::get_quest_reference( #"richtofen_fire_start" ) );
    level thread function_ac4dd4926465670e( player );
    level thread function_3d12a968a901f493( player );
    function_f55298f90b00fc4( player );
    wait 1;
    player val::set( #"hash_fcbb1a71755c44fd", "show_hud", 0 );
    function_7a800b9feba79de( player, 1 );
    player thread function_a429aaf9409bfd35( level.ee_richtofen.dialog.var_97b71299dc4b3e7a, 1, 2 );
    player thread function_af66df10144619bd();
    var_c9d01d7ab0239b9b = zm_sat_locust_util::get_quest_reference( #"richtofen_door_interact" );
    level thread function_634ddd4ef30b2b89( var_c9d01d7ab0239b9b );
    
    /#
        iprintlnbold( "<dev string:x93>" );
    #/
    
    function_e7f1566dcb30bedb( 0 );
    damage::register_scripted_damage_override_func( &richtofen_damage_override );
    utility::flag_wait( #"hash_69f45f8d347b8235" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xea00e454, Offset: 0x9f7e
// Size: 0x3e
function private function_60062548e78b7d3c( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f45f8d347b8235" );
    }
    
    damage::function_d8877aa55ec6518b( &richtofen_damage_override );
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x38639b16, Offset: 0x9fc4
// Size: 0x427
function private function_c419e99e4f96232b()
{
    var_1c6b2683485ec76 = utility::getstructarray( "rr_3_end_spawn" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_1c5cbccc24a36f29", var_1c6b2683485ec76 );
    var_c9d01d7ab0239b9b = utility::getstruct( "rr_3_exit_intr" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_4d405c01daacd177", var_c9d01d7ab0239b9b );
    triggers = utility::getstructarray( "rr_3_trigger_hallway" );
    
    foreach ( trigger in triggers )
    {
        trigger.fire_start_loc = utility::getstruct( trigger.target );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_14a71f50dace4909", triggers );
    all_fire_locs = utility::getstructarray( "rr_3_fire", "script_noteworthy" );
    
    foreach ( loc in all_fire_locs )
    {
        loc.connected_locs = utility::getstructarray( loc.target );
    }
    
    fire_start_loc = utility::getstruct( "rr_3_fire" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_df392d2fd685b908", all_fire_locs );
    zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_fire_start", fire_start_loc );
    timeout_fire_start_loc = utility::getstruct( "rr_3_timeout_fire" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_5a725e0c7d6b245f", timeout_fire_start_loc );
    var_c624ae365c2a6062 = utility::getstructarray( "rr_3_zm_spawn" );
    var_c624ae365c2a6062 = utility::array_sort_by_script_index( var_c624ae365c2a6062 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c4017038d46041c9", var_c624ae365c2a6062 );
    banners = getentitylessscriptablearray( %"sat_zm_prop_benjamin" );
    dust_falling_locs = utility::getstructarray( "dust_falling", "targetname" );
    utility::flag_wait( "scriptables_ready" );
    new_banners = [];
    
    foreach ( banner in banners )
    {
        banner setscriptablepartstate( #"sat_zm_prop_benjamin", #"disabled" );
        new_banner = spawnscriptable( %"sat_zm_prop_benjamin", banner.origin, banner.angles, undefined, function_67b78af3c33ac9a8( 0.65 ) );
        new_banners[ new_banners.size ] = new_banner;
    }
    
    if ( new_banners.size > 0 )
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_banners", new_banners );
    }
    
    new_dust_falling = [];
    
    foreach ( dust_falling in dust_falling_locs )
    {
        scriptable = spawnscriptable( %"sat_zm_prop_winston", dust_falling.origin, dust_falling.angles );
        scriptable.idx = int( dust_falling.script_noteworthy );
        new_dust_falling[ new_dust_falling.size ] = scriptable;
    }
    
    if ( new_dust_falling.size > 0 )
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"dust_falling", new_dust_falling );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x84b3702, Offset: 0xa3f3
// Size: 0x27
function private function_988b1819d4916a5d( player )
{
    player playsoundevent( %"sndevent_powerup_nuke" );
    player function_a17bb0ff89d17835( 1 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x808e62b1, Offset: 0xa422
// Size: 0x1bf
function private function_a17bb0ff89d17835( duration = 0.5 )
{
    self notify( #"play_nuke_screen_flash" );
    self endon( #"death_or_disconnect" );
    self endon( #"play_nuke_screen_flash" );
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        self.white_screen_overlay setshader( "white", 640, 480 );
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
        self.white_screen_overlay.scramblerdisabled = 1;
    }
    
    var_24c3037417857a23 = 0.2;
    n_target_alpha = 1;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    
    if ( duration > 0 )
    {
        wait duration;
    }
    
    remove_white_screen();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xc443edeb, Offset: 0xa5e9
// Size: 0x6f
function private remove_white_screen()
{
    self endon( #"disconnect" );
    var_24c3037417857a23 = 0.5;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
        self.white_screen_overlay.alpha = 0;
    }
    
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xe9e78f69, Offset: 0xa660
// Size: 0x19f
function private function_8443692b85e66957( struct )
{
    locs = [ struct ];
    var_13491744c99298ac = zm_sat_locust_util::get_quest_reference( #"hash_2dc4db5f0f23cdca" );
    
    for ( i = 0; i < var_13491744c99298ac.size ; i++ )
    {
        var_13491744c99298ac[ i ] thread function_244ca8cb4dbd6260( 0.5 * i );
    }
    
    while ( true )
    {
        if ( !locs || locs.size == 0 )
        {
            break;
        }
        
        next_locs = [];
        
        foreach ( loc in locs )
        {
            if ( loc.scriptable getscriptablepartstate( #"sat_zm_prop_fire_puddle" ) != "idle" )
            {
                continue;
            }
            
            state = #"on_ground";
            
            if ( loc.script_label == "wall" )
            {
                state = utility::cointoss() ? #"on_wall" : #"on_wall_small";
            }
            
            loc.scriptable setscriptablepartstate( #"sat_zm_prop_fire_puddle", state );
            
            if ( loc.connected_locs )
            {
                next_locs = arraycombine( next_locs, loc.connected_locs );
            }
        }
        
        locs = next_locs;
        wait 0.5;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xd1adfd81, Offset: 0xa807
// Size: 0x9f
function private function_244ca8cb4dbd6260( delay = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isai( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( self.var_65f584febac9b370 )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.var_65f584febac9b370 );
        zombie_knockdown::function_6fc167d4a3590991( self.origin );
    }
    
    if ( self getscriptablehaspart( #"burned" ) )
    {
        self setscriptablepartstate( #"burned", #"burned_on" );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xd4e6696f, Offset: 0xa8ae
// Size: 0x1a1
function private function_ac4dd4926465670e( player )
{
    level endon( #"game_ended", #"hash_69f45f8d347b8235" );
    player endon( #"death_or_disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    all_fire = zm_sat_locust_util::get_quest_reference( #"hash_df392d2fd685b908" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_4e33ab3edb74efee" ) )
    {
        var_2aea2067472b8bd1 = zm_sat_locust_util::get_quest_reference( #"hash_4e33ab3edb74efee" );
    }
    else
    {
        var_2aea2067472b8bd1 = utility::spawn_model( "tag_origin", ( 0, 0, 0 ) );
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_4e33ab3edb74efee", var_2aea2067472b8bd1 );
    }
    
    while ( true )
    {
        all_fire = sortbydistance( all_fire, player.origin );
        
        foreach ( loc in all_fire )
        {
            if ( distancesquared( loc.origin, player.origin ) < squared( 75 ) )
            {
                player dodamage( level.ee_richtofen.var_fd90b188d7de6f4a, loc.origin, var_2aea2067472b8bd1, undefined, "MOD_FIRE" );
                break;
            }
        }
        
        wait level.ee_richtofen.fire_damage_tick_rate;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x9be25b83, Offset: 0xaa57
// Size: 0x345
function private function_3d12a968a901f493( player )
{
    level endon( #"game_ended", #"hash_69f45f8d347b8235" );
    player endon( #"death_or_disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    var_93c3e7bb3f019adf = zm_sat_locust_util::get_quest_reference( #"hash_5a725e0c7d6b245f" );
    locs = [ var_93c3e7bb3f019adf ];
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_18d838366b3a6991" ) )
    {
        level.ee_richtofen.timeout_fires = [];
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_18d838366b3a6991", level.ee_richtofen.timeout_fires );
    }
    
    level.ee_richtofen.timeout_fires = zm_sat_locust_util::get_quest_reference( #"hash_18d838366b3a6991" );
    level thread function_a5b6f08da05c7d2e( player );
    
    for ( explosion_feedback = 1; true ; explosion_feedback++ )
    {
        next_locs = [];
        
        foreach ( loc in locs )
        {
            if ( !loc.scriptable )
            {
                if ( level.ee_richtofen.timeout_fires.size == level.ee_richtofen.var_f851405bf5428000 )
                {
                    farthest_fire = level.ee_richtofen.timeout_fires[ 0 ];
                    
                    if ( farthest_fire.scriptable )
                    {
                        farthest_fire.scriptable freescriptable();
                    }
                    
                    level.ee_richtofen.timeout_fires = arrayremove( level.ee_richtofen.timeout_fires, farthest_fire );
                }
                
                loc.scriptable = spawnscriptable( %"sat_zm_prop_fire_puddle", loc.origin, loc.angles );
                level.ee_richtofen.timeout_fires[ level.ee_richtofen.timeout_fires.size ] = loc;
            }
            
            if ( loc.scriptable getscriptablepartstate( #"sat_zm_prop_fire_puddle" ) != "idle" )
            {
                continue;
            }
            
            state = #"on_ground";
            
            if ( loc.script_label == "wall" )
            {
                state = utility::cointoss() ? #"on_wall" : #"on_wall_small";
            }
            
            loc.scriptable setscriptablepartstate( #"sat_zm_prop_fire_puddle", state );
            connected_locs = utility::getstructarray( loc.target );
            
            if ( connected_locs )
            {
                next_locs = arraycombine( next_locs, connected_locs );
            }
        }
        
        locs = next_locs;
        
        if ( explosion_feedback % 2 == 0 )
        {
            function_f55298f90b00fc4( player );
        }
        
        wait level.ee_richtofen.var_86d2f0958d6cf54b;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xb8903e77, Offset: 0xada4
// Size: 0x1dd
function private function_a5b6f08da05c7d2e( player )
{
    level endon( #"game_ended", #"hash_69f45f8d347b8235" );
    player endon( #"death_or_disconnect" );
    all_fire = level.ee_richtofen.timeout_fires;
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_4e33ab3edb74efee" ) )
    {
        var_2aea2067472b8bd1 = zm_sat_locust_util::get_quest_reference( #"hash_4e33ab3edb74efee" );
    }
    else
    {
        var_2aea2067472b8bd1 = utility::spawn_model( "tag_origin", ( 0, 0, 0 ) );
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_4e33ab3edb74efee", var_2aea2067472b8bd1 );
    }
    
    while ( true )
    {
        all_fire = level.ee_richtofen.timeout_fires;
        all_fire = sortbydistance( all_fire, player.origin );
        
        foreach ( loc in all_fire )
        {
            if ( !loc.scriptable || loc.scriptable getscriptablepartstate( #"sat_zm_prop_fire_puddle" ) == "idle" )
            {
                continue;
            }
            
            if ( distancesquared( loc.origin, player.origin ) < squared( 125 ) )
            {
                player dodamage( level.ee_richtofen.var_fd90b188d7de6f4a * 2, loc.origin, var_2aea2067472b8bd1, undefined, "MOD_FIRE" );
                break;
            }
        }
        
        wait level.ee_richtofen.fire_damage_tick_rate;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x8778ab85, Offset: 0xaf89
// Size: 0x11d
function private function_7a800b9feba79de( player, give_special = 0 )
{
    player val::reset_all( #"ee_richtofen" );
    
    if ( give_special )
    {
        player setdemeanorviewmodel( "normal" );
        player val::reset( #"narrative_room", "fire" );
        return;
    }
    
    if ( isdefined( player.ee_loadout[ "perks" ] ) )
    {
        foreach ( perk in player.ee_loadout[ "perks" ] )
        {
            player zombie_perks::give_perk( perk.ref, perk.bought, 0, undefined, perk.permanent );
            waitframe();
        }
    }
    
    player zm_utility::function_663d59490abc834f();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x16b18555, Offset: 0xb0ae
// Size: 0x21b
function private function_634ddd4ef30b2b89( struct )
{
    if ( struct.script_noteworthy )
    {
        door_num = 4 - int( struct.script_noteworthy );
    }
    else
    {
        door_num = 4;
    }
    
    side_doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" )[ door_num - 1 ];
    
    foreach ( door in side_doors )
    {
        foreach ( struct in door.linked_structs )
        {
            var_30085f70fc117162 = struct;
            params = { #difficulty_round_number:20, #forced_move_speed:"sprint", #skip_eyes:1, #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:"zombie_base" };
            zombie = zm_sat_locust_util::spawn_quest_zombie( params );
            
            if ( zombie )
            {
                zombie thread function_244ca8cb4dbd6260();
                level.ee_richtofen.zombies[ level.ee_richtofen.zombies.size ] = zombie;
                
                if ( struct.script_noteworthy == "shot_1" || struct.script_noteworthy == "shot_2" )
                {
                    struct thread function_8adf97910fa58051( zombie );
                }
                
                zombie callback::add( "on_zombie_ai_killed", &function_582f982b8dbaccaa );
            }
        }
        
        door side_door_open();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xe103b7c1, Offset: 0xb2d1
// Size: 0x25f
function private function_5a2d85b6af372a76( player, do_vision = 1 )
{
    end_doors = zm_sat_locust_util::get_quest_reference( #"hash_cde847cf5595a493" );
    
    foreach ( door in end_doors )
    {
        foreach ( struct in door.linked_structs )
        {
            var_30085f70fc117162 = struct;
            params = { #difficulty_round_number:20, #forced_move_speed:"sprint", #skip_eyes:1, #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:"zombie_base" };
            zombie = zm_sat_locust_util::spawn_quest_zombie( params );
            
            if ( zombie )
            {
                zombie thread function_244ca8cb4dbd6260();
                level.ee_richtofen.zombies[ level.ee_richtofen.zombies.size ] = zombie;
                zombie callback::add( "on_zombie_ai_killed", &function_582f982b8dbaccaa );
            }
        }
        
        door side_door_open();
    }
    
    if ( do_vision )
    {
        door_look = zm_sat_locust_util::get_quest_reference( #"hash_4d405c01daacd177" );
        earthquake( 0.3, 1, door_look.origin, 200 );
        player thread focus_view( vectortoangles( door_look.origin - player utility::get_player_camera_origin() ), 0.5, 1 );
        thread function_60c1cfc5c448f9aa( player, 1, 2 );
        wait 1;
        level thread function_5c8400c41240e3cc( player );
        wait 1;
        function_6facddde2f4fd0f( player, undefined, 0 );
        return;
    }
    
    level thread function_5c8400c41240e3cc( player );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x12ace6f7, Offset: 0xb538
// Size: 0x84
function private function_582f982b8dbaccaa( params )
{
    if ( level.ee_richtofen.zombies && level.ee_richtofen.zombies.size > 0 && arraycontains( level.ee_richtofen.zombies, self ) )
    {
        level.ee_richtofen.zombies = arrayremove( level.ee_richtofen.zombies, self );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xdc53c085, Offset: 0xb5c4
// Size: 0x1f
function private function_8adf97910fa58051( zombie )
{
    waitframe();
    scene::play( zombie, self.script_noteworthy );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x13724ea6, Offset: 0xb5eb
// Size: 0xdf
function private function_51625909a03e0c32( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        if ( trigger.script_noteworthy == "4" )
        {
            level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
            level thread function_5a2d85b6af372a76( ent );
            
            /#
                iprintlnbold( "<dev string:xce>" );
            #/
        }
        else
        {
            level thread function_634ddd4ef30b2b89( trigger );
            level thread function_8443692b85e66957( trigger.fire_start_loc );
            loc = trigger.script_noteworthy;
            
            /#
                iprintlnbold( "<dev string:xe4>" + int( loc ) + "<dev string:xf5>" );
            #/
            
            function_e7f1566dcb30bedb( int( trigger.script_noteworthy ) );
            function_f55298f90b00fc4( ent, trigger.origin );
        }
        
        trigger triggerdisable();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x661fd8d6, Offset: 0xb6d2
// Size: 0x5a
function private function_f55298f90b00fc4( player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" ), origin = player.origin )
{
    earthquake( 0.3, 2, origin, 500 );
    playsoundatpos( origin, "evt_ee_hallway_quake_lr" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x91dc0d6d, Offset: 0xb734
// Size: 0xb0
function private function_e7f1566dcb30bedb( idx )
{
    dust_falling_locs = zm_sat_locust_util::get_quest_reference( #"dust_falling" );
    
    foreach ( dust_falling in dust_falling_locs )
    {
        if ( dust_falling.idx == idx )
        {
            dust_falling setscriptablepartstate( "vfx", "on" );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x4abeed1, Offset: 0xb7ec
// Size: 0x2a9
function private function_5c8400c41240e3cc( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level.ee_richtofen notify( #"death_scene_start" );
    s_scene = utility::getstruct( "t10_cin_zm_vig_plr_dth_zmb_duo_01_global" );
    level.ee_richtofen.s_death_scene = s_scene;
    scene::add_scene_func( s_scene, &function_c203ac4223dc16f7, "callback_play" );
    scene_ents = [ player ];
    
    foreach ( zombie in level.ee_richtofen.zombies )
    {
        if ( isalive( zombie ) )
        {
            scene_ents[ scene_ents.size ] = zombie;
            level.ee_richtofen.zombies = arrayremove( level.ee_richtofen.zombies, zombie );
        }
        
        if ( scene_ents.size == 3 )
        {
            break;
        }
    }
    
    s_scene scene::function_b95eab90f9ebc981( player );
    s_scene thread scene::pre_stream_play( 2, scene_ents, "shot_010", "t10_cin_zm_vig_plr_dth_zmb_duo_01_global" );
    player val::set( #"richtofen_death", "death", 0 );
    player val::set( #"richtofen_death", "damage", 0 );
    game_utility::fadetoblackforplayerkeepui( player, 1, 1 );
    
    foreach ( zombie in level.ee_richtofen.zombies )
    {
        zombie zm_sat_locust_util::function_44f5bec4abb163f1( 1 );
    }
    
    function_a62e9fb7be9ff0a6( zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" ).origin, 2000 );
    
    if ( isalive( player ) && !player isspectatinganyone() )
    {
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player val::set( #"richtofen_death", "ignoreme", 1 );
    }
    
    if ( player )
    {
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xa301091c, Offset: 0xba9d
// Size: 0x27f
function private function_c203ac4223dc16f7()
{
    level endon( #"game_ended" );
    
    if ( level.ee_richtofen.s_death_scene )
    {
        level thread scene::remove_scene_func( level.ee_richtofen.s_death_scene, &function_c203ac4223dc16f7, "callback_play" );
    }
    
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    
    if ( player && !player isspectatinganyone() )
    {
        player val::set( #"richtofen_death", "show_hud", 0 );
        player player_camera_sway_stop();
    }
    
    var_9ac3bb793f88c30d = scene::get_entities();
    
    foreach ( ai in var_9ac3bb793f88c30d )
    {
        if ( isai( ai ) )
        {
            ai.ignore_enemy_count = 1;
            
            if ( ai getscriptablehaspart( #"burned" ) )
            {
                ai setscriptablepartstate( #"burned", #"burned_on" );
            }
        }
    }
    
    if ( player )
    {
        player playlocalsound( #"hash_f32f93cea4f6ec0e" );
    }
    
    game_utility::fadetoblackforplayerkeepui( player, 0, 0.5 );
    player thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.death_scene );
    wait 4.1;
    
    if ( player )
    {
        player setscriptablepartstate( #"locust_echo_sfx", #"trans_out" );
    }
    
    if ( player )
    {
        utility::flag_set( #"hash_69f45f8d347b8235" );
    }
    
    wait 2;
    thread scene::stop();
    
    if ( player )
    {
        wait 2;
    }
    
    foreach ( zombie in var_9ac3bb793f88c30d )
    {
        if ( isai( zombie ) )
        {
            zombie zm_sat_locust_util::function_44f5bec4abb163f1( 1 );
        }
    }
    
    function_a62e9fb7be9ff0a6( zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" ).origin, 2000 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x3b3e5413, Offset: 0xbd24
// Size: 0x87
function private function_af66df10144619bd()
{
    level endon( #"game_ended", #"hash_69f4608d347b83e8" );
    self endon( #"death_or_disconnect" );
    level.ee_richtofen endon( #"death_scene_start", #"player_remove" );
    
    while ( true )
    {
        msg = utility::waittill_any_timeout( level.ee_richtofen.var_cc16d15d20cb8ac5, "rr_3_interact" );
        
        if ( msg == "timeout" )
        {
            break;
        }
    }
    
    thread function_288f22014ae731b6();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x4c7ac5cc, Offset: 0xbdb3
// Size: 0xf1
function private function_288f22014ae731b6()
{
    player_camera_sway_stop();
    set_no_weapon( 1 );
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundlestart( self, %"cer_zm_ruby_echoes_cave_intense" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_14a71f50dace4909" ) )
    {
        triggers = zm_sat_locust_util::get_quest_reference( #"hash_14a71f50dace4909" );
        
        foreach ( trigger in triggers )
        {
            trigger triggerdisable();
        }
    }
    
    level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
    function_6facddde2f4fd0f( self );
    level thread function_5a2d85b6af372a76( self, 0 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x8d416777, Offset: 0xbeac
// Size: 0x76
function private function_7d6d583ab952aca6( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    level thread function_e98ef6613b671233( player );
    player val::reset_all( #"hash_23ed4140309e18d4" );
    utility::delaythread( 1, &function_37b27adb8fb3067d );
    utility::flag_wait( #"hash_69f4608d347b83e8" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x8e573791, Offset: 0xbf2a
// Size: 0x119
function private function_60062c48e78b8ca1( skipped, save_restored )
{
    profilestart();
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    player.var_420915a121e1cc41 = 0;
    level.ee_richtofen.completed_players[ level.ee_richtofen.completed_players.size ] = player;
    player zm_sat_locust_rej::function_241d85333be1a0d8( 0 );
    player function_37e122b643059d9();
    player val::reset_all( #"hash_90e7a906e736a9ba" );
    player val::reset_all( #"hash_e5a70e25939f301e" );
    player.b_ignore_powerups = undefined;
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_69f4608d347b83e8" );
    }
    
    thread function_a221a30c3a2d5fff();
    function_318495bde7515829( player );
    level callback::remove( #"player_disconnect", &on_player_disconnect );
    level callback::remove( "zm_exfil_started", &function_69d18e825270af2f );
    utility::flag_clear( "rr_3_is_busy" );
    utility::delaythread( 1, &reset_quest_data );
    profilestop();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xfbbdd639, Offset: 0xc04b
// Size: 0x2b
function private function_9faf2ce6e7d814da()
{
    loc = utility::getstruct( "rr_3_land" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c5a04643085f8e3a", loc );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x22203b08, Offset: 0xc07e
// Size: 0x243
function private function_e98ef6613b671233( player )
{
    player endon( #"death_or_disconnect" );
    landing_destination = zm_sat_locust_util::get_quest_reference( #"hash_c5a04643085f8e3a" );
    player val::set( #"hash_2a4b737ed621233c", "allow_movement", 0 );
    player val::set( #"hash_2a4b737ed621233c", "freezecontrols", 1 );
    player hud_util::fade_out( 0.25, "white" );
    stopfxontagforclients( utility::getfx( "richtofen_camera" ), player, "j_head", player );
    player setscriptablepartstate( #"locust_echo_sfx", #"off" );
    wait 1;
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundlestart( player, %"cer_zm_topaz_sam_teleport" );
    player zm_sat_locust_rej::prepare_player();
    function_7a800b9feba79de( player );
    player set_no_weapon();
    player setscriptablepartstate( #"burning", #"active" );
    wait 2;
    pbgpostfxbundleend( player, %"cer_zm_topaz_sam_teleport" );
    player val::reset_all( #"richtofen_death" );
    player val::reset_all( #"hash_fcbb1a71755c44fd" );
    player zm_sat_locust_rej::function_6b4a863987e3a49( landing_destination.origin + ( 0, 0, landing_destination.script_int ), vectortoangles( landing_destination.origin - player.origin ) );
    player thread zm_sat_locust_rej::function_5e6fbf9ef5db2557( landing_destination.origin, landing_destination.script_int, landing_destination.angles, 0 );
    wait 0.5;
    player thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.var_346244389bce69be );
    player playsoundevent( %"sndevent_teleportation_end_3d" );
    player waittill( #"touchdown_ejection" );
    destination = utility::function_f1933af772476229( level.robot_ejection_tubes.narrative_rooms );
    destination.in_use = 0;
    destination.player = undefined;
    wait 1;
    level thread function_8e14ce1e3cc561fc();
    player val::reset_all( #"hash_2a4b737ed621233c" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x9af28bab, Offset: 0xc2c9
// Size: 0xa4
function private function_8e14ce1e3cc561fc()
{
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    player setscriptablepartstate( #"burning", #"neutral" );
    level musicbank_utility::function_5aca66c390aa347d( player, #"hash_7e0d843390bf5ebd" );
    player thread function_5ca0e2e5f6c2bd68( level.ee_richtofen.dialog.outro_sequence );
    player play_outro_gesture( "sat_vm_gesture_ee_richtofen_ending", "sat_zm_vm_ges_locust_ee_richtofen_ending" );
    player val::reset_all( #"hash_b73288e732d73f08" );
    utility::flag_set( #"hash_69f4608d347b83e8" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x62c88bff, Offset: 0xc375
// Size: 0x16a
function private play_outro_gesture( str_gesture, var_4450ba6666aac19a )
{
    self endon( #"death_or_disconnect" );
    set_no_weapon( 0 );
    val::set( #"hash_b73288e732d73f08", "reload", 0 );
    val::set( #"hash_b73288e732d73f08", "ignoreme", 1 );
    val::set( #"hash_b73288e732d73f08", "freezecontrols", 1 );
    val::set( #"hash_b73288e732d73f08", "death", 0 );
    val::set( #"hash_b73288e732d73f08", "show_hud", 0 );
    val::set( #"hash_b73288e732d73f08", "fire", 0 );
    val::set( #"hash_b73288e732d73f08", "weapon_switch", 0 );
    val::set( #"hash_b73288e732d73f08", "killstreaks", 0 );
    val::set( #"hash_b73288e732d73f08", "damage", 0 );
    val::set( #"hash_b73288e732d73f08", "allow_movement", 0 );
    val::set( #"hash_b73288e732d73f08", "interactions", 0 );
    
    while ( self getcurrentweapon().type == "none" )
    {
        waitframe();
    }
    
    if ( var_4450ba6666aac19a )
    {
        utility::function_72b6372d2d8c997( var_4450ba6666aac19a, 1 );
    }
    else
    {
        self forceplaygestureviewmodel( str_gesture );
    }
    
    var_961463cd2ff4ea9c = self getgestureanimlength( str_gesture );
    wait var_961463cd2ff4ea9c;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xb53e2aae, Offset: 0xc4e7
// Size: 0xba7
function private function_37b27adb8fb3067d()
{
    foreach ( zombie in level.ee_richtofen.zombies )
    {
        zombie zm_sat_locust_util::function_44f5bec4abb163f1( 1 );
    }
    
    function_a62e9fb7be9ff0a6( zm_sat_locust_util::get_quest_reference( #"hash_85c40662d036ce09" ).origin, 2000 );
    side_doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" );
    
    foreach ( door_pair in side_doors )
    {
        foreach ( door in door_pair )
        {
            door side_door_close( 0, 1 );
        }
    }
    
    end_doors = zm_sat_locust_util::get_quest_reference( #"hash_cde847cf5595a493" );
    
    foreach ( door in end_doors )
    {
        door side_door_close( 0, 1 );
    }
    
    if ( utility::flag( #"hash_69f45e8d347b8082" ) )
    {
        thread door_close( 0.5, 0, 1, 1 );
    }
    else if ( !utility::flag( #"hash_69f45c8d347b7d1c" ) )
    {
        thread door_close();
    }
    
    door_fx = zm_sat_locust_util::get_quest_reference( #"hash_11265e48ac939248" );
    door_fx setscriptablepartstate( #"sat_zm_prop_dixon", #"off" );
    staged_items = zm_sat_locust_util::get_quest_reference( #"hash_67940ffe36651660" );
    
    foreach ( item in staged_items )
    {
        item setscriptablepartstate( item function_84ad2f70189ee7c3(), #"visible" );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_wallbuy" ) )
    {
        wallbuy = zm_sat_locust_util::get_quest_reference( #"richtofen_wallbuy" );
        
        if ( wallbuy.default_origin )
        {
            wallbuy.origin = wallbuy.default_origin;
        }
    }
    
    all_fire = zm_sat_locust_util::get_quest_reference( #"hash_df392d2fd685b908" );
    
    foreach ( loc in all_fire )
    {
        if ( loc.scriptable )
        {
            loc.scriptable freescriptable();
        }
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_18d838366b3a6991" ) )
    {
        timeout_fires = zm_sat_locust_util::get_quest_reference( #"hash_18d838366b3a6991" );
        
        foreach ( loc in timeout_fires )
        {
            if ( loc.scriptable )
            {
                loc.scriptable freescriptable();
            }
        }
    }
    
    var_abc21ec33af41c7d = getentitylessscriptablearray( %"sat_zm_prop_fire_puddle" );
    
    if ( var_abc21ec33af41c7d.size > 0 )
    {
        foreach ( fire in var_abc21ec33af41c7d )
        {
            fire freescriptable();
        }
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"dust_falling" ) )
    {
        dust_falling_locs = zm_sat_locust_util::get_quest_reference( #"dust_falling" );
        
        foreach ( loc in dust_falling_locs )
        {
            loc setscriptablepartstate( #"vfx", #"off" );
        }
    }
    
    all_statues = zm_sat_locust_util::get_quest_reference( #"hash_c1cc810120bdd85" );
    
    foreach ( statue in all_statues )
    {
        statue setscriptablepartstate( #"sat_zm_prop_lysander", #"visible_default" );
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_9fd1d446daeec84c" );
    radio = zm_sat_locust_util::get_quest_reference( #"richtofen_radio" );
    radio setscriptablepartstate( #"usable", #"off" );
    radio setscriptablepartstate( #"fx", #"off" );
    radio setscriptablepartstate( #"fire_fx", #"off" );
    scale = zm_sat_locust_util::get_quest_reference( #"richtofen_scale" );
    scale setscriptablepartstate( #"animation", #"idle" );
    scale setscriptablepartstate( #"figurines", #"all_hidden" );
    scale setscriptablepartstate( #"hash_79c30145a71da1ce", #"all_hidden" );
    scale setscriptablepartstate( #"crystal_fx_1", #"hidden" );
    scale setscriptablepartstate( #"crystal_fx_2", #"hidden" );
    scale setscriptablepartstate( #"crystal_fx_3", #"hidden" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_banners" ) )
    {
        banners = zm_sat_locust_util::get_quest_reference( #"richtofen_banners" );
        
        foreach ( banner in banners )
        {
            banner setscriptablepartstate( #"sat_zm_prop_benjamin", #"default" );
            banner setscriptablepartstate( #"vfx", #"off" );
        }
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_4e33ab3edb74efee" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_14a71f50dace4909" ) )
    {
        triggers = zm_sat_locust_util::get_quest_reference( #"hash_14a71f50dace4909" );
        
        foreach ( trigger in triggers )
        {
            trigger triggerdisable();
        }
    }
    
    hallway_sections = zm_sat_locust_util::get_quest_reference( #"hash_c23493f42f049840" );
    
    foreach ( section in hallway_sections )
    {
        foreach ( sword in section.sword_blockers )
        {
            if ( sword.sword )
            {
                sword.sword delete();
            }
        }
        
        foreach ( prop in section.prop_blockers )
        {
            if ( prop.scriptable )
            {
                prop.scriptable freescriptable();
            }
        }
        
        section.clip_blocker hide();
        section.clip_blocker connectpaths();
        activateworldevent( section.world_event );
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_ff65b19917726f75" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_ff65ae9917726a5c" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_ff65af9917726c0f" );
    
    if ( level.ee_richtofen.var_1ed1cde6ea5640e0 )
    {
        foreach ( ent in level.ee_richtofen.var_1ed1cde6ea5640e0 )
        {
            ent delete();
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x1768f54e, Offset: 0xd096
// Size: 0xf0
function private function_a221a30c3a2d5fff()
{
    player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    
    if ( !player )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    v_landing = player.origin + anglestoforward( player getplayerangles( 1 ) ) * 64;
    spawnoptions = common_item::function_b94327aa4c1b718b( v_landing, player );
    
    if ( zm_quest::is_quest_complete( #"locust_quest_pap" ) )
    {
        itembundle = getscriptbundle( %"itemspawnentry:zm_sat_item_killstreak_zm_bernard_primary" );
        common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        wait 0.2;
    }
    
    if ( zm_quest::is_quest_complete( #"hash_d1612ed5d50da819" ) )
    {
        itembundle = getscriptbundle( %"itemspawnentry:zm_sat_item_killstreak_zm_bernard_secondary" );
        common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        wait 0.2;
    }
    
    common_item::function_577fe3f000fcb275( 0.2, 6, %"hash_5a198da2e339f331", spawnoptions );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x68f6ff5f, Offset: 0xd18e
// Size: 0x132
function private function_318495bde7515829( player )
{
    if ( level utility::flag( "rr_3_doc_1_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_document_9" );
    }
    
    if ( level utility::flag( "rr_3_doc_2_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_document_10" );
    }
    
    if ( level utility::flag( "rr_3_doc_3_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_document_11" );
    }
    
    if ( level utility::flag( "935_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_audiolog_6", undefined, undefined, 1 );
    }
    
    if ( level utility::flag( "115_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_audiolog_7", undefined, undefined, 1 );
    }
    
    if ( level utility::flag( "704_collected" ) )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_audiolog_8", undefined, undefined, 1 );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x62cd7fa4, Offset: 0xd2c8
// Size: 0x1e6
function private reset_quest_data( var_2e367b80eda5838 )
{
    utility::flag_clear( "rr_3_doc_1_collected" );
    utility::flag_clear( "rr_3_doc_2_collected" );
    utility::flag_clear( "rr_3_doc_3_collected" );
    utility::flag_clear( "935_collected" );
    utility::flag_clear( "115_collected" );
    utility::flag_clear( "704_collected" );
    utility::flag_clear( #"hash_69f4598d347b7803" );
    utility::flag_clear( #"hash_69f45a8d347b79b6" );
    utility::flag_clear( #"hash_69f45b8d347b7b69" );
    utility::flag_clear( #"hash_124ad1ddc7368f9" );
    utility::flag_clear( #"hash_124aa1ddc7363e0" );
    utility::flag_clear( #"hash_124ab1ddc736593" );
    utility::flag_clear( #"hash_69f45c8d347b7d1c" );
    utility::flag_clear( #"hash_69f45d8d347b7ecf" );
    utility::flag_clear( #"hash_124f1b1de6212d23" );
    utility::flag_clear( #"hash_124f1c1de6212ed6" );
    utility::flag_clear( #"hash_124f1d1de6213089" );
    utility::flag_clear( #"hash_69f45e8d347b8082" );
    utility::flag_clear( #"hash_69f45f8d347b8235" );
    utility::flag_clear( #"hash_69f4608d347b83e8" );
    utility::flag_clear( "rr_3_is_busy" );
    utility::flag_clear( "rr_3_teleport_done" );
    utility::flag_clear( "richtofen_reset_quest" );
    utility::flag_set( "richtofen_on_cooldown" );
    round_cooldown = var_2e367b80eda5838 ?? getdvarint( @"hash_cf364123dd87a577", 1 );
    level.ee_richtofen.cooldown_round = zm_utility::get_round_number() + round_cooldown;
    level.ee_richtofen.dialog_playing = 0;
    
    if ( level.ee_richtofen.var_4a1630a7ec169dff )
    {
        level thread zm_quest::function_80abdea0cd4c89a7( #"hash_ff7a8692bfd9781d", #"collect_medal" );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x31be4701, Offset: 0xd4b6
// Size: 0x66
function private function_1c2ab91e77f0c6ae( params )
{
    if ( utility::flag( "richtofen_on_cooldown" ) && level.ee_richtofen.cooldown_round )
    {
        if ( zm_utility::get_round_number() >= level.ee_richtofen.cooldown_round )
        {
            utility::flag_clear( "richtofen_on_cooldown" );
            utility::flag_set( "richtofen_reset_quest" );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0x9c8e79eb, Offset: 0xd524
// Size: 0x4f, Type: bool
function private is_richtofen_operator( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( arraycontains( level.ee_richtofen.completed_players, player ) )
    {
        return false;
    }
    
    if ( player operator::getoperatorref() == %"sat_ger_pl_purple" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x3c19c953, Offset: 0xd57c
// Size: 0x91
function private function_b3370116b1b41c74()
{
    richtofens = [];
    
    foreach ( player in level.players )
    {
        if ( is_richtofen_operator( player ) )
        {
            richtofens[ richtofens.size ] = player;
        }
    }
    
    return richtofens;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0x1d4f2e0b, Offset: 0xd616
// Size: 0x388
function private function_5ca0e2e5f6c2bd68( dialog_data, from_ent )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    level endon( #"game_ended", #"zm_game_over", #"start_game_ended" );
    self endon( #"disconnect" );
    level.ee_richtofen endon( #"player_remove" );
    level.ee_richtofen.dialog_playing = 1;
    function_f8c0e2b699fab9be();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_9fd1d446daeec84c" ) )
    {
        room_ents = zm_sat_locust_util::get_quest_reference( #"hash_9fd1d446daeec84c" );
    }
    
    if ( !isdefined( from_ent ) )
    {
        from_ent = self;
    }
    
    if ( !isent( from_ent ) )
    {
        var_222f2450b7c9d25e = utility::spawn_model( "tag_origin", self.origin );
        
        if ( room_ents )
        {
            room_ents[ room_ents.size ] = var_222f2450b7c9d25e;
        }
        
        from_ent = var_222f2450b7c9d25e;
    }
    
    if ( isarray( dialog_data ) )
    {
        for ( i = 0; i < dialog_data.size ; i++ )
        {
            if ( dialog_data[ i ].var_c30477c3bb21dc9e > 0 )
            {
                wait dialog_data[ i ].var_c30477c3bb21dc9e;
            }
            
            if ( !isent( from_ent ) )
            {
                var_222f2450b7c9d25e = utility::spawn_model( "tag_origin", self.origin );
                
                if ( room_ents )
                {
                    room_ents[ room_ents.size ] = var_222f2450b7c9d25e;
                }
                
                from_ent = var_222f2450b7c9d25e;
            }
            
            self notify( #"hash_7a95bdf0de61ac4d", dialog_data[ i ] );
            from_ent notify( #"hash_7a95bdf0de61ac4d", dialog_data[ i ] );
            self playsoundtoplayer( dialog_data[ i ].var_cdc21a4905c4928d, self, from_ent );
            duration = lookupsoundlength( dialog_data[ i ].var_cdc21a4905c4928d ) * 0.001;
            wait_time = dialog_data[ i ].var_560c21e0db66a7f0 > -1 ? dialog_data[ i ].var_560c21e0db66a7f0 : duration;
            
            if ( wait_time > 0 )
            {
                wait wait_time;
            }
            
            self notify( #"hash_8f9c22cfdab164c3", dialog_data[ i ] );
            from_ent notify( #"hash_8f9c22cfdab164c3", dialog_data[ i ] );
            
            if ( dialog_data[ i ].var_3baf6a6e48ca2bb9 > 0 )
            {
                wait dialog_data[ i ].var_3baf6a6e48ca2bb9;
            }
            
            self notify( #"hash_8b002a9029798397", dialog_data[ i ] );
            from_ent notify( #"hash_8b002a9029798397", dialog_data[ i ] );
        }
    }
    else
    {
        if ( dialog_data.var_c30477c3bb21dc9e > 0 )
        {
            wait dialog_data.var_c30477c3bb21dc9e;
        }
        
        if ( !isent( from_ent ) )
        {
            var_222f2450b7c9d25e = utility::spawn_model( "tag_origin", self.origin );
            
            if ( room_ents )
            {
                room_ents[ room_ents.size ] = var_222f2450b7c9d25e;
            }
            
            from_ent = var_222f2450b7c9d25e;
        }
        
        self notify( #"hash_7a95bdf0de61ac4d", dialog_data );
        from_ent notify( #"hash_7a95bdf0de61ac4d", dialog_data );
        self playsoundtoplayer( dialog_data.var_cdc21a4905c4928d, self, from_ent );
        duration = lookupsoundlength( dialog_data.var_cdc21a4905c4928d ) * 0.001;
        wait duration;
        self notify( #"hash_8f9c22cfdab164c3", dialog_data );
        from_ent notify( #"hash_8f9c22cfdab164c3", dialog_data );
        
        if ( dialog_data.var_3baf6a6e48ca2bb9 > 0 )
        {
            wait dialog_data.var_3baf6a6e48ca2bb9;
        }
        
        self notify( #"hash_8b002a9029798397", dialog_data );
        from_ent notify( #"hash_8b002a9029798397", dialog_data );
    }
    
    level.ee_richtofen.dialog_playing = 0;
    level.ee_richtofen.last_dialog_played = gettime();
    
    if ( var_222f2450b7c9d25e )
    {
        if ( room_ents )
        {
            room_ents = arrayremove( room_ents, var_222f2450b7c9d25e );
        }
        
        var_222f2450b7c9d25e delete();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 4, eflags: 0xc
// Checksum 0xdef943c7, Offset: 0xd9a6
// Size: 0x1a1
function private function_a429aaf9409bfd35( dialog_data, delay_min = 15, delay_max = 30, ent_override )
{
    self notify( #"hash_d635477c42e008b1" );
    self endon( #"hash_d635477c42e008b1" );
    level endon( #"game_ended", #"zm_game_over", #"start_game_ended" );
    level.ee_richtofen endon( #"hash_4dbc6c6709ac4a5e" );
    self endon( #"disconnect" );
    var_8a48d96e73009bd3 = ent_override ?? function_ec55c81dd1cd00ca( self );
    var_8a48d96e73009bd3.vo_audience = self;
    
    if ( !isdefined( level.ee_richtofen.last_dialog_played ) )
    {
        level.ee_richtofen.last_dialog_played = 0;
    }
    
    while ( true )
    {
        if ( level.ee_richtofen.dialog_playing || gettime() < level.ee_richtofen.last_dialog_played + 2000 )
        {
            wait 1;
            continue;
        }
        
        /#
            debug::sphere( var_8a48d96e73009bd3, 5, ( 0.5, 0, 1 ), 3 );
            debug::print3d( var_8a48d96e73009bd3, "<dev string:x118>", ( 0.5, 0, 1 ), 3, undefined, undefined, 1, 0.3 );
        #/
        
        var_8a48d96e73009bd3 thread dialogue::say( dialog_data.var_cdc21a4905c4928d, undefined, undefined, 1 );
        wait randomfloatrange( delay_min, delay_max );
        var_8a48d96e73009bd3 = ent_override ?? function_ec55c81dd1cd00ca( self );
        var_8a48d96e73009bd3.vo_audience = self;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xb2ed7824, Offset: 0xdb4f
// Size: 0x156
function private function_ec55c81dd1cd00ca( player )
{
    if ( !isdefined( level.ee_richtofen.var_1ed1cde6ea5640e0 ) )
    {
        level.ee_richtofen.var_1ed1cde6ea5640e0 = [ utility::spawn_model( "tag_origin" ) ];
    }
    
    foreach ( ent in level.ee_richtofen.var_1ed1cde6ea5640e0 )
    {
        if ( !ent dialogue::is_speaking() )
        {
            var_8a48d96e73009bd3 = ent;
            break;
        }
    }
    
    if ( !var_8a48d96e73009bd3 )
    {
        var_8a48d96e73009bd3 = utility::spawn_model( "tag_origin" );
        level.ee_richtofen.var_1ed1cde6ea5640e0[ level.ee_richtofen.var_1ed1cde6ea5640e0.size ] = var_8a48d96e73009bd3;
    }
    
    origin = utility::getrandompointincircle( player.origin, 150 ) + ( 0, 0, randomint( 100 ) );
    origin = getclosestpointonnavmesh( origin );
    var_8a48d96e73009bd3.origin = origin;
    return var_8a48d96e73009bd3;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x9c0184b6, Offset: 0xdcae
// Size: 0xef
function private function_f8c0e2b699fab9be()
{
    ents = level.ee_richtofen.var_1ed1cde6ea5640e0;
    
    foreach ( ent in ents )
    {
        ent stopsounds();
        
        if ( ent dialogue::is_speaking() )
        {
            ent dialogue::stop_dialogue();
        }
        
        level.ee_richtofen.var_1ed1cde6ea5640e0 = arrayremove( level.ee_richtofen.var_1ed1cde6ea5640e0, ent );
        
        if ( !isplayer( ent ) )
        {
            ent utility::delaycall( level.framedurationseconds, &delete );
        }
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0
// Checksum 0xefe86845, Offset: 0xdda5
// Size: 0x42
function player_camera_sway_setup()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        return;
    }
    
    function_618b5f78fac6b6e();
    thread player_camera_sway_begin( 1, "richtofen_sway_complete", 1 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0
// Checksum 0xdd424377, Offset: 0xddef
// Size: 0x26
function function_618b5f78fac6b6e()
{
    var_550963bbb003c756 = ( 0, 0, 0 );
    self.var_550963bbb003c756 = var_550963bbb003c756;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 4
// Checksum 0x5f08ec51, Offset: 0xde1d
// Size: 0x4f
function player_camera_sway_begin( base_multiplier = 1, flag_endon, var_ff7969d4eb2f286e = 1, var_4114bccfd16215bf )
{
    player_camera_sway_settings( base_multiplier );
    thread player_camera_sway_thread( flag_endon, var_ff7969d4eb2f286e );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0
// Checksum 0xa99d6f4b, Offset: 0xde74
// Size: 0x51
function player_camera_sway_init()
{
    utility::ent_flag_set( "player_camera_sway" );
    self.var_c7b6c9bfdbf8d9fc = spawn( "script_model", self.origin );
    self.var_c7b6c9bfdbf8d9fc.angles = self getplayerangles();
    self playersetgroundreferenceent( self.var_c7b6c9bfdbf8d9fc );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 8
// Checksum 0x415281c3, Offset: 0xdecd
// Size: 0x1ce
function player_camera_sway_settings( base_multiplier = 1, base_duration = 5, duration_variance = 1, base_yaw = 2, base_pitch = 2, base_roll = 4, low_variance = 0.5, high_variance = 1 )
{
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_init();
    }
    
    if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
    {
        base_duration *= 4;
        base_multiplier *= 0.25;
    }
    
    if ( base_multiplier >= 1 )
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance;
    }
    else
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration * 1 / base_multiplier;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance * 1 / base_multiplier;
    }
    
    self.var_c7b6c9bfdbf8d9fc.base_yaw = base_yaw * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_pitch = base_pitch * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_roll = base_roll * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.low_variance = low_variance * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.high_variance = high_variance * base_multiplier;
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0
// Checksum 0x5a028e3c, Offset: 0xe0a3
// Size: 0x26
function function_2bba09510ee8823d()
{
    if ( isdefined( self.var_550963bbb003c756 ) )
    {
        return self.var_550963bbb003c756;
    }
    
    return ( 0, 0, 0 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2
// Checksum 0xe2e35991, Offset: 0xe0d2
// Size: 0x581
function player_camera_sway_thread( flag_endon, var_ff7969d4eb2f286e = 1 )
{
    self notify( #"hash_8fa0ee1352548f15" );
    self endon( #"hash_8fa0ee1352548f15" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended", #"richtofen_sway_complete" );
    
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_settings();
    }
    
    if ( var_ff7969d4eb2f286e )
    {
        self.var_c7b6c9bfdbf8d9fc.angles = function_2bba09510ee8823d();
    }
    else
    {
        self.var_c7b6c9bfdbf8d9fc.angles = ( 0, 0, 0 );
        duration = self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance;
        self.var_c7b6c9bfdbf8d9fc rotateto( function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration;
    }
    
    while ( utility::ent_flag( "player_camera_sway" ) && !level utility::flag( flag_endon ) )
    {
        if ( self.var_c7b6c9bfdbf8d9fc.paused )
        {
            waitframe();
            continue;
        }
        
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_yaw );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_pitch );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1 - self.var_c7b6c9bfdbf8d9fc.high_variance, self.var_c7b6c9bfdbf8d9fc.base_roll );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
        
        if ( !utility::ent_flag( "player_camera_sway" ) || level utility::flag( flag_endon ) )
        {
            break;
        }
        
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1, self.var_c7b6c9bfdbf8d9fc.base_yaw + self.var_c7b6c9bfdbf8d9fc.low_variance );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1, self.var_c7b6c9bfdbf8d9fc.base_pitch + self.var_c7b6c9bfdbf8d9fc.low_variance );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1, self.var_c7b6c9bfdbf8d9fc.base_roll + self.var_c7b6c9bfdbf8d9fc.high_variance );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
    }
    
    if ( !level utility::flag( flag_endon ) )
    {
        duration = min( 0.5, self.var_c7b6c9bfdbf8d9fc.base_duration * 2 );
        self.var_c7b6c9bfdbf8d9fc rotateto( function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        level utility::flag_wait_or_timeout( flag_endon, duration );
    }
    
    if ( !level utility::flag( flag_endon ) )
    {
        duration = min( 0.5, self.var_c7b6c9bfdbf8d9fc.base_duration * 4 );
    }
    else
    {
        duration = min( 0.5, self.var_c7b6c9bfdbf8d9fc.base_duration );
    }
    
    self.var_c7b6c9bfdbf8d9fc rotateto( ( 0, 0, 0 ), duration, duration * 0.2, duration * 0.4 );
    wait duration;
    wait 0.2;
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self playersetgroundreferenceent( undefined );
        self.var_550963bbb003c756 = ( 0, 0, 0 );
        wait 0.2;
        
        if ( self.var_c7b6c9bfdbf8d9fc )
        {
            self.var_c7b6c9bfdbf8d9fc delete();
        }
        
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc = undefined;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xf3b0a5e0, Offset: 0xe65b
// Size: 0x21
function private player_camera_sway_stop()
{
    level notify( #"richtofen_sway_complete" );
    utility::ent_flag_clear( "player_camera_sway" );
    thread player_camera_sway_reset();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x74fbb2ea, Offset: 0xe684
// Size: 0xd6
function private player_camera_sway_reset()
{
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_c7b6c9bfdbf8d9fc.base_duration )
    {
        return;
    }
    
    duration = min( 0.5, self.var_c7b6c9bfdbf8d9fc.base_duration * 2 );
    self.var_c7b6c9bfdbf8d9fc rotateto( ( 0, 0, 0 ), duration, duration * 0.2, duration * 0.4 );
    wait duration;
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self playersetgroundreferenceent( undefined );
        self.var_550963bbb003c756 = ( 0, 0, 0 );
        wait 0.2;
        
        if ( self.var_c7b6c9bfdbf8d9fc )
        {
            self.var_c7b6c9bfdbf8d9fc delete();
        }
        
        waitframe();
        self.var_c7b6c9bfdbf8d9fc = undefined;
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 3, eflags: 0x4
// Checksum 0x7577efa2, Offset: 0xe762
// Size: 0xd3
function private focus_view( v_goal_angles, n_time = 1, var_899b9bbe505cba96 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = n_time * 1000;
    
    if ( !var_899b9bbe505cba96 )
    {
        v_goal_angles += ( 0, 0, randomintrange( -33, 33 ) );
    }
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            v_angles = anglelerpquatfrac( self getplayerangles(), v_goal_angles, lerpfraction );
            self setplayerangles( v_angles );
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 5, eflags: 0x4
// Checksum 0xa88eca7d, Offset: 0xe83d
// Size: 0x272
function private function_60c1cfc5c448f9aa( player, zoom_level = 2, total_duration = 2, skip_post_fx = 0, skip_sfx = 0 )
{
    level endon( #"game_ended", #"mq_encounter_starting" );
    player endon( #"hash_815c5d54c6c22997" );
    player player_camera_sway_stop();
    player set_no_weapon( 1 );
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
    
    if ( !skip_post_fx )
    {
        pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_intense" );
    }
    
    if ( !skip_sfx )
    {
        player setscriptablepartstate( #"locust_echo_sfx", #"focus_fov_ambience" );
    }
    
    var_c78b70e3d9102fdc = player val::get( "move_speed_scale" ) ?? 1;
    var_c2f5b6f80189d02e = ( var_c78b70e3d9102fdc ?? 1 ) / 100;
    var_3298596b509255cf = ( var_c78b70e3d9102fdc ?? 1 ) / 3;
    player val::set( #"hash_23ed4140309e18d4", "move_speed_scale", var_c2f5b6f80189d02e );
    player capturnrate( 0.01, 0.01 );
    
    if ( !isdefined( player.defaultbasefov ) )
    {
        player.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    defaultbasefov = player.defaultbasefov;
    var_bb2b834c881c250a = defaultbasefov / zoom_level;
    var_740a7e431ccd7e86 = var_bb2b834c881c250a * 1.5;
    var_d50fd14c99f18d0e = total_duration / 2;
    zoom_out_dur = total_duration / 3;
    var_91c7d44332ddcf42 = total_duration - var_d50fd14c99f18d0e - zoom_out_dur;
    player playrumbleonentity( "damage_light" );
    player modifybasefov( int( var_740a7e431ccd7e86 ), var_91c7d44332ddcf42 );
    wait var_91c7d44332ddcf42;
    player playrumbleonentity( "damage_heavy" );
    player modifybasefov( int( var_bb2b834c881c250a ), var_d50fd14c99f18d0e );
    wait var_d50fd14c99f18d0e;
    player capturnrate( 66, 66 );
    player val::set( #"hash_23ed4140309e18d4", "move_speed_scale", var_3298596b509255cf );
    player playrumbleonentity( "damage_heavy" );
    player modifybasefov( int( defaultbasefov * 1.2 ), zoom_out_dur );
    wait zoom_out_dur;
    player capturnrate( 222, 222 );
    player val::set( #"hash_23ed4140309e18d4", "move_speed_scale", var_c78b70e3d9102fdc );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 5, eflags: 0x4
// Checksum 0xfc8c161a, Offset: 0xeab7
// Size: 0x112
function private function_6facddde2f4fd0f( player, n_fov_time = 1, restart_sway = 1, skip_post_fx = 0, skip_sfx = 0 )
{
    player notify( #"hash_815c5d54c6c22997" );
    player playrumbleonentity( "damage_heavy" );
    player set_no_weapon( 0 );
    
    if ( !isdefined( player.defaultbasefov ) )
    {
        player.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    player modifybasefov( player.defaultbasefov, n_fov_time );
    player capturnrate( 999, 999 );
    
    if ( !skip_sfx )
    {
        player setscriptablepartstate( #"locust_echo_sfx", #"main_ambience_loop" );
    }
    
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intense" );
    
    if ( !skip_post_fx )
    {
        pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave" );
    }
    
    if ( restart_sway )
    {
        player player_camera_sway_setup();
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xbf2f1ffd, Offset: 0xebd1
// Size: 0x73
function private set_no_weapon( b_no_weapon = 1 )
{
    if ( b_no_weapon )
    {
        val::set( #"hash_187535f66026c256", "weapon", 0 );
        val::set( #"hash_187535f66026c256", "reload", 0 );
        return;
    }
    
    val::reset( #"hash_187535f66026c256", "weapon" );
    val::reset( #"hash_187535f66026c256", "reload" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xcdc644de, Offset: 0xec4c
// Size: 0x51
function private on_player_disconnect( params )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) || self != zm_sat_locust_util::get_quest_reference( #"richtofen_player" ) )
    {
        return;
    }
    
    function_f8c0e2b699fab9be();
    function_37b27adb8fb3067d();
    utility::delaythread( 1, &reset_quest_data );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x5ef7ad8d, Offset: 0xeca5
// Size: 0xac
function private function_da56c29c7485e84()
{
    level endon( #"game_ended" );
    level.ee_richtofen endon( #"death_scene_start" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        msg = utility::waittill_any_timeout( level.ee_richtofen.var_9483bcaade88c506, "rr_3_interact", "forced_removal" );
        
        if ( msg == "timeout" || msg == "forced_removal" )
        {
            break;
        }
    }
    
    forced = msg == "forced_removal";
    
    if ( !forced )
    {
        player_jumpscare();
        wait 1;
    }
    
    level thread function_439b4f25311bdaee( self, forced );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x1eff549a, Offset: 0xed59
// Size: 0x56
function private player_jumpscare()
{
    val::set( #"hash_3f9f69f557f5bfb9", "show_hud", 0 );
    playfxontagforclients( utility::getfx( "blood_moon_jumpscare" ), self, "j_head", self );
    self playsoundtoplayer( "evt_ee_jump_scare_cursed_scream", self );
    wait 1.8;
    val::reset( #"hash_3f9f69f557f5bfb9", "show_hud" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 2, eflags: 0x4
// Checksum 0xcd310060, Offset: 0xedb7
// Size: 0x368
function private function_439b4f25311bdaee( player, forced = 0 )
{
    level.ee_richtofen notify( #"player_remove" );
    
    if ( player )
    {
        function_6facddde2f4fd0f( player, undefined, 0, 1, 1 );
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( player );
    function_899dac17bef9614a( player );
    level.ee_richtofen.dialog_playing = 1;
    player player_camera_sway_stop();
    level.ee_richtofen notify( #"hash_4dbc6c6709ac4a5e" );
    function_f8c0e2b699fab9be();
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intense" );
    landing_destination = zm_sat_locust_util::get_quest_reference( #"hash_c5a04643085f8e3a" );
    player playsoundevent( %"sndevent_teleportation_begin_3d", player );
    pbgpostfxbundlestart( player, %"cer_zm_topaz_sam_teleport" );
    player playsoundevent( %"hash_57425efd488b3f31", player );
    
    if ( !forced )
    {
        wait 2;
    }
    
    if ( player )
    {
        player hud_util::fade_out( 0.5, "white" );
        
        if ( player.richtofen_camera_fx )
        {
            stopfxontagforclients( utility::getfx( "richtofen_camera" ), player, "j_head", player );
        }
        
        pbgpostfxbundleend( player, %"cer_zm_topaz_sam_teleport" );
        player zm_sat_locust_rej::prepare_player();
        player val::reset_all( #"ee_richtofen" );
        player val::reset_all( #"hash_61ab6a8c8a2761b4" );
        player val::reset_all( #"hash_3f9f69f557f5bfb9" );
        player val::reset_all( #"hash_b73288e732d73f08" );
        player val::reset_all( #"richtofen_death" );
        player val::reset_all( #"hash_e5a70e25939f301e" );
        player val::reset_all( #"hash_d952e388d2ee6de" );
        player val::reset_all( #"hash_fcbb1a71755c44fd" );
        function_7a800b9feba79de( player );
        player val::reset_all( #"hash_23ed4140309e18d4" );
        player setscriptablepartstate( #"locust_echo_sfx", #"off" );
    }
    
    if ( !forced )
    {
        wait 1;
    }
    
    function_37b27adb8fb3067d();
    
    if ( player )
    {
        player zm_sat_locust_rej::function_6b4a863987e3a49( landing_destination.origin + ( 0, 0, landing_destination.script_int ), vectortoangles( landing_destination.origin - player.origin ) );
        player zm_sat_locust_rej::function_5e6fbf9ef5db2557( landing_destination.origin, landing_destination.script_int, landing_destination.angles, 0 );
        player setdemeanorviewmodel( "normal" );
        player val::reset_all( #"hash_90e7a906e736a9ba" );
        player.b_ignore_powerups = undefined;
        player playsoundevent( %"sndevent_teleportation_end_3d" );
        function_318495bde7515829( player );
        pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
        pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intense" );
        pbgpostfxbundleend( player, %"cer_zm_topaz_sam_teleport" );
        player player_camera_sway_stop();
    }
    
    destination = utility::function_f1933af772476229( level.robot_ejection_tubes.narrative_rooms );
    destination.in_use = 0;
    destination.player = undefined;
    utility::delaythread( 1, &reset_quest_data );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 1, eflags: 0x4
// Checksum 0xac3c4501, Offset: 0xf127
// Size: 0x57
function private function_69d18e825270af2f( params )
{
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) && arraycontains( params.a_exfil_players, zm_sat_locust_util::get_quest_reference( #"richtofen_player" ) ) )
    {
        level thread function_439b4f25311bdaee( zm_sat_locust_util::get_quest_reference( #"richtofen_player" ) );
    }
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0x6dd421a6, Offset: 0xf186
// Size: 0x8a
function private function_37e122b643059d9()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"hash_f4e9aa4b1cdb96a9";
    params.var_be82617e5e8087bd = [ self ];
    params.event = #"zm_sq_quest_complete";
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_sq_quest_complete", params );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xc2e311c9, Offset: 0xf218
// Size: 0x1411
function private init_dialog()
{
    level.ee_richtofen.dialog = { #outro_sequence:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsoutseqln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsoutseqln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsoutseqln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rsoutseqln4" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rsoutseqln5" } ], #var_346244389bce69be:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsflfrsky" }, #death_scene:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsdtfkout" }, #var_3dc551918bc60a49:[ { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:1, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_on" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln01" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln02" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln03" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln04" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln05" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln06" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln07" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln08" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln09" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln10" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar7_dcc4_prpl_rsslogdccivln11" }, { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_off" } ], #var_72958e90f6ce179f:[ { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:1, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_on" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln01" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln02" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln03" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln04" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln05" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln06" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln07" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln08" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln09" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln10" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar9_mc3x_prpl_rsalogcm3xvln11" }, { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_off" } ], #var_e6256a914b54ce91:[ { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:1, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_on" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln01" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln02" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln03" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln04" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln05" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln06" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln07" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln08" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lar1_acxv_prpl_rsalogcxvln09" }, { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"evt_ee_radio_record_button_off" } ], #post_all_interacts:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rsofccmpln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rsofccmpln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsofccmpln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rsofccmpln4" } ], #var_a55d54b8675c37b8:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rskntlkln08" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rskntlkln09" } ], #var_585b4cc83ed3f398:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:0, #var_c30477c3bb21dc9e:1, #var_cdc21a4905c4928d:"evt_ee_knight_sacrifice" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rskntlkln01" }, { #var_3baf6a6e48ca2bb9:5, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rskntlkln02" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rskntlkln03" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:2, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"evt_ee_knight_demon" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rskntlkln04" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rskntlkln05" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rskntlkln06" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rskntlkln07" } ], #var_4d1a77577e7fbfd7:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rssdtblrdo1intln5" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rssdtblrdo1intln6" } ], #var_d19dad2c7617ec0b:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:11, #var_c30477c3bb21dc9e:1, #var_cdc21a4905c4928d:"evt_ee_radio_first_interact_sfx" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_nyrp_rssdtblrdo1intln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_nyrp_rssdtblrdo1intln2" }, { #var_3baf6a6e48ca2bb9:5, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_nyrp_rssdtblrdo1intln3" }, { #var_3baf6a6e48ca2bb9:6, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_nyrp_rssdtblrdo1intln4" } ], #var_b5653ee9af45d19a:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rscnttblcmpln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rscnttblcmpln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rscnttblcmpln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rscnttblcmpln4" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rscnttblcmpln5" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rscnttblcmpln6" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rscnttblcmpln7" } ], #var_22bad38635ffeff8:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rssacofrintln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rssacofrintln2" } ], #var_aadf07e31a3f72a0:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rselcxvintln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rselcxvintln2" }, { #var_3baf6a6e48ca2bb9:1, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_vlst_rselcxvintln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rselcxvintln4" } ], #var_8a90e47b8391377:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwflintln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwflintln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rshwflintln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwflintln4" } ], #var_8a90d47b8391144:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwrpintln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwrpintln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rshwrpintln3" } ], #var_8a91047b83917dd:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rshwdsintln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwdsintln2" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwdsintln3" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwdsintln4" } ], #var_97b71299dc4b3e7a:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsflhwinth" }, #var_97b71399dc4b40ad:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsofcinth" }, #var_97b71099dc4b3a14:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rshwinth" }, #intro_sequence:[ { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsintseqln1" }, { #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_sslo_rsintseqln2" } ], #var_67304a617ee4886a:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsmdint" }, #medal_attract:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsmdatr" }, #var_47203fc1e763c413:{ #var_3baf6a6e48ca2bb9:0, #var_560c21e0db66a7f0:-1, #var_c30477c3bb21dc9e:0, #var_cdc21a4905c4928d:"dx_zm_lors_lpsd_prpl_rsmebrlnomc" } };
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0
// Checksum 0x6870a8b6, Offset: 0x10631
// Size: 0xd, Type: bool
function is_busy()
{
    return utility::flag( "rr_3_is_busy" );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xa551b4b4, Offset: 0x10647
// Size: 0x2d
function private function_347b9b0d161d82a8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    zm_utility::function_d47920bb0d5fa327( "locust_eerichtofen_saveloadout" );
    take_player_loadout();
}

// Namespace zm_sat_locust_ee_richtofen
// Params 0, eflags: 0x4
// Checksum 0xde9dc869, Offset: 0x1067c
// Size: 0x1b0
function private take_player_loadout()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    zm_utility::function_92275a9d3969d91d();
    ee_loadout = [];
    ee_loadout[ "perks" ] = [];
    
    foreach ( perk in self.perks_active )
    {
        data = { #permanent:self.perma_perks && arraycontains( self.perma_perks, perk ), #bought:self.perkspurchased && self.perkspurchased[ perk ], #ref:perk };
        ee_loadout[ "perks" ][ ee_loadout[ "perks" ].size ] = data;
    }
    
    supers_mp::clearsuper( 1 );
    zombie_perks::take_all_perks( 1 );
    self.ee_loadout = ee_loadout;
    val::reset( #"hash_90e7a906e736a9ba", "weapon_pickup" );
    itembundle = getscriptbundle( %"hash_324ce24cfa4cd65f" );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( 0, 0, 0 ) );
    item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    common_item::function_2b5e2ff57d5f392( item, 0 );
    val::set( #"hash_90e7a906e736a9ba", "weapon_pickup", 0 );
}

// Namespace zm_sat_locust_ee_richtofen
// Params 10, eflags: 0x4
// Checksum 0x45a0db4d, Offset: 0x10834
// Size: 0xbd
function private richtofen_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) )
    {
        return idamage;
    }
    
    richtofen_ee = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
    
    if ( self != richtofen_ee )
    {
        return idamage;
    }
    
    if ( self.health - idamage <= 0 )
    {
        thread function_288f22014ae731b6();
        return ( self.health - 1 );
    }
}

/#

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0xe12f1189, Offset: 0x108f9
    // Size: 0x16e, Type: dev
    function private debug_init()
    {
        setdvarifuninitialized( @"hash_37d0663b76b53d73", 1, 1, 3 );
        setdvarifuninitialized( @"hash_6102e2111be17728", 2, 2, 10 );
        zm_quest::function_bc99f123a684344f( #"hash_ff7a8692bfd9781d" );
        devgui::add_devgui_func( "<dev string:x12a>", "<dev string:x137>", &debug_toggle_debug );
        devgui::add_devgui_func( "<dev string:x151>", "<dev string:x166>", &function_a231218328d37f87 );
        devgui::add_devgui_func( "<dev string:x17d>", "<dev string:x188>", &debug_open_doors );
        devgui::add_devgui_func( "<dev string:x1a0>", "<dev string:x1ac>", &debug_close_doors );
        devgui::add_devgui_dvar( "<dev string:x1c5>", "<dev string:x1db>" );
        devgui::add_devgui_dvar( "<dev string:x1fd>", "<dev string:x217>" );
        devgui::add_devgui_func( "<dev string:x23d>", "<dev string:x24f>", &function_3a2444a8d35de10e );
        devgui::add_devgui_func( "<dev string:x269>", "<dev string:x274>", &function_9a08d8b5091c5c75 );
        devgui::add_devgui_func( "<dev string:x286>", "<dev string:x298>", &debug_dust_falling );
        devgui::add_devgui_func( "<dev string:x2a8>", "<dev string:x2b9>", &function_5d05e96c89236ff4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2d2>", "<dev string:x2e7>", &debug_play_gesture );
        devgui::function_cd4e263c1f3018ae( "<dev string:x303>", "<dev string:x317>", &debug_play_gesture );
        devgui::add_devgui_func( "<dev string:x333>", "<dev string:x340>", &function_b3c34b8f1f664141 );
        devgui::add_devgui_func( "<dev string:x35a>", "<dev string:x369>", &function_bfe12d6e827d4433 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0xda31774d, Offset: 0x10a6f
    // Size: 0x17, Type: dev
    function private function_9a08d8b5091c5c75()
    {
        function_7a800b9feba79de( level.player, 1 );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0xc313d13b, Offset: 0x10a8e
    // Size: 0xd, Type: dev
    function private function_3a2444a8d35de10e()
    {
        level thread function_3229d24d4da3d18b();
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x3b57598d, Offset: 0x10aa3
    // Size: 0x9f, Type: dev
    function private function_3229d24d4da3d18b()
    {
        door = zm_sat_locust_util::get_quest_reference( #"richtofen_door_interact" );
        var_3d0c232c0c2eb2b4 = 1;
        level.player thread focus_view( vectortoangles( door.origin - level.player utility::get_player_camera_origin() ), var_3d0c232c0c2eb2b4, 1 );
        wait var_3d0c232c0c2eb2b4 / 2;
        function_60c1cfc5c448f9aa( level.player, getdvarint( @"hash_37d0663b76b53d73" ), getdvarint( @"hash_6102e2111be17728" ) );
        function_6facddde2f4fd0f( level.player );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x70367ce6, Offset: 0x10b4a
    // Size: 0xf7, Type: dev
    function private debug_open_doors()
    {
        doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" );
        
        foreach ( door_pair in doors )
        {
            foreach ( door in door_pair )
            {
                door side_door_open();
            }
        }
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x51a303a9, Offset: 0x10c49
    // Size: 0xf7, Type: dev
    function private debug_close_doors()
    {
        doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" );
        
        foreach ( door_pair in doors )
        {
            foreach ( door in door_pair )
            {
                door side_door_close();
            }
        }
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0xb6468dfd, Offset: 0x10d48
    // Size: 0x8c, Type: dev
    function private debug_toggle_debug()
    {
        if ( level.ee_richtofen.var_4f4d1954fb08ab )
        {
            level.ee_richtofen.var_4f4d1954fb08ab = 0;
            level notify( #"richtofen_debug_off" );
            iprintlnbold( "<dev string:x385>" );
            return;
        }
        
        level.ee_richtofen.var_4f4d1954fb08ab = 1;
        iprintlnbold( "<dev string:x39c>" );
        
        if ( !utility::flag( #"hash_69f4598d347b7803" ) )
        {
            level.player thread function_cb6ed8534a92f413();
        }
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x30abdc68, Offset: 0x10ddc
    // Size: 0x2e, Type: dev
    function private function_a231218328d37f87()
    {
        level.player utility::callsharedfunc( #"loot_perks", #"hash_d60bebeaed508539", "<dev string:x3b2>", 0, 0 );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 1, eflags: 0x4
    // Checksum 0x72d49b18, Offset: 0x10e12
    // Size: 0x22e, Type: dev
    function private function_c619bb37acac2dd1( params )
    {
        level notify( #"door_zombie_debug" );
        
        if ( level.ee_richtofen.debug_zombies && level.ee_richtofen.debug_zombies.size > 0 )
        {
            foreach ( zombie in level.ee_richtofen.debug_zombies )
            {
                zombie zm_sat_locust_util::function_44f5bec4abb163f1( 1 );
            }
        }
        
        side_doors = zm_sat_locust_util::get_quest_reference( #"richtofen_side_doors" )[ int( params[ 0 ] ) - 1 ];
        
        foreach ( door in side_doors )
        {
            door side_door_close();
            
            foreach ( struct in door.linked_structs )
            {
                if ( struct.script_noteworthy == "<dev string:x3c2>" || struct.script_noteworthy == "<dev string:x3c9>" )
                {
                    var_7a65731f0e287ddc = door;
                    scene_node = struct;
                    continue;
                }
                
                var_30085f70fc117162 = struct;
            }
        }
        
        level thread function_15c478339d6d116e( var_7a65731f0e287ddc );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 1, eflags: 0x4
    // Checksum 0x625b01ac, Offset: 0x11048
    // Size: 0x1ab, Type: dev
    function private function_15c478339d6d116e( door )
    {
        level endon( #"door_zombie_debug" );
        
        foreach ( struct in door.linked_structs )
        {
            if ( struct.script_noteworthy == "<dev string:x3c2>" || struct.script_noteworthy == "<dev string:x3c9>" )
            {
                scene_node = struct;
                continue;
            }
            
            var_30085f70fc117162 = struct;
        }
        
        wait 0.4;
        door side_door_open();
        
        if ( !isdefined( level.ee_richtofen.debug_zombies ) )
        {
            level.ee_richtofen.debug_zombies = [];
        }
        
        params = { #forced_move_speed:"<dev string:x3dc>", #skip_eyes:1, #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:"<dev string:x3d0>" };
        zombie = zm_sat_locust_util::spawn_quest_zombie( params );
        
        if ( !zombie )
        {
            iprintlnbold( "<dev string:x3e3>" );
            return;
        }
        
        level.ee_richtofen.debug_zombies[ level.ee_richtofen.debug_zombies.size ] = zombie;
        scene_node thread scene::play( zombie, scene_node.script_noteworthy );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x76c17a3f, Offset: 0x111fb
    // Size: 0x98, Type: dev
    function private debug_dust_falling()
    {
        dust_falling_locs = zm_sat_locust_util::get_quest_reference( #"dust_falling" );
        
        foreach ( dust_falling in dust_falling_locs )
        {
            dust_falling setscriptablepartstate( "<dev string:x3f9>", "<dev string:x3fd>" );
        }
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0xcd0d0704, Offset: 0x1129b
    // Size: 0xc9, Type: dev
    function private function_5d05e96c89236ff4()
    {
        if ( level.ee_richtofen.dialog_playing )
        {
            iprintlnbold( "<dev string:x400>" );
            return;
        }
        
        level.player setorigin( ( 7257, 10299, 700 ) );
        level.player setplayerangles( ( 0, 0, 0 ) );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"richtofen_player" ) )
        {
            zm_sat_locust_util::function_222215ce3aef9da1( #"richtofen_player", level.player );
        }
        else
        {
            zm_sat_locust_util::function_295a36ef38f5acae( #"richtofen_player", level.player );
        }
        
        level.ee_richtofen.scene_cleaned_up = 0;
        level thread function_a1c12a5f67ef7e34( level.player );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 1, eflags: 0x4
    // Checksum 0x7fdea284, Offset: 0x1136c
    // Size: 0x52, Type: dev
    function private debug_play_gesture( params )
    {
        if ( params[ 0 ] == "<dev string:x418>" )
        {
            level.player thread play_outro_gesture( "<dev string:x41a>", "<dev string:x43d>" );
            return;
        }
        
        level.player thread play_outro_gesture( "<dev string:x466>", "<dev string:x48a>" );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 1, eflags: 0x4
    // Checksum 0xcef5fafa, Offset: 0x113c6
    // Size: 0x49, Type: dev
    function private function_b3c34b8f1f664141( params )
    {
        level.player thread function_347b9b0d161d82a8();
        wait 5;
        function_7a800b9feba79de( level.player, 0 );
        level.player setdemeanorviewmodel( "<dev string:x4b2>" );
    }

    // Namespace zm_sat_locust_ee_richtofen
    // Params 0, eflags: 0x4
    // Checksum 0x9196e7fc, Offset: 0x11417
    // Size: 0xab, Type: dev
    function private function_bfe12d6e827d4433()
    {
        if ( level.ee_richtofen.debug_camera_fx )
        {
            level.ee_richtofen.debug_camera_fx = 0;
            stopfxontagforclients( utility::getfx( "<dev string:x4b9>" ), level.player, "<dev string:x4ca>", level.player );
            iprintlnbold( "<dev string:x4d1>" );
            return;
        }
        
        level.ee_richtofen.debug_camera_fx = 1;
        playfxontagforclients( utility::getfx( "<dev string:x4b9>" ), level.player, "<dev string:x4ca>", level.player );
        iprintlnbold( "<dev string:x4df>" );
    }

#/
