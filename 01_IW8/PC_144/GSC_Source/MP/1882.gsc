// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_agent( var_0 )
{
    if ( !isdefined( level.agent_definition ) )
        level.agent_definition = [];

    init_spawn_times();
    var_1 = [];
    var_1["species"] = 3;
    var_1["traversal_unit_type"] = 4;
    var_1["body_model"] = 5;
    var_1["animclass"] = 6;
    var_1["health"] = 7;
    var_1["xp"] = 8;
    var_1["reward"] = 9;
    var_1["behaviorTree"] = 10;
    var_1["asm"] = 11;
    var_1["radius"] = 12;
    var_1["height"] = 13;
    var_1["legacy"] = 14;
    var_2 = 0;
    var_3 = 50;

    for ( var_4 = var_2; var_4 <= var_3; var_4++ )
    {
        var_5 = tablelookupbyrow( var_0, var_4, 2 );

        if ( var_5 == "" )
            break;

        var_6 = [];

        foreach ( var_11, var_8 in var_1 )
        {
            var_9 = tablelookupbyrow( var_0, var_4, var_8 );

            if ( var_9 == "0" )
                var_9 = 0;
            else if ( int( var_9 ) != 0 )
            {
                var_10 = var_9 + "";

                if ( issubstr( var_10, "." ) )
                    var_9 = float( var_9 );
                else
                    var_9 = int( var_9 );
            }

            var_6[var_11] = var_9;
        }

        level.agent_definition[var_5] = var_6;
    }

    level notify( "scripted_agents_initialized" );
}

init_spawn_times()
{
    level.agent_available_to_spawn_time = [];
    level.agent_recycle_interval = 500;
}

setup_bt_and_asm()
{
    var_0 = level.agent_definition[self.agent_type];

    if ( !isdefined( var_0["behaviorTree"] ) || var_0["behaviorTree"] == "" )
        return;

    scripts\mp\agents\scriptedagents::ai_init( var_0["behaviorTree"], var_0["asm"] );
}

setupweapon( var_0 )
{
    self.weapon = var_0;
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.grenadeweapon = isundefinedweapon();
    self.grenadeammo = 0;
}

setup_spawn_struct( var_0 )
{
    self.spawner = var_0;
}

spawnnewagentaitype( var_0, var_1, var_2 )
{
    if ( !scripts\engine\utility::string_starts_with( var_0, "actor_" ) )
        var_0 = "actor_" + var_0;

    if ( !isdefined( level.agent_definition[var_0] ) )
        return undefined;

    var_3 = spawnnewagent( var_0, level.agent_definition[var_0]["team"], var_1, var_2 );
    return var_3;
}

spawnnewagent( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = getfreeagent( var_0 );

    if ( isdefined( var_6 ) )
    {
        if ( !isdefined( var_3 ) )
            var_3 = ( 0, 0, 0 );

        var_6.connecttime = gettime();

        if ( isdefined( var_5 ) )
            var_6 setup_spawn_struct( var_5 );

        if ( !isdefined( var_1 ) )
            var_1 = "axis";

        var_6 set_agent_team( var_1 );
        var_6 set_agent_model( var_6, var_0 );
        var_6 set_agent_species( var_6, var_0 );

        if ( is_scripted_agent( var_0 ) )
            var_6 = spawn_scripted_agent( var_6, var_0, var_2, var_3 );
        else
            var_6 = spawn_regular_agent( var_6, var_2, var_3 );

        var_6 set_agent_team( var_1 );
        var_6 setup_agent( var_0 );
        var_6 set_agent_spawn_health( var_6, var_0 );
        var_6 set_agent_traversal_unit_type( var_6, var_0 );
        var_6 add_to_characters_array();

        if ( is_using_behaviortree( var_0 ) )
            var_6 setup_bt_and_asm();

        if ( isdefined( var_4 ) )
        {
            if ( issameweapon( var_4 ) )
                var_6 setupweapon( var_4 );
            else
                return undefined;
        }

        var_6 activateagent();
        var_6 scripts\engine\utility::set_ai_number();
    }

    return var_6;
}

