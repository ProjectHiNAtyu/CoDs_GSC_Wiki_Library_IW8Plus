// script_49d8737472831623  (hash_49d8737472831623.gscc) (size: 12516 Bytes / 0x30e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26d897a6 (651728806)
// size ...... 12516 (0x30e4)
// includes .. 14  (offset: 0x2b48)
// strings ... 75  (offset: 0x2bb8)
// dev strs .. 7   (offset: 0x3040)
// exports ... 25  (offset: 0x1c1c)
// cseg ...... 0x6fa + 0x1522 (0x1c1c)
// imports ... 93  (offset: 0x2004)
// animtree1 . 1   (offset: 0x3094)
// animtree2 . 4   (offset: 0x30a4)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;

#namespace br_sierra_sidequest_hub;

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x5
// Checksum 0x82f18d35, Offset: 0x718
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_12fe703d9c7a07b5", undefined, &pre_main, &post_main );
}

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0x16fa5879, Offset: 0x73d
// Size: 0x2
function private pre_main()
{
    
}

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0xf44e5da6, Offset: 0x747
// Size: 0x17b
function private post_main()
{
    if ( !getdvarint( @"hash_e705a42d638f719b", 1 ) || !getdvarint( @"scr_sierra_sidequest_enabled", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_7bac13b446aa7fc9 ) )
    {
        level.var_7bac13b446aa7fc9 = [];
    }
    
    level.var_7bac13b446aa7fc9[ level.var_7bac13b446aa7fc9.size ] = &function_9f3308ccedd58ebe;
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level.progresshub = spawnstruct();
    level.progresshub.var_dc83fc59522116a1 = getdvarint( @"hash_3cee7c513ae578f7", 0 );
    scriptbundle = game_utility_mp::function_cb7ed8e67866f9d0( "progresshubsidequests" );
    level.progresshub.scriptbundle = scriptbundle;
    initanims();
    initvo();
    computerarray = getentitylessscriptablearray( "EEProgressHub", "script_noteworthy" );
    
    foreach ( computer in computerarray )
    {
        computer setscriptablepartstate( "equipment_computer_workstation_03", "usable" );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "equipment_computer_workstation_03", &computerused );
    
    /#
        debug_init();
    #/
}

#using_animtree( "script_model" );

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0x69e76586, Offset: 0x8ca
// Size: 0x178
function private initanims()
{
    level.scr_animtree[ "sierra_progress_hub" ] = #animtree;
    level.scr_anim[ "sierra_progress_hub" ][ "use_progress_hub" ] = %t10_mp_s3_progress_hub;
    level.scr_eventanim[ "sierra_progress_hub" ][ "use_progress_hub" ] = %"use_progress_hub";
    level.scr_viewmodelanim[ "sierra_progress_hub" ][ "use_progress_hub" ] = "t10_mp_s3_progress_hub";
    level.scr_anim[ "sierra_progress_hub" ][ "use_progress_hub_enter" ] = %t10_mp_s3_progress_in;
    level.scr_eventanim[ "sierra_progress_hub" ][ "use_progress_hub_enter" ] = %"use_progress_hub_enter";
    level.scr_viewmodelanim[ "sierra_progress_hub" ][ "use_progress_hub_enter" ] = "t10_mp_s3_progress_in";
    level.scr_anim[ "sierra_progress_hub" ][ "use_progress_hub_idle" ] = %t10_mp_s3_progress_loop;
    level.scr_eventanim[ "sierra_progress_hub" ][ "use_progress_hub_idle" ] = %"use_progress_hub_idle";
    level.scr_viewmodelanim[ "sierra_progress_hub" ][ "use_progress_hub_idle" ] = "t10_mp_s3_progress_loop";
    level.scr_anim[ "sierra_progress_hub" ][ "use_progress_hub_exit" ] = %t10_mp_s3_progress_out;
    level.scr_eventanim[ "sierra_progress_hub" ][ "use_progress_hub_exit" ] = %"use_progress_hub_exit";
    level.scr_viewmodelanim[ "sierra_progress_hub" ][ "use_progress_hub_exit" ] = "t10_mp_s3_progress_out";
}

