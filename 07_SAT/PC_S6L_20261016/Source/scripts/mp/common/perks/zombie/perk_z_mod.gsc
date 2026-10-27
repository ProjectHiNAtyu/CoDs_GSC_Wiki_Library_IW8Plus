// scripts\mp\common\perks\zombie\perk_z_mod.gsc  (hash_709ef09d540bd437.gscc) (size: 9175 Bytes / 0x23d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d0016a9 (1291851433)
// size ...... 9175 (0x23d7)
// includes .. 14  (offset: 0x2253)
// strings ... 17  (offset: 0x22c3)
// dev strs .. 0   (offset: 0x23d7)
// exports ... 19  (offset: 0x148b)
// cseg ...... 0x1e8 + 0x12a3 (0x148b)
// imports ... 91  (offset: 0x1783)
// animtree1 . 0   (offset: 0x23d7)
// animtree2 . 0   (offset: 0x23d7)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;

#namespace perk_z_mod;

// Namespace perk_z_mod
// Params 0, eflags: 0x5
// Checksum 0x7dc47a14, Offset: 0x206
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_z_mod", undefined, &__init__, undefined );
}

// Namespace perk_z_mod
// Params 0
// Checksum 0xab7c914f, Offset: 0x223
// Size: 0xa
function __init__()
{
    level thread perk_z_mod_init();
}

