// scripts\mp\zm\systems\items\zm_item_ammo.gsc  (hash_6c7e7ed734c643d8.gscc) (size: 4685 Bytes / 0x124d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc3896a7 (3426260647)
// size ...... 4685 (0x124d)
// includes .. 8   (offset: 0x1185)
// strings ... 9   (offset: 0x11c5)
// dev strs .. 0   (offset: 0x124d)
// exports ... 9   (offset: 0xb1d)
// cseg ...... 0x10d + 0xa10 (0xb1d)
// imports ... 41  (offset: 0xc85)
// animtree1 . 0   (offset: 0x124d)
// animtree2 . 0   (offset: 0x124d)
#using script_72d1ece3cbd0884a;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_round_logic;

#namespace zm_item_ammo;

// Namespace zm_item_ammo
// Params 0
// Checksum 0x3fc472c6, Offset: 0x12b
// Size: 0xc5
function init_item_ammo()
{
    common_item::function_4b30c091d3b04a25( "ammo" );
    common_item::function_84174b793b5fe9a7( "ammo", #"use", &function_1a34e930468f0e5 );
    common_item::function_84174b793b5fe9a7( "ammo", #"canautouse", &function_81c4f8c09e6032c4 );
    common_item::function_84174b793b5fe9a7( "ammo", #"hash_9e49dfaa7c147654", &function_81c4f8c09e6032c4 );
    common_item::function_84174b793b5fe9a7( "ammo", #"database_additem", &function_87d214afcb21b724 );
    
    if ( getdvarint( @"hash_1a0aac3eab65ce39", 1 ) )
    {
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "ammo" );
    }
    
    level callback::add( "on_zombie_ai_killed", &function_cae232367db4d671 );
    level.ammo_drop_throttle = throttle::throttle_initialize( "ammo_drop", 1, level.framedurationseconds );
}

// Namespace zm_item_ammo
// Params 1
// Checksum 0x6105bb3e, Offset: 0x1f8
// Size: 0x17
function function_ed7a337817f46e30( var_dda424c349037c52 )
{
    level.var_92f8a45e199f5366 = var_dda424c349037c52;
}

// Namespace zm_item_ammo
// Params 0
// Checksum 0x74024f44, Offset: 0x217
// Size: 0xc
function function_331d2418b6cdd643()
{
    level.var_92f8a45e199f5366 = undefined;
}

// Namespace zm_item_ammo
// Params 4
// Checksum 0x11259c0c, Offset: 0x22b
// Size: 0x22a, Type: bool
function function_81c4f8c09e6032c4( itembundle, item, auto_pickup, var_a0f59cb55797bb59 )
{
    primary_weapons = self getweaponslistprimaries();
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    var_6f117b3580b7c9ea = [];
    
    foreach ( primary_weapon in primary_weapons )
    {
        if ( primary_weapon.inventorytype != "primary" )
        {
            continue;
        }
        
        var_6f117b3580b7c9ea[ var_6f117b3580b7c9ea.size ] = primary_weapon;
        
        if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
        {
            var_6f117b3580b7c9ea[ var_6f117b3580b7c9ea.size ] = primary_weapon getaltweapon();
        }
    }
    
    foreach ( weapon in var_6f117b3580b7c9ea )
    {
        current_ammo = self getweaponammostock( weapon );
        current_ammo_clip = self getweaponammoclip( weapon );
        maxammo = utility::get_max_stock_ammo( weapon, var_482e9999b75ed3d8 );
        
        if ( current_ammo < maxammo && !weapon.ismelee )
        {
            return true;
        }
        
        if ( weapon.reloaddisabled && current_ammo_clip < weapon.clipsize && !weapon.ismelee )
        {
            return true;
        }
        
        if ( maxammo == 0 && !weapon.ismelee && current_ammo_clip < weapon.clipsize )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_item_ammo
// Params 4
// Checksum 0xe17cbc8e, Offset: 0x45e
// Size: 0x4ca, Type: bool
function function_1a34e930468f0e5( itembundle, item, autouse, var_981c264073bf1154 )
{
    primary_weapons = self getweaponslistprimaries();
    
    foreach ( primary_weapon in primary_weapons )
    {
        ammogain = 0.1;
        
        if ( primary_weapon.inventorytype == "primary" && !weapon::iskillstreakweapon( primary_weapon ) )
        {
            if ( isdefined( item.type ) && isstartstr( item.type, "zmloot_ammo_lg" ) )
            {
                item.ammo_percent_override = 0.2;
            }
            
            if ( isdefined( item.ammo_percent_override ) )
            {
                ammogain = item.ammo_percent_override;
            }
            
            var_7ee2cd26e86a1ceb = weapon::iswonderweapon( primary_weapon );
            
            if ( var_7ee2cd26e86a1ceb )
            {
                ammogain = item.var_1a82ea81e4335d1a ?? 0.02;
                
                if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_parting_gift" ) )
                {
                    ammogain = level.zombie_augments[ #"vulture_aid_parting_gift" ].var_6406bc09d53992e7 ?? 0.02;
                }
            }
            
            if ( isdefined( level.var_92f8a45e199f5366 ) )
            {
                ammogain *= level.var_92f8a45e199f5366;
            }
            
            var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
            
            if ( primary_weapon.reloaddisabled )
            {
                maxclipammo = weaponclipsize( primary_weapon );
                new_amount = int( min( self getweaponammoclip( primary_weapon ) + maxclipammo * ammogain, maxclipammo ) );
                self setweaponammoclip( primary_weapon, new_amount );
            }
            else
            {
                maxammo = utility::get_max_stock_ammo( primary_weapon, var_482e9999b75ed3d8 );
                
                if ( maxammo == 0 )
                {
                    current_ammo_clip = self getweaponammoclip( primary_weapon );
                    
                    if ( !primary_weapon.ismelee && current_ammo_clip < primary_weapon.clipsize )
                    {
                        new_amount = current_ammo_clip + max( 1, maxammo * ammogain );
                        new_amount = min( new_amount, primary_weapon.clipsize );
                        self setweaponammoclip( primary_weapon, int( new_amount ) );
                    }
                }
                else
                {
                    var_5d0c831b13e279b6 = self getweaponammostock( primary_weapon );
                    new_amount = var_5d0c831b13e279b6 + max( 1, maxammo * ammogain );
                    new_amount = min( new_amount, maxammo );
                    self setweaponammostock( primary_weapon, int( new_amount ) );
                }
            }
            
            if ( primary_weapon.hasalternate && !weapon::function_33e74163843b348e( primary_weapon ) )
            {
                weaponaltobj = primary_weapon getaltweapon();
                var_be8947252ccd1331 = getweaponattachments( weaponaltobj );
                altmaxammo = utility::get_max_stock_ammo( weaponaltobj, var_482e9999b75ed3d8 );
                var_e729f3166d7760ff = weaponclipsize( weaponaltobj );
                var_fbbd9f6d8db91388 = self getweaponammoclip( weaponaltobj );
                
                if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
                {
                    ammogain = item.var_c1fccb53c0121a8 ?? 0.1;
                }
                
                if ( function_9955d5b2a1d97c43( primary_weapon ) && !function_b7037bc0cf5c7a82( primary_weapon ) )
                {
                    foreach ( attachment in var_be8947252ccd1331 )
                    {
                        if ( issubstr( attachment, "_ub_gl_smoke_" ) )
                        {
                            var_d02a3a6053af0838 = item.var_280e80414af5cabd ?? 0.1;
                            break;
                        }
                        
                        var_d02a3a6053af0838 = item.var_319af4bdf57f5b2f ?? 0.1;
                    }
                }
                
                if ( altmaxammo > 0 )
                {
                    var_a965dfad792e80f0 = self getweaponammostock( weaponaltobj );
                    addammo = isdefined( var_d02a3a6053af0838 ) ? var_d02a3a6053af0838 : max( 1, altmaxammo * ammogain );
                    var_be7a46a9aa22eff5 = int( min( var_a965dfad792e80f0 + addammo, altmaxammo ) );
                    self setweaponammostock( weaponaltobj, var_be7a46a9aa22eff5 );
                }
                
                if ( var_fbbd9f6d8db91388 < var_e729f3166d7760ff )
                {
                    addammo = isdefined( var_d02a3a6053af0838 ) ? var_d02a3a6053af0838 : max( 1, var_e729f3166d7760ff * ammogain );
                    var_55be21aa1a6193db = int( min( var_fbbd9f6d8db91388 + addammo, var_e729f3166d7760ff ) );
                    self setweaponammoclip( weaponaltobj, var_55be21aa1a6193db );
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_item_ammo
// Params 1, eflags: 0x4
// Checksum 0x12cf5249, Offset: 0x931
// Size: 0x27
function private function_87d214afcb21b724( itembundlename )
{
    utility::callsharedfunc( #"vehicle_pickup", #"databaseadditem", itembundlename );
}

// Namespace zm_item_ammo
// Params 1, eflags: 0x4
// Checksum 0x5b8adfa6, Offset: 0x960
// Size: 0x61
function private function_cae232367db4d671( sparams )
{
    if ( isplayer( sparams.eattacker ) && !self.var_a13bed1ac47e1b2c && !level.gametypebundle.var_e8959b0d5b7cafad )
    {
        spawn_chance_ammo( sparams.smeansofdeath, sparams.eattacker );
    }
}

// Namespace zm_item_ammo
// Params 2
// Checksum 0x88366701, Offset: 0x9c9
// Size: 0x154
function spawn_chance_ammo( smeansofdeath, eattacker )
{
    if ( self.var_a13bed1ac47e1b2c || self.b_in_spawn_closet || self.var_f895c28d17024434 )
    {
        return;
    }
    
    unittype = self.unittype;
    origin = self.origin;
    angles = self.angles;
    aicategory = self.aicategory;
    playerdamagelist = self.a_n_player_damage;
    var_3d166d714869e1c = spawnstruct();
    throttle::throttle_wait_in_queue( level.ammo_drop_throttle, var_3d166d714869e1c );
    n_round = zm_round_logic::get_rb_round_number();
    str_item_list = "zm_t10_items_lv1_ammo";
    
    switch ( aicategory )
    {
        case #"hash_7b0e2f2ed84f34":
        case #"hash_8c089e813083e510":
            str_item_list = "zm_t10_items_ammo_elite";
            break;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin );
    
    if ( isdefined( level.var_597f31ee570896c0 ) )
    {
        self [[ level.var_597f31ee570896c0 ]]( spawnoptions, playerdamagelist, self.origin );
    }
    
    itemsspawned = level common_item::function_38cde6a6acb68ea6( str_item_list, 1, spawnoptions );
}

