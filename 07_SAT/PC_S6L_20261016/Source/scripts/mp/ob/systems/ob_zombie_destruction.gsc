// scripts\mp\ob\systems\ob_zombie_destruction.gsc  (hash_5bb6a0c0d722d2ea.gscc) (size: 1528 Bytes / 0x5f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27246045 (656695365)
// size ...... 1528 (0x5f8)
// includes .. 3   (offset: 0x5b0)
// strings ... 4   (offset: 0x5c8)
// dev strs .. 0   (offset: 0x5f8)
// exports ... 4   (offset: 0x3b8)
// cseg ...... 0x80 + 0x338 (0x3b8)
// imports ... 12  (offset: 0x458)
// animtree1 . 0   (offset: 0x5f8)
// animtree2 . 0   (offset: 0x5f8)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\scene;
#using scripts\common\utility;

#namespace ob_zombie_destruction;

// Namespace ob_zombie_destruction
// Params 4
// Checksum 0xc0e5c055, Offset: 0x9e
// Size: 0x1f7
function function_887430a227947d29( scriptable, attractor_team, var_28d5052d4ec66a5c, var_5d734d0da2864457 )
{
    var_fc48cc6608c8d82c = scriptable utility::get_linked_structs();
    attractor = zombie_attractor_manager::add_attractor( scriptable, undefined, undefined, 1, undefined, undefined, 0, attractor_team );
    zombie_attractor_manager::set_attractor_slots( attractor, var_fc48cc6608c8d82c );
    
    foreach ( slot in var_fc48cc6608c8d82c )
    {
        level thread function_de8be5aba2bf9781( slot );
    }
    
    attractor.var_f5851b55e83fd222 = 0;
    
    while ( attractor.var_f5851b55e83fd222 < var_28d5052d4ec66a5c )
    {
        wait 1;
        
        if ( !function_df2f91d99e311918( attractor ) )
        {
            attractor.var_f5851b55e83fd222 = 0;
            continue;
        }
        
        attractor.var_f5851b55e83fd222++;
    }
    
    if ( isdefined( var_5d734d0da2864457 ) )
    {
        [[ var_5d734d0da2864457 ]]( scriptable, attractor );
        return;
    }
    
    zombie_attractor_manager::remove_attractor( scriptable );
    scriptable setscriptablepartstate( "base", "dead" );
    
    foreach ( slot in attractor.var_fc48cc6608c8d82c )
    {
        if ( isdefined( slot.target ) )
        {
            scene_struct = utility::getstruct( slot.target, "targetname" );
            scene_struct thread scene::play( slot.var_80be1da0fa595ce1, "shot_1" );
        }
    }
}

// Namespace ob_zombie_destruction
// Params 1, eflags: 0x4
// Checksum 0x270e8069, Offset: 0x29d
// Size: 0xa8, Type: bool
function private function_df2f91d99e311918( attractor )
{
    num_slots_filled = 0;
    
    foreach ( slot in attractor.var_fc48cc6608c8d82c )
    {
        num_slots_filled += slot.var_9bbd36b991be9153;
    }
    
    return num_slots_filled >= attractor.var_fc48cc6608c8d82c.size;
}

// Namespace ob_zombie_destruction
// Params 1, eflags: 0x4
// Checksum 0x7c2a1ee8, Offset: 0x34e
// Size: 0x6a
function private function_de8be5aba2bf9781( slot )
{
    slot.var_9bbd36b991be9153 = 0;
    
    while ( isdefined( slot ) )
    {
        slot.var_9bbd36b991be9153 = isdefined( slot.var_80be1da0fa595ce1 ) && distancesquared( slot.var_80be1da0fa595ce1.origin, slot.origin ) < squared( 50 );
        waitframe();
    }
}

