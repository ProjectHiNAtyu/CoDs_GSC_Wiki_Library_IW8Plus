// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    var_0[0] = "sd";
    var_0[1] = "bombzone";
    var_0[2] = "blocker";
    scripts\mp\gameobjects::main( var_0 );

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
    }
    else
    {
        scripts\mp\utility\game::registerroundswitchdvar( scripts\mp\utility\game::getgametype(), 3, 0, 12 );
        scripts\mp\utility\game::registertimelimitdvar( scripts\mp\utility\game::getgametype(), 150 );
        scripts\mp\utility\game::registerscorelimitdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerroundlimitdvar( scripts\mp\utility\game::getgametype(), 0 );
        scripts\mp\utility\game::registerwinlimitdvar( scripts\mp\utility\game::getgametype(), 4 );
        scripts\mp\utility\game::registernumlivesdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerhalftimedvar( scripts\mp\utility\game::getgametype(), 0 );
        scripts\mp\utility\game::registerwinbytwoenableddvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerwinbytwomaxroundsdvar( scripts\mp\utility\game::getgametype(), 4 );
        scripts\mp\utility\game::registerdogtagsenableddvar( scripts\mp\utility\game::getgametype(), 1 );
    }

    updategametypedvars();
    level.laststandrequiresmelee = getdvarint( "scr_laststand_melee", 0 );
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.onprecachegametype = ::onprecachegametype;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.modeonspawnplayer = ::onspawnplayer;
    level.onplayerkilled = ::onplayerkilled;
    level.ondeadevent = ::ondeadevent;
    level.ononeleftevent = ::ononeleftevent;
    level.ontimelimit = ::ontimelimit;
    level.onnormaldeath = ::onnormaldeath;
    level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
    level.onobjectivecomplete = ::onbombexploded;
    level.resetuiomnvargamemode = scripts\mp\gametypes\obj_bombzone.gsc::resetuiomnvargamemode;
    level.allowlatecomers = 0;
    level.bombsplanted = 0;
    level.nofriendlytags = 1;
    level.aplanted = 0;
    level.bplanted = 0;
    game["dialog"]["gametype"] = "gametype_snr";

    if ( getdvarint( "OSMSLRTOP" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "NOSLRNTRKL" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];

    game["dialog"]["offense_obj"] = "obj_destroy";
    game["dialog"]["defense_obj"] = "obj_defend";
    game["dialog"]["bomb_achieve"] = "bomb_achieve";
    game["dialog"]["bomb_taken"] = "bomb_taken";
    game["dialog"]["bomb_lost"] = "bomb_enemyowns";
    game["dialog"]["bomb_defused"] = "bomb_defused";
    game["dialog"]["bomb_planted"] = "bomb_planted";
    game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
    game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
    game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
    game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
    game["dialog"]["kill_confirmed"] = "kill_confirmed";
    game["dialog"]["lastalive_revive"] = "lastalive_revive";
    setomnvar( "ui_bomb_timer_endtime_a", 0 );
    setomnvar( "ui_bomb_timer_endtime_b", 0 );
    setomnvar( "ui_bomb_planted_a", 0 );
    setomnvar( "ui_bomb_planted_b", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    level.conf_fx["vanish"] = loadfx( "vfx/core/impacts/small_snowhit" );
    level thread laststandmonitor();
}

initializematchrules()
{
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_sr_bombtimer", getmatchrulesdata( "bombData", "bombTimer" ) );
    setdynamicdvar( "scr_sr_planttime", getmatchrulesdata( "bombData", "plantTime" ) );
    setdynamicdvar( "scr_sr_defusetime", getmatchrulesdata( "bombData", "defuseTime" ) );
    setdynamicdvar( "scr_sr_multibomb", getmatchrulesdata( "bombData", "multiBomb" ) );
    setdynamicdvar( "scr_sr_silentPlant", getmatchrulesdata( "bombData", "silentPlant" ) );
    setdynamicdvar( "scr_sr_halftime", 0 );
    scripts\mp\utility\game::registerhalftimedvar( "sr", 0 );
    setdynamicdvar( "scr_sr_promode", 0 );
}

onprecachegametype()
{
    game["bomb_dropped_sound"] = "mp_war_objective_lost";
    game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

onstartgametype()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    setclientnamemode( "manual_change" );
    level._effect["bomb_explosion"] = loadfx( "vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx" );
    level._effect["vehicle_explosion"] = loadfx( "vfx/core/expl/small_vehicle_explosion_new.vfx" );
    level._effect["building_explosion"] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    scripts\mp\utility\game::setobjectivetext( game["attackers"], &"OBJECTIVES/SD_ATTACKER" );
    scripts\mp\utility\game::setobjectivetext( game["defenders"], &"OBJECTIVES/SD_DEFENDER" );

    if ( level.splitscreen )
    {
        scripts\mp\utility\game::setobjectivescoretext( game["attackers"], &"OBJECTIVES/SD_ATTACKER" );
        scripts\mp\utility\game::setobjectivescoretext( game["defenders"], &"OBJECTIVES/SD_DEFENDER" );
    }
    else
    {
        scripts\mp\utility\game::setobjectivescoretext( game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE" );
        scripts\mp\utility\game::setobjectivescoretext( game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE" );
    }

    scripts\mp\utility\game::setobjectivehinttext( game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT" );
    scripts\mp\utility\game::setobjectivehinttext( game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT" );
    initspawns();
    level.dogtagallyonusecb = ::dogtagallyonusecb;
    setspecialloadout();
    thread bombs();
}

initspawns()
{
    scripts\mp\spawnlogic::setactivespawnlogic( "SearchAndRescue", "Crit_Frontline" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
    scripts\mp\spawnlogic::addspawnpoints( "attacker", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "attacker", "mp_tdm_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::addspawnpoints( "defender", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "defender", "mp_tdm_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::registerspawnpoints( "normal", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::registerspawnpoints( "fallback", "mp_tdm_spawn_secondary" );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

getspawnpoint()
{
    var_0 = "defender";

    if ( self.pers["team"] == game["attackers"] )
        var_0 = "attacker";

    if ( scripts\mp\spawnlogic::shoulduseteamstartspawn() )
    {
        var_1 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_" + var_0 );
        var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn( var_1 );
    }
    else
        var_2 = scripts\mp\spawnlogic::getspawnpoint( self, self.pers["team"], "normal", "fallback" );

    return var_2;
}

onspawnplayer()
{
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;

    if ( level.multibomb && self.pers["team"] == game["attackers"] )
        self setclientomnvar( "ui_carrying_bomb", 1 );
    else
    {
        self setclientomnvar( "ui_carrying_bomb", 0 );

        foreach ( var_1 in level.objectives )
            var_1.trigger disableplayeruse( self );
    }

    level notify( "spawned_player" );

    if ( scripts\mp\utility\teams::isgameplayteam( self.sessionteam ) )
    {
        level notify( "sr_player_joined", self );
        scripts\mp\utility\stats::setextrascore0( 0 );

        if ( isdefined( self.pers["plants"] ) )
            scripts\mp\utility\stats::setextrascore0( self.pers["plants"] );

        scripts\mp\utility\stats::setextrascore1( 0 );

        if ( isdefined( self.pers["rescues"] ) )
            scripts\mp\utility\stats::setextrascore1( self.pers["rescues"] );
    }
}

laststandmonitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        waitframe();
        level thread laststandkillteamifdown();
    }
}

laststandkillteamifdown()
{
    var_0 = [];

    foreach ( var_2 in level.teamnamelist )
    {
        var_0[var_2] = [];
        var_3[var_2] = 0;
    }

    foreach ( var_2 in level.teamnamelist )
    {
        var_6 = scripts\mp\utility\teams::getteamdata( var_2, "players" );
        var_3 = 0;
        var_0 = [];

        foreach ( var_8 in var_6 )
        {
            if ( scripts\mp\utility\player::isreallyalive( var_8 ) )
            {
                var_3++;

                if ( istrue( var_8.inlaststand ) )
                    var_0[var_0.size] = var_8;
            }
        }

        if ( var_0.size > 0 && var_3 <= var_0.size )
        {
            level.laststandrequiresmelee = 0;

            foreach ( var_8 in var_0 )
                var_8 suicide();
        }
    }
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    thread checkallowspectating();
}

checkallowspectating()
{
    waitframe();
    var_0 = 0;

    if ( !scripts\mp\utility\teams::getteamdata( game["attackers"], "aliveCount" ) )
    {
        level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( !scripts\mp\utility\teams::getteamdata( game["defenders"], "aliveCount" ) )
    {
        level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( var_0 )
        scripts\mp\spectating::updatespectatesettings();
}

sd_endgame( var_0, var_1 )
{
    setomnvarforallclients( "ui_objective_state", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    thread scripts\mp\gamelogic::endgame( var_0, var_1 );
}

ondeadevent( var_0 )
{
    if ( level.bombexploded > 0 || level.bombdefused )
        return;

    if ( var_0 == "all" )
    {
        if ( level.bombplanted )
            sd_endgame( game["attackers"], game["end_reason"][tolower( game[game["defenders"]] ) + "_eliminated"] );
        else
            sd_endgame( game["defenders"], game["end_reason"][tolower( game[game["attackers"]] ) + "_eliminated"] );
    }
    else if ( var_0 == game["attackers"] )
    {
        if ( level.bombplanted )
            return;

        level thread sd_endgame( game["defenders"], game["end_reason"][tolower( game[game["attackers"]] ) + "_eliminated"] );
    }
    else if ( var_0 == game["defenders"] )
        level thread sd_endgame( game["attackers"], game["end_reason"][tolower( game[game["defenders"]] ) + "_eliminated"] );
}

ononeleftevent( var_0 )
{
    if ( level.bombexploded > 0 || level.bombdefused )
        return;

    var_1 = scripts\mp\utility\game::getlastlivingplayer( var_0 );
    var_1 thread givelastonteamwarning();
}

onnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    scripts\mp\gametypes\common.gsc::oncommonnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 );
    var_6 = scripts\mp\rank::getscoreinfovalue( "kill" );
    var_7 = var_0.team;

    if ( var_0.isplanting )
    {
        thread scripts\common\utility::_id_12ED6( level.stadium_puzzle, var_2, "planting" );
        var_1 scripts\mp\utility\stats::incpersstat( "defends", 1 );
        var_1 scripts\mp\persistence::statsetchild( "round", "defends", var_1.pers["defends"] );
    }
    else if ( var_0.isbombcarrier )
        thread scripts\common\utility::_id_12ED6( level.stadium_puzzle, var_2, "carrying" );
    else if ( var_0.isdefusing )
    {
        thread scripts\common\utility::_id_12ED6( level.stadium_puzzle, var_2, "defusing" );
        var_1 scripts\mp\utility\stats::incpersstat( "defends", 1 );
        var_1 scripts\mp\persistence::statsetchild( "round", "defends", var_1.pers["defends"] );
    }

    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_awardgenericbombzonemedals( var_1, var_0 );
}

givelastonteamwarning()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    scripts\mp\utility\player::waittillrecoveredhealth( 3 );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "inform_last_one" );
    var_0 = scripts\mp\utility\game::getotherteam( self.pers["team"] )[0];
    level thread scripts\mp\hud_util::teamplayercardsplash( "callout_lastteammemberalive", self, self.pers["team"] );
    level thread scripts\mp\hud_util::teamplayercardsplash( "callout_lastenemyalive", self, var_0 );

    foreach ( var_2 in level.players )
    {
        if ( var_2.pers["team"] == self.pers["team"] )
        {
            if ( isdefined( var_2.tagavailable ) && var_2.tagavailable )
                level.nofriendlytags = 0;
        }
    }

    level notify( "last_alive", self );
}

ontimelimit()
{
    sd_endgame( game["defenders"], game["end_reason"]["time_limit_reached"] );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.bombplantweapon ) )
        {
            var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon( var_1.bombplantweapon );
            break;
        }
    }
}

updategametypedvars()
{
    scripts\mp\gametypes\common.gsc::updatecommongametypedvars();
    level.planttime = scripts\mp\utility\dvars::dvarfloatvalue( "planttime", 5, 0, 20 );
    level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue( "bombtimer", 45, 1, 300 );
    level.multibomb = scripts\mp\utility\dvars::dvarintvalue( "multibomb", 0, 0, 1 );
    level.silentplant = scripts\mp\utility\dvars::dvarintvalue( "silentPlant", 0, 0, 1 );
}

removebombzonec( var_0 )
{
    var_1 = [];
    var_2 = getentarray( "script_brushmodel", "classname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.script_gameobjectname ) && var_4.script_gameobjectname == "bombzone" )
        {
            foreach ( var_6 in var_0 )
            {
                if ( distance( var_4.origin, var_6.origin ) < 100 && issubstr( tolower( var_6.script_label ), "c" ) )
                {
                    var_6.relatedbrushmodel = var_4;
                    var_1[var_1.size] = var_6;
                    break;
                }
            }
        }
    }

    foreach ( var_10 in var_1 )
    {
        var_10.relatedbrushmodel delete();
        var_11 = getentarray( var_10.target, "targetname" );

        foreach ( var_13 in var_11 )
            var_13 delete();

        var_10 delete();
    }

    return scripts\engine\utility::array_removeundefined( var_0 );
}

bombs()
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_setupbombcase( "sd_bomb" );
    var_0 = getentarray( "bombzone", "targetname" );
    var_0 = removebombzonec( var_0 );
    level.objectives = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = scripts\mp\gametypes\obj_bombzone.gsc::setupobjective( var_2, 1 );
        var_3.onbeginuse = ::onbeginuse;
        var_3.onenduse = ::onenduse;
        var_3.onuse = ::onuseplantobject;
        level.objectives[var_3.objectivekey] = var_3;
    }
}

onbeginuse( var_0 )
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onbeginuse( var_0 );

    if ( !scripts\mp\gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        if ( level.multibomb )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives["_b"] scripts\mp\gameobjects::allowuse( "none" );
                level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam( "friendly" );
            }
            else
            {
                level.objectives["_a"] scripts\mp\gameobjects::allowuse( "none" );
                level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam( "friendly" );
            }
        }
    }
}

