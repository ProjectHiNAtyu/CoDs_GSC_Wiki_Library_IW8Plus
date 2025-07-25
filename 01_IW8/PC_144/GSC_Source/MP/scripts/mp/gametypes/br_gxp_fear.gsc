// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.completesmokinggunquest.kstargetlocation = 0;

    if ( !getdvarint( "scr_br_gxp_fear", 0 ) )
        return;

    level.completesmokinggunquest.laser_func = [];
    level.completesmokinggunquest.laser_fx = 0;
    level thread _id_13440();
    initvalues();
}

initvalues()
{
    level.completesmokinggunquest.fearval = spawnstruct();
    level.completesmokinggunquest.fearval.minfear = getdvarint( "scr_fear_min", 0 );
    level.completesmokinggunquest.fearval.maxfear = getdvarint( "scr_fear_max", 500 );
    level.completesmokinggunquest.fearval.hallucinationtrigger = level.completesmokinggunquest.fearval.maxfear / 2.0;
    level.completesmokinggunquest.fearval.damagemax = getdvarint( "scr_fear_damage_max", 100 );
    level.completesmokinggunquest.fearval.damagescalar = getdvarfloat( "scr_fear_damage_scalar", 2.0 );
    level.completesmokinggunquest.fearval.armordamagescalar = getdvarfloat( "scr_fear_armor_damage_scalar", 2.0 );
    level.completesmokinggunquest.fearval.vehicledamagescalar = getdvarfloat( "scr_fear_vehicle_damage_scalar", 2.0 );
    level.completesmokinggunquest.fearval.baselineinterval = int( getdvarfloat( "scr_fear_baseline_interval", 1.0 ) * 1000 );
    level.completesmokinggunquest.fearval.burst_fire_turret = getdvarint( "scr_fear_baseline_increment", 2 );
    level.completesmokinggunquest.fearval.baselineincrementcamping = getdvarint( "scr_fear_baseline_increment_camping", 2 );
    level.completesmokinggunquest.fearval.baselineincrementghosts = getdvarint( "scr_fear_baseline_increment_ghosts", 3 );
    level.completesmokinggunquest.fearval.ghostradius = getdvarint( "scr_fear_ghost_radius", 500 );
    level.completesmokinggunquest.fearval.ghostinterval = int( getdvarfloat( "scr_fear_ghost_interval", 5.0 ) * 1000 );
    level.completesmokinggunquest.fearval.ghostspectralblast = getdvarint( "scr_fear_ghost_spectral_blast", 25 );
    level.completesmokinggunquest.fearval.onteammatekilled = int( getdvarfloat( "scr_fear_onteammatekilled", 0.15 ) * 500 );
    level.completesmokinggunquest.fearval.onlaststandenteredself = int( getdvarfloat( "scr_fear_onlaststandenteredself", 0.15 ) * 500 );
    level.completesmokinggunquest.fearval.onlaststandenteredteammate = int( getdvarfloat( "scr_fear_onlaststandenteredteammate", 0.15 ) * 500 );
    level.completesmokinggunquest.fearval.unresolvedcollisiontolerancesqr = int( getdvarfloat( "scr_fear_onkillstreakdanger", 0.1 ) * 500 );
    level.completesmokinggunquest.fearval.onenemyequipment = int( getdvarfloat( "scr_fear_onenemyequipment", 0.1 ) * 500 );
    level.completesmokinggunquest.fearval.onplayerdied = int( getdvarfloat( "scr_fear_onplayerdied", 0.1 ) * 500 );
    level.completesmokinggunquest.fearval.onlootboxjumpscare = int( getdvarfloat( "scr_fear_onlootboxjumpscare", 0.1 ) * 500 );
    level.completesmokinggunquest.fearval.onplayerkilled = int( getdvarfloat( "scr_fear_onplayerkilled", 0.15 ) * 500 );
    level.completesmokinggunquest.fearval.onghostkilled = int( getdvarfloat( "scr_fear_onghostkilled", 0.25 ) * 500 );
    level.completesmokinggunquest.fearval.unset_force_aitype_sniper = int( getdvarfloat( "scr_fear_onlaststandrevive", 0.2 ) * 500 );
    level.completesmokinggunquest.fearval.tv_station_global_stealth_broken = int( getdvarfloat( "scr_fear_onarmorplate", 0.05 ) * 500 );
    level.completesmokinggunquest.fearval.oncontractcomplete = int( getdvarfloat( "scr_fear_oncontractcomplete", 0.1 ) * 500 );
    level.completesmokinggunquest.fearval.campinggraceperiod = getdvarint( "scr_fear_camping_grace_period", 3 );
    level.completesmokinggunquest.fearval.campingdistancedecay = getdvarint( "scr_fear_camping_distance_decay", 50 );
    level.completesmokinggunquest.fearval.campingdistance = getdvarint( "scr_fear_camping_distance", 500 );
    level.completesmokinggunquest.fearval.campingdistancecap = getdvarint( "scr_fear_camping_distance_cap", 5000 );
    level.completesmokinggunquest.fearval.beataudio = [];
    level.completesmokinggunquest.fearval.beataudio[0] = "br_gov_fear_heart_high";
    level.completesmokinggunquest.fearval.beataudio[1] = "br_gov_fear_heart_high";
    level.completesmokinggunquest.fearval.beataudio[2] = "br_gov_fear_heart_low";
    level.completesmokinggunquest.fearval.stingeraudio = [];
    level.completesmokinggunquest.fearval.stingeraudio[0] = "br_gov_fear_whsp_high";
    level.completesmokinggunquest.fearval.thresholdstingeraudio = [];
    level.completesmokinggunquest.fearval.thresholdstingeraudio[0] = "br_gov_fear_sting_high";
    level.completesmokinggunquest.fearval.thresholdstingeraudio[1] = "br_gov_fear_sting_med";
    level.completesmokinggunquest.fearval.thresholdstingeraudio[2] = "br_gov_fear_sting_low";
}

