// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = scripts\mp\utility\dvars::obj_caches_tanks( "scr_" + scripts\mp\utility\game::getgametype() + "_healthregentime", "scr_player_healthregentime" );
    scripts\mp\tweakables::settweakablevalue( "player", "healthregentime", var_0 );
    scripts\mp\tweakables::settweakablelastvalue( "player", "healthregentime", var_0 );
    level.healthregendelay = scripts\mp\tweakables::gettweakablevalue( "player", "healthregentime" );
    level.healthregendisabled = level.healthregendelay <= 0;
    level.playerhealth_regularregendelay = level.healthregendelay;
    level.deathsdoorexitpct = getdvarfloat( "scr_br_deathsdoor_exit_pct", 0.8 );
    level.deathsdoorenterpct = getdvarfloat( "scr_br_deathsdoor_enter_pct", 0.55 );
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( ::onplayerspawned );
}

onplayerspawned()
{
    thread manageplayerregen();
    self visionsetthermalforplayer( game["thermal_vision"] );
}

manageplayerregen()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self.deathsdoor = 0;
    self.getnexthelimodule = 0;
    self.hasdonepainbreathloopthislife = 0;
    self stoplocalsound( "deaths_door_out" );
    self stoplocalsound( "deaths_door_in" );
    self clearsoundsubmix( "deaths_door_mp" );

    for (;;)
    {
        scripts\engine\utility::waittill_either( "damage", "force_regeneration" );
        thread healhregenthink();
    }
}

onenterdeathsdoor()
{
    if ( istrue( self.deathsdoor ) )
        return;

    self.deathsdoor = 1;
    self.painbreathloopsplayed = 0;

    if ( !istrue( self.getnexthelimodule ) && !istrue( self.heligotoplunderrepository ) )
    {
        self.getnexthelimodule = 1;
        self stoplocalsound( "deaths_door_out" );
        self playlocalsound( "deaths_door_in" );
        self setsoundsubmix( "deaths_door_mp", 0.2, 1 );
        self enableplayerbreathsystem( 0 );
        thread playerbreathingpainsound();
    }

    if ( level.healthregendisabled )
        self painvisionon();

    self notify( "deaths_door_enter" );
}

onexitdeathsdoor( var_0 )
{
    if ( istrue( var_0 ) )
    {
        self.painbreathloopsplayed = 0;
        self.hasdonepainbreathloopthislife = 0;
    }

    if ( !istrue( self.deathsdoor ) )
        return;

    self.deathsdoor = 0;
    self.getnexthelimodule = 0;
    self stoplocalsound( "deaths_door_in" );
    self playlocalsound( "deaths_door_out" );
    self clearsoundsubmix( "deaths_door_mp" );
    self enableplayerbreathsystem( 1 );

    if ( level.healthregendisabled )
        self painvisionoff();

    self notify( "deaths_door_exit" );
}

onfullhealth()
{
    self notify( "healed" );
    level notify( "healed", self );
    thread scripts\mp\damage::removeoldattackersovertime();
    self setclientomnvar( "ui_health_regen_hud", 0 );

    if ( level.gameended )
        return;

    if ( scripts\mp\utility\player::isusingremote() )
        return;

    self playlocalsound( scripts\engine\utility::ter_op( scripts\mp\utility\player::isfemale(), "Fem_breathing_better", "breathing_better" ) );
}

gethealthpersec( var_0 )
{
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        if ( isdefined( var_0 ) )
        {
            if ( var_0 == "equip_bandages" )
                return self.maxhealth * scripts\mp\equipment\bandage::getbandagehealfractionbr() / scripts\mp\equipment\bandage::getbandagehealtimebr();

            return self.maxhealth / scripts\mp\equipment\bandage::getfirstaidhealtimebr();
        }
    }

    return 4;
}

healhregenthink( var_0 )
{
    if ( !scripts\mp\utility\player::isreallyalive( self ) )
        return;

    self notify( "healhRegenThink" );
    self endon( "healhRegenThink" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_1 = !istrue( self.adrenalinepoweractive ) && !istrue( self.bandageactive ) && !istrue( self.laststandhealisactive );
    var_2 = self.health / self.maxhealth;

    while ( istrue( level.healthregendisabled ) && scripts\mp\utility\player::isusingremote() )
        waitframe();

    if ( var_2 < level.deathsdoorenterpct && !scripts\mp\utility\player::isusingremote() && !istrue( self.prevcallback ) )
        onenterdeathsdoor();

    if ( var_1 )
    {
        if ( level.healthregendisabled )
            return;

        while ( istrue( self.healthregendisabled ) || !scripts\mp\utility\player::is_health_regen_allowed() )
            waitframe();

        waitforhealthregendelay();
    }

    if ( !var_1 || scripts\mp\utility\perk::_hasperk( "specialty_regenfaster" ) )
        self setclientomnvar( "ui_health_regen_hud", 1 );

    var_3 = self.maxhealth / 50.0;
    var_4 = 0.0;
    var_5 = self.health;
    var_6 = istrue( self.adrenalinepoweractive );

    for (;;)
    {
        if ( !scripts\mp\utility\player::is_health_regen_allowed() || istrue( self.healthregendisabled ) && var_1 )
            return;

        wait 0.05;
        var_7 = var_3;

        if ( istrue( self.adrenalinepoweractive ) )
            var_7 = scripts\mp\equipment\adrenaline::gethealthperframe();
        else if ( istrue( self.bandageactive ) )
        {
            var_7 = gethealthpersec( var_0 );
            wait 1;
        }
        else if ( istrue( self.laststandhealisactive ) )
            var_7 = scripts\mp\supers\laststand_heal::laststandheal_gethealthperframe();
        else if ( scripts\mp\utility\perk::_hasperk( "specialty_regenfaster" ) )
            var_7 = var_3 * level.regenfasterhealthmod;

        if ( isdefined( level._id_11DAA ) )
            var_7 = [[ level._id_11DAA ]]( var_7 );

        if ( self.health < self.maxhealth )
        {
            var_8 = self.health + var_7 + var_4;
            var_9 = int( min( self.maxhealth, var_8 ) );
            var_4 = var_8 - var_9;
            self.health = var_9;
            var_2 = self.health / self.maxhealth;

            if ( var_2 > level.deathsdoorexitpct )
                onexitdeathsdoor( 1 );
        }

        if ( self.health >= self.maxhealth )
        {
            self.health = self.maxhealth;
            break;
        }
    }

    var_10 = self.health - var_5;

    if ( var_6 )
    {
        scripts\mp\damage::combatrecordtacticalstat( "equip_adrenaline", var_10 );
        scripts\mp\utility\stats::incpersstat( "stimDamageHealed", var_10 );
        scripts\cp\helicopter\chopper_boss::unsetreduceregendelayonkill( var_10 );
        scripts\mp\analyticslog::logevent_playerhealed( self, var_10, self );
    }
    else if ( !isai( self ) )
        scripts\mp\analyticslog::spawn_deceleration( self, var_10 );

    if ( var_1 && var_10 > 0 )
        level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "player_recover" );

    onfullhealth();
}

