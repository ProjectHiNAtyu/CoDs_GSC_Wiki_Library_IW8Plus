// scripts\mp\zm\systems\zm_livingworld_vo.gsc  (hash_1d7912161f42fb0c.gscc) (size: 1823 Bytes / 0x71f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5ddefe9 (3856527337)
// size ...... 1823 (0x71f)
// includes .. 1   (offset: 0x677)
// strings ... 13  (offset: 0x67f)
// dev strs .. 0   (offset: 0x71f)
// exports ... 4   (offset: 0x4eb)
// cseg ...... 0x162 + 0x389 (0x4eb)
// imports ... 8   (offset: 0x58b)
// animtree1 . 0   (offset: 0x71f)
// animtree2 . 0   (offset: 0x71f)
#using scripts\anim\dialogue;

#namespace zm_livingworld_vo;

// Namespace zm_livingworld_vo
// Params 1
// Checksum 0xd78b14b3, Offset: 0x180
// Size: 0x202
function function_897af5e2d6e4c0ce( human )
{
    human endon( #"death" );
    var_bf9e5f176507cd2a = randomintrange( 1, 2 );
    var_74f399cf58ad792d = [];
    var_74f399cf58ad792d[ 0 ] = 40;
    var_74f399cf58ad792d[ 1 ] = 500;
    var_74f399cf58ad792d[ 2 ] = 1000;
    sparams = get_dialogue_params( var_74f399cf58ad792d, human.origin );
    
    if ( !isdefined( sparams ) )
    {
        return;
    }
    
    b_player_close = 0;
    var_2c710eabb71e5cb4 = 0;
    
    foreach ( enemy in sparams.a_sorted_enemies )
    {
        if ( isplayer( enemy ) )
        {
            b_player_close = 1;
            continue;
        }
        
        if ( enemy.type == "zombie" )
        {
            var_2c710eabb71e5cb4 = 1;
        }
    }
    
    if ( b_player_close && var_2c710eabb71e5cb4 )
    {
        sparams.enemy_condition = 2;
    }
    else if ( b_player_close )
    {
        sparams.enemy_condition = 1;
    }
    else
    {
        sparams.enemy_condition = 0;
    }
    
    alias_suffix = [ [ "_srtargetzombiecqb", "_srtargetplayercqb", "_srtargetmixedcqb" ], [ "_srtargetzombienoncqb", "_srtargetplayernoncqb", "_srtargetmixednoncqb" ], [ "_lrtargetzombie", "_lrtargetplayer", "_lrtargetmixed" ] ][ sparams.dist_condition ][ sparams.enemy_condition ];
    dialogue = "dx_zm_aigr_jnsg_jng" + var_bf9e5f176507cd2a + alias_suffix;
    human dialogue::say_global( dialogue );
}

// Namespace zm_livingworld_vo
// Params 2, eflags: 0x4
// Checksum 0x29e124e9, Offset: 0x38a
// Size: 0x101
function private get_dialogue_params( var_74f399cf58ad792d, origin )
{
    player_team = level.players[ 0 ].team;
    
    if ( !isdefined( player_team ) )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( dist_condition, max_dist in var_74f399cf58ad792d )
        {
            var_6f5c0bece5deb66e = getplayersandaiarrayinradius( origin, max_dist, player_team, "team_two_hundred" );
            
            if ( !isdefined( var_6f5c0bece5deb66e ) || var_6f5c0bece5deb66e.size == 0 )
            {
                continue;
            }
            
            a_sorted_enemies = sortbydistance( var_6f5c0bece5deb66e, origin );
            return { #a_sorted_enemies:a_sorted_enemies, #dist_condition:dist_condition };
        }
        
        waitframe();
    }
}

// Namespace zm_livingworld_vo
// Params 1
// Checksum 0x9959fea2, Offset: 0x493
// Size: 0x58
function function_fff44f2c6fb01ef3( human )
{
    human endon( #"death" );
    var_bf9e5f176507cd2a = randomintrange( 1, 2 );
    dialogue = "dx_zm_aigr_jnsg_jng" + var_bf9e5f176507cd2a + "_teleportpanic";
    human dialogue::stop_dialogue();
    human dialogue::say_global( dialogue );
}

