// scripts\common\activity_nexus\activity_voting.gsc  (hash_1ddfc951cf926b09.gscc) (size: 12245 Bytes / 0x2fd5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41dccd0e (1104989454)
// size ...... 12245 (0x2fd5)
// includes .. 6   (offset: 0x2c19)
// strings ... 8   (offset: 0x2c49)
// dev strs .. 60  (offset: 0x2cc9)
// exports ... 59  (offset: 0x17d9)
// cseg ...... 0x10f + 0x16ca (0x17d9)
// imports ... 87  (offset: 0x2111)
// animtree1 . 0   (offset: 0x2fd5)
// animtree2 . 0   (offset: 0x2fd5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_nexus_debug;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\devgui;

#namespace activity_voting;

// Namespace activity_voting
// Params 1
// Checksum 0x6b173354, Offset: 0x12d
// Size: 0x60
function function_43b7c6f27fc1a1f8( player )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    focusedactivity = namespace_e55955ff7520be97::function_e811448130016c90( player );
    
    if ( !isdefined( focusedactivity ) )
    {
        println( "<dev string:x64>" + "<dev string:xc1>" + "<dev string:x114>" );
        return;
    }
    
    function_df77a410e3b3636d( focusedactivity, player );
}

// Namespace activity_voting
// Params 2
// Checksum 0x151777b2, Offset: 0x195
// Size: 0x7a
function function_df77a410e3b3636d( activityinstance, player )
{
    if ( !function_ad89b4f5ea0ac1e4( activityinstance, player ) )
    {
        return;
    }
    
    function_804f84dcf243a51( activityinstance );
    
    if ( function_d8b0532736908c0e( activityinstance, player ) )
    {
        println( "<dev string:x12c>" );
        return;
    }
    
    function_d03fe514c125c3b7( activityinstance, player );
    var_d8c5526fa9a1fb2d = function_45ed9e6ceee5269c( activityinstance, player );
    function_73ffb9c2ddf7d0ce( activityinstance, player, var_d8c5526fa9a1fb2d );
    function_a12ec129e298e037( activityinstance, player );
}

// Namespace activity_voting
// Params 2
// Checksum 0x792a850c, Offset: 0x217
// Size: 0x58
function function_601a46ed2df2bba0( activityinstance, player )
{
    if ( !function_ad89b4f5ea0ac1e4( activityinstance, player ) )
    {
        return;
    }
    
    function_804f84dcf243a51( activityinstance );
    
    if ( function_499200fb0a93daf( activityinstance, player ) )
    {
        function_465ec53cf6a7f880( activityinstance, player );
        function_d03fe514c125c3b7( activityinstance, player );
        function_a12ec129e298e037( activityinstance, player, 1 );
    }
}

// Namespace activity_voting
// Params 2
// Checksum 0xc9a1ee5f, Offset: 0x277
// Size: 0x42
function function_b3eff06557c09621( activityinstance, player )
{
    if ( !function_ad89b4f5ea0ac1e4( activityinstance, player ) )
    {
        return;
    }
    
    function_804f84dcf243a51( activityinstance );
    
    if ( function_499200fb0a93daf( activityinstance, player ) )
    {
        function_dc5047765ee55080( activityinstance, player );
    }
}

// Namespace activity_voting
// Params 2
// Checksum 0x9bd7653a, Offset: 0x2c1
// Size: 0x43
function cancelsquadabandonvote( activityinstance, player )
{
    if ( !isdefined( activityinstance ) )
    {
        println( "<dev string:x192>" );
        return;
    }
    
    function_c11aee29e715383c( activityinstance, player );
    function_291fc59785199b0a( activityinstance, player, "ActivityVoteResult_Cancelled" );
}

// Namespace activity_voting
// Params 2
// Checksum 0x781f3ccf, Offset: 0x30c
// Size: 0x3c, Type: bool
function function_499200fb0a93daf( activityinstance, player )
{
    if ( !( isdefined( activityinstance ) && isdefined( activityinstance.squadabandonvotes ) ) )
    {
        return false;
    }
    
    return function_fb9809eaf94d845f( activityinstance, player ) == "ActivityVoteResult_InProgress";
}