_id_13440()
{
    waittillframeend;
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );

    foreach ( var_2, var_1 in level.br_pickups.br_equipname )
    {

    }

    level.completesmokinggunquest.kstargetlocation = 1;

    if ( istrue( level.br_infils_disabled ) )
    {
        foreach ( var_4 in level.players )
            var_4 thread hasplatepouch();
    }

    _id_11DE9( "onPlayerDamaged", ::laps_data );
    _id_11DE9( "onPlayerArmorDamaged", ::lap_index );
    _id_11DE9( "onLastStandEnter", ::landmine_trigger_origin );
    _id_11DE9( "onKillstreakDanger", ::landing_damage_watcher );
    _id_11DE9( "onTeammateKilled", ::labelsused, level.completesmokinggunquest.fearval.onteammatekilled );
    _id_11DE9( "onPlayerDied", ::labelsused, level.completesmokinggunquest.fearval.onplayerdied );
    _id_11DE9( "onVehicleDamaged", ::laser_activate );
    _id_11DE9( "onPlayerHallucinate", ::large_transport_initdamage );
    _id_11DE9( "onLastStandRevive", ::labels, level.completesmokinggunquest.fearval.unset_force_aitype_sniper );
    _id_11DE9( "onArmorPlate", ::labels, level.completesmokinggunquest.fearval.tv_station_global_stealth_broken );
    _id_11DE9( "onContractEnd", ::land_usability_disabled, level.completesmokinggunquest.fearval.oncontractcomplete );
    _id_11DE9( "onOpenLootBox", ::lap );
    _id_11DE9( "onPlayerKilled", ::large_transport_initomnvars );
    level thread _id_13091();

    if ( !getdvarint( "scr_br_gxp_disable_hallucination_player_vfx", 0 ) )
        level thread scripts\mp\gametypes\br_gxp_hallucination.gsc::tr_playerdisconnect();
}

projectileimpactexplode( var_0 )
{
    var_1 = ninetypercent_music();
    self.play_3p_anim = clamp( self.play_3p_anim + var_0, level.completesmokinggunquest.fearval.minfear, level.completesmokinggunquest.fearval.maxfear );
    self setclientomnvar( "ui_br_fear_meter", ( self.play_3p_anim - level.completesmokinggunquest.fearval.minfear ) / ( level.completesmokinggunquest.fearval.maxfear - level.completesmokinggunquest.fearval.minfear ) );
    fear_thresholdstinger( var_1 );
}

