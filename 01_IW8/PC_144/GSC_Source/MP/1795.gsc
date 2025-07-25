// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !isdefined( level.petconsts ) && !scripts\common\utility::iscp() )
        level thread brking_watchcircletimers();

    level.petconsts = [];
    var_0 = 0;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/petWatchTable.csv", var_0, 1 );

        if ( !isdefined( var_1 ) || var_1 == "" )
            break;

        var_1 = int( var_1 );
        var_2 = spawnstruct();
        var_2.phasetime = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 2 ) );
        var_2.bonustimemax = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 3 ) );
        var_2.boredomrate = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 4 ) );
        var_2.dirtyrate = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 5 ) );
        var_2.unrulyrate = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 6 ) );
        var_2.hungryrate = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 7 ) );
        var_2.bonustype = tablelookupbyrow( "mp/petWatchTable.csv", var_0, 8 );
        var_2.boredstart = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 9 ) );
        var_2.dirtystart = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 10 ) );
        var_2.unrulystart = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 11 ) );
        var_2.hungrystart = int( tablelookupbyrow( "mp/petWatchTable.csv", var_0, 12 ) );
        level.petconsts[var_1] = var_2;
        var_0++;
    }

    level.vehiclespawn_littlebirdmg = [];
    level.vehiclespawn_littlebirdmg["assist"] = 1;
    level.vehiclespawn_littlebirdmg["longshot"] = 1;
    level.vehiclespawn_littlebirdmg["pointblank"] = 1;
    level.vehiclespawn_littlebirdmg["headshot"] = 1;
    level.vehiclespawn_littlebirdmg["avenger"] = 1;
    level.vehiclespawn_littlebirdmg["save_teammate"] = 1;
    level.vehiclespawn_littlebirdmg["posthumous"] = 1;
    level.vehiclespawn_littlebirdmg["revenge"] = 1;
    level.vehiclespawn_littlebirdmg["firstblood"] = 1;
    level.vehiclespawn_littlebirdmg["comeback"] = 1;
    level.vehiclespawn_littlebirdmg["backfire"] = 1;
    level.vehiclespawn_littlebirdmg["quad_feed"] = 1;
    level.vehiclespawn_littlebirdmg["first_place_kill"] = 1;
    level.vehiclespawn_littlebirdmg["gun_butt"] = 1;
    level.vehiclespawn_littlebirdmg["mode_x_wipeout"] = 1;
    level.vehiclespawn_littlebirdmg["grenade_double"] = 1;
}

brking_watchcircletimers()
{
    level endon( "game_ended" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( isdefined( var_1.petwatch ) )
                var_1 feedaction();
        }

        wait 1;
    }
}

setstate( var_0, var_1 )
{
    self setclientomnvar( "ui_pet_watch_action", var_0 * -1 );
    self.petwatch.phase = var_0;
    updateuistate();
}

doaction( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            growpet();
            break;
        case 2:
            feedaction();
            break;
        case 3:
            thread updatepetstatesincelastupdate();
            break;
        case 4:
            initpet( 1 );
            break;
        case 6:
            initpet( 1, "pet_black" );
            break;
        case 5:
            initpet( 1, "pet_turbo" );
            break;
        case 7:
            initpet( 1, "pet_turbo", 1 );
            break;
    }
}

growpet()
{
    var_0 = level.petconsts[self.petwatch.phase].phasetime;
    self.petwatch.growthtime = var_0;
    debugsetlasttime( var_0 );
}

unmarkplayeraseliminated()
{
    self.petwatch = undefined;
}

_id_12EFD()
{
    self endon( "disconnect" );
    self notify( "turboPetChallengeWatcher()" );
    self endon( "turboPetChallengeWatcher()" );

    for (;;)
    {
        self waittill( "luinotifyserver", var_0, var_1 );

        if ( var_0 == "petwatch_turbo_grow" )
        {
            switch ( var_1 )
            {
                case 1:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_egg" );
                    break;
                case 2:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_baby" );
                    break;
                case 3:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_child" );
                    break;
                case 4:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_teen_a" );
                    break;
                case 5:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_teen_b" );
                    break;
                case 6:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_skunk" );
                    break;
                case 7:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_bear" );
                    break;
                case 8:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_mantis" );
                    break;
                case 9:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_trex" );
                    break;
                case 10:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_octopus" );
                    break;
                case 11:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_fox" );
                    break;
                case 12:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret1" );
                    break;
                case 13:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret2" );
                    break;
                case 14:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret3" );
                    break;
                default:
                    break;
            }

            continue;
        }

        if ( var_0 == "petwatch_turbo_state" )
            self setclientomnvar( "ui_pet_watch_state", var_1 );
    }
}

