// script_49d5fcbd3b667277  (hash_49d5fcbd3b667277.gscc) (size: 1119 Bytes / 0x45f)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a2144c2 (975258818)
// size ...... 1119 (0x45f)
// includes .. 1   (offset: 0x457)
// strings ... 0   (offset: 0x45f)
// dev strs .. 0   (offset: 0x45f)
// exports ... 5   (offset: 0x2c7)
// cseg ...... 0x58 + 0x26f (0x2c7)
// imports ... 7   (offset: 0x38f)
// animtree1 . 0   (offset: 0x45f)
// animtree2 . 0   (offset: 0x45f)
#using script_38b3a2dd00d469d7;

#namespace namespace_6e83184658f2320c;

// Namespace namespace_6e83184658f2320c
// Params 0
// Checksum 0x6ff0ca52, Offset: 0x76
// Size: 0x76
function register()
{
    namespace_65703d98c062a7d0::register_task( #"hold", { #description:undefined, #title:undefined, #var_d510f1926ab220cf:1, #defaulttimelimit:level.var_4e147a96a4a5740d.taskduration ?? 120, #var_a689daceff70fb12:30, #callbacks:{ #begin:&begin } } );
}

// Namespace namespace_6e83184658f2320c
// Params 1
// Checksum 0x15629c2a, Offset: 0xf4
// Size: 0x16
function begin( task )
{
    level thread function_ddcf362c880fce4a( task );
}

// Namespace namespace_6e83184658f2320c
// Params 1, eflags: 0x4
// Checksum 0xbbdc3a46, Offset: 0x112
// Size: 0x51
function private function_ddcf362c880fce4a( task )
{
    level endon( #"game_ended" );
    level endon( #"hash_974fecacc94e1b75" );
    
    while ( true )
    {
        wait 1;
        var_27836a09f9688985 = function_16a2c8d3b8e157d5();
        
        if ( var_27836a09f9688985 )
        {
            namespace_65703d98c062a7d0::function_3e454447aae37e67( var_27836a09f9688985, 1 );
        }
    }
}

// Namespace namespace_6e83184658f2320c
// Params 0, eflags: 0x4
// Checksum 0x7fa42895, Offset: 0x16b
// Size: 0x15b
function private function_16a2c8d3b8e157d5()
{
    best = undefined;
    bestcount = -1;
    tie = 0;
    
    foreach ( team in level.teamnamelist )
    {
        count = 0;
        
        foreach ( player in level.players )
        {
            if ( player.team == team && isalive( player ) )
            {
                count++;
            }
        }
        
        if ( count > bestcount )
        {
            bestcount = count;
            best = team;
            tie = 0;
            continue;
        }
        
        if ( count == bestcount )
        {
            tie = 1;
        }
    }
    
    if ( tie || bestcount <= 0 )
    {
        return;
    }
    
    return best;
}

