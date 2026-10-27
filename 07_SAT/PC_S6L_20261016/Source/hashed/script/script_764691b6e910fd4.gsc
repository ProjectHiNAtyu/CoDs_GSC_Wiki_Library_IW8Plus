// script_764691b6e910fd4  (hash_0764691b6e910fd4.gscc) (size: 901 Bytes / 0x385 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b9b1346 (2610631494)
// size ...... 901 (0x385)
// includes .. 2   (offset: 0x345)
// strings ... 4   (offset: 0x355)
// dev strs .. 0   (offset: 0x385)
// exports ... 4   (offset: 0x1f1)
// cseg ...... 0x97 + 0x15a (0x1f1)
// imports ... 6   (offset: 0x291)
// animtree1 . 0   (offset: 0x385)
// animtree2 . 0   (offset: 0x385)
#using script_7381472113d2aa0b;
#using scripts\common\callbacks;

#namespace analytics_ai;

// Namespace analytics_ai
// Params 0
// Checksum 0x63fcbd72, Offset: 0xb5
// Size: 0x3c
function init()
{
    assert( level.var_f72e312e8d48a549 );
    callback::add( "on_agent_spawned", &on_ai_spawn );
    callback::add( #"on_ai_killed", &on_ai_killed );
}

// Namespace analytics_ai
// Params 1, eflags: 0x4
// Checksum 0xa379d1b8, Offset: 0xf9
// Size: 0x8b
function private on_ai_spawn( params )
{
    ent = params.agent;
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    state = 0;
    data = ent.agent_type;
    analytics::function_8a366d2fb782aedb( "agent_spawn", ent, state, data );
    
    if ( level.gametypebundle.var_af98e016afcd1c81 )
    {
        analytics::function_8a366d2fb782aedb( "agent_team", ent, state, ent.team );
    }
}

// Namespace analytics_ai
// Params 1, eflags: 0x4
// Checksum 0xb88b49ac, Offset: 0x18c
// Size: 0x65
function private on_ai_killed( params )
{
    ent = self;
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    attacker = params.eattacker;
    attacker_weapon_name = analytics::function_70d5ce15078d923a( params, ent, attacker );
    state = 0;
    analytics::function_8a366d2fb782aedb( "agent_down", ent, state, attacker_weapon_name );
}

