// scripts\mp\br\gametypes\br_history_quest.gsc  (hash_5e707b81473a88e3.gscc) (size: 9221 Bytes / 0x2405 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdef9864b (3740894795)
// size ...... 9221 (0x2405)
// includes .. 5   (offset: 0x2239)
// strings ... 17  (offset: 0x2261)
// dev strs .. 0   (offset: 0x2405)
// exports ... 24  (offset: 0x149d)
// cseg ...... 0x1b7 + 0x12e6 (0x149d)
// imports ... 78  (offset: 0x185d)
// animtree1 . 0   (offset: 0x2405)
// animtree2 . 0   (offset: 0x2405)
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;

#namespace br_history_quest;

// Namespace br_history_quest
// Params 0
// Checksum 0x4030a967, Offset: 0x1d5
// Size: 0xd9
function init()
{
    enabled = br_quest_util::registerquestcategory( "history", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    br_quest_util::getquestdata( "history" ).missionbasetimer = getdvarint( @"hash_1225f4a756603591", 240 );
    br_quest_util::getquestdata( "history" ).dvarlocations = getdvarint( @"hash_237b2ffce8991450", 0 );
    br_quest_util::registerremovequestinstance( "history", &his_removequestinstance );
    br_quest_util::registeronplayerdisconnect( "history", &his_playerdisconnect );
    br_quest_util::registeronrespawn( "history", &his_respawn );
    br_quest_util::registerquestthink( "history", &his_think, 0.1 );
    br_quest_util::questtimerinit( "history", 0 );
    br_quest_util::registerontimerexpired( "history", &his_ontimerexpired );
    createallhistorydestinations();
}

// Namespace br_history_quest
// Params 1
// Checksum 0x34fff721, Offset: 0x2b6
// Size: 0x3a
function his_respawn( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( !checkforcorrectinstance( player ) )
    {
        return;
    }
    
    player br_quest_util::uiobjectiveshow( "history" );
    br_quest_util::showquestobjicontoplayer( player );
}

// Namespace br_history_quest
// Params 0
// Checksum 0x188ed5e2, Offset: 0x2f8
// Size: 0x1a
function his_ontimerexpired()
{
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
}

// Namespace br_history_quest
// Params 0
// Checksum 0xd64e32d3, Offset: 0x31a
// Size: 0xdf
function his_removequestinstance()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( isdefined( self.currentdestination ) )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            self.currentdestination.gameobject hidefromplayer( player );
            self.currentdestination.gameobject disableplayeruse( player );
        }
    }
    
    deletehistoryhud();
    br_quest_util::releaseteamonquest( self.team );
}

// Namespace br_history_quest
// Params 1
// Checksum 0x87d1aced, Offset: 0x401
// Size: 0x4e
function his_playerdisconnect( disconnectplayer )
{
    if ( disconnectplayer.team == self.team )
    {
        if ( !br_quest_util::isteamvalid( disconnectplayer.team ) )
        {
            self.result = "fail";
            br_quest_util::removequestinstance();
        }
    }
}

// Namespace br_history_quest
// Params 1
// Checksum 0x3c456f09, Offset: 0x457
// Size: 0x2c
function checkforcorrectinstance( player )
{
    if ( player.team == self.team )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_history_quest
// Params 5
// Checksum 0x670997d3, Offset: 0x48b
// Size: 0x1f7
function givequest( team, id, player, modifier, rewardscriptable )
{
    instance = br_quest_util::createquestinstance( "history", team, id, rewardscriptable );
    instance br_quest_util::registerteamonquest( team, player );
    instance.team = self.team;
    instance.startlocation = self.origin;
    instance.playerlist = teams::getteamdata( self.team, "players" );
    instance.destprogress = 0;
    instance br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_x1_02_objective", "current", ( 0, 0, 0 ) );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        instance br_quest_util::showquestobjicontoplayer( player );
    }
    
    instance setfirsthistorydestination();
    br_quest_util::uiobjectiveshowtoteam( "history", self.team );
    instance br_quest_util::questtimerset( br_quest_util::getquestdata( "history" ).missionbasetimer, 4 );
    br_quest_util::addquestinstance( "history", instance );
    br_quest_util::startteamcontractchallenge( "history", self, self.team );
    params = spawnstruct();
    params.plundervar = br_quest_util::getquestplunderreward( "history", br_quest_util::getquestrewardtier( self.team ) );
    br_quest_util::displayteamsplash( self.team, "br_history_quest_start_team_notify", params );
    return instance;
}

// Namespace br_history_quest
// Params 0
// Checksum 0x8bb000b8, Offset: 0x68b
// Size: 0x7b
function applyquest()
{
    player = self;
    
    if ( isdefined( level.questinfo.quests[ "history" ].instances[ player.team ] ) )
    {
        return;
    }
    
    instance = givequest( player.team, "", player, "" );
    
    if ( isdefined( instance ) )
    {
        instance thread oninstanceremoved();
    }
    
    return instance;
}

