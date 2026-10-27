// scripts\vehicle\pluto\zm_firefly_pluto_damage.gsc  (hash_1da042bac00ce4d0.gscc) (size: 1817 Bytes / 0x719 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4d54751 (4107618129)
// size ...... 1817 (0x719)
// includes .. 2   (offset: 0x6c5)
// strings ... 5   (offset: 0x6d5)
// dev strs .. 0   (offset: 0x719)
// exports ... 4   (offset: 0x4fd)
// cseg ...... 0x140 + 0x3bd (0x4fd)
// imports ... 10  (offset: 0x59d)
// animtree1 . 0   (offset: 0x719)
// animtree2 . 0   (offset: 0x719)
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 1
// Checksum 0xf71959fa, Offset: 0x15e
// Size: 0x13a
function function_2b4090229bfff6af( data )
{
    thread function_a48f758e4314135e( data.inflictor );
    data.damage = function_ed2cc24bd11f384e( data );
    
    switch ( self.var_7493baa2cd62443 )
    {
        case 1:
        case 2:
            data.damage *= 1;
            break;
        case 3:
        case 4:
            data.damage *= 0.8;
            break;
        default:
            data.damage *= 1;
            break;
    }
    
    round_number = zm_utility::get_round_number();
    
    if ( round_number < self.bundledata.var_40c888fa59445b79 )
    {
        data.damage *= self.bundledata.var_f6dfe61bec45080e;
    }
    
    return data.damage;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xdd2e9e35, Offset: 0x2a1
// Size: 0x121
function private function_ed2cc24bd11f384e( data )
{
    var_2f24312ac52671dd = data.damage;
    new_damage = 0;
    
    if ( data.inflictor.aicategory == "hvt" )
    {
        new_damage = 150;
    }
    else if ( isdefined( data.inflictor.subclass ) )
    {
        switch ( data.inflictor.subclass )
        {
            case #"hash_1380581f5144c465":
            case #"hash_99a38be9e88b5244":
            case #"hash_f297af39454fdc7b":
                new_damage = 90;
                break;
            case #"hash_615dbf7f92e4de09":
                new_damage = 200;
                break;
            case #"hash_b4981557ecbe551":
                new_damage = 100;
                break;
            case #"hash_564f375ce42a5b21":
                new_damage = 100;
                break;
            case #"hash_e7da8821c456119c":
                new_damage = 135;
                break;
            default:
                new_damage = 90;
                break;
        }
    }
    else
    {
        new_damage = 90;
    }
    
    return min( var_2f24312ac52671dd, new_damage );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xd82fc2de, Offset: 0x3cb
// Size: 0x132
function private function_a48f758e4314135e( var_bd2c4ac1948d79c6 )
{
    if ( var_bd2c4ac1948d79c6.subclass == "zombie_shade" && var_bd2c4ac1948d79c6.var_c2244a336e1c23aa )
    {
        if ( !level utility::flag( "shade_attach_to_veh_and_attacked_first_time" ) )
        {
            level utility::flag_set( "shade_attach_to_veh_and_attacked_first_time" );
            utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_5a56b1cdba0d5abf" );
            return;
        }
    }
    
    if ( var_bd2c4ac1948d79c6.subclass == "zombie_callisto" && !level utility::flag( "callisto_attack_veh_first_time" ) )
    {
        level utility::flag_set( "callisto_attack_veh_first_time" );
        utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_289fb66944271b96" );
        return;
    }
    
    curr_time = gettime();
    
    if ( !self.var_5887dfdd882bb41a || curr_time - self.var_5887dfdd882bb41a >= utility::function_4b74c15943231980( 120 ) )
    {
        if ( utility::percent_chance( 15 ) )
        {
            self.var_5887dfdd882bb41a = curr_time;
            utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_f6fcc03251387ed5" );
        }
    }
}

