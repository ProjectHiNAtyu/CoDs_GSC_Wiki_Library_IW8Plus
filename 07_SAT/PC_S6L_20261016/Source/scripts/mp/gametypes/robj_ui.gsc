// scripts\mp\gametypes\robj_ui.gsc  (hash_7c32d91c895c063e.gscc) (size: 7503 Bytes / 0x1d4f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24a9c764 (615106404)
// size ...... 7503 (0x1d4f)
// includes .. 4   (offset: 0x1bab)
// strings ... 24  (offset: 0x1bcb)
// dev strs .. 0   (offset: 0x1d4f)
// exports ... 38  (offset: 0x10eb)
// cseg ...... 0x24d + 0xe9e (0x10eb)
// imports ... 37  (offset: 0x16db)
// animtree1 . 0   (offset: 0x1d4f)
// animtree2 . 0   (offset: 0x1d4f)
#using script_1aadb848a02a4cf5;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;

#namespace robj_ui;

// Namespace robj_ui
// Params 1
// Checksum 0xb5225c8e, Offset: 0x26b
// Size: 0x26
function function_1fda9f4f027c2cf3( player )
{
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0 );
}

// Namespace robj_ui
// Params 1
// Checksum 0xd9aa45ae, Offset: 0x299
// Size: 0x27
function starthacking( player )
{
    player setclientomnvar( "ui_securing", 26 );
    player setclientomnvar( "ui_securing_progress", 0 );
}

// Namespace robj_ui
// Params 2
// Checksum 0xf5291f17, Offset: 0x2c8
// Size: 0x23
function function_f19a15bd598a6bea( player, progress )
{
    player setclientomnvar( "ui_securing_progress", progress );
}

// Namespace robj_ui
// Params 1
// Checksum 0xdb89f756, Offset: 0x2f3
// Size: 0x19
function stophacking( player )
{
    player setclientomnvar( "ui_securing", 0 );
}

// Namespace robj_ui
// Params 0
// Checksum 0xf38b029, Offset: 0x314
// Size: 0x24
function function_ae96f9bb6ab7f2f8()
{
    setomnvar( "ui_bomb_owner_team", -1 );
    setomnvar( "ui_bomb_timer_endtime", 0 );
    setomnvar( "ui_objective_timer_stopped", 0 );
}

// Namespace robj_ui
// Params 3
// Checksum 0xa84bc3c, Offset: 0x340
// Size: 0x6f
function startcapture( team, endtimems, paused )
{
    setomnvar( "ui_bomb_timer_endtime", endtimems );
    
    if ( paused )
    {
        setomnvar( "ui_objective_timer_stopped", 1 );
    }
    else
    {
        setomnvar( "ui_objective_timer_stopped", 0 );
    }
    
    if ( team == "allies" )
    {
        setomnvar( "ui_bomb_owner_team", 2 );
        return;
    }
    
    setomnvar( "ui_bomb_owner_team", 1 );
}

// Namespace robj_ui
// Params 0
// Checksum 0xadc16350, Offset: 0x3b7
// Size: 0xe
function function_cee4f50a29798dab()
{
    setomnvar( "ui_objective_timer_stopped", 1 );
}

// Namespace robj_ui
// Params 0
// Checksum 0x684add6, Offset: 0x3cd
// Size: 0xd
function function_8c31e99f3cffd44a()
{
    setomnvar( "ui_objective_timer_stopped", 0 );
}

// Namespace robj_ui
// Params 1
// Checksum 0x20c88ff6, Offset: 0x3e2
// Size: 0x37
function function_63c928de53b81212( player )
{
    uid = "SECURE_REACH_UID";
    ui_key = "SECURE_REACH";
    player start_objective( uid, ui_key );
}

// Namespace robj_ui
// Params 1
// Checksum 0xd5dd923b, Offset: 0x421
// Size: 0x27
function function_4d33ef19991b352d( player )
{
    uid = "SECURE_REACH_UID";
    player complete_objective( uid );
}