initpet( var_0, var_1, var_2 )
{
    if ( !isdefined( self.petwatch ) )
    {
        self setclientomnvar( "ui_pet_watch_state", 0 );
        self.petwatch = spawnstruct();
        self.petwatch.vehomn_fadeoutcontrolsforclient = var_1;

        if ( var_1 == "pet_black" )
            self.petwatch.weapon_xp_iw8_knife = "petWatchDataBlack";
        else if ( var_1 == "pet_turbo" )
        {
            self.petwatch.weapon_xp_iw8_knife = "petWatchDataTurbo";
            thread _id_12EFD();
        }
        else
            self.petwatch.weapon_xp_iw8_knife = "petWatchData";

        if ( var_0 && !istrue( var_2 ) )
        {
            self setclientomnvar( "ui_pet_watch_action", -1 );
            setphase( 0 );
        }
        else
            setphase( self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "phase" ) );
    }
    else
    {
        if ( var_0 )
        {
            self setclientomnvar( "ui_pet_watch_action", -1 );
            setphase( 0 );
        }

        if ( self.petwatch.phase == 0 )
            resetpet( 1 );

        if ( !istrue( var_0 ) )
            return;
    }

    self.petwatch.getstreamedinplayercount = 0;

    if ( self.petwatch.phase == 0 )
        resetpet( 1 );
    else
    {
        self.petwatch.bonustime = 0;
        self.petwatch.check_for_early_impact = 0;
        self.petwatch.lastupdatetime = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "lastUpdateTime" );
        self.petwatch.bored = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "boredDmg" );
        self.petwatch.dirty = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "dirtyDmg" );
        self.petwatch.unruly = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "unrulyDmg" );
        self.petwatch.hungry = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "hungryDmg" );
        self.petwatch.check_for_early_impact = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "bonusTime" );
        self.petwatch.charged = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "charged" );
        self.petwatch.growthtime = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "growthTime" );
        self.petwatch.reproductionstreak = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "reproductionStreak" );
        self.petwatch.damage = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "damage" );
        self.petwatch.setexfiltimer = self.petwatch.bored;
        self.petwatch.setincomingremovedcallback = self.petwatch.dirty;
        self.petwatch.setup_hacks = self.petwatch.unruly;
        self.petwatch.setnewabilitycount = self.petwatch.hungry;
        var_3 = self.petwatch.reproductionstreak % 10;
        var_4 = var_3 / 10;
        self.petwatch.growthtime = self.petwatch.growthtime + var_4;
        self.petwatch.check_for_early_impact = self.petwatch.check_for_early_impact + var_4;
        self.petwatch.reproductionstreak = int( self.petwatch.reproductionstreak / 10 );
        self.petwatch._id_12FBE = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "orcaPoints" );
        self.petwatch._id_1315F = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "apachePoints" );
        self.petwatch.dragonpoints = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "dragonPoints" );
        self.petwatch.check_for_at_set_final_wave = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "killstreakCharge" );
        self.petwatch.check_for_execution_allows = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "winGamesCharge" );
        self.petwatch.check_for_damage_scalar_change = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "objectiveScoreCharge" );
        self.petwatch.check_dropped_locations_and_offset = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "killsCharge" );
        self.petwatch.topkillstreakcharge = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "topKillstreakCharge" );
        self.petwatch.nukecharge = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "nukeCharge" );
        self.petwatch.wingamestop3 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "winGamesTop3" );
        self.petwatch.plantscharge = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "plantsCharge" );
        self.petwatch.executionscharge = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "executionsCharge" );
        self.petwatch.objectivescorecharge = 0;
        self.petwatch.killstreakcharge = 0;
        self.petwatch.wingamescharge = 0;
        self.petwatch.killscharge = 0;
        self.petwatch.setnewabilityhud = 0;
        self.petwatch.setextractspawninstances = 0;
        self.petwatch.setup_heli_starts = 0;
        self.petwatch.setjailtimeouthud = 0;
    }

    updateuistate();
}

