// scripts\mp\common\powerups\free_perk.gsc  (hash_435537f04d8110df.gscc) (size: 1217 Bytes / 0x4c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb090ddf9 (2962284025)
// size ...... 1217 (0x4c1)
// includes .. 3   (offset: 0x49d)
// strings ... 1   (offset: 0x4b5)
// dev strs .. 0   (offset: 0x4c1)
// exports ... 6   (offset: 0x275)
// cseg ...... 0x65 + 0x210 (0x275)
// imports ... 11  (offset: 0x365)
// animtree1 . 0   (offset: 0x4c1)
// animtree2 . 0   (offset: 0x4c1)
#using scripts\common\powerups;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\powerups;

#namespace free_perk;

// Namespace free_perk
// Params 0, eflags: 0x1
// Checksum 0xf8206d8e, Offset: 0x83
// Size: 0x9
function autoexec main()
{
    init_free_perk();
}

// Namespace free_perk
// Params 0
// Checksum 0x81626b05, Offset: 0x94
// Size: 0x18
function init_free_perk()
{
    powerups::register_powerup( "free_perk", &function_a2539931c560cc44, &func_should_drop_with_regular_powerups );
}

// Namespace free_perk
// Params 2
// Checksum 0x62246dbf, Offset: 0xb4
// Size: 0xad
function function_a2539931c560cc44( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        if ( !player isspectatinganyone() )
        {
            player function_8dfcaa8f3c3d2482();
            player thread powerups_cpmp::function_52318afc13635e7c( str_powerup );
        }
    }
}

// Namespace free_perk
// Params 0
// Checksum 0xe84c8057, Offset: 0x169
// Size: 0x17
function function_8dfcaa8f3c3d2482()
{
    var_127234c5fdc9f8ae = zombie_perks::function_ab9b4123275d6153();
    
    /#
    #/
}

// Namespace free_perk
// Params 0
// Checksum 0x5370dcf6, Offset: 0x188
// Size: 0xec, Type: bool
function func_should_drop_with_regular_powerups()
{
    var_ff06637b610142ac = 0;
    
    if ( !isdefined( level.total_purchased_perks ) )
    {
        level.total_purchased_perks = 0;
    }
    
    if ( level.total_purchased_perks < 3 + level.players.size )
    {
        return false;
    }
    
    foreach ( player in level.players )
    {
        if ( player.perks_active.size < 6 )
        {
            var_ff06637b610142ac = 1;
        }
    }
    
    if ( var_ff06637b610142ac )
    {
        rand_chance = 0.25 > randomfloat( 1 );
        
        if ( rand_chance )
        {
            return true;
        }
    }
    
    return false;
}