watch_for_team_undefined()
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self.team ) )
            level notify( "agent_missing_team" );

        waitframe();
    }
}

set_agent_traversal_unit_type( var_0, var_1 )
{
    if ( !can_set_traversal_unit_type( var_0 ) )
        return;

    if ( !isdefined( anim.animselector ) )
        scripts\anim\animselector.gsc::init();

    var_0.unittype = level.agent_definition[var_1]["traversal_unit_type"];
}

can_set_traversal_unit_type( var_0 )
{
    if ( is_agent_scripted( var_0 ) )
        return 1;

    return 0;
}

set_agent_model( var_0, var_1 )
{
    var_2 = level.agent_definition[var_1]["setup_model_func"];

    if ( isdefined( var_2 ) )
    {
        var_0 [[ var_2 ]]( var_1 );
        return;
    }

    var_0 detachall();
    var_0 setmodel( level.agent_definition[var_1]["body_model"] );
    var_0 show();
}

is_scripted_agent( var_0 )
{
    return level.agent_definition[var_0]["animclass"] != "";
}

is_using_behaviortree( var_0 )
{
    if ( !isdefined( level.agent_definition[var_0] ) )
        return 0;

    return level.agent_definition[var_0]["behaviorTree"] != "";
}

spawn_scripted_agent( var_0, var_1, var_2, var_3 )
{
    var_0.onenteranimstate = var_0 speciesfunc( "on_enter_animstate" );
    var_0.is_scripted_agent = 1;
    var_4 = level.agent_definition[var_1]["radius"];

    if ( !isdefined( var_4 ) )
        var_4 = 15;

    var_5 = level.agent_definition[var_1]["height"];

    if ( !isdefined( var_5 ) )
        var_5 = 50;

    var_6 = level.agent_definition[var_1]["legacy"];

    if ( !isdefined( var_6 ) || isstring( var_6 ) )
        var_6 = 0;

    var_0 spawnagent( var_2, var_3, level.agent_definition[var_1]["animclass"], var_4, var_5, undefined, var_6 );
    var_0.agent_height = var_5;
    var_0.agent_radius = var_4;
    var_0.legacy = spawnstruct();
    return var_0;
}

spawn_regular_agent( var_0, var_1, var_2 )
{
    var_0.is_scripted_agent = 0;
    var_0 spawnagent( var_1, var_2 );
    return var_0;
}

is_agent_scripted( var_0 )
{
    return var_0.is_scripted_agent;
}

agent_go_to_pos( var_0, var_1, var_2, var_3, var_4 )
{
    if ( is_agent_scripted( self ) )
        self setgoalpos( var_0 );
    else
        self botsetscriptgoal( var_0, var_1, var_2, var_3, var_4 );
}

setup_agent( var_0 )
{
    var_1 = level.agent_definition[var_0];

    if ( !isdefined( var_1 ) )
        return;

    var_2 = var_1["setup_func"];

    if ( !isdefined( var_2 ) )
        return;

    self [[ var_2 ]]();
}

set_agent_species( var_0, var_1 )
{
    if ( !isdefined( level.agent_funcs[var_1] ) )
        level.agent_funcs[var_1] = [];

    var_0.species = level.agent_definition[var_1]["species"];

    if ( isdefined( var_0.species ) && !isdefined( level.species_funcs[var_0.species] ) || !isdefined( level.species_funcs[var_0.species]["on_enter_animstate"] ) )
    {
        level.species_funcs[var_0.species] = [];
        level.species_funcs[var_0.species]["on_enter_animstate"] = ::default_on_enter_animstate;
    }

    assign_agent_func( "spawn", ::default_spawn_func );
    assign_agent_func( "on_damaged", ::default_on_damage );
    assign_agent_func( "on_damaged_finished", ::default_on_damage_finished );
    assign_agent_func( "on_killed", ::default_on_killed );
}