// Namespace br_sierra_sidequest_hub
// Params 0
// Checksum 0x1902acaa, Offset: 0xa4a
// Size: 0x74
function initvo()
{
    level.progresshub.voiceovers = [];
    level.progresshub.voiceovers[ "FIRST_TIME" ] = "dx_br_vrdr_sree_wzan_hbfr";
    level.progresshub.voiceovers[ "HALF_COMPLETED" ] = "dx_br_vrdr_sree_wzan_hbhf";
    level.progresshub.voiceovers[ "FULL_COMPLETED" ] = "dx_br_vrdr_sree_wzan_hbcm";
}

// Namespace br_sierra_sidequest_hub
// Params 6
// Checksum 0xe620fa9, Offset: 0xac6
// Size: 0x104
function computerused( instance, part, state, player, bautouse, usestring )
{
    if ( !common_item::function_9af4a186249f7df1( player ) )
    {
        if ( isdefined( level.showerrormessagefunc ) && isdefined( level.br_pickups.var_e42dab6eb0ce5dec ) )
        {
            player [[ level.showerrormessagefunc ]]( level.br_pickups.var_e42dab6eb0ce5dec );
        }
        
        return;
    }
    
    var_d9c428d62e4443e8 = instance user_player_goal_pos();
    player_array = getentarrayinradius( "player", #classname, var_d9c428d62e4443e8, 30 );
    player_array = arrayremove( player_array, player );
    
    if ( player_array.size > 0 )
    {
        if ( isdefined( level.showerrormessagefunc ) )
        {
            player [[ level.showerrormessagefunc ]]( %"hash_6acd535b28a7f304" );
        }
        
        return;
    }
    
    thread function_7464e213f8ce31bb( instance, part, state, player, bautouse, usestring );
}

// Namespace br_sierra_sidequest_hub
// Params 6
// Checksum 0x645bda70, Offset: 0xbd2
// Size: 0x3da
function function_7464e213f8ce31bb( instance, part, state, player, bautouse, usestring )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"interrupt_progress_hub" );
    allowthirdperson = !player.disable_third_person_toggle;
    
    if ( allowthirdperson )
    {
        var_e9340cc7e02fef5f = player getcamerathirdperson();
        function_10e96a1d14d86739( player, var_e9340cc7e02fef5f, 0, 0 );
    }
    
    instance thread watchplayerdeathordisconnect( player );
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 0 );
    goalpos = instance user_player_goal_pos();
    targetlocalangles = combineangles( ( 0, 180, 0 ), ( 15, 0, 0 ) );
    goalangles = combineangles( instance.angles, targetlocalangles );
    movetotime = 0.5;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    player function_91716ceafc1be3f9( 0 );
    
    if ( player.linktoent )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = max( 0, 0.5 - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
    wait var_ed2a546b70aa8095;
    timestart = gettime();
    instance setscriptablepartstate( "equipment_computer_workstation_03", "on" );
    player setclientomnvar( "ui_br_sierra_progress_hub_active", 1 );
    player thread function_c8e83240d20a875b( instance );
    instance function_8a8c886721bc7701();
    player thread create_player_rig( "sierra_progress_hub", player.origin, player.angles );
    player.player_rig showonlytoplayer( player );
    player lerpfovscalefactor( 0, 1 );
    instance.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_progress_hub_enter" );
    instance.animstruct thread anim_mp::anim_player_solo( player, player.player_rig, "use_progress_hub_idle" );
    player thread controls_input();
    player thread function_e110305a51d76d3( player );
    result = player utility::waittill_any( "weapon_change", "exit_progress_hub", "damage", "damage_armor" );
    player lerpfovscalefactor( 1, 1 );
    instance.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_progress_hub_exit" );
    
    if ( isdefined( player ) )
    {
        player notify( #"exit_progress_hub" );
        player function_91716ceafc1be3f9( 1 );
        
        if ( allowthirdperson )
        {
            function_10e96a1d14d86739( player, var_e9340cc7e02fef5f, 1, var_e9340cc7e02fef5f );
        }
        
        thread hubanimend( player );
        player setclientomnvar( "ui_br_sierra_progress_hub_active", 0 );
        timeend = gettime();
        var_8e10bb237744a881 = utility::function_6f5d2e1f1ff70482( timeend - timestart );
        player dlog_recordplayerevent( "dlog_event_br_sierra_progress_hub_used", [ "time_used_second", var_8e10bb237744a881 ] );
    }
    
    instance setscriptablepartstate( "equipment_computer_workstation_03", "off" );
    instance notify( #"progress_hub_give_reward" );
}

// Namespace br_sierra_sidequest_hub
// Params 1
// Checksum 0xc780e32d, Offset: 0xfb4
// Size: 0xee
function watchplayerdeathordisconnect( player )
{
    level endon( #"game_ended" );
    player endon( #"exit_progress_hub" );
    msg = player utility::waittill_any_return( "death", "disconnect", "enter_live_ragdoll", "last_stand_enter", "execution_begin_victim", "meatshield_victim_grabbed" );
    
    if ( isdefined( player ) )
    {
        player notify( #"interrupt_progress_hub" );
        player stopanimscriptsceneevent();
        
        if ( isdefined( player.linktoent ) )
        {
            player unlink();
            player.linktoent delete();
            player.linktoent = undefined;
        }
        
        if ( msg == "last_stand_enter" || msg == "death" )
        {
            player notify( #"remove_rig" );
        }
        
        player function_91716ceafc1be3f9( 1 );
        player setclientomnvar( "ui_br_sierra_progress_hub_active", 0 );
        self setscriptablepartstate( "equipment_computer_workstation_03", "off" );
    }
}

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0xa72d36fb, Offset: 0x10aa
// Size: 0xef
function private controls_input()
{
    level endon( #"game_ended" );
    self endon( #"exit_progress_hub" );
    var_cb07672552d7fdbc = [ "exit_progress_hub" ];
    var_247f6da444bc683c = { #scroll_value:1 };
    var_d45b97a16157087f = { #scroll_value:2 };
    childthread usebuttonwatch();
    player::function_872ddf4ab418a5d5( "hub_scroll_up_kbm", "forward", &scrollgrid, var_247f6da444bc683c, var_cb07672552d7fdbc, "kbm_only", 0.1 );
    player::function_872ddf4ab418a5d5( "hub_scroll_down_kbm", "back", &scrollgrid, var_d45b97a16157087f, var_cb07672552d7fdbc, "kbm_only", 0.1 );
    player::function_872ddf4ab418a5d5( "hub_scroll_up_gamepad", "weapnext", &scrollgrid, var_247f6da444bc683c, var_cb07672552d7fdbc, "gamepad_only", 0.1 );
    player::function_872ddf4ab418a5d5( "hub_scroll_down_gamepad", "gostand", &scrollgrid, var_d45b97a16157087f, var_cb07672552d7fdbc, "gamepad_only", 0.1 );
}

// Namespace br_sierra_sidequest_hub
// Params 1, eflags: 0x4
// Checksum 0xeed5354, Offset: 0x11a1
// Size: 0x40
function private function_e110305a51d76d3( player )
{
    level endon( #"game_ended" );
    player endon( #"exit_progress_hub" );
    player waittill( #"hash_fdaaf8222e36fe9d" );
    player notify( #"exit_progress_hub" );
}

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0x78550334, Offset: 0x11e9
// Size: 0x1f
function private usebuttonwatch()
{
    while ( true )
    {
        waitframe();
        
        if ( self usebuttonpressed() )
        {
            self notify( #"exit_progress_hub" );
        }
    }
}

// Namespace br_sierra_sidequest_hub
// Params 1
// Checksum 0x505d345a, Offset: 0x1210
// Size: 0x166
function function_91716ceafc1be3f9( isallowed )
{
    if ( !isallowed )
    {
        val::set( "progress_hub", "allow_jump", 0 );
        val::set( "progress_hub", "gesture", 0 );
        val::set( "progress_hub", "melee", 0 );
        val::set( "progress_hub", "mantle", 0 );
        val::set( "progress_hub", "offhand_weapons", 0 );
        val::set( "progress_hub", "allow_movement", 0 );
        val::set( "progress_hub", "sprint", 0 );
        val::set( "progress_hub", "fire", 0 );
        val::set( "progress_hub", "reload", 0 );
        val::set( "progress_hub", "weapon_pickup", 0 );
        val::set( "progress_hub", "weapon_switch", 0 );
        val::set( "progress_hub", "offhand_weapons", 0 );
        val::set( "progress_hub", "execution_victim", 0 );
        val::set( "progress_hub", "supers", 0 );
        val::set( "progress_hub", "usability", 0 );
        val::set( "progress_hub", "allow_toggle_third_person", 0 );
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( "progress_hub" );
    self setclientomnvar( "ui_br_inventory_disabled", 0 );
    self function_7d73d6786e51ae1f();
}

// Namespace br_sierra_sidequest_hub
// Params 1, eflags: 0x4
// Checksum 0xd394b0df, Offset: 0x137e
// Size: 0x40
function private scrollgrid( params )
{
    if ( !isdefined( params.scroll_value ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_br_sierra_progress_hub_move", params.scroll_value );
    waitframe();
    self setclientomnvar( "ui_br_sierra_progress_hub_move", 0 );
}

// Namespace br_sierra_sidequest_hub
// Params 1, eflags: 0x4
// Checksum 0x7fc85ce4, Offset: 0x13c6
// Size: 0x2b8
function private function_c8e83240d20a875b( instance )
{
    level endon( #"game_ended" );
    self endon( #"exit_progress_hub" );
    
    /#
        if ( isdefined( self.var_977d05794af867c3 ) )
        {
            switch ( self.var_977d05794af867c3 )
            {
                case 100:
                    points::doscoreevent( #"hash_cb6718154f5dac94" );
                    thread function_47f5711361b9f3b7( level.progresshub.scriptbundle.var_f7dd596d9005af28, instance );
                    self playsoundtoplayer( level.progresshub.voiceovers[ "<dev string:x24>" ], self );
                    break;
                case 51:
                    points::doscoreevent( #"hash_9b1fe08ed2abf1fc" );
                    thread function_47f5711361b9f3b7( level.progresshub.scriptbundle.var_bc539e8057cc30, instance );
                    self playsoundtoplayer( level.progresshub.voiceovers[ "<dev string:x33>" ], self );
                    break;
            }
            
            self.var_977d05794af867c3 = undefined;
            return;
        }
    #/
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        switch ( message )
        {
            case #"hash_b46dfa4fb27c5972":
                challenges::function_37e945722d6497f3( self, "sierra_sidequest_completion_half", 1 );
                points::doscoreevent( #"hash_9b1fe08ed2abf1fc" );
            case #"hash_80d919f6d4c39f24":
                challenges::function_37e945722d6497f3( self, "sierra_sidequest_completion_full", 1 );
                points::doscoreevent( #"hash_cb6718154f5dac94" );
                self playsoundtoplayer( level.progresshub.voiceovers[ "FULL_COMPLETED" ], self );
            case #"hash_1b24fd1c2dbfd644":
                thread function_47f5711361b9f3b7( level.progresshub.scriptbundle.var_f7dd596d9005af28, instance );
                break;
            case #"hash_36fd7bd228c2810c":
                challenges::function_37e945722d6497f3( self, "sierra_sidequest_completion_half", 1 );
                points::doscoreevent( #"hash_9b1fe08ed2abf1fc" );
                self playsoundtoplayer( level.progresshub.voiceovers[ "HALF_COMPLETED" ], self );
            case #"hash_d46f5ef78439212c":
                thread function_47f5711361b9f3b7( level.progresshub.scriptbundle.var_bc539e8057cc30, instance );
                break;
            case #"hash_a98c530443b84f71":
                challenges::function_37e945722d6497f3( self, "sierra_sidequest_completion_first", 1 );
                self playsoundtoplayer( level.progresshub.voiceovers[ "FIRST_TIME" ], self );
                break;
        }
    }
}

// Namespace br_sierra_sidequest_hub
// Params 2, eflags: 0x4
// Checksum 0x114bb3cc, Offset: 0x1686
// Size: 0x93
function private function_47f5711361b9f3b7( itemspawnlist, instance )
{
    level endon( #"game_ended" );
    
    if ( self.var_d419eaa0e3c862e )
    {
        return;
    }
    
    self.var_d419eaa0e3c862e = 1;
    instance waittill( #"progress_hub_give_reward" );
    lootquantity = getdvarint( @"hash_1261a641b03a5e93", 3 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( instance.origin, instance.angles );
    common_item::function_38cde6a6acb68ea6( itemspawnlist, lootquantity, spawnoptions );
}

// Namespace br_sierra_sidequest_hub
// Params 0
// Checksum 0x2e316f2, Offset: 0x1721
// Size: 0x65
function function_8a8c886721bc7701()
{
    if ( !self.animstruct )
    {
        animstruct = spawnstruct();
        animstruct.origin = self.origin;
        animstruct.angles = combineangles( self.angles, ( 0, 0, 0 ) );
        self.animstruct = animstruct;
    }
}

// Namespace br_sierra_sidequest_hub
// Params 3
// Checksum 0xb3a210f4, Offset: 0x178e
// Size: 0x173
function create_player_rig( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    self function_e19ccf4da1a61ba7( spawnpos );
    player_rig = spawn( "script_arms", spawnpos, 0, 0, self );
    self.player_rig = player_rig;
    player_rig.angles = spawnang;
    player_rig.player = self;
    player_rig hide( 1 );
    player_rig.animname = animname;
    player_rig useanimtree( #animtree );
    player_rig.updatedversion = 1;
    self playerlinktoabsolute( player_rig, "tag_origin" );
    self notify( #"rig_created" );
    utility::waittill_any( "killed_player", "remove_rig", "player_free_spot", "disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        self stopviewmodelanim();
        hackwaitframes = level.progresshub.var_dc83fc59522116a1;
        
        while ( hackwaitframes > 0 )
        {
            waitframe();
            hackwaitframes -= 1;
        }
        
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig ) && player_rig islinked() )
    {
        player_rig unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace br_sierra_sidequest_hub
// Params 1
// Checksum 0xa2af852, Offset: 0x1909
// Size: 0xa1
function hubanimend( player )
{
    player notify( #"remove_rig" );
    player unlink();
    player stopviewmodelanim();
    hackwaitframes = level.progresshub.var_dc83fc59522116a1;
    
    while ( hackwaitframes > 0 )
    {
        waitframe();
        hackwaitframes -= 1;
    }
    
    player thread inventory_utility::takegunlessweapon();
    
    if ( player.var_7548d3e3a1d7189b )
    {
        if ( player.var_7548d3e3a1d7189b islinked() )
        {
            player.var_7548d3e3a1d7189b unlink();
        }
        
        player.var_7548d3e3a1d7189b delete();
    }
}

// Namespace br_sierra_sidequest_hub
// Params 1, eflags: 0x4
// Checksum 0xc3ca5d0e, Offset: 0x19b2
// Size: 0x13b, Type: bool
function private function_9f3308ccedd58ebe( player )
{
    computer_array = getentitylessscriptablearray( "EEProgressHub", "script_noteworthy" );
    player_eye_origin = player geteye();
    physics_content = trace::create_default_contents();
    
    foreach ( computer in computer_array )
    {
        if ( distancesquared( computer.origin, player.origin ) <= 10000 )
        {
            if ( withinfov( computer.origin, computer.angles, player.origin, 0.25 ) )
            {
                trace_results = physics_raycast( player_eye_origin, computer.origin, physics_content, [ player ], 0, "physicsquery_closest", 0, 1 );
                
                if ( trace_results[ 0 ][ "scriptable" ] === computer )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace br_sierra_sidequest_hub
// Params 0, eflags: 0x4
// Checksum 0xa17ea427, Offset: 0x1af6
// Size: 0x26
function private user_player_goal_pos()
{
    return self.origin + rotatevector( ( 35, 0, -35 ), self.angles );
}

// Namespace br_sierra_sidequest_hub
// Params 4, eflags: 0x4
// Checksum 0xf6442f64, Offset: 0x1b25
// Size: 0x49
function private function_10e96a1d14d86739( player, var_e9340cc7e02fef5f, var_712d476a668bf41c, cameravalue )
{
    if ( var_e9340cc7e02fef5f )
    {
        player setcamerathirdperson( cameravalue );
    }
    
    player val::set( "progress_hub", "allow_toggle_third_person", var_712d476a668bf41c );
}

/#

    // Namespace br_sierra_sidequest_hub
    // Params 0, eflags: 0x4
    // Checksum 0xb8a8a2ad, Offset: 0x1b76
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace br_sierra_sidequest_hub
    // Params 0, eflags: 0x4
    // Checksum 0x397d18f4, Offset: 0x1b8a
    // Size: 0x44, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x42>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5e>", "<dev string:x6f>", &function_711bc088b53ce17e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x86>", "<dev string:x98>", &function_711bc088b53ce17e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sierra_sidequest_hub
    // Params 1, eflags: 0x4
    // Checksum 0x39a2c094, Offset: 0x1bd6
    // Size: 0x46, Type: dev
    function private function_711bc088b53ce17e( params )
    {
        player = level.players[ 0 ];
        player.var_d419eaa0e3c862e = 0;
        player.var_977d05794af867c3 = int( params[ 0 ] );
    }

#/