// Namespace activity_voting
// Params 2
// Checksum 0xf1d744e5, Offset: 0x351
// Size: 0x6a
function function_ca6130966c47d21( activityinstance, votingpoolsize )
{
    relevantinfostruct = spawnstruct();
    relevantinfostruct.votingpoolsize = votingpoolsize;
    activitytype = activityinstance.type;
    
    if ( activity_common::getactivityfunction( activitytype, 8 ) )
    {
        return activity_common::runactivityfunction( activityinstance, 8, relevantinfostruct );
    }
    
    return function_bdcf1e61ded5586f( relevantinfostruct );
}

// Namespace activity_voting
// Params 1
// Checksum 0x4aa108fa, Offset: 0x3c4
// Size: 0x27
function function_bdcf1e61ded5586f( relevantinfostruct )
{
    assert( isdefined( relevantinfostruct ), "<dev string:x1da>" );
    return relevantinfostruct.votingpoolsize;
}

// Namespace activity_voting
// Params 3, eflags: 0x4
// Checksum 0xef656621, Offset: 0x3f4
// Size: 0x8a
function private function_73ffb9c2ddf7d0ce( activityinstance, player, var_d8c5526fa9a1fb2d )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_6babc949be76f19f( activityinstance, player );
    voterpool = function_aed7f791124817ef( activityinstance, player );
    var_79d42084a1ea4799 = function_2db098b8c0111fd( activityinstance, votename, votes, voterpool, player, var_d8c5526fa9a1fb2d );
    activity_instance_common::announceactivitymoment( activityinstance, "VoteCast", var_79d42084a1ea4799 );
    
    /#
        function_ff328507759cf54a( activityinstance, player );
    #/
}

// Namespace activity_voting
// Params 3, eflags: 0x4
// Checksum 0x666539d3, Offset: 0x486
// Size: 0x89
function private function_291fc59785199b0a( activityinstance, player, voteresult )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_6babc949be76f19f( activityinstance, player );
    voterpool = function_aed7f791124817ef( activityinstance, player );
    var_9bf5022c762e8f6d = function_90f828ebb10eddef( activityinstance, votename, votes, voterpool, voteresult );
    activity_instance_common::announceactivitymoment( activityinstance, "VoteEnd", var_9bf5022c762e8f6d );
    
    /#
        function_fd1845450f07c6c3( activityinstance, player );
    #/
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xf84e9c9a, Offset: 0x517
// Size: 0x80
function private function_465ec53cf6a7f880( activityinstance, player )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_6babc949be76f19f( activityinstance, player );
    voterpool = function_aed7f791124817ef( activityinstance, player );
    var_6fbb1fbb7ad69bcf = function_f3a4f38302dfda7d( activityinstance, votename, votes, voterpool, player );
    activity_instance_common::announceactivitymoment( activityinstance, "VoterLeft", var_6fbb1fbb7ad69bcf );
    
    /#
        function_867b77ff01ae92d8( activityinstance, player );
    #/
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x8b14a3dc, Offset: 0x59f
// Size: 0x80
function private function_dc5047765ee55080( activityinstance, player )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_6babc949be76f19f( activityinstance, player );
    voterpool = function_aed7f791124817ef( activityinstance, player );
    var_623ea2b6cee80dd7 = function_94e6ed80fcfa1c4d( activityinstance, votename, votes, voterpool, player );
    activity_instance_common::announceactivitymoment( activityinstance, "VoterJoined", var_623ea2b6cee80dd7 );
    
    /#
        function_8ebf1a679e72e668( activityinstance, player );
    #/
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xd1a024ae, Offset: 0x627
// Size: 0x5f, Type: bool
function private function_ad89b4f5ea0ac1e4( activityinstance, player )
{
    if ( !isdefined( activityinstance ) )
    {
        println( "<dev string:x234>" );
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x2a7>" );
        return false;
    }
    
    if ( !isdefined( function_d9d91e84ebf53d67( player ) ) )
    {
        assertmsg( "<dev string:x2d5>" );
        return false;
    }
    
    return true;
}

