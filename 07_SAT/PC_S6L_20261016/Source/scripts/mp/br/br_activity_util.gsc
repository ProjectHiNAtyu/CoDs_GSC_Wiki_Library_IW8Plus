// scripts\mp\br\br_activity_util.gsc  (hash_53d999e26576a580.gscc) (size: 19531 Bytes / 0x4c4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd2814b5 (3710391477)
// size ...... 19531 (0x4c4b)
// includes .. 22  (offset: 0x492b)
// strings ... 36  (offset: 0x49db)
// dev strs .. 9   (offset: 0x4bdf)
// exports ... 58  (offset: 0x320b)
// cseg ...... 0x367 + 0x2ea4 (0x320b)
// imports ... 113 (offset: 0x3b1b)
// animtree1 . 0   (offset: 0x4c4b)
// animtree2 . 0   (offset: 0x4c4b)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\talking_gun;

#namespace br_activity_util;

// Namespace br_activity_util
// Params 1
// Checksum 0x5d28f157, Offset: 0x385
// Size: 0x92
function function_4e9e312232df58ab( ref )
{
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player function_e8ab3983ca03f37b( ref );
    }
}

// Namespace br_activity_util
// Params 0
// Checksum 0x5d28f137, Offset: 0x41f
// Size: 0x87
function function_eb1ba17bd8151ce6()
{
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player function_9f77cccca136d836();
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0xa91100cf, Offset: 0x4ae
// Size: 0x4e
function function_e8ab3983ca03f37b( ref )
{
    assert( isplayer( self ) );
    index = level.activitymanager.var_cbd7f4e8feb34f18[ ref ];
    
    if ( isdefined( index ) )
    {
        self setclientomnvar( "ui_br_objective_index", index );
    }
}

// Namespace br_activity_util
// Params 0
// Checksum 0xbfe0f27d, Offset: 0x504
// Size: 0x1b
function function_9f77cccca136d836()
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_index", 0 );
}

// Namespace br_activity_util
// Params 2
// Checksum 0x7a37604d, Offset: 0x527
// Size: 0x9c
function function_951f899c3ca23364( value, value2 )
{
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player function_525a0dd5ce55a274( value, value2 );
    }
}

// Namespace br_activity_util
// Params 2
// Checksum 0xa988449f, Offset: 0x5cb
// Size: 0x52
function function_525a0dd5ce55a274( value, value2 )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_param", value );
    
    if ( isdefined( value2 ) )
    {
        assert( isdefined( value ), "<dev string:x24>" );
        self setclientomnvar( "ui_br_objective_extraParam", value2 );
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0x86ab79e3, Offset: 0x625
// Size: 0xa9
function function_87a015bf03f9d1f6( objectiveidnum )
{
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        if ( !filtercondition_isdead( player ) && !filtercondition_ingulag( player ) )
        {
            objective_addclienttomask( objectiveidnum, player );
        }
    }
}

// Namespace br_activity_util
// Params 3
// Checksum 0xf4c9f3f0, Offset: 0x6d6
// Size: 0x50
function function_2a1bc1efcfd981da( splash_key, params, splashlistoverride )
{
    assert( isdefined( splash_key ), "<dev string:x66>" );
    players = self.playerparticipants;
    displaysplashtoplayers( players, splash_key, params, splashlistoverride );
}