// Namespace robj_ui
// Params 1
// Checksum 0xde06a0f1, Offset: 0x450
// Size: 0x37
function function_29ded81d838b99f1( player )
{
    uid = "SECURE_FIND_UID";
    ui_key = "SECURE_FIND";
    player start_objective( uid, ui_key );
}

// Namespace robj_ui
// Params 1
// Checksum 0x3eb489f9, Offset: 0x48f
// Size: 0x27
function function_e97154b8d8fd073e( player )
{
    uid = "SECURE_FIND_UID";
    player complete_objective( uid );
}

// Namespace robj_ui
// Params 1
// Checksum 0x21ca8656, Offset: 0x4be
// Size: 0x40
function function_9860302b02a6f5c6( player )
{
    uid_reach = "SECURE_REACH_UID";
    player clear_objective( uid_reach );
    uid_find = "SECURE_FIND_UID";
    player clear_objective( uid_find );
}

// Namespace robj_ui
// Params 1
// Checksum 0xa4830900, Offset: 0x506
// Size: 0xc3
function detectplayerinsidequestcircle( player )
{
    player notify( #"hash_ca990f0ff7ea449b" );
    player endon( #"hash_ca990f0ff7ea449b" );
    player endon( #"disconnect" );
    
    while ( !isdefined( level.robj_quest ) )
    {
        waitframe();
    }
    
    quest_circle_origin = level.robj_quest game_utility::questcircle_getorigin();
    
    while ( true )
    {
        if ( distance2d( quest_circle_origin, player.origin ) < 512 )
        {
            player setclientomnvar( "ui_quest_circle_opacity_change", 1 );
            function_a61934df767b7a5c( player );
            function_4d33ef19991b352d( player );
            function_29ded81d838b99f1( player );
        }
        else
        {
            function_45b593ede807aae8( player );
            player setclientomnvar( "ui_quest_circle_opacity_change", 0 );
        }
        
        waitframe();
    }
}

// Namespace robj_ui
// Params 1
// Checksum 0x955ef0a3, Offset: 0x5d1
// Size: 0x24
function init_obj_tracker( player )
{
    namespace_4c5fce57fb970de0::player_init( player, "ObjectiveTracker", "scripted_widget_objective_tracker_jup_robj", 47, 383 );
}

// Namespace robj_ui
// Params 2
// Checksum 0xdddc6961, Offset: 0x5fd
// Size: 0x87
function start_objective( uid, ui_key )
{
    completed = 0;
    player_has_objective = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( isdefined( self.objective_tracker ) )
    {
        if ( !player_has_objective )
        {
            self.objective_tracker.next_uid = uid;
            namespace_4c5fce57fb970de0::add_objective( uid, undefined, undefined, ui_key, completed );
        }
    }
}

// Namespace robj_ui
// Params 1
// Checksum 0xc6d7f1ac, Offset: 0x68c
// Size: 0x71
function complete_objective( uid )
{
    player_has_objective = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( player_has_objective && !self.objective_tracker.objectives[ uid ].is_completed )
    {
        namespace_4c5fce57fb970de0::on_objective_complete( uid, 1 );
    }
}

// Namespace robj_ui
// Params 1
// Checksum 0x4bc275e9, Offset: 0x705
// Size: 0x4a
function clear_objective( uid )
{
    var_1050e0459943c8f0 = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( var_1050e0459943c8f0 )
    {
        namespace_4c5fce57fb970de0::remove_objective( uid );
    }
}

// Namespace robj_ui
// Params 0
// Checksum 0x11aa8dca, Offset: 0x757
// Size: 0x8a
function get_current_objective()
{
    current_obj = undefined;
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.next_uid ) )
    {
        next_uid = self.objective_tracker.next_uid;
    }
    
    if ( isdefined( next_uid ) && isdefined( self.objective_tracker.objectives[ next_uid ] ) )
    {
        current_obj = self.objective_tracker.objectives[ next_uid ];
    }
    
    return current_obj;
}

// Namespace robj_ui
// Params 0
// Checksum 0x7e4b6b9d, Offset: 0x7ea
// Size: 0xf6
function function_f6f52c75e5b02c9()
{
    visibility = 0;
    
    foreach ( objective in level.current_objectives )
    {
        scriptablename = "";
        
        if ( isdefined( objective.scriptable ) && isdefined( objective.scriptable.type ) )
        {
            scriptablename = objective.scriptable.type;
        }
        
        if ( scriptablename == "mp_secure_outdoor_objective_01" || scriptablename == "mp_secure_indoor_objective_01" )
        {
            visibility = 1;
            break;
        }
    }
    
    self setclientomnvar( "ui_secure_overlay_active", visibility );
}

// Namespace robj_ui
// Params 0
// Checksum 0x6b597a67, Offset: 0x8e8
// Size: 0x146
function update_objective_ui()
{
    if ( !( isdefined( self ) && isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) ) )
    {
        return;
    }
    
    self.objective_tracker.var_6d4c835bb3019325 = level.framedurationseconds;
    current_obj = get_current_objective();
    
    if ( isdefined( current_obj ) )
    {
        if ( !isdefined( self.objective_tracker.active_uid ) )
        {
            namespace_4c5fce57fb970de0::function_cfd35a1d757761ed( current_obj.uid, current_obj.ui_key, current_obj.is_completed, current_obj.is_successful );
        }
        else if ( self.objective_tracker.active_uid != current_obj.uid )
        {
            namespace_4c5fce57fb970de0::function_5ed9e57658a48212();
        }
        else if ( self.objective_tracker.active_completed != current_obj.is_completed )
        {
            if ( current_obj.is_completed )
            {
                namespace_4c5fce57fb970de0::function_a119c385540b5a9b( current_obj.is_successful );
            }
        }
    }
    else if ( isdefined( self.objective_tracker.active_uid ) )
    {
        namespace_4c5fce57fb970de0::function_5ed9e57658a48212();
    }
    
    function_f6f52c75e5b02c9();
}

