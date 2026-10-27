// scripts\mp\br\gametypes\br_vip_quest_legacy.gsc  (hash_384301a1d0b7e7b4.gscc) (size: 7936 Bytes / 0x1f00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x813a35cc (2168075724)
// size ...... 7936 (0x1f00)
// includes .. 5   (offset: 0x1cc8)
// strings ... 31  (offset: 0x1cf0)
// dev strs .. 2   (offset: 0x1ee8)
// exports ... 19  (offset: 0x10a0)
// cseg ...... 0x377 + 0xd29 (0x10a0)
// imports ... 78  (offset: 0x1398)
// animtree1 . 0   (offset: 0x1f00)
// animtree2 . 0   (offset: 0x1f00)
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\teams;
#using scripts\mp\laststand;

#namespace br_vip_quest_legacy;

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0xfe95984b, Offset: 0x395
// Size: 0x15d
function init()
{
    enabled = br_quest_util::registerquestcategory( "vip", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    br_quest_util::registerremovequestinstance( "vip", &vip_removequestinstance );
    br_quest_util::registeronplayerkilled( "vip", &vip_playerdied );
    br_quest_util::registeronplayerdisconnect( "vip", &vip_playerdisconnect );
    br_quest_util::registeronentergulag( "vip", &vip_onentergulag );
    br_quest_util::registeronrespawn( "vip", &vip_onrespawn );
    br_quest_util::registerquestthink( "vip", &vip_questthink_iconposition, 2 );
    
    /#
        br_quest_util::function_2190fafae6ba4d43( "<dev string:x24>", "<dev string:x28>", [ 5, 30, 60, 120, 180, 240, 300 ], 180 );
    #/
    
    game[ "dialog" ][ "hvt_accept" ] = "contract_hvt_accept";
    game[ "dialog" ][ "mission_hvt_accept_first_person" ] = "mission_mission_hvt_accept_first_person";
    game[ "dialog" ][ "mission_hvt_success_third_person" ] = "mission_mission_hvt_success_third_person";
    game[ "dialog" ][ "mission_hvt_success_first_person" ] = "mission_mission_hvt_success_first_person";
    game[ "dialog" ][ "mission_hvt_failure" ] = "mission_mission_hvt_failure";
    game[ "dialog" ][ "mission_hvt_eliminated" ] = "mission_mission_hvt_eliminated";
    br_quest_util::questtimerinit( "vip", 1 );
    br_quest_util::registerontimerexpired( "vip", &vip_ontimerexpired );
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0xf9672584, Offset: 0x4fa
// Size: 0x240
function takequestitem( pickupent )
{
    /#
        br_quest_util::function_e4ac44a582699ee0();
    #/
    
    instance = br_quest_util::createquestinstance( "vip", self.team, pickupent.index, pickupent );
    instance br_quest_util::registerteamonquest( self.team, self );
    br_quest_util::giveteampoints( self.team, #"hash_67eb4b642067882a" );
    instance.team = self.team;
    instance.vip = self;
    instance.vip br_public::setplayermostwantedextrainfo( 1 );
    instance br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.origin + ( 0, 0, 100 ) );
    instance viphud_setupvisibility();
    instance br_quest_util::questtimerset( getdvarint( @"hash_7f10f216178d1d16", 180 ), 4 );
    br_quest_util::addquestinstance( "vip", instance );
    br_quest_util::startteamcontractchallenge( "vip", self, self.team );
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = instance.vip;
    params.excludedteams = [];
    params.excludedteams[ 0 ] = instance.team;
    params.plundervar = br_quest_util::getquestplunderreward( "vip", br_quest_util::getquestrewardtier( self.team ) );
    br_quest_util::displayteamsplash( instance.team, "br_vip_quest_start_vip_team", params );
    br_quest_util::displayplayersplash( instance.vip, "br_vip_quest_start_tablet_finder", params );
    br_quest_util::displaysplashtoplayersinradius( "br_vip_quest_vip_spawn_alert", self.origin, 5000, level.questinfo.defaultfilter, params );
    level thread br_public::brleaderdialogteamexcludeplayer( "hvt_accept", instance.team, instance.vip, 1, undefined, 0.5 );
    level thread br_public::brleaderdialogplayer( "mission_hvt_accept_first_person", instance.vip, 1, undefined, 0.5 );
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0xd9ab889a, Offset: 0x742
// Size: 0x19c
function viphud_setupvisibility()
{
    objective_addalltomask( self.objectiveiconid );
    allplayers = br_quest_util::sortvalidplayersinarray( level.players );
    
    foreach ( player in allplayers[ "valid" ] )
    {
        br_quest_util::showquestobjicontoplayer( player );
    }
    
    foreach ( player in allplayers[ "invalid" ] )
    {
        br_quest_util::hidequestobjiconfromplayer( player );
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( !player br_public::isplayeringulag() )
        {
            viphud_showtoplayer( player );
        }
        
        br_quest_util::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_vip_quest_legacy
// Params 2
// Checksum 0xb809736c, Offset: 0x8e6
// Size: 0x41
function vip_playerdied( attacker, victim )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( victim br_public::isplayeringulag() || attacker br_public::isplayeringulag() )
    {
        return;
    }
    
    vip_playerremoved( victim, attacker );
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0xf0109e36, Offset: 0x92f
// Size: 0x1f
function vip_playerdisconnect( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    vip_playerremoved( player );
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0x20b0696b, Offset: 0x956
// Size: 0x1f
function vip_onentergulag( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    viphud_hidefromplayer( player );
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0x5bc99ec0, Offset: 0x97d
// Size: 0x40
function vip_onrespawn( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( player.team == self.team )
    {
        viphud_showtoplayer( player );
    }
    
    br_quest_util::showquestobjicontoplayer( player );
}

// Namespace br_vip_quest_legacy
// Params 2
// Checksum 0x54406712, Offset: 0x9c5
// Size: 0x67
function vip_playerremoved( removedplayer, attacker )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( removedplayer.team == self.team )
    {
        if ( removedplayer == self.vip )
        {
            vip_failquest( attacker );
        }
        else
        {
            viphud_hidefromplayer( removedplayer );
        }
        
        return;
    }
    
    br_quest_util::hidequestobjiconfromplayer( removedplayer );
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0x7bda59e3, Offset: 0xa34
// Size: 0x13
function vip_ontimerexpired()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    vip_completequest();
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0x8414192a, Offset: 0xa4f
// Size: 0x35
function vip_removequestinstance()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    level notify( "calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid );
    br_quest_util::releaseteamonquest( self.team );
    viphud_deletehud();
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0xaf4331c0, Offset: 0xa8c
// Size: 0x43
function viphud_showtoplayer( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    player br_quest_util::uiobjectiveshow( "vip" );
    player br_quest_util::uiobjectivesetparameter( self.vip getentitynumber() );
    br_quest_util::showquestobjicontoplayer( player );
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0x98f52ff1, Offset: 0xad7
// Size: 0x28
function viphud_hidefromplayer( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    player br_quest_util::uiobjectivehide();
    br_quest_util::hidequestobjiconfromplayer( player );
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0x7e95990f, Offset: 0xb07
// Size: 0x97
function viphud_deletehud()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        viphud_hidefromplayer( player );
    }
    
    br_quest_util::deletequestobjicon();
}

// Namespace br_vip_quest_legacy
// Params 3
// Checksum 0x89477331, Offset: 0xba6
// Size: 0x7a
function vip_respawnplayer( player, sponsor, analyticsevent )
{
    if ( player.inlaststand )
    {
        player laststand::exit( "last_stand_self_revive" );
    }
    
    if ( !isalive( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playergulagautowin( "vipRespawn", sponsor );
        return;
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playerpulloutofgulagwin( sponsor, analyticsevent );
    }
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0xc8376209, Offset: 0xc28
// Size: 0x1cf
function vip_completequest()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    params = spawnstruct();
    rewardtier = br_quest_util::getquestrewardtier( self.team );
    missionid = br_quest_util::getquestindex( "vip" );
    rewardindex = br_quest_util::getquestrewardgroupindex( br_quest_util::getquestrewardbuildgroupref( "vip" ) );
    params.packedbits = br_quest_util::packsplashparambits( missionid, rewardtier, rewardindex );
    br_quest_util::displayteamsplash( self.team, "br_vip_quest_complete", params );
    level thread br_public::brleaderdialogteamexcludeplayer( "mission_hvt_success_third_person", self.team, self.vip, 1, undefined, 0.5 );
    level thread br_public::brleaderdialogplayer( "mission_hvt_success_first_person", self.vip, 1, undefined, 0.5 );
    self.vip br_public::setplayermostwantedextrainfo( 0 );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        vip_respawnplayer( player, self.vip, "vip" );
    }
    
    self.rewardmodifier = undefined;
    self.rewardorigin = self.vip.origin;
    self.rewardangles = self.vip.angles;
    self.result = "success";
    thread br_quest_util::removequestinstance();
}

// Namespace br_vip_quest_legacy
// Params 1
// Checksum 0x355e5a9e, Offset: 0xdff
// Size: 0x1b6
function vip_failquest( attacker )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( isplayer( attacker ) && attacker.team != self.team )
    {
        params = spawnstruct();
        rewardtier = br_quest_util::getquestrewardtier( attacker.team );
        missionid = br_quest_util::getquestindex( "vip" );
        self.rewardmodifier = "_killer";
        rewardindex = br_quest_util::getquestrewardgroupindex( br_quest_util::getquestrewardbuildgroupref( "vip", self.rewardmodifier, self.modifier ) );
        params.packedbits = br_quest_util::packsplashparambits( missionid, rewardtier, rewardindex );
        br_quest_util::displayteamsplash( attacker.team, "br_vip_quest_you_killed_the_vip", params );
        level thread br_public::brleaderdialogteam( "mission_hvt_eliminated", attacker.team, 1, 1 );
        br_quest_util::givequestrewardsinstance( attacker.team, self.vip.origin, self.vip.angles, self.rewardscriptable );
        self.rewardmodifier = undefined;
        self.result = "fail";
    }
    
    self.vip br_public::setplayermostwantedextrainfo( 0 );
    level thread br_public::brleaderdialogteam( "mission_hvt_failure", self.team, 1, 1 );
    br_quest_util::displayteamsplash( self.team, "br_vip_quest_failure" );
    self.rewardmodifier = undefined;
    self.result = "fail";
    br_quest_util::removequestinstance();
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0xcbad7f6e, Offset: 0xfbd
// Size: 0x34
function vip_questthink_iconposition()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    br_quest_util::movequestobjicon( self.vip.origin + ( 0, 0, 100 ) );
}

// Namespace br_vip_quest_legacy
// Params 0
// Checksum 0xb87bf64d, Offset: 0xff9
// Size: 0xa6, Type: bool
function function_8225394f018d1121()
{
    quests = br_quest_util::getquestdata( "vip" );
    
    if ( !isdefined( quests ) )
    {
        return false;
    }
    
    foreach ( instance in quests.instances )
    {
        if ( instance.vip == self )
        {
            return true;
        }
    }
    
    return false;
}

