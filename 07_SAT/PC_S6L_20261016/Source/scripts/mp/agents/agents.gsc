// scripts\mp\agents\agents.gsc  (hash_069e2e8bebe24a71.gscc) (size: 9030 Bytes / 0x2346 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd204ba6d (3523525229)
// size ...... 9030 (0x2346)
// includes .. 26  (offset: 0x2066)
// strings ... 31  (offset: 0x2136)
// dev strs .. 8   (offset: 0x22de)
// exports ... 18  (offset: 0x13de)
// cseg ...... 0x20c + 0x11d2 (0x13de)
// imports ... 87  (offset: 0x16ae)
// animtree1 . 0   (offset: 0x2346)
// animtree2 . 0   (offset: 0x2346)
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\agents\agent_common;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_war;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\hostmigration;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\mtx_weapon;
#using scripts\mp\playerhealth;
#using scripts\mp\riotshield;
#using scripts\mp\weapons;

#namespace agents;

// Namespace agents/agents_main
// Params 0, eflags: 0x20
// Checksum 0xc170be96, Offset: 0x22a
// Size: 0x61
function event_handler[agents_main] main()
{
    if ( level.createfx_enabled )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        if ( !level.gametypebundle.var_c388baef4d3e28e8 && !level.brenableagents && !game_utility::function_c446c60d2979dbfe() )
        {
            return;
        }
    }
    
    setup_callbacks();
    
    /#
        level thread function_66a6b3cbc1bd24e8();
    #/
    
    level thread agent_common::init();
}