onenduse( var_0, var_1, var_2 )
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onenduse( var_0, var_1, var_2 );

    if ( !scripts\mp\gameobjects::isfriendlyteam( var_1.pers["team"] ) )
    {
        if ( level.multibomb && !var_2 )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives["_b"] scripts\mp\gameobjects::allowuse( "enemy" );
                level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam( "any" );
            }
            else
            {
                level.objectives["_a"] scripts\mp\gameobjects::allowuse( "enemy" );
                level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam( "any" );
            }
        }
    }
}

onuseplantobject( var_0 )
{
    if ( !scripts\mp\gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        foreach ( var_2 in level.objectives )
        {
            if ( var_2 == self )
                continue;

            var_2 scripts\mp\gameobjects::disableobject();
        }
    }

    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onuseplantobject( var_0 );
}

onbombexploded( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_3 == game["attackers"] )
    {
        setgameendtime( 0 );
        wait 3;
        sd_endgame( game["attackers"], game["end_reason"]["target_destroyed"] );
    }
    else
    {
        wait 1.5;
        setgameendtime( 0 );
        sd_endgame( game["defenders"], game["end_reason"]["bomb_defused"] );
    }
}

setspecialloadout()
{
    if ( isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", game["attackers"], 5, "class", "inUse" ) )
        level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass( game["attackers"], 5 );
}

dogtagallyonusecb( var_0 )
{
    var_0 scripts\mp\utility\stats::setextrascore1( var_0.pers["rescues"] );
}
