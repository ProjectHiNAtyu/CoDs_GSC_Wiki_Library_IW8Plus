// scripts\mp\br\gametypes\br_extract_quest.gsc  (hash_548141e6b9c99bc2.gscc) (size: 12229 Bytes / 0x2fc5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6229143c (1646859324)
// size ...... 12229 (0x2fc5)
// includes .. 9   (offset: 0x2ca9)
// strings ... 42  (offset: 0x2cf1)
// dev strs .. 2   (offset: 0x2fad)
// exports ... 28  (offset: 0x1b1d)
// cseg ...... 0x476 + 0x16a7 (0x1b1d)
// imports ... 113 (offset: 0x1f7d)
// animtree1 . 0   (offset: 0x2fc5)
// animtree2 . 0   (offset: 0x2fc5)
#using scripts\common\scriptable;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;

#namespace br_extract_quest;

// Namespace br_extract_quest
// Params 0
// Checksum 0x4f7c6796, Offset: 0x494
// Size: 0x2be
function init()
{
    enabled = br_quest_util::registerquestcategory( "blueprintextract", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    br_quest_util::registertabletinit( "blueprintextract", &extracttablet_init );
    br_quest_util::registerremovequestinstance( "blueprintextract", &extractquest_removequestinstance );
    br_quest_util::registerquestlocale( "blueprintextract_locale" );
    br_quest_util::registercreatequestlocale( "blueprintextract_locale", &extractlocale_createquestlocale );
    br_quest_util::registercheckiflocaleisavailable( "blueprintextract_locale", &extractlocale_checkiflocaleisavailable );
    br_quest_util::registerremovequestinstance( "blueprintextract_locale", &extractlocale_removelocaleinstance );
    br_quest_util::registerquestcircletick( "blueprintextract_locale", &extractlocale_circletick );
    br_quest_util::registeronentergulag( "blueprintextract_locale", &extractlocale_onentergulag );
    br_quest_util::registeronrespawn( "blueprintextract_locale", &extractlocale_onrespawn );
    br_quest_util::getquestdata( "blueprintextract_locale" ).nextid = 0;
    br_quest_util::questtimerinit( "blueprintextract", 1 );
    br_quest_util::registerontimerexpired( "blueprintextract", &extract_ontimerexpired );
    
    if ( !level.br_plunder_enabled )
    {
        br_plunder::initheliextractanims();
        br_plunder::inithelipropanims();
        level._effect[ "vfx_extract_smoke" ] = loadfxasset( "vfx_iw8_br_gameplay_adv_supply_drop_marker" );
        br_plunder::plunder_initrepositories();
        br_plunder::inithelirepository();
    }
    
    if ( !br_plunder::isplunderextractionenabled() )
    {
        scriptable::scriptable_addusedcallback( &br_plunder::plundersiteused );
    }
    
    gametype = game_utility::getgametype();
    inplunder = gametype == "plunder" || gametype == "risk";
    level.extractmissionhelipadscriptable = inplunder ? "brloot_quest_extract_site_plunder" : "brloot_quest_extract_site_br";
    level.extractmissionhelipadmodel = inplunder ? "brloot_quest_extract_site_model_plunder" : "brloot_quest_extract_site_model_br";
    level.plunderrepositories.data[ "extractHelipadPlunder" ].prevcallback = level.plunderrepositories.data[ "extractHelipadPlunder" ].usecallback;
    level.plunderrepositories.data[ "extractHelipadPlunder" ].usecallback = &extracthelipadusecallback;
    level.plunderrepositories.data[ "extractHelipadBR" ].prevcallback = level.plunderrepositories.data[ "extractHelipadBR" ].usecallback;
    level.plunderrepositories.data[ "extractHelipadBR" ].usecallback = &extracthelipadusecallback;
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_extract_accept" ] = "bm_exfil_arrived";
    game[ "dialog" ][ "mission_extract_success" ] = "contract_misc_success";
}

// Namespace br_extract_quest
// Params 3
// Checksum 0x87acea00, Offset: 0x75a
// Size: 0xaa
function extracthelipadusecallback( entity, player, amount )
{
    player.lastplunderbankindex = entity.index;
    player notify( #"helideposit" );
    gametype = game_utility::getgametype();
    
    if ( amount > 0 && level.br_plunder_enabled && ( gametype == "plunder" || gametype == "risk" ) )
    {
        [[ level.plunderrepositories.data[ "extractHelipadPlunder" ].prevcallback ]]( entity, player, amount );
    }
}

// Namespace br_extract_quest
// Params 0
// Checksum 0x7fd49b32, Offset: 0x80c
// Size: 0x62
function extractquest_removequestinstance()
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    br_quest_util::releaseteamonquest( self.team );
    br_quest_util::uiobjectivehidefromteam( self.team );
    extractupdatehud( 0, undefined );
    
    if ( isdefined( self.carryingplayer ) )
    {
        self.carryingplayer unsetweaponcarry();
    }
    
    self.subscribedlocale thread extractupdateiconsframeend();
}

// Namespace br_extract_quest
// Params 0
// Checksum 0xa066ae4, Offset: 0x876
// Size: 0x9c
function extractlocale_removelocaleinstance()
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    foreach ( instance in self.subscribedinstances )
    {
        instance thread br_quest_util::removequestinstance();
    }
    
    br_quest_util::deletequestobjicon();
    self.helipadscriptable thread removeextracthelipad();
}

