// scripts\mp\br\gametypes\br_collection_quest.gsc  (hash_715905e40e1bfbfd.gscc) (size: 9749 Bytes / 0x2615 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4ddd742 (3571308354)
// size ...... 9749 (0x2615)
// includes .. 5   (offset: 0x2499)
// strings ... 18  (offset: 0x24c1)
// dev strs .. 1   (offset: 0x2609)
// exports ... 27  (offset: 0x14dd)
// cseg ...... 0x1d8 + 0x1305 (0x14dd)
// imports ... 100 (offset: 0x1915)
// animtree1 . 0   (offset: 0x2615)
// animtree2 . 0   (offset: 0x2615)
#using scripts\common\math;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\objidpoolmanager;

#namespace br_collection_quest;

// Namespace br_collection_quest
// Params 0
// Checksum 0x6f8f8adf, Offset: 0x1f6
// Size: 0xdb
function init()
{
    enabled = br_quest_util::registerquestcategory( "collection", 0 );
    
    if ( !enabled )
    {
        return;
    }
    
    level.scr_br_collection_findpath = getdvarint( @"scr_br_collection_findpath", 0 ) != 0;
    br_quest_util::registerremovequestinstance( "collection", &col_removequestinstance );
    br_quest_util::registerquestlocale( "collect_locale" );
    br_quest_util::registerquestthink( "collect_locale", &col_localethink_itemspawn, 3 );
    br_quest_util::registerquestthink( "collect_locale", &col_localethink_objectivevisibility, 0.2 );
    br_quest_util::registerremovequestinstance( "collect_locale", &col_removelocaleinstance );
    br_quest_util::registercreatequestlocale( "collect_locale", &col_createquestlocale );
    br_quest_util::registercheckiflocaleisavailable( "collect_locale", &col_checkiflocaleisavailable );
    br_quest_util::registerquestcircletick( "collect_locale", &col_circletick );
    br_quest_util::getquestdata( "collect_locale" ).nextid = 0;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0xa74375f1, Offset: 0x2d9
// Size: 0xd9
function col_removequestinstance()
{
    locale = br_quest_util::getquestinstancedata( "collect_locale", self.team );
    locale hideuielements( self );
    br_quest_util::uiobjectivehidefromteam( self.team );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( locale.objectiveiconid, player );
    }
    
    br_quest_util::releaseteamonquest( self.team );
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xf8e83863, Offset: 0x3ba
// Size: 0x264
function takequestitem( pickupent )
{
    br_quest_util::uiobjectiveshowtoteam( "collection", self.team );
    instance = br_quest_util::createquestinstance( "collection", self.team, pickupent.index, pickupent );
    instance.team = self.team;
    instance.startlocation = checkpoint( self.origin );
    instance br_quest_util::registerteamonquest( self.team, self );
    search_params = spawnstruct();
    search_params.searchfunc = "questPointsArray";
    search_params.searchcircleorigin = instance.startlocation;
    search_params.searchradiusmax = 10000;
    search_params.searchradiusmin = 0;
    search_params.searchradiusidealmax = 6000;
    search_params.searchradiusidealmin = 4000;
    search_params.mintime = 30;
    search_params.initialplayer = self;
    search_params.questtypes = 7;
    locale = instance br_quest_util::requestquestlocale( "collect_locale", search_params );
    instance.totalcollecteditems = 0;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player.collecteditems = 0;
    }
    
    locale updatelocaleplayerlist();
    locale updateusablestateall();
    locale showuielements( instance );
    br_quest_util::addquestinstance( "collection", instance );
    br_quest_util::startteamcontractchallenge( "collection", self, self.team );
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self;
    br_quest_util::displayteamsplash( self.team, "br_scavenger_quest_start_team", params );
    br_quest_util::displayplayersplash( self, "br_scavenger_quest_start_tablet_finder" );
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x1dcc314f, Offset: 0x626
// Size: 0x120
function updatelocaleplayerlist()
{
    var_9afb25ce18d99f6d = [];
    
    foreach ( instance in self.subscribedinstances )
    {
        team = instance.team;
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_9afb25ce18d99f6d[ var_9afb25ce18d99f6d.size ] = player;
        }
    }
    
    self.playerlist = var_9afb25ce18d99f6d;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0xf55e2770, Offset: 0x74e
// Size: 0x7b
function updateusablestateall()
{
    foreach ( item in self.itemlist )
    {
        updateusablestate( item );
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0x47af2c71, Offset: 0x7d1
// Size: 0xa9
function updateusablestate( item )
{
    foreach ( player in level.players )
    {
        if ( arraycontains( self.playerlist, player ) )
        {
            item enableplayeruse( player );
            item showtoplayer( player );
            continue;
        }
        
        item disableplayeruse( player );
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xc5739edf, Offset: 0x882
// Size: 0x9c
function showuielements( instance )
{
    foreach ( player in teams::getteamdata( instance.team, "players" ) )
    {
        game_utility::questcircle_showtoplayer( player );
        updatecollectionuiforplayer( instance, player );
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xd6e24bc4, Offset: 0x926
// Size: 0x93
function updatecollectionui( instance )
{
    foreach ( player in teams::getteamdata( instance.team, "players" ) )
    {
        updatecollectionuiforplayer( instance, player );
    }
}

// Namespace br_collection_quest
// Params 2
// Checksum 0x1443eff, Offset: 0x9c1
// Size: 0x37
function updatecollectionuiforplayer( instance, player )
{
    assert( isplayer( player ) );
    player br_quest_util::uiobjectivesetparameter( instance.totalcollecteditems );
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x85e2e2dd, Offset: 0xa00
// Size: 0xb6
function determineobjectiveiconvisibility()
{
    foreach ( player in self.playerlist )
    {
        if ( distance2d( player.origin, self.curorigin ) > 0 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xc6d4224b, Offset: 0xabe
// Size: 0x9b
function hideuielements( instance )
{
    foreach ( player in teams::getteamdata( instance.team, "players" ) )
    {
        game_utility::questcircle_hidefromplayer( player );
        player br_quest_util::uiobjectivehide();
    }
}

// Namespace br_collection_quest
// Params 0
// Checksum 0xaaccb9a4, Offset: 0xb61
// Size: 0x10e
function findpoint()
{
    point = self.curorigin + math::random_vector_2d() * randomintrange( 0, 2900 );
    point = checkpoint( point );
    point += ( 0, 0, 10 );
    
    foreach ( item in self.itemlist )
    {
        if ( distance( item.origin, point ) < 100 )
        {
            return;
        }
    }
    
    if ( level.scr_br_collection_findpath )
    {
        path = self.playerlist[ 0 ] findpath( self.curorigin, point, 0, 0 );
        
        if ( isdefined( path ) )
        {
            return point;
        }
        else
        {
            return;
        }
        
        return;
    }
    
    return point;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x1e8d8d45, Offset: 0xc77
// Size: 0x85
function forcespawnitem()
{
    if ( isdefined( self.previouspoints ) && self.previouspoints.size > 0 )
    {
        point = self.previouspoints[ 0 ];
        self.previouspoints = arrayremove( self.previouspoints, self.previouspoints[ 0 ] );
        return;
    }
    
    for ( index = 0; index < 30 ; index++ )
    {
        point = findpoint();
        
        if ( !isdefined( point ) )
        {
            return point;
        }
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0x896e24e, Offset: 0xd04
// Size: 0xb7
function spawnitem( point )
{
    self.numitems++;
    stashlocation = spawn( "script_model", point );
    stashlocation setmodel( "box_wooden_grenade_01" );
    stashlocation makeusable();
    stashlocation setcursorhint( "HINT_NOICON" );
    stashlocation setuseholdduration( "duration_short" );
    stashlocation sethintdisplayfov( 150 );
    stashlocation setusefov( 150 );
    stashlocation setuserange( 150 );
    stashlocation sethintstring( &"mp/scav_pickup_prompt" );
    stashlocation setasgametypeobjective();
    stashlocation.locale = self;
    stashlocation thread stashthink();
    self.itemlist[ self.itemlist.size ] = stashlocation;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x3a38544c, Offset: 0xdc3
// Size: 0x44
function stashthink()
{
    self endon( #"death" );
    self endon( #"remove_locale" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        thread usestash( player );
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xb5dd04df, Offset: 0xe0f
// Size: 0x129
function usestash( player )
{
    locale = self.locale;
    instance = br_quest_util::getquestinstancedata( "collection", player.team );
    
    if ( isdefined( instance ) )
    {
        self hide();
        self makeunusable();
        self.origin += ( 0, 0, -500 );
        self delete();
        player.collecteditems++;
        instance.totalcollecteditems++;
        locale updatecollectionui( instance );
        locale.numitems -= 1;
        
        if ( !isdefined( locale.previouspoints ) )
        {
            locale.previouspoints = [];
        }
        
        locale.previouspoints[ locale.previouspoints.size ] = self.origin;
        locale.itemlist = arrayremove( locale.itemlist, self );
        
        if ( instance.totalcollecteditems >= 10 )
        {
            instance thread completecollectionquest( self );
        }
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0x1b4417f4, Offset: 0xf40
// Size: 0xff
function completecollectionquest( stash )
{
    rewardtier = br_quest_util::getquestrewardtier( self.team );
    reward = br_quest_util::getquestplunderreward( "collection", rewardtier );
    params = spawnstruct();
    missionid = br_quest_util::getquestindex( "collection" );
    params.packedbits = br_quest_util::packsplashparambits( missionid, rewardtier );
    br_quest_util::displayteamsplash( self.id, "br_scavenger_quest_complete", params );
    br_quest_util::giveteamplunderflat( self.team, reward );
    self.rewardorigin = stash.origin;
    self.rewardangles = stash.angles;
    self.result = "success";
    br_quest_util::removequestinstance();
    
    if ( isdefined( level.dmzmissioncomplete ) )
    {
        level [[ level.dmzmissioncomplete ]]( self.team );
    }
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x7882b4fd, Offset: 0x1047
// Size: 0x2c
function failcollectionquest()
{
    br_quest_util::displayteamsplash( self.id, "br_scavenger_quest_circle_failure" );
    self.result = "fail";
    br_quest_util::removequestinstance();
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x6623708e, Offset: 0x107b
// Size: 0x1a
function col_checkiflocaleisavailable()
{
    if ( self.subscribedinstances.size < 4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_collection_quest
// Params 1
// Checksum 0x965d0d21, Offset: 0x109d
// Size: 0xbb
function col_createquestlocale( placement )
{
    br_quest_util::getquestdata( "collect_locale" ).nextid++;
    locale = br_quest_util::createlocaleinstance( "collect_locale", "collection", "ColLoc:" + br_quest_util::getquestdata( "collect_locale" ).nextid );
    locale.curorigin = placement.origin;
    locale col_createcircleobjectiveicon();
    locale.itemlist = [];
    locale game_utility::questcircle_create( "Collection_Br", locale.curorigin, 2000 );
    locale game_utility::questcircle_hidefromall();
    br_quest_util::addquestinstance( "collect_locale", locale );
    return locale;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x9ad873da, Offset: 0x1161
// Size: 0xa6
function col_createcircleobjectiveicon()
{
    self.objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( self.objectiveiconid, "current", ( 0, 0, 0 ), "ui_mp_br_mapmenu_icon_scavengerhunt_tablet" );
        objidpoolmanager::update_objective_position( self.objectiveiconid, self.curorigin );
        objidpoolmanager::update_objective_setbackground( self.objectiveiconid, 2 );
        objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
        objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        return;
    }
    
    println( "<dev string:x24>" );
}

// Namespace br_collection_quest
// Params 0
// Checksum 0xb4997ef8, Offset: 0x120f
// Size: 0x8f
function col_localethink_itemspawn()
{
    if ( !isdefined( self.numitems ) )
    {
        self.numitems = 0;
        self.nextitem = 0;
    }
    
    if ( self.nextitem % 3 == 0 || self.numitems < 5 )
    {
        if ( self.numitems < 15 )
        {
            if ( isdefined( self.nextpoint ) )
            {
                spawnitem( self.nextpoint );
                self.nextpoint = undefined;
            }
            else
            {
                forcespawnitem();
            }
        }
    }
    
    self.nextitem++;
}

// Namespace br_collection_quest
// Params 0
// Checksum 0x8dd35f9c, Offset: 0x12a6
// Size: 0x24
function col_localethink_objectivevisibility()
{
    determineobjectiveiconvisibility();
    
    if ( !isdefined( self.nextpoint ) )
    {
        self.nextpoint = findpoint();
    }
}

// Namespace br_collection_quest
// Params 0
// Checksum 0xc8a05e25, Offset: 0x12d2
// Size: 0xe4
function col_removelocaleinstance()
{
    game_utility::questcircle_delete();
    self.playerlist = undefined;
    self.subscribedinstances = undefined;
    
    foreach ( item in self.itemlist )
    {
        item notify( #"remove_locale" );
        item hide();
        item makeunusable();
        item.origin += ( 0, 0, -500 );
        item delete();
    }
    
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_collection_quest
// Params 2
// Checksum 0x2ad74304, Offset: 0x13be
// Size: 0xf9
function col_circletick( dangercircleorigin, dangercircleradius )
{
    if ( !isdefined( self.lastcircletick ) )
    {
        self.lastcircletick = -1;
    }
    
    currenttime = gettime();
    
    if ( self.lastcircletick == currenttime )
    {
        return;
    }
    
    self.lastcircletick = currenttime;
    dist = distance2d( self.curorigin, dangercircleorigin );
    
    if ( dist > dangercircleradius )
    {
        foreach ( instanceid in self.subscribedinstances )
        {
            br_quest_util::getquestinstancedata( "collection", instanceid ) failcollectionquest();
        }
    }
}

// Namespace br_collection_quest
// Params 1
// Checksum 0xbd78e7ad, Offset: 0x14bf
// Size: 0x1d
function checkpoint( point )
{
    if ( isnavmeshloaded() )
    {
        point = getclosestpointonnavmesh( point );
    }
    
    return point;
}