// Namespace br_activity_util
// Params 4
// Checksum 0xc5b9e63d, Offset: 0x72e
// Size: 0x101
function displaysplashtoplayers( players, splash_key, params, splashlistoverride )
{
    assert( isdefined( splash_key ), "<dev string:xa1>" );
    
    if ( isdefined( level.br_ending ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( filtercondition_ingulag( player ) )
        {
            continue;
        }
        
        if ( isdefined( params ) )
        {
            if ( isdefined( params.excludedplayers ) )
            {
                if ( arraycontains( params.excludedplayers, player ) )
                {
                    continue;
                }
            }
        }
        
        displayplayersplash( player, splash_key, params, splashlistoverride );
    }
}

// Namespace br_activity_util
// Params 4
// Checksum 0x67d85bb2, Offset: 0x837
// Size: 0xe9
function displayplayersplash( player, splash_key, params, splashlistoverride )
{
    assert( isdefined( splash_key ), "<dev string:xd3>" + player.name );
    
    if ( isdefined( params ) && isdefined( params.packedbits ) )
    {
        player thread hud_message::showsplash( splash_key, params.packedbits, undefined, undefined, undefined, splashlistoverride );
        return;
    }
    
    if ( isdefined( params ) && isdefined( params.intvar ) )
    {
        player thread hud_message::showsplash( splash_key, params.intvar, undefined, undefined, undefined, splashlistoverride );
        return;
    }
    
    if ( isdefined( params ) && isdefined( params.playerforplayercard ) )
    {
        player thread hud_message::showsplash( splash_key, undefined, params.playerforplayercard, undefined, undefined, splashlistoverride );
        return;
    }
    
    player thread hud_message::showsplash( splash_key, undefined, undefined, undefined, undefined, splashlistoverride );
}

// Namespace br_activity_util
// Params 3
// Checksum 0xeb51d6cb, Offset: 0x928
// Size: 0xdf
function function_479a733299fbbd24( state, missionref, player_ref = self.var_ca369031b554da2f )
{
    players = self.playerparticipants;
    var_39520877e3384490 = level.activitymanager.var_cbd7f4e8feb34f18[ missionref ];
    
    if ( !isdefined( var_39520877e3384490 ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        player function_6c425c5fbea68743( player_ref, state, var_39520877e3384490 );
    }
}

// Namespace br_activity_util
// Params 3, eflags: 0x4
// Checksum 0x338e4046, Offset: 0xa0f
// Size: 0x70
function private function_6c425c5fbea68743( player_ref, state, var_39520877e3384490 )
{
    player = player_ref getentitynumber();
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( player ) )
    {
        player = 0;
    }
    
    if ( !isdefined( var_39520877e3384490 ) )
    {
        var_39520877e3384490 = 0;
    }
    
    value = 0;
    value = var_39520877e3384490 << 12 | player << 4 | state;
    self setclientomnvar( "ui_br_expanded_obit_message", value );
}

// Namespace br_activity_util
// Params 2
// Checksum 0xd5674213, Offset: 0xa87
// Size: 0x78
function function_f255dbc3d969ce02( var_6178022a28917e8, timer_type )
{
    level endon( #"game_ended" );
    eventduration = var_6178022a28917e8;
    self.eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer_type", timer_type );
    setomnvar( "ui_publicevent_timer", self.eventendtime );
    setomnvar( "ui_minimap_pulse", 1 );
    wait var_6178022a28917e8;
    function_f24cad5d113f4f52();
}

// Namespace br_activity_util
// Params 0
// Checksum 0x3fa5704a, Offset: 0xb07
// Size: 0x18
function function_f24cad5d113f4f52()
{
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_activity_util
// Params 2
// Checksum 0x6baaffad, Offset: 0xb27
// Size: 0xf3
function function_3fbbc67df36be7bb( time, animbuffer = 0 )
{
    self.totaltime = time + animbuffer;
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_objective_duration_time", self.totaltime * 1000 );
    }
    
    self.missionstarttime = gettime();
    self.missiontime = self.missionstarttime + self.totaltime * 1000;
    function_a21d0af31443edfc();
}

// Namespace br_activity_util
// Params 1
// Checksum 0xfc67774c, Offset: 0xc22
// Size: 0xfb
function function_3a67c27d33cb206c( time )
{
    self.missiontime += time * 1000;
    currenttime = gettime();
    elapsed = currenttime - self.missionstarttime;
    newtime = self.totaltime * 1000 - elapsed + time * 1000;
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_objective_duration_time", newtime );
    }
    
    function_a21d0af31443edfc();
}

// Namespace br_activity_util
// Params 1
// Checksum 0x3f3a9cb8, Offset: 0xd25
// Size: 0x70
function function_cf8dc263065eabc9( time )
{
    if ( self.missiontime - gettime() <= 1000 )
    {
        return;
    }
    
    if ( self.missiontime - gettime() - time * 1000 <= 0 )
    {
        self.missiontime = gettime() + 1000;
    }
    else
    {
        self.missiontime -= time * 1000;
    }
    
    function_a21d0af31443edfc();
}

// Namespace br_activity_util
// Params 0
// Checksum 0xf222288b, Offset: 0xd9d
// Size: 0x9a
function function_a21d0af31443edfc()
{
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
    
    thread function_ba413f6e6e9fa43f();
}

// Namespace br_activity_util
// Params 0, eflags: 0x4
// Checksum 0xb6e3facc, Offset: 0xe3f
// Size: 0x9f
function private function_ba413f6e6e9fa43f()
{
    self notify( #"hash_712bc7b5bc2fdeb7" );
    self endon( #"game_ended" );
    self endon( #"hash_712bc7b5bc2fdeb7" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    waittime = ( self.missiontime - gettime() ) / 1000;
    
    if ( waittime < 0 )
    {
        self.missiontime = gettime() + 1000;
        waittime = ( self.missiontime - gettime() ) / 1000;
    }
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    announcemoment( self, "BRTimerExpired" );
}

// Namespace br_activity_util
// Params 1
// Checksum 0xd41fa19b, Offset: 0xee6
// Size: 0xb9
function showtablet( tablet )
{
    if ( !( isdefined( tablet ) && isdefined( tablet.type ) ) )
    {
        return;
    }
    
    tablet setscriptablepartstate( tablet.type, "visible" );
    level.activitymanager.visibletablets[ level.activitymanager.visibletablets.size ] = tablet;
    tablet function_b33edaa05b154b90( 1 );
    ref = tablet.associatedactivityinstance.varianttag;
    level callback::callback( #"on_contract_shown", { #ref:ref, #tablet:tablet } );
}

// Namespace br_activity_util
// Params 1
// Checksum 0x4fafb736, Offset: 0xfa7
// Size: 0xb9
function hidetablet( tablet )
{
    if ( !( isdefined( tablet ) && isdefined( tablet.type ) ) )
    {
        return;
    }
    
    level.activitymanager.visibletablets = arrayremove( level.activitymanager.visibletablets, tablet );
    tablet function_b33edaa05b154b90( 0 );
    tablet notify( #"onTabletHidden" );
    ref = tablet.associatedactivityinstance.varianttag;
    level callback::callback( #"on_contract_hidden", { #ref:ref, #tablet:tablet } );
    pickups::loothide( tablet );
}

// Namespace br_activity_util
// Params 1
// Checksum 0xd975e19e, Offset: 0x1068
// Size: 0x52
function function_b33edaa05b154b90( var_30a628ba295efa7c )
{
    activityinstance = self.var_edc89ff04fe6a343.activityinstance;
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        return;
    }
    
    if ( var_30a628ba295efa7c )
    {
        activity_common::function_d630366b03a83c40( activityinstance );
        return;
    }
    
    activity_common::function_15af4039c83423a6( activityinstance );
}

// Namespace br_activity_util
// Params 3
// Checksum 0x952a7205, Offset: 0x10c2
// Size: 0xf6
function function_68f2ccbc07be54d( dist, var_e33007e788481556 = level.activitymanager.visibletablets, activitytype )
{
    if ( !isarray( var_e33007e788481556 ) )
    {
        return;
    }
    
    var_e33007e788481556 = sortbydistancecullbyradius( var_e33007e788481556, self.origin, dist );
    
    foreach ( tablet in var_e33007e788481556 )
    {
        if ( tablet == self )
        {
            continue;
        }
        
        if ( activitytype && activitytype != activity_instance_common::getactivitytype( tablet.var_edc89ff04fe6a343.activityinstance ) )
        {
            continue;
        }
        
        return tablet;
    }
}

// Namespace br_activity_util
// Params 3
// Checksum 0xf7d46693, Offset: 0x11c1
// Size: 0x11f
function function_62fbf778fbab9c2b( dist2d, var_e33007e788481556, activitytype )
{
    if ( !isdefined( dist2d ) || dist2d <= 0 )
    {
        return;
    }
    
    if ( !isdefined( var_e33007e788481556 ) )
    {
        var_e33007e788481556 = level.activitymanager.visibletablets;
    }
    
    if ( !isarray( var_e33007e788481556 ) )
    {
        return;
    }
    
    dist2dsquared = dist2d * dist2d;
    
    foreach ( tablet in var_e33007e788481556 )
    {
        if ( tablet == self )
        {
            continue;
        }
        
        if ( activitytype && activitytype != activity_instance_common::getactivitytype( tablet.var_edc89ff04fe6a343.activityinstance ) )
        {
            continue;
        }
        
        if ( distance2dsquared( self.origin, tablet.origin ) <= dist2dsquared )
        {
            return tablet;
        }
    }
}

// Namespace br_activity_util
// Params 2
// Checksum 0x18b7410e, Offset: 0x12e9
// Size: 0x2d, Type: bool
function isneartablet( dist, var_e33007e788481556 )
{
    nearbytablet = function_68f2ccbc07be54d( dist, var_e33007e788481556 );
    return isdefined( nearbytablet );
}

// Namespace br_activity_util
// Params 1
// Checksum 0x4a4051fa, Offset: 0x131f
// Size: 0x36, Type: bool
function function_34071c53dfc789e6( dist )
{
    nearbytablet = function_68f2ccbc07be54d( dist, level.activitymanager.activetablets );
    return isdefined( nearbytablet );
}

// Namespace br_activity_util
// Params 2
// Checksum 0xcfd8199, Offset: 0x135e
// Size: 0x8f
function function_ca55fe718632b570( type, nocircle )
{
    if ( nocircle )
    {
        if ( type.mincircle <= 0 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    if ( level.br_circle.circleindex < type.mincircle )
    {
        return 0;
    }
    
    if ( level.br_circle.circleindex > type.maxcircle && type.maxcircle != -1 )
    {
        return -1;
    }
    
    return 1;
}

// Namespace br_activity_util
// Params 1
// Checksum 0xd8446467, Offset: 0x13f6
// Size: 0x40
function function_dc401ee9c856c395( type )
{
    if ( level.br_circle.circleindex == type.mincircle )
    {
        return type.var_9b0f065779b5af30;
    }
    
    return -1;
}

// Namespace br_activity_util
// Params 2
// Checksum 0xef73eac0, Offset: 0x143e
// Size: 0xf8, Type: bool
function function_79f1eba39959ffed( activity, filter )
{
    if ( !isdefined( level.activitymanager.defaultfilter ) )
    {
        level.activitymanager.defaultfilter = [ &filtercondition_isdead, &filtercondition_ingulag ];
    }
    
    if ( !isdefined( filter ) )
    {
        filter = level.activitymanager.defaultfilter;
    }
    
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        if ( _validateplayer( player, filter ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_activity_util
// Params 2, eflags: 0x4
// Checksum 0xac4b683, Offset: 0x153f
// Size: 0x8a, Type: bool
function private _validateplayer( player, filter )
{
    foreach ( condition in filter )
    {
        if ( [[ condition ]]( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_activity_util
// Params 1
// Checksum 0x82528778, Offset: 0x15d2
// Size: 0x14, Type: bool
function filtercondition_isdead( player )
{
    return br_public::isplayerdead( player );
}

// Namespace br_activity_util
// Params 1
// Checksum 0x4aa3c182, Offset: 0x15ef
// Size: 0x14
function filtercondition_iseliminated( player )
{
    return br_public::function_5a91d8c6c620f983( player );
}

// Namespace br_activity_util
// Params 1
// Checksum 0x74bfcd01, Offset: 0x160c
// Size: 0x35, Type: bool
function filtercondition_ingulag( player )
{
    return player.jailed || player.gulagarena || player.gulag;
}

// Namespace br_activity_util
// Params 1
// Checksum 0x876d0761, Offset: 0x164a
// Size: 0x4f
function function_d0dded8c467ac5dd( params )
{
    if ( self.state != "Active" )
    {
        return;
    }
    
    player_list = activity_instance_common::function_4225efca86f0dea9( self );
    
    if ( player_list.size == 0 || !function_79f1eba39959ffed( self ) )
    {
        activity_instance_common::endactivity( self, 0 );
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0x225ec3c2, Offset: 0x16a1
// Size: 0x2c5
function startcontract( params )
{
    team = self.team;
    idx = self.squadindex ?? team;
    callback::callback( #"on_contract_start", { #index:idx, #task:self } );
    numteamplayers = 0;
    islegendarycontract = istrue( self.islegendarycontract );
    self.var_c79d572823fbd9a9 = function_95b5e800a753f909();
    activityindex = level.activitymanager.var_60a8822c8b45732e[ self.varianttag ];
    players = activity_instance_common::function_4225efca86f0dea9( self );
    
    foreach ( friendlyplayer in players )
    {
        if ( !self.skipanalytics )
        {
            challenges::function_7bc79aeb658f2606( friendlyplayer, activityindex, self.var_ca369031b554da2f );
        }
        
        talking_gun::talkinggun_event( friendlyplayer, #"contract_start" );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"setactivecontractstatusomnvar" ) )
    {
        utility::callsharedfunc( #"gametype", #"setactivecontractstatusomnvar", team );
    }
    
    instanceholder = spawnstruct();
    instanceholder.type = spawnstruct();
    instanceholder.type.ref = self.varianttag;
    instanceholder.tablet = self.tablet;
    
    if ( isdefined( self.tablet ) )
    {
        instanceholder.missionid = string( self.tablet.index );
        instanceholder.distance = params.distance;
        br_analytics::branalytics_missionstart( instanceholder, self.var_ca369031b554da2f );
        return;
    }
    
    if ( isdefined( self.traincar ) )
    {
        if ( !isdefined( level.var_86ddf2b3dd523151 ) )
        {
            level.var_86ddf2b3dd523151 = 0;
        }
        
        self.trainindex = level.var_86ddf2b3dd523151;
        level.var_86ddf2b3dd523151++;
        instanceholder.missionid = "train_recon_" + self.trainindex;
        instanceholder.distance = params.distance;
        br_analytics::branalytics_missionstart( instanceholder, self.var_ca369031b554da2f );
    }
}

// Namespace br_activity_util
// Params 7
// Checksum 0x4fc4d547, Offset: 0x196e
// Size: 0x749
function endcontract( success, rewards, endstate, var_7dcfa778765f05d1, var_8b55d0911674b2ba, var_40b965a332bf5634, var_13624218cd8b0cb6 )
{
    team = self.team;
    idx = self.squadindex ?? team;
    callback::callback( #"on_contract_end", { #success:istrue( success ), #index:idx, #task:self } );
    numteamplayers = 0;
    islegendarycontract = istrue( self.islegendarycontract );
    
    if ( utility::issharedfuncdefined( #"gametype", #"setactivecontractstatusomnvar" ) )
    {
        utility::callsharedfunc( #"gametype", #"setactivecontractstatusomnvar", team );
    }
    
    players = activity_instance_common::function_4225efca86f0dea9( self );
    activityindex = level.activitymanager.var_60a8822c8b45732e[ self.varianttag ];
    
    if ( success )
    {
        numteamplayers = players.size;
        
        foreach ( player in players )
        {
            player setclientomnvar( "ui_br_objective_duration_time", 0 );
            
            if ( !isdefined( player.brmissionscompleted ) )
            {
                player.brmissionscompleted = 0;
            }
            
            player.brmissionscompleted++;
            
            if ( level.var_4d2ffb649fcef6ea )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "objectivesCompleted" ] ) )
                    {
                        player.leaderboarddata[ "objectivesCompleted" ] = player.leaderboarddata[ "objectivesCompleted" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objectivesCompleted" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objectivesCompleted" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x10a>" );
                    
                    if ( isdefined( player.pers[ "objectivesCompleted" ] ) )
                    {
                        player.pers[ "objectivesCompleted" ] = player.pers[ "objectivesCompleted" ] + 1;
                    }
                }
                
                player br_public::updatebrscoreboardstat( "missionsCompleted", player.pers[ "objectivesCompleted" ] );
            }
            else
            {
                player br_public::updatebrscoreboardstat( "missionsCompleted", player.brmissionscompleted );
            }
            
            if ( !isdefined( player.var_1cb9bb9f1476cdd4 ) )
            {
                player.var_1cb9bb9f1476cdd4 = [];
            }
            
            if ( !arraycontains( player.var_1cb9bb9f1476cdd4, self.varianttag ) )
            {
                player.var_1cb9bb9f1476cdd4[ player.var_1cb9bb9f1476cdd4.size ] = self.varianttag;
            }
            
            challenges::function_84e8396c49d7b89d( player, activityindex, 1, 1, self.startingpoi, self.varianttag, undefined, islegendarycontract, self.var_c79d572823fbd9a9 );
        }
        
        if ( !isdefined( level.activitymanager.var_eadfe43e300095f8[ idx ] ) )
        {
            level.activitymanager.var_eadfe43e300095f8[ idx ] = 0;
        }
        
        level.activitymanager.var_eadfe43e300095f8[ idx ]++;
        
        if ( self.var_332f929de1894b2b.var_4659f1b281908048.var_e86b89671e4fd9a7 && !self.poached )
        {
            if ( !isdefined( var_40b965a332bf5634 ) )
            {
                var_40b965a332bf5634 = function_396e4d818e829921( self.var_ca369031b554da2f );
            }
            
            if ( !isdefined( var_13624218cd8b0cb6 ) )
            {
                var_13624218cd8b0cb6 = ( 0, 0, 0 );
            }
            
            info = spawnstruct();
            info.origin = var_40b965a332bf5634;
            info.angles = var_13624218cd8b0cb6;
            info.activity = self;
            info.crateinfo = self.var_332f929de1894b2b.var_4659f1b281908048;
            function_68426c67d3320967( self.var_ca369031b554da2f, info );
        }
        
        if ( utility::issharedfuncdefined( #"gametype", #"givecontractadditionalrewards" ) )
        {
            utility::callsharedfunc( #"gametype", #"givecontractadditionalrewards", team, self );
        }
        
        callback::callback( #"on_contract_completed", { #contract:self, #players:players } );
    }
    else
    {
        foreach ( player in players )
        {
            player setclientomnvar( "ui_br_objective_duration_time", 0 );
            challenges::function_84e8396c49d7b89d( player, activityindex, 0, 1, undefined, self.varianttag, undefined, islegendarycontract, self.var_c79d572823fbd9a9 );
        }
        
        if ( isdefined( var_7dcfa778765f05d1 ) )
        {
            var_44eabfaaeeccd596 = isdefined( var_8b55d0911674b2ba ) ? teams::getsquadmates( var_7dcfa778765f05d1, var_8b55d0911674b2ba ) : teams::getteamdata( var_7dcfa778765f05d1, "players" );
            
            foreach ( var_1cf12352269e9a61 in var_44eabfaaeeccd596 )
            {
                challenges::function_84e8396c49d7b89d( var_1cf12352269e9a61, activityindex, 1, 2, undefined, self.varianttag, undefined, islegendarycontract, self.var_c79d572823fbd9a9 );
            }
        }
    }
    
    instanceholder = spawnstruct();
    instanceholder.questcategory = self.varianttag;
    questtier = br_quest_util::getquestrewardtier( team );
    instanceholder.islegendarycontract = self.islegendarycontract;
    
    if ( success )
    {
        instanceholder.result = "success";
    }
    else
    {
        instanceholder.result = "failure";
    }
    
    if ( isdefined( self.tablet ) )
    {
        instanceholder.missionid = string( self.tablet.index );
        instanceholder.endstate = endstate;
        
        if ( !isdefined( rewards ) )
        {
            rewards = [];
        }
        
        br_analytics::branalytics_missionend( instanceholder, questtier, rewards, numteamplayers );
        return;
    }
    
    if ( isdefined( self.traincar ) )
    {
        instanceholder.missionid = "train_recon_" + self.trainindex;
        instanceholder.endstate = endstate;
        
        if ( !isdefined( rewards ) )
        {
            rewards = [];
        }
        
        br_analytics::branalytics_missionend( instanceholder, questtier, rewards, numteamplayers );
    }
}

// Namespace br_activity_util
// Params 0
// Checksum 0x52c6203f, Offset: 0x20bf
// Size: 0x3b, Type: bool
function function_95b5e800a753f909()
{
    if ( self.varianttag )
    {
        contractbundle = getscriptbundle( "contract:" + self.varianttag );
        return istrue( contractbundle.var_c79d572823fbd9a9 );
    }
    
    return false;
}

// Namespace br_activity_util
// Params 3
// Checksum 0x6d17ea38, Offset: 0x2103
// Size: 0xea
function function_333e692c891758bb( playerarray, statname, amount = 1 )
{
    if ( !playerarray )
    {
        return;
    }
    
    if ( isplayer( playerarray ) )
    {
        playerarray = [ playerarray ];
    }
    
    foreach ( player in playerarray )
    {
        if ( !isdefined( player.endmatchstats[ statname ] ) )
        {
            player.endmatchstats[ statname ] = 0;
        }
        
        player.endmatchstats[ statname ] += amount;
    }
}

// Namespace br_activity_util
// Params 3
// Checksum 0x5b61737d, Offset: 0x21f5
// Size: 0x4b
function function_381d1d8f56715c32( team, statname, amount = 1 )
{
    teamplayers = teams::getteamdata( team, "players" );
    function_333e692c891758bb( teamplayers, statname, amount );
}

// Namespace br_activity_util
// Params 1
// Checksum 0xce54206e, Offset: 0x2248
// Size: 0x39
function function_501ceea91ee698e7( attacker )
{
    if ( isplayer( attacker ) )
    {
        return attacker;
    }
    
    if ( isplayer( attacker.owner ) )
    {
        return attacker.owner;
    }
}

// Namespace br_activity_util
// Params 2
// Checksum 0x88814003, Offset: 0x228a
// Size: 0xa0
function function_73a69a713bac3359( activitymoment, relevantinfostruct )
{
    foreach ( activityinstance in level.activities.instances )
    {
        if ( isdefined( activityinstance ) )
        {
            announcemoment( activityinstance, activitymoment, relevantinfostruct );
        }
    }
}

// Namespace br_activity_util
// Params 2
// Checksum 0xd0c464df, Offset: 0x2332
// Size: 0xa0
function function_e6250fc87b2e5e72( activitymoment, relevantinfostruct )
{
    foreach ( activityinstance in level.activitymanager.var_cc0e4315eede2fec )
    {
        if ( isdefined( activityinstance ) )
        {
            announcemoment( activityinstance, activitymoment, relevantinfostruct );
        }
    }
}

// Namespace br_activity_util
// Params 3
// Checksum 0x58276d71, Offset: 0x23da
// Size: 0xdf
function function_59e94911ee8444c3( player, activitymoment, relevantinfostruct )
{
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, instanceinfostruct in var_ccc91d79bfa22c3a )
    {
        activityinstance = level.activities.instances[ instanceid ];
        
        if ( isdefined( activityinstance ) && activityinstance.state == "Active" )
        {
            announcemoment( activityinstance, activitymoment, relevantinfostruct );
        }
    }
}

// Namespace br_activity_util
// Params 3
// Checksum 0xa0949943, Offset: 0x24c1
// Size: 0x86
function announcemoment( activityinstance, activitymoment, relevantinfostruct = spawnstruct() )
{
    if ( !isdefined( relevantinfostruct.playerlist ) )
    {
        relevantinfostruct.playerlist = activityinstance.playerparticipants;
    }
    
    activitytype = activityinstance.type;
    activityinstance function_4f0e8ca0454dacd5( level.activities.types[ activitytype ], activitymoment, relevantinfostruct );
}

// Namespace br_activity_util
// Params 3, eflags: 0x4
// Checksum 0xc8ff40ce, Offset: 0x254f
// Size: 0xce
function private function_4f0e8ca0454dacd5( activitymomentcallbackcontainer, activitymoment, relevantinfostruct )
{
    var_3d3beb3c212d444d = isdefined( activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ] ) && activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ].size > 0;
    
    if ( var_3d3beb3c212d444d )
    {
        foreach ( callback in activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ] )
        {
            self thread [[ callback ]]( relevantinfostruct );
        }
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0x546d8d5c, Offset: 0x2625
// Size: 0x2f
function function_97dba697e6d63daf( activityscriptbundle )
{
    customproperties = activity_definition_utils::function_9129cd8075c85c09( getscriptbundle( activityscriptbundle ) );
    return customproperties.var_a850bc76b747aa84;
}

// Namespace br_activity_util
// Params 1
// Checksum 0x4e03f59c, Offset: 0x265d
// Size: 0xaa, Type: bool
function function_28ad214e28d6ee27( type )
{
    foreach ( activityinstance in level.activities.instances )
    {
        if ( activity_instance_common::getactivitytype( activityinstance ) == type && activity_instance_common::getactivitystate( activityinstance ) == "Active" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_activity_util
// Params 2
// Checksum 0x56cd3df2, Offset: 0x2710
// Size: 0x69
function activitylog( activity_instance, string )
{
    if ( !getdvarint( @"hash_7a0d79ddfa39c643", 1 ) )
    {
        return;
    }
    
    logstring( "[" + activity_instance_common::getactivitytype( activity_instance ) + "] [" + activity_instance.varianttag + ":" + activity_instance.id + "] " + string );
}

// Namespace br_activity_util
// Params 2
// Checksum 0x204fda71, Offset: 0x2781
// Size: 0x3f
function function_28cfe75da788438f( activity_type, string )
{
    if ( !getdvarint( @"hash_7a0d79ddfa39c643", 1 ) )
    {
        return;
    }
    
    logstring( "[" + activity_type + "] " + string );
}

// Namespace br_activity_util
// Params 2
// Checksum 0x235a24ab, Offset: 0x27c8
// Size: 0xf2
function function_3f7de03328463b48( activity_instance, agent )
{
    if ( !activity_instance.var_332f929de1894b2b.lootsettings )
    {
        return;
    }
    
    foreach ( setting in activity_instance.var_332f929de1894b2b.lootsettings )
    {
        if ( issubstr( agent.agent_type, setting.aitype ) )
        {
            return { #count:setting.count, #lootlist:setting.lootlist };
        }
    }
}

// Namespace br_activity_util
// Params 4
// Checksum 0xf2542d9d, Offset: 0x28c3
// Size: 0x70
function additemdrops( requestid, activity_instance, agent, spawndata )
{
    dropdata = function_3f7de03328463b48( activity_instance, agent );
    agent.var_50e1da833a37c346 = "itemspawnlist:" + dropdata.lootlist;
    agent.var_5e76e05112324d92 = dropdata.count;
}

// Namespace br_activity_util
// Params 3
// Checksum 0xdbae05a9, Offset: 0x293b
// Size: 0x303
function function_3b8688dc02095a80( origin, paramstruct, locnodes )
{
    assert( paramstruct.locmaxdist > 0, "<dev string:x130>" );
    assert( paramstruct.var_adc4e9b877bcfb5 >= 0, "<dev string:x152>" );
    assert( paramstruct.var_15799891fdae502f >= 0, "<dev string:x185>" );
    assert( paramstruct.var_540b35ff024488bc >= 0, "<dev string:x1b8>" );
    bestnode = undefined;
    var_17e3128928408199 = paramstruct.locmaxdist * paramstruct.locmaxdist;
    playerspeed = getdvarint( @"g_speed", 190 );
    var_8100588660eb2cf7 = paramstruct.locmaxdist * paramstruct.locmaxdist;
    var_6eaff8c4ae3ca876 = paramstruct.var_adc4e9b877bcfb5 * paramstruct.var_adc4e9b877bcfb5;
    var_286b7a76a475f794 = paramstruct.var_15799891fdae502f * paramstruct.var_15799891fdae502f;
    var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( origin );
    var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    
    foreach ( node in locnodes )
    {
        distsquared = distance2dsquared( node.origin, origin );
        
        if ( distsquared > var_8100588660eb2cf7 )
        {
            continue;
        }
        
        if ( node.activity_instance )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_e34b2a712c85d8c6 = 0;
            
            if ( !isdefined( node.circletimeline ) || !isdefined( node.var_b77210c587c94ed6 ) )
            {
                var_c8f52e077a73a45d = br_circle_util::function_472c93858e491e0a( node.origin );
                var_e34b2a712c85d8c6 = br_circle_util::function_b880c0f9998fdd69( var_c8f52e077a73a45d );
                node.circletimeline = var_c8f52e077a73a45d;
                node.var_b77210c587c94ed6 = var_e34b2a712c85d8c6;
            }
            else
            {
                var_c8f52e077a73a45d = node.circletimeline;
                var_e34b2a712c85d8c6 = node.var_b77210c587c94ed6;
            }
            
            if ( var_e34b2a712c85d8c6 < var_b5eefdf655fda772 )
            {
                continue;
            }
            
            traveltime = sqrt( distsquared / playerspeed * playerspeed );
            var_e34b2a712c85d8c6 -= traveltime;
            
            if ( var_e34b2a712c85d8c6 < paramstruct.var_540b35ff024488bc )
            {
                continue;
            }
        }
        
        var_6208485609110f3f = 0;
        
        if ( distsquared < var_286b7a76a475f794 )
        {
            var_6208485609110f3f = var_286b7a76a475f794 - distsquared;
        }
        else if ( distsquared > var_6eaff8c4ae3ca876 )
        {
            var_6208485609110f3f = distsquared - var_6eaff8c4ae3ca876;
        }
        
        if ( var_6208485609110f3f < var_17e3128928408199 )
        {
            var_17e3128928408199 = var_6208485609110f3f;
            bestnode = node;
            
            if ( var_6208485609110f3f <= 0 )
            {
                break;
            }
        }
    }
    
    return bestnode;
}

// Namespace br_activity_util
// Params 2
// Checksum 0x71861c2b, Offset: 0x2c47
// Size: 0x2f0
function function_68426c67d3320967( player, info )
{
    origin = info.origin;
    angles = info.angles;
    team = player.team;
    activity = info.activity;
    crateinfo = info.crateinfo;
    
    if ( !isdefined( origin ) )
    {
        origin = function_396e4d818e829921( player );
    }
    
    forward = anglestoforward( angles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    drop_point = isnavmeshloaded() ? getclosestpointonnavmesh( origin + offset ) : origin + offset;
    crate = airdrop::dropcrate( undefined, team, "legendary_supply_drop", drop_point + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), drop_point );
    crate.source = "contract_activity";
    crate.activity = activity;
    crate.skipminimapicon = 1;
    crate.crateinfo = crateinfo;
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, crateinfo.markerimage );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, crateinfo.var_4ce09d3d5e1b980b );
        function_ac9886e0e2860e18( id, crateinfo.iconfadestart, crateinfo.iconfadeend );
        function_44a344c68a68f28d( id, 1 );
        function_461834c350793158( id, 1 );
        crate.scriptedobjid = id;
        
        foreach ( teammate in player::getteamarray( player.team ) )
        {
            if ( teammate player::isreallyalive() && !teammate br_public::isplayerinorgoingtogulag() )
            {
                teammate calloutmarkerping::function_5d7b7302e94b97c2( crate.scriptedobjid );
                break;
            }
        }
        
        if ( !level.br_circle_disabled )
        {
            crate thread function_645bd791761c683b( drop_point );
        }
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0xc61db800, Offset: 0x2f3f
// Size: 0x2f
function function_eb40fb73f72cb41e( crate )
{
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) )
    {
        waitframe();
    }
    
    crate notify( #"crate_gas" );
}

// Namespace br_activity_util
// Params 1
// Checksum 0xd92dca82, Offset: 0x2f76
// Size: 0x98
function function_645bd791761c683b( origin )
{
    self notify( #"hash_c0a3f46fd168a35a" );
    self endon( #"hash_c0a3f46fd168a35a" );
    level endon( #"game_ended" );
    self endon( #"crate_gas" );
    self endon( #"death" );
    crate_hit_time = br_circle_util::gettimetilldangerforpoint( origin );
    
    while ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", crate_hit_time ) != "timeout" )
    {
    }
    
    if ( isdefined( self.scriptedobjid ) )
    {
        objidpoolmanager::update_objective_state( self.scriptedobjid, "active" );
    }
}

// Namespace br_activity_util
// Params 1
// Checksum 0x5fec43ef, Offset: 0x3016
// Size: 0xea
function cratedroprewards( player )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( self.crateinfo.var_7a140188db547e4a );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        var_d22cf77a781bb725 = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        
        if ( !isdefined( spawnoptions.ignoreents ) )
        {
            spawnoptions.ignoreents = [];
        }
        
        spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self;
        common_item::function_38cde6a6acb68ea6( var_d22cf77a781bb725, spawncount, spawnoptions );
    }
    
    player thread points::doscoreevent( #"br_cacheopen_epic" );
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

// Namespace br_activity_util
// Params 1
// Checksum 0x4fe0a078, Offset: 0x3108
// Size: 0x102
function function_396e4d818e829921( targetplayer )
{
    team = targetplayer.team;
    
    if ( targetplayer player::isreallyalive() && !targetplayer br_public::isplayerinorgoingtogulag() )
    {
        return targetplayer.origin;
    }
    else
    {
        foreach ( player in player::getteamarray( team ) )
        {
            if ( player player::isreallyalive() && !player br_public::isplayerinorgoingtogulag() )
            {
                return player.origin;
            }
        }
    }
    
    logprint( "ERROR: " + self.varianttag + " activity variant called the reward crate function, did not pass a drop location in, and has no valid players to drop on. Defaulting to world origin" );
    return ( 0, 0, 0 );
}