// Namespace br_extract_quest
// Params 0
// Checksum 0xbf725792, Offset: 0x91a
// Size: 0x4c, Type: bool
function extracttablet_init()
{
    /#
        br_quest_util::function_9054d3c68a31b891();
    #/
    
    search_params = getsearchparams( self );
    placement = br_quest_util::findquestplacement( "blueprintextract", search_params );
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    self.reservedplacement = placement;
    return true;
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x906e4314, Offset: 0x96f
// Size: 0x275
function extractlocale_createquestlocale( placement )
{
    /#
        br_quest_util::function_a65f25c1da281772();
    #/
    
    br_quest_util::getquestdata( "blueprintextract_locale" ).nextid++;
    locale = br_quest_util::createlocaleinstance( "blueprintextract_locale", "blueprintextract", "ExtractPoint:" + br_quest_util::getquestdata( "blueprintextract_locale" ).nextid );
    
    if ( !isdefined( placement ) )
    {
        locale.curorigin = ( 0, 0, 0 );
        locale.enabled = 0;
        return locale;
    }
    
    locale.playerlist = teams::getteamdata( self.team, "players" );
    locale.helipad = spawn( "script_model", placement.origin );
    locale.helipad setmodel( level.extractmissionhelipadmodel );
    assert( isdefined( locale.playerlist ) || locale.playerlist.size > 0, "<dev string:x2b>" );
    var_88b519152b97f56a = locale.playerlist[ 0 ];
    locale.helipad setotherent( var_88b519152b97f56a );
    locale.helipad setscriptablepartstate( level.extractmissionhelipadscriptable, "activeCurrent" );
    locale.helipad.forceextractscriptable = 1;
    locale.helipadscriptable = locale.helipad getlinkedscriptableinstance();
    locale.helipadscriptable.activestate = "active";
    locale.helipadscriptable.activecurrstate = "activeCurrent";
    locale.helipadscriptable.disabledstate = "hidden";
    locale.helipadscriptable.disabledcurrstate = "hidden";
    locale.helipadscriptable.questcomplete = 0;
    locale.locationpad = placement;
    locale br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_extraction_objective", "current", placement.origin );
    locale.lastcircletick = -1;
    locale.curorigin = placement.origin;
    br_quest_util::addquestinstance( "blueprintextract_locale", locale );
    return locale;
}

// Namespace br_extract_quest
// Params 1
// Checksum 0xc54fb3d8, Offset: 0xbed
// Size: 0x56, Type: bool
function extractlocale_islocaleavailable( position )
{
    faketablet = spawnstruct();
    faketablet.origin = position;
    search_params = getsearchparams( faketablet );
    placement = br_quest_util::findquestplacement( "blueprintextract", search_params );
    return isdefined( placement );
}

// Namespace br_extract_quest
// Params 0
// Checksum 0x92f3431f, Offset: 0xc4c
// Size: 0x67
function removeextracthelipad()
{
    gametype = game_utility::getgametype();
    
    if ( gametype != "plunder" && gametype != "risk" )
    {
        self setscriptablepartstate( level.extractmissionhelipadscriptable, "hidden" );
    }
    
    if ( isdefined( self.heli ) )
    {
        self waittill( #"hash_9c0cd27aba1401bb" );
    }
    
    self.entity delete();
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x453b6baa, Offset: 0xcbb
// Size: 0x16
function extractlocale_checkiflocaleisavailable( search_params )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
}

// Namespace br_extract_quest
// Params 2
// Checksum 0xd44271f9, Offset: 0xcd9
// Size: 0x130
function extractlocale_circletick( dangercircleorigin, dangercircleradius )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    if ( !isdefined( self.helipad ) )
    {
        return;
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
            br_quest_util::displayteamsplash( instance.team, "br_blueprint_extract_quest_circle_failure" );
            level thread br_public::brleaderdialogteam( "mission_obj_circle_fail", instance.team, 1 );
            instance.result = "circle";
        }
        
        br_quest_util::removequestinstance();
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x34cec51d, Offset: 0xe11
// Size: 0x1f
function extractlocale_onentergulag( player )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    extracthideiconfromplayer( player );
}

// Namespace br_extract_quest
// Params 1
// Checksum 0xbb546adf, Offset: 0xe38
// Size: 0x43
function extractlocale_onrespawn( player )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    if ( player.team == self.subscribedinstances[ 0 ].team )
    {
        extractshowicontoplayer( player );
    }
}