give_clip_of_ammo( var_0 )
{
    self.play_3p_anim = clamp( self.play_3p_anim - var_0, level.completesmokinggunquest.fearval.minfear, level.completesmokinggunquest.fearval.maxfear );
    self setclientomnvar( "ui_br_fear_meter", ( self.play_3p_anim - level.completesmokinggunquest.fearval.minfear ) / ( level.completesmokinggunquest.fearval.maxfear - level.completesmokinggunquest.fearval.minfear ) );
}

display_hint_for_player_single()
{
    if ( istrue( self.play_approach_building_two ) )
        return 0;

    if ( self.play_3p_anim >= level.completesmokinggunquest.fearval.hallucinationtrigger )
        return 1;

    return 0;
}

ninetypercent_music()
{
    if ( self.play_3p_anim < level.completesmokinggunquest.fearval.hallucinationtrigger )
        return 0.0;

    return ( self.play_3p_anim - level.completesmokinggunquest.fearval.hallucinationtrigger ) / ( level.completesmokinggunquest.fearval.maxfear - level.completesmokinggunquest.fearval.hallucinationtrigger );
}

onplayerconnect( var_0 )
{
    if ( !getdvarint( "scr_br_gxp_fear", 0 ) )
        return;

    var_0 findnewplunderextractsite();
}

onplayerspawned()
{
    if ( !level.completesmokinggunquest.kstargetlocation )
        return;

    findnewplunderextractsite();
    thread hasplatepouch();
}

labelpc( var_0, var_1, var_2 )
{
    if ( !level.completesmokinggunquest.kstargetlocation )
        return;

    if ( !isdefined( level.completesmokinggunquest.laser_func[var_0].function ) )
        scripts\mp\utility\script::handle_train_veh_collision( var_0 + " is not defined in triggerFear." );

    if ( isdefined( level.completesmokinggunquest.laser_func[var_0].function ) )
    {
        if ( isdefined( var_2 ) )
            return [[ level.completesmokinggunquest.laser_func[var_0].function ]]( level.completesmokinggunquest.laser_func[var_0].value, var_1, var_2 );
        else if ( isdefined( var_1 ) )
            return [[ level.completesmokinggunquest.laser_func[var_0].function ]]( level.completesmokinggunquest.laser_func[var_0].value, var_1 );
        else
            return [[ level.completesmokinggunquest.laser_func[var_0].function ]]( level.completesmokinggunquest.laser_func[var_0].value );
    }
}

_id_11DE9( var_0, var_1, var_2 )
{
    if ( isdefined( level.completesmokinggunquest.laser_func[var_0] ) )
        scripts\mp\utility\script::handle_train_veh_collision( "registerFearCause already has " + var_0 + " defined." );

    if ( !isdefined( var_2 ) )
        var_2 = 0.0;

    level.completesmokinggunquest.laser_func[var_0] = spawnstruct();
    level.completesmokinggunquest.laser_func[var_0].function = var_1;
    level.completesmokinggunquest.laser_func[var_0].value = var_2;
}

findnewplunderextractsite()
{
    self.play_3p_anim = 0;
    self.play_3p_anim_non_animscene = gettime();
    self.play_ac130_approach_based_on = 0;
    self.play_airport_success_vo = gettime();
    self.play_ac130_approach_scene = 0;
    self.play_airstrike_sequence = 0;
    self.play_alarms_onto = gettime();
    self.play_ai_taking_to_convoy_firsttime = self.origin + ( 0, 0, 1 ) * level.completesmokinggunquest.fearval.campingdistancecap;
}

rocket_missile()
{
    return 0;
}

_id_12C2B()
{
    var_0 = level.completesmokinggunquest.fearval.campinggraceperiod;
    var_1 = 1;

    if ( rocket_missile() )
        var_1 = 0;
    else
    {
        var_2 = vectornormalize( self.play_ai_taking_to_convoy_firsttime - self.origin );
        var_3 = distance( self.origin, self.play_ai_taking_to_convoy_firsttime );
        var_4 = clamp( var_3 - level.completesmokinggunquest.fearval.campingdistancedecay * level.completesmokinggunquest.fearval.baselineinterval * 0.001, 0, level.completesmokinggunquest.fearval.campingdistancecap );
        self.play_ai_taking_to_convoy_firsttime = self.origin + var_2 * var_4;

        if ( var_4 < level.completesmokinggunquest.fearval.campingdistance )
            self.play_ac130_approach_scene = 1;
        else
            self.play_ac130_approach_scene = 0;

        if ( self.play_ac130_approach_scene == 0 )
            var_1 = 0;
    }

    if ( var_1 == 0 )
    {
        self.play_ac130_approach_based_on = 0;
        return 0;
    }
    else
    {
        self.play_ac130_approach_based_on++;

        if ( self.play_ac130_approach_based_on >= var_0 )
            return 1;
    }

    return 0;
}