// Namespace robj_ui
// Params 2
// Checksum 0x805f96c8, Offset: 0xa36
// Size: 0xa2
function create_objective_marker( origin, type )
{
    marker_type = get_valid_marker_type( type );
    marker = gameobjects::createobjidobject( get_offset_origin( origin ), "neutral", ( 0, 0, 0 ), undefined, "all", 0 );
    marker.iconname = "";
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 0 );
    
    if ( !isdefined( level.robj_objective_marker ) )
    {
        level.robj_objective_marker = [];
    }
    
    level.robj_objective_marker[ marker_type ] = marker;
}

// Namespace robj_ui
// Params 2
// Checksum 0xf0ab0906, Offset: 0xae0
// Size: 0x43
function move_objective_marker( origin, type )
{
    marker = function_b63fff028e38a5cf( type );
    objidpoolmanager::update_objective_position( marker.objidnum, get_offset_origin( origin ) );
}

// Namespace robj_ui
// Params 2
// Checksum 0x32fcb9bc, Offset: 0xb2b
// Size: 0x6b
function function_197417edb07e5eef( type, optionalobjective )
{
    marker = function_b63fff028e38a5cf( type );
    objective = level.current_objectives[ 0 ];
    
    if ( isdefined( optionalobjective ) )
    {
        objective = optionalobjective;
    }
    
    objidpoolmanager::update_objective_position( marker.objidnum, get_offset_origin( objective.curorigin ) );
}

// Namespace robj_ui
// Params 1
// Checksum 0xf4cecf1, Offset: 0xb9e
// Size: 0x54
function function_a61934df767b7a5c( player )
{
    player.var_79335a25370b6866 = 1;
    function_baad411123aff5e3( player, "obscured" );
    function_52ac37be091e08f( player, "on_point" );
    
    if ( level.current_objectives.size > 1 )
    {
        function_52ac37be091e08f( player, "on_point_2" );
    }
}

