// scripts\mp\ob\contracts\ob_contract_most_wanted.gsc  (hash_620ccc95b4c66c54.gscc) (size: 5245 Bytes / 0x147d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1f7472e (2717337390)
// size ...... 5245 (0x147d)
// includes .. 13  (offset: 0x131d)
// strings ... 5   (offset: 0x1385)
// dev strs .. 13  (offset: 0x13e1)
// exports ... 19  (offset: 0x9bd)
// cseg ...... 0x9d + 0x920 (0x9bd)
// imports ... 55  (offset: 0xcb5)
// animtree1 . 0   (offset: 0x147d)
// animtree2 . 0   (offset: 0x147d)
#using script_4dbf393b22261d86;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\menus;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\squads;

#namespace ob_contract_most_wanted;

// Namespace ob_contract_most_wanted
// Params 0, eflags: 0x5
// Checksum 0x6b467166, Offset: 0xbb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_contract_most_wanted", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_contract_most_wanted
// Params 0, eflags: 0x4
// Checksum 0xa719d0ab, Offset: 0xe4
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_MOST_WANTED", &activity_type_init );
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0x25bbf3ae, Offset: 0xff
// Size: 0xa9
function activity_type_init()
{
    /#
        thread init_devgui();
    #/
    
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 0, &instance_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 1, &instance_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 2, &instance_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 3, &instance_cleanup );
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 4, &function_3201f1f01a94887f );
    activity_common::function_944074f3079c1d4e( "REV_OB_MOST_WANTED", 5, &get_reward_struct );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_MOST_WANTED" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_MOST_WANTED" );
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0xb180a7f4, Offset: 0x1b0
// Size: 0x12
function instance_setup()
{
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0x1eb787d5, Offset: 0x1ca
// Size: 0x70
function instance_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    assert( isdefined( self.most_wanted ) );
    ob_contract_ui_widget::function_855fd697c30b090c( self.most_wanted getentitynumber() );
    self.most_wanted attach( %"prop_zc_game_flag", #"tag_stowed_back3", 1 );
    thread function_710f0a9a49728d51();
    thread function_5cbb75887a45e42c();
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0xc2d6f4fa, Offset: 0x242
// Size: 0x9
function instance_end()
{
    most_wanted_cleanup();
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0xc71e6b69, Offset: 0x253
// Size: 0x9
function instance_cleanup()
{
    most_wanted_cleanup();
}

// Namespace ob_contract_most_wanted
// Params 1
// Checksum 0x94b943c9, Offset: 0x264
// Size: 0xfe
function set_most_wanted( most_wanted )
{
    /#
        if ( getdvarint( @"scr_most_wanted_player", -1 ) >= 0 )
        {
            player = level.players[ getdvarint( @"scr_most_wanted_player" ) ];
            
            if ( isdefined( player ) )
            {
                most_wanted = player;
            }
        }
    #/
    
    self.most_wanted = most_wanted;
    self.most_wanted.var_789b7a49ee864fec = namespace_d7fa4530141146a5::function_de87bf7072515cd3( self.var_91c91f4a631c481d.objectivemarker, 0, 0 );
    objidpoolmanager::update_objective_onentity( self.most_wanted.var_789b7a49ee864fec, self.most_wanted );
    objective_hidefromplayersinmask( self.most_wanted.var_789b7a49ee864fec );
    function_38b84cb3d4357dd7( self.most_wanted.var_789b7a49ee864fec );
    objective_addclienttomask( self.most_wanted.var_789b7a49ee864fec, self.most_wanted );
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0xd980aa06, Offset: 0x36a
// Size: 0x39
function most_wanted_cleanup()
{
    if ( isdefined( self.most_wanted ) )
    {
        self.most_wanted detach( %"prop_zc_game_flag", #"tag_stowed_back3" );
    }
    
    self.most_wanted = undefined;
}

// Namespace ob_contract_most_wanted
// Params 0, eflags: 0x4
// Checksum 0x62ac45a3, Offset: 0x3ab
// Size: 0x5c
function private function_710f0a9a49728d51()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    countdown = getdvarint( @"hash_f99e6215770deffe", self.var_91c91f4a631c481d.countdownsec );
    ob_contract_ui_widget::function_2ee97780d0898a9b( countdown );
    wait countdown;
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_contract_most_wanted
// Params 0, eflags: 0xc
// Checksum 0x12c4e6f3, Offset: 0x40f
// Size: 0x68
function private function_5cbb75887a45e42c()
{
    self notify( #"hash_ff01b3961aba3d37" );
    self endon( #"hash_ff01b3961aba3d37" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( !isdefined( self.most_wanted ) || self.most_wanted ob_laststand::is_eliminated() )
        {
            break;
        }
        
        waitframe();
    }
    
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_contract_most_wanted
// Params 1
// Checksum 0x8ff80e58, Offset: 0x47f
// Size: 0xf9
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    if ( self.state == "Idle" && !isdefined( self.most_wanted ) )
    {
        set_most_wanted( player_list[ 0 ] );
        activity_instance_common::function_46135a69bddfec2c( self );
    }
    
    if ( isdefined( self.most_wanted ) )
    {
        foreach ( player in player_list )
        {
            objective_addclienttomask( self.most_wanted.var_789b7a49ee864fec, player );
        }
    }
}

// Namespace ob_contract_most_wanted
// Params 1
// Checksum 0x6cae95af, Offset: 0x580
// Size: 0xe2
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.state == "Active" && arraycontains( player_list, self.most_wanted ) )
    {
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    if ( isdefined( self.most_wanted ) )
    {
        foreach ( player in player_list )
        {
            objective_removeclientfrommask( self.most_wanted.var_789b7a49ee864fec, player );
        }
    }
}

// Namespace ob_contract_most_wanted
// Params 0
// Checksum 0x7d125f84, Offset: 0x66a
// Size: 0x15
function function_3201f1f01a94887f()
{
    return self.most_wanted.origin;
}

// Namespace ob_contract_most_wanted
// Params 1
// Checksum 0xd19d1ea2, Offset: 0x688
// Size: 0x8f
function get_reward_struct( relevantinfostruct )
{
    player = self.most_wanted;
    
    if ( !isdefined( player ) )
    {
        player = self.playerparticipants[ 0 ];
    }
    
    var_ed2431ff5fd3b5d8 = player.origin + anglestoforward( player.angles ) * 60;
    var_ed2431ff5fd3b5d8 = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    var_ed2431ff5fd3b5d8 = utility::drop_to_ground( var_ed2431ff5fd3b5d8 );
    return { #angles:( 0, 0, 0 ), #origin:var_ed2431ff5fd3b5d8 };
}

/#

    // Namespace ob_contract_most_wanted
    // Params 1
    // Checksum 0x6cd2ee77, Offset: 0x720
    // Size: 0xdd, Type: dev
    function init_devgui( params )
    {
        setdvarifuninitialized( @"scr_most_wanted_player", -1 );
        setdvarifuninitialized( @"hash_dcf2b9526e86ba33", -1 );
        level thread function_a63131d304e9c01c();
        wait 1;
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x50>", "<dev string:x66>", &function_dccc41f06ad47554, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7b>", "<dev string:x91>", &function_dccc41f06ad47554, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa6>", "<dev string:xbc>", &function_dccc41f06ad47554, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd1>", "<dev string:xe7>", &function_dccc41f06ad47554, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfc>", "<dev string:x112>", &function_dccc41f06ad47554, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x127>", "<dev string:x13d>", &function_dccc41f06ad47554, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_contract_most_wanted
    // Params 0
    // Checksum 0xbf6ecfb0, Offset: 0x805
    // Size: 0x5c, Type: dev
    function function_a63131d304e9c01c()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            val = getdvarint( @"hash_dcf2b9526e86ba33", -1 );
            
            if ( val >= 0 )
            {
                setdvar( @"hash_dcf2b9526e86ba33", -1 );
                function_dccc41f06ad47554( [ val ] );
            }
            
            wait 1;
        }
    }

    // Namespace ob_contract_most_wanted
    // Params 1
    // Checksum 0x7969bbbd, Offset: 0x869
    // Size: 0x154, Type: dev
    function function_dccc41f06ad47554( params )
    {
        index = int( params[ 0 ] );
        player = level.players[ index ];
        
        if ( !isdefined( player.most_wanted_original_team ) )
        {
            if ( !isdefined( player.most_wanted_original_team ) )
            {
                player.most_wanted_original_team = player.team;
            }
            
            if ( !isdefined( player.var_cb733b3c39ce881f ) )
            {
                player.var_cb733b3c39ce881f = player.sessionsquadid;
            }
            
            if ( !isdefined( player.var_2020cf1489015e6e ) )
            {
                player.var_2020cf1489015e6e = player.sessionuimemberindex;
            }
            
            var_a229f55b7f2358f = level.teamnamelist[ 2 + index ];
            player menus::addtoteam( var_a229f55b7f2358f, 0, 1, 1 );
            player squads::joinsquad( var_a229f55b7f2358f, 0, player.var_2020cf1489015e6e );
        }
        else
        {
            player menus::addtoteam( player.most_wanted_original_team, 0, 1, 1 );
            player squads::joinsquad( player.most_wanted_original_team, player.var_cb733b3c39ce881f, player.var_2020cf1489015e6e );
            player.most_wanted_original_team = undefined;
        }
        
        namespace_e1c8f2179967550d::function_28efaa36817be8e7( [ player ] );
    }

#/