// Namespace perk_z_mod
// Params 0
// Checksum 0x25a2c29f, Offset: 0x235
// Size: 0x267
function perk_z_mod_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_z_mod" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_z_mod" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_z_mod" );
    var_7c0c0569bf2695fb = var_fcb7626c79b3c98f ?? 2000;
    level thread zombie_perks::enable_perk_for_level( "specialty_z_mod", str_currency, var_7c0c0569bf2695fb, &function_7d7c6a7334105586, &function_fa18def5daddfa0c, 1 );
    level utility::flag_set( "specialty_z_mod" + "init_complete" );
    utility::registersharedfunc( #"item_weapon", #"hash_7347b2185d2c7180", &function_5d233d31d5029ddf );
    callback::add( #"item_weapon_picked_up", &function_eb6b1705e61f6457 );
    callback::add( #"player_weapon_take", &function_fce31d3ac8548a53 );
    callback::add( "zm_packed_weapon", &function_e2345f5588773afb );
    callback::add( #"player_laststand_revived", &z_mod_player_revived );
    callback::add( #"player_death", &z_mod_player_death );
    callback::add( #"hash_d558db2dac47d5f7", &function_e498c41fd90a8d6 );
    scriptable::scriptable_addnotifycallback( "z_mod_shot", &z_mod_machine_shoot );
    level.var_f8185688078b34a9 = [];
    var_57bad7a72f7d0037 = level.zombie_augments[ #"z_mod_ol_reliable" ].var_f4eee770994a896b;
    
    if ( var_57bad7a72f7d0037 )
    {
        var_57bad7a72f7d0037 = getscriptbundle( "itemspawnlist:" + var_57bad7a72f7d0037 );
        
        foreach ( itementry in var_57bad7a72f7d0037.itementries )
        {
            if ( !isdefined( itementry.itemspawnentry ) )
            {
                continue;
            }
            
            itembundle = getscriptbundle( itementry.itemspawnentry );
            
            if ( itembundle.baseweapon )
            {
                hashedweaponname = getxhashasset( itembundle.baseweapon );
                function_36ca41dde96afcd3( hashedweaponname );
            }
        }
    }
}

// Namespace perk_z_mod
// Params 0
// Checksum 0x3d79a49c, Offset: 0x4a4
// Size: 0x13
function function_5d233d31d5029ddf()
{
    if ( zombie_perks::has_perk( "specialty_z_mod" ) )
    {
        return 3;
    }
}

// Namespace perk_z_mod
// Params 0
// Checksum 0x9f8fd7f2, Offset: 0x4bf
// Size: 0x1f3
function function_7d7c6a7334105586()
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_z_mod" );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_fully_equipped" ) )
    {
        perk::giveperk( "specialty_extraoffhandammo" );
    }
    
    var_b1a757fc9a331099 = utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_ol_reliable" );
    
    if ( var_b1a757fc9a331099 && isdefined( self.var_3bf72dcd2775aa78 ) )
    {
        item_weapon::function_96add18b226ff731( self.var_3bf72dcd2775aa78 );
        var_8bb1b2bde27b267c = self.var_a7acf43fb611891 ?? utility::get_max_stock_ammo( self.var_3bf72dcd2775aa78, 1 );
        self setweaponammostock( self.var_3bf72dcd2775aa78, var_8bb1b2bde27b267c );
        
        if ( isdefined( self.var_18988f80052a4d58 ) )
        {
            item_weapon::function_40e1cbd0e1f47d1a( self.var_3bf72dcd2775aa78, self.var_18988f80052a4d58 );
        }
        
        if ( isdefined( self.var_15c8a1faad39f870 ) )
        {
            utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", self.var_3bf72dcd2775aa78, self.var_15c8a1faad39f870, 0 );
        }
        
        if ( isdefined( self.var_bbc0991cb44019fc ) )
        {
            if ( utility::issharedfuncdefined( #"ammo_mod", #"hash_24f1a2cf1ed6660d" ) )
            {
                utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", self.var_3bf72dcd2775aa78, self.var_bbc0991cb44019fc, 0 );
            }
        }
    }
    
    if ( !self.var_b35729a9ecacd84f )
    {
        self.var_b35729a9ecacd84f = 1;
        currentweapon = self getcurrentweapon();
        var_5cb6bb85d5c5aee7 = utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_pack_mule" );
        var_be116b49a96aa33c = utility::get_max_stock_ammo( currentweapon, var_5cb6bb85d5c5aee7 );
        
        if ( !weapon::iskillstreakweapon( currentweapon ) )
        {
            self setweaponammostock( currentweapon, var_be116b49a96aa33c );
        }
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xc87f5f2f, Offset: 0x6ba
// Size: 0x23
function function_36ca41dde96afcd3( weaponname )
{
    level.var_f8185688078b34a9[ level.var_f8185688078b34a9.size ] = weaponname;
}

// Namespace perk_z_mod
// Params 0
// Checksum 0xee0e81fb, Offset: 0x6e5
// Size: 0x9c, Type: bool
function function_c935cae6fcb8ff28()
{
    if ( isdefined( self.var_3bf72dcd2775aa78 ) )
    {
        foreach ( weapon in level.var_f8185688078b34a9 )
        {
            if ( weapon == self.var_3bf72dcd2775aa78.basenamehash )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace perk_z_mod
// Params 4
// Checksum 0x3a2fcd83, Offset: 0x78a
// Size: 0x1aa
function function_fa18def5daddfa0c( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    var_b1a757fc9a331099 = utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_ol_reliable" );
    var_2e670208c026bc55 = function_c935cae6fcb8ff28();
    
    if ( var_b1a757fc9a331099 && !var_2e670208c026bc55 )
    {
        if ( isdefined( self.var_3bf72dcd2775aa78 ) )
        {
            self.var_a7acf43fb611891 = self getweaponammostock( self.var_3bf72dcd2775aa78 );
            
            if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) )
            {
                self.var_18988f80052a4d58 = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( self.var_3bf72dcd2775aa78 );
            }
            
            if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
            {
                self.var_15c8a1faad39f870 = namespace_9d8e359c3b1041e5::function_1d4087075103b248( self.var_3bf72dcd2775aa78 );
            }
            
            if ( utility::issharedfuncdefined( #"zombie", #"get_ammo_mod_name" ) && utility::issharedfuncdefined( #"zombie", #"has_ammo_mod" ) )
            {
                if ( namespace_9d8e359c3b1041e5::function_f3b72bf1c0b8c737( self.var_3bf72dcd2775aa78 ) )
                {
                    self.var_bbc0991cb44019fc = namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( self.var_3bf72dcd2775aa78 );
                }
            }
        }
        
        thread function_5dd230c7e6a65fc6( 1 );
    }
    else
    {
        thread function_5dd230c7e6a65fc6();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_fully_equipped" ) )
    {
        perk::removeperk( "specialty_extraoffhandammo" );
    }
    
    zombie_perks::function_25539251d02082( "specialty_z_mod" );
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xd8773a05, Offset: 0x93c
// Size: 0x38
function function_e2345f5588773afb( sparams )
{
    if ( self.var_3bf72dcd2775aa78 == sparams.var_39044599845b54cf )
    {
        self.var_3bf72dcd2775aa78 = sparams.var_101633ed971732ba;
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xa3530ee1, Offset: 0x97c
// Size: 0xed
function function_eb6b1705e61f6457( sparams )
{
    numprimaries = item_weapon::function_db94c1441f6cd802();
    
    if ( numprimaries == 3 )
    {
        if ( isdefined( sparams.oldweaponobj ) && isdefined( self.var_3bf72dcd2775aa78 ) && isdefined( self.var_1dbdf5cd10dc5432 ) )
        {
            if ( sparams.oldweaponobj == self.var_3bf72dcd2775aa78 )
            {
                self.var_3bf72dcd2775aa78 = sparams.newweaponobj;
                self.var_1dbdf5cd10dc5432 = sparams.var_ab592b9195e8598f;
            }
        }
        else
        {
            self.var_3bf72dcd2775aa78 = sparams.newweaponobj;
            self.var_1dbdf5cd10dc5432 = sparams.var_ab592b9195e8598f;
        }
        
        if ( self function_5c766d1d0140b86( "ui_gameplay_telemetry_mule_weap_lootid" ) )
        {
            lootid = weapon::getweaponlootid( self.var_3bf72dcd2775aa78 );
            self setclientomnvar( "ui_gameplay_telemetry_mule_weap_lootid", lootid );
        }
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xcad4d79e, Offset: 0xa71
// Size: 0x246
function function_fce31d3ac8548a53( sparams )
{
    self endon( #"disconnect" );
    waitframe();
    
    if ( isplayer( self ) && isalive( self ) && !self.var_8d728cf8ba72f5a6 )
    {
        numprimaries = item_weapon::function_db94c1441f6cd802();
        
        if ( numprimaries < 3 && isdefined( self.var_3bf72dcd2775aa78 ) && self hasweapon( self.var_3bf72dcd2775aa78 ) )
        {
            self.var_8d728cf8ba72f5a6 = 1;
            item_weapon::function_9e7275fa51ace996( self.var_3bf72dcd2775aa78, "zmod_weaponremovedcallback" );
            weaponinfo = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:self.var_3bf72dcd2775aa78 } );
            waitframe();
            
            if ( isplayer( self ) && isalive( self ) && isdefined( self.var_3bf72dcd2775aa78 ) )
            {
                item_weapon::function_35910aac16378fec( self.var_3bf72dcd2775aa78, weaponinfo.ammoclipright, weaponinfo.ammostock );
                item_weapon::function_d6a514964e1e7f2c( self.var_3bf72dcd2775aa78 );
                
                if ( weaponinfo.paplv > 0 )
                {
                    pack_a_punch::function_3f3b9cdbb4843e45( self.var_3bf72dcd2775aa78, weaponinfo.paplv, 0 );
                }
                
                if ( weaponinfo.ammomod )
                {
                    ammo_mod::add_ammo_mod_to_weapon( self.var_3bf72dcd2775aa78, weaponinfo.ammomod, 0 );
                }
                
                if ( weapon::isakimbo( self.var_3bf72dcd2775aa78 ) && weaponinfo.ammoclipleft >= 0 )
                {
                    self setweaponammoclip( self.var_3bf72dcd2775aa78, weaponinfo.ammoclipleft, "left" );
                }
                
                self.var_3bf72dcd2775aa78 = undefined;
                self.var_1dbdf5cd10dc5432 = undefined;
                
                if ( self function_5c766d1d0140b86( "ui_gameplay_telemetry_mule_weap_lootid" ) )
                {
                    self setclientomnvar( "ui_gameplay_telemetry_mule_weap_lootid", -1 );
                }
            }
            
            waitframe();
            
            if ( isplayer( self ) )
            {
                self.var_7d16772ccd0f25ef = undefined;
            }
        }
    }
    
    if ( isplayer( self ) && zombie_perks::has_perk( "specialty_z_mod" ) && isdefined( self.var_3bf72dcd2775aa78 ) && !self hasweapon( self.var_3bf72dcd2775aa78 ) )
    {
        self.var_3bf72dcd2775aa78 = undefined;
        self.var_1dbdf5cd10dc5432 = undefined;
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xbb5ad7ac, Offset: 0xcbf
// Size: 0x2bd
function function_5dd230c7e6a65fc6( btakeweapon = 0 )
{
    if ( isdefined( self.var_3bf72dcd2775aa78 ) && self hasweapon( self.var_3bf72dcd2775aa78 ) )
    {
        var_3bf72dcd2775aa78 = self.var_3bf72dcd2775aa78;
        var_ee77111e6584bdd9 = 0;
        
        if ( !self.inlaststand && var_3bf72dcd2775aa78 == self getcurrentweapon() )
        {
            var_ee77111e6584bdd9 = 1;
        }
        
        if ( self.inlaststand && var_3bf72dcd2775aa78 == self getcurrentweapon() )
        {
            self.var_b4b5b6ea04345176 = 1;
        }
        
        if ( level.var_506022c3af2830ca )
        {
            var_b402d230c5a059ff = 1;
            
            while ( isplayer( self ) && isalive( self ) && ( !self isonground() || var_b402d230c5a059ff ) )
            {
                if ( isplayer( self ) && isalive( self ) )
                {
                    var_b402d230c5a059ff = 0;
                    
                    foreach ( volume in level.var_506022c3af2830ca )
                    {
                        if ( ispointinvolume( self.origin, volume ) )
                        {
                            var_b402d230c5a059ff = 1;
                            break;
                        }
                    }
                }
                
                waitframe();
            }
        }
        
        if ( !isplayer( self ) || !isalive( self ) )
        {
            randomplayerindex = randomintrange( 0, level.players.size );
            chosen_player = level.players[ randomplayerindex ];
            spawn_origin = getclosestpointonnavmesh( chosen_player.origin );
            spawn_angles = chosen_player.angles;
            spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
            spawnoptions.spawnpositionindex = 1;
            spawnoptions.weapon = var_3bf72dcd2775aa78;
            spawnoptions.cleanupdisabled = 1;
            spawnoptions.var_8d4f327170228364 = 1;
            weaponinfostruct = function_6fc306d1b8b4d844( var_3bf72dcd2775aa78 );
            item_weapon::function_53da2af5697709f8( var_3bf72dcd2775aa78, weaponinfostruct, spawnoptions );
            return;
        }
        
        self.var_f5ee28e51c394b99 = item_weapon::items_weapon_removeweapon( { #dontdrop:btakeweapon, #weapon:self.var_3bf72dcd2775aa78 } );
        
        if ( !btakeweapon )
        {
            self.var_3bf72dcd2775aa78 = undefined;
            self.var_1dbdf5cd10dc5432 = undefined;
            
            if ( self function_5c766d1d0140b86( "ui_gameplay_telemetry_mule_weap_lootid" ) )
            {
                self setclientomnvar( "ui_gameplay_telemetry_mule_weap_lootid", -1 );
            }
        }
        
        if ( var_ee77111e6584bdd9 )
        {
            self switchtoweaponimmediate( self.primaryweapons[ 0 ] );
        }
    }
}

// Namespace perk_z_mod
// Params 1, eflags: 0x4
// Checksum 0xb809b387, Offset: 0xf84
// Size: 0x116
function private function_6fc306d1b8b4d844( currentweapon )
{
    rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( currentweapon );
    PAPlvl = pack_a_punch::get_pap_level( currentweapon );
    ammomod = item_weapon::function_ef9c1a22435b14b9( currentweapon );
    ammoclipright = self getweaponammoclip( currentweapon );
    ammoclipleft = self getweaponammoclip( currentweapon, "left" );
    ammoclipalt = item_weapon::function_dc8d4a742844a795( currentweapon ) ? 0 : self getweaponammoclip( currentweapon getaltweapon() );
    ammostock = self getweaponammostock( currentweapon );
    weaponammocount = self getweaponammoclip( currentweapon );
    weaponinfostruct = { #weaponammocount:weaponammocount, #ammostock:ammostock, #ammoclipalt:ammoclipalt, #ammoclipleft:ammoclipleft, #ammoclipright:ammoclipright, #ammomod:ammomod, #paplv:PAPlvl, #rarity:rarity };
    return weaponinfostruct;
}

// Namespace perk_z_mod
// Params 1
// Checksum 0x7cefd2e1, Offset: 0x10a3
// Size: 0x33
function z_mod_player_revived( sparams )
{
    if ( self.var_b4b5b6ea04345176 )
    {
        self.var_b4b5b6ea04345176 = undefined;
        self switchtoweaponimmediate( self.primaryweapons[ 0 ] );
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xcfac4b0f, Offset: 0x10de
// Size: 0x1e
function z_mod_player_death( sparams )
{
    if ( isplayer( self ) )
    {
        self.var_b4b5b6ea04345176 = undefined;
    }
}

// Namespace perk_z_mod
// Params 4
// Checksum 0x9b79667, Offset: 0x1104
// Size: 0x1e1
function z_mod_machine_shoot( eattacker, note, param, var_64ffacba090c91be )
{
    if ( utility::percent_chance( 15 ) )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( eattacker.origin, eattacker.angles );
        spawn_options.var_c580c0e8b49f1fcc = 1;
        spawn_options.var_90cdc5dbcd319e5d = 1;
        spawn_options.var_4a4b419f66681601 = [];
        spawn_options.var_4a4b419f66681601[ spawn_options.var_4a4b419f66681601.size ] = var_64ffacba090c91be;
        item = level common_item::function_38cde6a6acb68ea6( "zm_sat_items_z_mod_machine_equipment", 1, spawn_options );
    }
    
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( !isdefined( level.z_mod_machine_shoot_throttle ) )
    {
        level.z_mod_machine_shoot_throttle = throttle::throttle_initialize( "z_mod_machine_shoot_throttle", 1, level.framedurationseconds );
    }
    
    var_da240dd623954f38 = getaiarrayinradius( eattacker.origin, 256 );
    var_a134472124fa2713 = spawnstruct();
    
    foreach ( zombie in var_da240dd623954f38 )
    {
        zombie dodamage( zombie_base_health, eattacker.origin, eattacker, eattacker, "MOD_RIFLE_BULLET", "<explicitweaponnone>", "none", undefined, 1073807360 );
        throttle::throttle_wait_in_queue( level.z_mod_machine_shoot_throttle, var_a134472124fa2713 );
    }
}

// Namespace perk_z_mod
// Params 1
// Checksum 0xec4195b, Offset: 0x12ed
// Size: 0x6b
function function_e498c41fd90a8d6( params )
{
    var_b1a757fc9a331099 = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_ol_reliable" );
    
    if ( var_b1a757fc9a331099 && isdefined( self.var_3bf72dcd2775aa78 ) && !self hasweapon( self.var_3bf72dcd2775aa78 ) )
    {
        thread function_33384cc73651f22f();
    }
}

// Namespace perk_z_mod
// Params 0, eflags: 0x4
// Checksum 0xcca05c61, Offset: 0x1360
// Size: 0x12b
function private function_33384cc73651f22f()
{
    self endon( #"death_or_disconnect" );
    weaponobj = self.var_3bf72dcd2775aa78;
    ammo = self.var_a7acf43fb611891;
    rarity = self.var_18988f80052a4d58;
    packlv = self.var_15c8a1faad39f870;
    ammomodname = self.var_bbc0991cb44019fc;
    waitframe();
    
    if ( isplayer( self ) && !self hasweapon( weaponobj ) )
    {
        item_weapon::function_96add18b226ff731( weaponobj );
        var_8bb1b2bde27b267c = ammo ?? utility::get_max_stock_ammo( weaponobj, 1 );
        self setweaponammostock( weaponobj, var_8bb1b2bde27b267c );
        
        if ( isdefined( rarity ) )
        {
            item_weapon::function_40e1cbd0e1f47d1a( weaponobj, rarity );
        }
        
        if ( isdefined( packlv ) )
        {
            utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", weaponobj, packlv, 0 );
        }
        
        if ( isdefined( ammomodname ) )
        {
            if ( utility::issharedfuncdefined( #"ammo_mod", #"hash_24f1a2cf1ed6660d" ) )
            {
                utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", weaponobj, ammomodname, 0 );
            }
        }
        
        self.var_3bf72dcd2775aa78 = weaponobj;
    }
}

