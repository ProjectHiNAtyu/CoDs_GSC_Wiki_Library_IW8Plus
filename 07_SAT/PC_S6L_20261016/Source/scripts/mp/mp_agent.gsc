// scripts\mp\mp_agent.gsc  (hash_4db5d44a376c1c35.gscc) (size: 18042 Bytes / 0x467a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2bb74b1 (2998629553)
// size ...... 18042 (0x467a)
// includes .. 18  (offset: 0x42d2)
// strings ... 50  (offset: 0x4362)
// dev strs .. 5   (offset: 0x463e)
// exports ... 36  (offset: 0x2dea)
// cseg ...... 0x39a + 0x2a50 (0x2dea)
// imports ... 129 (offset: 0x338a)
// animtree1 . 0   (offset: 0x467a)
// animtree2 . 0   (offset: 0x467a)
#using script_2e61bcf54eaedd23;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\events;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gametypes\common;
#using scripts\mp\mtx_weapon;

#namespace mp_agent;

// Namespace mp_agent
// Params 1
// Checksum 0x151c3acb, Offset: 0x3b8
// Size: 0x87
function setupweapon( primaryweaponobject )
{
    assert( isweapon( primaryweaponobject ), "<dev string:x24>" );
    self.weapon = primaryweaponobject;
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
}

// Namespace mp_agent
// Params 8
// Checksum 0x99b76c6c, Offset: 0x447
// Size: 0xc2
function spawnnewagentaitype( aitype, position, angles, team, characterlistname, gender, var_4f627fa582a17e0f, var_cae8263562118c46 )
{
    if ( !isstartstr( aitype, "actor_" ) )
    {
        aitype = "actor_" + aitype;
    }
    
    if ( isdefined( level.var_1e2c07e345d293d1 ) )
    {
        aitype = [[ level.var_1e2c07e345d293d1 ]]( aitype );
    }
    
    if ( !isaitypenamevalid( aitype ) )
    {
        assertmsg( "<dev string:x5d>" + aitype + "<dev string:x5f>" );
        return;
    }
    
    agent = spawnnewagent( aitype, team, position, angles, undefined, characterlistname, gender, var_4f627fa582a17e0f, var_cae8263562118c46 );
    return agent;
}

// Namespace mp_agent
// Params 9
// Checksum 0xd422b22d, Offset: 0x512
// Size: 0x76
function spawnnewagent( agent_type, spawn_team, spawn_position, spawn_angles, var_156fc0c2ef9088cb, characterlistname, gender, var_4f627fa582a17e0f, var_cae8263562118c46 )
{
    agent = dospawnaitype( agent_type, spawn_position, spawn_angles, 0, 0, 1, 0, spawn_team, characterlistname, gender, var_4f627fa582a17e0f, var_cae8263562118c46 );
    return agent;
}