gethours( var_0 )
{
    var_1 = 3600;
    return int( var_0 / var_1 );
}

gethourtime( var_0 )
{
    var_1 = 3600;
    var_2 = 24 * var_1;
    var_3 = var_2 * 365.25;
    var_4 = var_0 / int( var_3 );
    var_5 = int( var_0 % var_3 ) / int( var_2 );
    var_6 = int( var_0 % var_2 ) / int( var_1 );
    return int( var_6 );
}

testtiming()
{
    var_0 = getsystemtime();
    var_1 = var_0 - 300;
    var_2 = var_0 - 7200;
    var_3 = var_0 - 3480;
    var_4 = var_0 - 3720;
    var_5 = var_0 - 43200;
    var_6 = var_0 - 86400;
    var_7 = var_6 - 43200;
    var_8 = var_0 - 604800;
    var_9 = hoursawakesincelastupdate( var_0, var_1 ).plunder_awarded_by_missions_total;
    var_10 = hoursawakesincelastupdate( var_0, var_3 ).plunder_awarded_by_missions_total;
    var_11 = hoursawakesincelastupdate( var_0, var_4 ).plunder_awarded_by_missions_total;
    var_12 = hoursawakesincelastupdate( var_0, var_2 ).plunder_awarded_by_missions_total;
    var_13 = hoursawakesincelastupdate( var_0, var_5 ).plunder_awarded_by_missions_total;
    var_14 = hoursawakesincelastupdate( var_0, var_6 ).plunder_awarded_by_missions_total;
    var_15 = hoursawakesincelastupdate( var_0, var_7 ).plunder_awarded_by_missions_total;
    var_16 = hoursawakesincelastupdate( var_0, var_8 ).plunder_awarded_by_missions_total;
    var_17 = 1;
}

printplayerdatastats()
{
    var_0 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "phase" );
    var_1 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "lastUpdateTime" );
    var_2 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "boredDmg" );
    var_3 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "dirtyDmg" );
    var_4 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "unrulyDmg" );
    var_5 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "hungryDmg" );
    var_6 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "bonusTime" );
    var_7 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "charged" );
    var_8 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "growthTime" );
    var_9 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "reproductionStreak" );
    var_10 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "damage" );
    var_11 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "orcaPoints" );
    var_12 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "apachePoints" );
    var_13 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "dragonPoints" );
    var_14 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "killstreakCharge" );
    var_15 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "winGamesCharge" );
    var_16 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "objectiveScoreCharge" );
    var_17 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "killsCharge" );
    var_18 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "topKillstreakCharge" );
    var_19 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "nukeCharge" );
    var_20 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "winGamesTop3" );
    var_21 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "plantsCharge" );
    var_22 = self getplayerdata( "common", self.petwatch.weapon_xp_iw8_knife, "executionsCharge" );
}

testpetdebug( var_0 )
{
    if ( var_0 > 16 && !isdefined( self.petwatch ) )
        initpet( 1, "pet_turbo" );

    if ( !isdefined( self.petwatch ) )
        return;

    switch ( var_0 )
    {
        case 1:
            testtiming();
            break;
        case 2:
            printplayerdatastats();
            break;
        case 3:
            addkillcharge();
            break;
        case 4:
            apc_rus_initomnvars();
            break;
        case 5:
            addobjectivescorecharge( "debug", 1 );
            break;
        case 6:
            addobjectivescorecharge( "debug", 10 );
            break;
        case 7:
            addwatchchargewin();
            break;
        case 8:
            addplantingcharge();
            break;
        case 9:
            addexecutioncharge();
            break;
        case 10:
            addwatchchargewintop3();
            break;
        case 11:
            addtopkillstreakcharge();
            break;
        case 12:
            addnukecharge();
            break;
        case 13:
            self.petwatch.damage = 0;
            updateuistate();
            break;
        case 14:
            self.petwatch.damage = 900;
            updateuistate();
            break;
        case 15:
            self.petwatch.damage = 500;
            updateuistate();
            break;
        case 16:
            addkillstreakcharge();
            break;
        case 17:
            self setclientomnvar( "ui_smart_watch_interact", 2 );
            break;
        case 18:
            self setclientomnvar( "ui_smart_watch_interact", 3 );
            break;
        case 19:
            self setclientomnvar( "ui_smart_watch_interact", 4 );
            break;
        case 20:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 1 );
            break;
        case 21:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 2 );
            break;
        case 22:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 3 );
            break;
    }
}

