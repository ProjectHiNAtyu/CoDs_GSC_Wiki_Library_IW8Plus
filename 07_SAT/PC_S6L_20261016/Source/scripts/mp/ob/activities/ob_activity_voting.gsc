// scripts\mp\ob\activities\ob_activity_voting.gsc  (hash_772af60d545e6e09.gscc) (size: 7821 Bytes / 0x1e8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66a6c13 (107637779)
// size ...... 7821 (0x1e8d)
// includes .. 10  (offset: 0x1c29)
// strings ... 27  (offset: 0x1c79)
// dev strs .. 7   (offset: 0x1e09)
// exports ... 24  (offset: 0x11ad)
// cseg ...... 0x2dd + 0xed0 (0x11ad)
// imports ... 54  (offset: 0x156d)
// animtree1 . 0   (offset: 0x1e8d)
// animtree2 . 0   (offset: 0x1e8d)
#using script_2b062cc62170d7a8;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\activity_nexus\activity_voting;
#using scripts\common\data_tracker;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\lui_game_event_aggregator;

#namespace ob_activity_voting;

// Namespace ob_activity_voting
// Params 0
// Checksum 0xefe42677, Offset: 0x2fb
// Size: 0x70
function function_2828191605885a74()
{
    activity_common::function_2dd4f07fa5c3e911( "VoteCast", &function_b7059e48b9b76eb0 );
    activity_common::function_2dd4f07fa5c3e911( "VoteEnd", &function_bba0a44bfb25ce3c );
    activity_common::function_2dd4f07fa5c3e911( "VoterLeft", &function_5d960da8bc31f48e );
    activity_common::function_2dd4f07fa5c3e911( "VoterJoined", &function_1c8dc69e453686e6 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_5edb5e40ce0996b6 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_1d749c9305f38f6f );
    level thread function_30b5aac3dedfaf40();
}

// Namespace ob_activity_voting
// Params 0, eflags: 0x4
// Checksum 0x20aefbaf, Offset: 0x373
// Size: 0x1b
function private function_30b5aac3dedfaf40()
{
    waittillframeend();
    lui_game_event_aggregator::registeronluieventcallback( &function_c05d6d94209d8063 );
    namespace_9fd3ecf626067599::function_ced28cc2c2efdabf( &function_8fde63c439b42254 );
}

// Namespace ob_activity_voting
// Params 2
// Checksum 0x6195ceed, Offset: 0x396
// Size: 0xb3
function function_c05d6d94209d8063( notification, value )
{
    var_bf38875515b40693 = self;
    
    if ( isdefined( notification ) )
    {
        switch ( notification )
        {
            case #"hash_9fd64c8b171158f":
                focusedactivity = activity_player_common::function_e811448130016c90( var_bf38875515b40693 );
                activitycategory = activity_instance_common::getactivitycategory( focusedactivity );
                
                if ( activitycategory == "Contract" && !focusedactivity.var_4de7a98b03e71cca )
                {
                    var_b46ec7b58e160c9f = activity_voting::function_499200fb0a93daf( focusedactivity, var_bf38875515b40693 );
                    activity_voting::function_43b7c6f27fc1a1f8( var_bf38875515b40693 );
                    
                    if ( !var_b46ec7b58e160c9f )
                    {
                        thread function_67969554af01f647( activity_player_common::function_e811448130016c90( var_bf38875515b40693 ), var_bf38875515b40693 );
                    }
                }
                
                break;
        }
    }
}