waitforhealthregendelay()
{
    self endon( "force_regeneration" );
    self.shrapnelregendelay = 0.0;

    if ( isdefined( self.lastshrapneltime ) )
    {
        var_0 = gettime();
        var_1 = var_0 - self.lastshrapneltime;
        var_1 = var_1 * 0.001;

        if ( scripts\mp\utility\perk::_hasperk( "specialty_shrapnel_resist" ) )
        {
            var_2 = 1;
            self.shrapnelregendelay = max( var_2 - var_1, 0 );
        }
        else
            self.shrapnelregendelay = max( 3 - var_1, 0 );
    }

    if ( !isdefined( self.regendelayspeed ) )
        self.regendelayspeed = 1;

    var_3 = self.shrapnelregendelay > 0.0;

    if ( var_3 )
        thread applyshrapnelfx();

    if ( !isdefined( self.regendelayreductiontime ) || gettime() - self.regendelayreductiontime > 0.15 )
        self.regendelayreduction = 0;

    var_4 = level.playerhealth_regularregendelay + self.shrapnelregendelay;
    self.currentregendelay = var_4;
    var_0 = gettime() * 0.001;

    while ( self.currentregendelay - self.regendelayreduction > 0 )
    {
        var_5 = self.regendelayspeed;

        if ( isdefined( level._id_11DA9 ) )
            var_5 = [[ level._id_11DA9 ]]( var_5 );

        self.currentregendelay = self.currentregendelay - ( gettime() * 0.001 - var_0 ) * var_5;
        var_0 = gettime() * 0.001;

        if ( var_3 && self.currentregendelay - self.regendelayreduction <= level.playerhealth_regularregendelay )
        {
            var_3 = 0;

            if ( self.regendelayreduction > 0 )
                self notify( "shrapnel_ended" );
            else
                self notify( "shrapnel_ended_early" );
        }

        wait 0.05;
    }

    if ( var_3 )
        self notify( "shrapnel_ended_early" );

    self.regendelayreduction = 0;
    self.regendelayreductiontime = 0;
}

reducehealthregendelay( var_0 )
{
    if ( !isdefined( self.regendelayreduction ) )
    {
        self.regendelayreduction = 0;
        self.regendelayreductiontime = 0;
    }

    self.regendelayreduction = self.regendelayreduction + var_0;
    self.regendelayreductiontime = gettime();
}

playerbreathingpainsound( var_0 )
{
    self endon( "death_or_disconnect" );
    self endon( "deaths_door_exit" );
    self endon( "healed" );
    self endon( "last_stand_revived" );
    level endon( "game_ended" );
    wait 0.5;

    for (;;)
    {
        if ( scripts\mp\utility\player::isusingremote() )
        {
            waitframe();
            continue;
        }

        if ( level.healthregendisabled )
        {
            self.painbreathloopsplayed++;

            if ( self.painbreathloopsplayed > scripts\engine\utility::ter_op( istrue( self.hasdonepainbreathloopthislife ), 1, 4 ) )
            {
                wait 1.0;
                self.hasdonepainbreathloopthislife = 1;
                onexitdeathsdoor( 0 );
                break;
            }
        }

        self playlocalsound( "plr_breath_pain_ong_exh" );
        wait 1.7;
    }
}

applyshrapnelfx()
{
    self endon( "disconnect" );
    self notify( "applyShrapnelFX" );
    self endon( "applyShrapnelFX" );
    self setclientomnvar( "ui_shrapnel_overlay", 1 );
    self playlocalsound( "iw8_mp_perk_shrapnel" );
    var_0 = applyshrapnelfxinternal();

    if ( istrue( var_0 ) )
        self setclientomnvar( "ui_shrapnel_overlay", 2 );
    else
        self setclientomnvar( "ui_shrapnel_overlay", 3 );
}

applyshrapnelfxinternal()
{
    self endon( "death" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    var_0 = scripts\engine\utility::_id_133F8( "shrapnel_ended_early", "shrapnel_ended", "force_regeneration" );
    return var_0 == "shrapnel_ended";
}