// Namespace br_history_quest
// Params 0
// Checksum 0xd433229c, Offset: 0x70f
// Size: 0x34
function oninstanceremoved()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    instance = self;
    instance waittill( #"removed" );
    instance notify( #"update" );
}

// Namespace br_history_quest
// Params 0
// Checksum 0xe18e0bd2, Offset: 0x74b
// Size: 0x396
function createallhistorydestinations()
{
    if ( level.mapname == "mp_br_mechanics" )
    {
        br_quest_util::getquestdata( "history" ).destinations[ 0 ] = createhistorydestination( ( -814, -1073, 30 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 1 ] = createhistorydestination( ( 174, -1394, 30 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 2 ] = createhistorydestination( ( 358, -767, 30 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 3 ] = createhistorydestination( ( 607, 465, 30 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 4 ] = createhistorydestination( ( 33, 1106, 30 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 5 ] = createhistorydestination( ( -34, 257, 30 ) );
    }
    else if ( br_quest_util::getquestdata( "history" ).dvarlocations )
    {
        br_quest_util::getquestdata( "history" ).destinations[ 0 ] = getdvarvector( @"hash_2cb65fc00f6cc800", ( 47129, -10802, 101 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 1 ] = getdvarvector( @"hash_2cb662c00f6cce99", ( -38441, -2006, -118 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 2 ] = getdvarvector( @"hash_2cb661c00f6ccc66", ( 41891, -41209, -621 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 3 ] = getdvarvector( @"hash_2cb664c00f6cd2ff", ( -37283, -19054, 220 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 4 ] = getdvarvector( @"hash_2cb663c00f6cd0cc", ( 21348, 16554, 192 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 5 ] = getdvarvector( @"hash_2cb666c00f6cd765", ( 18691, -34849, -496 ) );
    }
    else
    {
        br_quest_util::getquestdata( "history" ).destinations[ 0 ] = createhistorydestination( ( 47129, -10802, 101 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 1 ] = createhistorydestination( ( -38441, -2006, -118 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 2 ] = createhistorydestination( ( 41891, -41209, -621 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 3 ] = createhistorydestination( ( -37283, -19054, 220 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 4 ] = createhistorydestination( ( 21348, 16554, 192 ) );
        br_quest_util::getquestdata( "history" ).destinations[ 5 ] = createhistorydestination( ( 18691, -34849, -496 ) );
    }
    
    br_quest_util::getquestdata( "history" ).numrequireddestinations = getdvarint( @"hash_e6e6458e790f4fc7", 1 );
}

// Namespace br_history_quest
// Params 1
// Checksum 0x8c5063b5, Offset: 0xae9
// Size: 0xbd
function createhistorydestination( destorigin )
{
    destination = spawnstruct();
    destination.origin = br_public::droptogroundmultitrace( destorigin, 0, -200 ) + ( 0, 0, 20 );
    destination.gameobject = spawn( "script_model", destination.origin );
    destination.gameobject setmodel( "electronics_keycard_office_02_black_gold" );
    destination.gameobject.angles = ( 45, 0, 45 );
    destination.gameobject hide();
    destination.gameobject thread function_e7783ef95fc823c2();
    return destination;
}

// Namespace br_history_quest
// Params 0
// Checksum 0x3771dc88, Offset: 0xbaf
// Size: 0x51
function function_e7783ef95fc823c2()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        player function_58b3a25cd2344599( self );
        player playlocalsound( "fly_pickup_gen" );
    }
}

// Namespace br_history_quest
// Params 1
// Checksum 0xc82929b7, Offset: 0xc08
// Size: 0xf2
function function_58b3a25cd2344599( destination )
{
    /#
        br_quest_util::function_e4ac44a582699ee0();
    #/
    
    questinstance = br_quest_util::getquestinstancedata( "history", self.team );
    
    foreach ( player in teams::getteamdata( questinstance.team, "players" ) )
    {
        questinstance.currentdestination.gameobject hidefromplayer( player );
        questinstance.currentdestination.gameobject disableplayeruse( player );
    }
    
    questinstance reachhistorydestination();
}

// Namespace br_history_quest
// Params 0
// Checksum 0x4199b71, Offset: 0xd02
// Size: 0x26a
function sethistorydestination()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( isdefined( self.currentdestination ) )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            self.currentdestination.gameobject hidefromplayer( player );
            self.currentdestination.gameobject disableplayeruse( player );
        }
    }
    
    self.currentdestination = br_quest_util::getquestdata( "history" ).destinations[ self.currentdestindex ];
    br_quest_util::movequestobjicon( self.currentdestination.origin + ( 0, 0, 38 ) );
    
    if ( !self.currentdestination.gameobject.hintinit )
    {
        self.currentdestination.gameobject.hintinit = 1;
        self.currentdestination.gameobject disableplayeruseforallplayers();
        self.currentdestination.gameobject gameobjects::sethintobject( undefined, undefined, undefined, &"mp_br_ingame/x1_card_use", undefined, "duration_none", undefined, 200, 90, 72, 90 );
        self.currentdestination.gameobject setuseprioritymax();
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        self.currentdestination.gameobject showtoplayer( player );
        self.currentdestination.gameobject enableplayeruse( player );
    }
    
    updatehistoryhud();
}

// Namespace br_history_quest
// Params 0
// Checksum 0xfd295363, Offset: 0xf74
// Size: 0xac
function setfirsthistorydestination()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    self.destorder = [];
    
    for ( index = 0; index < br_quest_util::getquestdata( "history" ).destinations.size ; index++ )
    {
        self.destorder[ index ] = index;
    }
    
    self.destorder = arrayrandomize( self.destorder );
    self.currentdestindex = self.destorder[ 0 ];
    self.currentdestination = br_quest_util::getquestdata( "history" ).destinations[ self.currentdestindex ];
    sethistorydestination();
}

// Namespace br_history_quest
// Params 0
// Checksum 0x131c4e22, Offset: 0x1028
// Size: 0x2f
function setnexthistorydestination()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    self.currentdestindex = self.destorder[ self.destprogress ];
    sethistorydestination();
}

// Namespace br_history_quest
// Params 0
// Checksum 0x438705d6, Offset: 0x105f
// Size: 0xe4
function reachhistorydestination()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    self.destprogress++;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player calloutmarkerping::function_7c0ee9d4b604e6d6( 7 );
    }
    
    if ( self.destprogress < br_quest_util::getquestdata( "history" ).numrequireddestinations )
    {
        setnexthistorydestination();
        br_quest_util::displayteamsplash( self.team, "br_history_quest_next_destination" );
        return;
    }
    
    his_completemission();
}

// Namespace br_history_quest
// Params 0
// Checksum 0xf3d2507f, Offset: 0x114b
// Size: 0x1f
function his_think()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( self.forcefail )
    {
        failhistoryquest();
    }
}

// Namespace br_history_quest
// Params 0
// Checksum 0x93a3d724, Offset: 0x1172
// Size: 0x12b
function his_completemission()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    params = spawnstruct();
    rewardtier = br_quest_util::getquestrewardtier( self.team );
    missionid = br_quest_util::getquestindex( "history" );
    rewardindex = br_quest_util::getquestrewardgroupindex( br_quest_util::getquestrewardbuildgroupref( "history" ) );
    params.packedbits = br_quest_util::packsplashparambits( missionid, rewardtier, rewardindex );
    
    if ( getdvarint( @"hash_4b7d23ad6fca65d8", 1 ) )
    {
        players = level.teamdata[ self.team ][ "alivePlayers" ];
        br_quest_util::displaysplashtoplayers( players, "br_history_quest_complete", params );
    }
    else
    {
        br_quest_util::displayteamsplash( self.team, "br_history_quest_complete", params );
    }
    
    self.rewardorigin = self.playerlist[ 0 ].origin;
    self.rewardangles = self.playerlist[ 0 ].angles;
    self.result = "success";
    br_quest_util::removequestinstance();
}

// Namespace br_history_quest
// Params 0
// Checksum 0xd81188c3, Offset: 0x12a5
// Size: 0x21
function failhistoryquest()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    self.result = "fail";
    br_quest_util::removequestinstance();
}

// Namespace br_history_quest
// Params 0
// Checksum 0xa5cc95f9, Offset: 0x12ce
// Size: 0x89
function updatehistoryhud()
{
    foreach ( player in self.playerlist )
    {
        player br_quest_util::uiobjectiveshow( "history" );
        br_quest_util::showquestobjicontoplayer( player );
    }
}

// Namespace br_history_quest
// Params 1
// Checksum 0x9b85637, Offset: 0x135f
// Size: 0x28
function hidehistoryhudfromplayer( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    br_quest_util::hidequestobjiconfromplayer( player );
    player br_quest_util::uiobjectivehide();
}

// Namespace br_history_quest
// Params 0
// Checksum 0x21ba6407, Offset: 0x138f
// Size: 0x10e
function deletehistoryhud()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    foreach ( player in self.playerlist )
    {
        if ( isdefined( player ) )
        {
            hidehistoryhudfromplayer( player );
        }
    }
    
    br_quest_util::deletequestobjicon();
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player calloutmarkerping::function_7c0ee9d4b604e6d6( 7 );
    }
}

