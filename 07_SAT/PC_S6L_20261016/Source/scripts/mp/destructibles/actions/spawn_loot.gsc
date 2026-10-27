// scripts\mp\destructibles\actions\spawn_loot.gsc  (hash_31745f90afc66988.gscc) (size: 1163 Bytes / 0x48b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8e19494 (3101791380)
// size ...... 1163 (0x48b)
// includes .. 2   (offset: 0x46f)
// strings ... 1   (offset: 0x47f)
// dev strs .. 0   (offset: 0x48b)
// exports ... 2   (offset: 0x2eb)
// cseg ...... 0x61 + 0x28a (0x2eb)
// imports ... 11  (offset: 0x33b)
// animtree1 . 0   (offset: 0x48b)
// animtree2 . 0   (offset: 0x48b)
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace spawn_loot;

// Namespace spawn_loot
// Params 1
// Checksum 0xcc87a2eb, Offset: 0x7f
// Size: 0x26c
function execute( params )
{
    spawn_list = params.itemspawnlist;
    
    if ( getgametypenamekey() == "zm_rb" && isarray( params.var_f8e0a540d478b98b ) )
    {
        round_number = [[ level.zm_get_round_number ]]() ?? 1;
        
        for ( i = 0; i < params.var_f8e0a540d478b98b.size ; i++ )
        {
            if ( round_number >= params.var_f8e0a540d478b98b[ i ].fromround )
            {
                spawn_list = params.var_f8e0a540d478b98b[ i ].itemspawnlist;
            }
        }
    }
    
    vector_right = anglestoright( self.angles ) * params.spawndirection.x;
    var_e3eb0afdf490177f = anglestoforward( self.angles ) * params.spawndirection.y;
    vector_up = anglestoup( self.angles ) * params.spawndirection.z;
    spawn_vector = vector_right + var_e3eb0afdf490177f + vector_up;
    spawn_target_position = utility::drop_to_ground( self.origin + spawn_vector, 1 );
    spawn_target_position = getclosestpointonnavmesh( spawn_target_position );
    spawn_options = common_item::function_b94327aa4c1b718b( spawn_target_position, self );
    
    if ( params.var_c580c0e8b49f1fcc )
    {
        nearbyplayers = getplayersinradius( self.origin, params.var_8ec0c623ded38805 );
        
        foreach ( player in nearbyplayers )
        {
            if ( !isdefined( spawn_options.var_4a4b419f66681601 ) )
            {
                spawn_options.var_4a4b419f66681601 = [];
            }
            
            spawn_options.var_4a4b419f66681601[ spawn_options.var_4a4b419f66681601.size ] = player;
        }
    }
    
    level common_item::function_38cde6a6acb68ea6( spawn_list, params.itemcount, spawn_options );
}