assign_agent_func( var_0, var_1 )
{
    var_2 = self.agent_type;

    if ( !isdefined( level.agent_funcs[var_2][var_0] ) )
    {
        if ( !isdefined( level.species_funcs[self.species] ) || !isdefined( level.species_funcs[self.species][var_0] ) )
            level.agent_funcs[var_2][var_0] = var_1;
        else
            level.agent_funcs[var_2][var_0] = level.species_funcs[self.species][var_0];
    }
}

set_agent_spawn_health( var_0, var_1 )
{
    var_0 set_agent_health( level.agent_definition[var_1]["health"] );
}

get_agent_type( var_0 )
{
    return var_0.agent_type;
}

getfreeagentcount()
{
    if ( !isdefined( level.agentarray ) )
        return 0;

    var_0 = gettime();
    var_1 = 0;

    foreach ( var_3 in level.agentarray )
    {
        if ( !isdefined( var_3.isactive ) || !var_3.isactive )
        {
            if ( isdefined( var_3.waitingtodeactivate ) && var_3.waitingtodeactivate )
                continue;

            var_4 = var_3 getentitynumber();

            if ( isdefined( level.agent_available_to_spawn_time ) && isdefined( level.agent_available_to_spawn_time[var_4] ) && var_0 < level.agent_available_to_spawn_time[var_4] )
                continue;

            var_1++;
        }
    }

    return var_1;
}

getfreeagent( var_0 )
{
    var_1 = undefined;
    var_2 = gettime();

    if ( isdefined( level.agentarray ) )
    {
        foreach ( var_4 in level.agentarray )
        {
            if ( !isdefined( var_4.isactive ) || !var_4.isactive )
            {
                if ( isdefined( var_4.waitingtodeactivate ) && var_4.waitingtodeactivate )
                    continue;

                var_5 = var_4 getentitynumber();

                if ( isdefined( level.agent_available_to_spawn_time ) )
                {
                    if ( isdefined( level.agent_available_to_spawn_time[var_5] ) && var_2 < level.agent_available_to_spawn_time[var_5] )
                        continue;

                    level.agent_available_to_spawn_time[var_5] = undefined;
                }

                var_1 = var_4;
                var_1.agent_type = var_0;
                var_1 initagentscriptvariables();
                var_1 notify( "agent_in_use" );
                break;
            }
        }
    }

    return var_1;
}

initagentscriptvariables()
{
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.spawntime = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self detachall();
    initplayerscriptvariables();
}

initplayerscriptvariables()
{
    self.class = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    scripts\common\input_allow::clear_allow_info( "weapon" );
    scripts\common\input_allow::clear_allow_info( "weaponSwitch" );
    scripts\common\input_allow::clear_allow_info( "offhandWeaps" );
    scripts\common\input_allow::clear_allow_info( "usability" );
    self.nocorpse = undefined;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.ten_percent_of_max_health = undefined;
    self.command_given = undefined;
    self.current_icon = undefined;
    self.do_immediate_ragdoll = undefined;

    if ( isdefined( level.gametype_agent_init ) )
        self [[ level.gametype_agent_init ]]();
}

set_agent_team( var_0, var_1 )
{
    self.team = var_0;
    self.agentteam = var_0;
    self.pers["team"] = var_0;
    self.owner = var_1;
    self setotherent( var_1 );
    self setentityowner( var_1 );
}

add_to_characters_array()
{
    for ( var_0 = 0; var_0 < level.characters.size; var_0++ )
    {
        if ( level.characters[var_0] == self )
            return;
    }

    level.characters[level.characters.size] = self;
}

agentfunc( var_0 )
{
    return level.agent_funcs[self.agent_type][var_0];
}

speciesfunc( var_0 )
{
    return level.species_funcs[self.species][var_0];
}

validateattacker( var_0 )
{
    if ( isagent( var_0 ) && ( !isdefined( var_0.isactive ) || !var_0.isactive ) )
        return undefined;

    if ( isagent( var_0 ) && !isdefined( var_0.classname ) )
        return undefined;

    return var_0;
}

set_agent_health( var_0 )
{
    self.agenthealth = var_0;
    self.health = var_0;
    self.maxhealth = var_0;
}

default_spawn_func( var_0, var_1, var_2 )
{

}

