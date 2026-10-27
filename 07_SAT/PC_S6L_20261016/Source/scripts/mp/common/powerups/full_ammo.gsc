// scripts\mp\common\powerups\full_ammo.gsc  (hash_76336d4eae755a50.gscc) (size: 2584 Bytes / 0xa18 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa516f897 (2769746071)
// size ...... 2584 (0xa18)
// includes .. 7   (offset: 0x998)
// strings ... 6   (offset: 0x9d0)
// dev strs .. 0   (offset: 0xa18)
// exports ... 7   (offset: 0x4e0)
// cseg ...... 0xb3 + 0x42d (0x4e0)
// imports ... 31  (offset: 0x5f8)
// animtree1 . 0   (offset: 0xa18)
// animtree2 . 0   (offset: 0xa18)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;

#namespace full_ammo;

// Namespace full_ammo
// Params 0, eflags: 0x1
// Checksum 0xa42a28d6, Offset: 0xd1
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_full_ammo", 0 ) )
    {
        return;
    }
    
    init_full_ammo();
}

// Namespace full_ammo
// Params 0
// Checksum 0x5f596c12, Offset: 0xf4
// Size: 0x1d
function init_full_ammo()
{
    powerups::register_powerup( "full_ammo", &function_bc9950cc826d680f, &function_221d39e8091d9b86, &modify_drop_chance );
}

// Namespace full_ammo
// Params 2
// Checksum 0x10d00eff, Offset: 0x119
// Size: 0xc3
function function_bc9950cc826d680f( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        if ( !player val::get( "allow_full_ammo_powerup" ) )
        {
            continue;
        }
        
        player function_cf46f312587658ee();
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
    }
    
    level notify( #"zmb_max_ammo_level" );
}

// Namespace full_ammo
// Params 0
// Checksum 0x4a4e7e50, Offset: 0x1e4
// Size: 0x55
function function_221d39e8091d9b86()
{
    if ( utility::issharedfuncdefined( #"powerup_full_ammo", #"hash_75b10183404b5a16" ) )
    {
        return utility::callsharedfunc( #"powerup_full_ammo", #"hash_75b10183404b5a16" );
    }
    
    root = powerups::get_powerups_root();
    return root.var_e976cc211ff8126 == 0;
}

// Namespace full_ammo
// Params 2
// Checksum 0xdc961742, Offset: 0x242
// Size: 0x4e
function modify_drop_chance( chance, context )
{
    if ( utility::issharedfuncdefined( #"powerup_full_ammo", #"modify_drop_chance" ) )
    {
        return utility::callsharedfunc( #"powerup_full_ammo", #"modify_drop_chance", chance, context );
    }
    
    return chance;
}

// Namespace full_ammo
// Params 0
// Checksum 0x161cf6b7, Offset: 0x299
// Size: 0x247
function function_cf46f312587658ee()
{
    if ( utility::issharedfuncdefined( #"powerup_full_ammo", #"give_ammo" ) )
    {
        utility::callsharedfunc( #"powerup_full_ammo", #"give_ammo" );
        return;
    }
    
    weapons = self getweaponslistprimaries();
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    
    foreach ( weapon in weapons )
    {
        if ( !weapon::iskillstreakweapon( weapon ) )
        {
            max_ammo = utility::get_max_stock_ammo( weapon, var_482e9999b75ed3d8 );
            self setweaponammostock( weapon, max_ammo );
            self cancelreload();
            var_83e55048826dcd05 = self getweaponammoclip( weapon );
            var_b11feea92c35d08e = weaponclipsize( weapon );
            
            if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
            {
                self setweaponammoclip( weapon, weaponclipsize( weapon ) );
            }
            
            if ( weapon::isakimbo( weapon ) )
            {
                if ( !isdefined( lefthandquantity ) )
                {
                    lefthandquantity = weaponclipsize( weapon );
                }
                
                self setweaponammoclip( weapon, lefthandquantity, "left" );
            }
            
            if ( weapon.hasalternate && !weapon::function_33e74163843b348e( weapon ) )
            {
                weaponaltobj = weapon getaltweapon();
                max_ammo = utility::get_max_stock_ammo( weaponaltobj, var_482e9999b75ed3d8 );
                self setweaponammostock( weaponaltobj, max_ammo );
                var_83e55048826dcd05 = self getweaponammoclip( weaponaltobj );
                var_b11feea92c35d08e = weaponclipsize( weaponaltobj );
                
                if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
                {
                    self setweaponammoclip( weaponaltobj, weaponclipsize( weaponaltobj ) );
                }
            }
        }
    }
    
    primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
    var_382c92ced2f61c35 = equipment_mp::getequipmentmaxammo( primary_equip_ref );
    equipment_mp::setequipmentammo( primary_equip_ref, var_382c92ced2f61c35, var_382c92ced2f61c35 );
    secondary_equip_ref = equipment_mp::getcurrentequipment( "secondary" );
    var_f9720a7bbc3dc8a5 = equipment_mp::getequipmentmaxammo( secondary_equip_ref );
    equipment_mp::setequipmentammo( secondary_equip_ref, var_f9720a7bbc3dc8a5, var_f9720a7bbc3dc8a5 );
    self notify( #"zmb_max_ammo" );
}