// Namespace robj_ui
// Params 1
// Checksum 0xa0d05a1a, Offset: 0xbfa
// Size: 0x55
function function_45b593ede807aae8( player )
{
    if ( player.var_79335a25370b6866 )
    {
        return;
    }
    
    function_52ac37be091e08f( player, "obscured" );
    function_baad411123aff5e3( player, "on_point" );
    
    if ( level.current_objectives.size > 1 )
    {
        function_baad411123aff5e3( player, "on_point_2" );
    }
}

// Namespace robj_ui
// Params 0
// Checksum 0x4325e35e, Offset: 0xc57
// Size: 0xf7
function function_8003ef44ab00fe5()
{
    if ( !isdefined( level.robj_objective_marker ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player notify( #"hash_ca990f0ff7ea449b" );
        player.var_79335a25370b6866 = 0;
        player setclientomnvar( "ui_secure_overlay_active", 0 );
    }
    
    function_baad411123aff5e3( level.players, "obscured" );
    function_baad411123aff5e3( level.players, "on_point" );
    
    if ( level.current_objectives.size > 1 )
    {
        function_baad411123aff5e3( level.players, "on_point_2" );
    }
}

// Namespace robj_ui
// Params 2
// Checksum 0x2fe534e0, Offset: 0xd56
// Size: 0xb7
function function_52ac37be091e08f( players, type )
{
    marker = function_b63fff028e38a5cf( type );
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        objidpoolmanager::objective_playermask_addshowplayer( marker.objidnum, player );
    }
}

// Namespace robj_ui
// Params 2
// Checksum 0xa9a5d800, Offset: 0xe15
// Size: 0xb7
function function_baad411123aff5e3( players, type )
{
    marker = function_b63fff028e38a5cf( type );
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        objidpoolmanager::objective_playermask_hidefrom( marker.objidnum, player );
    }
}

// Namespace robj_ui
// Params 1
// Checksum 0x6e581b37, Offset: 0xed4
// Size: 0x4a
function function_70eef1e633207b36( type )
{
    marker = function_b63fff028e38a5cf( type );
    objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_locked" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 0 );
}

// Namespace robj_ui
// Params 1
// Checksum 0xf469e46f, Offset: 0xf26
// Size: 0x4a
function function_8183a85d0612c9a( type )
{
    marker = function_b63fff028e38a5cf( type );
    objidpoolmanager::update_objective_icon( marker.objidnum, "jup_ui_map_icon_obj_bg" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 0 );
}

// Namespace robj_ui
// Params 2
// Checksum 0x80fb5651, Offset: 0xf78
// Size: 0x4e
function function_c769c485e4258910( type, time )
{
    marker = function_b63fff028e38a5cf( type );
    
    if ( time == 0 )
    {
        objidpoolmanager::objective_show_progress( marker.objidnum, 0 );
        return;
    }
    
    marker thread gameobjects::function_d7321ef757ecefd7( time );
}

// Namespace robj_ui
// Params 3
// Checksum 0x9b2aa091, Offset: 0xfce
// Size: 0x5a
function function_98c7aed2f3ef9b64( type, dointro, dooutro )
{
    marker = function_b63fff028e38a5cf( type );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, dointro );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, dooutro );
}

// Namespace robj_ui
// Params 2
// Checksum 0x1028f672, Offset: 0x1030
// Size: 0x3d
function set_marker_background_type( type, bgtype )
{
    marker = function_b63fff028e38a5cf( type );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, bgtype );
}

// Namespace robj_ui
// Params 1
// Checksum 0xa2308613, Offset: 0x1075
// Size: 0x1c
function get_offset_origin( origin )
{
    return origin + ( 0, 0, 80 );
}

// Namespace robj_ui
// Params 1
// Checksum 0x8bcf70f, Offset: 0x109a
// Size: 0x2c
function function_b63fff028e38a5cf( type )
{
    marker_type = get_valid_marker_type( type );
    return level.robj_objective_marker[ marker_type ];
}

// Namespace robj_ui
// Params 1
// Checksum 0x15e1db87, Offset: 0x10cf
// Size: 0x1b
function get_valid_marker_type( marker_type )
{
    if ( !isdefined( marker_type ) )
    {
        return "obscured";
    }
    
    return marker_type;
}

