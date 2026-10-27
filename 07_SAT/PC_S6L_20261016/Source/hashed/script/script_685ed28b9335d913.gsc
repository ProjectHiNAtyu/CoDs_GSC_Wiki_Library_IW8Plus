// script_685ed28b9335d913  (hash_685ed28b9335d913.gscc) (size: 1076 Bytes / 0x434 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98b02029 (2561679401)
// size ...... 1076 (0x434)
// includes .. 2   (offset: 0x3e4)
// strings ... 5   (offset: 0x3f4)
// dev strs .. 0   (offset: 0x434)
// exports ... 4   (offset: 0x234)
// cseg ...... 0x95 + 0x19f (0x234)
// imports ... 9   (offset: 0x2d4)
// animtree1 . 0   (offset: 0x434)
// animtree2 . 0   (offset: 0x434)
#using script_7381472113d2aa0b;
#using scripts\common\callbacks;

#namespace analytics_player;

// Namespace analytics_player
// Params 0
// Checksum 0xa0e1980, Offset: 0xb3
// Size: 0x40
function init()
{
    assert( level.var_f72e312e8d48a549 );
    callback::add( #"player_spawned", &on_player_spawn );
    callback::add( #"player_death", &on_player_death );
}

// Namespace analytics_player
// Params 1, eflags: 0x4
// Checksum 0x9fdcd277, Offset: 0xfb
// Size: 0xbc
function private on_player_spawn( params )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    analytics::addevent( "player_spawned", player getorigin(), 0, "", player );
    
    if ( level.gametypebundle.var_af98e016afcd1c81 )
    {
        analytics::addevent( "player_team", player getorigin(), 0, player.team, player );
    }
    
    if ( level.gametypebundle.var_fde50792af73df24 )
    {
        if ( isdefined( player.sessionsquadid ) )
        {
            analytics::addevent( "player_squad", player getorigin(), 0, "" + player.sessionsquadid, player );
        }
    }
}

// Namespace analytics_player
// Params 1, eflags: 0x4
// Checksum 0x40e0a896, Offset: 0x1bf
// Size: 0x75
function private on_player_death( params )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    attacker = params.eattacker;
    attacker_weapon_name = analytics::function_70d5ce15078d923a( params, player, attacker );
    state = analytics::_getdeathstatecode( params.deathtype );
    analytics::function_8a366d2fb782aedb( "down", player, state, attacker_weapon_name );
}

