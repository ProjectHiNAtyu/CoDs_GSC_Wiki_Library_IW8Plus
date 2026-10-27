// scripts\mp\agents\agent_common.gsc  (hash_39f58ea1aaec2704.gscc) (size: 3760 Bytes / 0xeb0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e62afa5 (2388832165)
// size ...... 3760 (0xeb0)
// includes .. 3   (offset: 0xddc)
// strings ... 6   (offset: 0xdf4)
// dev strs .. 9   (offset: 0xe40)
// exports ... 15  (offset: 0x9d4)
// cseg ...... 0xa5 + 0x92f (0x9d4)
// imports ... 15  (offset: 0xc2c)
// animtree1 . 0   (offset: 0xeb0)
// animtree2 . 0   (offset: 0xeb0)
#using scripts\anim\notetracks_mp;
#using scripts\asm\asm;
#using scripts\common\callbacks;

#namespace agent_common;

// Namespace agent_common/agent_added
// Params 0, eflags: 0x20
// Checksum 0x83c045e6, Offset: 0xc3
// Size: 0x76
function event_handler[agent_added] agent_added()
{
    self [[ level.initagentscriptvariables ]]();
    agentteam = "axis";
    
    if ( level.numagents % 2 == 0 )
    {
        agentteam = "allies";
    }
    
    level.numagents++;
    self sethitlocdamagetable( %"ai_lochit_dmgtable" );
    self [[ level.setagentteam ]]( agentteam );
    level.agentarray[ level.agentarray.size ] = self;
}