// Namespace ob_activity_voting
// Params 2, eflags: 0x4
// Checksum 0xedfdac92, Offset: 0x451
// Size: 0x22
function private function_67969554af01f647( activityinstance, var_bf38875515b40693 )
{
    wait 15;
    activity_voting::cancelsquadabandonvote( activityinstance, var_bf38875515b40693 );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x88e115fa, Offset: 0x47b
// Size: 0x38
function function_8515664faece0dee( relevantinfostruct )
{
    assert( isdefined( relevantinfostruct ), "<dev string:x24>" );
    return int( floor( relevantinfostruct.votingpoolsize / 2 ) ) + 1;
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x478ebfa9, Offset: 0x4bc
// Size: 0x9a
function function_b7059e48b9b76eb0( var_6fd2ac22061676d0 )
{
    votename = var_6fd2ac22061676d0.votename;
    activityinstance = var_6fd2ac22061676d0.activityinstance;
    
    if ( votename == "ActivityVoteName_SquadAbandonVote" )
    {
        activitycategory = activity_instance_common::getactivitycategory( activityinstance );
        
        if ( activitycategory == "Contract" )
        {
            function_dba08d933cd77ab0( var_6fd2ac22061676d0 );
        }
        else
        {
            println( "<dev string:x7a>" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:xca>" + ( votename ?? "<dev string:xde>" ) + "<dev string:xe8>" );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x4ef00224, Offset: 0x55e
// Size: 0x1ec
function function_bba0a44bfb25ce3c( var_8403c8b7160c9fb4 )
{
    votename = var_8403c8b7160c9fb4.votename;
    activityinstance = var_8403c8b7160c9fb4.activityinstance;
    println( "<dev string:xf9>" + votename );
    activitycategory = activity_instance_common::getactivitycategory( activityinstance );
    squadmembers = var_8403c8b7160c9fb4.voterpool;
    
    foreach ( squadmember in squadmembers )
    {
        if ( isplayer( squadmember ) )
        {
            squadmember setclientomnvar( "ui_squad_vote_member_1", 0 );
            squadmember setclientomnvar( "ui_squad_vote_member_2", 0 );
            squadmember setclientomnvar( "ui_squad_vote_member_3", 0 );
            squadmember setclientomnvar( "ui_squad_vote_member_4", 0 );
            squadmember setclientomnvar( "ui_squad_vote_initiator_id", -1 );
        }
    }
    
    if ( votename == "ActivityVoteName_SquadAbandonVote" )
    {
        foreach ( squadmember in squadmembers )
        {
            if ( isplayer( squadmember ) )
            {
                squadmember val::reset( "ob_voting", "allow_ping" );
            }
        }
        
        if ( activitycategory == "Contract" )
        {
            function_8e6a641df0bbf94c( var_8403c8b7160c9fb4 );
        }
        else
        {
            println( "<dev string:x7a>" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:xca>" + ( votename ?? "<dev string:xde>" ) + "<dev string:xe8>" );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0xd536398c, Offset: 0x752
// Size: 0x9a
function function_5d960da8bc31f48e( var_4fcf594688ef006a )
{
    votename = var_4fcf594688ef006a.votename;
    activityinstance = var_4fcf594688ef006a.activityinstance;
    activitycategory = activity_instance_common::getactivitycategory( activityinstance );
    
    if ( votename == "ActivityVoteName_SquadAbandonVote" )
    {
        if ( activitycategory == "Contract" )
        {
            function_ae3d9fa7ec986316( var_4fcf594688ef006a );
        }
        else
        {
            println( "<dev string:x7a>" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:xca>" + ( votename ?? "<dev string:xde>" ) + "<dev string:xe8>" );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0xa3f2a23b, Offset: 0x7f4
// Size: 0x9a
function function_1c8dc69e453686e6( var_61f51a984153c0d2 )
{
    votename = var_61f51a984153c0d2.votename;
    activityinstance = var_61f51a984153c0d2.activityinstance;
    activitycategory = activity_instance_common::getactivitycategory( activityinstance );
    
    if ( votename == "ActivityVoteName_SquadAbandonVote" )
    {
        if ( activitycategory == "Contract" )
        {
            function_91d8318dce054f1e( var_61f51a984153c0d2 );
        }
        else
        {
            println( "<dev string:x7a>" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:xca>" + ( votename ?? "<dev string:xde>" ) + "<dev string:xe8>" );
}

// Namespace ob_activity_voting
// Params 0
// Checksum 0xd8177d31, Offset: 0x896
// Size: 0xbf
function function_852b00ec27c782d1()
{
    self endon( #"disconnect" );
    self notifyonplayercommand( "quest_vote_accept", "-actionslot 1" );
    
    if ( self usinggamepad() )
    {
        val::set( "ob_voting", "allow_ping", 0 );
    }
    else
    {
        self notifyonplayercommand( "quest_vote_accept", "decline_vote" );
    }
    
    msg = utility::waittill_any_return( "quest_vote_accept", "quest_vote_timeout" );
    self notifyonplayercommandremove( "quest_vote_accept", "-actionslot 1" );
    self notifyonplayercommandremove( "quest_vote_accept", "decline_vote" );
    
    if ( !isdefined( msg ) || msg == "quest_vote_timeout" )
    {
        return 0;
    }
    
    if ( msg == "quest_vote_accept" )
    {
        self playlocalsound( "uin_cer_zm_squadvote_decline" );
        activity_voting::function_43b7c6f27fc1a1f8( self );
        return 0;
    }
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x1caaefe0, Offset: 0x95d
// Size: 0x13c
function function_dba08d933cd77ab0( var_6fd2ac22061676d0 )
{
    squadvotes = var_6fd2ac22061676d0.votes;
    squadmates = var_6fd2ac22061676d0.voterpool;
    var_d8c5526fa9a1fb2d = var_6fd2ac22061676d0.var_d8c5526fa9a1fb2d;
    activityinstance = var_6fd2ac22061676d0.activityinstance;
    
    if ( var_d8c5526fa9a1fb2d )
    {
        return;
    }
    
    playersquadmates = function_fe160cdef01bc31c( squadmates );
    var_ef492c47a56fb71c = arrayremove( playersquadmates, squadvotes );
    
    foreach ( squadmate in var_ef492c47a56fb71c )
    {
        if ( isplayer( squadmate ) )
        {
            squadmate thread function_852b00ec27c782d1();
        }
    }
    
    var_616737dbc22c0c94 = activity_voting::function_ca6130966c47d21( activityinstance, squadmates.size );
    function_86e413458d1b0e58( var_ef492c47a56fb71c, activityinstance );
    function_16ba9ab8db50f549( playersquadmates, activityinstance, squadvotes.size, var_616737dbc22c0c94 );
    function_d571e95fcf81ea53( playersquadmates, squadvotes, var_616737dbc22c0c94 );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x824cb405, Offset: 0xaa1
// Size: 0xed
function function_8e6a641df0bbf94c( var_8403c8b7160c9fb4 )
{
    squadmates = var_8403c8b7160c9fb4.voterpool;
    voteresult = var_8403c8b7160c9fb4.voteresult;
    playersquadmates = function_fe160cdef01bc31c( squadmates );
    function_c3bd8ef6c0808224( playersquadmates );
    
    foreach ( squadmate in playersquadmates )
    {
        squadmate notify( #"quest_vote_timeout" );
    }
    
    if ( voteresult == "ActivityVoteResult_Success" )
    {
        return;
    }
    
    if ( voteresult == "ActivityVoteResult_Cancelled" )
    {
        println( "<dev string:x124>" );
    }
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0xfbce75e2, Offset: 0xb96
// Size: 0xaa
function function_ae3d9fa7ec986316( var_4fcf594688ef006a )
{
    squadvotes = var_4fcf594688ef006a.votes;
    squadmates = var_4fcf594688ef006a.voterpool;
    var_20b9721bf8f875ed = var_4fcf594688ef006a.var_20b9721bf8f875ed;
    var_f4c8648319b7b354 = arrayremove( squadvotes, var_20b9721bf8f875ed );
    var_d0dee5d009757de5 = arrayremove( squadmates, var_20b9721bf8f875ed );
    var_fe015d6ae1903b52 = function_fe160cdef01bc31c( var_d0dee5d009757de5 );
    var_616737dbc22c0c94 = activity_voting::function_ca6130966c47d21( var_4fcf594688ef006a.activityinstance, var_d0dee5d009757de5.size );
    function_d571e95fcf81ea53( var_fe015d6ae1903b52, var_f4c8648319b7b354, var_616737dbc22c0c94 );
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x36385e59, Offset: 0xc48
// Size: 0x9f
function function_91d8318dce054f1e( var_61f51a984153c0d2 )
{
    squadvotes = var_61f51a984153c0d2.votes;
    squadmates = var_61f51a984153c0d2.voterpool;
    var_9e53a0536ce2272d = var_61f51a984153c0d2.var_9e53a0536ce2272d;
    var_b7224be76a550721 = arraycombineunique( squadmates, [ var_9e53a0536ce2272d ] );
    var_b29758a39923bc8 = function_fe160cdef01bc31c( var_b7224be76a550721 );
    var_616737dbc22c0c94 = activity_voting::function_ca6130966c47d21( var_61f51a984153c0d2.activityinstance, var_b7224be76a550721.size );
    function_d571e95fcf81ea53( var_b29758a39923bc8, squadvotes, var_616737dbc22c0c94 );
}

// Namespace ob_activity_voting
// Params 4
// Checksum 0x4af7bd48, Offset: 0xcef
// Size: 0x5a
function function_16ba9ab8db50f549( players, activityinstance, var_e9f1482ee94e89f5, var_44bf7e5007c2cf12 )
{
    cancellationstate = var_e9f1482ee94e89f5 | var_44bf7e5007c2cf12 << 3;
    function_7f27a21a8b685c32( activityinstance, "abandon_vote_pending_cancellation_state", cancellationstate );
    activityinstance activity_player_broadcasting::function_cb4750c84882dd07( "abandon_vote_pending_splash", players );
}

// Namespace ob_activity_voting
// Params 2
// Checksum 0xec27e9bf, Offset: 0xd51
// Size: 0x25
function function_86e413458d1b0e58( players, activityinstance )
{
    activityinstance activity_player_broadcasting::function_cb4750c84882dd07( "abandon_vote_pending_vo", players );
}

// Namespace ob_activity_voting
// Params 3
// Checksum 0x85a1bfed, Offset: 0xd7e
// Size: 0x162
function function_d571e95fcf81ea53( players, var_f40a539b85c5bdac, var_44bf7e5007c2cf12 )
{
    var_e9f1482ee94e89f5 = var_f40a539b85c5bdac.size;
    cancellationstate = var_e9f1482ee94e89f5 | var_44bf7e5007c2cf12 << 3;
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_contract_cancellation_state", cancellationstate );
        
        if ( var_e9f1482ee94e89f5 > 0 )
        {
            player setclientomnvar( "ui_squad_vote_initiator_id", var_f40a539b85c5bdac[ 0 ].clientid );
            
            foreach ( playervoted in var_f40a539b85c5bdac )
            {
                cancelomnvar = "ui_squad_vote_member_" + playervoted.sessionuimemberindex + 1;
                player setclientomnvar( cancelomnvar, 1 );
            }
        }
    }
}

// Namespace ob_activity_voting
// Params 1
// Checksum 0x612e602b, Offset: 0xee8
// Size: 0x82
function function_c3bd8ef6c0808224( players )
{
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_contract_cancellation_state", 0 );
    }
}

// Namespace ob_activity_voting
// Params 1, eflags: 0x4
// Checksum 0x55a4e73e, Offset: 0xf72
// Size: 0x2a
function private function_8fde63c439b42254( player )
{
    focusedactivity = activity_player_common::function_e811448130016c90( player );
    activity_voting::function_601a46ed2df2bba0( focusedactivity, player );
}

// Namespace ob_activity_voting
// Params 1, eflags: 0x4
// Checksum 0x8e50a7e0, Offset: 0xfa4
// Size: 0x88
function private function_1d749c9305f38f6f( relevantinfostruct )
{
    foreach ( player in relevantinfostruct.playerlist )
    {
        activity_voting::function_601a46ed2df2bba0( self, player );
    }
}

// Namespace ob_activity_voting
// Params 1, eflags: 0x4
// Checksum 0xbedf0bc1, Offset: 0x1034
// Size: 0x88
function private function_5edb5e40ce0996b6( relevantinfostruct )
{
    foreach ( player in relevantinfostruct.playerlist )
    {
        activity_voting::function_b3eff06557c09621( self, player );
    }
}

// Namespace ob_activity_voting
// Params 3, eflags: 0x4
// Checksum 0xac3b5244, Offset: 0x10c4
// Size: 0x43
function private function_7f27a21a8b685c32( activityinstance, datatrackername, var_9b7889e8a08d929f )
{
    if ( activityinstance data_tracker::function_72b9e57bfc6deb7a( datatrackername ) )
    {
        activityinstance data_tracker::updatedata( datatrackername, var_9b7889e8a08d929f );
        return;
    }
    
    activityinstance data_tracker::adddataint( datatrackername, var_9b7889e8a08d929f );
}

// Namespace ob_activity_voting
// Params 1, eflags: 0x4
// Checksum 0xd8751c50, Offset: 0x110f
// Size: 0x9d
function private function_fe160cdef01bc31c( squadmates )
{
    playersquadmates = [];
    
    foreach ( squadmate in squadmates )
    {
        if ( isplayer( squadmate ) && !isbot( squadmate ) )
        {
            playersquadmates[ playersquadmates.size ] = squadmate;
        }
    }
    
    return playersquadmates;
}