hoursawakesincelastupdate( var_0, var_1, var_2 )
{
    var_3 = gethourtime( var_0 );
    var_4 = gethours( var_0 - var_1 );
    var_5 = max( 0, var_4 );
    var_6 = spawnstruct();
    var_6.plunder_awarded_by_missions_total = var_5;
    return var_6;
}

updatepetstatesincelastupdate( var_0 )
{
    self endon( "disconnect" );
    return;
}

apc_rus_monitordriverturretfire()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        self.petwatch.wingamescharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge );
    }
}

addkillstreakcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        self.petwatch.check_for_at_set_final_wave++;
        self.petwatch.killstreakcharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 30000 + self.petwatch.killstreakcharge );
    }
}

anim_override()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20000 );
}

apc_rus_initdamage()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        self.petwatch.plantscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge );
    }
}

any_player_nearby_same_floor()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 );
}

animscripted_loop_n_times()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        self.petwatch.nukecharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_4", 10000 + self.petwatch.nukecharge );
    }
}

apcturret()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        self.petwatch.wingamestop3++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3 );
    }
}

onfieldupgradeendbuffer()
{
    var_0 = level.gametype;

    if ( var_0 == "br" )
    {
        var_1 = getdvar( "scr_br_gametype", "" );

        if ( var_1 != "" )
            return var_1;
    }

    return var_0;
}

apc_rus_updatedriverturretammoui()
{
    var_0 = onfieldupgradeendbuffer();

    if ( level.gametype == "br" && ( var_0 == "br" || var_0 == "jugg" || var_0 == "mini" ) )
    {
        if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
            self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 );
    }
}

appliednukethreads()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 );
}

_id_13028()
{
    if ( !scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getTeamData" ) )
        return;

    var_0 = game["roundsPlayed"];

    foreach ( var_2 in level.teamnamelist )
    {
        var_3 = game["roundsWon"][var_2];
        var_4 = var_3 / level.winlimit;
        var_5 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getTeamData" ) ]]( var_2, "players" );

        foreach ( var_7 in var_5 )
        {
            if ( isdefined( var_7.petwatch ) && var_7.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
                var_7 _id_12EEE( var_4, 2 );
        }
    }
}

_id_12EEE( var_0, var_1 )
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        var_0 = min( 1.0, var_0 );
        self setclientomnvar( "ui_pet_watch_bonus_earned_4", 50000 + int( var_0 * 10 ) + var_1 * 100 );
    }
}

_id_12D36( var_0 )
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        if ( !isdefined( var_0.drone_out_of_bound_monitor ) )
        {
            var_0.drone_out_of_bound_monitor = [];
            var_0.drone_movement_vector_monitor = [];
        }

        var_1 = -1;

        foreach ( var_4, var_3 in var_0.drone_out_of_bound_monitor )
        {
            if ( var_3 == self )
            {
                var_1 = var_4;
                break;
            }
        }

        if ( var_1 == -1 )
        {
            var_1 = var_0.drone_out_of_bound_monitor.size;
            var_0.drone_out_of_bound_monitor[var_1] = self;
            var_0.drone_movement_vector_monitor[var_1] = 1;
        }
        else
            var_0.drone_movement_vector_monitor[var_1]++;

        _id_12EEE( var_0.drone_movement_vector_monitor[var_1] / 10, 3 );
    }
}

enable_nvgs()
{
    if ( isdefined( self.drone_out_of_bound_monitor ) )
    {
        var_0 = 0;

        foreach ( var_4, var_2 in self.drone_out_of_bound_monitor )
        {
            var_3 = isdefined( var_2.petwatch ) && var_2.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo";

            if ( !var_3 )
                continue;

            var_0 = self.drone_movement_vector_monitor[var_4];

            if ( var_0 >= 10 )
                var_2 setclientomnvar( "ui_pet_watch_bonus_earned_1", 10000 );
        }
    }
}