// Namespace agent_common/agent_damaged
// Params 1, eflags: 0x20
// Checksum 0xaf4e0c97, Offset: 0x141
// Size: 0x340
function event_handler[agent_damaged] agent_damaged( data )
{
    if ( !self.isactive )
    {
        println( "<dev string:x24>" + ( self.subclass ?? "<dev string:x56>" ) + "<dev string:x5b>" + ( self.agent_type ?? "<dev string:x56>" ) + "<dev string:x6a>" );
        return;
    }
    
    einflictor = data.einflictor;
    eattacker = data.eattacker;
    idamage = data.idamage;
    idflags = data.idflags;
    smeansofdeath = data.smeansofdeath;
    objweapon = data.weapon;
    vpoint = data.vpoint;
    vdir = data.vdir;
    shitloc = data.shitloc;
    timeoffset = data.timeoffset;
    modelindex = data.modelindex;
    partname = data.partname;
    poisedamage = data.poisedamage;
    sweapon = objweapon;
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    params = { #poisedamage:poisedamage ?? 0, #prevhelmethealth:self.helmethealth, #prevarmorhealth:self.armorhealth, #partname:partname, #modelindex:modelindex, #timeoffset:timeoffset, #shitloc:shitloc, #vdir:vdir, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #vpoint:vpoint, #idflags:idflags, #idamage:idamage, #eattacker:eattacker, #einflictor:einflictor };
    eattacker = [[ level.agentvalidateattacker ]]( eattacker, einflictor );
    agent_func = self [[ level.agentfunc ]]( "on_damaged" );
    
    if ( isdefined( agent_func ) )
    {
        self [[ agent_func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage ?? 0 );
    }
    
    /#
        var_7cf07c613689bfc1 = params.idamage;
    #/
    
    callback::callback( #"on_ai_damaged", params );
    assert( var_7cf07c613689bfc1 == params.idamage, "<dev string:x7f>" );
    
    if ( eattacker )
    {
        /#
            var_7cf07c613689bfc1 = params.idamage;
        #/
        
        params.victim = self;
        eattacker callback::callback( #"hash_2f7a081cd065e655", params );
        assert( var_7cf07c613689bfc1 == params.idamage, "<dev string:x10a>" );
    }
}

// Namespace agent_common/event_4b42c400bd809cc5
// Params 3, eflags: 0x20
// Checksum 0x5f0a0de8, Offset: 0x489
// Size: 0x52
function event_handler[event_4b42c400bd809cc5] function_98148e6ced6f6db0( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 )
{
    if ( !var_5c1822850207de16 )
    {
        return;
    }
    
    lw_agent_func = self [[ level.var_1d67c3e48637c5d6 ]]( "on_damaged_lw" );
    
    if ( isdefined( lw_agent_func ) )
    {
        self [[ lw_agent_func ]]( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 );
    }
}

// Namespace agent_common/agent_impaled
// Params 1, eflags: 0x20
// Checksum 0xd7c3604a, Offset: 0x4e3
// Size: 0x95
function event_handler[agent_impaled] agent_impaled( data )
{
    if ( isdefined( level.callbackplayerimpaled ) )
    {
        [[ level.callbackplayerimpaled ]]( data.eattacker, data.weapon, data.vpointclient, data.vpoint, data.vdir, data.shitloc, data.spartname, data.var_56243ba4fafee4a5, data.var_ea333e2537a8fa73, data.var_2e6727b4a3db5100, 1 );
    }
}

// Namespace agent_common/agent_launched
// Params 1, eflags: 0x20
// Checksum 0xb0aa18af, Offset: 0x580
// Size: 0x5e
function event_handler[agent_launched] agent_launched( data )
{
    if ( isdefined( level.var_8f62eac141f8bdb6 ) )
    {
        [[ level.var_8f62eac141f8bdb6 ]]( data.eattacker, data.weapon, data.vdir, data.magnitude, data.shitloc, 1 );
    }
}

// Namespace agent_common/agent_killed
// Params 1, eflags: 0x20
// Checksum 0x318bef8a, Offset: 0x5e6
// Size: 0x14d
function event_handler[agent_killed] agent_killed( data )
{
    self.codecallback_killed = 1;
    einflictor = data.einflictor;
    eattacker = data.eattacker;
    idamage = data.idamage;
    idflags = data.idflags;
    smeansofdeath = data.smeansofdeath;
    objweapon = data.weapon;
    vdir = data.vdir;
    shitloc = data.shitloc;
    timeoffset = data.timeoffset;
    deathanimduration = data.deathanimduration;
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    eattacker = [[ level.agentvalidateattacker ]]( eattacker, einflictor );
    agent_func = self [[ level.agentfunc ]]( "on_killed" );
    
    if ( isdefined( agent_func ) )
    {
        self thread [[ agent_func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
    }
}

// Namespace agent_common/event_ccbfafe92fbf6a91
// Params 1, eflags: 0x20
// Checksum 0xa801025e, Offset: 0x73b
// Size: 0xc
function event_handler[event_ccbfafe92fbf6a91] function_ccbfafe92fbf6a91( data )
{
    
}

// Namespace agent_common
// Params 0
// Checksum 0x47de924b, Offset: 0x74f
// Size: 0x20
function init()
{
    initagentlevelvariables();
    notetracks_mp::registernotetracks();
    level thread asm::setup_level_ents();
    level thread add_agents_to_game();
}

// Namespace agent_common
// Params 3
// Checksum 0x56a54637, Offset: 0x777
// Size: 0xe3
function connectnewagent( agent_type, team, class )
{
    agent = function_a8d80f2e90e9df6f();
    
    if ( isdefined( agent ) )
    {
        agent.connecttime = gettime();
        
        if ( isdefined( team ) )
        {
            agent [[ level.setagentteam ]]( team );
        }
        else
        {
            agent [[ level.setagentteam ]]( agent.team );
        }
        
        if ( isdefined( class ) )
        {
            agent.class_override = class;
        }
        
        if ( isdefined( level.agent_funcs[ agent_type ][ "onAIConnect" ] ) )
        {
            agent [[ agent [[ level.agentfunc ]]( "onAIConnect" ) ]]();
        }
        
        agent [[ level.addtocharactersarray ]]();
        assert( agent.connecttime == gettime(), "<dev string:x1a6>" );
    }
    
    return agent;
}

// Namespace agent_common
// Params 0
// Checksum 0xd0de1d1f, Offset: 0x863
// Size: 0x2c
function initagentlevelvariables()
{
    level.agentarray = [];
    level.numagents = 0;
    
    if ( !isdefined( level.var_b015ccbf2d22a363 ) )
    {
        level.var_b015ccbf2d22a363 = 0;
    }
}

// Namespace agent_common
// Params 0
// Checksum 0x704d335a, Offset: 0x897
// Size: 0xc7
function add_agents_to_game()
{
    level endon( #"game_ended" );
    level waittill( #"connected", player );
    maxagents = getmaxagents();
    println( "<dev string:x1ee>" + maxagents + "<dev string:x20c>" );
    agents_per_frame = getdvarint( @"hash_3c453eaf21ea4a86", -1 );
    
    while ( level.agentarray.size < maxagents )
    {
        if ( agents_per_frame != -1 && level.agentarray.size != 0 && level.agentarray.size % agents_per_frame == 0 )
        {
            waitframe();
        }
        
        agent = addagent();
        
        if ( !isdefined( agent ) )
        {
            waitframe();
            continue;
        }
    }
    
    level.var_f334a2aa4deb0aeb = 1;
}

// Namespace agent_common
// Params 1
// Checksum 0x7d3664c2, Offset: 0x966
// Size: 0x22
function set_agent_health( health )
{
    self.health = health;
    self.maxhealth = health;
}

// Namespace agent_common
// Params 1
// Checksum 0x60b32485, Offset: 0x990
// Size: 0x22
function function_9bb8f5332f51c12e( poisehealth )
{
    self.poise = poisehealth;
    self.maxpoise = poisehealth;
}

// Namespace agent_common/agent_deactivate
// Params 0, eflags: 0x20
// Checksum 0xdcf1699b, Offset: 0x9ba
// Size: 0x1a
function event_handler[agent_deactivate] on_deactivate()
{
    self notify( #"killanimscript" );
    self notify( #"terminate_ai_threads" );
}