bot_try_switch_attack_zone()
{
    if ( self.play_alarms_onto + level.completesmokinggunquest.fearval.ghostinterval < gettime() )
    {
        self.play_alarms_onto = gettime();
        var_0 = scripts\mp\utility\player::getplayersinradius( self.origin, level.completesmokinggunquest.fearval.ghostradius );

        foreach ( var_2 in var_0 )
        {
            if ( var_2.team == self.team && self.squadindex == self.squadindex )
                continue;

            if ( scripts\mp\gametypes\br_public.gsc::zombie() )
            {
                self.play_airstrike_sequence = 1;
                break;
            }
        }
    }

    return self.play_airstrike_sequence;
}

relic_squadlink_onsteppedclose()
{
    return scripts\mp\gametypes\br_gxp_safe_zones.gsc::reset_recharge_after_respawn( self );
}

burst_fire_turret()
{
    if ( self.play_3p_anim_non_animscene + level.completesmokinggunquest.fearval.baselineinterval < gettime() )
    {
        var_0 = relic_squadlink_onsteppedclose();
        scripts\mp\gametypes\br_gametype_gxp_ghost.gsc::_id_13082( "inSafeZone", var_0 );

        if ( var_0 )
            give_clip_of_ammo( level.completesmokinggunquest.safezonefeardecrement );
        else
        {
            var_1 = level.completesmokinggunquest.fearval.burst_fire_turret;

            if ( _id_12C2B() )
                var_1 = var_1 + level.completesmokinggunquest.fearval.baselineincrementcamping;

            if ( bot_try_switch_attack_zone() )
                var_1 = var_1 + level.completesmokinggunquest.fearval.baselineincrementghosts;

            projectileimpactexplode( var_1 );
        }

        self.play_3p_anim_non_animscene = gettime();
    }
}

_id_12505()
{
    if ( self.sessionstate != "playing" )
        return 0;

    if ( scripts\mp\utility\game::runextractreroll( self ) )
        return 0;

    if ( scripts\mp\gametypes\br_public.gsc::zombie() )
        return 0;

    if ( istrue( self.inlaststand ) )
        return 0;

    return 1;
}

_id_124E3()
{
    if ( self.sessionstate != "playing" )
        return 1;

    if ( scripts\mp\utility\game::runextractreroll( self ) )
        return 1;

    if ( scripts\mp\gametypes\br_public.gsc::zombie() )
        return 1;

    return 0;
}

_id_1307C()
{
    self endon( "disconnect" );

    if ( _id_12505() )
    {
        burst_fire_turret();

        if ( display_hint_for_player_single() )
            scripts\mp\gametypes\br_gxp_hallucination.gsc::update( ninetypercent_music() );
        else
            scripts\mp\gametypes\br_gxp_hallucination.gsc::farah_nobraids_body_reset();

        return;
    }

    scripts\mp\gametypes\br_gxp_hallucination.gsc::farah_nobraids_body_reset();

    if ( _id_124E3() )
        findnewplunderextractsite();
}

_id_13091()
{
    for (;;)
    {
        if ( isdefined( level.players ) && level.players.size )
        {
            level.completesmokinggunquest.laser_fx = level.completesmokinggunquest.laser_fx % level.players.size;
            var_0 = clamp( 10, 1, level.players.size );

            for ( var_1 = 0; var_1 < var_0; var_1++ )
            {
                var_2 = level.completesmokinggunquest.laser_fx;
                var_3 = level.players[var_2];
                level.completesmokinggunquest.laser_fx = ( level.completesmokinggunquest.laser_fx + 1 ) % level.players.size;
                var_3 thread _id_1307C();
                var_3 thread fear_heartbeat();
            }
        }

        wait 0.05;
    }
}

labelsused( var_0, var_1 )
{
    projectileimpactexplode( var_0 );
}

