// script_2399696a9d953451  (hash_2399696a9d953451.gscc) (size: 3171 Bytes / 0xc63)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe336b654 (3812013652)
// size ...... 3171 (0xc63)
// includes .. 0   (offset: 0xbc7)
// strings ... 12  (offset: 0xbc7)
// dev strs .. 1   (offset: 0xc57)
// exports ... 15  (offset: 0x74b)
// cseg ...... 0x198 + 0x5b3 (0x74b)
// imports ... 17  (offset: 0x9a3)
// animtree1 . 0   (offset: 0xc63)
// animtree2 . 0   (offset: 0xc63)
#namespace mission_ui;

// Namespace mission_ui
// Params 3
// Checksum 0xc1a8e99, Offset: 0x1b6
// Size: 0x10f
function initialize( var_39520877e3384490, players, optionalparameters )
{
    clear( players );
    function_63013f0b545be74e( var_39520877e3384490, players );
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    state = optionalparameters.state ?? 1;
    function_6065da0279993033( state, players );
    step = optionalparameters.step ?? 0;
    function_a706272b19d49be5( step, players );
    
    if ( isdefined( optionalparameters.timeremaining ) )
    {
        function_1ee77ed07dcad9b7( optionalparameters.timeremaining, players );
    }
    
    if ( isdefined( optionalparameters.maxprogress ) )
    {
        function_759924b87215156b( 0, optionalparameters.maxprogress, players );
    }
    
    if ( isdefined( optionalparameters.difficulty ) )
    {
        function_8d86622f598743d5( optionalparameters.difficulty, players );
    }
    
    if ( isdefined( optionalparameters.rewardamount ) )
    {
        function_64ea545e2a6e3023( optionalparameters.rewardamount, players );
    }
}

// Namespace mission_ui
// Params 1, eflags: 0x4
// Checksum 0x267f27c6, Offset: 0x2cd
// Size: 0x49
function private clear( players )
{
    function_63013f0b545be74e( -1, players );
    function_6065da0279993033( 0, players );
    function_1ee77ed07dcad9b7( 0, players );
    function_a706272b19d49be5( 0, players );
    function_8d86622f598743d5( 0, players );
    function_64ea545e2a6e3023( 0, players );
}

// Namespace mission_ui
// Params 2
// Checksum 0xdee06252, Offset: 0x31e
// Size: 0x38
function function_a706272b19d49be5( stepindex, players )
{
    function_be7a7a9facd486e7( players );
    function_759924b87215156b( 0, 0, players );
    function_1c90859b607a24a2( "ui_mission_step_index", stepindex, players );
}

// Namespace mission_ui
// Params 1
// Checksum 0x9ef4dfbc, Offset: 0x35e
// Size: 0x35
function function_be7a7a9facd486e7( players )
{
    for ( i = 1; i <= 3 ; i++ )
    {
        function_d84701041f6f95c2( i, 0, 0, players );
    }
}

// Namespace mission_ui
// Params 2
// Checksum 0x80dae8de, Offset: 0x39b
// Size: 0x2c
function function_8d86622f598743d5( difficulty, players )
{
    if ( !isdefined( difficulty ) )
    {
        return;
    }
    
    function_1c90859b607a24a2( "ui_mission_difficulty", difficulty, players );
}

// Namespace mission_ui
// Params 2
// Checksum 0xabdba7f, Offset: 0x3cf
// Size: 0x4d
function function_1ee77ed07dcad9b7( timeremaining, players )
{
    if ( !isdefined( timeremaining ) )
    {
        return;
    }
    
    var_8aed4c80d7354bc2 = 0;
    
    if ( timeremaining != 0 )
    {
        var_8aed4c80d7354bc2 = gettime() + timeremaining * 1000;
    }
    
    function_1c90859b607a24a2( "ui_mission_end_time", var_8aed4c80d7354bc2, players );
}

// Namespace mission_ui
// Params 2
// Checksum 0x1d34ceb4, Offset: 0x424
// Size: 0x2c
function function_2b2cdf8a2b3a224c( freeze, players )
{
    if ( !isdefined( freeze ) )
    {
        return;
    }
    
    function_1c90859b607a24a2( "ui_mission_end_time_frozen", freeze, players );
}

// Namespace mission_ui
// Params 2
// Checksum 0xad797776, Offset: 0x458
// Size: 0x31
function function_c2f4da8976865f8d( messagetext, players )
{
    if ( !isdefined( messagetext ) )
    {
        return;
    }
    
    function_1c90859b607a24a2( "ui_mission_message_text_loc_index", getlocstringindex( messagetext ), players );
}

// Namespace mission_ui
// Params 3
// Checksum 0x226ae191, Offset: 0x491
// Size: 0x58
function function_759924b87215156b( currentprogress, maxprogress, players )
{
    if ( !isdefined( currentprogress ) && !isdefined( maxprogress ) )
    {
        return;
    }
    
    if ( isdefined( currentprogress ) )
    {
        function_1c90859b607a24a2( "ui_mission_progress", currentprogress, players );
    }
    
    if ( isdefined( maxprogress ) )
    {
        function_1c90859b607a24a2( "ui_mission_progress_max", maxprogress, players );
    }
}

// Namespace mission_ui
// Params 2
// Checksum 0x93d76ffa, Offset: 0x4f1
// Size: 0x9b
function function_6065da0279993033( state, players )
{
    if ( !isdefined( state ) )
    {
        return;
    }
    
    switch ( state )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            assertmsg( "<dev string:x24>" );
            return;
    }
    
    function_1c90859b607a24a2( "ui_mission_state", state, players );
}

// Namespace mission_ui
// Params 2
// Checksum 0x16b79408, Offset: 0x594
// Size: 0x2c
function function_64ea545e2a6e3023( rewardamount, players )
{
    if ( !isdefined( rewardamount ) )
    {
        return;
    }
    
    function_1c90859b607a24a2( "ui_mission_reward_amount", rewardamount, players );
}

// Namespace mission_ui
// Params 4
// Checksum 0x674c268f, Offset: 0x5c8
// Size: 0xa5
function function_d84701041f6f95c2( var_1711bae6656762aa, startingprogress, maxprogress, players )
{
    if ( !isdefined( startingprogress ) || !isdefined( var_1711bae6656762aa ) )
    {
        return;
    }
    
    if ( var_1711bae6656762aa < 1 || var_1711bae6656762aa > 3 )
    {
        return;
    }
    
    progressomnvar = "ui_mission_step_progress_" + var_1711bae6656762aa;
    var_3f74564d55de8f0d = maxprogress ? minint( startingprogress, maxprogress ) : startingprogress;
    function_1c90859b607a24a2( progressomnvar, var_3f74564d55de8f0d, players );
    
    if ( maxprogress )
    {
        var_1db26aa740f1180 = "ui_mission_step_progress_max_" + var_1711bae6656762aa;
        function_1c90859b607a24a2( var_1db26aa740f1180, maxprogress, players );
    }
}

// Namespace mission_ui
// Params 2
// Checksum 0x92299396, Offset: 0x675
// Size: 0x2c
function function_63013f0b545be74e( index, players )
{
    if ( !isdefined( index ) )
    {
        return;
    }
    
    function_1c90859b607a24a2( "ui_mission_index", index, players );
}

// Namespace mission_ui
// Params 3, eflags: 0x4
// Checksum 0xba0c894d, Offset: 0x6a9
// Size: 0xa2
function private function_1c90859b607a24a2( omnvar, value, players )
{
    if ( !players.size )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        player setclientomnvar( omnvar, value );
    }
}