// Namespace activity_voting
// Params 1, eflags: 0x4
// Checksum 0x2516b3e8, Offset: 0x68f
// Size: 0x30
function private function_804f84dcf243a51( activityinstance )
{
    if ( isdefined( activityinstance ) && !isdefined( activityinstance.squadabandonvotes ) )
    {
        activityinstance.squadabandonvotes = [];
    }
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xfa16f093, Offset: 0x6c7
// Size: 0x54
function private function_d03fe514c125c3b7( activityinstance, player )
{
    squadid = function_d9d91e84ebf53d67( player );
    abandonvotes = function_6babc949be76f19f( activityinstance, player );
    activityinstance.squadabandonvotes[ squadid ] = function_b6fc189b1b726f10( abandonvotes, player );
}

// Namespace activity_voting
// Params 3, eflags: 0x4
// Checksum 0xf165ddf4, Offset: 0x723
// Size: 0x86
function private function_a12ec129e298e037( activityinstance, player, isplayerleavingvote = 0 )
{
    voteresult = function_fb9809eaf94d845f( activityinstance, player, isplayerleavingvote );
    
    if ( voteresult == "ActivityVoteResult_Success" )
    {
        function_291fc59785199b0a( activityinstance, player, "ActivityVoteResult_Success" );
        function_c11aee29e715383c( activityinstance, player );
        activity_participation::function_1b2fcd30f5842df5( activityinstance, player, 1 );
    }
    else if ( voteresult == "ActivityVoteResult_Cancelled" )
    {
        cancelsquadabandonvote( activityinstance, player );
    }
    
    return voteresult;
}

// Namespace activity_voting
// Params 3, eflags: 0x4
// Checksum 0x349f9012, Offset: 0x7b2
// Size: 0x57
function private function_fb9809eaf94d845f( activityinstance, player, isplayerleavingvote = 0 )
{
    if ( function_45ed9e6ceee5269c( activityinstance, player ) )
    {
        return "ActivityVoteResult_Success";
    }
    
    if ( function_e604fadd5318c210( activityinstance, player, isplayerleavingvote ) )
    {
        return "ActivityVoteResult_Cancelled";
    }
    
    return "ActivityVoteResult_InProgress";
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x45325107, Offset: 0x811
// Size: 0x3b, Type: bool
function private function_6babc949be76f19f( activityinstance, player )
{
    squadid = function_d9d91e84ebf53d67( player );
    return activityinstance.squadabandonvotes[ squadid ] ?? [];
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x650c4f24, Offset: 0x855
// Size: 0x50
function private function_c11aee29e715383c( activityinstance, player )
{
    if ( !isdefined( activityinstance.squadabandonvotes ) )
    {
        function_804f84dcf243a51( activityinstance );
    }
    
    squadid = function_d9d91e84ebf53d67( player );
    activityinstance.squadabandonvotes[ squadid ] = undefined;
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x453c63d, Offset: 0x8ad
// Size: 0x31
function private function_d8b0532736908c0e( activityinstance, player )
{
    var_892bca9cadcf7a33 = function_6babc949be76f19f( activityinstance, player );
    return arraycontains( var_892bca9cadcf7a33, player );
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x331ba4db, Offset: 0x8e7
// Size: 0x56, Type: bool
function private function_45ed9e6ceee5269c( activityinstance, player )
{
    squadvotecount = function_73c6775bdadf91be( activityinstance, player );
    squadmates = function_aed7f791124817ef( activityinstance, player );
    var_616737dbc22c0c94 = function_ca6130966c47d21( activityinstance, squadmates.size );
    return squadvotecount >= var_616737dbc22c0c94;
}

// Namespace activity_voting
// Params 3, eflags: 0x4
// Checksum 0xb1eb257b, Offset: 0x946
// Size: 0x4e, Type: bool
function private function_e604fadd5318c210( activityinstance, player, isplayerleavingvote = 0 )
{
    votes = function_c1410d4bdf3590e3( activityinstance, player );
    
    if ( isplayerleavingvote )
    {
        votes = arrayremove( votes, player );
    }
    
    return votes.size == 0;
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xa14691b6, Offset: 0x99d
// Size: 0x1f
function private function_73c6775bdadf91be( activityinstance, player )
{
    return function_c1410d4bdf3590e3( activityinstance, player ).size;
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xf911abd4, Offset: 0x9c5
// Size: 0x46
function private function_c1410d4bdf3590e3( activityinstance, player )
{
    squadvotes = function_6babc949be76f19f( activityinstance, player );
    squadmates = function_aed7f791124817ef( activityinstance, player );
    return function_96b3d4d45af013ce( squadvotes, squadmates );
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x709cc4d3, Offset: 0xa14
// Size: 0x59
function private function_aed7f791124817ef( activityinstance, player )
{
    /#
        if ( isdefined( level.var_45a4fa50edab5201 ) )
        {
            return level.var_45a4fa50edab5201[ player.team ][ player.sessionsquadid ].players;
        }
    #/
    
    return namespace_e55955ff7520be97::function_44ef43ff1f6d21d4( player );
}

// Namespace activity_voting
// Params 1, eflags: 0x4
// Checksum 0xa00ac327, Offset: 0xa76
// Size: 0x17
function private function_d9d91e84ebf53d67( player )
{
    return player.sessionsquadid;
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0xb4b96128, Offset: 0xa96
// Size: 0x22
function private function_b6fc189b1b726f10( votes, voter )
{
    return arraycombineunique( votes, [ voter ] );
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x1d0820cb, Offset: 0xac1
// Size: 0x48
function private function_96b3d4d45af013ce( votes, voterpool )
{
    if ( !isdefined( votes ) )
    {
        assertmsg( "<dev string:x342>" );
        return [];
    }
    
    if ( !isdefined( voterpool ) )
    {
        assertmsg( "<dev string:x36b>" );
        return [];
    }
    
    return arrayintersection( votes, voterpool );
}

// Namespace activity_voting
// Params 2, eflags: 0x4
// Checksum 0x64c0f7ef, Offset: 0xb12
// Size: 0x1f
function private function_e15169db62a7466f( votes, voterpool )
{
    return function_96b3d4d45af013ce( votes, voterpool ).size;
}

// Namespace activity_voting
// Params 4, eflags: 0x4
// Checksum 0x17efd392, Offset: 0xb3a
// Size: 0x84
function private function_67f2c8fe60304942( activityinstance, votename, votes, voterpool )
{
    var_802e4ea675e235e3 = spawnstruct();
    var_802e4ea675e235e3.activityinstance = activityinstance ?? undefined;
    var_802e4ea675e235e3.votename = votename ?? undefined;
    var_802e4ea675e235e3.votes = function_96b3d4d45af013ce( votes, voterpool );
    var_802e4ea675e235e3.voterpool = voterpool ?? [];
    return var_802e4ea675e235e3;
}

// Namespace activity_voting
// Params 6, eflags: 0x4
// Checksum 0xba333198, Offset: 0xbc7
// Size: 0x77
function private function_2db098b8c0111fd( activityinstance, votename, votes, voterpool, voter, var_d8c5526fa9a1fb2d )
{
    var_5d8a51499dc22065 = function_67f2c8fe60304942( activityinstance, votename, votes, voterpool );
    var_5d8a51499dc22065.voter = voter ?? undefined;
    var_5d8a51499dc22065.var_d8c5526fa9a1fb2d = var_d8c5526fa9a1fb2d ?? undefined;
    return var_5d8a51499dc22065;
}

// Namespace activity_voting
// Params 5, eflags: 0x4
// Checksum 0xaf39bf50, Offset: 0xc47
// Size: 0x5c
function private function_90f828ebb10eddef( activityinstance, votename, votes, voterpool, voteresult )
{
    var_856022444b713797 = function_67f2c8fe60304942( activityinstance, votename, votes, voterpool );
    var_856022444b713797.voteresult = voteresult ?? undefined;
    return var_856022444b713797;
}

// Namespace activity_voting
// Params 5, eflags: 0x4
// Checksum 0xe109febe, Offset: 0xcac
// Size: 0x58
function private function_f3a4f38302dfda7d( activityinstance, votename, votes, voterpool, var_20b9721bf8f875ed )
{
    var_730669da7e8c0fe5 = function_67f2c8fe60304942( activityinstance, votename, votes, voterpool );
    var_730669da7e8c0fe5.var_20b9721bf8f875ed = var_20b9721bf8f875ed;
    return var_730669da7e8c0fe5;
}

// Namespace activity_voting
// Params 5, eflags: 0x4
// Checksum 0xf3e98554, Offset: 0xd0d
// Size: 0x58
function private function_94e6ed80fcfa1c4d( activityinstance, votename, votes, voterpool, var_9e53a0536ce2272d )
{
    var_e2a3847bf9425f25 = function_67f2c8fe60304942( activityinstance, votename, votes, voterpool );
    var_e2a3847bf9425f25.var_9e53a0536ce2272d = var_9e53a0536ce2272d;
    return var_e2a3847bf9425f25;
}

/#

    // Namespace activity_voting
    // Params 2, eflags: 0x4
    // Checksum 0x665157d6, Offset: 0xd6e
    // Size: 0x87, Type: dev
    function private function_ff328507759cf54a( activityinstance, player )
    {
        squadmates = function_aed7f791124817ef( activityinstance, player );
        numvotes = function_73c6775bdadf91be( activityinstance, player );
        println( "<dev string:x398>" + "<dev string:x3ba>" + activityinstance.type + "<dev string:x3cf>" + activityinstance.varianttag + "<dev string:x3dc>" + numvotes + "<dev string:x3e9>" + squadmates.size + "<dev string:x3f7>" );
    }

    // Namespace activity_voting
    // Params 2, eflags: 0x4
    // Checksum 0xa6960173, Offset: 0xdfd
    // Size: 0x5e, Type: dev
    function private function_fd1845450f07c6c3( activityinstance, player )
    {
        println( "<dev string:x406>" + "<dev string:x3ba>" + activityinstance.type + "<dev string:x3cf>" + activityinstance.varianttag + "<dev string:x42e>" + player.sessionsquadid + "<dev string:x437>" );
    }

    // Namespace activity_voting
    // Params 2, eflags: 0x4
    // Checksum 0x81cdaf00, Offset: 0xe63
    // Size: 0x87, Type: dev
    function private function_867b77ff01ae92d8( activityinstance, player )
    {
        squadmates = function_aed7f791124817ef( activityinstance, player );
        numvotes = function_73c6775bdadf91be( activityinstance, player );
        println( "<dev string:x453>" + "<dev string:x3ba>" + activityinstance.type + "<dev string:x3cf>" + activityinstance.varianttag + "<dev string:x3dc>" + numvotes + "<dev string:x3e9>" + squadmates.size + "<dev string:x3f7>" );
    }

    // Namespace activity_voting
    // Params 2, eflags: 0x4
    // Checksum 0x560b1a21, Offset: 0xef2
    // Size: 0x87, Type: dev
    function private function_8ebf1a679e72e668( activityinstance, player )
    {
        squadmates = function_aed7f791124817ef( activityinstance, player );
        numvotes = function_73c6775bdadf91be( activityinstance, player );
        println( "<dev string:x48c>" + "<dev string:x3ba>" + activityinstance.type + "<dev string:x3cf>" + activityinstance.varianttag + "<dev string:x3dc>" + numvotes + "<dev string:x3e9>" + squadmates.size + "<dev string:x3f7>" );
    }

    // Namespace activity_voting
    // Params 0
    // Checksum 0x40567535, Offset: 0xf81
    // Size: 0x1cf, Type: dev
    function function_52715f99efaf4a43()
    {
        var_72a41c61e0a93ba7 = activity_nexus_debug::function_3a45e311cf4d30b7();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x4c3>" );
        devgui::add_devgui_func( "<dev string:x4e6>", "<dev string:x507>", &function_448ed313f00336c6 );
        devgui::add_devgui_func( "<dev string:x529>", "<dev string:x551>", &function_78f11c91ae3799b );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x576>" );
        devgui::add_devgui_func( "<dev string:x5ae>", "<dev string:x5c4>", &function_31c200433c386439 );
        devgui::add_devgui_func( "<dev string:x5d8>", "<dev string:x507>", &function_448ed313f00336c6 );
        devgui::add_devgui_func( "<dev string:x600>", "<dev string:x632>", &function_244f33a5b4230ce4 );
        devgui::add_devgui_func( "<dev string:x661>", "<dev string:x693>", &function_244f36a5b423137d );
        devgui::add_devgui_func( "<dev string:x6c2>", "<dev string:x6f4>", &function_244f35a5b423114a );
        devgui::add_devgui_func( "<dev string:x723>", "<dev string:x745>", &function_2d02a5b082e42f50 );
        devgui::add_devgui_func( "<dev string:x75c>", "<dev string:x77e>", &function_2d02a8b082e435e9 );
        devgui::add_devgui_func( "<dev string:x795>", "<dev string:x7b7>", &function_2d02a7b082e433b6 );
        devgui::add_devgui_func( "<dev string:x7ce>", "<dev string:x7f5>", &function_a81d539b03801486 );
        devgui::add_devgui_func( "<dev string:x80a>", "<dev string:x832>", &function_8f2b40a9eb50e341 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x848>" );
        devgui::add_devgui_func( "<dev string:x87f>", "<dev string:x8b1>", &_info );
        devgui::add_devgui_func( "<dev string:x5d8>", "<dev string:x507>", &function_448ed313f00336c6 );
        devgui::add_devgui_func( "<dev string:x8b7>", "<dev string:x8e0>", &function_e2459a14d85d8ea1 );
        devgui::add_devgui_func( "<dev string:x90a>", "<dev string:x933>", &function_e2459714d85d8808 );
        devgui::add_devgui_func( "<dev string:x95d>", "<dev string:x986>", &function_e2459814d85d8a3b );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x21800e28, Offset: 0x1158
    // Size: 0x2b, Type: dev
    function private function_654efc1380781476()
    {
        if ( isdefined( level.players ) )
        {
            return level.players[ 0 ];
        }
        
        return level.player;
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x9c5c5c34, Offset: 0x118b
    // Size: 0x6, Type: dev
    function private _info()
    {
                return;
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x690ccf35, Offset: 0x1199
    // Size: 0x29, Type: dev
    function private function_448ed313f00336c6()
    {
        hostplayer = function_654efc1380781476();
        
        if ( isplayer( hostplayer ) )
        {
            function_43b7c6f27fc1a1f8( hostplayer );
        }
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x72d3235, Offset: 0x11ca
    // Size: 0x4f, Type: dev
    function private function_e2459a14d85d8ea1()
    {
        player = level.players[ 1 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = function_654efc1380781476();
            var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
            function_df77a410e3b3636d( var_2faf8e06a4a3cec3, player );
        }
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x9e24638c, Offset: 0x1221
    // Size: 0x4f, Type: dev
    function private function_e2459714d85d8808()
    {
        player = level.players[ 2 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = function_654efc1380781476();
            var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
            function_df77a410e3b3636d( var_2faf8e06a4a3cec3, player );
        }
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0xe923531b, Offset: 0x1278
    // Size: 0x4f, Type: dev
    function private function_e2459814d85d8a3b()
    {
        player = level.players[ 3 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = function_654efc1380781476();
            var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
            function_df77a410e3b3636d( var_2faf8e06a4a3cec3, player );
        }
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x90ee027a, Offset: 0x12cf
    // Size: 0x46, Type: dev
    function private function_78f11c91ae3799b()
    {
        hostplayer = function_654efc1380781476();
        
        if ( isplayer( hostplayer ) )
        {
            var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
            cancelsquadabandonvote( var_2faf8e06a4a3cec3, hostplayer );
            iprintlnbold( "<dev string:x9b0>" );
        }
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0xe178e6ac, Offset: 0x131d
    // Size: 0x4e, Type: dev
    function private function_31c200433c386439()
    {
        function_8b82d7e240eec5c6( 1 );
        var_43d8c16ca819cb2a = 3;
        
        for ( i = 0; i < var_43d8c16ca819cb2a ; i++ )
        {
            function_116eeca2e8ad5c62();
        }
        
        iprintlnbold( "<dev string:x9e7>" + var_43d8c16ca819cb2a + "<dev string:x9ee>" );
    }

    // Namespace activity_voting
    // Params 1, eflags: 0x4
    // Checksum 0xd9d8baa0, Offset: 0x1373
    // Size: 0xb8, Type: dev
    function private function_8b82d7e240eec5c6( force )
    {
        if ( !isdefined( force ) )
        {
            force = 0;
        }
        
        if ( !force || isdefined( level.var_45a4fa50edab5201 ) )
        {
            return;
        }
        
        hostplayer = function_654efc1380781476();
        level.var_45a4fa50edab5201 = [];
        level.var_45a4fa50edab5201[ hostplayer.team ] = [];
        level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ] = spawnstruct();
        level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players = [ hostplayer ];
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x306189db, Offset: 0x1433
    // Size: 0xf2, Type: dev
    function private function_116eeca2e8ad5c62()
    {
        if ( !isdefined( level.var_9a0a400c30bf0347 ) )
        {
            level.var_9a0a400c30bf0347 = 1;
        }
        
        hostplayer = function_654efc1380781476();
        fakeplayer = spawnstruct();
        fakeplayer.sessionsquadid = hostplayer.sessionsquadid;
        fakeplayer.team = hostplayer.team;
        fakeplayer.fakeid = level.var_9a0a400c30bf0347;
        players = level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players;
        level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players[ players.size ] = fakeplayer;
        level.var_9a0a400c30bf0347++;
        return fakeplayer;
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0xe4d1ad04, Offset: 0x152d
    // Size: 0x4a, Type: dev
    function private function_a81d539b03801486()
    {
        function_8b82d7e240eec5c6();
        hostplayer = function_654efc1380781476();
        fakeplayer = function_116eeca2e8ad5c62();
        var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
        function_b3eff06557c09621( var_2faf8e06a4a3cec3, fakeplayer );
    }

    // Namespace activity_voting
    // Params 1, eflags: 0x4
    // Checksum 0xa2926efe, Offset: 0x157f
    // Size: 0x94, Type: dev
    function private function_293391885cbbe65e( fakesquadmemberindex )
    {
        if ( !isdefined( level.var_45a4fa50edab5201 ) )
        {
            return;
        }
        
        hostplayer = function_654efc1380781476();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        squadmember = level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players[ fakesquadmemberindex ];
        
        if ( !isdefined( squadmember ) )
        {
            return;
        }
        
        var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
        function_df77a410e3b3636d( var_2faf8e06a4a3cec3, squadmember );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0xf5fb2f96, Offset: 0x161b
    // Size: 0xe, Type: dev
    function private function_244f33a5b4230ce4()
    {
        function_293391885cbbe65e( 1 );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x6cf27e2f, Offset: 0x1631
    // Size: 0xe, Type: dev
    function private function_244f36a5b423137d()
    {
        function_293391885cbbe65e( 2 );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x1bf54eb8, Offset: 0x1647
    // Size: 0xe, Type: dev
    function private function_244f35a5b423114a()
    {
        function_293391885cbbe65e( 3 );
    }

    // Namespace activity_voting
    // Params 1, eflags: 0x4
    // Checksum 0x97c0b194, Offset: 0x165d
    // Size: 0x13a, Type: dev
    function private function_8f2b40a9eb50e341( fakesquadmemberindex )
    {
        if ( !isdefined( level.var_45a4fa50edab5201 ) )
        {
            return;
        }
        
        hostplayer = function_654efc1380781476();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        if ( !isdefined( fakesquadmemberindex ) )
        {
            fakesquadmemberindex = level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players.size - 1;
        }
        
        squadmember = level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players[ fakesquadmemberindex ];
        
        if ( !isdefined( squadmember ) || squadmember == hostplayer )
        {
            return;
        }
        
        var_2faf8e06a4a3cec3 = namespace_e55955ff7520be97::function_e811448130016c90( hostplayer );
        function_601a46ed2df2bba0( var_2faf8e06a4a3cec3, squadmember );
        players = level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players;
        level.var_45a4fa50edab5201[ hostplayer.team ][ hostplayer.sessionsquadid ].players = arrayremove( players, squadmember );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x600445a8, Offset: 0x179f
    // Size: 0xe, Type: dev
    function private function_2d02a5b082e42f50()
    {
        function_8f2b40a9eb50e341( 1 );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0xf90d1411, Offset: 0x17b5
    // Size: 0xe, Type: dev
    function private function_2d02a8b082e435e9()
    {
        function_8f2b40a9eb50e341( 2 );
    }

    // Namespace activity_voting
    // Params 0, eflags: 0x4
    // Checksum 0x8e0a2486, Offset: 0x17cb
    // Size: 0xe, Type: dev
    function private function_2d02a7b082e433b6()
    {
        function_8f2b40a9eb50e341( 3 );
    }

#/