// Namespace agents
// Params 0
// Checksum 0xc71717ee, Offset: 0x293
// Size: 0x110
function setup_callbacks()
{
    if ( !isdefined( level.agent_funcs ) )
    {
        level.agent_funcs = [];
    }
    
    level.agent_funcs[ "player" ] = [];
    level.agent_funcs[ "player" ][ "spawn" ] = &spawn_agent_player;
    level.agent_funcs[ "player" ][ "think" ] = &bots_gametype_war::bot_war_think;
    level.agent_funcs[ "player" ][ "on_killed" ] = &on_agent_player_killed;
    level.agent_funcs[ "player" ][ "on_damaged" ] = &on_agent_player_damaged;
    level.agent_funcs[ "player" ][ "on_damaged_finished" ] = &agent_damage_finished;
    
    if ( !isdefined( level.lw_agent_funcs ) )
    {
        level.lw_agent_funcs = [];
    }
    
    level.lw_agent_funcs[ "player" ] = [];
    level.lw_agent_funcs[ "player" ][ "on_damaged_lw" ] = &function_bb4f627face4efb2;
    utility::registersharedfunc( #"ai", #"displaydamagenumber_sharedfunc", &mp_agent_damage::function_eb8ba16055d6da7c );
}

// Namespace agents
// Params 0
// Checksum 0x41e8cecd, Offset: 0x3ab
// Size: 0x19
function wait_till_agent_funcs_defined()
{
    while ( !isdefined( level.agent_funcs ) )
    {
        wait 0.05;
    }
}

/#

    // Namespace agents
    // Params 0
    // Checksum 0xe756d7c5, Offset: 0x3cc
    // Size: 0x161, Type: dev
    function function_a2792232b41f679b()
    {
        teamcounts = [];
        teamcounts[ "<dev string:x24>" ] = 0;
        teamcounts[ "<dev string:x2b>" ] = 0;
        minteam = undefined;
        
        foreach ( player in level.participants )
        {
            if ( !isdefined( teamcounts[ player.team ] ) )
            {
                teamcounts[ player.team ] = 0;
            }
            
            if ( game_utility_common::isteamparticipant( player ) )
            {
                teamcounts[ player.team ]++;
            }
        }
        
        foreach ( team, count in teamcounts )
        {
            if ( team != "<dev string:x30>" && ( !isdefined( minteam ) || teamcounts[ minteam ] > count ) )
            {
                minteam = team;
            }
        }
        
        return minteam;
    }

    // Namespace agents
    // Params 0
    // Checksum 0xd2400e8f, Offset: 0x535
    // Size: 0x1b, Type: dev
    function set_agent_team_participant()
    {
        self.agent_teamparticipant = 1;
        level.var_62f4f0f64754e5dc = 1;
    }

    // Namespace agents
    // Params 0
    // Checksum 0x1003a790, Offset: 0x558
    // Size: 0x1a7, Type: dev
    function function_66a6b3cbc1bd24e8()
    {
        setdevdvarifuninitialized( @"hash_b725de514a5e641", "<dev string:x3a>" );
        setdevdvarifuninitialized( @"hash_35fa3411ab03151f", "<dev string:x3a>" );
        
        while ( level.players.size == 0 )
        {
            wait 0.05;
        }
        
        for ( ;; )
        {
            wait 0.1;
            var_7d73cc537d38e6a2 = getdvarint( @"hash_b725de514a5e641" );
            var_f7fd143d25c0d454 = getdvarint( @"hash_35fa3411ab03151f" );
            
            if ( var_7d73cc537d38e6a2 != 0 )
            {
                setdevdvar( @"hash_b725de514a5e641", 0 );
            }
            
            if ( var_f7fd143d25c0d454 != 0 )
            {
                setdevdvar( @"hash_35fa3411ab03151f", 0 );
            }
            
            for ( i = 0; i < var_7d73cc537d38e6a2 ; i++ )
            {
                agent = add_humanoid_agent( "<dev string:x3c>", function_a2792232b41f679b(), undefined, undefined, undefined, undefined, 1, 1 );
                
                if ( isdefined( agent ) )
                {
                    agent set_agent_team_participant();
                }
            }
            
            foreach ( agent in level.agentarray )
            {
                if ( !agent.isactive )
                {
                    continue;
                }
                
                if ( agent.isactive && agent.agent_type == "<dev string:x3c>" )
                {
                    if ( var_f7fd143d25c0d454 > 0 )
                    {
                        agent agent_utility::deactivateagent();
                        agent suicide();
                        var_f7fd143d25c0d454--;
                    }
                }
            }
        }
    }

#/

// Namespace agents
// Params 14
// Checksum 0xd027685b, Offset: 0x707
// Size: 0xe7
function add_humanoid_agent( agent_type, team, class, optional_spawnorigin, optional_spawnangles, optional_owner, var_20c0952064b8615c, respawn_on_death, difficulty, classcallback, disableloadout, var_177480d46d82f6f, disablehealthregen, disablebattlechatter )
{
    agent = agent_common::connectnewagent( agent_type, team, class );
    
    if ( isdefined( classcallback ) )
    {
        assert( class == "<dev string:x43>", "<dev string:x4c>" );
        agent.classcallback = classcallback;
    }
    
    if ( isdefined( agent ) )
    {
        agent thread [[ agent agent_utility::agentfunc( "spawn" ) ]]( optional_spawnorigin, optional_spawnangles, optional_owner, var_20c0952064b8615c, respawn_on_death, difficulty, disableloadout, var_177480d46d82f6f, disablehealthregen, disablebattlechatter );
    }
    
    return agent;
}

// Namespace agents
// Params 10
// Checksum 0xc4538132, Offset: 0x7f7
// Size: 0x2fb
function spawn_agent_player( optional_spawnorigin, optional_spawnangles, optional_owner, var_20c0952064b8615c, respawn_on_death, difficulty, disableloadout, var_177480d46d82f6f, disablehealthregen, disablebattlechatter )
{
    self endon( #"disconnect" );
    
    while ( !isdefined( level.getspawnpoint ) )
    {
        waitframe();
    }
    
    if ( self.hasdied )
    {
        wait randomintrange( 6, 10 );
    }
    
    agent_utility::initplayerscriptvariables( 1 );
    
    if ( isdefined( optional_spawnorigin ) && isdefined( optional_spawnangles ) )
    {
        spawnorigin = optional_spawnorigin;
        spawnangles = optional_spawnangles;
        self.lastspawnpoint = spawnstruct();
        self.lastspawnpoint.origin = spawnorigin;
        self.lastspawnpoint.angles = spawnangles;
    }
    else
    {
        spawnpoint = self [[ level.getspawnpoint ]]();
        spawnorigin = spawnpoint.origin;
        spawnangles = spawnpoint.angles;
        self.lastspawnpoint = spawnpoint;
    }
    
    agent_utility::activateagent();
    self.lastspawntime = gettime();
    self.spawntime = gettime();
    phys_trace_start = spawnorigin + ( 0, 0, 25 );
    phys_trace_end = spawnorigin;
    newspawnorigin = playerphysicstrace( phys_trace_start, phys_trace_end );
    
    if ( distancesquared( newspawnorigin, phys_trace_start ) > 1 )
    {
        spawnorigin = newspawnorigin;
    }
    
    assertmsg( "<dev string:xaa>" );
    bots_util_mp::bot_set_personality( "default" );
    
    if ( isdefined( difficulty ) )
    {
        bots_util_mp::bot_set_difficulty( difficulty );
    }
    
    initplayerclass();
    agent_common::set_agent_health( 100 );
    
    if ( respawn_on_death )
    {
        self.respawn_on_death = 1;
    }
    
    if ( isdefined( optional_owner ) )
    {
        agent_utility::set_agent_team( optional_owner.team, optional_owner );
    }
    
    if ( isdefined( self.owner ) )
    {
        thread destroyonownerdisconnect( self.owner );
    }
    
    self enableanimstate( 0 );
    self takeallweapons();
    self [[ level.onspawnplayer ]]( 0 );
    
    if ( !disableloadout )
    {
        class::giveloadout( self.team, self.class, 1 );
    }
    
    thread bots::bot_think_watch_enemy( 1 );
    thread bots::bot_think_crate();
    thread bots_tactical_goals::think_tactical_goals();
    self thread [[ agent_utility::agentfunc( "think" ) ]]();
    
    if ( !self.hasdied )
    {
        game_utility_common::addtoparticipantsarray();
    }
    
    self.hasdied = 0;
    
    if ( !var_177480d46d82f6f )
    {
        thread weapons::onplayerspawned();
    }
    
    if ( !disablehealthregen )
    {
        thread playerhealth::manageplayerregen();
    }
    
    if ( !disablebattlechatter )
    {
        thread battlechatter_mp::onplayerspawned();
    }
    
    level notify( #"hash_9d131336aa866afd", self );
    level notify( #"spawned_agent", self );
    self notify( #"spawned_player" );
    callback::callback( #"player_spawned" );
}

// Namespace agents
// Params 1
// Checksum 0x5245913f, Offset: 0xafa
// Size: 0x42
function destroyonownerdisconnect( owner )
{
    self endon( #"death" );
    childthread watchownerstatus( "disconnect", owner );
    childthread watchownerstatus( "joined_team", owner );
    childthread watchownerstatus( "joined_spectators", owner );
}

// Namespace agents
// Params 2
// Checksum 0x50eb815b, Offset: 0xb44
// Size: 0x3c
function watchownerstatus( notifymsg, owner )
{
    owner waittill( notifymsg );
    self notify( #"owner_disconnect" );
    
    if ( hostmigration::waittillhostmigrationdone() )
    {
        wait 0.05;
    }
    
    self suicide();
}

// Namespace agents
// Params 13
// Checksum 0xa4de0c9, Offset: 0xb88
// Size: 0x152
function agent_damage_finished( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, poisedamage )
{
    if ( isalive( self ) )
    {
        if ( isdefined( einflictor ) || isdefined( eattacker ) )
        {
            if ( !isdefined( einflictor ) )
            {
                einflictor = eattacker;
            }
            
            if ( isdefined( self.allowvehicledamage ) && !self.allowvehicledamage )
            {
                if ( einflictor.classname == "script_vehicle" )
                {
                    return 0;
                }
            }
            
            if ( einflictor.classname == "auto_turret" )
            {
                eattacker = einflictor;
            }
        }
        
        assert( self.isactive );
        idamage = int( clamp( idamage, -2.68435e+08, 2.68435e+08 ) );
        self finishagentdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage );
        
        if ( !isalive( self ) && level.var_36cf9f43f205635c && isplayer( eattacker ) )
        {
            eattacker thread events::killedagent( self, smeansofdeath );
        }
        
        return 1;
    }
}

// Namespace agents
// Params 13
// Checksum 0x1198110e, Offset: 0xce2
// Size: 0x286
function on_agent_generic_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, poisedamage )
{
    var_cf8e9b1ae515338 = isdefined( eattacker ) && isdefined( self.owner ) && self.owner == eattacker;
    var_7111d00ec3ec7af5 = damage::attackerishittingteam( self.owner, eattacker ) || var_cf8e9b1ae515338;
    
    if ( !( var_cf8e9b1ae515338 && self.agent_type == "playerProxy" ) )
    {
        if ( level.teambased && var_7111d00ec3ec7af5 && !level.friendlyfire )
        {
            return 0;
        }
        
        if ( !level.teambased && var_cf8e9b1ae515338 )
        {
            return 0;
        }
    }
    
    if ( isdefined( einflictor ) && smeansofdeath == "MOD_CRUSH" && einflictor.classname == "script_vehicle" )
    {
        return 0;
    }
    
    if ( !isdefined( self ) || !player::isreallyalive() )
    {
        return 0;
    }
    
    if ( isdefined( eattacker ) && eattacker.classname == "script_origin" && eattacker.type == "soft_landing" )
    {
        return 0;
    }
    
    if ( sweapon == "killstreak_emp_mp" )
    {
        return 0;
    }
    
    if ( issubstr( sweapon, "throwingknife" ) && smeansofdeath == "MOD_IMPACT" )
    {
        idamage = self.health + 1;
    }
    
    if ( isdefined( einflictor ) && einflictor.stuckenemyentity == self )
    {
        idamage = self.health + 1;
    }
    
    if ( idamage <= 0 )
    {
        return 0;
    }
    
    if ( isdefined( eattacker ) && eattacker != self && idamage > 0 && shitloc != "shield" )
    {
        if ( idflags & 16 )
        {
            typehit = "stun";
        }
        else
        {
            typehit = "standard";
        }
        
        eattacker damagefeedback::updatedamagefeedback( typehit, idamage >= self.health );
    }
    
    if ( isdefined( level.modifyplayerdamage ) )
    {
        idamage = [[ level.modifyplayerdamage ]]( einflictor, self, eattacker, idamage, smeansofdeath, sweapon, vpoint, vdir, shitloc );
    }
    
    return self [[ agent_utility::agentfunc( "on_damaged_finished" ) ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, poisedamage );
}

// Namespace agents
// Params 13
// Checksum 0x62929e67, Offset: 0xf71
// Size: 0xf6
function on_agent_player_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    var_cf8e9b1ae515338 = isdefined( eattacker ) && isdefined( self.owner ) && self.owner == eattacker;
    
    if ( !level.teambased && var_cf8e9b1ae515338 )
    {
        return 0;
    }
    
    objweapon = utility::function_64003742d8f5c781( sweapon );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    damage::callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname );
}

// Namespace agents
// Params 3
// Checksum 0xc1872361, Offset: 0x106f
// Size: 0x4f
function function_bb4f627face4efb2( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 )
{
    damage::function_4aaeed9fade1dcd( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 );
    infopackage = agent_utils::function_d77442145c568a4e( var_5bf42dcb704ef501 );
    infopackage callback::callback( #"hash_c9f2f4a513dda6fd" );
}

// Namespace agents
// Params 10
// Checksum 0xa0042c8e, Offset: 0x10c6
// Size: 0x114
function on_agent_player_killed( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration )
{
    on_humanoid_agent_killed_common( einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, 1 );
    
    if ( isplayer( eattacker ) && !self.var_f15c9942cad3b3ac && eattacker != self.owner )
    {
        damage::onkillstreakkilled( "squad_mate", eattacker, sweapon, smeansofdeath, idamage, "destroyed_squad_mate" );
    }
    
    thread utility::callsharedfunc( #"specialty_scavenger", #"dropscavengerfordeath", eattacker );
    
    if ( self.isactive )
    {
        self.hasdied = 1;
        
        if ( game_utility_mp::getgametypenumlives() != 1 && self.respawn_on_death )
        {
            self thread [[ agent_utility::agentfunc( "spawn" ) ]]();
            return;
        }
        
        agent_utility::deactivateagent();
    }
}

// Namespace agents
// Params 10
// Checksum 0xeb51c83f, Offset: 0x11e2
// Size: 0x1a8
function on_humanoid_agent_killed_common( einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons )
{
    if ( self.hasriotshieldequipped )
    {
        damage::launchshield( idamage, smeansofdeath );
        
        if ( !dropweapons )
        {
            item = self dropitem( self getcurrentweapon() );
            
            if ( isdefined( item ) )
            {
                item thread weapons::deletepickupafterawhile();
                item.owner = self;
                item.ownersattacker = eattacker;
                item makeunusable();
            }
        }
    }
    
    if ( dropweapons )
    {
        self [[ level.weapondropfunction ]]( eattacker, smeansofdeath, undefined, idamage );
    }
    
    riotshield::riotshield_clear();
    
    if ( isdefined( self.nocorpse ) )
    {
        return;
    }
    
    self.body = self cloneagent( deathanimduration, 0, 1, 0, eattacker );
    self.body.targetname = "agent_corpse";
    self.body.aicategory = self.aicategory;
    
    if ( mtx_weapon::function_31632334e41cf319( eattacker, sweapon, smeansofdeath, shitloc, einflictor ) )
    {
        return;
    }
    
    if ( self.helmetdamaged )
    {
        self.body setscriptablepartstate( "helmet", "damaged" );
    }
    else if ( self.helmetbroken )
    {
        self.body setscriptablepartstate( "helmet", "off" );
    }
    
    thread damage::_startragdoll( self.body, smeansofdeath, einflictor );
}

// Namespace agents
// Params 0
// Checksum 0x55abe343, Offset: 0x1392
// Size: 0x4c
function initplayerclass()
{
    if ( isdefined( self.class_override ) )
    {
        self.class = self.class_override;
        return;
    }
    
    if ( bots_loadout::function_869a511557a60ad4() )
    {
        self.class = "callback";
        return;
    }
    
    self.class = "class1";
}