// Namespace br_extract_quest
// Params 0
// Checksum 0xf505b431, Offset: 0xe83
// Size: 0x12f
function extractupdateicons()
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    objective_showtoplayersinmask( self.objectiveiconid );
    objective_removeallfrommask( self.objectiveiconid );
    
    foreach ( instance in self.subscribedinstances )
    {
        foreach ( player in teams::getteamdata( instance.team, "players" ) )
        {
            if ( !player br_public::isplayeringulag() )
            {
                objective_addclienttomask( self.objectiveiconid, player );
            }
        }
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0xa11b77b5, Offset: 0xfba
// Size: 0x26
function extracthideiconfromplayer( player )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    objective_removeclientfrommask( self.objectiveiconid, player );
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x51e80186, Offset: 0xfe8
// Size: 0x26
function extractshowicontoplayer( player )
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    objective_addclienttomask( self.objectiveiconid, player );
}

// Namespace br_extract_quest
// Params 0
// Checksum 0x4317d1f2, Offset: 0x1016
// Size: 0x20
function extractupdateiconsframeend()
{
    /#
        br_quest_util::function_984e3602904184b7();
    #/
    
    self endon( #"removed" );
    waittillframeend();
    extractupdateicons();
}

// Namespace br_extract_quest
// Params 2
// Checksum 0x96790b85, Offset: 0x103e
// Size: 0x101
function extractupdatehud( var_ac616d89972a4732, carryingplayer )
{
    carryingplayernum = 0;
    lootid = -1;
    
    if ( var_ac616d89972a4732 )
    {
        carryingplayernum = carryingplayer getentitynumber();
        lootid = self.extractunlockablelootid;
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player br_quest_util::uiobjectivesetparameter( carryingplayernum );
        player br_quest_util::uiobjectivesetlootid( lootid );
        iscarryingplayer = player == carryingplayer;
        showhudicon = var_ac616d89972a4732 && iscarryingplayer;
        player setclientomnvar( "ui_br_has_extract_bag", showhudicon );
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x4d6f3e5a, Offset: 0x1147
// Size: 0x3fd
function takequestitem( pickupent )
{
    /#
        br_quest_util::function_e4ac44a582699ee0();
    #/
    
    quests = br_quest_util::getallactivequestsforteam( self.team );
    
    if ( quests.size > 0 )
    {
        foreach ( quest in quests )
        {
            quest.instance br_quest_util::removequestinstance();
        }
    }
    
    instance = br_quest_util::createquestinstance( "blueprintextract", self.team, pickupent.index, pickupent );
    instance br_quest_util::registerteamonquest( self.team, self );
    instance.team = self.team;
    instance.tablet = pickupent;
    instance.extractunlockablelootid = pickupent.extractunlockablelootid;
    questtime = getdvarint( @"hash_244206ce2e68a9d8", 240 );
    instance br_quest_util::questtimerset( questtime, 4 );
    search_params = getsearchparams( pickupent );
    locale = instance br_quest_util::requestquestlocale( "blueprintextract_locale", search_params, 1 );
    
    if ( !locale.enabled )
    {
        instance.result = "no_locale";
        instance br_quest_util::releaseteamonquest( self.team );
        return;
    }
    
    locale extractupdateicons();
    br_quest_util::uiobjectiveshowtoteam( "blueprintextract", self.team );
    br_quest_util::addquestinstance( "blueprintextract", instance );
    br_quest_util::startteamcontractchallenge( "blueprintextract", self, self.team );
    
    if ( !level.br_plunder_enabled )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            player.plundercount = 0;
        }
    }
    
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self;
    params.plundervar = br_quest_util::getquestplunderreward( "blueprintextract", br_quest_util::getquestrewardtier( self.team ) );
    br_quest_util::displayteamsplash( self.team, "br_blueprint_extract_quest_start_team", params );
    br_quest_util::displayplayersplash( self, "br_blueprint_extract_quest_start_tablet_finder", params );
    br_quest_util::displaysquadmessagetoteam( instance.team, self, 6, br_quest_util::getquestindex( "blueprintextract" ) );
    level thread br_public::brleaderdialogteam( "mission_extract_accept", instance.team, 1 );
    setweaponcarry( locale, pickupent.extractunlockablelootid );
    instance.carryingplayer = self;
    
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            locale.helipadscriptable disablescriptablepartplayeruse( level.extractmissionhelipadscriptable, player );
        }
    }
    
    instance extractupdatehud( 1, self );
    instance thread watchweapondeathordisconnect( self );
    instance thread watchfordeposit( self );
}

