// scripts\mp\ob\contracts\ob_contract_ui_widget.gsc  (hash_5fc1b76d5342bc8c.gscc) (size: 7115 Bytes / 0x1bcb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd83f2599 (3628017049)
// size ...... 7115 (0x1bcb)
// includes .. 4   (offset: 0x1a3f)
// strings ... 16  (offset: 0x1a5f)
// dev strs .. 13  (offset: 0x1b2f)
// exports ... 29  (offset: 0xed3)
// cseg ...... 0x232 + 0xca1 (0xed3)
// imports ... 55  (offset: 0x135b)
// animtree1 . 0   (offset: 0x1bcb)
// animtree2 . 0   (offset: 0x1bcb)
#using script_2399696a9d953451;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\mp\flags;

#namespace ob_contract_ui_widget;

// Namespace ob_contract_ui_widget
// Params 0, eflags: 0x1
// Checksum 0xd2f1c139, Offset: 0x250
// Size: 0x9
function autoexec init()
{
    thread function_7d730f4c289e66fd();
}

// Namespace ob_contract_ui_widget
// Params 0, eflags: 0x4
// Checksum 0x2a4aaa77, Offset: 0x261
// Size: 0x88
function private function_7d730f4c289e66fd()
{
    level flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    foreach ( player in level.players )
    {
        thread function_53e0f8462eb23bf4( player );
    }
}