is_friendly_damage( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        if ( isdefined( var_1.team ) && var_1.team == var_0.team )
            return 1;

        if ( isdefined( var_1.owner ) && isdefined( var_1.owner.team ) && var_1.owner.team == var_0.team )
            return 1;
    }

    return 0;
}

default_on_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    var_13 = self;
    var_14 = undefined;

    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[self.unittype] ) )
        var_14 = level.agent_funcs[self.unittype]["gametype_on_damaged"];

    if ( isdefined( var_14 ) )
        [[ var_14 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
    else
    {
        var_14 = level.agent_funcs[self.agent_type]["gametype_on_damaged"];

        if ( isdefined( var_14 ) )
            [[ var_14 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );
    }

    if ( is_friendly_damage( var_13, var_0 ) )
        return;

    if ( istrue( var_13.agentdamagefeedback ) )
    {
        var_15 = 0;

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "isKillstreakWeapon" ) )
        {
            var_15 = isdefined( var_12 ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "isKillstreakWeapon" ) ]]( var_12.basename );

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "handleDamageFeedback" ) )
                var_1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "handleDamageFeedback" ) ]]( var_0, var_1, var_13, var_2, var_4, var_12, var_8, var_3, 0, 0, var_15 );
        }
    }

    if ( isdefined( level.arenaflag_setenabled ) )
        var_13 [[ level.arenaflag_setenabled ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11 );
    else if ( isdefined( var_13.unittype ) && isdefined( level.agent_funcs[var_13.unittype] ) && isdefined( level.agent_funcs[var_13.unittype]["on_damaged_finished"] ) )
        var_13 [[ level.agent_funcs[var_13.unittype]["on_damaged_finished"] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11 );
    else
        var_13 [[ level.agent_funcs[var_13.agent_type]["on_damaged_finished"] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11 );
}

default_on_damage_finished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 )
{
    var_15 = self.health;
    var_16 = var_5;
    self.damagedby = var_1;
    self.damagepoint = var_6;
    self finishagentdamage( var_0, var_1, var_2, var_3, var_4, var_16, var_6, var_7, var_8, var_9, 0.0, var_11, var_12 );

    if ( self.health > 0 && self.health < var_15 )
    {
        self notify( "pain" );
        scripts\asm\asm_mp::_id_120B5();
    }

    if ( isalive( self ) )
    {
        if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[self.unittype] ) && isdefined( level.agent_funcs[self.unittype]["gametype_on_damage_finished"] ) )
        {
            var_17 = level.agent_funcs[self.unittype]["gametype_on_damage_finished"];

            if ( isdefined( var_17 ) )
            {
                [[ var_17 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );
                return;
            }
        }
        else if ( isdefined( self.agent_type ) )
        {
            var_17 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];

            if ( isdefined( var_17 ) )
                [[ var_17 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );
        }
    }
}

default_on_killed( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( isdefined( self.on_zombie_agent_killed_common ) )
        self [[ self.on_zombie_agent_killed_common ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );
    else
        on_humanoid_agent_killed_common( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0 );

    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[self.unittype] ) && isdefined( level.agent_funcs[self.unittype]["gametype_on_killed"] ) )
    {
        var_9 = level.agent_funcs[self.unittype]["gametype_on_killed"];

        if ( isdefined( var_9 ) )
            [[ var_9 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    }
    else
    {
        var_9 = level.agent_funcs[self.agent_type]["gametype_on_killed"];

        if ( isdefined( var_9 ) )
            [[ var_9 ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    }

    deactivateagent();
}

default_on_enter_animstate( var_0, var_1 )
{
    self.aistate = var_1;

    switch ( var_1 )
    {
        case "traverse":
            self.do_immediate_ragdoll = 1;
            scripts\asm\shared\mp\utility::dotraversal();
            self.do_immediate_ragdoll = 0;
            break;
        default:
            break;
    }

    cleardamagehistory();
}

cleardamagehistory()
{
    self.recentdamages = [];
    self.damagelistindex = 0;
}

deactivateagent()
{
    var_0 = self getentitynumber();
    level.agent_available_to_spawn_time[var_0] = gettime() + 500;
}

getnumactiveagents( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "all";

    var_1 = getactiveagentsoftype( var_0 );
    return var_1.size;
}

getactiveagentsoftype( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.agentarray ) )
        return var_1;

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3.isactive ) && var_3.isactive )
        {
            if ( var_0 == "all" || var_3.agent_type == var_0 )
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

getaliveagentsofteam( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.agentarray )
    {
        if ( isalive( var_3 ) && isdefined( var_3.team ) && var_3.team == var_0 )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

getactiveagentsofspecies( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.agentarray ) )
        return var_1;

    foreach ( var_3 in level.agentarray )
    {
        if ( isdefined( var_3.isactive ) && var_3.isactive )
        {
            if ( var_3.species == var_0 )
                var_1[var_1.size] = var_3;
        }
    }

    return var_1;
}

