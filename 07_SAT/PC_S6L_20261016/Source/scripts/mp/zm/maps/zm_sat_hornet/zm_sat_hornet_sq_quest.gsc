// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_sq_quest.gsc  (hash_4776c79129936205.gscc) (size: 48246 Bytes / 0xbc76 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83701ff (137822719)
// size ...... 48246 (0xbc76)
// includes .. 31  (offset: 0xac1a)
// strings ... 213 (offset: 0xad12)
// dev strs .. 9   (offset: 0xbc0a)
// exports ... 103 (offset: 0x73f2)
// cseg ...... 0x1196 + 0x625c (0x73f2)
// imports ... 283 (offset: 0x840a)
// animtree1 . 0   (offset: 0xbc76)
// animtree2 . 0   (offset: 0xbc76)
#using script_16ea1b94f0f381b3;
#using script_aa3bac81ad4fc8e;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\supers;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zombie_intel;

#namespace zm_sat_hornet_sq_quest;

// Namespace zm_sat_hornet_sq_quest
// Params 0, eflags: 0x5
// Checksum 0x70285404, Offset: 0x11b4
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hornet_sq_quest", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x29be318e, Offset: 0x11e1
// Size: 0x1a9
function function_7cf8dacb278a2665()
{
    toggle_zones( 0 );
    
    if ( !getdvarint( @"hash_a848de4270c1778d", 0 ) || zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level.hornet_sq_quest = zm_quest::get_quest( #"hornet_sq_quest" );
    zm_quest::register_quest_step( #"hornet_sq_quest", #"combat_1", &function_4e781ceb33acabf4, &function_b0489d7b00623f49 );
    zm_quest::register_quest_step( #"hornet_sq_quest", #"combat_2", &function_4e781feb33acb28d, &function_b0489a7b006238b0 );
    zm_quest::register_quest_step( #"hornet_sq_quest", #"combat_3", &function_4e781eeb33acb05a, &function_b0489b7b00623ae3 );
    zm_quest::register_quest_step( #"hornet_sq_quest", #"sq_exit", &function_4e7819eb33aca55b, &function_b048a07b006245e2 );
    callback::add( #"player_spawned", &function_ec2d4c99e7cfa7f8 );
    callback::add( #"grenade_fire", &function_cadf2d49d2505379 );
    callback::add( #"player_death", &function_b1f6637eef435b04 );
    callback::add( #"player_disconnect", &function_b1f6637eef435b04 );
    callback::add( #"player_laststand", &function_27ba57181c16731f );
    callback::add( #"player_laststand_revived", &function_dad37515d9a95f85 );
    callback::add( #"player_connect", &function_18009e53f7dfab76 );
    utility::registersharedfunc( #"zombie", #"hash_ec597a712c9bb135", &function_2923e4e60f984da );
    level.hornet_sq_quest.unique_xuids = [];
    
    /#
        level thread function_1240b5ea6a2c6924();
    #/
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x789c8a9, Offset: 0x1392
// Size: 0x70
function postmain_init()
{
    if ( !getdvarint( @"hash_a848de4270c1778d", 0 ) || game_utility::function_21211f3255f8ea58() || zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level thread function_bfad22a0d43eb483();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"sq", &function_c124f114472e4210 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"sq_start", &function_c24e9e42a87314c7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"sq_oni", &function_79ce990edf623413 );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xefb284fa, Offset: 0x140a
// Size: 0x55
function function_18009e53f7dfab76( params )
{
    xuid = self getxuid();
    var_bf436af334f022e6 = level.hornet_sq_quest.unique_xuids;
    
    if ( isdefined( var_bf436af334f022e6 ) )
    {
        if ( arraycontains( var_bf436af334f022e6, xuid ) )
        {
            self.var_6716a7bd8a14a48 = 1;
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x6d37dfbf, Offset: 0x1467
// Size: 0x28
function function_ec2d4c99e7cfa7f8( params )
{
    if ( isdefined( level.sq_sword ) )
    {
        level.sq_sword hidefromplayer( self );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xea2a84af, Offset: 0x1497
// Size: 0x48
function function_b1f6637eef435b04( params )
{
    if ( self == level.sq_player )
    {
        level utility::flag_set( "bro_done" );
        self.var_3be847287ab525d = undefined;
        wait 1;
        reset_sq();
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x611f09f2, Offset: 0x14e7
// Size: 0x45
function function_27ba57181c16731f( params )
{
    if ( self == level.sq_player )
    {
        level utility::flag_set( "bro_done" );
        self.var_26f437a4c6495be8 = 1;
        player_return( "downed" );
    }
    
    thread katana_reset();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x675a5625, Offset: 0x1534
// Size: 0x34
function function_dad37515d9a95f85( params )
{
    if ( isdefined( self.var_26f437a4c6495be8 ) )
    {
        self.var_26f437a4c6495be8 = undefined;
        waitframe();
        player_vals( 0 );
        function_ca72ec13bf33b972( 0 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x6a5b1616, Offset: 0x1570
// Size: 0xcf
function function_2923e4e60f984da( params )
{
    idamage = params.idamage;
    
    if ( isdefined( level.sq_player ) && level.sq_player == self )
    {
        if ( idamage > self.health && !isdefined( self.is_dead ) )
        {
            self.health = self.maxhealth;
            self.is_dead = 1;
            val::set( "progress", "damage", 0 );
            val::set( "progress", "death", 0 );
            val::set( "progress", "ignoreme", 1 );
            val::set( "progress", "freezecontrols", 1 );
            thread function_56648da1ef128b85();
            return 0;
        }
    }
    
    return idamage;
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xfa60456b, Offset: 0x1648
// Size: 0x4b
function function_bfad22a0d43eb483()
{
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "power_on" );
    function_75a9f496a1c29bb9();
    level thread setup_sq_trigger();
    level thread clip_manager();
    level thread zm_quest::start_quest( #"hornet_sq_quest" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x8480c582, Offset: 0x169b
// Size: 0x22
function function_4e781ceb33acabf4( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_sq_step_1" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x316231a9, Offset: 0x16c5
// Size: 0x22
function function_b0489d7b00623f49( b_skipped, b_save_restored )
{
    level utility::flag_set( "completed_sq_step_1" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x8480c582, Offset: 0x16ef
// Size: 0x22
function function_4e781feb33acb28d( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_sq_step_2" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x316231a9, Offset: 0x1719
// Size: 0x22
function function_b0489a7b006238b0( b_skipped, b_save_restored )
{
    level utility::flag_set( "completed_sq_step_2" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x8480c582, Offset: 0x1743
// Size: 0x22
function function_4e781eeb33acb05a( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_sq_step_3" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x316231a9, Offset: 0x176d
// Size: 0x22
function function_b0489b7b00623ae3( b_skipped, b_save_restored )
{
    level utility::flag_set( "completed_sq_step_3" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x8480c582, Offset: 0x1797
// Size: 0x22
function function_4e7819eb33aca55b( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_sq_step_4" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x316231a9, Offset: 0x17c1
// Size: 0x22
function function_b048a07b006245e2( b_skipped, b_save_restored )
{
    level utility::flag_set( "completed_sq_step_4" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xc90e31ef, Offset: 0x17eb
// Size: 0x192
function function_12b8971e4f39a73f()
{
    level endon( #"sq_over" );
    level utility::waittill_any( "hornet_mq_bossfight_fasttravel_started", "hornet_mq_onryo_fight_fasttravel_started" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player unlink();
        level.sq_player function_ca72ec13bf33b972( 0 );
        level.sq_player player_vals( 0 );
        level.sq_player function_ea288a1204994a5b( 0 );
        level.sq_player set_combat_hud( 0 );
        level.sq_player setscriptablepartstate( "hornet_sq_audio", "deactivate" );
        level.sq_player player::hideminimap( 0 );
        level musicbank_utility::function_4f253fd35ec68cbc( level.sq_player );
        function_895ffaf5f35e0f3d( 0 );
        deactivateworldevent( "we_vfx_camera_motes" );
        
        if ( level.sq_player.var_15598453bb30f76e )
        {
            level.sq_player setcamerathirdperson( 1 );
            level.sq_player setclientomnvar( "ui_toggle_third_person", 1 );
        }
        
        level.sq_player val::reset_all( "sq_hud" );
        level.sq_player val::reset_all( "sq_transition" );
        level.sq_player set_screen_fx( 0, "cer_zm_ruby_echoes_cave_intro" );
        level.sq_player set_screen_fx( 0, "cer_zm_ruby_echoes_cave" );
        level.sq_player setscriptablepartstate( "hornet_sq", "camera_off" );
        level thread game_utility::fadetoblackforplayer( level.sq_player, 0, 0.5 );
    }
    
    reset_sq();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x39a55e34, Offset: 0x1985
// Size: 0x8f
function toggle_zones( var_6fb860f7c9723d4e )
{
    var_a77bb00f025e9731 = get_takeo_zones();
    
    foreach ( var_4cdafb4532dd9de4 in var_a77bb00f025e9731 )
    {
        zone_manager::set_zone_enabled( var_4cdafb4532dd9de4, var_6fb860f7c9723d4e );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x11a73896, Offset: 0x1a1c
// Size: 0x4a
function setup_sq_trigger()
{
    var_cc9dbb3fbaaec44e = utility::getstruct( "sq_trigger_item" );
    level.sq_sword = utility::spawn_model( "sat_wm_me_elnath", var_cc9dbb3fbaaec44e.origin, var_cc9dbb3fbaaec44e.angles );
    katana_hide();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x9553be11, Offset: 0x1a6e
// Size: 0x3dd
function function_7972f90ff57fc45( player )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    if ( isdefined( level.sq_sword ) )
    {
        level.sq_sword endon( #"death" );
    }
    
    player endon( #"death" );
    var_359cad62d73f79e5 = player killstreak_utility::get_using_killstreaks();
    
    if ( self.b_interacted || player.interactions_disabled || !player namespace_c0b4f2882c9d100f::is_takeo() || !zm_player::function_f37cfdf04b932a03( player ) || player.var_6716a7bd8a14a48 || var_359cad62d73f79e5.size || level utility::flag( "mq_step_36_complete" ) )
    {
        return;
    }
    
    if ( level utility::flag( "solo_game" ) )
    {
        zm_quest::function_4eefe6de31f5ddab( #"hornet_sq_quest", #"sq_done", 1 );
    }
    
    level thread function_12b8971e4f39a73f();
    level.sq_player = player;
    player.var_6716a7bd8a14a48 = 1;
    player.b_ignore_powerups = 1;
    player.v_org = player.origin;
    player.v_ang = player.angles;
    xuid = player getxuid();
    level.hornet_sq_quest.unique_xuids[ level.hornet_sq_quest.unique_xuids.size ] = xuid;
    
    if ( !player.b_cheat )
    {
        self.b_interacted = 1;
    }
    
    if ( isdefined( player.bgb_hellping_hound ) )
    {
        var_e97a4f4962bc3f25 = player bgb::get_bgb_slot( "helping_hound" );
        
        if ( isdefined( var_e97a4f4962bc3f25 ) )
        {
            player bgb::take( var_e97a4f4962bc3f25 );
        }
    }
    
    player val::set( "squest", "show_hud", 0 );
    s_start = utility::getstruct( "transition_start" );
    player predictstreamposuntilcleared( s_start.origin );
    player function_ca72ec13bf33b972( 1 );
    player forceweaponinspect();
    player player_vals( 1 );
    level.var_37cf7e3cad2ca8b6 = zm_utility::get_round_number();
    
    if ( level.var_37cf7e3cad2ca8b6 < 15 )
    {
        level.var_37cf7e3cad2ca8b6 = 15;
    }
    
    level utility::flag_set( "sq_triggered" );
    
    if ( !player.b_cheat && isdefined( level.sq_sword ) )
    {
        level.sq_sword hide();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( player, #"takeo_sq_intro" );
    wait 0.5;
    level utility::flag_set( "twins_dialogue_playing" );
    player dialogue::say_dialogue( "dx_zm_hoss_htsd_scar_tsdkain", [ player ] );
    level utility::flag_clear( "twins_dialogue_playing" );
    player setscriptablepartstate( "hornet_sq_audio", "active" );
    wait 0.25;
    game_utility::fadetoblackforplayer( player, 1, 0.5 );
    wait 1;
    toggle_zones( 1 );
    function_895ffaf5f35e0f3d( 1 );
    level thread setup_trees();
    
    if ( !player.b_cheat )
    {
        katana_hide();
    }
    
    player sq_transition();
    player player_vals( 0 );
    player function_ea288a1204994a5b( 1 );
    player player::hideminimap( 1 );
    player setscriptablepartstate( "hornet_sq_audio", "active_noloop" );
    game_utility::fadetoblackforplayer( player, 0, 1 );
    level musicbank_utility::function_5aca66c390aa347d( player, #"hash_108f6647f760ce7f" );
    player thread player_progression();
    t_return = getent( "t_return", "targetname" );
    t_return thread walljump_watcher();
    player clearpredictedstreampos();
    
    if ( !player.b_cheat && isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x1af6e293, Offset: 0x1e53
// Size: 0xc8
function function_895ffaf5f35e0f3d( var_b0e144194be51c26 )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( level.sq_player ) && level.sq_player != player )
        {
            if ( var_b0e144194be51c26 )
            {
                level.sq_player hidefromplayer( player );
                continue;
            }
            
            level.sq_player showtoplayer( player );
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xc24c368b, Offset: 0x1f23
// Size: 0x2a
function set_combat_hud( var_b0e144194be51c26 )
{
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_zm_is_bear_attack_quest", var_b0e144194be51c26 );
        self setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x4b4cce1b, Offset: 0x1f55
// Size: 0x1be
function player_vals( var_b0e144194be51c26 )
{
    if ( var_b0e144194be51c26 )
    {
        val::set( "squest", "auto_pickup", 0 );
        val::set( "squest", "crouch", 0 );
        val::set( "squest", "allow_last_stand", 0 );
        val::set( "squest", "allow_battlechatter_vo", 0 );
        val::set( "squest", "damage", 0 );
        val::set( "squest", "death", 0 );
        val::set( "squest", "interactions", 0 );
        val::set( "squest", "item_pickup", 0 );
        val::set( "squest", "killstreaks", 0 );
        val::set( "squest", "melee", 0 );
        val::set( "squest", "allow_movement", 0 );
        val::set( "squest", "offhand_weapons", 0 );
        val::set( "squest", "allow_ping", 0 );
        val::set( "squest", "prone", 0 );
        val::set( "squest", "allow_scripted_bgb_use", 0 );
        val::set( "squest", "supers", 0 );
        val::set( "squest", "fire", 0 );
        val::set( "squest", "weapon_pickup", 0 );
        val::set( "squest", "ignoreme", 1 );
        val::set( "squest", "ignore_playable_area_check", 1 );
        val::set( "squest", "round_spawning_ignore_player", 1 );
        
        if ( utility::ent_flag( "field_upgrade_in_use" ) )
        {
            supers_mp::superusefinished();
        }
        
        return;
    }
    
    val::reset_all( "squest" );
    val::reset_all( "focus" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xadd62f96, Offset: 0x211b
// Size: 0xb1
function function_ea288a1204994a5b( var_b0e144194be51c26 )
{
    if ( var_b0e144194be51c26 )
    {
        val::set( "progress", "allow_battlechatter_vo", 0 );
        val::set( "progress", "item_pickup", 0 );
        val::set( "progress", "allow_last_stand", 0 );
        val::set( "progress", "killstreaks", 0 );
        val::set( "progress", "allow_ping", 0 );
        val::set( "progress", "allow_scripted_bgb_use", 0 );
        val::set( "progress", "supers", 0 );
        val::set( "progress", "round_spawning_ignore_player", 1 );
        return;
    }
    
    val::reset_all( "progress" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x1ab9f427, Offset: 0x21d4
// Size: 0x378
function sq_transition()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    activateworldevent( "we_vfx_camera_motes" );
    s_start = utility::getstruct( "transition_start" );
    var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", s_start.origin, s_start.angles );
    var_15598453bb30f76e = self getcamerathirdperson();
    
    if ( var_15598453bb30f76e )
    {
        self.var_15598453bb30f76e = 1;
        self setcamerathirdperson( 0 );
        self setclientomnvar( "ui_toggle_third_person", 0 );
    }
    
    val::set( "sq_transition", "allow_toggle_third_person", 0 );
    val::set( "sq_transition", "freezecontrols", 1 );
    val::set( "sq_transition", "freezecontrols_allowlook", 1 );
    sc_teleport = spawnscriptable( %"zm_sat_hornet_sq_vfx", self.origin );
    sc_teleport setscriptablepartstate( "visual", "sq_teleport" );
    val::set( "sq_hud", "show_hud", 0 );
    val::set( "squest", "weapon", 0 );
    
    if ( !self.b_cheat )
    {
        self setorigin( var_2b0c20cebe23ba0b.origin );
        self setplayerangles( var_2b0c20cebe23ba0b.angles );
        self playerlinktodelta( var_2b0c20cebe23ba0b, "tag_origin", 0, 0, 0, 0, 0 );
        path = [ s_start.origin ];
        
        for ( node = s_start; isdefined( node.target ) ; node = var_c27efcf4d873bd51 )
        {
            var_c27efcf4d873bd51 = utility::getstruct( node.target );
            path[ path.size ] = var_c27efcf4d873bd51.origin;
        }
        
        level thread function_abf257f0b9587bc2( 1 );
    }
    
    wait 1;
    sc_teleport freescriptable();
    set_screen_fx( 1, "cer_zm_ruby_echoes_cave_intro" );
    
    if ( !self.b_cheat )
    {
        level utility::flag_set( "twins_dialogue_playing" );
        level thread overlord::playconversation( #"hash_fd53a89739d5404a", [ self ] );
    }
    
    level thread game_utility::fadetoblackforplayer( self, 0, 0.5 );
    
    if ( !self.b_cheat )
    {
        var_2b0c20cebe23ba0b thread utility::function_2159dd4196ff4b81( path, 37, 1, 0, 0, 1 );
        wait 37 - 1.5;
    }
    
    level utility::flag_set( "transition_outro" );
    game_utility::fadetoblackforplayer( self, 1, 1 );
    wait 2;
    level utility::flag_set( "transition_done" );
    
    if ( self.var_15598453bb30f76e )
    {
        self setcamerathirdperson( 1 );
        self setclientomnvar( "ui_toggle_third_person", 1 );
    }
    
    level thread function_abf257f0b9587bc2( 0 );
    val::reset( "sq_transition", "allow_toggle_third_person" );
    val::reset( "sq_transition", "freezecontrols" );
    val::reset( "sq_transition", "freezecontrols_allowlook" );
    
    if ( isdefined( var_2b0c20cebe23ba0b ) )
    {
        var_2b0c20cebe23ba0b delete();
    }
    
    var_ed100f9a07836d02 = utility::getstruct( "sq_pos" );
    self setorigin( var_ed100f9a07836d02.origin );
    self setplayerangles( var_ed100f9a07836d02.angles );
    set_screen_fx( 0, "cer_zm_ruby_echoes_cave_intro" );
    set_screen_fx( 1, "cer_zm_ruby_echoes_cave" );
    val::reset( "squest", "weapon" );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2, eflags: 0x4
// Checksum 0xee9585a6, Offset: 0x2554
// Size: 0x1db
function private function_c473ef2ca3032767( n_fade_out_time = 0.5, n_fade_in_time = 0.5 )
{
    self endon( #"death_or_disconnect" );
    self playsoundtoplayer( "evt_power_on_white_out", self );
    
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
    }
    
    n_target_alpha = 0.8;
    self.white_screen_overlay fadeovertime( n_fade_out_time );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait 1;
    self.white_screen_overlay fadeovertime( n_fade_in_time );
    self.white_screen_overlay.alpha = 0;
    wait n_fade_in_time;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 2, eflags: 0x4
// Checksum 0xd8708592, Offset: 0x2737
// Size: 0x2d
function private set_screen_fx( b_is_on, str_bundle )
{
    if ( b_is_on )
    {
        pbgpostfxbundlestart( self, str_bundle );
        return;
    }
    
    pbgpostfxbundleend( self, str_bundle );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0xb8f5f730, Offset: 0x276c
// Size: 0x40
function sq_hint( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x7f99dc55, Offset: 0x27b5
// Size: 0x2a9
function function_ca72ec13bf33b972( var_6a8390f12c65981d )
{
    self endon( #"death" );
    
    if ( var_6a8390f12c65981d )
    {
        n_rarity = 4;
        var_951c89546ec50477 = 3;
        self.current_weapon = self.currentweapon;
        zm_utility::function_d47920bb0d5fa327( "hornet_sqquest_swordswitch" );
        zm_utility::function_92275a9d3969d91d();
        spawnoptions = common_item::function_bc5ff2958b71a708( self.origin );
        var_298fe7dcdb17fe4f = [];
        var_298fe7dcdb17fe4f[ "perks" ] = [];
        
        foreach ( perk in self.perks_active )
        {
            data = { #permanent:self.perma_perks && arraycontains( self.perma_perks, perk ), #bought:self.perkspurchased && self.perkspurchased[ perk ], #ref:perk };
            var_298fe7dcdb17fe4f[ "perks" ][ var_298fe7dcdb17fe4f[ "perks" ].size ] = data;
        }
        
        zombie_perks::take_all_perks( 1 );
        self.var_298fe7dcdb17fe4f = var_298fe7dcdb17fe4f;
        wait 0.5;
        weapon = makeweapon( %"sat_me_elnath_mp", [ "sat_rec_me_elnath_dissolve" ] );
        item_weapon::function_96add18b226ff731( weapon );
        item_weapon::function_40e1cbd0e1f47d1a( weapon, n_rarity );
        self switchtoweapon( weapon );
        self.weap_katana = weapon;
        return;
    }
    
    if ( !isdefined( self.var_26f437a4c6495be8 ) )
    {
        self.weap_katana = undefined;
        
        if ( isdefined( self.var_298fe7dcdb17fe4f[ "perks" ] ) )
        {
            foreach ( perk in self.var_298fe7dcdb17fe4f[ "perks" ] )
            {
                zombie_perks::give_perk( perk.ref, perk.bought, 0, undefined, perk.permanent );
                waitframe();
            }
        }
        
        if ( self.a_saved_weapons )
        {
            zm_utility::function_663d59490abc834f( self.current_weapon );
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xb27f0831, Offset: 0x2a66
// Size: 0x9e
function get_takeo_zones()
{
    var_aa6a7d050293c5f2 = [];
    
    foreach ( zone_name, zone_struct in level.zone_manager.inited_defs )
    {
        if ( issubstr( zone_name, "takeo" ) )
        {
            var_aa6a7d050293c5f2[ var_aa6a7d050293c5f2.size ] = zone_name;
        }
    }
    
    return var_aa6a7d050293c5f2;
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x39177d5, Offset: 0x2b0d
// Size: 0x84
function function_75a9f496a1c29bb9()
{
    var_a77bb00f025e9731 = get_takeo_zones();
    
    foreach ( var_4cdafb4532dd9de4 in var_a77bb00f025e9731 )
    {
        zone_spawner::function_2ce7db1d59b307d8( var_4cdafb4532dd9de4 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x714d6bfc, Offset: 0x2b99
// Size: 0x21c
function player_progression()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    level.sq_hellhounds = [];
    level.var_d1a317e0dabbfa14 = 0;
    level.sq_scorch = [];
    level.var_f11a1936aefc000c = 0;
    level.sq_samurai = [];
    level.var_733b43b2c0ebf766 = 0;
    s_center = utility::getstruct( "arena_1_center" );
    s_spawn = utility::getstructarray( "arena_1_spawn_1st" );
    var_c04fe6401200c960 = utility::getstructarray( "arena_1_spawn" );
    thread vo_progression();
    thread function_ec810f013ce9dc70( getdvarint( @"hash_df46a6be68bff5bf", 90 ) );
    function_c30b8aba4384e71a( s_center );
    set_combat_hud( 1 );
    zombie_spawns( s_spawn, "zombie_hellhound" );
    wait 1.5;
    level thread hellhound_arena_fire();
    zombie_spawns( var_c04fe6401200c960, "zombie_hellhound" );
    level thread hellhound_attack();
    
    while ( true )
    {
        if ( !level.var_d1a317e0dabbfa14 )
        {
            level utility::flag_set( "hellhounds_done" );
            level utility::flag_set( "completed_sq_step_1" );
            break;
        }
        
        wait 1;
    }
    
    s_center = utility::getstruct( "arena_2_center" );
    function_c30b8aba4384e71a( s_center );
    level notify( #"end_timer" );
    thread function_ec810f013ce9dc70( getdvarint( @"hash_df46a7be68bff7f2", 120 ) );
    set_combat_hud( 1 );
    activateworldevent( "we_vfx_zm_hornet_sq_spaces_ambient" );
    function_5d3f74a19fde0a77();
    
    while ( true )
    {
        if ( !level.var_f11a1936aefc000c )
        {
            level utility::flag_set( "scorch_done" );
            level utility::flag_set( "completed_sq_step_2" );
            break;
        }
        
        wait 1;
    }
    
    s_center = utility::getstruct( "arena_3_center" );
    function_c30b8aba4384e71a( s_center );
    level utility::flag_set( "final_battle" );
    level notify( #"end_timer" );
    thread function_ec810f013ce9dc70( getdvarint( @"hash_df46a8be68bffa25", 240 ) );
    level thread takeshi_samurai();
    set_combat_hud( 1 );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x29ed5a67, Offset: 0x2dbd
// Size: 0x97
function function_c30b8aba4384e71a( s_center )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    var_92b21ca8efb6aef2 = squared( s_center.radius );
    
    while ( distance2dsquared( self.origin, s_center.origin ) >= var_92b21ca8efb6aef2 )
    {
        wait 1;
    }
    
    if ( isdefined( s_center.script_noteworthy ) )
    {
        level utility::flag_set( s_center.script_noteworthy );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x5f96c3ba, Offset: 0x2e5c
// Size: 0x1a1
function zombie_spawns( var_c04fe6401200c960, var_ff75798b22968d50 )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    if ( isstruct( var_c04fe6401200c960 ) )
    {
        var_c04fe6401200c960 = [ var_c04fe6401200c960 ];
    }
    
    for ( i = 0; i < var_c04fe6401200c960.size ; i++ )
    {
        var_ea616919227739f = agent_manager::spawn_agent( var_ff75798b22968d50, var_c04fe6401200c960[ i ].origin, var_c04fe6401200c960[ i ].angles, "team_two_hundred" );
        
        if ( isdefined( var_ea616919227739f ) )
        {
            var_ea616919227739f thread zombie_values();
            var_ea616919227739f thread function_b31cd313e8893e77();
            
            if ( var_ff75798b22968d50 == "zombie_hellhound" )
            {
                level.sq_hellhounds[ level.sq_hellhounds.size ] = var_ea616919227739f;
                var_ea616919227739f thread hellhound_death_watcher();
                var_ea616919227739f thread hellhound_entrance( var_c04fe6401200c960[ i ] );
                level.var_d1a317e0dabbfa14++;
                wait 0.75;
            }
            else if ( var_ff75798b22968d50 == "zombie_base_armored_agni" )
            {
                level.sq_scorch[ level.sq_scorch.size ] = var_ea616919227739f;
                level.var_f11a1936aefc000c++;
                var_ea616919227739f thread zombie_spawn_animation( var_c04fe6401200c960[ i ] );
                var_ea616919227739f thread scorch_death_watcher();
            }
            else if ( var_ff75798b22968d50 == "sat_spawner_zombie_base_zm_hornet_sq_samurai" )
            {
                level.sq_samurai[ level.sq_samurai.size ] = var_ea616919227739f;
                level.var_733b43b2c0ebf766++;
                var_ea616919227739f thread zombie_spawn_animation( var_c04fe6401200c960[ i ] );
                var_ea616919227739f thread katana_attach();
                var_ea616919227739f thread samurai_death_watcher();
                var_ea616919227739f zombie_utils::function_a8ce00e0448cb6f0( "run", "sq", 6 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x20ed9d5c, Offset: 0x3005
// Size: 0x26
function hellhound_spawn_fx( s_spawn )
{
    s_spawn.script_animation = "spawn";
    zone_spawner::function_ce10e453e7f7bb8e( s_spawn );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x5f5e7ac3, Offset: 0x3033
// Size: 0xc8
function hellhound_entrance( s_spawn )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    hellhound_spawn_fx( s_spawn );
    thread hellhound_behavior( s_spawn );
    var_be17fae8e83d6e7b = utility::getstruct( s_spawn.target );
    self setgoalpos( var_be17fae8e83d6e7b.origin, 8 );
    self waittill( #"goal " );
    self.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self linkto( self.var_2b0c20cebe23ba0b );
    waitframe();
    wait 1.5;
    thread hellhound_face();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x73423268, Offset: 0x3103
// Size: 0x86
function hellhound_behavior( s_spawn )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    zombie_utils::function_a8ce00e0448cb6f0( "run", "side_quest", 99 );
    thread function_3261700c9e39ad9c( s_spawn );
    self waittill( #"attack" );
    utility::ent_flag_set( "attack" );
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b delete();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x4d5d87ce, Offset: 0x3191
// Size: 0x10f
function hellhound_face()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"attack", #"death" );
    self.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self linkto( self.var_2b0c20cebe23ba0b );
    
    while ( true )
    {
        if ( utility::ent_flag( "attack" ) || level utility::flag( "attack" ) )
        {
            break;
        }
        
        v_face = vectortoangles( level.sq_player.origin - self.var_2b0c20cebe23ba0b.origin );
        self.var_2b0c20cebe23ba0b rotateto( v_face, 0.1 );
        self.var_2b0c20cebe23ba0b waittill( #"rotatedone" );
    }
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b delete();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x14933bde, Offset: 0x32a8
// Size: 0x34
function hellhound_death_watcher()
{
    self waittill( #"death" );
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b delete();
    }
    
    level.var_d1a317e0dabbfa14--;
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xf72a8a7e, Offset: 0x32e4
// Size: 0xd0
function function_3261700c9e39ad9c( s_spawn )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death", #"attack" );
    var_be17fae8e83d6e7b = utility::getstruct( s_spawn.target );
    var_92b21ca8efb6aef2 = squared( var_be17fae8e83d6e7b.radius );
    
    while ( true )
    {
        if ( isdefined( level.sq_player ) && distance2dsquared( self.origin, level.sq_player.origin ) <= var_92b21ca8efb6aef2 )
        {
            level utility::flag_set( "attack" );
            self notify( #"attack" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xbefd5839, Offset: 0x33bc
// Size: 0x92
function hellhound_attack()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    level.sq_hellhounds = arrayrandomize( level.sq_hellhounds );
    
    for ( i = 0; i < level.sq_hellhounds.size ; i++ )
    {
        wait randomfloatrange( 1.5, 2.5 );
        
        if ( isalive( level.sq_hellhounds[ i ] ) )
        {
            level.sq_hellhounds[ i ] notify( #"attack" );
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xc852b147, Offset: 0x3456
// Size: 0x156
function hellhound_arena_fire( v_org )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    wait 1;
    level.var_92f81be3ffbd28a9 utility::function_32b24db3127bff40( "visual", "fire_loop" );
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_01" );
    level thread arena_fire_damage( 1, 1 );
    wait 2;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_02" );
    level thread arena_fire_damage( 1, 2 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_10" );
    level thread arena_fire_damage( 1, 10 );
    wait 1.5;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_03" );
    level thread arena_fire_damage( 1, 3 );
    wait 0.1;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_09" );
    level thread arena_fire_damage( 1, 9 );
    wait 2;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_04" );
    level thread arena_fire_damage( 1, 4 );
    wait 0.2;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_08" );
    level thread arena_fire_damage( 1, 8 );
    wait 1.5;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_07" );
    level thread arena_fire_damage( 1, 7 );
    wait 0.1;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_05" );
    level thread arena_fire_damage( 1, 5 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_1_fire_06" );
    level thread arena_fire_damage( 1, 6 );
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0xce8edb54, Offset: 0x35b4
// Size: 0x14e
function arena_fire_damage( n_arena, var_b61e464adec53205 )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over", "stop_fire_" + n_arena );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player endon( #"death" );
    }
    
    s_fire = utility::getstruct( "arena_" + n_arena + "_fire_" + var_b61e464adec53205 );
    
    if ( !isdefined( s_fire ) )
    {
        return;
    }
    
    n_radius = squared( s_fire.radius );
    
    while ( level.sq_player && s_fire )
    {
        if ( distance2dsquared( level.sq_player.origin, s_fire.origin ) < n_radius && !level.sq_player player::isinlaststand() )
        {
            level.sq_player utility::function_32b24db3127bff40( "burning", "active" );
            level.sq_player effect_burn::burn( 1, 50, 1, s_fire, "arena_fire" );
        }
        else
        {
            level.sq_player utility::function_32b24db3127bff40( "burning", "neutral" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xeb97e9a8, Offset: 0x370a
// Size: 0x11f
function arena_fire_exit()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"stop_fire" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player endon( #"death" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    n_radius = squared( self.radius );
    
    while ( true )
    {
        if ( distance2dsquared( level.sq_player.origin, self.origin ) < n_radius && !level.sq_player player::isinlaststand() && isdefined( level.sq_player ) && isdefined( self ) )
        {
            level.sq_player utility::function_32b24db3127bff40( "burning", "active" );
            level.sq_player effect_burn::burn( 1, 50, 1, self, "arena_fire" );
        }
        else
        {
            level.sq_player utility::function_32b24db3127bff40( "burning", "neutral" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x86290483, Offset: 0x3831
// Size: 0x2d3
function function_5d3f74a19fde0a77()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    a_s_fire = utility::getstructarray( "arena_fire_approach" );
    s_center_2 = utility::getstruct( "arena_2_center" );
    var_c04fe6401200c960 = utility::getstructarray( "arena_2_spawn" );
    a_s_scorch = utility::getstructarray( "arena_2_spawn_reinforce" );
    level utility::flag_wait( s_center_2.script_noteworthy );
    
    foreach ( s_fire in a_s_fire )
    {
        s_fire.var_be17fae8e83d6e7b = utility::getstruct( s_fire.target );
        s_fire.e_mover = utility::spawn_model( "tag_origin", s_fire.origin, s_fire.angles );
        s_fire.sc_fire = spawnscriptable( %"zm_sat_hornet_sq_vfx", s_fire.origin, s_fire.angles );
        s_fire.sc_fire utility::function_32b24db3127bff40( "visual", "fire_exit" );
        s_fire.sc_fire utility::scriptable_setparententity( s_fire.e_mover );
        s_fire.e_mover moveto( s_fire.var_be17fae8e83d6e7b.origin, 6 );
        s_fire.sc_fire thread free_on_notify( "scorch_vo", 3 );
    }
    
    wait 2.5;
    level thread scorch_arena_fire();
    zombie_spawns( var_c04fe6401200c960, "zombie_base_armored_agni" );
    level utility::flag_set( "scorch_vo" );
    
    foreach ( s_fire in a_s_fire )
    {
        s_fire.e_mover delete();
    }
    
    level.var_92f818e3ffbd2210 setscriptablepartstate( "visual", "fire_loop" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player thread function_bb719f86dc63c1be();
    }
    
    wait 5;
    zombie_spawns( a_s_scorch, "zombie_base_armored_agni" );
    level utility::flag_set( "scorch_reinforce" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xf24ddbca, Offset: 0x3b0c
// Size: 0x1fc
function scorch_arena_fire()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_16" );
    level thread arena_fire_damage( 2, 16 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_15" );
    level thread arena_fire_damage( 2, 15 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_01" );
    level thread arena_fire_damage( 2, 1 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_14" );
    level thread arena_fire_damage( 2, 14 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_02" );
    level thread arena_fire_damage( 2, 2 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_13" );
    level thread arena_fire_damage( 2, 13 );
    wait 1;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_03" );
    level thread arena_fire_damage( 2, 3 );
    level utility::flag_wait( "scorch_reinforce" );
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_12" );
    level thread arena_fire_damage( 2, 12 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_04" );
    level thread arena_fire_damage( 2, 4 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_11" );
    level thread arena_fire_damage( 2, 11 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_05" );
    level thread arena_fire_damage( 2, 5 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_10" );
    level thread arena_fire_damage( 2, 10 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_06" );
    level thread arena_fire_damage( 2, 6 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_09" );
    level thread arena_fire_damage( 2, 9 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_07" );
    level thread arena_fire_damage( 2, 7 );
    wait 0.25;
    activateworldevent( "we_vfx_hornet_sq_arena_2_fire_08" );
    level thread arena_fire_damage( 2, 8 );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player thread function_2424ff5825b058d8();
        level.sq_player thread player_wall_jump();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xe311798f, Offset: 0x3d10
// Size: 0x1ad
function function_abf257f0b9587bc2( var_b0e144194be51c26 )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    if ( var_b0e144194be51c26 )
    {
        wait 18;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_08" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_07" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_09" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_06" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_10" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_10" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_05" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_11" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_04" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_12" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_03" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_13" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_02" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_14" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_01" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_15" );
        wait 0.65;
        activateworldevent( "we_vfx_hornet_sq_arena_2_fire_16" );
        return;
    }
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player setscriptablepartstate( "hornet_sq", "camera_off" );
    }
    
    for ( i = 1; i < 17 ; i++ )
    {
        if ( i < 10 )
        {
            deactivateworldevent( "we_vfx_hornet_sq_arena_2_fire_0" + i );
            continue;
        }
        
        deactivateworldevent( "we_vfx_hornet_sq_arena_2_fire_" + i );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x886f5db8, Offset: 0x3ec5
// Size: 0xad
function function_2424ff5825b058d8()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    self setscriptablepartstate( "hornet_sq", "engulfed" );
    t_fire_exit = getent( "t_fire_exit", "targetname" );
    
    while ( true )
    {
        t_fire_exit waittill( #"trigger", ent );
        
        if ( ent == self && !isdefined( ent.var_d983df8c03accc75 ) )
        {
            ent.var_d983df8c03accc75 = 1;
            self setscriptablepartstate( "hornet_sq", "camera_off" );
            return;
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xdf480db7, Offset: 0x3f7a
// Size: 0xa3
function player_wall_jump()
{
    level endon( #"wall_jump", #"sq_over", #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started" );
    self endon( #"death" );
    t_wall_jump = getent( "t_wall_jump", "targetname" );
    
    while ( true )
    {
        t_wall_jump waittill( #"trigger", ent );
        
        if ( ent == self && !isdefined( ent.b_walljump ) )
        {
            ent.b_walljump = 1;
            level utility::flag_set( "wall_jump" );
            return;
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xf5f3507, Offset: 0x4025
// Size: 0x19
function scorch_death_watcher()
{
    self waittill( #"death" );
    level.var_f11a1936aefc000c--;
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xc3dadabb, Offset: 0x4046
// Size: 0x128
function takeshi_samurai()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    level.a_v_spots = [];
    var_c04fe6401200c960 = utility::getstructarray( "arena_3_spawn" );
    zombie_spawns( var_c04fe6401200c960, "sat_spawner_zombie_base_zm_hornet_sq_samurai" );
    wait 5;
    var_c04fe6401200c960 = utility::getstructarray( "arena_3_reinforce" );
    zombie_spawns( var_c04fe6401200c960, "sat_spawner_zombie_base_zm_hornet_sq_samurai" );
    level.var_ad15c4e8c7178e23 = var_c04fe6401200c960.size;
    level utility::flag_wait( "samurai_done" );
    wait 2;
    level utility::flag_clear( "samurai_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.sq_player, #"takeo_sq_battle" );
    
    foreach ( var_b4ccff30d877fa31 in level.a_v_spots )
    {
        level thread function_ec2ad5103ddddef1( var_b4ccff30d877fa31 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xa4e95111, Offset: 0x4176
// Size: 0xde
function function_ec2ad5103ddddef1( var_b4ccff30d877fa31 )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    var_7eeca3426600cbba = utility::spawn_model( "tag_origin", var_b4ccff30d877fa31, ( 0, 0, 0 ) );
    var_7eeca3426600cbba.sc_fx = spawnscriptable( %"zm_sat_hornet_pap_fx", var_7eeca3426600cbba.origin, var_7eeca3426600cbba.angles );
    waitframe();
    var_7eeca3426600cbba.sc_fx utility::function_32b24db3127bff40( "visual", "katana_spawn" );
    var_7eeca3426600cbba.sc_fx utility::scriptable_setparententity( var_7eeca3426600cbba );
    wait 1;
    var_7eeca3426600cbba.sc_fx utility::function_32b24db3127bff40( "visual", "katana_trail" );
    wait 0.5;
    var_7eeca3426600cbba thread function_61ecd43ef1c7521();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xb114db3a, Offset: 0x425c
// Size: 0xcd
function function_61ecd43ef1c7521()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over", #"hash_73fd3c03e7171417" );
    var_f59f629951d5c376 = utility::getstruct( "sq_boss" );
    self movez( 60, 2 );
    self waittill( #"movedone" );
    wait randomfloatrange( 1, 1.5 );
    self moveto( var_f59f629951d5c376.origin + ( 0, 0, 40 ), 1 );
    self waittill( #"movedone" );
    self.sc_fx freescriptable();
    self delete();
    level.var_ad15c4e8c7178e23--;
    
    if ( !level.var_ad15c4e8c7178e23 )
    {
        level thread takeshi_coalesce();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x98c72170, Offset: 0x4331
// Size: 0x265
function takeshi_coalesce()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over", #"hash_73fd3c03e7171417" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player endon( #"death" );
    }
    
    s_spawn = utility::getstruct( "sq_boss" );
    
    if ( isdefined( level.sq_player ) )
    {
        v_face = vectortoangles( level.sq_player.origin - s_spawn.origin );
    }
    else
    {
        v_face = s_spawn.angles;
    }
    
    level.mdl_katana = utility::spawn_model( %"sat_wm_me_elnath", s_spawn.origin + ( 0, 0, 40 ), v_face );
    sc_fx = spawnscriptable( %"zm_sat_hornet_sq_vfx", level.mdl_katana.origin + ( 0, 0, 20 ) );
    waitframe();
    sc_fx setscriptablepartstate( "visual", "onryo_spawn" );
    v_face = vectortoangles( vectornormalize( level.sq_player.origin - s_spawn.origin ) );
    v_face = ( 0, v_face[ 1 ], 0 );
    var_ea616919227739f = agent_manager::spawn_agent( "zombie_orion_hvt_sq", s_spawn.origin, v_face, "team_two_hundred" );
    
    if ( isdefined( var_ea616919227739f ) )
    {
        var_ea616919227739f.is_takeshi = 1;
        var_ea616919227739f zombie_utils::set_zombie_round_difficulty( level.var_37cf7e3cad2ca8b6 );
        var_ea616919227739f thread function_b31cd313e8893e77();
        var_ea616919227739f.disable_spawn_vfx = 1;
        var_ea616919227739f.spawn_fast = 1;
        sc_spawn = spawnscriptable( %"zm_sat_hornet_sq_vfx", var_ea616919227739f.origin );
        waitframe();
        sc_spawn setscriptablepartstate( "visual", "oni_spawn" );
        
        if ( !isdefined( level.var_37cf7e3cad2ca8b6 ) )
        {
            level.var_37cf7e3cad2ca8b6 = 15;
        }
        
        var_ea616919227739f thread zombie_values( 1 );
        var_ea616919227739f thread function_a8b0455763c9d8d3();
        var_ea616919227739f thread takeshi_damage_watcher();
        wait 1;
        sc_fx freescriptable();
        sc_spawn freescriptable();
        wait 1;
        level.mdl_katana hide();
        level utility::flag_set( "takeshi" );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x22a32c51, Offset: 0x459e
// Size: 0x1c9
function takeshi_damage_watcher()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death", #"detach" );
    n_starting_health = self.health;
    var_6bb4dc0b16a4fc0e = int( n_starting_health * 0.75 );
    var_804f2a91cd329af5 = int( n_starting_health * 0.5 );
    var_e38b8b1ec317e265 = int( n_starting_health * 0.25 );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( self.health <= var_6bb4dc0b16a4fc0e && !isdefined( self.var_dc0a8f90e5e7f872 ) )
        {
            self.var_dc0a8f90e5e7f872 = 1;
            thread function_180b81fd58c78fe3( 2 );
            continue;
        }
        
        if ( self.health <= var_804f2a91cd329af5 && !isdefined( self.var_7b3eda0990b0ffa1 ) )
        {
            self.var_7b3eda0990b0ffa1 = 1;
            thread function_180b81fd58c78fe3( 3 );
            continue;
        }
        
        if ( self.health <= var_e38b8b1ec317e265 && !isdefined( self.var_3253f155cb5da581 ) )
        {
            self.var_3253f155cb5da581 = 1;
            thread function_180b81fd58c78fe3( 4 );
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x5c2e70a6, Offset: 0x476f
// Size: 0x79
function katana_attach()
{
    v_org = self gettagorigin( "j_mid_ri_1" );
    v_ang = self gettagangles( "j_mid_ri_1" );
    knife = utility::spawn_model( %"execution_p47_me_sword01_v0", v_org, v_ang );
    knife linkto( self, "j_mid_ri_1", ( 0, 1, 0 ), ( 180, 180, 180 ) );
    knife thread function_fd346ae1020b55ef( self );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x36744bd8, Offset: 0x47f0
// Size: 0x20
function function_fd346ae1020b55ef( zombie )
{
    zombie waittill( #"death" );
    self delete();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x49fc9051, Offset: 0x4818
// Size: 0x6f
function samurai_death_watcher()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self waittill( #"death" );
    level.a_v_spots[ level.a_v_spots.size ] = self.origin;
    level.var_733b43b2c0ebf766--;
    
    if ( !level.var_733b43b2c0ebf766 )
    {
        level utility::flag_set( "samurai_done" );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xa1ad5c8, Offset: 0x488f
// Size: 0x28d
function function_a8b0455763c9d8d3()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self waittill( #"death" );
    level notify( #"end_timer" );
    level utility::flag_set( "bro_done" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player set_combat_hud( 0 );
    }
    
    level.mdl_katana unlink();
    waitframe();
    var_c5fb7b9c0ca383b7 = utility::getstruct( "sq_exit_item" );
    var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", level.mdl_katana.origin );
    level.mdl_katana linkto( var_2b0c20cebe23ba0b );
    waitframe();
    level.mdl_katana rotatepitch( 720, 1 );
    control_pt = ( level.mdl_katana.origin + var_c5fb7b9c0ca383b7.origin ) / 2 + ( 0, 0, 200 );
    var_2b0c20cebe23ba0b thread utility::function_8001268940441423( level.mdl_katana.origin, var_c5fb7b9c0ca383b7.origin, control_pt, 1, undefined, 1 );
    var_2b0c20cebe23ba0b utility::waittill_any_timeout( 3.1, "off_bezier_curve" );
    var_2b0c20cebe23ba0b delete();
    level.mdl_katana delete();
    sc_katana = spawnscriptable( %"zm_sat_hornet_sq_vfx", var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    sc_katana setscriptablepartstate( "visual", "katana_reveal" );
    level.var_cd7c72b72f141df4 = utility::spawn_model( "sat_wm_me_elnath", var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    playsoundatpos( var_c5fb7b9c0ca383b7.origin, "evt_hornet_sq_sword_appear" );
    wait 1;
    level.sq_player thread focus_view( vectortoangles( level.var_cd7c72b72f141df4.origin - level.sq_player utility::get_player_camera_origin() ), 3, 1 );
    function_13b98587f2622369();
    wait 3.5;
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player setscriptablepartstate( "hornet_sq", "hair_on" );
    }
    
    wait 1;
    level thread function_1ac86d519cc66bfd();
    level.var_cd7c72b72f141df4 delete_after_time( 8 );
    sc_katana freescriptable();
    level utility::flag_set( "completed_sq_step_3" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xde75f554, Offset: 0x4b24
// Size: 0x89
function function_180b81fd58c78fe3( var_c930de9b95c7b6dd )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    var_c04fe6401200c960 = utility::getstructarray( "arena_3_final" );
    var_c04fe6401200c960 = utility::get_array_of_farthest( self.origin, var_c04fe6401200c960 );
    
    for ( i = 0; i < var_c930de9b95c7b6dd ; i++ )
    {
        thread function_a6ed1ef7781383b7( var_c04fe6401200c960[ i ] );
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x9ed8e064, Offset: 0x4bb5
// Size: 0x28e
function function_a6ed1ef7781383b7( s_spawn )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    self endon( #"death" );
    v_pos = self gettagorigin( "j_spine4" );
    var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", v_pos, ( 0, 0, 0 ) );
    var_2b0c20cebe23ba0b linkto( self, "j_spine4" );
    var_2b0c20cebe23ba0b.sc_fx = spawnscriptable( %"zm_sat_hornet_pap_fx", var_2b0c20cebe23ba0b.origin, var_2b0c20cebe23ba0b.angles );
    var_2b0c20cebe23ba0b.sc_fx thread delete_after_time( 7 );
    var_2b0c20cebe23ba0b thread delete_after_time( 8 );
    waitframe();
    var_2b0c20cebe23ba0b.sc_fx utility::function_32b24db3127bff40( "visual", "katana_spawn" );
    var_2b0c20cebe23ba0b.sc_fx utility::scriptable_setparententity( var_2b0c20cebe23ba0b );
    wait 2;
    var_2b0c20cebe23ba0b.sc_fx utility::function_32b24db3127bff40( "visual", "katana_trail" );
    waitframe();
    control_pt = ( var_2b0c20cebe23ba0b.origin + s_spawn.origin ) / 2 + ( 0, 0, 200 );
    var_2b0c20cebe23ba0b unlink();
    waitframe();
    var_2b0c20cebe23ba0b thread utility::function_8001268940441423( self gettagorigin( "j_spine4" ), s_spawn.origin, control_pt, 2, undefined, 1 );
    var_2b0c20cebe23ba0b utility::waittill_any_timeout( 3.1, "off_bezier_curve" );
    sc_spawn = spawnscriptable( %"zm_sat_hornet_sq_vfx", s_spawn.origin, s_spawn.angles );
    sc_spawn utility::function_32b24db3127bff40( "visual", "samurai_spawn" );
    sc_spawn thread delete_after_time( 8 );
    
    if ( !level utility::flag( "bro_done" ) )
    {
        var_ea616919227739f = agent_manager::spawn_agent( "sat_spawner_zombie_base_zm_hornet_sq_samurai", s_spawn.origin, s_spawn.angles, "team_two_hundred" );
        
        if ( isdefined( var_ea616919227739f ) )
        {
            var_ea616919227739f thread zombie_values();
            var_ea616919227739f thread katana_attach();
            var_ea616919227739f thread function_b31cd313e8893e77();
            var_ea616919227739f zombie_utils::function_a8ce00e0448cb6f0( "run", "sq", 6 );
        }
    }
    
    wait 1;
    
    if ( isdefined( var_2b0c20cebe23ba0b.sc_fx ) )
    {
        var_2b0c20cebe23ba0b.sc_fx freescriptable();
    }
    
    if ( isdefined( var_2b0c20cebe23ba0b ) )
    {
        var_2b0c20cebe23ba0b delete();
    }
    
    if ( isdefined( sc_spawn ) )
    {
        sc_spawn freescriptable();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x30beae77, Offset: 0x4e4b
// Size: 0x37
function delete_after_time( n_time )
{
    self endon( #"death" );
    wait n_time;
    
    if ( isdefined( self ) )
    {
        if ( isent( self ) )
        {
            self delete();
            return;
        }
        
        self freescriptable();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xe561fe66, Offset: 0x4e8a
// Size: 0x24
function function_b31cd313e8893e77()
{
    self endon( #"death" );
    level utility::flag_wait( "bro_done" );
    thread zm_utility::function_5bbd540197e3fd( 100 );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x6529b95f, Offset: 0x4eb6
// Size: 0xcb
function function_1ac86d519cc66bfd()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    if ( !isdefined( level.sq_player ) )
    {
        return;
    }
    
    level.sq_player endon( #"death" );
    level utility::flag_set( "twins_dialogue_playing" );
    level.sq_player dialogue::say_dialogue( "dx_zm_hoss_htsd_scar_tsdtakatln01", [ level.sq_player ] );
    wait 0.5;
    level.sq_player dialogue::say_dialogue( "dx_zm_hoss_htsd_scar_tsdtakatln02", [ level.sq_player ] );
    level utility::flag_clear( "twins_dialogue_playing" );
    level utility::flag_set( "completed_sq_step_4" );
    level.sq_player thread player_return( "success" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x8a20fb76, Offset: 0x4f89
// Size: 0xc5
function function_56648da1ef128b85()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started" );
    self endon( #"death" );
    level notify( #"sq_over", "bro_done" );
    thread function_6943561c0d8f3b73( undefined, 3.5 );
    self setscriptablepartstate( "hornet_sq", "hair_on" );
    wait 2;
    thread player_return( "death" );
    var_32d7310b7c94c555 = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 80 ), self.angles );
    level utility::flag_set( "twins_dialogue_playing" );
    var_32d7310b7c94c555 dialogue::say_dialogue( "dx_zm_otka_aitk_ortk_aiorpldthcmtc", [ self ] );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xda64e5c6, Offset: 0x5056
// Size: 0x3ba
function player_return( var_66071b7285da1614 )
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started" );
    self endon( #"death" );
    level notify( #"sq_over" );
    
    if ( self.var_3be847287ab525d )
    {
        return;
    }
    
    self.var_3be847287ab525d = 1;
    utility::function_32b24db3127bff40( "burning", "neutral" );
    var_3bfd1ad32ac1f2be = utility::getstruct( "sq_return" );
    self predictstreamposuntilcleared( var_3bfd1ad32ac1f2be.origin );
    
    if ( var_66071b7285da1614 == "success" )
    {
        v_ang = var_3bfd1ad32ac1f2be.angles;
        v_pos = var_3bfd1ad32ac1f2be.origin;
    }
    else if ( var_66071b7285da1614 == "death" )
    {
        v_ang = self.v_ang;
        v_pos = self.v_org;
    }
    else
    {
        v_ang = self.v_ang;
        v_pos = self.v_org;
    }
    
    val::set( "squest", "ignoreme", 1 );
    val::set( "squest", "damage", 0 );
    val::set( "squest", "death", 0 );
    val::set( "squest", "allow_movement", 0 );
    val::set( "squest", "freezecontrols_allowlook", 0 );
    self.b_fell = undefined;
    zm_fasttravel::set_player_vars( 1 );
    self setscriptablepartstate( "hornet_sq_audio", "deactivate" );
    level musicbank_utility::function_4f253fd35ec68cbc( self );
    game_utility::fadetoblackforplayer( self, 1, 1 );
    self setscriptablepartstate( "hornet_sq", "camera_off" );
    set_screen_fx( 0, "cer_zm_ruby_echoes_cave" );
    deactivateworldevent( "we_vfx_camera_motes" );
    player::showminimap();
    level utility::flag_set( "bro_done" );
    wait 2;
    self setplayerangles( v_ang );
    self setorigin( v_pos );
    deactivateworldevent( "we_vfx_zm_hornet_sq_spaces_ambient" );
    zm_fasttravel::set_player_vars( 0 );
    wait 0.1;
    sc_teleport = spawnscriptable( %"zm_sat_hornet_sq_vfx", self.origin );
    sc_teleport setscriptablepartstate( "visual", "sq_teleport" );
    self setscriptablepartstate( #"gas_vfx", #"vfx_on", 1 );
    function_895ffaf5f35e0f3d( 0 );
    self.b_ignore_powerups = undefined;
    game_utility::fadetoblackforplayer( self, 0, 1 );
    reset_sq();
    self playsound( #"hash_55f133ceefcbd964" );
    
    if ( var_66071b7285da1614 == "success" )
    {
        thread katana_dissolve();
        level utility::flag_set( "twins_dialogue_playing" );
        overlord::playconversation( #"hash_9ddbde7c94183d59", [ self ], 1 );
        level utility::flag_clear( "twins_dialogue_playing" );
    }
    
    val::reset( "squest", "round_spawning_ignore_player" );
    val::reset( "squest", "ignoreme" );
    val::reset( "squest", "damage" );
    val::reset( "squest", "death" );
    val::reset( "squest", "freezecontrols_allowlook" );
    val::reset( "squest", "allow_movement" );
    val::reset( "squest", "show_hud" );
    val::reset( "sq_hud", "show_hud" );
    set_combat_hud( 0 );
    
    if ( var_66071b7285da1614 != "downed" )
    {
        function_ca72ec13bf33b972( 0 );
    }
    
    function_ea288a1204994a5b( 0 );
    sc_teleport freescriptable();
    self clearpredictedstreampos();
    self.var_3be847287ab525d = undefined;
    
    if ( var_66071b7285da1614 == "success" )
    {
        give_rewards();
        level thread utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_15800b43a7bb4ab8", #"hash_b0a4a3586a7d8781", [ self ] );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x81b83045, Offset: 0x5418
// Size: 0xce
function give_rewards()
{
    var_3bfd1ad32ac1f2be = utility::getstruct( "sq_return" );
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_takeo_sq", "Default" );
    var_21c3b67f1a74cd8e = getclosestpointonnavmesh( var_3bfd1ad32ac1f2be.origin );
    
    if ( !isdefined( var_21c3b67f1a74cd8e ) )
    {
        var_21c3b67f1a74cd8e = var_3bfd1ad32ac1f2be.origin;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_21c3b67f1a74cd8e );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        spawneditems = common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
        spawneditems.var_86918c8abfcc1332 = 1;
    }
    
    intel::spawn_intel_at_location( undefined, "zmintel_sat_hornet_audiolog_6", undefined, undefined, "zmintel_sat_hornet_audiolog_6" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x41013c5f, Offset: 0x54ee
// Size: 0x24
function function_1b92f3b36303b4b9()
{
    self endon( #"death" );
    wait 2.6;
    self setscriptablepartstate( "hornet_sword_inspect", "inspect" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x6a469182, Offset: 0x551a
// Size: 0x61
function katana_dissolve()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started" );
    self endon( #"death" );
    self forceweaponinspect();
    thread function_1b92f3b36303b4b9();
    wait 4.6;
    self giveweapon( level.defaultfist, undefined, 0, 0, 1, 1 );
    self switchtoweaponimmediate( level.defaultfist );
    self forceweaponinspect();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x1c601aae, Offset: 0x5583
// Size: 0x9e
function walljump_watcher()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ent == level.sq_player && !isdefined( ent.b_fell ) )
        {
            ent.b_fell = 1;
            game_utility::fadetoblackforplayer( ent, 1, 0.1 );
            
            if ( isdefined( ent ) )
            {
                ent thread player_return( "fall" );
                return;
            }
            
            reset_sq();
            return;
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x361d94e5, Offset: 0x5629
// Size: 0x766
function setup_trees()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player endon( #"death" );
    }
    
    level.a_s_trees = [];
    level.var_2ea13692fc6602b2 = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        level.a_s_trees[ i ] = utility::getstructarray( "tree_" + i );
    }
    
    for ( i = 0; i < 5 ; i++ )
    {
        level.var_2ea13692fc6602b2[ i ] = [];
        
        foreach ( var_f6f96163bcc5370 in level.a_s_trees[ i ] )
        {
            sc_bamboo = spawnscriptable( %"zm_sat_hornet_sq_vfx", var_f6f96163bcc5370.origin, var_f6f96163bcc5370.angles );
            level.var_2ea13692fc6602b2[ i ][ level.var_2ea13692fc6602b2[ i ].size ] = sc_bamboo;
        }
    }
    
    s_center_1 = utility::getstruct( "arena_1_center" );
    s_center_2 = utility::getstruct( "arena_2_center" );
    s_center_3 = utility::getstruct( "arena_3_center" );
    s_exit_1 = utility::getstruct( "fire_exit_1" );
    s_exit_2 = utility::getstruct( "fire_exit_2" );
    level.var_92f81be3ffbd28a9 = spawnscriptable( %"zm_sat_hornet_sq_vfx", s_exit_1.origin, s_exit_1.angles );
    level.var_92f818e3ffbd2210 = spawnscriptable( %"zm_sat_hornet_sq_vfx", s_exit_2.origin, s_exit_2.angles );
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 1 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo" );
    }
    
    level utility::flag_wait( s_center_1.script_noteworthy );
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 0 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo" );
    }
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 3 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo" );
    }
    
    level utility::flag_wait( "hellhounds_done" );
    wait 3;
    level.var_92f81be3ffbd28a9 setscriptablepartstate( "visual", "fire_exit" );
    s_exit_1 thread arena_fire_exit();
    level.sq_player set_combat_hud( 0 );
    level.sq_player thread focus_view( vectortoangles( level.var_92f81be3ffbd28a9.origin + ( 0, 0, 80 ) - level.sq_player utility::get_player_camera_origin() ), 3, 1 );
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 1 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo_burn" );
        sc_bamboo thread free_on_notify( "fire_approach", 0.5 );
    }
    
    wait 4.5;
    level utility::flag_set( "bamboo_burn_1" );
    s_exit_1 notify( #"stop_fire" );
    level.var_92f81be3ffbd28a9 setscriptablepartstate( "visual", "hidden" );
    level utility::flag_wait( s_center_2.script_noteworthy );
    level.var_92f81be3ffbd28a9 freescriptable();
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 2 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo" );
    }
    
    level utility::flag_wait( "scorch_done" );
    wait 1.5;
    level.sq_player set_combat_hud( 0 );
    level.sq_player thread focus_view( vectortoangles( level.var_92f818e3ffbd2210.origin + ( 0, 0, 80 ) - level.sq_player utility::get_player_camera_origin() ), 3, 1 );
    level.var_92f818e3ffbd2210 setscriptablepartstate( "visual", "fire_exit" );
    s_exit_2 thread arena_fire_exit();
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 3 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo_burn" );
        sc_bamboo thread free_on_notify( "final_battle", 0.5 );
    }
    
    wait 4.5;
    level utility::flag_set( "bamboo_burn_2" );
    s_exit_2 notify( #"stop_fire" );
    level.var_92f818e3ffbd2210 freescriptable();
    level utility::flag_wait( s_center_3.script_noteworthy );
    
    foreach ( sc_bamboo in level.var_2ea13692fc6602b2[ 4 ] )
    {
        sc_bamboo setscriptablepartstate( "visual", "bamboo" );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x3f59cb7b, Offset: 0x5d97
// Size: 0x4d
function free_on_notify( str_notify, n_delay = 0.1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level waittill( str_notify );
    wait n_delay;
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x8a9961f0, Offset: 0x5dec
// Size: 0x139
function clip_manager()
{
    level endon( #"hornet_mq_bossfight_fasttravel_started", #"hornet_mq_onryo_fight_fasttravel_started", #"sq_over" );
    mdl_clip_1 = getent( "clip_clearing_1", "targetname" );
    mdl_clip_2 = getent( "clip_clearing_2", "targetname" );
    mdl_clip_3 = getent( "clip_clearing_3", "targetname" );
    mdl_clip_4 = getent( "clip_clearing_4", "targetname" );
    mdl_clip_5 = getent( "clip_clearing_5", "targetname" );
    mdl_clip_1 notsolid();
    level utility::flag_wait( "hellhound" );
    mdl_clip_1 solid();
    level utility::flag_wait( "bamboo_burn_1" );
    mdl_clip_2 notsolid();
    mdl_clip_3 notsolid();
    level utility::flag_wait( "fire_approach" );
    level notify( #"hash_2b1fa1f7a99bf0d2" );
    mdl_clip_2 solid();
    mdl_clip_3 solid();
    level utility::flag_wait( "bamboo_burn_2" );
    mdl_clip_4 notsolid();
    mdl_clip_5 notsolid();
    level utility::flag_wait( "final_battle" );
    level notify( #"hash_2b1fa0f7a99bef1f" );
    mdl_clip_4 solid();
    mdl_clip_5 solid();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x1b283648, Offset: 0x5f2d
// Size: 0xf6
function zombie_values( b_takeshi )
{
    if ( !isdefined( b_takeshi ) )
    {
        zombie_utils::set_zombie_round_difficulty( zm_utility::get_round_number() );
    }
    
    val::set( "takeshi_zombie", "ignore_cleanup", 1 );
    self.var_eb92c31552620100 = 1;
    self.b_cleanup_no_respawn = 1;
    self.var_15598d8e493afe88 = 1;
    self.var_825b17c932865df = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.ignore_enemy_count = 1;
    self.no_powerups = 1;
    
    if ( self.aicategory == "elite" )
    {
        self.kiastring = #"zombie_kia_mission_kill_elite";
        return;
    }
    
    if ( self.aicategory == "special" )
    {
        self.kiastring = #"zombie_kia_mission_kill_special";
        return;
    }
    
    self.kiastring = #"zombie_kia_mission_kill";
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x4296768a, Offset: 0x602b
// Size: 0xf5
function function_cadf2d49d2505379( params )
{
    if ( params.grenade.weapon_name == "sat_gas_grenade_zm" )
    {
        if ( level utility::flag( "mq_step_36_complete" ) )
        {
            return;
        }
        
        if ( level utility::flag( "solo_game" ) && zm_quest::function_73720cdf21c3cfd7( #"hornet_sq_quest", #"sq_done" ) )
        {
            return;
        }
        
        if ( isdefined( params.grenade.owner ) && params.grenade.owner namespace_c0b4f2882c9d100f::is_takeo() && !params.grenade.owner.var_6716a7bd8a14a48 )
        {
            player = params.grenade.owner;
            player thread decoy_monitor();
            player thread decoy_timeout();
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x67232f3e, Offset: 0x6128
// Size: 0x29
function decoy_timeout()
{
    self endon( #"death", #"psych_out" );
    wait 6.5;
    self notify( #"psych_out" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x7d98b4ce, Offset: 0x6159
// Size: 0x1d9
function decoy_monitor()
{
    self endon( #"death", #"psych_out" );
    t_floor = getent( "t_second_floor", "targetname" );
    
    while ( !isdefined( self.decoys ) )
    {
        wait 0.1;
    }
    
    wait 0.1;
    
    while ( true )
    {
        foreach ( decoy in self.decoys )
        {
            if ( !isdefined( decoy.b_watched ) && decoy istouching( t_floor ) )
            {
                decoy.b_watched = 1;
                
                if ( isdefined( decoy.weaponent ) )
                {
                    decoy.weaponent hide();
                }
                
                decoy thread decoy_death_watcher( self );
                decoy.var_ec33c64544b86c4b = utility::spawn_model( %"c_sat_gear_scarlet_proto_katana_blade", decoy.origin, decoy.angles );
                decoy.var_ec33c64544b86c4b linkto( decoy, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                decoy scriptmodelplayanim( "ch_cin_zm_ruby_outro_sh120_tak", "gasVictim_notify" );
                decoy.var_ec33c64544b86c4b scriptmodelplayanim( "ch_cin_zm_ruby_outro_sh120_tak_katana", "gasVictim_notify" );
                decoy hide();
                decoy.var_ec33c64544b86c4b hide();
                decoy.var_ec33c64544b86c4b showtoplayer( self );
                decoy showtoplayer( self );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xf99da3ab, Offset: 0x633a
// Size: 0x244
function decoy_death_watcher( player )
{
    player endon( #"death" );
    t_floor = getent( "t_second_floor", "targetname" );
    v_org = self.origin;
    self waittill( #"death" );
    
    if ( isdefined( self.var_ec33c64544b86c4b ) )
    {
        self.var_ec33c64544b86c4b delete();
    }
    
    if ( distance2dsquared( v_org, player.origin ) <= 14400 && player namespace_c0b4f2882c9d100f::is_takeo() && isdefined( level.sq_sword ) && !isdefined( level.sq_sword.is_visible ) && self istouching( t_floor ) )
    {
        v_forward_pos = vectornormalize( anglestoforward( player.angles ) ) * 100 + player.origin;
        v_drop_pos = getclosestpointonnavmesh( v_forward_pos );
        v_ground_pos = utility::groundpos( v_drop_pos );
        level.sq_sword.is_visible = 1;
        level.sq_sword.origin = v_ground_pos + ( 0, 0, 50 );
        level.sq_sword showtoplayer( player );
        level.sq_sword.owner = player;
        level.sq_sword moveto( v_ground_pos + ( 0, 0, 24 ), 0.25 );
        level.sq_sword waittill( #"movedone" );
        level.sq_sword thread function_2f9cd79691259fee();
        level.sq_sword thread katana_timeout( player );
        player thread katana_reveal( v_ground_pos );
        level.sq_interact = interaction::register_interact( level.sq_sword.origin + ( 0, 0, 20 ), 40, &function_7972f90ff57fc45, undefined, undefined, undefined, 1 );
        level.sq_interact interaction::set_interact_hint_callback( &sq_hint );
        level.sq_interact.var_ec33c64544b86c4b = level.sq_sword;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x28dde8b1, Offset: 0x6586
// Size: 0x24
function katana_timeout( player )
{
    level endon( #"sq_triggered" );
    wait 60;
    player katana_reset();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x7da9cb51, Offset: 0x65b2
// Size: 0x63
function katana_reset()
{
    if ( isdefined( level.sq_sword ) )
    {
        if ( self == level.sq_sword.owner )
        {
            level.sq_sword hide();
            level.sq_sword.is_visible = undefined;
        }
    }
    
    if ( isdefined( level.sq_interact ) )
    {
        level.sq_interact delete();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x49577c56, Offset: 0x661d
// Size: 0x81
function katana_reveal( v_org )
{
    self endon( #"death" );
    var_7c170ceae0649b57 = [ #"teamselect", self getentitynumber() ];
    sc_fx = spawnscriptable( %"zm_sat_hornet_sq_client", v_org, ( 0, 0, 0 ), undefined, var_7c170ceae0649b57 );
    sc_fx utility::function_32b24db3127bff40( "base", "visible" );
    wait 2;
    sc_fx freescriptable();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x71a436ff, Offset: 0x66a6
// Size: 0x8d
function katana_hide()
{
    foreach ( player in level.players )
    {
        if ( isdefined( level.sq_sword ) )
        {
            level.sq_sword hide();
        }
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x7b917658, Offset: 0x673b
// Size: 0x328
function reset_sq()
{
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player = undefined;
    }
    
    if ( isdefined( level.sq_interact.b_interacted ) )
    {
        level.sq_interact.b_interacted = 0;
    }
    
    level utility::flag_clear( "completed_sq_step_1" );
    level utility::flag_clear( "completed_sq_step_2" );
    level utility::flag_clear( "completed_sq_step_3" );
    level utility::flag_clear( "completed_sq_step_4" );
    level utility::flag_clear( "sq_triggered" );
    level utility::flag_clear( "transition_outro" );
    level utility::flag_clear( "transition_done" );
    level utility::flag_clear( "attack" );
    level utility::flag_clear( "scorch_vo" );
    level utility::flag_clear( "scorch_reinforce" );
    level utility::flag_clear( "wall_jump" );
    level utility::flag_clear( "takeshi" );
    level utility::flag_clear( "bro_done" );
    level utility::flag_clear( "bamboo_burn_1" );
    level utility::flag_clear( "bamboo_burn_2" );
    level utility::flag_clear( "final_battle" );
    s_center_1 = utility::getstruct( "arena_1_center" );
    s_center_2 = utility::getstruct( "arena_2_center" );
    s_center_3 = utility::getstruct( "arena_3_center" );
    level utility::flag_clear( s_center_1.script_noteworthy );
    level utility::flag_clear( s_center_2.script_noteworthy );
    level utility::flag_clear( s_center_3.script_noteworthy );
    level utility::flag_clear( "hellhounds_done" );
    level utility::flag_clear( "scorch_done" );
    level utility::flag_clear( "samurai_done" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        foreach ( var_f6f96163bcc5370 in level.var_2ea13692fc6602b2[ i ] )
        {
            if ( isdefined( var_f6f96163bcc5370 ) )
            {
                var_f6f96163bcc5370 freescriptable();
            }
        }
    }
    
    if ( isdefined( level.var_92f81be3ffbd28a9 ) )
    {
        level.var_92f81be3ffbd28a9 freescriptable();
    }
    
    if ( isdefined( level.var_92f818e3ffbd2210 ) )
    {
        level.var_92f818e3ffbd2210 freescriptable();
    }
    
    toggle_zones( 0 );
    
    if ( isdefined( level.sq_sword ) )
    {
        level.sq_sword delete();
    }
    
    if ( isdefined( level.var_cd7c72b72f141df4 ) )
    {
        level.var_cd7c72b72f141df4 delete();
    }
    
    for ( i = 1; i < 11 ; i++ )
    {
        if ( i < 10 )
        {
            deactivateworldevent( "we_vfx_hornet_sq_arena_1_fire_0" + i );
            continue;
        }
        
        deactivateworldevent( "we_vfx_hornet_sq_arena_1_fire_10" );
    }
    
    level thread function_abf257f0b9587bc2( 0 );
    level thread zm_quest::function_80abdea0cd4c89a7( #"hornet_sq_quest", #"combat_1" );
    level thread setup_sq_trigger();
    level thread clip_manager();
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x992a3bf, Offset: 0x6a6b
// Size: 0x128
function function_2f9cd79691259fee()
{
    level endon( #"sq_triggered", #"game_ended" );
    self endon( #"death" );
    var_a24b06ee08924b7e = squared( 360 );
    str_dx = "dx_zm_hoss_htsd_scar_tsdktat";
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && player namespace_c0b4f2882c9d100f::is_takeo() && distancesquared( player.origin, self.origin ) <= var_a24b06ee08924b7e && !isdefined( player.var_f0855a219c4be561 ) )
            {
                player.var_f0855a219c4be561 = 1;
                player thread function_4ad11f1462e44537();
                player thread dialogue::say_dialogue( str_dx, [ player ] );
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x93fe3b1f, Offset: 0x6b9b
// Size: 0x36
function function_4ad11f1462e44537()
{
    level endon( #"sq_triggered", #"game_ended" );
    self endon( #"death" );
    wait randomintrange( 15, 31 );
    self.var_f0855a219c4be561 = undefined;
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0x1b561a36, Offset: 0x6bd9
// Size: 0x7b
function function_63ac4fb1f05a8912( n_index, str_endon )
{
    self endon( #"death" );
    level endon( str_endon, #"bro_done", #"sq_over" );
    str_vo = "dx_zm_hoss_htsd_scar_tsdintrth" + n_index;
    wait randomfloatrange( 1, 2 );
    
    while ( true )
    {
        thread dialogue::say_dialogue( str_vo, [ self ] );
        wait randomintrange( 7, 21 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xd8275a4b, Offset: 0x6c5c
// Size: 0x14c
function vo_progression()
{
    self endon( #"death" );
    level endon( #"game_ended", #"bro_done", #"sq_over" );
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( #"hash_c443b7192093e8e2", [ self ], 1 );
    wait 1.5;
    function_63ac4fb1f05a8912( 1, "fire_approach" );
    level utility::flag_wait( "fire_approach" );
    wait 1;
    function_63ac4fb1f05a8912( 2, "scorch_done" );
    level utility::flag_wait( "scorch_vo" );
    overlord::playconversation( #"hash_95945dc15f8fb9c8", [ self ], 2 );
    wait 1.5;
    overlord::playconversation( #"scorch_done", [ self ] );
    level utility::flag_wait( "wall_jump" );
    function_63ac4fb1f05a8912( 3, "final_battle" );
    overlord::playconversation( #"hash_641d4a3e1ffe6412", [ self ] );
    level utility::flag_wait( "takeshi" );
    overlord::playconversation( #"hash_f7e38159b03da46d", [ self ], 2 );
    level utility::flag_wait( "bro_done" );
    wait 1.5;
    dialogue::say_dialogue( "dx_zm_hoss_htsd_scar_tsdtkshd", [ self ] );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0xa2327af8, Offset: 0x6db0
// Size: 0xa3
function function_bb719f86dc63c1be()
{
    level endon( #"scorch_done", #"sq_over" );
    s_center = utility::getstruct( "arena_2_center" );
    
    while ( true )
    {
        zombies = getaiarrayinradius( s_center.origin, s_center.radius + 200, "team_two_hundred" );
        
        if ( zombies.size )
        {
            speaker = utility::array_random( zombies );
            
            if ( isdefined( speaker ) )
            {
                speaker dialogue::say_dialogue( "dx_zm_hoss_htsd_ghrm_tsdhnptcalls", [ self ] );
            }
        }
        
        wait randomfloatrange( 4, 8 );
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 0
// Checksum 0x4235bb0, Offset: 0x6e5b
// Size: 0x49
function function_13b98587f2622369()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.sq_player ) )
    {
        level.sq_player endon( #"death" );
    }
    
    dialogue::say_dialogue( "dx_zm_hoss_htsd_psor_tsdapkta", [ level.sq_player ] );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0xf6943eb9, Offset: 0x6eac
// Size: 0x64
function zombie_spawn_animation( s_spawn )
{
    s_spawn.spawning = 1;
    
    if ( !isdefined( s_spawn.script_animation ) )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            s_spawn.script_animation = "spawn";
        }
    }
    
    zone_spawner::function_ce10e453e7f7bb8e( s_spawn );
    s_spawn.spawning = undefined;
}

// Namespace zm_sat_hornet_sq_quest
// Params 1, eflags: 0xc
// Checksum 0xda02c204, Offset: 0x6f18
// Size: 0x78
function private function_ec810f013ce9dc70( var_3cd5bea2a8d3e74 )
{
    self notify( #"hash_77783bc9a9c22f25" );
    self endon( #"hash_77783bc9a9c22f25" );
    self endon( #"death" );
    level endon( #"game_ended", #"end_timer", #"warp_to_boss", #"sq_over" );
    
    if ( getdvarint( @"hash_cdc4ebc756651bf9", 0 ) )
    {
        return;
    }
    
    wait var_3cd5bea2a8d3e74;
    thread player_return( "timeout" );
}

// Namespace zm_sat_hornet_sq_quest
// Params 3, eflags: 0x4
// Checksum 0xdb5d8910, Offset: 0x6f98
// Size: 0x12d
function private focus_view( v_goal_angles, n_time = 1, var_899b9bbe505cba96 )
{
    level endon( #"game_ended", #"end_timer", #"sq_over" );
    self endon( #"death_or_disconnect" );
    val::set( "focus", "freezecontrols", 1 );
    val::set( "focus", "freezecontrols_allowlook", 1 );
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
            val::reset( "focus", "freezecontrols" );
            val::reset( "focus", "freezecontrols_allowlook" );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_sq_quest
// Params 2
// Checksum 0xc85da1a1, Offset: 0x70cd
// Size: 0x82
function function_6943561c0d8f3b73( gestureref, duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( gestureref ) )
    {
        gestureref = "vm_ges_shockstick_react";
    }
    
    curweapon = self getcurrentweapon();
    
    if ( !isdefined( curweapon ) || curweapon.basename === "none" )
    {
        return;
    }
    
    while ( !self isgestureplaying( gestureref ) )
    {
        self forceplaygestureviewmodel( gestureref );
        waitframe();
    }
    
    wait duration;
    self stopgestureviewmodel( gestureref, 0.5 );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x348d2ac9, Offset: 0x7157
// Size: 0x4f
function function_c24e9e42a87314c7( params )
{
    level utility::flag_set( "open_sesame" );
    function_75a9f496a1c29bb9();
    level thread clip_manager();
    level.player.b_cheat = 1;
    level thread function_7972f90ff57fc45( level.player );
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x2852d933, Offset: 0x71ae
// Size: 0x26
function function_79ce990edf623413( params )
{
    level.sq_player = level.player;
    level thread takeshi_coalesce();
}

// Namespace zm_sat_hornet_sq_quest
// Params 1
// Checksum 0x87064450, Offset: 0x71dc
// Size: 0x119
function function_c124f114472e4210( params )
{
    toggle_zones( 1 );
    function_75a9f496a1c29bb9();
    zm_quest::clear_all_guidance();
    mdl_clip_1 = getent( "clip_clearing_1", "targetname" );
    mdl_clip_2 = getent( "clip_clearing_2", "targetname" );
    mdl_clip_3 = getent( "clip_clearing_3", "targetname" );
    mdl_clip_4 = getent( "clip_clearing_4", "targetname" );
    mdl_clip_5 = getent( "clip_clearing_5", "targetname" );
    mdl_clip_1 notsolid();
    mdl_clip_2 notsolid();
    mdl_clip_3 notsolid();
    mdl_clip_4 notsolid();
    mdl_clip_5 notsolid();
    var_ed100f9a07836d02 = utility::getstruct( "sq_pos" );
    level.player setorigin( var_ed100f9a07836d02.origin );
    level.player setplayerangles( var_ed100f9a07836d02.angles );
    level.player function_ca72ec13bf33b972( 1 );
}

/#

    // Namespace zm_sat_hornet_sq_quest
    // Params 0
    // Checksum 0xbc05ac91, Offset: 0x72fd
    // Size: 0x33, Type: dev
    function function_b9ac30107a7eef85()
    {
        level.players[ 0 ] setscriptablepartstate( "<dev string:x24>", "<dev string:x39>" );
        level.players[ 0 ] function_ca72ec13bf33b972( 1 );
    }

    // Namespace zm_sat_hornet_sq_quest
    // Params 0
    // Checksum 0xb686b5b, Offset: 0x7338
    // Size: 0x30, Type: dev
    function function_2e866c6611436c8f()
    {
        level.players[ 0 ] katana_dissolve();
        wait 3;
        level.players[ 0 ] function_ca72ec13bf33b972( 0 );
    }

    // Namespace zm_sat_hornet_sq_quest
    // Params 0
    // Checksum 0xa0003716, Offset: 0x7370
    // Size: 0x20, Type: dev
    function function_81e091a53a4ede85()
    {
        level.sq_interact function_7972f90ff57fc45( level.players[ 0 ] );
    }

    // Namespace zm_sat_hornet_sq_quest
    // Params 0
    // Checksum 0x1fa7f071, Offset: 0x7398
    // Size: 0x5a, Type: dev
    function function_1240b5ea6a2c6924()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3f>" );
        devgui::add_devgui_func( "<dev string:x58>", "<dev string:x61>", &function_81e091a53a4ede85 );
        devgui::add_devgui_func( "<dev string:x6a>", "<dev string:x7b>", &function_b9ac30107a7eef85 );
        devgui::add_devgui_func( "<dev string:x8c>", "<dev string:x9d>", &function_2e866c6611436c8f );
        devgui::function_77df7fe7dd273e10();
    }

#/