laps_data( var_0, var_1 )
{
    var_2 = var_1.objweapon.basename;
    var_3 = scripts\mp\utility\weapon::getequipmenttype( var_2 );

    if ( isdefined( var_3 ) )
    {
        if ( var_3 == "equipment_other" || var_3 == "tactical" )
        {
            projectileimpactexplode( level.completesmokinggunquest.fearval.onenemyequipment );
            return;
        }
    }

    if ( var_2 == "emp_drone_player_mp" )
    {
        projectileimpactexplode( level.completesmokinggunquest.fearval.ghostspectralblast );
        return;
    }

    var_4 = clamp( var_1.damage, 0, level.completesmokinggunquest.fearval.damagemax );
    var_5 = var_4 * level.completesmokinggunquest.fearval.damagescalar;
    projectileimpactexplode( var_5 );
}

lap_index( var_0, var_1 )
{
    if ( !isdefined( var_1.prev_weapon_taccover ) || !var_1.prev_weapon_taccover )
    {
        var_2 = clamp( var_1.getcircleindexforpoint, 0, level.completesmokinggunquest.fearval.damagemax );
        var_3 = var_2 * level.completesmokinggunquest.fearval.armordamagescalar;
        projectileimpactexplode( var_3 );
    }
}

laser_activate( var_0, var_1 )
{
    var_2 = clamp( var_1.damage, 0, level.completesmokinggunquest.fearval.damagemax );
    var_3 = var_2 * level.completesmokinggunquest.fearval.vehicledamagescalar;
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );

    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_4 )
        {
            if ( isdefined( var_6 ) && isalive( var_6 ) )
                var_6 projectileimpactexplode( var_3 );
        }
    }
}

landmine_trigger_origin( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( self == var_1 )
        projectileimpactexplode( level.completesmokinggunquest.fearval.onlaststandenteredself );
    else
        projectileimpactexplode( level.completesmokinggunquest.fearval.onlaststandenteredteammate );
}

landing_damage_watcher( var_0, var_1 )
{
    if ( istrue( var_1.watch_flight_collision ) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue( var_1.trial_callback_ai_damage ) )
    {
        var_2 = level.completesmokinggunquest.fearval.unresolvedcollisiontolerancesqr;
        projectileimpactexplode( var_2 );
    }
}

labels( var_0, var_1 )
{
    give_clip_of_ammo( var_0 );
}

large_transport_initdamage( var_0, var_1 )
{
    scripts\mp\gametypes\br_gametype_gxp_challenges.gsc::on_player_hallucinated( self, var_0 );
    var_2 = var_1.ks_killleaders * level.completesmokinggunquest.fearval.maxfear;
    give_clip_of_ammo( var_2 );
}

land_usability_disabled( var_0, var_1 )
{
    if ( var_1 == 1 )
        give_clip_of_ammo( var_0 );
}

lap( var_0 )
{
    if ( _branalytics_addeventallowed::_id_12EE4() )
        projectileimpactexplode( level.completesmokinggunquest.fearval.onlootboxjumpscare );
}

large_transport_initomnvars( var_0, var_1 )
{
    var_2 = var_1.victim;
    var_3 = var_1.attacker;

    if ( var_2 scripts\mp\gametypes\br_public.gsc::zombie() )
        give_clip_of_ammo( level.completesmokinggunquest.fearval.onghostkilled );
    else
        give_clip_of_ammo( level.completesmokinggunquest.fearval.onplayerkilled );
}

fear_heartbeat()
{
    var_0 = gettime();

    if ( isdefined( self.nextfearheartbeattime ) && var_0 < self.nextfearheartbeattime )
        return;

    var_1 = ninetypercent_music();
    var_2 = 1.0;
    var_3 = 0.5;
    var_4 = scripts\engine\math::lerp( var_2, var_3, var_1 );
    self.nextfearheartbeattime = var_0 + int( 1000 * var_4 );

    if ( var_1 <= 0 )
        return;

    for ( var_5 = 0; var_5 < level.completesmokinggunquest.play_operator_reply_vo.size; var_5++ )
    {
        var_6 = level.completesmokinggunquest.play_operator_reply_vo[var_5]._id_12E89;

        if ( var_1 < var_6 )
            continue;

        var_7 = level.completesmokinggunquest.fearval.beataudio[var_5];

        if ( isdefined( var_7 ) )
            self playlocalsound( var_7, self );

        var_8 = level.completesmokinggunquest.fearval.stingeraudio[var_5];

        if ( isdefined( var_8 ) )
        {
            if ( !isdefined( self.nextfearstingertime ) || var_0 >= self.nextfearstingertime )
            {
                self playlocalsound( var_8 );
                self.nextfearstingertime = var_0 + int( 1000 * randomfloatrange( 3, 5 ) );
            }
        }

        break;
    }
}