getaliveagents()
{
    var_0 = [];

    foreach ( var_2 in level.agentarray )
    {
        if ( isalive( var_2 ) )
            var_0[var_0.size] = var_2;
    }

    return var_0;
}

activateagent()
{
    self.isactive = 1;
    self.spawn_time = gettime();
}

autorespawnwaittime( var_0, var_1 )
{
    if ( var_0 != "MOD_CRUSH" )
        return 0;

    if ( !isdefined( var_1 ) )
        return 0;

    if ( !var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        return 0;

    return 1;
}

on_humanoid_agent_killed_common( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = autorespawnwaittime( var_3, var_0 );
    self asmdodeathtransition( self.asmname );

    if ( isdefined( self.deathanimduration ) )
        var_8 = self.deathanimduration;
    else if ( var_8 == 0 )
        var_8 = 500;

    if ( isdefined( self.fncleanupbt ) )
        self [[ self.fncleanupbt ]]();

    if ( isdefined( self.nocorpse ) )
        return;

    var_11 = self;
    self.body = self cloneagent( var_8 );

    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( isdefined( var_3 ) && var_3 == "MOD_FIRE" )
            self.ragdoll_directionscale = 0;

        if ( !istrue( self._blackboard.invehicle ) || istrue( self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll ) )
        {
            if ( var_10 )
                self.body startragdollfromvehicleimpact( var_0 );
            else if ( should_do_immediate_ragdoll( self ) )
            {
                if ( isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
                    self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
                else
                    do_immediate_ragdoll( self.body );
            }
            else
                thread delaystartragdoll( self.body, var_6, var_5, var_4, var_0, var_3 );
        }
        else
        {
            self.body enablelinkto();

            if ( istrue( self._blackboard.chosenvehicleanimpos.linktoblend ) )
                self.body linktoblendtotag( self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag, 0 );
            else
                self.body linktomoveoffset( self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag );

            if ( isdefined( self._blackboard.vehicledeathwait ) )
                thread delaystartragdoll( self.body, var_6, var_4, var_0, var_3 );
            else
                self.body thread _id_11CD1( self._blackboard.currentvehicle );
        }
    }
    else if ( istrue( self.burningtodeath ) )
    {
        if ( self isscriptable() )
        {
            var_12 = self getscriptablepartstate( "burn_to_death_by_molotov", 1 );

            if ( isdefined( var_12 ) && var_12 == "active" )
            {
                self.body setscriptablepartstate( "burn_to_death_by_molotov", "active" );
                thread _id_1306F( self.body );
                thread delaystartragdoll( self.body, var_6, var_5, var_4, var_0, var_3 );
            }
        }
    }
    else if ( var_10 )
        self.body startragdollfromvehicleimpact( var_0 );
    else if ( should_do_immediate_ragdoll( self ) )
    {
        if ( isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
            self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
        else
            do_immediate_ragdoll( self.body );
    }
    else
        thread delaystartragdoll( self.body, var_6, var_5, var_4, var_0, var_3 );
}

_id_11CD1( var_0 )
{
    self endon( "entitydeleted" );

    if ( self isragdoll() )
        return;

    if ( isdefined( var_0 ) )
    {
        for (;;)
        {
            if ( !isdefined( self ) )
                return;

            if ( !isdefined( var_0 ) || var_0 scripts\common\vehicle_code::vehicle_iscorpse() )
            {
                self unlink();
                self startragdoll();
                return;
            }

            waitframe();
        }
    }
}

should_do_immediate_ragdoll( var_0 )
{
    if ( istrue( var_0.do_immediate_ragdoll ) )
        return 1;

    if ( istrue( var_0.forceragdollimmediate ) )
        return 1;

    return 0;
}

do_immediate_ragdoll( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.ragdollhitloc ) && isdefined( var_0.ragdollimpactvector ) )
    {
        var_0 startragdollfromimpact( var_0.ragdollhitloc, var_0.ragdollimpactvector );
        return;
    }

    var_1 = 10;
    var_2 = scripts\common\utility::getdamagetype( self.damagemod );

    if ( isdefined( self.attacker ) && isplayer( self.attacker ) && var_2 == "melee" )
        var_1 = 5;

    var_3 = self.damagetaken;

    if ( var_2 == "bullet" || isdefined( self.damagemod ) && self.damagemod == "MOD_FIRE" )
        var_3 = min( var_3, 300 );

    var_4 = var_1 * var_3;
    var_5 = max( 0.3, self.damagedir[2] );
    var_6 = ( self.damagedir[0], self.damagedir[1], var_5 );

    if ( isdefined( self.ragdoll_directionscale ) )
        var_6 = var_6 * self.ragdoll_directionscale;
    else
        var_6 = var_6 * var_4;

    if ( self.forceragdollimmediate )
        var_6 = var_6 + self.prevanimdelta * 20 * 10;

    if ( isdefined( self.ragdoll_start_vel ) )
        var_6 = var_6 + self.ragdoll_start_vel * 10;

    var_7 = self.damagelocation;

    if ( isdefined( self.ragdoll_damagelocation_none ) && var_7 == "none" )
        var_7 = self.ragdoll_damagelocation_none;

    var_0 startragdollfromimpact( var_7, var_6 );
}

