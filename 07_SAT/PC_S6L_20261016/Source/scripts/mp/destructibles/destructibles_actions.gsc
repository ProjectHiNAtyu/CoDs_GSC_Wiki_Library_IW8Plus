// scripts\mp\destructibles\destructibles_actions.gsc  (hash_467dfbfe670c1b03.gscc) (size: 733 Bytes / 0x2dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4ba0faa (3568963498)
// size ...... 733 (0x2dd)
// includes .. 3   (offset: 0x2ad)
// strings ... 0   (offset: 0x2c5)
// dev strs .. 2   (offset: 0x2c5)
// exports ... 4   (offset: 0x179)
// cseg ...... 0x58 + 0x121 (0x179)
// imports ... 5   (offset: 0x219)
// animtree1 . 0   (offset: 0x2dd)
// animtree2 . 0   (offset: 0x2dd)
#using script_2e54049e99139489;
#using scripts\mp\destructibles\actions\respawn;
#using scripts\mp\destructibles\actions\spawn_loot;

#namespace destructible_actions;

// Namespace destructible_actions
// Params 0
// Checksum 0x4ecd58b2, Offset: 0x76
// Size: 0x41
function init()
{
    function_c97f8e9cb2dab4d6( #"hash_369d1e10810f20b7", &spawn_loot::execute );
    function_c97f8e9cb2dab4d6( #"respawn", &respawn::execute );
    function_c97f8e9cb2dab4d6( #"spawn_scriptable", &spawn_scriptable::execute );
}

// Namespace destructible_actions
// Params 2, eflags: 0x4
// Checksum 0xd9c7472a, Offset: 0xbf
// Size: 0x63
function private function_c97f8e9cb2dab4d6( id, action_callback )
{
    if ( !isdefined( level.destructibles.actions ) )
    {
        level.destructibles.actions = [];
    }
    
    level.destructibles.actions[ id ] = { #execute:action_callback };
}

// Namespace destructible_actions
// Params 1
// Checksum 0x351b3e77, Offset: 0x12a
// Size: 0x4e
function function_ac2ba61b9f601475( var_cc3f73473d1c4ac0 )
{
    action = level.destructibles.actions[ var_cc3f73473d1c4ac0 ];
    
    if ( !isdefined( action ) )
    {
        assertmsg( "<dev string:x24>" + var_cc3f73473d1c4ac0 + "<dev string:x5f>" );
        return;
    }
    
    return action;
}