// Namespace ob_contract_ui_widget
// Params 1, eflags: 0x4
// Checksum 0xcbc242a1, Offset: 0x2f1
// Size: 0x44
function private function_53e0f8462eb23bf4( player )
{
    var_39520877e3384490 = player getclientomnvar( "ui_mission_index" );
    mission_ui::function_63013f0b545be74e( -1, [ player ] );
    waitframe();
    mission_ui::function_63013f0b545be74e( var_39520877e3384490, [ player ] );
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0xd058d241, Offset: 0x33d
// Size: 0x1d9
function function_a33182f87738c4de( bundlename )
{
    if ( !isdefined( level.ob_missionbundle ) )
    {
        level.ob_missionbundle = getscriptbundle( level.gametypebundle.missionstable );
        
        if ( !isdefined( level.ob_missionbundle ) )
        {
            assertmsg( "<dev string:x24>" );
            return;
        }
    }
    
    if ( !isdefined( level.ob_mission_cache ) )
    {
        level.ob_mission_cache = [];
    }
    
    refasset = isxhashasset( bundlename ) ? bundlename : hashcat( %"hash_10953bfa19e5ded7", bundlename );
    
    if ( isdefined( level.ob_mission_cache[ refasset ] ) )
    {
        return level.ob_mission_cache[ refasset ];
    }
    
    foreach ( index, mission in level.ob_missionbundle.missions )
    {
        if ( mission.bundle == refasset )
        {
            bundle = getscriptbundlefieldvalues( mission.bundle, [ #"hash_d4a1cc97ce5e839f", #"hash_1eddcb8dd7c05bc5" ] );
            assert( isdefined( bundle.var_2d577ac3223e3dee ), "<dev string:x65>" + getxhashsourcename( refasset ) + "<dev string:x72>" );
            level.ob_mission_cache[ refasset ] = { #step:bundle.var_df27392240e8a77c ?? 0, #index:index };
            return level.ob_mission_cache[ refasset ];
        }
    }
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0x1796ff4a, Offset: 0x51f
// Size: 0x3e
function function_724ff866fa7fb742( stringreference )
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_d3aa02fc5d62637d( stringreference, activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 3
// Checksum 0x3593aac1, Offset: 0x565
// Size: 0x4a
function function_d3aa02fc5d62637d( stringreference, players, state = 2 )
{
    optionalparameters = { #state:state };
    function_bb923ce693c606f9( stringreference, players, optionalparameters );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x77b957b7, Offset: 0x5b7
// Size: 0x33
function function_16223345ffbb5859( missionasset, players )
{
    mission_ui::function_be7a7a9facd486e7( players );
    mission_ui::function_759924b87215156b( 0, 0, players );
    function_d3aa02fc5d62637d( missionasset, players );
}

// Namespace ob_contract_ui_widget
// Params 3
// Checksum 0x9ed47105, Offset: 0x5f2
// Size: 0x13b
function function_bb923ce693c606f9( missionasset, players, optionalparameters )
{
    missioninfo = function_a33182f87738c4de( missionasset );
    
    if ( !isdefined( missioninfo ) )
    {
        assertmsg( "<dev string:x9a>" + missionasset + "<dev string:xad>" + getxhashsourcename( level.gametypebundle.missionstable ) );
        return;
    }
    
    println( "<dev string:xd2>", missioninfo.index, "<dev string:xe2>", missioninfo.step );
    
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_index", missioninfo.index, -1 );
        function_e2652264f8a4b37c( 0, players );
        function_4a10c6b2bccfdecd( optionalparameters.state, players );
        setprogress( 0, 0, players );
        function_33c02efd4a127b9e( missioninfo.step, players );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    if ( !isdefined( optionalparameters.step ) )
    {
        optionalparameters.step = missioninfo.step;
    }
    
    mission_ui::initialize( missioninfo.index, players, optionalparameters );
}

// Namespace ob_contract_ui_widget
// Params 0
// Checksum 0xfdc4c6b3, Offset: 0x735
// Size: 0x33
function function_d9301d218459002e()
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_dac15947c2d451e9( activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0x1c8e39a1, Offset: 0x770
// Size: 0x3f
function function_dac15947c2d451e9( players )
{
    function_4a10c6b2bccfdecd( 0, players );
    
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_index", -1 );
        return;
    }
    
    mission_ui::function_63013f0b545be74e( -1, players );
}

// Namespace ob_contract_ui_widget
// Params 5
// Checksum 0xf3462150, Offset: 0x7b7
// Size: 0xaa
function completed( players, finalref, var_653947f5949e9be3, optionalparameters, delay_override )
{
    println( "<dev string:xf3>" );
    function_4a10c6b2bccfdecd( 3, players );
    delay = delay_override ?? getdvarfloat( @"hash_9cc5d72383d6137f", 0.5 );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( finalref )
    {
        if ( var_653947f5949e9be3 && optionalparameters )
        {
            optionalparameters.state = var_653947f5949e9be3;
        }
        
        function_bb923ce693c606f9( finalref, players, optionalparameters );
        return;
    }
    
    function_dac15947c2d451e9( players );
}

// Namespace ob_contract_ui_widget
// Params 3
// Checksum 0xce8930d5, Offset: 0x869
// Size: 0x7a
function failed( players, finalref, var_653947f5949e9be3 )
{
    println( "<dev string:x105>" );
    function_4a10c6b2bccfdecd( 4, players );
    delay = getdvarfloat( @"hash_6fa7e76c1c5bfddb", 0.5 );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( finalref )
    {
        function_d3aa02fc5d62637d( finalref, players, var_653947f5949e9be3 );
        return;
    }
    
    function_dac15947c2d451e9( players );
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0x2aee130e, Offset: 0x8eb
// Size: 0x3e
function function_855fd697c30b090c( value )
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_fe5a48019d0d2e33( value, activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x48e7a248, Offset: 0x931
// Size: 0x3e
function function_fe5a48019d0d2e33( value, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_progress", value, 0 );
        return;
    }
    
    mission_ui::function_759924b87215156b( value, undefined, players );
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0x904b1c1a, Offset: 0x977
// Size: 0x3e
function function_9025afff14ea9bee( value )
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_e5e3a5d667d0a9( value, activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x3524b58c, Offset: 0x9bd
// Size: 0x3d
function function_e5e3a5d667d0a9( value, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_progress_max", value, 0 );
        return;
    }
    
    mission_ui::function_759924b87215156b( undefined, value, players );
}

// Namespace ob_contract_ui_widget
// Params 3
// Checksum 0xc9f03df3, Offset: 0xa02
// Size: 0x4a
function setprogress( value, max, players )
{
    if ( !isdefined( max ) )
    {
        function_fe5a48019d0d2e33( value, players );
        return;
    }
    
    function_fe5a48019d0d2e33( minint( value, max ), players );
    function_e5e3a5d667d0a9( max, players );
}

// Namespace ob_contract_ui_widget
// Params 4
// Checksum 0xb48d9299, Offset: 0xa54
// Size: 0xef
function function_572260f3b30f1e52( objectiveindex, value, max, players )
{
    if ( !isdefined( objectiveindex ) || objectiveindex < 1 || objectiveindex > 3 )
    {
        throw( "Invalid objective index, only 1 to 3 are supported currently." );
        return;
    }
    
    println( "<dev string:x114>", objectiveindex, "<dev string:x126>", value, isdefined( max ) ? "<dev string:x133>" + max : "<dev string:x13b>" );
    
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        progressomnvar = "ui_mission_step_progress_" + objectiveindex;
        
        if ( max )
        {
            var_1db26aa740f1180 = "ui_mission_step_progress_max_" + objectiveindex;
            activity_player_common::function_674cca638cafcae3( players, self, progressomnvar, minint( value, max ), 0 );
            activity_player_common::function_674cca638cafcae3( players, self, var_1db26aa740f1180, max, 0 );
        }
        else
        {
            activity_player_common::function_674cca638cafcae3( players, self, progressomnvar, value, 0 );
        }
        
        return;
    }
    
    mission_ui::function_d84701041f6f95c2( objectiveindex, value, max, players );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x35febe60, Offset: 0xb4b
// Size: 0x48
function function_34a17ebd3b1e6de( var_a926a95db1acc6a9, var_f48f7700cd33a318 )
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_b2ec62ad9ca3bf79( var_a926a95db1acc6a9, var_f48f7700cd33a318, activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 3
// Checksum 0xfda43d15, Offset: 0xb9b
// Size: 0xdf
function function_b2ec62ad9ca3bf79( var_a926a95db1acc6a9, var_f48f7700cd33a318, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        if ( isdefined( var_f48f7700cd33a318 ) )
        {
            activity_player_common::function_674cca638cafcae3( players, self, "ui_br_objective_progress_bar_threshold", var_f48f7700cd33a318, 0 );
        }
        
        activity_player_common::function_674cca638cafcae3( players, self, "ui_br_objective_progress_bar", var_a926a95db1acc6a9, -1 );
        return;
    }
    
    mission_ui::function_759924b87215156b( var_a926a95db1acc6a9, undefined, players );
    
    if ( isdefined( var_f48f7700cd33a318 ) )
    {
        foreach ( player in players )
        {
            player setclientomnvar( "ui_br_objective_progress_bar_threshold", var_f48f7700cd33a318 );
        }
    }
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0xff72468c, Offset: 0xc82
// Size: 0x3e
function function_2ee97780d0898a9b( timeinseconds )
{
    activityinstance = self;
    assert( activity_instance_common::isactivityinstance( activityinstance ) );
    activityinstance function_e2652264f8a4b37c( timeinseconds, activityinstance.playerparticipants );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0xc1000842, Offset: 0xcc8
// Size: 0x61
function function_e2652264f8a4b37c( timeinseconds, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        var_8aed4c80d7354bc2 = 0;
        
        if ( timeinseconds != 0 )
        {
            var_8aed4c80d7354bc2 = gettime() + int( timeinseconds ) * 1000;
        }
        
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_end_time", var_8aed4c80d7354bc2, 0 );
        return;
    }
    
    mission_ui::function_1ee77ed07dcad9b7( timeinseconds, players );
}

// Namespace ob_contract_ui_widget
// Params 1
// Checksum 0x4a38515e, Offset: 0xd31
// Size: 0x4b
function function_3134f518dc4eba30( var_bddd1f17a9f2e6a5 )
{
    assert( activity_instance_common::isactivityinstance( self ) );
    activity_player_common::function_674cca638cafcae3( self.playerparticipants, self, "ui_br_timer_modification", 0 );
    waitframe();
    activity_player_common::function_674cca638cafcae3( self.playerparticipants, self, "ui_br_timer_modification", var_bddd1f17a9f2e6a5 );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x26244bc1, Offset: 0xd84
// Size: 0x3c
function setdifficulty( difficulty, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_difficulty", difficulty, 0 );
        return;
    }
    
    mission_ui::function_8d86622f598743d5( difficulty, players );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x8e4fbf65, Offset: 0xdc8
// Size: 0x3f
function setmessage( messagetext, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_message_text_loc_index", getlocstringindex( messagetext ) );
        return;
    }
    
    mission_ui::function_c2f4da8976865f8d( messagetext, players );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0xc58ddbea, Offset: 0xe0f
// Size: 0x3c
function function_4a10c6b2bccfdecd( state, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_state", state, 0 );
        return;
    }
    
    mission_ui::function_6065da0279993033( state, players );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x5af3e9d7, Offset: 0xe53
// Size: 0x3c
function function_3b7d5e996ba0c975( reward_amount, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_reward_amount", reward_amount, 0 );
        return;
    }
    
    mission_ui::function_64ea545e2a6e3023( reward_amount, players );
}

// Namespace ob_contract_ui_widget
// Params 2
// Checksum 0x48bcdf53, Offset: 0xe97
// Size: 0x3c
function function_33c02efd4a127b9e( stepindex, players )
{
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        activity_player_common::function_674cca638cafcae3( players, self, "ui_mission_step_index", stepindex, 0 );
        return;
    }
    
    mission_ui::function_a706272b19d49be5( stepindex, players );
}

