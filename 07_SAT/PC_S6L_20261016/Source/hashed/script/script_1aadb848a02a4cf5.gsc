// script_1aadb848a02a4cf5  (hash_1aadb848a02a4cf5.gscc) (size: 9025 Bytes / 0x2341 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd076df05 (3497451269)
// size ...... 9025 (0x2341)
// includes .. 2   (offset: 0x2231)
// strings ... 16  (offset: 0x2241)
// dev strs .. 2   (offset: 0x2329)
// exports ... 39  (offset: 0x17c1)
// cseg ...... 0x1e1 + 0x15e0 (0x17c1)
// imports ... 33  (offset: 0x1dd9)
// animtree1 . 0   (offset: 0x2341)
// animtree2 . 0   (offset: 0x2341)
#using scripts\common\scripted_widgets;
#using scripts\mp\flags;

#namespace namespace_4c5fce57fb970de0;

// Namespace namespace_4c5fce57fb970de0
// Params 5
// Checksum 0x7e404161, Offset: 0x1ff
// Size: 0xc9
function player_init( player, widget_ref, widget_type, pos_x, pos_y )
{
    assert( isdefined( player ) );
    
    if ( !player scripted_widgets::is_active( widget_ref ) )
    {
        player.objective_tracker = spawnstruct();
        player.objective_tracker.objectives = [];
        player.objective_tracker.widget_ref = widget_ref;
        player.objective_tracker.init_complete = 0;
        player scripted_widgets::create( widget_ref, widget_type );
    }
    
    player thread init_widget_omnvars( widget_ref );
    player thread set_widget_position( widget_ref, pos_x, pos_y );
    player thread function_cbf9b03ec62801d6();
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x130e08e2, Offset: 0x2d0
// Size: 0x7f
function init_widget_omnvars( widget_ref )
{
    self endon( #"disconnect" );
    player = self;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    player scripted_widgets::set_param( widget_ref, "INIT" );
    wait 1;
    
    if ( isdefined( player ) && isdefined( player.objective_tracker ) )
    {
        player.objective_tracker.init_complete = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0x28fee894, Offset: 0x357
// Size: 0x55
function set_widget_position( widget_ref, pos_x, pos_y )
{
    self endon( #"disconnect" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    wait 1;
    scripted_widgets::set_position( widget_ref, pos_x, pos_y, 0, 0 );
}

// Namespace namespace_4c5fce57fb970de0
// Params 6
// Checksum 0x6f3e11f5, Offset: 0x3b4
// Size: 0x13a
function add_objective( uid, owner, owner_type, ui_key, is_completed, is_sub_objective_update )
{
    assert( isdefined( self ) );
    assert( isdefined( ui_key ) );
    assert( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) );
    
    if ( isdefined( self.objective_tracker.objectives[ uid ] ) )
    {
        println( "<dev string:x24>" + uid + "<dev string:x54>" );
        return;
    }
    
    objective = spawnstruct();
    objective.uid = uid;
    objective.owner = owner;
    objective.owner_type = owner_type;
    objective.ui_key = ui_key;
    objective.is_completed = is_completed;
    objective.var_d8701f2127d3c21e = 0;
    objective.is_sub_objective_update = is_sub_objective_update;
    self.objective_tracker.objectives[ uid ] = objective;
    queue_objective( uid );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0xbd3394b1, Offset: 0x4f6
// Size: 0x87
function remove_objective( uid )
{
    assert( isdefined( self ) );
    assert( isdefined( uid ) );
    
    if ( !( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) ) )
    {
        return;
    }
    
    objective_to_remove = self.objective_tracker.objectives[ uid ];
    
    if ( !isdefined( objective_to_remove ) )
    {
        return;
    }
    
    self.objective_tracker.objectives[ uid ] = undefined;
}

// Namespace namespace_4c5fce57fb970de0
// Params 2
// Checksum 0xf68165ae, Offset: 0x585
// Size: 0xbf
function on_objective_complete( uid, is_successful )
{
    assert( isdefined( self ) );
    assert( isdefined( uid ) );
    
    if ( !( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) ) )
    {
        return;
    }
    
    var_6348e34a2b7afee7 = self.objective_tracker.objectives[ uid ];
    
    if ( !isdefined( var_6348e34a2b7afee7 ) )
    {
        return;
    }
    
    self.objective_tracker.objectives[ uid ].is_completed = 1;
    self.objective_tracker.objectives[ uid ].is_successful = is_successful;
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x341b80fa, Offset: 0x64c
// Size: 0x74
function generate_uid( prefix )
{
    if ( !isdefined( level.objective_tracker ) )
    {
        level.objective_tracker = spawnstruct();
        level.objective_tracker.next_uid_gen = 0;
    }
    
    uid = prefix + level.objective_tracker.next_uid_gen;
    level.objective_tracker.next_uid_gen++;
    return uid;
}

// Namespace namespace_4c5fce57fb970de0
// Params 0
// Checksum 0x2b1d8a6e, Offset: 0x6c9
// Size: 0x8e
function function_5ed9e57658a48212()
{
    assert( isdefined( self ) );
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.widget_ref ) )
    {
        scripted_widgets::set_state( self.objective_tracker.widget_ref, "FADE_OUT" );
        self.objective_tracker.active_uid = undefined;
        self.objective_tracker.active_completed = undefined;
        self.objective_tracker.var_6d4c835bb3019325 = 0.5;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 4
// Checksum 0x32fb73cf, Offset: 0x75f
// Size: 0x12b
function function_cfd35a1d757761ed( uid, ui_key, is_completed, is_successful )
{
    assert( isdefined( self ) );
    assert( isdefined( ui_key ) );
    assert( isdefined( is_completed ) );
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.widget_ref ) )
    {
        function_21174b24aefef4ec( self );
        scripted_widgets::set_param( self.objective_tracker.widget_ref, ui_key );
        new_state = "FADE_IN_INCOMPLETE";
        
        if ( is_completed && isdefined( is_successful ) )
        {
            new_state = is_successful ? "FADE_IN_SUCCESSFUL" : "FADE_IN_FAILURE";
        }
        
        scripted_widgets::set_state( self.objective_tracker.widget_ref, new_state );
        function_a3a1fa16a97eb576( self, uid );
        self.objective_tracker.active_uid = uid;
        self.objective_tracker.active_completed = is_completed;
        self.objective_tracker.var_6d4c835bb3019325 = 0.5;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2
// Checksum 0xd391f515, Offset: 0x892
// Size: 0xe4
function function_29b375d839468101( uid, ui_key )
{
    assert( isdefined( uid ) );
    assert( isdefined( ui_key ) );
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.widget_ref ) )
    {
        function_21174b24aefef4ec( self );
        scripted_widgets::set_param( self.objective_tracker.widget_ref, ui_key );
        scripted_widgets::set_state( self.objective_tracker.widget_ref, "SUB_OBJECTIVE_UPDATE" );
        function_a3a1fa16a97eb576( self, uid );
        self.objective_tracker.active_uid = uid;
        self.objective_tracker.active_completed = 0;
        self.objective_tracker.var_6d4c835bb3019325 = level.framedurationseconds;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x8a19e6d1, Offset: 0x97e
// Size: 0xb3
function function_a119c385540b5a9b( is_successful )
{
    assert( isdefined( self ) );
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.widget_ref ) )
    {
        new_state = is_successful ? "INCOMPLETE_TO_SUCCESSFUL" : "INCOMPLETE_TO_FAILURE";
        scripted_widgets::set_state( self.objective_tracker.widget_ref, new_state );
    }
    
    if ( isdefined( self.objective_tracker.active_uid ) )
    {
        uid = self.objective_tracker.active_uid;
        thread function_401b96984a852635( uid, 2 );
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2
// Checksum 0x4409ce97, Offset: 0xa39
// Size: 0x84
function function_401b96984a852635( uid, num_fades )
{
    transition_length = 0.5 * num_fades;
    wait transition_length;
    
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) )
    {
        obj = self.objective_tracker.objectives[ uid ];
        
        if ( isdefined( obj ) )
        {
            obj.var_d8701f2127d3c21e = 1;
        }
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0xda396376, Offset: 0xac5
// Size: 0xae
function set_obj_counter_total( player, uid, totalcount )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            update_counter_total( player, totalcount );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.counter_total = totalcount;
        objective.update_counter_total = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0xc38bd608, Offset: 0xb7b
// Size: 0x23
function private update_counter_total( player, totalcount )
{
    player setclientomnvar( "obj_tracker_counter_set", totalcount );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0x4cb0404e, Offset: 0xba6
// Size: 0xae
function set_obj_counter_progress( player, uid, progresscount )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        objective = player.objective_tracker.objectives[ uid ];
        objective.counter_progress = progresscount;
        
        if ( player.objective_tracker.active_uid == uid )
        {
            update_counter_progress( player, progresscount );
            return;
        }
        
        objective.update_counter_progress = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0xd50aa496, Offset: 0xc5c
// Size: 0x23
function private update_counter_progress( player, progresscount )
{
    player setclientomnvar( "obj_tracker_counter_update", progresscount );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0xd880cede, Offset: 0xc87
// Size: 0x28
function function_461cbbc7cf88bc2( player )
{
    player setclientomnvar( "obj_tracker_counter_set", -1 );
    player setclientomnvar( "obj_tracker_counter_update", -1 );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0x8d49445, Offset: 0xcb7
// Size: 0xae
function set_obj_progress_bar( player, uid, progress )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            update_progress_bar( player, progress );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.progress_bar = progress;
        objective.update_progress_bar = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0xd3f3941, Offset: 0xd6d
// Size: 0x23
function private update_progress_bar( player, progress )
{
    player setclientomnvar( "obj_tracker_progress_bar_update", progress );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0xe508a27e, Offset: 0xd98
// Size: 0xae
function set_obj_progress_bar_state( player, uid, state )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            update_progress_bar_state( player, state );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.progress_bar_state = state;
        objective.update_progress_bar_state = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0xd2fd79eb, Offset: 0xe4e
// Size: 0x23
function private update_progress_bar_state( player, state )
{
    player setclientomnvar( "obj_tracker_progress_bar_state", state );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0x1081ac65, Offset: 0xe79
// Size: 0xae
function function_d6a164b1dad285cf( player, uid, show_bar )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            show_progress_bar( player, show_bar );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.progress_bar_show = show_bar;
        objective.var_7cf1115439777e78 = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0xddece453, Offset: 0xf2f
// Size: 0x23
function private show_progress_bar( player, show_bar )
{
    player setclientomnvar( "obj_tracker_progress_bar_show", show_bar );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0xc1283845, Offset: 0xf5a
// Size: 0x33
function function_6e6adde71620d63f( player )
{
    player setclientomnvar( "obj_tracker_progress_bar_update", 0 );
    player setclientomnvar( "obj_tracker_progress_bar_show", 0 );
    player setclientomnvar( "obj_tracker_progress_bar_state", 0 );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0x4591b386, Offset: 0xf95
// Size: 0xae
function set_obj_timer( player, uid, endtime )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            update_objective_timer( player, endtime );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.timer_end_time = endtime;
        objective.update_timer = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2
// Checksum 0x59a44237, Offset: 0x104b
// Size: 0x23
function update_objective_timer( player, endtime )
{
    player setclientomnvar( "obj_tracker_timer_end_time", endtime );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0xa7758591, Offset: 0x1076
// Size: 0x19
function reset_objective_timer( player )
{
    player setclientomnvar( "obj_tracker_timer_end_time", 0 );
}

// Namespace namespace_4c5fce57fb970de0
// Params 3
// Checksum 0xe5d6c20d, Offset: 0x1097
// Size: 0xae
function set_obj_icon( player, uid, icon )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.objectives ) )
    {
        if ( player.objective_tracker.active_uid == uid )
        {
            update_icon( player, icon );
            return;
        }
        
        objective = player.objective_tracker.objectives[ uid ];
        objective.new_icon = icon;
        objective.update_icon = 1;
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 2, eflags: 0x4
// Checksum 0x9883788c, Offset: 0x114d
// Size: 0x23
function private update_icon( player, icon )
{
    player setclientomnvar( "obj_tracker_icon_update", icon );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x4437147f, Offset: 0x1178
// Size: 0x1a
function reset_icon( player )
{
    player setclientomnvar( "obj_tracker_icon_update", -1 );
}

// Namespace namespace_4c5fce57fb970de0
// Params 2
// Checksum 0xbbeda2aa, Offset: 0x119a
// Size: 0x1e6
function function_a3a1fa16a97eb576( player, uid )
{
    if ( !isdefined( player.objective_tracker.objectives ) )
    {
        return;
    }
    
    objective = player.objective_tracker.objectives[ uid ];
    
    if ( isdefined( objective ) )
    {
        if ( objective.update_icon )
        {
            update_icon( player, objective.new_icon );
            objective.update_icon = 0;
        }
        
        if ( objective.update_counter_total && isdefined( objective.counter_total ) )
        {
            update_counter_total( player, objective.counter_total );
            objective.update_counter_total = 0;
        }
        
        if ( objective.update_counter_progress && isdefined( objective.counter_progress ) )
        {
            update_counter_progress( player, objective.counter_progress );
            objective.update_counter_progress = 0;
        }
        
        if ( objective.update_progress_bar && isdefined( objective.progress_bar ) )
        {
            update_progress_bar( player, objective.progress_bar );
            objective.update_progress_bar = 0;
        }
        
        if ( objective.update_progress_bar_state && isdefined( objective.progress_bar_state ) )
        {
            update_progress_bar_state( player, objective.progress_bar_state );
            objective.update_progress_bar_state = 0;
        }
        
        if ( objective.var_7cf1115439777e78 )
        {
            show_progress_bar( player, objective.progress_bar_show );
            objective.var_7cf1115439777e78 = 0;
        }
        
        if ( objective.update_timer && isdefined( objective.timer_end_time ) )
        {
            update_objective_timer( player, objective.timer_end_time );
        }
    }
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x241890b0, Offset: 0x1388
// Size: 0x1e
function function_21174b24aefef4ec( player )
{
    reset_icon( player );
    function_6e6adde71620d63f( player );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0xd1ccc171, Offset: 0x13ae
// Size: 0xc8
function queue_objective( uid )
{
    if ( !isdefined( self.objective_tracker ) )
    {
        return;
    }
    
    new_obj = spawnstruct();
    new_obj.uid = uid;
    
    if ( !isdefined( self.objective_tracker.var_d221557854e18376 ) )
    {
        self.objective_tracker.var_d221557854e18376 = new_obj;
        self.objective_tracker.var_7d4ed9db62d50056 = new_obj;
        thread function_6136f3545f3db588();
        return;
    }
    
    old_tail = self.objective_tracker.var_7d4ed9db62d50056;
    old_tail.next_obj = new_obj;
    self.objective_tracker.var_7d4ed9db62d50056 = new_obj;
}

// Namespace namespace_4c5fce57fb970de0
// Params 0
// Checksum 0x2a544f66, Offset: 0x147e
// Size: 0x106
function function_6136f3545f3db588()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"clear_obj_queue" );
    update_wait_sec = level.framedurationseconds;
    
    while ( isdefined( self.objective_tracker.var_d221557854e18376 ) )
    {
        if ( self.objective_tracker.init_complete )
        {
            if ( isdefined( self.objective_tracker.active_uid ) )
            {
                active_uid = self.objective_tracker.active_uid;
                active_obj = self.objective_tracker.objectives[ active_uid ];
                
                if ( active_obj.is_completed && active_obj.var_d8701f2127d3c21e )
                {
                    wait 3;
                    function_ab1f497286ea9cd5();
                }
            }
            else
            {
                function_ab1f497286ea9cd5();
            }
        }
        
        wait update_wait_sec;
    }
    
    self.objective_tracker.var_7d4ed9db62d50056 = undefined;
}

// Namespace namespace_4c5fce57fb970de0
// Params 0
// Checksum 0xa751fb54, Offset: 0x158c
// Size: 0x5f
function function_ab1f497286ea9cd5()
{
    obj = self.objective_tracker.var_d221557854e18376;
    self.objective_tracker.next_uid = obj.uid;
    self.objective_tracker.var_d221557854e18376 = obj.next_obj;
}

// Namespace namespace_4c5fce57fb970de0
// Params 0
// Checksum 0x40914095, Offset: 0x15f3
// Size: 0x80
function clear_obj_queue()
{
    self notify( #"clear_obj_queue" );
    next_obj = self.objective_tracker.var_d221557854e18376;
    
    while ( isdefined( next_obj ) )
    {
        current_obj = next_obj;
        next_obj = current_obj.next_obj;
        current_obj.next_obj = undefined;
    }
    
    self.objective_tracker.var_d221557854e18376 = undefined;
    self.objective_tracker.var_7d4ed9db62d50056 = undefined;
}

// Namespace namespace_4c5fce57fb970de0
// Params 0, eflags: 0x4
// Checksum 0xb5a4188c, Offset: 0x167b
// Size: 0xb2
function private function_cbf9b03ec62801d6()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player = self;
    
    while ( true )
    {
        if ( !isdefined( player ) )
        {
            break;
        }
        
        if ( isdefined( level.var_3e02e08d03cf84c6 ) )
        {
            player [[ level.var_3e02e08d03cf84c6 ]]();
        }
        
        update_wait_sec = level.framedurationseconds;
        
        if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.var_6d4c835bb3019325 ) )
        {
            update_wait_sec = player.objective_tracker.var_6d4c835bb3019325;
        }
        
        wait update_wait_sec;
    }
    
    function_58f3f8f7651deb2a( player );
}

// Namespace namespace_4c5fce57fb970de0
// Params 1
// Checksum 0x9230afe5, Offset: 0x1735
// Size: 0x8c
function function_58f3f8f7651deb2a( player )
{
    if ( isdefined( player ) && isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.widget_ref ) )
    {
        if ( player scripted_widgets::is_active( player.objective_tracker.widget_ref ) )
        {
            player scripted_widgets::destroy( player.objective_tracker.widget_ref );
        }
        
        player clear_obj_queue();
        player.objective_tracker = undefined;
    }
}