// Namespace br_extract_quest
// Params 2
// Checksum 0xf086cb9d, Offset: 0x154c
// Size: 0x57
function setweaponcarry( locale, unlockablelootid )
{
    self.extractquest_alwaysallowdeposit = 1;
    self.extractquest_helipadid = locale.helipadscriptable.index;
    self.extractquest_missionitem = "brloot_blueprintextract_tablet";
    self.extractquest_unlockablelootid = unlockablelootid;
}

// Namespace br_extract_quest
// Params 0
// Checksum 0x7726bacd, Offset: 0x15ab
// Size: 0x2a
function unsetweaponcarry()
{
    self.extractquest_alwaysallowdeposit = undefined;
    self.extractquest_helipadid = undefined;
    self.extractquest_missionitem = undefined;
    self.extractquest_unlockablelootid = undefined;
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x49a6a67d, Offset: 0x15dd
// Size: 0x7c
function extract_removemissionweapon( quest )
{
    if ( self hasweapon( quest.weapon ) )
    {
        fists = level.defaultfist;
        switchto = inventory_utility::iscurrentweapon( quest.weapon );
        inventory_utility::_takeweapon( quest.weapon );
        inventory_utility::_giveweapon( fists, undefined, undefined, 1 );
        
        if ( switchto )
        {
            inventory_utility::_switchtoweaponimmediate( fists );
        }
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x964ee137, Offset: 0x1661
// Size: 0x28, Type: bool
function extract_ismissionweapon( weapon )
{
    if ( !isdefined( self.extractquest_missionweapon ) )
    {
        return false;
    }
    
    return self.extractquest_missionweapon == weapon;
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x907824e4, Offset: 0x1692
// Size: 0x8b
function watchweapondeathordisconnect( player )
{
    self endon( #"removed" );
    team = player.team;
    
    while ( true )
    {
        player waittill( #"death_or_disconnect" );
        level thread br_public::brleaderdialogteam( "br_blueprint_extract_quest_failure", team, 1, 1 );
        br_quest_util::displayteamsplash( team, "br_blueprint_extract_quest_failure" );
        
        if ( isdefined( player ) )
        {
            player unsetweaponcarry();
        }
        
        self.result = "fail";
        thread br_quest_util::removequestinstance();
        return;
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x2fbcea35, Offset: 0x1725
// Size: 0x217
function watchfordeposit( player )
{
    self endon( #"removed" );
    
    while ( true )
    {
        player waittill( #"helideposit" );
        
        if ( player.lastplunderbankindex == self.subscribedlocale.helipadscriptable.index )
        {
            unlockref = "blueprint_unlock_" + self.extractunlockablelootid;
            optionalnumber = br_quest_util::getquestunlockableindexfromlootid( self.extractunlockablelootid );
            
            foreach ( teammate in teams::getteamdata( self.team, "players" ) )
            {
                challenges::function_37e945722d6497f3( teammate, unlockref );
                
                if ( optionalnumber > 0 )
                {
                    teammate thread hud_message::showsplash( "br_unlockable_weapon_splash", optionalnumber );
                }
            }
            
            self.subscribedlocale.helipadscriptable.questcomplete = 1;
            br_quest_util::displaysquadmessagetoteam( self.team, player, 8, br_quest_util::getquestindex( "blueprintextract" ) );
            displaydelayedmissioncompletesplash( player );
            missionid = br_quest_util::getquestindex( "blueprintextract" );
            br_quest_util::displaysquadmessagetoteam( self.team, player, 8, missionid );
            level thread br_public::brleaderdialogteam( "mission_extract_success", self.team, 1, 1 );
            self.rewardorigin = self.subscribedlocale.helipad.origin;
            self.rewardangles = self.subscribedlocale.helipad.angles;
            self.result = "success";
            thread br_quest_util::removequestinstance();
            return;
        }
    }
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x36b01701, Offset: 0x1944
// Size: 0xc8
function displaydelayedmissioncompletesplash( player )
{
    level endon( #"game_ended" );
    team = self.team;
    params = spawnstruct();
    rewardtier = br_quest_util::getquestrewardtier( player.team );
    missionid = br_quest_util::getquestindex( "blueprintextract" );
    rewardindex = br_quest_util::getquestrewardgroupindex( br_quest_util::getquestrewardbuildgroupref( "blueprintextract" ) );
    unlockableindex = br_quest_util::getquestunlockableindexfromlootid( self.extractunlockablelootid );
    params.packedbits = br_quest_util::packsplashparambits( missionid, rewardtier, rewardindex, unlockableindex );
    waitframe();
    br_quest_util::displayteamsplash( team, "br_blueprint_extract_quest_complete", params );
}

// Namespace br_extract_quest
// Params 1
// Checksum 0x83601afb, Offset: 0x1a14
// Size: 0xd1
function getsearchparams( tablet )
{
    search_params = spawnstruct();
    search_params.searchfunc = "getInactiveHelipads";
    search_params.searchcircleorigin = ( tablet.origin[ 0 ], tablet.origin[ 1 ], 0 );
    search_params.searchradiusmax = 30000;
    search_params.searchradiusmin = 0;
    search_params.searchradiusidealmax = getdvarint( @"hash_3f4a769b64c24a7d", 20000 );
    search_params.searchradiusidealmin = getdvarint( @"hash_51284059de901d6f", 15000 );
    search_params.searchforcecirclecenter = 1;
    search_params.reservedplacement = tablet.reservedplacement;
    return search_params;
}

// Namespace br_extract_quest
// Params 0
// Checksum 0x6a4f159e, Offset: 0x1aee
// Size: 0x2f
function extract_ontimerexpired()
{
    br_quest_util::displayteamsplash( self.team, "br_blueprint_extract_quest_timer_expired" );
    level thread br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
}

