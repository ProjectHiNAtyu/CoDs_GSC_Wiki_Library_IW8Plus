// scripts\mp\br\gametypes\br_secretstash_quest.gsc  (hash_7b2aeb4932b5b6ea.gscc) (size: 8085 Bytes / 0x1f95 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6170b7e4 (1634777060)
// size ...... 8085 (0x1f95)
// includes .. 6   (offset: 0x1d89)
// strings ... 26  (offset: 0x1db9)
// dev strs .. 5   (offset: 0x1f59)
// exports ... 19  (offset: 0x1159)
// cseg ...... 0x2b1 + 0xea8 (0x1159)
// imports ... 79  (offset: 0x1451)
// animtree1 . 0   (offset: 0x1f95)
// animtree2 . 0   (offset: 0x1f95)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;

#namespace br_secretstash_quest;

// Namespace br_secretstash_quest
// Params 0
// Checksum 0x5b4d2df3, Offset: 0x2cf
// Size: 0x103
function init()
{
    scriptable::scriptable_addusedcallbackbypart( "body", &secretstashlootcacheused );
    enabled = br_quest_util::registerquestcategory( "secretstash", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    br_quest_util::getquestdata( "secretstash" ).searchcirclesize = getdvarint( @"hash_78bca7221bbede3b", 3500 );
    br_quest_util::getquestdata( "secretstash" ).missionbasetimer = getdvarint( @"hash_edb6290ecfb6c128", 180 );
    br_quest_util::registertabletinit( "secretstash", &sstablet_init );
    br_quest_util::registerremovequestinstance( "secretstash", &ss_removequestinstance );
    br_quest_util::registeronplayerdisconnect( "secretstash", &ss_playerdisconnect );
    br_quest_util::registerquestcircletick( "secretstash", &ss_circletick );
    br_quest_util::registeronentergulag( "secretstash", &ss_entergulag );
    br_quest_util::registeronrespawn( "secretstash", &ss_respawn );
    br_quest_util::questtimerinit( "secretstash", 1 );
    br_quest_util::registerontimerexpired( "secretstash", &ss_ontimerexpired );
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0x8553585c, Offset: 0x3da
// Size: 0x7d, Type: bool
function sstablet_init()
{
    /#
        br_quest_util::function_9054d3c68a31b891();
    #/
    
    searchorigin = self.origin;
    search_params = lootcachesearchparams( searchorigin );
    placement = br_quest_util::findquestplacement( "secretstash", search_params );
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    disablelootspawnpoint( placement.index );
    searchorigin = placement.origin;
    self.reservedplacement = placement;
    return true;
}

// Namespace br_secretstash_quest
// Params 2
// Checksum 0x3d4d444d, Offset: 0x460
// Size: 0x125
function ss_circletick( dangercircleorigin, dangercircleradius )
{
    assert( isdefined( dangercircleorigin ), "<dev string:x24>" );
    assert( isdefined( dangercircleradius ), "<dev string:x5a>" );
    assert( isdefined( self.curorigin ), "<dev string:x90>" );
    
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
        foreach ( instance in self.subscribedinstances )
        {
            instance failsecretstashquest();
        }
    }
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0x435a859, Offset: 0x58d
// Size: 0x35
function ss_entergulag( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( !checkforcorrectinstance( player ) )
    {
        return;
    }
    
    player br_quest_util::uiobjectivehide();
    game_utility::questcircle_hidefromplayer( player );
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0x19160d5d, Offset: 0x5ca
// Size: 0x3a
function ss_respawn( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    if ( !checkforcorrectinstance( player ) )
    {
        return;
    }
    
    player br_quest_util::uiobjectiveshow( "secretstash" );
    game_utility::questcircle_showtoplayer( player );
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0x39515e5b, Offset: 0x60c
// Size: 0x2f
function ss_ontimerexpired()
{
    br_quest_util::displayteamsplash( self.team, "br_scavenger_quest_timer_expired" );
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0xc3e2e42c, Offset: 0x643
// Size: 0x23
function ss_removequestinstance()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    game_utility::questcircle_delete();
    br_quest_util::releaseteamonquest( self.team );
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0xe051d67b, Offset: 0x66e
// Size: 0xb9
function ss_playerdisconnect( disconnectplayer )
{
    if ( disconnectplayer.team == self.team )
    {
        playerlist = teams::getteamdata( self.team, "players" );
        br_quest_util::getquestinstancedata( "secretstash", self.team ).playerlist = playerlist;
        
        if ( isdefined( self ) && isdefined( self.cacheentity ) && playerlist.size )
        {
            self.cacheentity setotherent( playerlist[ 0 ] );
        }
        
        if ( !br_quest_util::isteamvalid( disconnectplayer.team ) )
        {
            self.result = "fail";
            br_quest_util::removequestinstance();
        }
    }
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0xa545bb18, Offset: 0x72f
// Size: 0x2c
function checkforcorrectinstance( player )
{
    if ( player.team == self.team )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0xe66eadf5, Offset: 0x763
// Size: 0x246
function takequestitem( pickupent )
{
    /#
        br_quest_util::function_e4ac44a582699ee0();
    #/
    
    instance = br_quest_util::createquestinstance( "secretstash", self.team, pickupent.index, pickupent );
    instance br_quest_util::registerteamonquest( self.team, self );
    instance br_quest_util::registercontributingplayers( self );
    instance.team = self.team;
    instance.startlocation = self.origin;
    instance.currlocation = self.origin;
    instance.reservedplacement = pickupent.reservedplacement;
    instance.playerlist = teams::getteamdata( self.team, "players" );
    search_params = lootcachesearchparams( instance.startlocation, instance.reservedplacement );
    instance spawnsecretstashlootcache( instance.reservedplacement.origin, instance.reservedplacement.angles );
    instance game_utility::questcircle_create( "ScavengerHunt_Br", instance.reservedplacement.origin, 3500 );
    instance updatesecretstashhud();
    br_quest_util::uiobjectiveshowtoteam( "secretstash", self.team );
    instance br_quest_util::questtimerset( br_quest_util::getquestdata( "secretstash" ).missionbasetimer, 4 );
    br_quest_util::addquestinstance( "secretstash", instance );
    br_quest_util::startteamcontractchallenge( "secretstash", self, self.team );
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self;
    params.plundervar = br_quest_util::getquestplunderreward( "secretstash", br_quest_util::getquestrewardtier( self.team ) );
    br_quest_util::displayteamsplash( self.team, "br_secretstash_quest_start_team_notify", params );
    br_quest_util::displayplayersplash( self, "br_secretstash_quest_start_tablet_finder", params );
    br_quest_util::giveteampoints( self.team, #"hash_67eb4b642067882a" );
}

// Namespace br_secretstash_quest
// Params 2
// Checksum 0x5450865b, Offset: 0x9b1
// Size: 0x110
function lootcachesearchparams( searchcircleorigin, reservedplacement )
{
    search_params = spawnstruct();
    search_params.searchfunc = "getUnusedLootCacheArray";
    search_params.searchcircleorigin = searchcircleorigin;
    search_params.searchradiusmax = 10000;
    search_params.searchradiusmin = 0;
    search_params.searchradiusidealmax = 4000;
    search_params.searchradiusidealmin = 2000;
    search_params.searchforcecirclecenter = 1;
    search_params.reservedplacement = reservedplacement;
    search_params.mintime = 60;
    
    if ( game_utility::getgametype() == "plunder" )
    {
        if ( search_params.searchradiusmax < level.quest_secretdistmax )
        {
            search_params.searchradiusmax = level.quest_secretdistmax;
        }
        
        search_params.searchradiusidealmax = level.quest_secretdistmax;
        search_params.searchradiusidealmin = level.quest_secretdistmin;
    }
    
    return search_params;
}

// Namespace br_secretstash_quest
// Params 2
// Checksum 0x72bc7e23, Offset: 0xaca
// Size: 0x16a
function spawnsecretstashlootcache( inorigin, inangles )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    cacheentity = spawn( "script_model", inorigin );
    assert( isdefined( self.playerlist ) || self.playerlist.size > 0, "<dev string:xc2>" );
    var_88b519152b97f56a = self.playerlist[ 0 ];
    cacheentity.angles = inangles;
    cacheentity setotherent( var_88b519152b97f56a );
    cacheentity setmodel( "military_loot_crate_01_br_secretstash_01" );
    cacheentity setscriptablepartstate( "body", "secretstash_closed" );
    cacheentity.questinstance = self;
    self.cacheentity = cacheentity;
    
    foreach ( player in level.players )
    {
        if ( player != var_88b519152b97f56a && ( var_88b519152b97f56a.team == "none" || player.team != var_88b519152b97f56a.team ) )
        {
            cacheentity disablescriptableplayeruse( player );
        }
    }
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0xd0f943d4, Offset: 0xc3c
// Size: 0x120
function updatesecretstashhud()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    players = br_quest_util::sortvalidplayersinarray( self.playerlist );
    
    foreach ( player in players[ "valid" ] )
    {
        player br_quest_util::uiobjectiveshow( "secretstash" );
        game_utility::questcircle_showtoplayer( player );
    }
    
    foreach ( player in players[ "invalid" ] )
    {
        player br_quest_util::uiobjectivehide();
        game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0x6cb1a9e0, Offset: 0xd64
// Size: 0x28
function hidesecretstashhudfromplayer( player )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    game_utility::questcircle_hidefromplayer( player );
    player br_quest_util::uiobjectivehide();
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0x733fb1bd, Offset: 0xd94
// Size: 0x8c
function deletesecretstashhud()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    foreach ( player in self.playerlist )
    {
        hidesecretstashhudfromplayer( player );
    }
    
    game_utility::questcircle_delete();
}

// Namespace br_secretstash_quest
// Params 6
// Checksum 0x9bae80cb, Offset: 0xe28
// Size: 0x232
function secretstashlootcacheused( instance, part, state, player, bautouse, usestring )
{
    if ( player utility::callsharedfunc( #"gametype", #"hash_673db8bb5562ee19", instance ) )
    {
        return;
    }
    
    assert( part == "<dev string:x106>" );
    
    if ( state == "secretstash_closed" && isdefined( instance.entity ) )
    {
        questinstance = instance.entity.questinstance;
        
        if ( player.team != questinstance.team )
        {
            player iprintlnbold( "Chest Requires a Scavenger Mission" );
            return;
        }
        
        instance setscriptablepartstate( "body", "secretstash_opening" );
        var_e80d80736b232376 = getdvarint( @"hash_3b1ec176d14497ea", 30 );
        instance.entity utility::delaycallendon( var_e80d80736b232376, "death_or_disconnect", &delete );
        questinstance br_quest_util::givequestrewardgroup( "secretstash", player.team, instance.origin, instance.angles, questinstance.rewardscriptable );
        questinstance.rewardorigin = instance.origin;
        questinstance.rewardangles = instance.angles;
        questinstance completesecretstashquest( instance.entity );
        level notify( "lootcache_opened_kill_callout" + instance.origin );
        playersquad = teams::getfriendlyplayers( player.team, 0 );
        
        foreach ( teammate in playersquad )
        {
            teammate notify( #"hash_fe8368d98cacf961" );
        }
    }
}

// Namespace br_secretstash_quest
// Params 1
// Checksum 0xb4fa2bfb, Offset: 0x1062
// Size: 0xa1
function completesecretstashquest( chest )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    params = spawnstruct();
    params.packedbits = 0;
    br_quest_util::displayteamsplash( self.team, "br_secretstash_quest_complete", params );
    level thread br_public::brleaderdialogteam( "mission_scav_success", self.team, 1, 1 );
    self.rewardorigin = chest.origin;
    self.rewardangles = chest.angles;
    self.result = "success";
    br_quest_util::removequestinstance();
}

// Namespace br_secretstash_quest
// Params 0
// Checksum 0xe49dc75d, Offset: 0x110b
// Size: 0x4e
function failsecretstashquest()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    br_quest_util::displayteamsplash( self.team, "br_scavenger_quest_circle_failure" );
    level thread br_public::brleaderdialogteam( "mission_obj_circle_fail", self.team, 1 );
    self.result = "fail";
    br_quest_util::removequestinstance();
}

