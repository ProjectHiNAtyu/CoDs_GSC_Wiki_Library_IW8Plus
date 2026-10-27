// scripts\autotests\autotests_utility_scriptables.gsc  (hash_7ec1ba545eb47163.gscc) (size: 965 Bytes / 0x3c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c4fed12 (2354048274)
// size ...... 965 (0x3c5)
// includes .. 1   (offset: 0x399)
// strings ... 3   (offset: 0x3a1)
// dev strs .. 0   (offset: 0x3c5)
// exports ... 4   (offset: 0x251)
// cseg ...... 0x8c + 0x1c5 (0x251)
// imports ... 6   (offset: 0x2f1)
// animtree1 . 0   (offset: 0x3c5)
// animtree2 . 0   (offset: 0x3c5)
#using scripts\common\utility;

#namespace autotests_utility_scriptables;

// Namespace autotests_utility_scriptables/testautomation
// Params 0, eflags: 0x20
// Checksum 0x47ec0d81, Offset: 0xaa
// Size: 0x58
function event_handler[testautomation] main()
{
    var_1e9cdd9c40f70f04 = [];
    var_1e9cdd9c40f70f04[ "super_tac_cover" ] = #"tactical_cover";
    var_1e9cdd9c40f70f04[ "sentry_gun" ] = #"sentry_gun";
    var_1e9cdd9c40f70f04[ "intel_scrambler" ] = #"intel_scrambler";
    level.autotests.var_d83422d4f965577b = var_1e9cdd9c40f70f04;
}

// Namespace autotests_utility_scriptables
// Params 2
// Checksum 0x375d0d63, Offset: 0x10a
// Size: 0x119
function function_9902d3be8a6f6a01( player, radius = 250 )
{
    scriptables = getscriptablearrayinradius( undefined, undefined, player.origin, radius );
    
    foreach ( scriptable in scriptables )
    {
        if ( ischaracter( scriptable ) )
        {
            continue;
        }
        
        destroykey = function_54ccde962402e403( scriptable );
        
        if ( destroykey && level.autotests.var_d83422d4f965577b[ destroykey ] )
        {
            scriptable utility::callsharedfunc( level.autotests.var_d83422d4f965577b[ destroykey ], #"destroy" );
            wait 2;
            continue;
        }
        
        scriptable delete();
    }
}

// Namespace autotests_utility_scriptables
// Params 1, eflags: 0x4
// Checksum 0x1d4e66cb, Offset: 0x22b
// Size: 0x25, Type: bool
function private function_54ccde962402e403( scriptable )
{
    return scriptable.superref ?? scriptable.streakname;
}