enable_motionblur( var_0 )
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        if ( isdefined( var_0.drone_out_of_bound_monitor ) )
        {
            var_1 = 0;

            foreach ( var_4, var_3 in var_0.drone_out_of_bound_monitor )
            {
                if ( var_3 == self )
                {
                    var_1 = var_0.drone_movement_vector_monitor[var_4];
                    break;
                }
            }

            if ( var_1 >= 10 )
                self setclientomnvar( "ui_pet_watch_bonus_earned_1", 10000 );
        }
    }
}

addnukecharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.nukecharge++;
        var_0 = 10000 + self.petwatch.nukecharge;

        if ( self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
            var_0 = var_0 + 100;

        self setclientomnvar( "ui_pet_watch_bonus_earned_4", var_0 );
    }
}

addtopkillstreakcharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.topkillstreakcharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20000 + self.petwatch.topkillstreakcharge );
    }
}

anim_offset()
{
    if ( isdefined( self.petwatch ) )
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20001 );
}

addplantingcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient != "pet_turbo" )
    {
        self.petwatch.plantscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge );
    }
}

addobjectivescorecharge( var_0, var_1 )
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient != "pet_turbo" && ( !istrue( level.vehiclespawn_littlebirdmg[var_0] ) && !issubstr( var_0, "kill" ) ) )
    {
        self.petwatch.check_for_damage_scalar_change = self.petwatch.check_for_damage_scalar_change + var_1;
        self.petwatch.objectivescorecharge = self.petwatch.objectivescorecharge + var_1;
        self setclientomnvar( "ui_pet_watch_bonus_earned_3", 50000 + self.petwatch.objectivescorecharge );
    }
}

apc_rus_initomnvars()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.killscharge = self.petwatch.killscharge + 10;
        self.petwatch.check_dropped_locations_and_offset = self.petwatch.check_dropped_locations_and_offset + 10;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge );
    }
}

addkillcharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.killscharge++;
        self.petwatch.check_dropped_locations_and_offset++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge );
    }
}

addexecutioncharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.executionscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 70000 + self.petwatch.executionscharge );
    }
}

addwatchchargewin()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient != "pet_turbo" )
    {
        self.petwatch.check_for_execution_allows++;
        self.petwatch.wingamescharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge );
        feedaction();
    }
}

addwatchchargewintop3()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient != "pet_turbo" )
    {
        self.petwatch.wingamestop3++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3 );
    }
}

vehiclespawninginto()
{
    self endon( "disconnect" );
    self endon( "cancel_pet_plunder_timer" );
    self.petwatch._id_11AE9 = 1;
    var_0 = 180.0;
    var_1 = var_0 / 5;

    for ( var_2 = 1; var_2 <= 5; var_2++ )
    {
        wait( var_1 );
        _id_12EEE( var_2 / 5, 4 );
    }

    any_player_nearby_same_floor();
}

_id_1309D( var_0 )
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
        _id_12EEE( var_0, 1 );
}

