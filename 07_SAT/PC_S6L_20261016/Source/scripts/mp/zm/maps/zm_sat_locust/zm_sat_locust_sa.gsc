// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_sa.gsc  (hash_053af0b407d523d4.gscc) (size: 11145 Bytes / 0x2b89 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda986c0e (3667422222)
// size ...... 11145 (0x2b89)
// includes .. 9   (offset: 0x2921)
// strings ... 30  (offset: 0x2969)
// dev strs .. 5   (offset: 0x2b4d)
// exports ... 29  (offset: 0x1af1)
// cseg ...... 0x2d9 + 0x1818 (0x1af1)
// imports ... 81  (offset: 0x1f79)
// animtree1 . 0   (offset: 0x2b89)
// animtree2 . 0   (offset: 0x2b89)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_sa;

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x5
// Checksum 0xad13ca6f, Offset: 0x2f7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"safe_area", undefined, undefined, &post_main );
}

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x4
// Checksum 0xc1b5f7d, Offset: 0x318
// Size: 0x48b
function private post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    nodes = [];
    node_locs = utility::getstructarray( "safe_area_node" );
    
    foreach ( node in node_locs )
    {
        subnodes = utility::getstructarray( node.target );
        assert( subnodes.size == 2, "<dev string:x24>" );
        var_a3097b302185ae68 = spawnstruct();
        
        foreach ( subnode in subnodes )
        {
            if ( !isdefined( subnode.script_noteworthy ) || !( subnode.script_noteworthy == "enter" || subnode.script_noteworthy == "exit" ) )
            {
                assertmsg( "<dev string:x42>" );
                continue;
            }
            
            interact = spawnscriptable( %"sat_zm_interact_locust", subnode.origin, subnode.angles );
            interact.area_type = subnode.script_noteworthy;
            interact.script_radius = subnode.script_radius;
            interact.script_label = subnode.script_label;
            interact.script_type = subnode.script_type ? getxhash( "in_safe_area_" + subnode.script_type ) : #"in_safe_area";
            interact.var_a3097b302185ae68 = var_a3097b302185ae68;
            interact.var_a3097b302185ae68.timeout_list = [];
            interact.destination = { #target:subnode.target, #origin:interact.origin };
            interaction::register_scriptable_interact( interact, &function_d3800ee2a9f74819, undefined, undefined, &function_a4f83afa9257e6f5 );
            
            switch ( interact.area_type )
            {
                case #"hash_ad26743aa94a54ed":
                    var_a3097b302185ae68.enter = interact;
                    interact.cooldown_list = [];
                    interact.script_int = subnode.script_int ?? 45;
                    break;
                case #"hash_cf84b0041cf92be5":
                    var_a3097b302185ae68.exit = interact;
                    break;
            }
            
            interact thread init_zone();
            
            if ( isdefined( subnode.script_flag_wait ) )
            {
                interact.script_flag_wait = subnode.script_flag_wait;
                interact thread node_wait_watcher();
            }
            
            if ( isdefined( subnode.script_flag_set ) )
            {
                interact.script_flag_set = subnode.script_flag_set;
            }
            
            if ( isdefined( subnode.script_string ) )
            {
                interact.script_string = subnode.script_string;
            }
            
            if ( isdefined( subnode.script_parameters ) )
            {
                interact.script_sound = subnode.script_parameters;
            }
        }
        
        assert( isdefined( var_a3097b302185ae68.enter ) && isdefined( var_a3097b302185ae68.exit ), "<dev string:x77>" );
        nodes[ nodes.size ] = var_a3097b302185ae68;
    }
    
    if ( nodes.size > 0 )
    {
        init_ai_group();
        function_fff8803f7fcc8087();
        level callback::add( "on_round_start", &on_round_start );
        level callback::add( "zone_changed", &on_zone_changed );
        level callback::add( "on_agent_spawned", &function_24bb5c2aa0708efb );
        level callback::add( #"player_spawned", &on_player_spawned );
        level callback::add( #"hash_a533dd0ef17a6d8f", &function_25400073d7c664d8 );
        zm_quest::function_3c363613c60958f5( "safe_area_disabled" );
        level.safe_area = { #nodes:nodes };
    }
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0x1a791c49, Offset: 0x7ab
// Size: 0x8e
function private function_d3800ee2a9f74819( player )
{
    if ( isdefined( self.cooldown_list ) && arraycontains( self.cooldown_list, player ) )
    {
        return;
    }
    
    if ( player zm_quest::function_9b18c35fba5c3d31() )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    if ( level callback::response( 1, #"hash_70cbab924cc4ae29", { #type:self.area_type, #interact:self, #player:player } ) )
    {
        return;
    }
    
    player thread function_3b5f002c0f1e6207( self );
}

// Namespace zm_sat_locust_sa
// Params 2, eflags: 0x4
// Checksum 0xe2b5eeb8, Offset: 0x841
// Size: 0x244
function private function_a4f83afa9257e6f5( interact, player )
{
    if ( isdefined( interact.cooldown_list ) && arraycontains( interact.cooldown_list, player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_hud/safe_area_cooldown", #type:"HINT_NOBUTTON" };
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_disabled", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.area_type == "enter" )
    {
        if ( isdefined( interact.script_string ) )
        {
            switch ( interact.script_string )
            {
                case #"hash_785c3dd957dac4c2":
                    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_enter_robot_head", #type:"HINT_BUTTON" };
                case #"hash_9a2adde286aaf659":
                    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_enter_lighthouse", #type:"HINT_BUTTON" };
            }
        }
        
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_enter", #type:"HINT_BUTTON" };
    }
    
    if ( interact.area_type == "exit" )
    {
        if ( isdefined( interact.script_string ) )
        {
            switch ( interact.script_string )
            {
                case #"hash_a039e87976410ba8":
                    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_exit_robot_shoulder", #type:"HINT_BUTTON" };
                case #"hash_48d5c3ce1ec05a04":
                    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_exit_robot_foot", #type:"HINT_BUTTON" };
            }
        }
        
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_sa_exit", #type:"HINT_BUTTON" };
    }
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0xa04ce799, Offset: 0xa8d
// Size: 0xb0
function private function_3b5f002c0f1e6207( interact )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    callback::callback( #"hash_525068440908e3dc", { #type:interact.area_type, #interact:interact, #player:self } );
    
    if ( interact.area_type == "enter" )
    {
        if ( self.var_420915a121e1cc41 )
        {
            return;
        }
        
        childthread player_enter_safe_area( interact );
        return;
    }
    
    if ( isdefined( self.var_420915a121e1cc41 ) && !self.var_420915a121e1cc41 )
    {
        return;
    }
    
    childthread function_13d2bc75a82f1974( interact );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0x555ce6ea, Offset: 0xb45
// Size: 0xa3
function private player_enter_safe_area( interact )
{
    function_96eed93cb9eae83f( "enter", interact );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    childthread function_ed46a236b17a07dd( interact );
    
    if ( level callback::response( 1, #"safe_area_countdown", { #player:self, #interact:interact } ) )
    {
        return;
    }
    
    interact.var_a3097b302185ae68.timeout_list[ interact.var_a3097b302185ae68.timeout_list.size ] = self;
    childthread function_3820e965c4fdaf6f( interact );
    
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        function_feb153fc05d143de( interact );
    }
}

// Namespace zm_sat_locust_sa
// Params 4, eflags: 0x4
// Checksum 0x41350c5f, Offset: 0xbf0
// Size: 0x78
function private function_13d2bc75a82f1974( interact, var_6779a2f075a575a3 = 0, skip_teleport = 0, was_timeout = 0 )
{
    result = function_96eed93cb9eae83f( "exit", interact, var_6779a2f075a575a3, skip_teleport, was_timeout );
    
    if ( !isalive( self ) || !result )
    {
        return;
    }
    
    childthread blast_nearby_enemies( 0, 0, 1 );
}

// Namespace zm_sat_locust_sa
// Params 5, eflags: 0xc
// Checksum 0xf68e2320, Offset: 0xc70
// Size: 0x445
function private function_96eed93cb9eae83f( type, interact, var_6779a2f075a575a3 = 0, skip_teleport = 0, was_timeout = 0 )
{
    self notify( #"hash_f4eea3c51e587cc5" );
    self endon( #"hash_f4eea3c51e587cc5" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( interact.script_flag_set ) && !utility::flag( interact.script_flag_set ) )
    {
        utility::flag_set( interact.script_flag_set );
    }
    
    if ( type == "enter" )
    {
        val::set( "zm_safe_area_unlock", "killstreaks", 0 );
        val::set( "zm_safe_area_unlock", "supers", 0 );
        val::set( "zm_safe_area_unlock", "ignore_afk", 1 );
        val::set( "zm_safe_area_unlock", "round_spawning_ignore_player", 1 );
        val::set( "zm_safe_area_unlock", "ignore_playable_area_check", 1 );
        zm_quest::disable_specific_player_bgb( 1 );
        self.var_420915a121e1cc41 = 1;
        self setclientomnvar( "ui_zm_is_in_vault", 1 );
        self setthreatbiasgroup( "zm_vault_threat_player" );
        
        if ( !skip_teleport )
        {
            level thread zm_fasttravel_core::function_cbb08198e7c84adf( interact.var_a3097b302185ae68.enter.destination, self, undefined, 0, undefined, 3.5 );
            self playsoundevent( getxhashasset( interact.var_a3097b302185ae68.enter.script_sound ) );
        }
        
        callback::callback( #"hash_ced83715576a5279", { #type:type, #interact:interact, #player:self } );
    }
    else
    {
        self notify( #"hash_158754c5a64d9261" );
        callback::callback( #"hash_b0301b9d692ed6b1", { #type:type, #interact:interact, #player:self } );
        exit_data = { #was_timeout:was_timeout, #player:self, #node:interact.var_a3097b302185ae68 };
        exit_override = level callback::response( 0, #"hash_3f5e2e699aadded2", exit_data );
        
        if ( exit_override )
        {
            skip_teleport = 1;
            var_6779a2f075a575a3 = 1;
        }
        
        if ( !skip_teleport )
        {
            level thread zm_fasttravel_core::function_cbb08198e7c84adf( interact.var_a3097b302185ae68.exit.destination, self, undefined, 0, undefined, 3.5 );
            self playsoundevent( getxhashasset( interact.var_a3097b302185ae68.exit.script_sound ) );
        }
    }
    
    if ( !var_6779a2f075a575a3 )
    {
        self waittill( #"fasttravel_finished" );
    }
    
    if ( type == "exit" && isdefined( self ) )
    {
        ui_interact = function_15e1d39bcf76b81( self );
        
        if ( ui_interact )
        {
            thread function_d96af6edac5ca79c( ui_interact );
        }
        
        callback::callback( #"hash_e7672bcc96148159", { #type:type, #interact:interact, #player:self } );
        self notify( #"hash_b4a67d49d98f7e29" );
        val::reset_all( "zm_safe_area_unlock" );
        zm_quest::disable_specific_player_bgb( 0 );
        self.var_420915a121e1cc41 = 0;
        self setclientomnvar( "ui_zm_is_in_vault", 0 );
        self setthreatbiasgroup( "player_team" );
        
        if ( exit_override && exit_data.type == "ejection" )
        {
            destination = zm_sat_locust_rej::function_b938ebbbff3b0b39( level.robot_ejection_tubes.random_landings, 1 );
            var_d3823b80b1397854 = { #angles:self.angles, #origin:self.origin, #destination:destination };
            params = { #skip_narrative_room:1, #var_a8f377bd77c5267e:1, #player:self, #var_d3823b80b1397854:var_d3823b80b1397854 };
            level thread zm_sat_locust_rej::ejection_sequence( params );
            return 0;
        }
        
        return 1;
    }
}

// Namespace zm_sat_locust_sa
// Params 2, eflags: 0x4
// Checksum 0xa657faf9, Offset: 0x10bd
// Size: 0xd8
function private function_15e1d39bcf76b81( player, var_5527cdc0b445c976 = 0 )
{
    ui_interact = undefined;
    
    foreach ( node in level.safe_area.nodes )
    {
        if ( arraycontains( node.timeout_list, player ) )
        {
            ui_interact = node.exit;
            break;
        }
    }
    
    if ( ui_interact )
    {
        player thread remove_player_ui( ui_interact, var_5527cdc0b445c976 );
    }
    
    return ui_interact;
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0xaaf5fb56, Offset: 0x119e
// Size: 0x111
function private function_d96af6edac5ca79c( interact )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_c14f946ebf4aaea3" );
    
    if ( interact.var_a3097b302185ae68.enter.cooldown_list.size == 0 || !arraycontains( interact.var_a3097b302185ae68.enter.cooldown_list, self ) )
    {
        interact.var_a3097b302185ae68.enter.cooldown_list[ interact.var_a3097b302185ae68.enter.cooldown_list.size ] = self;
    }
    
    level waittill( #"round_started" );
    interact.var_a3097b302185ae68.enter.cooldown_list = arrayremove( interact.var_a3097b302185ae68.enter.cooldown_list, self );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0xc
// Checksum 0x86dfb5d4, Offset: 0x12b7
// Size: 0xc1
function private function_3820e965c4fdaf6f( interact )
{
    self notify( #"hash_d5e9aa2035d14c02" );
    self endon( #"hash_d5e9aa2035d14c02" );
    self endon( #"hash_c14f946ebf4aaea3" );
    self endon( #"hash_b4a67d49d98f7e29" );
    self endon( #"hash_158754c5a64d9261" );
    childthread function_48e0f22e44a793d3( interact );
    childthread function_64a58cd635805010( 1, "safe_area_last_ten_secs" );
    childthread function_af90a685c8c1540e( interact );
    wait interact.script_int - 10;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        function_feb153fc05d143de( interact, 10000 );
    }
    
    self notify( #"safe_area_last_ten_secs" );
    childthread function_64a58cd635805010( 0, "safe_area_cut_countdown" );
    wait 10;
    self notify( #"safe_area_cut_countdown" );
    thread function_13d2bc75a82f1974( interact, 0, 0, 1 );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0xc
// Checksum 0x9817960c, Offset: 0x1380
// Size: 0x76
function private function_48e0f22e44a793d3( interact )
{
    self notify( #"hash_13a72adadd3e453c" );
    self endon( #"hash_13a72adadd3e453c" );
    self endon( #"hash_b4a67d49d98f7e29" );
    self endon( #"hash_158754c5a64d9261" );
    self waittill( #"hash_544a6aa7b92eaeb5", var_6779a2f075a575a3, skip_teleport, was_timeout );
    thread function_13d2bc75a82f1974( interact, var_6779a2f075a575a3, skip_teleport, was_timeout );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0xc
// Checksum 0x19cfa9ed, Offset: 0x13fe
// Size: 0x56
function private function_af90a685c8c1540e( interact )
{
    self notify( #"hash_70f1418f2b6f1e4e" );
    self endon( #"hash_70f1418f2b6f1e4e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    thread function_13d2bc75a82f1974( interact, 1, 1 );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0xc
// Checksum 0x11eed10e, Offset: 0x145c
// Size: 0x12c
function private function_ed46a236b17a07dd( interact )
{
    self notify( #"hash_921e767e7eab8488" );
    self endon( #"hash_921e767e7eab8488" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b4a67d49d98f7e29" );
    self endon( #"hash_158754c5a64d9261" );
    
    while ( self.var_420915a121e1cc41 )
    {
        self waittill( #"zone_changed", zone_name );
        assert( zone_manager::function_427ae6b3bc10b5ac( self.origin, zone_name ), "<dev string:xae>" + self.origin + "<dev string:xc0>" + zone_name );
        zone = zone_manager::get_zone_struct( zone_name );
        
        if ( self.var_420915a121e1cc41 && interact.var_a3097b302185ae68.exit.zone.zone_name != zone_name || !zone.is_enabled || !zone_manager::function_65305a611c6226d9( self.origin ) )
        {
            thread function_13d2bc75a82f1974( interact, 1, 1 );
        }
    }
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0x8b9fa3f8, Offset: 0x1590
// Size: 0x18
function private on_round_start( var_8582cc5f29b6732c )
{
    level notify( #"round_started" );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0x78933ad3, Offset: 0x15b0
// Size: 0x55
function private on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) && isdefined( params.zone_struct.zone_name ) )
    {
        self notify( #"zone_changed", params.zone_struct.zone_name );
    }
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0xa7fec82d, Offset: 0x160d
// Size: 0x17
function private function_24bb5c2aa0708efb( params )
{
    self setthreatbiasgroup( "zm_vault_threat" );
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0xc72c5af7, Offset: 0x162c
// Size: 0x17
function private on_player_spawned( params )
{
    self setthreatbiasgroup( "player_team" );
}

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x4
// Checksum 0xfafaf472, Offset: 0x164b
// Size: 0x6d
function private init_ai_group()
{
    if ( !threatbiasgroupexists( "zm_vault_threat_player" ) )
    {
        createthreatbiasgroup( "zm_vault_threat_player" );
    }
    
    if ( !threatbiasgroupexists( "zm_vault_threat" ) )
    {
        createthreatbiasgroup( "zm_vault_threat" );
    }
    
    if ( !threatbiasgroupexists( "player_team" ) )
    {
        createthreatbiasgroup( "player_team" );
    }
    
    if ( !threatbiasgroupexists( "zm_vault_threat_inside_zombie" ) )
    {
        createthreatbiasgroup( "zm_vault_threat_inside_zombie" );
    }
    
    setignoremegroup( "zm_vault_threat_player", "zm_vault_threat" );
}

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x4
// Checksum 0x6745f989, Offset: 0x16c0
// Size: 0x17
function private function_fff8803f7fcc8087()
{
    utility::add_fx( #"safe_area_blast", "vfx_t10_levels_zm_quartz_clearing_blast" );
}

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x4
// Checksum 0x785b234f, Offset: 0x16df
// Size: 0x26
function private init_zone()
{
    utility::flag_wait( "zone_setup_finished" );
    self.zone = zone_manager::function_90e5c3e2272b0130( self.origin );
}

// Namespace zm_sat_locust_sa
// Params 0, eflags: 0x4
// Checksum 0xb80222ed, Offset: 0x170d
// Size: 0x79
function private node_wait_watcher()
{
    utility::flag_wait( self.script_flag_wait );
    self setscriptablepartstate( "interact", "enabled_" + self.script_radius );
    
    if ( self.area_type == "enter" && self.script_label == "objective" )
    {
        self setscriptablepartstate( "objective", self.var_a3097b302185ae68.enter.script_string );
    }
}

// Namespace zm_sat_locust_sa
// Params 3, eflags: 0x4
// Checksum 0x9713241d, Offset: 0x178e
// Size: 0x7c
function private blast_nearby_enemies( var_8473f30fa3f8a348 = 1, var_79aebce64a2c1ae4 = 1, b_forceannihilate = 0 )
{
    self playsoundevent( %"sndevent_vault_clear_blast" );
    playfxontag( utility::getfx( #"safe_area_blast" ), self, "tag_origin" );
    zm_quest::function_835556fe63cd2edd( self.origin, 256, 0, 1, var_8473f30fa3f8a348, var_79aebce64a2c1ae4, b_forceannihilate, 0 );
}

// Namespace zm_sat_locust_sa
// Params 2, eflags: 0x4
// Checksum 0x11523396, Offset: 0x1812
// Size: 0x5a
function private function_64a58cd635805010( var_6f1a82b73d7d6094, str_end_msg )
{
    if ( isdefined( str_end_msg ) )
    {
        self endon( str_end_msg );
    }
    
    while ( self.var_420915a121e1cc41 )
    {
        if ( var_6f1a82b73d7d6094 )
        {
            self playsoundtoplayer( #"hash_9a83ce5da0e5e56d", self );
        }
        else
        {
            self playsoundtoplayer( #"hash_fc4cc1352a8de4af", self );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_locust_sa
// Params 1, eflags: 0x4
// Checksum 0x76d09ac3, Offset: 0x1874
// Size: 0x20
function private function_25400073d7c664d8( params )
{
    function_15e1d39bcf76b81( params.player, 1 );
}

// Namespace zm_sat_locust_sa
// Params 1
// Checksum 0x4bbec010, Offset: 0x189c
// Size: 0x115
function function_93f25e062d584684( ref )
{
    foreach ( node in level.safe_area.nodes )
    {
        if ( node.enter.script_string == ref )
        {
            node.enter setscriptablepartstate( #"interact", #"default" );
            node.exit setscriptablepartstate( #"interact", #"default" );
            node.enter.disabled = 1;
            node.exit.disabled = 1;
        }
    }
}

// Namespace zm_sat_locust_sa
// Params 2, eflags: 0x4
// Checksum 0x6f88e68, Offset: 0x19b9
// Size: 0x85
function private function_feb153fc05d143de( interact, time )
{
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"safe_area", interact.script_type );
    zm_quest::function_fb3af5600f6a9441( 2, 0, #"safe_area", interact.script_type );
    
    if ( !isdefined( time ) )
    {
        time = interact.script_int * 1000;
    }
    
    zm_quest::function_612a9ad0db22c29c( time, 0, #"safe_area", interact.script_type );
}

// Namespace zm_sat_locust_sa
// Params 2, eflags: 0x4
// Checksum 0xe1085a03, Offset: 0x1a46
// Size: 0xab
function private remove_player_ui( interact, var_5527cdc0b445c976 = 0 )
{
    if ( !var_5527cdc0b445c976 )
    {
        interact.var_a3097b302185ae68.timeout_list = arrayremove( interact.var_a3097b302185ae68.timeout_list, self );
    }
    
    zm_quest::function_194bde735238c397( 0, 0, #"safe_area", interact.script_type );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"safe_area", interact.script_type );
    waitframe();
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"safe_area", interact.script_type );
}

