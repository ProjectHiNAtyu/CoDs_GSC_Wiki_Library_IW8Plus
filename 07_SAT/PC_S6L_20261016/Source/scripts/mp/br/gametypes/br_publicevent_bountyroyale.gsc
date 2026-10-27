// scripts\mp\br\gametypes\br_publicevent_bountyroyale.gsc  (hash_47cdea05edb781e1.gscc) (size: 28292 Bytes / 0x6e84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x490cc2a (76598314)
// size ...... 28292 (0x6e84)
// includes .. 16  (offset: 0x6938)
// strings ... 59  (offset: 0x69b8)
// dev strs .. 26  (offset: 0x6d3c)
// exports ... 67  (offset: 0x4a94)
// cseg ...... 0x5bb + 0x44d9 (0x4a94)
// imports ... 156 (offset: 0x550c)
// animtree1 . 0   (offset: 0x6e84)
// animtree2 . 0   (offset: 0x6e84)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace br_publicevent_bountyroyale;

// Namespace br_publicevent_bountyroyale
// Params 0, eflags: 0x1
// Checksum 0xa874ae4d, Offset: 0x5d9
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"bountyroyale", &init );
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xfcd30966, Offset: 0x5f8
// Size: 0x92
function init( eventinfo )
{
    if ( getdvarint( @"hash_48dc580a67359380", 1 ) == 0 )
    {
        return;
    }
    
    if ( !flags::gameflagexists( "bounty_royale_pe_init" ) )
    {
        flags::gameflaginit( "bounty_royale_pe_init", 0 );
    }
    
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.canactivatefunc = &canactivatefunc;
    eventinfo.deactivatefunc = &function_c7a6338c6f315a82;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x6b4f539d, Offset: 0x692
// Size: 0x1bd
function postinitfunc()
{
    level.var_fdca07a6f0bda1df = spawnstruct();
    level.var_fdca07a6f0bda1df.var_708abc1795dbaf45 = getdvarint( @"hash_ea78293276e6f5fc", 1 );
    level.var_fdca07a6f0bda1df.minstarttime = getdvarfloat( @"hash_e8ff82f5f9cd0948", 60 );
    level.var_fdca07a6f0bda1df.maxstarttime = getdvarfloat( @"hash_e92378f5f9f56e02", 565 );
    level.var_fdca07a6f0bda1df.eventduration = getdvarint( @"hash_b99ed95bc7f4bc06", 300 );
    level.var_fdca07a6f0bda1df.givecompensation = getdvarint( @"hash_5a4f4fdd537647b6", 1 ) > 0;
    level.var_fdca07a6f0bda1df.cancelcontracts = getdvarint( @"hash_48dc580a67359380", 1 ) > 0;
    level.var_fdca07a6f0bda1df.clusterradius = getdvarint( @"hash_ae171a9fd67fa527", 2500 );
    level.var_fdca07a6f0bda1df.var_97aadf24d0d174ea = getdvarfloat( @"hash_34fa0ec154827123", 1.5 );
    level.var_fdca07a6f0bda1df.var_3b8c5cc14b8c6195 = getdvarint( @"hash_d0cf244a05155e7d", 1 ) > 0;
    level.var_fdca07a6f0bda1df.var_34e492a810a098ef = getdvarint( @"hash_33acb5858593173", 4000 );
    level.var_fdca07a6f0bda1df.maxhunters = getdvarint( @"hash_df967a98af61e5cc", 3 );
    function_5f0da89a4cb8c6cc();
    flags::gameflagset( "bounty_royale_pe_init" );
    
    /#
        level thread debuginit();
    #/
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x5c566258, Offset: 0x857
// Size: 0xb8
function function_5f0da89a4cb8c6cc()
{
    game[ "dialog" ][ "bountyroyale_announcement" ] = "brsc_wzan_brnm";
    game[ "dialog" ][ "bountyroyale_explanation" ] = "brsc_wzan_brbs";
    game[ "dialog" ][ "bountyroyale_explanation_override" ] = "brsc_wzan_brov";
    game[ "dialog" ][ "bountyroyale_explanation_cq_exception" ] = "brsc_wzan_brbc";
    game[ "dialog" ][ "bountyroyale_poached" ] = "brsc_wzan_brpo";
    game[ "dialog" ][ "bountyroyale_success" ] = "brsc_wzan_brsu";
    game[ "dialog" ][ "bountyroyale_new_target" ] = "brsc_wzan_brnt";
    game[ "dialog" ][ "bountyroyale_end" ] = "brsc_wzan_bren";
    utility::registersharedfunc( #"assassination_quest", #"hash_c0d906c57803d43d", &function_8afee712736da8e );
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xc12e8edb, Offset: 0x917
// Size: 0x5e
function function_8afee712736da8e( targetteam, hunterteam )
{
    if ( !level.var_fdca07a6f0bda1df.var_bbfe55644d1207a5 )
    {
        level thread br_public::brleaderdialogteam( "bountyroyale_new_target", hunterteam, 1, 2, undefined, "dx_br_brbr_" );
        level thread br_public::brleaderdialogteam( "mission_ass_hunted", targetteam, 1, 2, undefined, "dx_br_brbr_" );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x3b8c3e7a, Offset: 0x97d
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x648f7d3a, Offset: 0x9b4
// Size: 0x6e
function calculateeventstarttime()
{
    if ( level.var_fdca07a6f0bda1df.maxstarttime > level.var_fdca07a6f0bda1df.minstarttime )
    {
        return randomfloatrange( level.var_fdca07a6f0bda1df.minstarttime, level.var_fdca07a6f0bda1df.maxstarttime );
    }
    
    return level.var_fdca07a6f0bda1df.minstarttime;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0xe457a48b, Offset: 0xa2a
// Size: 0x81
function function_a2743e8b4fa5854a()
{
    eventduration = level.var_fdca07a6f0bda1df.eventduration;
    buffertime = 10;
    minduration = 30;
    
    if ( level.br_circle.circleindex > -1 )
    {
        var_63cd788ad27022c0 = int( floor( br_circle::function_f30ad5eda1a16d44() ) );
        eventduration = min( eventduration, var_63cd788ad27022c0 - buffertime );
    }
    
    eventduration = max( eventduration, minduration );
    return eventduration;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x1a3b095, Offset: 0xab4
// Size: 0x219
function activatefunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    br_publicevents::showsplashtoall( "br_pe_bountyroyale_start", "splash_list_br_pe_bountyroyale" );
    level thread br_public::brleaderdialog( "bountyroyale_announcement", 1, undefined, undefined, undefined, undefined, "dx_br_brbr_" );
    level.var_533642d714767ad8 = 1;
    level.var_fdca07a6f0bda1df.var_bbfe55644d1207a5 = 1;
    level.asnprops.var_f21b95e41e7b314d = 1;
    level.asnprops.var_10a29b751ad7ff7c = 1;
    level.var_d7be75388b125a1c = 1;
    
    if ( level.usegulag )
    {
        level callback::add( #"br_player_respawn", &onplayerrespawn );
    }
    
    function_191eec4f2a4f8af2( function_d5141fc12e321361() );
    wait 1;
    var_7babff54f87e36c2 = function_d5141fc12e321361();
    
    foreach ( team in var_7babff54f87e36c2 )
    {
        level thread br_public::brleaderdialogteam( "bountyroyale_explanation", team, 1, undefined, undefined, "dx_br_brbr_" );
    }
    
    if ( level.var_fdca07a6f0bda1df.cancelcontracts )
    {
        function_2c351b3426cd21fe();
    }
    
    wait 2.5;
    function_6bf7ffc4bd6979fd();
    eventduration = function_a2743e8b4fa5854a();
    level.var_fdca07a6f0bda1df.eventendtime = gettime() + eventduration * 1000;
    level thread starttimer( eventduration, level.var_fdca07a6f0bda1df.eventendtime );
    function_e74b721c0ce273cc();
    level.var_fdca07a6f0bda1df.var_bbfe55644d1207a5 = undefined;
    wait eventduration;
    level thread br_public::brleaderdialog( "bountyroyale_end", 1, undefined, undefined, undefined, undefined, "dx_br_brbr_" );
    br_publicevents::function_a1af4e372c2ecc3( %"bountyroyale" );
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x2f02600e, Offset: 0xcd5
// Size: 0x17f
function function_2c351b3426cd21fe()
{
    foreach ( team, contract in level.contractmanager.var_ec04bf3a584cbd90 )
    {
        if ( function_d85e61aea54e4717( contract ) )
        {
            level thread br_public::brleaderdialogteam( "bountyroyale_explanation_cq_exception", team, 1, undefined, undefined, "dx_br_brbr_" );
            continue;
        }
        
        var_caf044c7e33cbea7 = 0;
        
        if ( level.var_fdca07a6f0bda1df.var_3b8c5cc14b8c6195 )
        {
            contractref = contract.type.ref;
            
            if ( contractref == "assassination" || contractref == "master_assassination" )
            {
                contract.forcesuccess = 1;
            }
            
            var_caf044c7e33cbea7 = br_contract_manager::function_7864d8f2e3f3454b( contract, contract.var_fe0156f1cf4e5f41, team );
        }
        
        if ( !var_caf044c7e33cbea7 )
        {
            contract br_contract_manager::contract_canceltask( team );
            
            if ( level.var_fdca07a6f0bda1df.givecompensation )
            {
                rewards = br_contract_manager::function_83f627106ef43736( "bounty_royale_cancel_compensation", undefined, team, contract.var_fe0156f1cf4e5f41 );
            }
        }
        
        level thread br_public::brleaderdialogteam( "bountyroyale_explanation_override", team, 1, undefined, undefined, "dx_br_brbr_" );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xb849bd1, Offset: 0xe5c
// Size: 0xe0
function onplayerrespawn( params )
{
    player = params.player;
    
    if ( !isdefined( player ) || arraycontains( level.var_fdca07a6f0bda1df.eventdata.participatingteams, player.team ) )
    {
        return;
    }
    
    newtarget = function_3f149e07705befef( player.team, undefined );
    
    if ( isdefined( newtarget ) )
    {
        function_56df1f1349b3ca77( player.team, newtarget );
        level.var_fdca07a6f0bda1df.eventdata.participatingteams = arraycombineunique( level.var_fdca07a6f0bda1df.eventdata.participatingteams, [ player.team ] );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xadb1712d, Offset: 0xf44
// Size: 0xca
function function_191eec4f2a4f8af2( targetteams )
{
    if ( !isdefined( level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6 ) )
    {
        level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6 = [];
    }
    
    foreach ( team in targetteams )
    {
        level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6[ team ] = br_contract_manager::function_af264a228f8c4b11( team );
        br_contract_manager::function_27236a33ea7d5ad9( team, 1 );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x49325edd, Offset: 0x1016
// Size: 0xb4
function function_6bf7ffc4bd6979fd()
{
    if ( !isdefined( level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6 ) )
    {
        return;
    }
    
    foreach ( team, shouldforce in level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6 )
    {
        br_contract_manager::function_27236a33ea7d5ad9( team, shouldforce );
    }
    
    level.var_fdca07a6f0bda1df.var_89a3cec8aa47a9f6 = [];
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x10b8d585, Offset: 0x10d2
// Size: 0x18, Type: bool
function function_d85e61aea54e4717( contract )
{
    return istrue( contract.iselite );
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x4cb34ec7, Offset: 0x10f3
// Size: 0xb3
function function_e74b721c0ce273cc()
{
    availableteams = function_d5141fc12e321361();
    
    if ( availableteams.size <= 1 )
    {
        return;
    }
    
    function_729f5f17033279d0( availableteams );
    var_b744bc1e119447fe = function_a13e3f055fc15f6f( availableteams );
    
    foreach ( team, target in var_b744bc1e119447fe )
    {
        function_56df1f1349b3ca77( team, target );
    }
    
    function_24fe7227ec5a2165( var_b744bc1e119447fe );
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x7e0a2584, Offset: 0x11ae
// Size: 0x138
function function_729f5f17033279d0( availableteams )
{
    level.var_fdca07a6f0bda1df.eventdata = spawnstruct();
    level.var_fdca07a6f0bda1df.eventdata.participatingteams = availableteams;
    level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15 = [];
    
    foreach ( team in availableteams )
    {
        teamdata = spawnstruct();
        teamdata.failcount = 0;
        teamdata.successcount = 0;
        teamdata.targetedplayer = undefined;
        teamdata.var_6ff8379e9568d24f = [];
        level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ team ] = teamdata;
        function_ebebc9c703462516( team, 0 );
        function_6239e450a9a265b1( team, 0 );
        function_69639a51e4bc2a16( team, 0 );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x15cad19, Offset: 0x12ee
// Size: 0x1f3
function function_56df1f1349b3ca77( team, target )
{
    [ player ] = teams::getteamdata( team, "players" );
    contractdata = level.contractmanager.var_ab95e990a9975df8[ "assassination" ];
    paramoverrides = spawnstruct();
    paramoverrides.targetteam = target.team;
    paramoverrides.targetplayer = target;
    paramoverrides.time = function_54888467536d085f();
    instance = spawnstruct();
    instance.task = spawnstruct();
    instance.task.type = contractdata;
    instance.task.paramoverrides = paramoverrides;
    instance.task.var_95bc436713519563 = [ "br_assassination_timer_expire_hunters_lose" ];
    instance.task.skipanalytics = 1;
    instance.task.var_8694b8091d3d20ae = 1;
    instance.task.var_efa81f3d9b78d1d9 = &oncontractend;
    instance.task br_contract_manager::function_3d62ad47bb990e95( player );
    instance.task thread [[ contractdata.funcs[ "onTeamAssigned" ] ]]();
    var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ target.team ];
    var_57ee2d1096b1e3de.targetedplayer = target;
    var_57ee2d1096b1e3de.var_6ff8379e9568d24f = arraycombineunique( var_57ee2d1096b1e3de.var_6ff8379e9568d24f, [ team ] );
    function_6239e450a9a265b1( team, 1 );
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x8ffd1897, Offset: 0x14e9
// Size: 0xa2
function function_d5141fc12e321361()
{
    availableteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( br_contract_manager::function_9cb0572c407b9880( team ) )
        {
            continue;
        }
        
        if ( function_67888fe593cd2fb8( team ) )
        {
            continue;
        }
        
        availableteams[ availableteams.size ] = team;
    }
    
    return availableteams;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x3b3cfb10, Offset: 0x1594
// Size: 0xbd, Type: bool
function function_67888fe593cd2fb8( team )
{
    alivecount = teams::getteamdata( team, "aliveCount" );
    
    if ( alivecount == 0 )
    {
        return true;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0xcc285565, Offset: 0x165a
// Size: 0x40
function function_54888467536d085f()
{
    var_68d5c64e3eb8bc82 = level.var_fdca07a6f0bda1df.eventendtime - gettime();
    remainingseconds = int( floor( var_68d5c64e3eb8bc82 / 1000 ) );
    return remainingseconds;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x12b9b62a, Offset: 0x16a3
// Size: 0xe9
function function_1c482a1287b16a53( availableteams )
{
    var_b744bc1e119447fe = [];
    randomizedteams = arrayrandomize( availableteams );
    
    foreach ( index, hunterteam in randomizedteams )
    {
        targetindex = index + 1;
        
        if ( targetindex >= randomizedteams.size )
        {
            targetindex = 0;
        }
        
        targetteam = randomizedteams[ targetindex ];
        var_fc943dae65c4d7c2 = teams::getteamdata( targetteam, "alivePlayers" );
        targetplayer = utility::array_random( var_fc943dae65c4d7c2 );
        var_b744bc1e119447fe[ hunterteam ] = targetplayer;
    }
    
    return var_b744bc1e119447fe;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xe733daaa, Offset: 0x1795
// Size: 0x2c2
function oncontractend( success, endstate )
{
    level endon( #"game_ended" );
    
    if ( function_258c990454bff383() || !br_publicevents::ispubliceventoftypeactive( %"bountyroyale" ) )
    {
        function_a10a2b54e909d4b6();
    }
    else
    {
        br_contract_manager::function_27236a33ea7d5ad9( self.hunterteam, 1 );
    }
    
    function_f0148d15eece9a89( endstate );
    wait 2;
    br_contract_manager::function_27236a33ea7d5ad9( self.hunterteam, 0 );
    function_69639a51e4bc2a16( self.targetteam, 0 );
    function_69639a51e4bc2a16( self.hunterteam, 0 );
    function_3e38429afbddb5c5();
    
    if ( !br_publicevents::ispubliceventoftypeactive( %"bountyroyale" ) )
    {
        return;
    }
    
    var_898a627b92c23dc5 = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ self.hunterteam ];
    var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ self.targetteam ];
    var_57ee2d1096b1e3de.var_6ff8379e9568d24f = arrayremove( var_57ee2d1096b1e3de.var_6ff8379e9568d24f, self.hunterteam );
    
    if ( var_57ee2d1096b1e3de.var_6ff8379e9568d24f.size == 0 )
    {
        var_57ee2d1096b1e3de.targetedplayer = undefined;
        function_a10a2b54e909d4b6();
    }
    
    var_4f8445da3c85dd73 = endstate == "Win";
    ispoached = endstate == "Vanished";
    
    if ( var_4f8445da3c85dd73 )
    {
        var_898a627b92c23dc5.successcount++;
        function_ebebc9c703462516( self.hunterteam, var_898a627b92c23dc5.successcount );
        level thread br_public::brleaderdialogteam( "bountyroyale_success", self.hunterteam, 1, undefined, undefined, "dx_br_brbr_" );
    }
    else if ( ispoached )
    {
        level thread br_public::brleaderdialogteam( "bountyroyale_poached", self.hunterteam, 1, undefined, undefined, "dx_br_brbr_" );
    }
    
    if ( var_4f8445da3c85dd73 || ispoached )
    {
        var_57ee2d1096b1e3de.failcount++;
        
        if ( function_67888fe593cd2fb8( self.hunterteam ) )
        {
            return;
        }
        
        if ( function_258c990454bff383() )
        {
            return;
        }
        
        lasttarget = self.targetteam;
        newtarget = function_3f149e07705befef( self.hunterteam, lasttarget );
        
        if ( isdefined( newtarget ) )
        {
            function_56df1f1349b3ca77( self.hunterteam, newtarget );
            return;
        }
        
        function_6239e450a9a265b1( self.hunterteam, 0 );
        var_9eb2b1914b7f4a07 = level.var_fdca07a6f0bda1df.eventdata.participatingteams.size;
        assert( var_9eb2b1914b7f4a07 <= 1, "<dev string:x24>" + var_9eb2b1914b7f4a07 + "<dev string:x5a>" + self.hunterteam + "<dev string:x6a>" );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xb267fb2c, Offset: 0x1a5f
// Size: 0xac
function function_f0148d15eece9a89( endstate )
{
    switch ( endstate )
    {
        case #"hash_602a0e6cc25d3c99":
            function_69639a51e4bc2a16( self.hunterteam, 1 );
            function_69639a51e4bc2a16( self.targetteam, 4 );
            break;
        case #"hash_3b5e333b846150b0":
            function_69639a51e4bc2a16( self.targetteam, 3 );
            break;
        case #"hash_71c7bd3c3fd26bb":
            function_69639a51e4bc2a16( self.hunterteam, 2 );
            function_69639a51e4bc2a16( self.targetteam, 4 );
            break;
        default:
            break;
    }
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x7cf9abef, Offset: 0x1b13
// Size: 0xb, Type: bool
function function_258c990454bff383()
{
    return function_54888467536d085f() < 5;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0xa57c18b7, Offset: 0x1b27
// Size: 0x98
function function_3e38429afbddb5c5()
{
    foreach ( player in teams::getteamdata( self.hunterteam, "players" ) )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player br_assassination_quest::hideassassinationhud( self );
    }
    
    game_utility::questcircle_delete();
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x3e109d12, Offset: 0x1bc7
// Size: 0x90
function function_a10a2b54e909d4b6()
{
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player br_assassination_quest::hideassassinationtargethud();
    }
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xe342fd91, Offset: 0x1c5f
// Size: 0x72
function function_3f149e07705befef( hunterteam, lasttarget )
{
    switch ( level.var_fdca07a6f0bda1df.var_708abc1795dbaf45 )
    {
        case 0:
            return function_67df3a14383c518e( hunterteam, lasttarget );
        case 1:
            return function_1581549226a41de3( hunterteam, undefined );
        case 2:
            return function_1581549226a41de3( hunterteam, lasttarget );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x901759d3, Offset: 0x1cd9
// Size: 0x333
function function_67df3a14383c518e( hunterteam, lasttarget )
{
    var_402384e392946204 = function_1cc65394637560e6( hunterteam );
    possibleteams = [];
    toremove = [];
    distancestep = level.var_fdca07a6f0bda1df.var_34e492a810a098ef;
    var_af8a429facd717a4 = distancestep * distancestep;
    
    foreach ( team in level.var_fdca07a6f0bda1df.eventdata.participatingteams )
    {
        if ( team == hunterteam )
        {
            continue;
        }
        
        if ( team == lasttarget && level.var_fdca07a6f0bda1df.eventdata.participatingteams.size > 2 )
        {
            continue;
        }
        
        if ( function_67888fe593cd2fb8( team ) )
        {
            toremove[ toremove.size ] = team;
            continue;
        }
        
        teamdata = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ team ];
        
        if ( teamdata.var_6ff8379e9568d24f.size >= level.var_fdca07a6f0bda1df.maxhunters )
        {
            continue;
        }
        
        squaddata = spawnstruct();
        squaddata.team = team;
        squaddata.center = function_1cc65394637560e6( team );
        squaddata.distsquared = distancesquared( var_402384e392946204, squaddata.center );
        distancepenalty = int( floor( squaddata.distsquared / var_af8a429facd717a4 ) );
        squaddata.score = teamdata.successcount - teamdata.failcount;
        squaddata.score -= distancepenalty;
        possibleteams[ possibleteams.size ] = squaddata;
    }
    
    level.var_fdca07a6f0bda1df.eventdata.participatingteams = arrayremove( level.var_fdca07a6f0bda1df.eventdata.participatingteams, toremove );
    bestteam = undefined;
    
    foreach ( squadteam in possibleteams )
    {
        if ( !isdefined( bestteam ) || bestteam.score < squadteam.score )
        {
            bestteam = squadteam;
        }
    }
    
    targetteam = bestteam.team;
    target = determinetargetplayer( targetteam );
    return target;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x3b533801, Offset: 0x2015
// Size: 0x24f
function function_1581549226a41de3( hunterteam, lasttarget )
{
    var_402384e392946204 = function_1cc65394637560e6( hunterteam );
    toremove = [];
    closestplayer = undefined;
    var_350b991bbbed45c7 = 2147483647;
    
    foreach ( team in level.var_fdca07a6f0bda1df.eventdata.participatingteams )
    {
        if ( team == hunterteam )
        {
            continue;
        }
        
        if ( team == lasttarget && level.var_fdca07a6f0bda1df.eventdata.participatingteams.size > 2 )
        {
            continue;
        }
        
        if ( function_67888fe593cd2fb8( team ) )
        {
            toremove[ toremove.size ] = team;
            continue;
        }
        
        var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ team ];
        players = [];
        
        if ( isdefined( var_57ee2d1096b1e3de.targetedplayer ) )
        {
            players[ players.size ] = var_57ee2d1096b1e3de.targetedplayer;
        }
        else
        {
            players = teams::getteamdata( team, "alivePlayers" );
        }
        
        foreach ( player in players )
        {
            distsquared = distancesquared( var_402384e392946204, player.origin );
            
            if ( distsquared < var_350b991bbbed45c7 )
            {
                var_350b991bbbed45c7 = distsquared;
                closestplayer = player;
            }
        }
    }
    
    level.var_fdca07a6f0bda1df.eventdata.participatingteams = arrayremove( level.var_fdca07a6f0bda1df.eventdata.participatingteams, toremove );
    return closestplayer;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x12d4f0c9, Offset: 0x226d
// Size: 0x7b
function determinetargetplayer( targetteam )
{
    target = undefined;
    var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ targetteam ];
    
    if ( isdefined( var_57ee2d1096b1e3de.targetedplayer ) )
    {
        target = var_57ee2d1096b1e3de.targetedplayer;
    }
    else
    {
        var_fc943dae65c4d7c2 = teams::getteamdata( targetteam, "alivePlayers" );
        target = utility::array_random( var_fc943dae65c4d7c2 );
    }
    
    return target;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x83075e9c, Offset: 0x22f1
// Size: 0x6a
function starttimer( eventduration, eventendtime )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    setomnvar( "ui_publicevent_timer_type", 15 );
    setomnvar( "ui_publicevent_timer", eventendtime );
    setomnvar( "ui_minimap_pulse", 1 );
    wait eventduration;
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x28a6038c, Offset: 0x2363
// Size: 0x92, Type: bool
function canactivatefunc()
{
    foreach ( func in level.var_fdca07a6f0bda1df.activationblockers )
    {
        if ( [[ func ]]() )
        {
            return false;
        }
    }
    
    if ( br_public::function_73ed6e27eb5e7544() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xf4af6e6e, Offset: 0x23fe
// Size: 0x7a
function function_b2ea64cecb9a4d53( func )
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "bounty_royale_pe_init" );
    
    if ( !isdefined( level.var_fdca07a6f0bda1df.activationblockers ) )
    {
        level.var_fdca07a6f0bda1df.activationblockers = [];
    }
    
    level.var_fdca07a6f0bda1df.activationblockers[ level.var_fdca07a6f0bda1df.activationblockers.size ] = func;
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0x5243367, Offset: 0x2480
// Size: 0x9
function function_c7a6338c6f315a82()
{
    thread eventcleanup();
}

// Namespace br_publicevent_bountyroyale
// Params 0
// Checksum 0xdaa3f965, Offset: 0x2491
// Size: 0x150
function eventcleanup()
{
    if ( isdefined( level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15 ) )
    {
        level thread br_analytics::function_ba7e47ee7f1974ec( self, level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15 );
    }
    
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    
    foreach ( team in level.teamnamelist )
    {
        if ( level.contractmanager )
        {
            br_contract_manager::function_27236a33ea7d5ad9( team, 0 );
        }
        
        function_6239e450a9a265b1( team, 0 );
        function_ebebc9c703462516( team, 0 );
        function_69639a51e4bc2a16( team, 0 );
    }
    
    if ( level.usegulag )
    {
        level callback::remove( #"br_player_respawn", &onplayerrespawn );
    }
    
    wait 2;
    level.var_533642d714767ad8 = undefined;
    
    if ( level.asnprops )
    {
        level.asnprops.var_f21b95e41e7b314d = undefined;
        level.asnprops.var_9c6cf82880bd659c = undefined;
    }
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xe2b23526, Offset: 0x25e9
// Size: 0xb8
function function_a13e3f055fc15f6f( availableteams )
{
    playerclusters = function_30950d7c95ca3d71( availableteams );
    var_b744bc1e119447fe = [];
    
    foreach ( cluster in playerclusters )
    {
        bounties = function_1c482a1287b16a53( cluster.teams );
        var_b744bc1e119447fe = function_c6c06162c8e6ae75( var_b744bc1e119447fe, bounties );
    }
    
    return var_b744bc1e119447fe;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xf75121f5, Offset: 0x26aa
// Size: 0x55c
function function_30950d7c95ca3d71( availableteams )
{
    clusters = [];
    clustersgrid = [];
    var_5ed4dcc36c53c99d = [];
    squadcenters = [];
    var_a257cd69bf9eefff = 0;
    clusterlength = 2 * level.var_fdca07a6f0bda1df.clusterradius;
    
    foreach ( team in availableteams )
    {
        squadcentroid = function_1cc65394637560e6( team );
        squadcenters[ team ] = squadcentroid;
        var_9d77e543b3143cab = int( floor( squadcentroid[ 0 ] / clusterlength ) );
        var_e8991b7655b2946e = int( floor( squadcentroid[ 1 ] / clusterlength ) );
        
        if ( !isdefined( clustersgrid[ var_9d77e543b3143cab ] ) )
        {
            clustersgrid[ var_9d77e543b3143cab ] = [];
        }
        
        if ( !isdefined( clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ] ) )
        {
            cluster = spawnstruct();
            cluster.teams = [ team ];
            cluster.centroid = squadcentroid;
            clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ] = cluster;
            clusters[ clusters.size ] = cluster;
            continue;
        }
        
        cluster = clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ];
        cluster.teams[ cluster.teams.size ] = team;
        cluster.centroid += ( squadcentroid - cluster.centroid ) / cluster.teams.size;
        var_5ed4dcc36c53c99d[ var_5ed4dcc36c53c99d.size ] = cluster;
    }
    
    var_116ce816a835f516 = arrayremove( clusters, var_5ed4dcc36c53c99d );
    var_42c0da0bfc79e2b1 = var_116ce816a835f516.size;
    
    /#
        thread drawclusters( var_116ce816a835f516, squadcenters, 1 );
    #/
    
    result = function_55a0c540d7b39dd4( clusters, var_116ce816a835f516, squadcenters, level.var_fdca07a6f0bda1df.clusterradius );
    
    if ( result.var_116ce816a835f516.size > 0 && level.var_fdca07a6f0bda1df.var_97aadf24d0d174ea > 0 )
    {
        maxradius = level.var_fdca07a6f0bda1df.clusterradius * level.var_fdca07a6f0bda1df.var_97aadf24d0d174ea;
        result = function_55a0c540d7b39dd4( result.clusters, result.var_116ce816a835f516, squadcenters, maxradius );
    }
    
    if ( result.var_116ce816a835f516.size == 1 )
    {
        result = function_55a0c540d7b39dd4( result.clusters, result.var_116ce816a835f516, squadcenters, level.var_fdca07a6f0bda1df.clusterradius );
    }
    
    clusters = result.clusters;
    var_116ce816a835f516 = result.var_116ce816a835f516;
    
    if ( var_116ce816a835f516.size > 0 )
    {
        cluster = spawnstruct();
        cluster.teams = [];
        cluster.centroid = ( 0, 0, 0 );
        var_a257cd69bf9eefff = 1;
        
        foreach ( var_28d19792004c7ce1 in var_116ce816a835f516 )
        {
            cluster.teams[ cluster.teams.size ] = var_28d19792004c7ce1.teams[ 0 ];
            cluster.centroid += ( var_28d19792004c7ce1.centroid - cluster.centroid ) / cluster.teams.size;
            clusters = arrayremove( clusters, var_28d19792004c7ce1 );
        }
        
        clusters[ clusters.size ] = cluster;
    }
    
    /#
        var_d2b183323b1c64fe = [];
        teamcount = 0;
        
        foreach ( cluster in clusters )
        {
            assert( cluster.teams.size > 1, "<dev string:x6c>" );
            
            foreach ( team in cluster.teams )
            {
                teamcount++;
                
                if ( !isdefined( var_d2b183323b1c64fe[ team ] ) )
                {
                    var_d2b183323b1c64fe[ team ] = 1;
                    continue;
                }
                
                assertmsg( "<dev string:x9c>" + team + "<dev string:xa2>" );
            }
        }
        
        assert( teamcount == availableteams.size, "<dev string:xc8>" );
        thread drawclusters( clusters, squadcenters );
    #/
    
    function_8f4cdeb5dcf501d1( clusters, var_42c0da0bfc79e2b1, var_a257cd69bf9eefff );
    return clusters;
}

// Namespace br_publicevent_bountyroyale
// Params 4
// Checksum 0x719464ea, Offset: 0x2c0f
// Size: 0x1ef
function function_55a0c540d7b39dd4( clusters, var_116ce816a835f516, squadcenters, maxdistance )
{
    toremove = [];
    var_1ab3474a7c6d13eb = maxdistance * maxdistance;
    
    foreach ( var_28d19792004c7ce1 in var_116ce816a835f516 )
    {
        if ( !function_b249dc8d64ad59fd( var_28d19792004c7ce1 ) )
        {
            continue;
        }
        
        nearcluster = function_c4b9c163757a1b16( var_28d19792004c7ce1, clusters );
        var_3b6f9f2795ad440 = var_28d19792004c7ce1.teams[ 0 ];
        var_1fda01e66a20ba90 = 0;
        var_c0605ab1f710e556 = var_116ce816a835f516.size - toremove.size;
        
        if ( var_c0605ab1f710e556 == 1 )
        {
            var_1fda01e66a20ba90 = 1;
        }
        else
        {
            var_a90a9ca8d29d1331 = squadcenters[ var_3b6f9f2795ad440 ];
            var_b70547d613d62a8b = nearcluster.centroid;
            var_1fda01e66a20ba90 = distance2dsquared( var_b70547d613d62a8b, var_a90a9ca8d29d1331 ) < var_1ab3474a7c6d13eb;
        }
        
        if ( var_1fda01e66a20ba90 )
        {
            nearcluster.centroid += ( var_28d19792004c7ce1.centroid - nearcluster.centroid ) / nearcluster.teams.size;
            
            if ( function_b249dc8d64ad59fd( nearcluster ) )
            {
                toremove[ toremove.size ] = nearcluster;
            }
            
            nearcluster.teams[ nearcluster.teams.size ] = var_3b6f9f2795ad440;
            toremove[ toremove.size ] = var_28d19792004c7ce1;
            clusters = arrayremove( clusters, var_28d19792004c7ce1 );
        }
    }
    
    var_116ce816a835f516 = arrayremove( var_116ce816a835f516, toremove );
    result = spawnstruct();
    result.clusters = clusters;
    result.var_116ce816a835f516 = var_116ce816a835f516;
    return result;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xa6a5e113, Offset: 0x2e07
// Size: 0x1b, Type: bool
function function_b249dc8d64ad59fd( cluster )
{
    return cluster.teams.size == 1;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xf297205c, Offset: 0x2e2b
// Size: 0xdb
function function_c4b9c163757a1b16( cluster, clusters )
{
    closestcluster = undefined;
    var_d809a0d4ba10a1f6 = undefined;
    
    foreach ( candidatecluster in clusters )
    {
        if ( candidatecluster == cluster )
        {
            continue;
        }
        
        dist = distance2dsquared( cluster.centroid, candidatecluster.centroid );
        
        if ( !isdefined( var_d809a0d4ba10a1f6 ) || dist < var_d809a0d4ba10a1f6 )
        {
            var_d809a0d4ba10a1f6 = dist;
            closestcluster = candidatecluster;
        }
    }
    
    return closestcluster;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x281dd6c1, Offset: 0x2f0f
// Size: 0xdc
function function_1cc65394637560e6( team )
{
    var_d4d9c3e347bb10ca = ( 0, 0, 0 );
    teamsize = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            var_d4d9c3e347bb10ca += player.origin;
            teamsize++;
        }
    }
    
    if ( teamsize > 0 )
    {
        var_d4d9c3e347bb10ca /= teamsize;
    }
    
    return var_d4d9c3e347bb10ca;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x36f40006, Offset: 0x2ff4
// Size: 0xb2
function function_6239e450a9a265b1( team, hascontract )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player omnvar_utility::function_85d5f88af471ac4b( "ui_br_pe_bounty_royale_data", 0, 1, hascontract );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0x904566bd, Offset: 0x30ae
// Size: 0xb3
function function_ebebc9c703462516( team, var_c215b0497761ba92 )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( !isdefined( players ) )
        {
            continue;
        }
        
        player omnvar_utility::function_85d5f88af471ac4b( "ui_br_pe_bounty_royale_data", 1, 4, var_c215b0497761ba92 );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xf03c1212, Offset: 0x3169
// Size: 0xff
function function_69639a51e4bc2a16( team, notificationstate )
{
    players = teams::getteamdata( team, "players" );
    var_c502c37fda499f96 = -1;
    
    foreach ( player in players )
    {
        if ( !isdefined( players ) )
        {
            continue;
        }
        
        if ( var_c502c37fda499f96 == -1 )
        {
            var_ddf1da86a03ef4e7 = player omnvar_utility::function_feb50abd0ba8a2e7( "ui_br_pe_bounty_royale_data", 5, 4 );
            
            if ( notificationstate > 0 )
            {
                var_c502c37fda499f96 = 1 << notificationstate - 1;
                var_c502c37fda499f96 = var_ddf1da86a03ef4e7 | var_c502c37fda499f96;
            }
            else
            {
                var_c502c37fda499f96 = 0;
            }
        }
        
        player omnvar_utility::function_85d5f88af471ac4b( "ui_br_pe_bounty_royale_data", 5, 4, var_c502c37fda499f96 );
    }
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xebb8fb75, Offset: 0x3270
// Size: 0x3d
function function_24fe7227ec5a2165( var_b744bc1e119447fe )
{
    if ( getdvarint( @"hash_e36b1d2f6f9475cd", 0 ) == 0 )
    {
        return;
    }
    
    stats = function_b53ea640d574ef0b( var_b744bc1e119447fe );
    function_eac78007074e2dd4( stats );
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x3a064c7d, Offset: 0x32b5
// Size: 0x28d
function function_b53ea640d574ef0b( var_b744bc1e119447fe )
{
    stats = spawnstruct();
    stats.distances = [];
    stats.huntedteammates = [];
    stats.targetteams = [];
    stats.var_5e0a16b0720022f4 = 0;
    var_91554df888b60ca3 = level.var_fdca07a6f0bda1df.clusterradius * 2;
    
    foreach ( team, target in var_b744bc1e119447fe )
    {
        stats.targetteams[ team ] = target.team;
        stats.huntedteammates[ target.team ] = target;
        var_d4d9c3e347bb10ca = function_1cc65394637560e6( team );
        dist = distance2d( var_d4d9c3e347bb10ca, target.origin );
        
        if ( !isdefined( stats.mindistance ) || dist < stats.mindistance )
        {
            stats.mindistance = dist;
        }
        
        if ( !isdefined( stats.maxdistance ) || dist > stats.maxdistance )
        {
            stats.maxdistance = dist;
        }
        
        if ( dist > var_91554df888b60ca3 )
        {
            stats.var_5e0a16b0720022f4++;
        }
        
        stats.distances[ stats.distances.size ] = dist;
    }
    
    stats.distances = arraysort( stats.distances );
    stats.averagedistance = utility::array_average( stats.distances );
    var_cd3cf2cf3b927430 = int( floor( stats.distances.size / 2 ) );
    
    if ( stats.distances.size % 2 != 0 )
    {
        stats.var_d34e3ab573ec535f = stats.distances[ var_cd3cf2cf3b927430 ];
    }
    else
    {
        var_4f7cc90ae3a68c0 = stats.distances[ var_cd3cf2cf3b927430 ] + stats.distances[ var_cd3cf2cf3b927430 - 1 ];
        stats.var_d34e3ab573ec535f = var_4f7cc90ae3a68c0 / 2;
    }
    
    return stats;
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xe34bdc39, Offset: 0x354b
// Size: 0x190
function function_eac78007074e2dd4( stats, waveindex )
{
    logstring( "-----------------------------------------------------" );
    logstring( "Public Event Bounty Royale - Assignation Statistics :" );
    logstring( "-----------------------------------------------------" );
    logstring( "----- Nb Bounties distributed: " + stats.targetteams.size );
    targetteams = stats.targetteams;
    logstring( "Targets Chains: " );
    
    while ( targetteams.size > 0 )
    {
        daisychain = function_42680cbdfe47446b( targetteams );
        str = function_d2256c44ce3350e8( daisychain, stats.huntedteammates );
        logstring( str );
        
        foreach ( key in daisychain )
        {
            targetteams[ key ] = undefined;
        }
    }
    
    logstring( "Isolated Targets: " + stats.var_5e0a16b0720022f4 );
    logstring( "Minimum distance: " + stats.mindistance );
    logstring( "Maximum distance: " + stats.maxdistance );
    logstring( "Median  distance: " + stats.var_d34e3ab573ec535f );
    logstring( "Average distance: " + stats.averagedistance );
    logstring( "-----------------------------------------------------" );
}

// Namespace br_publicevent_bountyroyale
// Params 2
// Checksum 0xf2d6d462, Offset: 0x36e3
// Size: 0x9c
function function_d2256c44ce3350e8( daisychain, huntedteammates )
{
    str = "";
    
    for ( i = 0; i < daisychain.size - 1 ; i++ )
    {
        if ( i == 0 )
        {
            team = daisychain[ i ];
            str += team;
        }
        
        targetteam = daisychain[ i + 1 ];
        str = str + " --> " + targetteam;
        str = str + " ( " + huntedteammates[ targetteam ].name + " )";
    }
    
    return str;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0xf7524db, Offset: 0x3788
// Size: 0x72
function function_42680cbdfe47446b( targetteams )
{
    firstteam = utility::array_get_first_item( targetteams );
    nextteam = firstteam;
    daisychain = [ firstteam ];
    
    for ( haslooped = 0; !haslooped ; haslooped = nextteam == firstteam )
    {
        if ( !isdefined( targetteams[ nextteam ] ) )
        {
            break;
        }
        
        nextteam = targetteams[ nextteam ];
        daisychain[ daisychain.size ] = nextteam;
    }
    
    return daisychain;
}

// Namespace br_publicevent_bountyroyale
// Params 3
// Checksum 0x27929882, Offset: 0x3803
// Size: 0x51
function function_8f4cdeb5dcf501d1( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 )
{
    if ( getdvarint( @"hash_e36b1d2f6f9475cd", 0 ) == 0 )
    {
        return;
    }
    
    stats = function_55238f73137ad387( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 );
    function_988dc73bb8f948ea( stats );
}

// Namespace br_publicevent_bountyroyale
// Params 3
// Checksum 0xfb9a8b89, Offset: 0x385c
// Size: 0x1d5
function function_55238f73137ad387( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 )
{
    stats = spawnstruct();
    stats.clusterscount = clusters.size;
    stats.var_c977fb4fd957cbe9 = 0;
    
    if ( var_7abadce195fc4305 )
    {
        lastcluster = clusters[ clusters.size - 1 ];
        stats.var_c977fb4fd957cbe9 = lastcluster.teams.size;
    }
    
    stats.var_4dc2769dfe116232 = var_42c0da0bfc79e2b1 - stats.var_c977fb4fd957cbe9;
    var_d8ee20a6bce613f9 = [];
    
    foreach ( cluster in clusters )
    {
        var_d8ee20a6bce613f9[ var_d8ee20a6bce613f9.size ] = cluster.teams.size;
    }
    
    stats.var_9828b4fd72cadf5e = arraysort( var_d8ee20a6bce613f9 );
    stats.averagesize = utility::array_average( stats.var_9828b4fd72cadf5e );
    var_cd3cf2cf3b927430 = int( floor( stats.var_9828b4fd72cadf5e.size / 2 ) );
    
    if ( stats.var_9828b4fd72cadf5e.size % 2 != 0 )
    {
        stats.var_f14c41a9e27f048d = stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 ];
    }
    else
    {
        var_4f7cc90ae3a68c0 = stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 ] + stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 - 1 ];
        stats.var_f14c41a9e27f048d = var_4f7cc90ae3a68c0 / 2;
    }
    
    return stats;
}

// Namespace br_publicevent_bountyroyale
// Params 1
// Checksum 0x3fa9471c, Offset: 0x3a3a
// Size: 0x164
function function_988dc73bb8f948ea( stats )
{
    logstring( "-----------------------------------------------------" );
    logstring( "Public Event Bounty Royale - Clustering Statistics :" );
    logstring( "-----------------------------------------------------" );
    logstring( "Isolated Squads Remaining: " + stats.var_c977fb4fd957cbe9 );
    logstring( "Isolated Squads Merged with nearby Clusters: " + stats.var_4dc2769dfe116232 );
    logstring( "---------------------" );
    arraystr = "[ ";
    index = 0;
    
    foreach ( size in stats.var_9828b4fd72cadf5e )
    {
        arraystr += size;
        
        if ( index == stats.var_9828b4fd72cadf5e.size - 1 )
        {
            arraystr += " ]";
        }
        else
        {
            arraystr += ", ";
        }
        
        index++;
    }
    
    logstring( "Cluster sizes: " + arraystr );
    logstring( "Median  Cluster Size: " + stats.var_f14c41a9e27f048d );
    logstring( "Average Cluster Size: " + stats.averagesize );
    logstring( "-----------------------------------------------------" );
}

/#

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0xbec3f68a, Offset: 0x3ba6
    // Size: 0x5, Type: dev
    function function_b967f2f55dce6301()
    {
        
    }

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0x47820769, Offset: 0x3bb3
    // Size: 0x18e, Type: dev
    function function_3666f879fc7589bb()
    {
        availableteams = function_d5141fc12e321361();
        
        if ( availableteams.size <= 1 )
        {
            return;
        }
        
        var_9310aab6c14830d = function_1c482a1287b16a53( availableteams );
        logstring( "<dev string:x107>" );
        function_24fe7227ec5a2165( var_9310aab6c14830d );
        var_b744bc1e119447fe = [];
        level.var_179b6c3280c0c8f8 = [];
        
        foreach ( team in availableteams )
        {
            hunterplayers = teams::getteamdata( team, "<dev string:x13e>" );
            mainplayer = utility::array_random( hunterplayers );
            targetteam = br_assassination_quest::determinetargetteam( mainplayer, 0 );
            
            if ( isdefined( targetteam ) )
            {
                var_fc943dae65c4d7c2 = teams::getteamdata( targetteam, "<dev string:x146>" );
                targetplayer = utility::array_random( var_fc943dae65c4d7c2 );
                var_b744bc1e119447fe[ team ] = targetplayer;
                level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( targetteam, "<dev string:x13e>" ) );
            }
        }
        
        logstring( "<dev string:x153>" );
        function_24fe7227ec5a2165( var_b744bc1e119447fe );
        logstring( "<dev string:x18a>" );
        var_e5eb2decf2eb06e8 = function_a13e3f055fc15f6f( availableteams );
        function_24fe7227ec5a2165( var_e5eb2decf2eb06e8 );
    }

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0x75324d4a, Offset: 0x3d49
    // Size: 0x13f, Type: dev
    function warpteams()
    {
        level notify( #"bounty_redraw" );
        availableteams = function_d5141fc12e321361();
        
        if ( availableteams.size <= 1 )
        {
            return;
        }
        
        interval = 3;
        arraystr = "<dev string:x1c1>";
        iprintln( availableteams.size + "<dev string:x1c4>" );
        
        foreach ( index, team in availableteams )
        {
            targetorigin = function_5dba5c1d035af115( level.player );
            
            if ( !isdefined( targetorigin ) )
            {
                continue;
            }
            
            function_1ae3fc069efe719c( team, targetorigin );
            arraystr += targetorigin;
            iprintln( "<dev string:x1d8>" + index + "<dev string:x1df>" );
            
            if ( index == availableteams.size - 1 )
            {
                arraystr += "<dev string:x1e8>";
                iprintln( "<dev string:x1ea>" );
                continue;
            }
            
            arraystr += "<dev string:x1f8>";
            wait interval;
        }
        
        logstring( "<dev string:x1fb>" + arraystr );
    }

    // Namespace br_publicevent_bountyroyale
    // Params 1
    // Checksum 0x6b4668f6, Offset: 0x3e90
    // Size: 0x73, Type: dev
    function function_5dba5c1d035af115( player )
    {
        start = player geteye();
        dir = anglestoforward( player getplayerangles() );
        end = start + 10000 * dir;
        trace = trace::_bullet_trace( start, end, 1, player );
        
        if ( isdefined( trace[ "<dev string:x223>" ] ) )
        {
            return trace[ "<dev string:x223>" ];
        }
        
        return;
    }

    // Namespace br_publicevent_bountyroyale
    // Params 2
    // Checksum 0x50eec429, Offset: 0x3f0b
    // Size: 0xbd, Type: dev
    function function_1ae3fc069efe719c( team, position )
    {
        players = teams::getteamdata( team, "<dev string:x146>" );
        
        foreach ( player in players )
        {
            if ( player == level.player )
            {
                continue;
            }
            
            player setorigin( position, 1 );
        }
        
        thread function_c82275f556df96a9( position );
    }

    // Namespace br_publicevent_bountyroyale
    // Params 1
    // Checksum 0x20bc250d, Offset: 0x3fd0
    // Size: 0x308, Type: dev
    function function_41dd6ebdc8a8c60e( label )
    {
        positionpreset = undefined;
        
        switch ( label )
        {
            case #"hash_e9493e5d95d774aa":
                positionpreset = [ ( -1052.69, 10020, 651.875 ), ( -3539.9, 4300.11, 605.372 ), ( 727.52, 1998.89, 1199.66 ), ( 2277.98, 6429.02, 448.039 ), ( 552.215, 8078.68, 837.956 ) ];
                break;
            case #"hash_293711302205da35":
                positionpreset = [ ( -159.593, 75.772, 1760 ), ( -2201.92, -355.116, 1125.83 ), ( -3498.79, -5067.24, 667.843 ), ( -1609.7, -6951.33, 712.645 ), ( 247.739, -3322.97, 1710 ), ( 2033.68, -6202.4, 699.789 ), ( -1820.81, -11595.6, 178.062 ), ( 3312.2, -3250.82, 1071.72 ) ];
                break;
            case #"hash_38aa36fd797a4eac":
            default:
                positionpreset = [ ( 836.468, -5859.08, 693.534 ), ( -225.287, -8624.61, 300 ), ( -1370.39, -7809.29, 400 ), ( 2985.37, -6358.27, 955.228 ), ( 2373.81, -4321.44, 711.252 ), ( -473.395, -3156.1, 1256.47 ), ( -2716.84, -5003.01, 690.154 ), ( 161.867, 7979.81, 839.459 ), ( -1599.72, 7205.77, 879.5 ), ( -1398.86, 9328.75, 1155.79 ), ( 1445.23, 6487.11, 579.167 ), ( -2599.62, 5931.11, 879.5 ), ( -4654.95, 545.391, 716.307 ), ( 2675.77, 856.257, 784 ), ( 2636.01, 1981.71, 485.667 ), ( 4174.29, -79.9519, 223.119 ) ];
                break;
        }
        
        if ( !isdefined( positionpreset ) )
        {
            return;
        }
        
        positionindex = 0;
        
        foreach ( team in level.teamnamelist )
        {
            if ( function_67888fe593cd2fb8( team ) )
            {
                continue;
            }
            
            position = positionpreset[ positionindex ];
            function_1ae3fc069efe719c( team, position );
            positionindex++;
            
            if ( positionindex >= positionpreset.size )
            {
                return;
            }
        }
    }

    // Namespace br_publicevent_bountyroyale
    // Params 1
    // Checksum 0x99dadeb0, Offset: 0x42e0
    // Size: 0xca, Type: dev
    function function_c82275f556df96a9( position )
    {
        if ( getdvarint( @"hash_abd886dfdd042260", 0 ) == 0 )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"bounty_redraw" );
        radius = level.var_fdca07a6f0bda1df.clusterradius;
        height = ( 0, 0, 2 );
        yellow = ( 1, 1, 0 );
        red = ( 1, 0, 0 );
        
        while ( true )
        {
            waitframe();
            cylinder( position - height, position + height, radius, yellow, 1, 1 );
            sphere( position, 50, red, 0, 1 );
        }
    }

    // Namespace br_publicevent_bountyroyale
    // Params 3
    // Checksum 0x8f99e38c, Offset: 0x43b2
    // Size: 0x238, Type: dev
    function drawclusters( clusters, squadcenters, var_7d5faccbec298845 )
    {
        if ( getdvarint( @"hash_abd886dfdd042260", 0 ) == 0 )
        {
            return;
        }
        
        if ( var_7d5faccbec298845 )
        {
            level notify( #"bounty_redraw" );
        }
        
        level endon( #"game_ended" );
        level endon( #"bounty_redraw" );
        radius = level.var_fdca07a6f0bda1df.clusterradius;
        height = ( 0, 0, 1 );
        orange = ( 1, 0.7, 0 );
        red = ( 1, 0, 0 );
        cyan = ( 0, 1, 1 );
        
        while ( true )
        {
            foreach ( cluster in clusters )
            {
                position = cluster.centroid;
                
                if ( cluster.teams.size == 1 )
                {
                    sphere( position, 100, cyan, 0, 1 );
                    continue;
                }
                else
                {
                    sphere( position, 100, orange, 0, 1 );
                    cylinder( position, position + height, radius, orange, 0, 1 );
                }
                
                foreach ( team in cluster.teams )
                {
                    var_a90a9ca8d29d1331 = squadcenters[ team ];
                    sphere( var_a90a9ca8d29d1331, 50, red, 0, 1 );
                    line( position, var_a90a9ca8d29d1331, red );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0x18c1b4f1, Offset: 0x45f2
    // Size: 0x41, Type: dev
    function debuginit()
    {
        devgui::function_9082edeb5db93280( "<dev string:x263>" );
        devgui::add_devgui_func( "<dev string:x275>", "<dev string:x283>", &function_ee26af2affee3809 );
        devgui::function_77df7fe7dd273e10();
        br_dev::registerhandlecommand( &handledevcommand_bountyroyale );
        thread function_4d22c6563de8e95b();
    }

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0x264ed9dc, Offset: 0x463b
    // Size: 0xde, Type: dev
    function function_4d22c6563de8e95b()
    {
        if ( getdvarint( @"hash_7e63edb898a7cdc6", 0 ) == 0 )
        {
            return;
        }
        
        var_c34e72f078f863 = 2000;
        drawmin = -20000;
        drawmax = 20000;
        
        while ( true )
        {
            for ( i = -4; i < 5 ; i++ )
            {
                factor = level.var_fdca07a6f0bda1df.clusterradius * 2 * i;
                begin = ( factor, drawmin, var_c34e72f078f863 );
                end = ( factor, drawmax, var_c34e72f078f863 );
                line( begin, end, ( 0, 1, 0 ) );
                begin = ( drawmin, factor, var_c34e72f078f863 );
                end = ( drawmax, factor, var_c34e72f078f863 );
                line( begin, end, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace br_publicevent_bountyroyale
    // Params 0
    // Checksum 0xe9e9c7c, Offset: 0x4721
    // Size: 0x26, Type: dev
    function function_ee26af2affee3809()
    {
        br_publicevents::function_a1af4e372c2ecc3( %"bountyroyale" );
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"bountyroyale" );
    }

    // Namespace br_publicevent_bountyroyale
    // Params 1
    // Checksum 0x4ec2c18e, Offset: 0x474f
    // Size: 0x69, Type: dev
    function function_eee5115e2f03cd2c( bit )
    {
        level notify( #"bounty_bit" );
        level endon( #"game_ended" );
        level endon( #"bounty_bit" );
        team = level.player.team;
        function_69639a51e4bc2a16( team, bit );
        wait 3;
        function_69639a51e4bc2a16( team, 0 );
    }

    // Namespace br_publicevent_bountyroyale
    // Params 1
    // Checksum 0x1512606a, Offset: 0x47c0
    // Size: 0xc3, Type: dev
    function function_707e202a3bcff02f( team )
    {
        foreach ( player in teams::getteamdata( team, "<dev string:x13e>" ) )
        {
            if ( player br_public::isplayerinorgoingtogulag() || !player::isreallyalive( player ) )
            {
                continue;
            }
            
            victimname = br_dev::function_bb6b1b28c82cf8ac( player.name );
            br_dev::devkillplayer( victimname, undefined );
        }
    }

    // Namespace br_publicevent_bountyroyale
    // Params 2, eflags: 0x4
    // Checksum 0x1e85f221, Offset: 0x488b
    // Size: 0x209, Type: dev
    function private handledevcommand_bountyroyale( command, args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        if ( command != "<dev string:x29c>" )
        {
            return;
        }
        
        command = args[ 0 ];
        
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        switch ( command )
        {
            case #"hash_9710f96c58beeaaa":
                function_ee26af2affee3809();
                break;
            case #"hash_94d1828f12087b7b":
                br_publicevents::function_a1af4e372c2ecc3( %"bountyroyale" );
                function_2c351b3426cd21fe();
                break;
            case #"hash_bdb14d744104f90f":
                thread warpteams();
                break;
            case #"hash_9c2be183fd2f9f7e":
                label = "<dev string:x2ba>";
                
                if ( isdefined( args[ 1 ] ) )
                {
                    label = args[ 1 ];
                }
                
                function_41dd6ebdc8a8c60e( label );
                break;
            case #"hash_851b0b40030f9694":
                function_3666f879fc7589bb();
                break;
            case #"hash_213e6f6c1b36e710":
                bit = 0;
                
                if ( isdefined( args[ 1 ] ) )
                {
                    bit = int( args[ 1 ] );
                }
                
                thread function_eee5115e2f03cd2c( bit );
                break;
            case #"hash_5bb99c2d99b504f6":
                targetteam = level.player.team;
                var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ targetteam ];
                hunterteams = var_57ee2d1096b1e3de.var_6ff8379e9568d24f;
                
                foreach ( team in hunterteams )
                {
                    if ( !isdefined( team ) )
                    {
                        continue;
                    }
                    
                    function_707e202a3bcff02f( team );
                }
                
                break;
            default:
                break;
        }
    }

#/