// Namespace mp_agent/agent_spawned
// Params 1, eflags: 0x20
// Checksum 0x59b76885, Offset: 0x591
// Size: 0xf7
function event_handler[agent_spawned] setup_agent_post_spawn( data )
{
    agent = data.agent;
    agent_type = data.agenttype;
    spawn_team = data.team;
    agent.connecttime = gettime();
    agent.spawntime = agent.connecttime;
    level.var_147ae5306edffb63 = agent.connecttime;
    agent set_pers_team( agent_type, spawn_team );
    agent set_agent_funcs();
    agent game_utility_common::addtocharactersarray();
    agent function_181b28818ecc4bf1( agent.agent_type );
    agent activateagent();
    agent utility::set_ai_number();
    agent utility::set_persistent_ai_number();
    agent notify( #"post_spawn" );
    callback::callback( "on_agent_spawned", { #agent:agent } );
}

// Namespace mp_agent
// Params 0
// Checksum 0xf658ab27, Offset: 0x690
// Size: 0x62
function set_agent_funcs()
{
    if ( !isdefined( level.agent_funcs[ self.agent_type ] ) )
    {
        level.agent_funcs[ self.agent_type ] = [];
        assign_agent_func( "on_damaged", &default_on_damage );
        assign_agent_func( "on_damaged_finished", &default_on_damage_finished );
        assign_agent_func( "on_killed", &default_on_killed );
    }
}

// Namespace mp_agent
// Params 2
// Checksum 0x3b146383, Offset: 0x6fa
// Size: 0x4d
function assign_agent_func( func_type_string, default_func )
{
    assert( !isdefined( level.agent_funcs[ self.agent_type ][ func_type_string ] ) );
    level.agent_funcs[ self.agent_type ][ func_type_string ] = default_func;
}

// Namespace mp_agent
// Params 2
// Checksum 0x6f37da4f, Offset: 0x74f
// Size: 0x4c
function override_agent_func( func_type_string, var_a7b26daee63d35b3 )
{
    assert( isdefined( level.agent_funcs[ self.agent_type ][ func_type_string ] ) );
    level.agent_funcs[ self.agent_type ][ func_type_string ] = var_a7b26daee63d35b3;
}

// Namespace mp_agent/event_bade264588c1dc83
// Params 1, eflags: 0x20
// Checksum 0x89dff1bd, Offset: 0x7a3
// Size: 0xc6
function event_handler[event_bade264588c1dc83] function_25313ee526445083( data )
{
    agent_type = data.agenttype;
    var_cae8263562118c46 = data.var_cae8263562118c46;
    aitypescriptbundle = getaitypescriptbundle( agent_type );
    subclassscriptbundle = getscriptbundle( hashcat( %"hash_138dab78b1b28a0f", aitypescriptbundle.subclass ) );
    self.agent_type = agent_type;
    self.var_cae8263562118c46 = var_cae8263562118c46;
    
    if ( isdefined( subclassscriptbundle ) && isdefined( level.var_92f18b2d64c2fd53[ subclassscriptbundle.name ] ) )
    {
        self [[ level.var_92f18b2d64c2fd53[ subclassscriptbundle.name ] ]]();
        return;
    }
    
    initagentscriptvariables();
}

// Namespace mp_agent
// Params 0
// Checksum 0xb755bfc, Offset: 0x871
// Size: 0x60
function initagentscriptvariables()
{
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self detachall();
    self.headmodel = undefined;
    initplayerscriptvariables();
}

// Namespace mp_agent
// Params 0
// Checksum 0x79a6f5f, Offset: 0x8d9
// Size: 0x10f
function initplayerscriptvariables()
{
    self.class = undefined;
    self.movespeedscaler = undefined;
    
    if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    val::nuke( "weapon" );
    val::nuke( "weapon_switch" );
    val::nuke( "offhand_weapons" );
    val::nuke( "usability" );
    self.nocorpse = undefined;
    self.ignoreme = 0;
    self.ignoreall = istrue( level.var_df336712f37ebfc0 );
    self.command_given = undefined;
    self.current_icon = undefined;
    self.do_immediate_ragdoll = undefined;
    
    if ( isdefined( level.gametype_agent_init ) )
    {
        self [[ level.gametype_agent_init ]]();
    }
}

// Namespace mp_agent
// Params 2
// Checksum 0x33786e08, Offset: 0x9f0
// Size: 0x5d
function set_pers_team( agent_type, spawn_team )
{
    if ( !isdefined( spawn_team ) )
    {
        aitypescriptbundle = getaitypescriptbundle( agent_type );
        
        if ( isdefined( aitypescriptbundle ) )
        {
            spawn_team = aitypescriptbundle.team;
        }
        else
        {
            spawn_team = "axis";
        }
    }
    
    self.pers[ "team" ] = spawn_team;
}

// Namespace mp_agent
// Params 1
// Checksum 0x8b8cc1a2, Offset: 0xa55
// Size: 0x22
function set_agent_health( health )
{
    self.health = health;
    self.maxhealth = health;
}

// Namespace mp_agent
// Params 4
// Checksum 0x99ad3465, Offset: 0xa7f
// Size: 0x150, Type: bool
function is_friendly_damage( agent, attacker, smeansofdeath, objweapon )
{
    if ( isdefined( attacker ) && isdefined( agent ) && isdefined( agent.team ) && !attacker.allowfriendlyfire )
    {
        if ( agent.aisettings.var_48e1c5af483f698d && ( agent.owner == attacker || agent.owner == attacker.owner ) )
        {
            return false;
        }
        
        if ( attacker.team == agent.team )
        {
            return true;
        }
        
        if ( isdefined( attacker.owner ) && attacker.owner.team == agent.team )
        {
            return true;
        }
        
        if ( isdefined( attacker.vehicle ) && attacker.vehicle.team == agent.team )
        {
            return true;
        }
    }
    
    if ( isdefined( attacker ) && isdefined( agent ) && attacker vehicle::is_vehicle() && vehicle_collision::function_898c68dd6412f983( attacker, agent, smeansofdeath, objweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mp_agent
// Params 14
// Checksum 0x300337df, Offset: 0xbd8
// Size: 0x31e
function default_on_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    victim = self;
    func = undefined;
    self.modifiedidflags = idflags;
    
    if ( isdefined( self.agent_damage_callback ) )
    {
        idamage = self [[ self.agent_damage_callback ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) )
    {
        func = level.agent_funcs[ self.unittype ][ "gametype_on_damaged" ];
    }
    
    if ( isdefined( func ) )
    {
        [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname );
    }
    else if ( isdefined( self.agent_type ) )
    {
        func = level.agent_funcs[ self.agent_type ][ "gametype_on_damaged" ];
        
        if ( isdefined( func ) )
        {
            [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname );
        }
    }
    
    if ( is_friendly_damage( victim, einflictor, smeansofdeath, objweapon ) )
    {
        return;
    }
    
    /#
        weapon_utility::function_926700ffa3fbe9e( idamage, eattacker, victim, smeansofdeath, shitloc, einflictor, vpoint );
    #/
    
    if ( victim.agentdamagefeedback && eattacker )
    {
        biskillstreakweapon = 0;
        
        if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
        {
            biskillstreakweapon = isdefined( objweapon ) && [[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( objweapon.basename );
            
            if ( utility::issharedfuncdefined( #"damage", #"hash_f1088336953cf1b9" ) )
            {
                eattacker [[ utility::getsharedfunc( #"damage", #"hash_f1088336953cf1b9" ) ]]( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, biskillstreakweapon );
            }
        }
    }
    
    idflags = self.modifiedidflags;
    
    if ( isdefined( victim.unittype ) && isdefined( level.agent_funcs[ victim.unittype ][ "on_damaged_finished" ] ) )
    {
        victim [[ level.agent_funcs[ victim.unittype ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage );
        return;
    }
    
    if ( isdefined( victim.agent_type ) )
    {
        assert( isdefined( level.agent_funcs[ victim.agent_type ][ "<dev string:xbb>" ] ) );
        victim [[ level.agent_funcs[ victim.agent_type ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage );
    }
}

// Namespace mp_agent
// Params 15
// Checksum 0xc18da2af, Offset: 0xefe
// Size: 0x48c
function default_on_damage_finished( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname, poisedamage, armorhit )
{
    prevhealth = self.health;
    objweapon = sweapon;
    self.damagedby = eattacker;
    self.damagetime = gettime();
    self.damagepoint = vpoint;
    
    if ( isdefined( self.var_62591663e6a187ce ) && !self.var_62591663e6a187ce )
    {
        if ( idamage >= self.health )
        {
            idamage = int( self.health - 1 );
        }
    }
    
    assert( self.isactive );
    var_d7dce04b4edc2c74 = idflags ?? 0;
    idamage = int( clamp( idamage, -2.68435e+08, 2.68435e+08 ) );
    var_6b87500226de662a = self.difficulty;
    var_407c65c25802195b = ai_utility::get_ai_tier();
    self finishagentdamage( einflictor, eattacker, idamage, var_d7dce04b4edc2c74, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage, istrue( armorhit ) );
    
    if ( self.health > 0 && self.health < prevhealth )
    {
        self notify( #"pain" );
        asm::asm_runpain( 0, 1 );
    }
    
    if ( isalive( self ) )
    {
        if ( isdefined( self.var_85111bb9ad8b0dba ) )
        {
            foreach ( func in self.var_85111bb9ad8b0dba )
            {
                self [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname );
            }
        }
        
        if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ][ "gametype_on_damage_finished" ] ) )
        {
            func = level.agent_funcs[ self.unittype ][ "gametype_on_damage_finished" ];
            
            if ( isdefined( func ) )
            {
                [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname );
            }
        }
        else if ( isdefined( self.agent_type ) )
        {
            func = level.agent_funcs[ self.agent_type ][ "gametype_on_damage_finished" ];
            
            if ( isdefined( func ) )
            {
                [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname );
            }
        }
    }
    
    if ( isweapon( einflictor.glgrenadeparent ) )
    {
        sweapon = einflictor.glgrenadeparent;
    }
    
    if ( !isalive( self ) && level.var_36cf9f43f205635c && isplayer( eattacker ) )
    {
        cleardifficulty = 0;
        
        if ( !isdefined( self.difficulty ) )
        {
            self.difficulty = var_6b87500226de662a;
            cleardifficulty = 1;
        }
        
        thread utility::callsharedfunc( #"ai", #"hash_943a38c7079b79ec", var_407c65c25802195b );
        eattacker thread events::killedagent( self, einflictor, idamage, idflags, smeansofdeath, sweapon, shitloc );
        
        if ( cleardifficulty )
        {
            self.difficulty = undefined;
        }
    }
    
    if ( eattacker.var_f3f3e16847bb9f5e )
    {
        weaponname = sweapon.basename;
        eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_damagedealt", weaponname, 12, idamage );
        var_f485a2c9a458e19a = eattacker.pers[ "weap_shotFired" ][ weaponname ] ?? 0;
        
        if ( !isdefined( eattacker.pers[ "weap_shotHit" ][ weaponname ] ) )
        {
            eattacker.pers[ "weap_shotHit" ][ weaponname ] = 0;
        }
        
        eattacker.pers[ "weap_shotHit" ][ weaponname ]++;
        shothit = eattacker.pers[ "weap_shotHit" ][ weaponname ];
        var_cef9affae1f4ddd3 = shothit / max( var_f485a2c9a458e19a, 1 ) * 100;
        eattacker thread gameplay_telemetry::function_83a6a8db9fcbb065( "weap_accuracy", objweapon.basename, 12, var_cef9affae1f4ddd3 );
    }
}

// Namespace mp_agent
// Params 10
// Checksum 0x21f0802e, Offset: 0x1392
// Size: 0x431
function default_on_killed( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration )
{
    if ( isdefined( self.on_zombie_agent_killed_common ) )
    {
        self [[ self.on_zombie_agent_killed_common ]]( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, 0 );
    }
    else
    {
        on_humanoid_agent_killed_common( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, 0 );
    }
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ][ "gametype_on_killed" ] ) )
    {
        func = level.agent_funcs[ self.unittype ][ "gametype_on_killed" ];
        
        if ( isdefined( func ) )
        {
            self [[ func ]]( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
        }
    }
    else
    {
        func = level.agent_funcs[ self.agent_type ][ "gametype_on_killed" ];
        
        if ( isdefined( func ) )
        {
            self [[ func ]]( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
        }
    }
    
    params_struct = spawnstruct();
    params_struct.einflictor = einflictor;
    params_struct.eattacker = eattacker;
    params_struct.idamage = idamage;
    params_struct.idflags = idflags;
    params_struct.smeansofdeath = smeansofdeath;
    params_struct.sweapon = objweapon;
    params_struct.vdir = vdir;
    params_struct.shitloc = shitloc;
    params_struct.timeoffset = timeoffset;
    params_struct.deathanimduration = deathanimduration;
    params_struct.victim = self;
    callback::callback( #"hash_2efd4eae7229b871", params_struct );
    callback::callback( #"on_ai_killed", params_struct );
    
    if ( isdefined( eattacker ) )
    {
        eattacker.var_4820067d5f8a5cb4 = 1;
    }
    
    params_struct.event = #"on_ai_killed";
    callback::callback( #"hash_6c71d319dc089c27", params_struct );
    thread utility::callsharedfunc( #"ai", #"droplootonagentdeath", params_struct );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.vehicle ) && isdefined( eattacker.vehicle.var_952cf197d2d0f4f3 ) )
    {
        [[ eattacker.vehicle.var_952cf197d2d0f4f3 ]]( eattacker.vehicle, self, params_struct );
    }
    else if ( isdefined( einflictor ) && isdefined( einflictor.var_952cf197d2d0f4f3 ) && smeansofdeath == "MOD_CRUSH" )
    {
        [[ einflictor.var_952cf197d2d0f4f3 ]]( einflictor, self, params_struct );
    }
    
    if ( eattacker.var_f3f3e16847bb9f5e )
    {
        if ( self.on_zombie_agent_killed_common )
        {
            eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_special_kills", objweapon.basename, 8 );
        }
        else
        {
            eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_kills", objweapon.basename, 8 );
        }
        
        if ( self.last_dmg_struct.biscritical )
        {
            eattacker gameplay_telemetry::function_383cde919fd850c4( "critical_kills", 8 );
            eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_critical_kills", objweapon.basename, 8 );
        }
        
        var_247242a4b35ed3d6 = eattacker.pers[ "weap_kills" ][ objweapon.basename ] ?? 0;
        var_4f35aee76195a79b = eattacker.pers[ "weap_special_kills" ][ objweapon.basename ] ?? 0;
        var_f710fbadb972b85b = eattacker.pers[ "weap_critical_kills" ][ objweapon.basename ] ?? 0;
        var_5a685d5f5429b84a = var_f710fbadb972b85b / max( var_4f35aee76195a79b + var_247242a4b35ed3d6, 1 ) * 100;
        eattacker gameplay_telemetry::function_83a6a8db9fcbb065( "weap_critical_accuracy", objweapon.basename, 8, var_5a685d5f5429b84a, 0 );
    }
}

// Namespace mp_agent
// Params 1
// Checksum 0x4f720401, Offset: 0x17cb
// Size: 0x2f
function getnumactiveagents( type = "all" )
{
    agents = getactiveagentsoftype( type );
    return agents.size;
}

// Namespace mp_agent
// Params 1
// Checksum 0x1ea109fb, Offset: 0x1803
// Size: 0xd6
function getactiveagentsoftype( type )
{
    assert( isdefined( type ) );
    
    if ( !isdefined( level.agentarray ) )
    {
        return [];
    }
    
    agents = [];
    
    foreach ( agent in level.agentarray )
    {
        if ( agent.isactive )
        {
            if ( type == "all" || agent.agent_type == type )
            {
                agents[ agents.size ] = agent;
            }
        }
    }
    
    return agents;
}

// Namespace mp_agent
// Params 1
// Checksum 0xe6d021f3, Offset: 0x18e2
// Size: 0xbb
function getaliveagentsofteam( team )
{
    var_d2b2c4970d4ff726 = [];
    
    foreach ( agent in level.agentarray )
    {
        if ( isalive( agent ) && isdefined( agent.team ) && agent.team == team )
        {
            var_d2b2c4970d4ff726[ var_d2b2c4970d4ff726.size ] = agent;
        }
    }
    
    return var_d2b2c4970d4ff726;
}

// Namespace mp_agent
// Params 0
// Checksum 0x81888194, Offset: 0x19a6
// Size: 0x38
function activateagent()
{
    /#
        if ( !self.isactive )
        {
            assert( self.connecttime == gettime(), "<dev string:xcf>" );
        }
    #/
    
    self.isactive = 1;
}

// Namespace mp_agent
// Params 2
// Checksum 0x83ca035a, Offset: 0x19e6
// Size: 0x3b, Type: bool
function ai_washitbyvehicle( meansofdeath, attacker )
{
    if ( meansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( !attacker vehicle::is_vehicle() )
    {
        return false;
    }
    
    return true;
}

// Namespace mp_agent
// Params 10
// Checksum 0x5aea9c82, Offset: 0x1a2a
// Size: 0x740
function on_humanoid_agent_killed_common( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons )
{
    bwashitbyvehicle = ai_washitbyvehicle( smeansofdeath, einflictor );
    
    if ( self.var_f654ebe2aeab29f7 )
    {
        if ( !self.var_fd5c989cd241b6c4 )
        {
            self asmdodeathtransition( self.asmname );
        }
    }
    else
    {
        self asmdodeathtransition( self.asmname );
    }
    
    if ( isdefined( self.deathanimduration ) )
    {
        deathanimduration = self.deathanimduration;
    }
    else if ( deathanimduration == 0 )
    {
        deathanimduration = 500;
    }
    
    if ( isdefined( self.fncleanupbt ) )
    {
        self [[ self.fncleanupbt ]]();
    }
    
    if ( isdefined( self.nocorpse ) )
    {
        if ( isplayer( eattacker ) )
        {
            eattacker mtx_weapon::function_ba18c5b844baaeae( self, objweapon, smeansofdeath );
        }
        
        return;
    }
    
    victim = self;
    
    if ( level.var_5e4d3c587acb273d )
    {
        ai_parachute_util::function_627158859ffddc38();
    }
    
    callback::callback( "pre_killed_body_cloned" );
    
    if ( self.noragdoll || self.script_noragdoll )
    {
        iscorpsefalling = self.iscorpsefalling ?? 1;
        
        if ( self.var_fd5c989cd241b6c4 )
        {
            iscorpsefalling = 0;
        }
        
        self.body = self cloneagent( deathanimduration, 1, iscorpsefalling, 1, eattacker );
    }
    else if ( ai::is_doing_traversal( self ) )
    {
        self.body = self cloneagent( deathanimduration, 1, 1, 0, eattacker, objweapon );
    }
    else
    {
        self.body = self cloneagent( deathanimduration, 0, 1, 0, eattacker, objweapon );
    }
    
    if ( !isdefined( self.body ) )
    {
        return;
    }
    
    if ( !isdefined( self.body.team ) )
    {
        self.body.team = self.team;
    }
    
    if ( isdefined( self.var_16e99c168b31e75d ) )
    {
        self.body.var_16e99c168b31e75d = self.var_16e99c168b31e75d;
    }
    
    self.body.aicategory = self.aicategory;
    
    if ( mtx_weapon::function_31632334e41cf319( eattacker, objweapon, smeansofdeath, shitloc, einflictor ) )
    {
        return;
    }
    
    var_8a9153cbbf758937 = spawnstruct();
    var_8a9153cbbf758937.body = self.body;
    var_8a9153cbbf758937.eattacker = eattacker;
    var_8a9153cbbf758937.smeansofdeath = smeansofdeath;
    var_8a9153cbbf758937.script_parameters = self.script_parameters;
    var_8a9153cbbf758937.objweapon = objweapon;
    callback::callback( "killed_body_cloned", var_8a9153cbbf758937 );
    
    if ( self.var_2726e44ca10e0a06 && !self isintraverse() )
    {
        death_anim = self.body getcorpseanim();
        stand_death = animhasnotetrack( death_anim, "stand_death" );
        
        if ( self.var_df03542cdd7c5f0b && stand_death )
        {
            up = ( 0, 0, 1 );
        }
        else
        {
            up = self function_4f4e3354d6089d6d();
        }
        
        if ( lengthsquared( up ) > 0 )
        {
            var_4660f0e6cdf245db = anglestoforward( self.angles );
            right = vectorcross( var_4660f0e6cdf245db, up );
            forward = vectorcross( up, right );
            self.body.angles = axistoangles( forward, right, up );
        }
    }
    
    self.weapondroporigin = self gettagorigin( "tag_weapon_right", 1 );
    self.weapondropangles = self gettagangles( "tag_weapon_right", 1 );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( smeansofdeath == "MOD_FIRE" )
        {
            self.ragdoll_directionscale = 0;
        }
        
        if ( self.burningtodeath )
        {
            if ( self isscriptable() && self.body isscriptable() )
            {
                currentstate = self getscriptablepartstate( "burn_to_death_by_molotov", 1 );
                
                if ( currentstate == "active" )
                {
                    self.body setscriptablepartstate( "burn_to_death_by_molotov", "active", 1 );
                    thread updateburningtodeath( self.body );
                }
            }
        }
        
        if ( !self._blackboard.invehicle || self._blackboard.chosenvehicleanimpos_deathragdoll || self.diedintransition )
        {
            if ( bwashitbyvehicle )
            {
                assert( isdefined( self.lastattacker ) );
                self.body startragdollfromvehicleimpact( einflictor );
            }
            else if ( ai::should_do_immediate_ragdoll() || self.diedintransition && !isdefined( self._blackboard.vehicledeathwait ) )
            {
                if ( isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
                {
                    self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
                }
                else
                {
                    do_immediate_ragdoll( self.body );
                }
            }
            else
            {
                thread delaystartragdoll( self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath );
            }
        }
        else
        {
            thread function_ebcfbef8daff423d( shitloc, objweapon, einflictor, smeansofdeath );
        }
    }
    else if ( self.burningtodeath )
    {
        if ( self isscriptable() && self.body isscriptable() )
        {
            currentstate = self getscriptablepartstate( "burn_to_death_by_molotov", 1 );
            
            if ( currentstate == "active" )
            {
                self.body setscriptablepartstate( "burn_to_death_by_molotov", "active", 1 );
                thread updateburningtodeath( self.body );
                thread delaystartragdoll( self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath );
            }
        }
    }
    else if ( bwashitbyvehicle )
    {
        assert( isdefined( self.lastattacker ) );
        
        if ( self.var_c837be1b82645ee5 )
        {
            offset = self.var_d910b0444df26d0a ?? ( 0, 0, 0 );
            imp = self.var_d1da80fea1e9d5b7 ?? 1;
            v_launch = ( vdir + offset ) * imp;
            self.body startragdollfromimpact( "torso_lower", v_launch );
        }
        else
        {
            self.body startragdollfromvehicleimpact( einflictor );
        }
    }
    else if ( ai::should_do_immediate_ragdoll() )
    {
        if ( isdefined( self.body ) && isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
        {
            self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
        }
        else
        {
            do_immediate_ragdoll( self.body );
        }
    }
    else
    {
        thread delaystartragdoll( self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath );
    }
    
    if ( self.var_ea900b480a55e803 )
    {
        self thread [[ self.var_ea900b480a55e803 ]]( self.body );
    }
}

// Namespace mp_agent
// Params 4, eflags: 0x4
// Checksum 0x1e2f5ef2, Offset: 0x2172
// Size: 0x1d1
function private function_ebcfbef8daff423d( shitloc, objweapon, einflictor, smeansofdeath )
{
    corpse = self.body;
    linkvehicle = self._blackboard.currentvehicle;
    linktoblend = self._blackboard.chosenvehicleanimpos_linktoblend;
    sittag = self._blackboard.chosenvehicleanimpos_sittag;
    vehicledeathwait = self._blackboard.vehicledeathwait;
    assignedposition = self._blackboard.var_25799974c1f2939b;
    deathanim = corpse getcorpseanim();
    ragdollnotetracks = getnotetracktimes( deathanim, "start_ragdoll" );
    shouldragdoll = ragdollnotetracks.size > 0;
    
    if ( level.var_c533d12f2be6403 && self._blackboard.currentvehicle vehicle::is_destroyed() )
    {
        linkvehicle = linkvehicle vehicle::function_821726d09177a949();
    }
    
    if ( !isdefined( linkvehicle ) && isdefined( corpse ) )
    {
        corpse delete();
        return;
    }
    
    corpse enablelinkto();
    
    if ( linktoblend )
    {
        corpse linktoblendtotag( linkvehicle, sittag, 0 );
    }
    else
    {
        corpse linktomoveoffset( linkvehicle, sittag );
    }
    
    if ( ( isdefined( vehicledeathwait ) || shouldragdoll ) && !self._blackboard.invehicle )
    {
        thread delaystartragdoll( corpse, shitloc, objweapon, einflictor, smeansofdeath );
        return;
    }
    
    corpse thread ragdoll_on_vehicle_death( linkvehicle );
    seatid = vehicle_ai::get_ai_rider_seat_id( linkvehicle, assignedposition );
    
    if ( isdefined( seatid ) )
    {
        thread function_bc6f746dcad17dcb( corpse, linkvehicle, seatid, 1 );
    }
}

// Namespace mp_agent
// Params 4
// Checksum 0x42a3bd98, Offset: 0x234b
// Size: 0x78
function function_bc6f746dcad17dcb( corpse, vehicle, seatid, deleteonseatenter )
{
    corpse endon( #"death" );
    corpse endon( #"cancel_delete_corpse" );
    
    if ( !vehicle.isdestroyed )
    {
        vehicle_occupancy::function_7730eb57fd31aeea( corpse, vehicle, seatid, deleteonseatenter );
    }
    
    vehicle waittill( #"death" );
    
    if ( isdefined( corpse ) )
    {
        corpse delete();
    }
}

// Namespace mp_agent
// Params 1
// Checksum 0xae22d264, Offset: 0x23cb
// Size: 0x5d
function ragdoll_on_vehicle_death( vehicle )
{
    self endon( #"entitydeleted" );
    
    if ( !self || self isragdoll() )
    {
        return;
    }
    
    if ( isdefined( vehicle ) )
    {
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( vehicle ) || vehicle vehicle_code::vehicle_iscorpse() )
            {
                self unlink();
                self startragdoll();
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace mp_agent
// Params 1
// Checksum 0xdc419281, Offset: 0x2430
// Size: 0x1ce
function do_immediate_ragdoll( agent_body )
{
    if ( !isdefined( agent_body ) )
    {
        return;
    }
    
    if ( isdefined( agent_body.ragdollhitloc ) && isdefined( agent_body.ragdollimpactvector ) )
    {
        agent_body startragdollfromimpact( agent_body.ragdollhitloc, agent_body.ragdollimpactvector );
        return;
    }
    
    initialimpulse = 10;
    damagetype = utility::getdamagetype( self.damagemod );
    
    if ( isplayer( self.attacker ) && damagetype == #"melee" )
    {
        initialimpulse = 5;
    }
    
    damagetaken = self.damagetaken;
    
    if ( damagetype == #"bullet" || self.damagemod == "MOD_FIRE" )
    {
        damagetaken = min( damagetaken, 300 );
    }
    
    directionscale = initialimpulse * damagetaken;
    directionup = max( 0.3, self.damagedir[ 2 ] );
    direction = ( self.damagedir[ 0 ], self.damagedir[ 1 ], directionup );
    
    if ( isdefined( self.ragdoll_directionscale ) )
    {
        direction *= self.ragdoll_directionscale;
    }
    else
    {
        direction *= directionscale;
    }
    
    if ( self.forceragdollimmediate )
    {
        direction += self.prevanimdelta * 20 * 10;
    }
    
    if ( isdefined( self.ragdoll_start_vel ) )
    {
        direction += self.ragdoll_start_vel * 10;
    }
    
    damagelocation = self.damagelocation;
    
    if ( isdefined( self.ragdoll_damagelocation_none ) && damagelocation == "none" )
    {
        damagelocation = self.ragdoll_damagelocation_none;
    }
    
    agent_body startragdollfromimpact( damagelocation, direction );
}

// Namespace mp_agent
// Params 6
// Checksum 0x6f7bbaa9, Offset: 0x2606
// Size: 0x353
function delaystartragdoll( ent, shitloc, vdir, objweapon, einflictor, smeansofdeath )
{
    if ( isdefined( ent ) )
    {
        deathanim = ent getcorpseanim();
        
        if ( animhasnotetrack( deathanim, "ignore_ragdoll" ) )
        {
            return;
        }
        
        if ( animhasnotetrack( deathanim, "annihilate" ) )
        {
            times = getnotetracktimes( deathanim, "annihilate" );
            waittime = times[ 0 ] * getanimlength( deathanim );
            params = spawnstruct();
            params.corpse = ent;
            params.annihilate_time = waittime;
            callback::callback( "on_corpse_annihilated", params );
            
            if ( waittime > 0 )
            {
                wait waittime;
            }
            
            if ( isdefined( ent ) )
            {
                ent delete();
            }
            
            return;
        }
    }
    
    if ( isdefined( level.noragdollents ) && level.noragdollents.size )
    {
        foreach ( norag in level.noragdollents )
        {
            if ( distancesquared( ent.origin, norag.origin ) < 65536 )
            {
                return;
            }
        }
    }
    
    var_4b1f4a1f1d71aec = undefined;
    
    if ( isdefined( self._blackboard.vehicledeathwait ) )
    {
        var_4b1f4a1f1d71aec = self._blackboard.vehicledeathwait;
    }
    
    b_ignore_ragdoll = self.noragdoll || self.script_noragdoll;
    waitframe();
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( ent isragdoll() || b_ignore_ragdoll )
    {
        return;
    }
    
    deathanim = ent getcorpseanim();
    
    if ( animisleaf( deathanim ) )
    {
        startfrac = 0.35;
        waittime = 0;
        
        if ( isdefined( var_4b1f4a1f1d71aec ) )
        {
            waittime = var_4b1f4a1f1d71aec;
        }
        else
        {
            hasnote = 0;
            times = getnotetracktimes( deathanim, "StartRagdoll" );
            
            if ( !times.size )
            {
                times = getnotetracktimes( deathanim, "start_ragdoll" );
            }
            
            if ( times.size > 0 )
            {
                noteindex = isdefined( ent.var_16e99c168b31e75d ) ? minint( ent.var_16e99c168b31e75d, times.size - 1 ) : 0;
                startfrac = times[ noteindex ];
                hasnote = 1;
            }
            else
            {
                times = getnotetracktimes( deathanim, "vehicle_death_ragdoll" );
                
                if ( times.size > 0 )
                {
                    startfrac = times[ 0 ];
                    hasnote = 1;
                }
            }
            
            waittime = startfrac * getanimlength( deathanim ) - level.frameduration / 1000;
            
            if ( !hasnote && waittime > 0.2 )
            {
                waittime = 0.2;
            }
        }
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
    }
    
    if ( isdefined( ent ) )
    {
        ent unlink();
        
        if ( isdefined( ent.ragdollhitloc ) && isdefined( ent.ragdollimpactvector ) )
        {
            ent startragdollfromimpact( ent.ragdollhitloc, ent.ragdollimpactvector );
            return;
        }
        
        ent startragdoll();
    }
}

// Namespace mp_agent
// Params 1
// Checksum 0xb17d3f22, Offset: 0x2961
// Size: 0x4e
function updateburningtodeath( corpse )
{
    wait 0.7;
    
    if ( !isdefined( corpse ) )
    {
        return;
    }
    
    corpse setcorpsemodel( "burntbody_male_cp", 1 );
    corpse dontinterpolate();
    wait 0.95;
    
    if ( !isdefined( corpse ) )
    {
        return;
    }
    
    corpse setscriptablepartstate( "burn_to_death_by_molotov", "inactive" );
}

// Namespace mp_agent
// Params 2
// Checksum 0x3f9acaef, Offset: 0x29b7
// Size: 0x119
function agent_hack( hackeffect, attacker )
{
    stunduration = hackeffect.hackduration * 0.001;
    var_d70b6e1d3d832b04 = [];
    
    if ( hackeffect.radiuseffect )
    {
        var_d70b6e1d3d832b04 = getaiarrayinradius( self.origin, hackeffect.radiuseffect );
    }
    else
    {
        var_d70b6e1d3d832b04[ var_d70b6e1d3d832b04.size ] = self;
    }
    
    for ( i = 0; i < var_d70b6e1d3d832b04.size ; i++ )
    {
        if ( !var_d70b6e1d3d832b04[ i ] function_4de5a741f5baa1c4( attacker, self, hackeffect ) )
        {
            continue;
        }
        
        tiernumber = var_d70b6e1d3d832b04[ i ] ai_utility::get_power_tier();
        
        if ( var_d70b6e1d3d832b04[ i ] function_bea36bbf42cd9ef2( hackeffect, tiernumber ) )
        {
            var_c54499ef1638be1a = var_d70b6e1d3d832b04[ i ] == self;
            var_d70b6e1d3d832b04[ i ] stun_target( attacker, stunduration );
            var_d70b6e1d3d832b04[ i ] thread shock_fx( stunduration, var_c54499ef1638be1a );
        }
        
        if ( !hackeffect.var_47082987d0ec87bc || tiernumber <= hackeffect.var_47082987d0ec87bc )
        {
            var_d70b6e1d3d832b04[ i ] function_d568862d5233ca9e( hackeffect, attacker, self );
        }
    }
}

// Namespace mp_agent
// Params 2
// Checksum 0x58e4b48b, Offset: 0x2ad8
// Size: 0x83
function stun_target( attacker, stunduration )
{
    if ( self.type == "human" )
    {
        self notify( #"flashbang", self.origin, 1, undefined, attacker, attacker.team, stunduration );
        return;
    }
    
    if ( self.type == "zombie" )
    {
        utility::callsharedfunc( #"zombie", #"stunZombie", stunduration, "stunned_on" );
    }
}

// Namespace mp_agent
// Params 2
// Checksum 0x454f3b21, Offset: 0x2b63
// Size: 0x90
function shock_fx( stunduration, var_3a999dcddbba9472 )
{
    self endon( #"death" );
    firstshock = gettime() > self._blackboard.var_ba9517cfc0287af8 + stunduration;
    self._blackboard.var_ba9517cfc0287af8 = gettime();
    
    if ( self asmhaspainstate( self.asmname ) && firstshock )
    {
        self asmevalpaintransition( self.asmname );
    }
    
    function_a66ea1eb4963bfe2( stunduration, var_3a999dcddbba9472 );
}

// Namespace mp_agent
// Params 2
// Checksum 0x66f00fd7, Offset: 0x2bfb
// Size: 0x5c
function function_a66ea1eb4963bfe2( stunduration, var_3a999dcddbba9472 )
{
    scriptable_part_name = var_3a999dcddbba9472 ? "areaShockVfx" : "shockStickVfx";
    self setscriptablepartstate( scriptable_part_name, "vfx_start", 0 );
    wait stunduration;
    
    if ( self getscriptablehaspart( scriptable_part_name ) )
    {
        self setscriptablepartstate( scriptable_part_name, "off", 0 );
    }
}

// Namespace mp_agent
// Params 3, eflags: 0x4
// Checksum 0x60223db6, Offset: 0x2c5f
// Size: 0x86
function private function_d568862d5233ca9e( hackeffect, attacker, hackedagent )
{
    if ( self == hackedagent )
    {
        return;
    }
    
    if ( self.type == "human" )
    {
        damage = hackeffect.var_398a78eb264487c3;
    }
    
    if ( self.type == "zombie" )
    {
        damage = hackeffect.var_80d4290702cc01dc;
    }
    
    if ( damage )
    {
        self dodamage( damage, self.origin, attacker );
    }
}

// Namespace mp_agent
// Params 3, eflags: 0x4
// Checksum 0xcf4127b4, Offset: 0x2ced
// Size: 0x4f, Type: bool
function private function_4de5a741f5baa1c4( attacker, var_67ccc474ab998ba7, hackeffect )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.team == attacker.team )
    {
        return false;
    }
    
    if ( var_67ccc474ab998ba7 == self )
    {
        return true;
    }
    
    return true;
}

// Namespace mp_agent
// Params 2, eflags: 0x4
// Checksum 0x95c46b4f, Offset: 0x2d45
// Size: 0xa4, Type: bool
function private function_bea36bbf42cd9ef2( hackeffect, tiernumber )
{
    var_92a1730c6ab8a04c = self.type == "human" && hackeffect.var_58062cd20f70e709;
    var_1d073b07cc05e913 = self.type == "zombie" && hackeffect.var_26c551d2cb58f72c;
    isvalidtier = !hackeffect.var_f9d25cb8241a9af1 || tiernumber <= hackeffect.var_f9d25cb8241a9af1;
    
    if ( isvalidtier && ( var_92a1730c6ab8a04c || var_1d073b07cc05e913 ) )
    {
        return true;
    }
    
    return false;
}