delaystartragdoll( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_0 ) )
    {
        var_6 = var_0 getcorpseanim();

        if ( animhasnotetrack( var_6, "ignore_ragdoll" ) )
            return;
    }

    if ( isdefined( level.noragdollents ) && level.noragdollents.size )
    {
        foreach ( var_8 in level.noragdollents )
        {
            if ( distancesquared( var_0.origin, var_8.origin ) < 65536 )
                return;
        }
    }

    waitframe();

    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 isragdoll() )
        return;

    var_6 = var_0 getcorpseanim();

    if ( animisleaf( var_6 ) )
    {
        var_10 = 0.35;
        var_11 = getnotetracktimes( var_6, "start_ragdoll" );

        if ( isdefined( var_11 ) && var_11.size > 0 )
            var_10 = var_11[0];
        else
        {
            var_11 = getnotetracktimes( var_6, "vehicle_death_ragdoll" );

            if ( isdefined( var_11 ) && var_11.size > 0 )
                var_10 = var_11[0];
        }

        var_12 = var_10 * getanimlength( var_6 ) - level.frameduration / 1000;

        if ( var_12 > 0 )
            wait( var_12 );
    }

    self unlink();

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0.ragdollhitloc ) && isdefined( var_0.ragdollimpactvector ) )
            var_0 startragdollfromimpact( var_0.ragdollhitloc, var_0.ragdollimpactvector );
        else
            var_0 startragdoll();
    }
}

_id_1306F( var_0 )
{
    var_1 = self.asm.archetype == "soldier_lw_br";

    if ( !var_1 )
        wait 0.7;

    if ( !isdefined( var_0 ) )
        return;

    var_0 setcorpsemodel( "burntbody_male_cp", 1 );

    if ( !var_1 )
        var_0 dontinterpolate();

    wait 0.95;

    if ( !isdefined( var_0 ) )
        return;

    var_0 setscriptablepartstate( "burn_to_death_by_molotov", "inactive" );
}
