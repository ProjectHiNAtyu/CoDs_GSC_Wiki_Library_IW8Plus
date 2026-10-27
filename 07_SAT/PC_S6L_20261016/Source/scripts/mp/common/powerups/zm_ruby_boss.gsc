// scripts\mp\common\powerups\zm_ruby_boss.gsc  (hash_5509acc1df1fc9d8.gscc) (size: 2209 Bytes / 0x8a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb73aa730 (3074074416)
// size ...... 2209 (0x8a1)
// includes .. 8   (offset: 0x821)
// strings ... 5   (offset: 0x861)
// dev strs .. 0   (offset: 0x8a1)
// exports ... 8   (offset: 0x3dd)
// cseg ...... 0xb8 + 0x325 (0x3dd)
// imports ... 27  (offset: 0x51d)
// animtree1 . 0   (offset: 0x8a1)
// animtree2 . 0   (offset: 0x8a1)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\equipment;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_ruby_boss;

// Namespace zm_ruby_boss
// Params 0, eflags: 0x1
// Checksum 0xea0ffbc1, Offset: 0xd6
// Size: 0x9
function autoexec main()
{
    init_ruby_boss_powerup();
}

// Namespace zm_ruby_boss
// Params 0
// Checksum 0x5f555d4d, Offset: 0xe7
// Size: 0x18
function init_ruby_boss_powerup()
{
    powerups::register_powerup( "ruby_boss", &function_254d4d529f3a8048, &function_7360aebb1383d656 );
}

// Namespace zm_ruby_boss
// Params 2
// Checksum 0xe6b2c643, Offset: 0x107
// Size: 0x1a6
function function_254d4d529f3a8048( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    root = powerups::get_powerups_root();
    n_lifetime = root.powerups[ "ruby_boss" ].var_3f03b937c69044df;
    
    if ( isdefined( level.powerup_timeout_override ) )
    {
        n_lifetime = self [[ level.powerup_timeout_override ]]( n_lifetime );
    }
    
    foreach ( player in a_players )
    {
        player utility::callsharedfunc( #"powerup_ruby_boss", #"apply_effect" );
        player playsoundtoplayer( "evt_ruby_boss_netpune_powerup_pick", player );
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup, n_lifetime );
        player full_ammo::function_cf46f312587658ee();
        owns_armor = isdefined( player.armorhealth ) && player.maxarmorhealth > 0;
        
        if ( owns_armor && !player armor::has_full_armor() )
        {
            player armor::repair_armor( player.maxarmorhealth );
        }
        
        if ( owns_armor )
        {
            player armor::function_164c824617d7e8d7( player armor::function_db9ebf086f67fe92() );
        }
        
        player thread give_unlimited_ammo( n_lifetime, root );
    }
    
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_dc7430c4699173ad", #"bc_flavor_player_positive" );
}

// Namespace zm_ruby_boss
// Params 2
// Checksum 0xbcb8de1e, Offset: 0x2b5
// Size: 0x9a
function give_unlimited_ammo( n_lifetime, root )
{
    callback::add( #"reload", &replenish_stock_ammo );
    callback::add( #"equipment_use", &function_78f07fca923420b6 );
    utility::waittill_any_timeout( n_lifetime, "end_ruby_boss_powerup", "death" );
    
    if ( isdefined( self ) )
    {
        callback::remove( #"reload", &replenish_stock_ammo );
        callback::remove( #"equipment_use", &function_78f07fca923420b6 );
        utility::callsharedfunc( #"powerup_ruby_boss", #"remove_effect" );
    }
}

// Namespace zm_ruby_boss
// Params 1, eflags: 0x4
// Checksum 0xf5be9ce5, Offset: 0x357
// Size: 0x2b
function private replenish_stock_ammo( params )
{
    player_weapon = self getcurrentweapon();
    self setweaponammostock( player_weapon, weaponmaxammo( player_weapon ) );
}

// Namespace zm_ruby_boss
// Params 1, eflags: 0x4
// Checksum 0xea47c300, Offset: 0x38a
// Size: 0x47
function private function_78f07fca923420b6( params )
{
    if ( params.slot == "primary" )
    {
        equipment_mp::setequipmentammo( params.ref, params.weapon_object.maxammo );
    }
}

// Namespace zm_ruby_boss
// Params 0
// Checksum 0xeee20606, Offset: 0x3d9
// Size: 0x3, Type: bool
function function_7360aebb1383d656()
{
    return false;
}