unset_relic_hideobjicons()
{
    if ( isdefined( self.petwatch ) && self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
    {
        if ( self.plundercount > 5000 )
        {
            if ( !isdefined( self.petwatch._id_11AE9 ) )
                thread vehiclespawninginto();
        }
        else if ( isdefined( self.petwatch._id_11AE9 ) )
        {
            self notify( "cancel_pet_plunder_timer" );
            self.petwatch._id_11AE9 = undefined;
            _id_12EEE( 0, 0 );
        }
    }
}

setphase( var_0 )
{
    self.petwatch.phase = var_0;
    self.pers["petWatchData_phase"] = var_0;
}

updateuistate()
{
    var_0 = 0;

    if ( self.petwatch.bored < 0 )
        var_0 = var_0 + 20;

    if ( self.petwatch.dirty < 0 )
        var_0 = var_0 + 100;

    if ( self.petwatch.unruly < 0 )
        var_0 = var_0 + 1000;

    if ( self.petwatch.hungry < 0 )
        var_0 = var_0 + 10000;

    var_1 = int( self.petwatch.damage / 100 ) - 1;
    var_1 = int( max( 0, min( var_1, 9 ) ) );
    var_0 = var_0 + 100000 * var_1;
    var_2 = var_0 + self.petwatch.phase;
    self setclientomnvar( "ui_pet_watch_state", var_2 );
}

_id_11F2C()
{
    self.petwatch.bored = level.petconsts[self.petwatch.phase].boredstart;
    self.petwatch.dirty = level.petconsts[self.petwatch.phase].dirtystart;
    self.petwatch.unruly = level.petconsts[self.petwatch.phase].unrulystart;
    self.petwatch.hungry = level.petconsts[self.petwatch.phase].hungrystart;
    self.petwatch.setnewabilityhud = 0;
    self.petwatch.setextractspawninstances = 0;
    self.petwatch.setup_heli_starts = 0;
    self.petwatch.setjailtimeouthud = 0;
    self.petwatch.charged = 0;
    self.petwatch.growthtime = 0;
    self.petwatch.check_for_early_impact = 0;
    self.petwatch.bonustime = 0;
    self.petwatch.damage = 0;
    self.petwatch._id_12FBE = 0;
    self.petwatch._id_1315F = 0;
    self.petwatch.dragonpoints = 0;
    self.petwatch.check_for_at_set_final_wave = 0;
    self.petwatch.killstreakcharge = 0;
    self.petwatch.check_for_execution_allows = 0;
    self.petwatch.wingamescharge = 0;
    self.petwatch.check_for_damage_scalar_change = 0;
    self.petwatch.objectivescorecharge = 0;
    self.petwatch.check_dropped_locations_and_offset = 0;
    self.petwatch.killscharge = 0;
    self.petwatch.topkillstreakcharge = 0;
    self.petwatch.nukecharge = 0;
    self.petwatch.wingamestop3 = 0;
    self.petwatch.plantscharge = 0;
    self.petwatch.executionscharge = 0;
}

resetpet( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        setphase( var_1 );
    else
        setphase( 1 );

    self.petwatch.lastupdatetime = getsystemtime();
    _id_11F2C();
}

debugsetlasttime( var_0 )
{
    self setclientomnvar( "ui_pet_watch_action", var_0 );
}

feedaction()
{
    if ( !isdefined( self.petwatch ) )
        return;

    if ( self.petwatch.vehomn_fadeoutcontrolsforclient == "pet_turbo" )
        return;

    if ( self.petwatch.phase == 15 )
        return;

    var_0 = self.petwatch.killstreakcharge * 20;
    var_1 = self.petwatch.wingamescharge * 20;
    var_2 = self.petwatch.objectivescorecharge * 0.5;
    var_3 = self.petwatch.killscharge * 1;
    var_4 = self.petwatch.setnewabilityhud < var_3;
    var_5 = self.petwatch.setjailtimeouthud < var_1;
    var_6 = self.petwatch.setextractspawninstances < var_0;
    var_7 = self.petwatch.setup_heli_starts < var_2;

    if ( !var_4 && !var_5 && !var_6 && !var_7 )
        return;

    var_0 = max( -240, min( var_0, 240 ) );
    var_1 = max( -240, min( var_1, 240 ) );
    var_2 = max( -240, min( var_2, 240 ) );
    var_3 = max( -240, min( var_3, 240 ) );

    if ( var_5 )
    {
        var_1 = int( var_1 );

        if ( var_1 == 0 )
            var_1 = 1;

        self setclientomnvar( "ui_pet_watch_health_dirty", var_1 );
    }

    if ( var_7 )
    {
        var_2 = int( var_2 );

        if ( var_2 == 0 )
            var_2 = 1;

        self setclientomnvar( "ui_pet_watch_health_unruly", int( var_2 ) );
    }

    if ( var_4 )
    {
        var_3 = int( var_3 );

        if ( var_3 == 0 )
            var_3 = 1;

        self setclientomnvar( "ui_pet_watch_health_hungry", int( var_3 ) );
    }

    if ( var_6 )
    {
        var_0 = int( var_0 );

        if ( var_0 == 0 )
            var_0 = 1;

        self setclientomnvar( "ui_pet_watch_health_bored", int( var_0 ) );
    }

    self.petwatch.setnewabilityhud = var_3;
    self.petwatch.setjailtimeouthud = var_1;
    self.petwatch.setextractspawninstances = var_0;
    self.petwatch.setup_heli_starts = var_2;
    self.petwatch.topkillstreakcharge = 0;
    self.petwatch.nukecharge = 0;
    self.petwatch.wingamestop3 = 0;
    self.petwatch.plantscharge = 0;
    self.petwatch.executionscharge = 0;
    self.petwatch.bored = var_0;
    self.petwatch.dirty = var_1;
    self.petwatch.unruly = var_2;
    self.petwatch.hungry = var_3;
}