fear_thresholdstinger( var_0 )
{
    if ( getdvarint( "scr_br_gxp_disable_fear_threshold_stinger", 0 ) )
        return;

    var_1 = ninetypercent_music();

    if ( var_1 <= 0 )
        return;

    for ( var_2 = 0; var_2 < level.completesmokinggunquest.play_operator_reply_vo.size; var_2++ )
    {
        var_3 = level.completesmokinggunquest.play_operator_reply_vo[var_2]._id_12E89;

        if ( var_0 <= var_3 && var_1 >= var_3 )
        {
            var_4 = level.completesmokinggunquest.fearval.thresholdstingeraudio[var_2];

            if ( isdefined( var_4 ) )
                self playlocalsound( var_4, self );

            return;
        }
    }
}

hasplatepouch()
{
    if ( !getdvarint( "scr_br_fear_enable_dev_draw", 0 ) )
        return;

    if ( isbot( self ) || initmaxspeedforpathlengthtable( self ) )
        return;

    if ( isdefined( self.hasseendiscountsplash ) )
        return;

    if ( scripts\mp\gametypes\br_public.gsc::zombie() )
        return;

    var_0 = 200;
    var_1 = 250;
    self.hasseendiscountsplash = scripts\mp\hud_util::createprimaryprogressbar( var_0, var_1 );
    self.hasseenendgamesplash = scripts\mp\hud_util::createprimaryprogressbartext( var_0 + 75, var_1 + 13 );
    self.hasseenendgamesplash setvalue( 0.0 );

    if ( getdvarint( "scr_br_gxp_fear_camping_debug", 0 ) )
        self.hasscrapassist = scripts\mp\hud_util::createprimaryprogressbar( 200, 235 );

    thread headicon_image();
}

headicon_image()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_0 = self.play_3p_anim;
    var_1 = distance( self.origin, self.play_ai_taking_to_convoy_firsttime );

    for (;;)
    {
        var_2 = self.play_3p_anim;

        if ( var_0 != var_2 )
        {
            var_3 = var_2 / level.completesmokinggunquest.fearval.maxfear;

            if ( var_3 > 1.0 )
                var_3 = 1.0;

            self.hasseendiscountsplash scripts\mp\hud_util::updatebar( var_3, 0 );
            var_0 = var_2;
            self.hasseendiscountsplash.bar.color = scripts\mp\gametypes\br_gxp_hallucination.gsc::hasselfrevivetoken();

            if ( self.play_ac130_approach_based_on >= level.completesmokinggunquest.fearval.campinggraceperiod )
                self.hasseendiscountsplash.color = ( 0.7, 0.3, 0.3 );
            else
                self.hasseendiscountsplash.color = ( 0.5, 0.5, 0.5 );

            self.hasseenendgamesplash setvalue( var_2 );
        }

        if ( getdvarint( "scr_br_gxp_fear_camping_debug", 0 ) )
        {
            var_4 = distance( self.origin, self.play_ai_taking_to_convoy_firsttime );

            if ( var_1 != var_4 )
            {
                if ( var_4 < level.completesmokinggunquest.fearval.campingdistance )
                {
                    var_3 = min( ( level.completesmokinggunquest.fearval.campingdistance - var_4 ) / level.completesmokinggunquest.fearval.campingdistance, 1.0 );
                    self.hasscrapassist scripts\mp\hud_util::updatebar( var_3, 0 );
                    self.hasscrapassist.bar.color = ( 1, 0, 0 );
                }
                else
                {
                    var_3 = min( ( var_4 - level.completesmokinggunquest.fearval.campingdistance ) / ( level.completesmokinggunquest.fearval.campingdistancecap - level.completesmokinggunquest.fearval.campingdistance ), 1.0 );
                    self.hasscrapassist scripts\mp\hud_util::updatebar( var_3, 0 );
                    self.hasscrapassist.bar.color = ( 1, 1, 1 );
                }

                var_1 = var_4;
            }
        }

        waitframe();
    }
}
