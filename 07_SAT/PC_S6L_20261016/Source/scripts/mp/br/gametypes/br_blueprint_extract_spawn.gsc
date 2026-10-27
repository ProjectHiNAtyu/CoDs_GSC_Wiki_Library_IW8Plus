// scripts\mp\br\gametypes\br_blueprint_extract_spawn.gsc  (hash_0354c6d52f9c837f.gscc) (size: 2844 Bytes / 0xb1c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51c446e1 (1371817697)
// size ...... 2844 (0xb1c)
// includes .. 9   (offset: 0xa88)
// strings ... 6   (offset: 0xad0)
// dev strs .. 0   (offset: 0xb1c)
// exports ... 9   (offset: 0x60c)
// cseg ...... 0xd3 + 0x539 (0x60c)
// imports ... 27  (offset: 0x774)
// animtree1 . 0   (offset: 0xb1c)
// animtree2 . 0   (offset: 0xb1c)
#using scripts\mp\br\gametypes\br_extract_quest;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_blueprint_extract_spawn;

// Namespace br_blueprint_extract_spawn
// Params 0
// Checksum 0xe5c8b01d, Offset: 0xf1
// Size: 0x197
function init()
{
    level.blueprint_maxpermatch = undefined;
    level.blueprint_chancebase = undefined;
    level.blueprint_chancepercontract = undefined;
    gametype = game_utility::getgametype();
    
    if ( gametype == "plunder" || gametype == "risk" )
    {
        level.blueprint_maxpermatch = getdvarfloat( @"scr_blueprint_plunder_maxpermatch", 4 );
        level.blueprint_chancebase = getdvarfloat( @"scr_blueprint_plunder_chancebase", 0.02 );
        level.blueprint_chancepercontract = getdvarfloat( @"scr_blueprint_plunder_chancepercontract", 0 );
    }
    else
    {
        level.blueprint_maxpermatch = getdvarfloat( @"scr_blueprint_br_maxpermatch", 4 );
        level.blueprint_chancebase = getdvarfloat( @"scr_blueprint_br_chancebase", 0.02 );
        level.blueprint_chancepercontract = getdvarfloat( @"scr_blueprint_br_chancepercontract", 0 );
    }
    
    level.blueprintextractspawns = 0;
    level.blueprintextractchance = level.blueprint_chancebase;
    level.blueprintcreatingteam = undefined;
    
    foreach ( unlockabledata in level.questinfo.unlockables )
    {
        br_pickups::registerpickupcreatedcallback( "brloot_blueprintextract_tablet", &blueprintextract_onpickupcreated );
    }
}

// Namespace br_blueprint_extract_spawn
// Params 1
// Checksum 0xf2af157f, Offset: 0x290
// Size: 0x8c
function blueprintextract_trygetreward( rewardorigin )
{
    if ( !blueprintextract_shouldgivereward( rewardorigin ) )
    {
        return;
    }
    
    if ( level.blueprintextractspawns >= level.blueprint_maxpermatch )
    {
        return;
    }
    
    randomvalue = randomfloat( 1 );
    
    if ( randomvalue <= level.blueprintextractchance )
    {
        level.blueprintextractspawns += 1;
        return "brloot_blueprintextract_tablet";
    }
    
    level.blueprintextractchance += level.blueprint_chancepercontract;
    return;
}

// Namespace br_blueprint_extract_spawn
// Params 1
// Checksum 0xd7f4ddc8, Offset: 0x324
// Size: 0xd4, Type: bool
function blueprintextract_shouldgivereward( rewardorigin )
{
    if ( br_public::isanytutorialorbotpracticematch() )
    {
        return false;
    }
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        return false;
    }
    
    if ( level.bmoovertime )
    {
        return false;
    }
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && isdefined( level.br_level ) && isdefined( level.br_level.br_circleclosetimes ) )
    {
        currentcircleindex = level.br_circle.circleindex;
        finalcircleindex = level.br_level.br_circleclosetimes.size - 1;
        
        if ( finalcircleindex - currentcircleindex < 4 )
        {
            return false;
        }
    }
    
    if ( !br_extract_quest::extractlocale_islocaleavailable( rewardorigin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_blueprint_extract_spawn
// Params 1
// Checksum 0xae11dcfe, Offset: 0x401
// Size: 0x17
function blueprintextract_beforepickupspawned( team )
{
    level.blueprintcreatingteam = team;
}

// Namespace br_blueprint_extract_spawn
// Params 0
// Checksum 0x1fb23e40, Offset: 0x420
// Size: 0x2b
function blueprintextract_onpickupcreated()
{
    randomlootid = br_quest_util::getrandomextractunlockablelootid();
    blueprintextract_setunlockablelootid( randomlootid );
    thread blueprintextract_createtempobjective();
    thread blueprintextract_cleanupwhennoavailablelocales();
}

// Namespace br_blueprint_extract_spawn
// Params 1
// Checksum 0x9d88a650, Offset: 0x453
// Size: 0x21
function blueprintextract_setunlockablelootid( unlockablelootid )
{
    common_item::items_setitemcount( self, unlockablelootid );
    self.extractunlockablelootid = unlockablelootid;
}

// Namespace br_blueprint_extract_spawn
// Params 0
// Checksum 0xcc1564de, Offset: 0x47c
// Size: 0x162
function blueprintextract_createtempobjective()
{
    creatingteam = level.blueprintcreatingteam;
    level.blueprintcreatingteam = undefined;
    
    if ( !isdefined( creatingteam ) )
    {
        return;
    }
    
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "invisible", ( 0, 0, 0 ), "ui_mp_br_mapmenu_icon_extraction_objective" );
        objidpoolmanager::objective_set_play_intro( objectiveiconid, 1 );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        
        foreach ( player in teams::getteamdata( creatingteam, "players" ) )
        {
            if ( !player br_public::isplayeringulag() )
            {
                objective_addclienttomask( objectiveiconid, player );
            }
        }
    }
    
    starttime = gettime();
    
    while ( isdefined( self ) && gettime() - starttime < 15000 )
    {
        newpos = self.origin + ( 0, 0, 10 );
        objidpoolmanager::update_objective_position( objectiveiconid, newpos );
        waitframe();
    }
    
    objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    objidpoolmanager::returnobjectiveid( objectiveiconid );
}

// Namespace br_blueprint_extract_spawn
// Params 0
// Checksum 0xd47bc822, Offset: 0x5e6
// Size: 0x26
function blueprintextract_cleanupwhennoavailablelocales()
{
    while ( isdefined( self ) )
    {
        if ( !br_extract_quest::extractlocale_islocaleavailable( self.origin ) )
        {
            pickups::deletescriptableinstance();
            return;
        }
        
        waitframe();
    }
}

