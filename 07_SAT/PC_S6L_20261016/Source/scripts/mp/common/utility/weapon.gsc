// scripts\mp\common\utility\weapon.gsc  (hash_734dce84c468439b.gscc) (size: 27130 Bytes / 0x69fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f7fd0be (1870647486)
// size ...... 27130 (0x69fa)
// includes .. 9   (offset: 0x623a)
// strings ... 101 (offset: 0x6282)
// dev strs .. 31  (offset: 0x6882)
// exports ... 100 (offset: 0x415a)
// cseg ...... 0xbc6 + 0x3594 (0x415a)
// imports ... 133 (offset: 0x50fa)
// animtree1 . 0   (offset: 0x69fa)
// animtree2 . 0   (offset: 0x69fa)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\superdeploy;
#using scripts\mp\supers;

#namespace weapon;

// Namespace weapon
// Params 1
// Checksum 0xfa6e57c0, Offset: 0xbe4
// Size: 0x43
function getattachmenttype( attachmentname )
{
    if ( !isdefined( attachmentname ) )
    {
        assertmsg( "<dev string:x24>" );
        return "";
    }
    
    attachmenttype = tablelookup( "mp/attachmenttable.csv", 4, attachmentname, 2 );
    return attachmenttype;
}

// Namespace weapon
// Params 1
// Checksum 0x7a1d08ba, Offset: 0xc30
// Size: 0x52
function getcompleteweaponnamenoalt( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        assertmsg( "<dev string:x6a>" );
        return "";
    }
    
    fullname = getcompleteweaponname( objweapon );
    
    if ( objweapon.isalternate )
    {
        fullname = getsubstr( fullname, 4 );
    }
    
    return fullname;
}

// Namespace weapon
// Params 3
// Checksum 0x6ac2b939, Offset: 0xc8b
// Size: 0x2aa
function getweapontype( weapon, weaponobj, weapongroup )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xb4>" + weapon );
        return "";
    }
    
    if ( !isdefined( weapongroup ) )
    {
        weapongroup = getweapongroup( weaponobj );
    }
    
    if ( iscacprimaryweapon( weapon, weapongroup ) )
    {
        return "primary";
    }
    
    if ( iscacsecondaryweapon( weapon, weapongroup ) )
    {
        return "secondary";
    }
    
    if ( iskillstreakweapon( weapon ) )
    {
        return "killstreak";
    }
    
    if ( killstreak_utility::iskillstreakdeployweapon( weapon ) )
    {
        return "killstreak_deploy";
    }
    
    if ( superdeploy::function_2417190da7fa263e( weapon ) )
    {
        return "super_deploy";
    }
    
    if ( issuperweapon( weapon ) )
    {
        return "super";
    }
    
    if ( isgamemodeweapon( weapon ) )
    {
        return "gamemode";
    }
    
    if ( weapon == "iw8_turret_50cal_mp" )
    {
        return "turret";
    }
    
    if ( function_bbaeb8f1c1a02231( weapon, weaponobj ) )
    {
        return "level";
    }
    
    if ( isstartstr( weapon, "destructible_" ) )
    {
        return "destructible";
    }
    
    if ( vehicle::isvehicleweapon( weapon ) )
    {
        return "vehicle";
    }
    
    if ( function_e93a21a657377115( weaponobj ) || weapon == "iw8_defibrillator_mp" )
    {
        return "special_melee";
    }
    
    if ( isenvironmentweapon( weapon ) )
    {
        return "environment";
    }
    
    var_7237854e3be197ca = getequipmenttype( weapon );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( weapon == "none" || issubstr( weapon, "execution" ) )
    {
        return "worldspawn";
    }
    
    switch ( weapon )
    {
        case #"hash_1ed1da8a2c218aa7":
        case #"hash_533ad89345613b09":
        case #"hash_55b3daf553a1271e":
            return weapon;
        case #"hash_444e24c19329aec0":
        case #"hash_82c54c49e3242f5b":
            return "super";
        case #"hash_275098dfc4df96df":
        case #"hash_68699589a4141977":
        case #"hash_787ce807fc2023d6":
        case #"hash_da283b7aed23aa70":
            return "gunless";
        case #"hash_3e6715cf4cbc46d0":
        case #"hash_81b9df21125879e2":
        case #"hash_9d164ab536ac5b47":
        case #"hash_b2f452f9e4afa176":
        case #"hash_e960249134c42eb9":
            return "turret";
        case #"hash_ab3485fa6834de47":
        case #"hash_b37b12da46653954":
            return "lethal";
    }
    
    if ( isfistsonly( weapon ) )
    {
        return "fists";
    }
    
    if ( weapon == ( level.var_99884af80074e803 ?? "teammate_revive_stim_mp" ) )
    {
        return "revive";
    }
    
    /#
        if ( getdvarint( @"scr_weapontesting", 0 ) > 0 )
        {
            return "<dev string:xf0>";
        }
    #/
    
    return "unknown";
}

// Namespace weapon
// Params 1
// Checksum 0xec8f99f2, Offset: 0xf3e
// Size: 0x81
function getequipmenttype( objweapon )
{
    if ( isstring( objweapon ) )
    {
        objweapon = makeweapon( objweapon );
    }
    
    equipmentref = objweapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( objweapon );
    
    if ( isdefined( equipmentref ) )
    {
        bundle = level.equipment.table[ equipmentref ].bundle;
        
        if ( isdefined( bundle ) )
        {
            return bundle.equipmenttype;
        }
    }
}

// Namespace weapon
// Params 1
// Checksum 0xff531711, Offset: 0xfc7
// Size: 0x7a, Type: bool
function function_d991bdc544c7f2d0( weaponobj )
{
    switch ( weaponobj.basenamehash )
    {
        case %"rex_radiation_dmz":
        case %"gas_can_toxic_mp":
        case %"gas_can_mp":
        case %"danger_circle_br":
        case %"minefield_mp":
        case %"shock_thunder_mp_br":
            return true;
        default:
            break;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0xf2e1eb42, Offset: 0x104a
// Size: 0x3e, Type: bool
function isenvironmentweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xf8>" );
        return false;
    }
    
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return function_d991bdc544c7f2d0( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0xb5a161d1, Offset: 0x1091
// Size: 0x2b, Type: bool
function function_d4dcd88477cfa8ca( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x133>" );
        return false;
    }
    
    return isdefined( supers_mp::function_4ae7eb52b7c57b( weapon ) );
}

// Namespace weapon
// Params 1
// Checksum 0x686a0cb8, Offset: 0x10c5
// Size: 0x2b, Type: bool
function issuperweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x133>" );
        return false;
    }
    
    return isdefined( supers_mp::getsuperrefforsuperweapon( weapon ) );
}

// Namespace weapon
// Params 1
// Checksum 0x3ac1792, Offset: 0x10f9
// Size: 0x72, Type: bool
function issuperdamagesource( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    if ( issuperweapon( weaponobj ) )
    {
        return true;
    }
    
    switch ( weaponobj.basenamehash )
    {
        case %"super_trophy_mp":
        case %"chargemode_mp":
        case %"micro_turret_gun_mp":
            return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x76e1f0db, Offset: 0x1174
// Size: 0x87, Type: bool
function function_bfe11051df303c94( weaponobj )
{
    if ( function_d565a7ddfefc76e2( weaponobj ) )
    {
        return true;
    }
    
    switch ( weaponobj.basenamehash )
    {
        case %"hash_7d16dd85a3e6fef":
        case %"rex_radiation_dmz":
        case %"danger_circle_br":
        case %"iw9_lm_dblmg":
        case %"iw9_cyberemp_mp":
        case %"shock_thunder_mp_br":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x16cdcb5b, Offset: 0x1204
// Size: 0x3e, Type: bool
function isgamemodeweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:x168>" );
        return false;
    }
    
    return function_bfe11051df303c94( weaponobj );
}

// Namespace weapon
// Params 2
// Checksum 0x94633b18, Offset: 0x124b
// Size: 0x7b
function function_bbaeb8f1c1a02231( weapon, weaponobj )
{
    if ( isdefined( weaponobj ) )
    {
        return weaponobj.islevelweapon;
    }
    
    weaponobject = utility::function_64003742d8f5c781( weapon );
    
    switch ( weaponobject.basenamehash )
    {
        case %"iw8_la_gromeoks_mp":
            return 1;
        case %"iw9_drown_mp":
            return 1;
        default:
            return 0;
    }
    
    return 0;
}

// Namespace weapon
// Params 1
// Checksum 0x29770c19, Offset: 0x12cf
// Size: 0xd5
function function_820c0dca2415bd8( weaponobj )
{
    group = function_adf5eaa819a6a257( weaponobj );
    
    if ( !isdefined( group ) )
    {
        if ( function_d4dcd88477cfa8ca( weaponobj.basenamehash ) )
        {
            group = "super";
        }
        else if ( iskillstreakweaponname( weaponobj.basename ) )
        {
            group = "killstreak";
        }
        else if ( function_bfe11051df303c94( weaponobj ) )
        {
            group = "gamemode";
        }
        else if ( function_a78e72fac3e9c073( weaponobj ) )
        {
            group = "weapon_ballisticSpecial";
        }
        else if ( function_5d5739e57e77d55b( weaponobj ) )
        {
            group = "weapon_dragonsBreath";
        }
        else if ( isunderwaterweaponobject( weaponobj ) )
        {
            group = "weapon_underwater";
        }
        else if ( iswonderweapon( weaponobj ) )
        {
            group = "weapon_wonder";
        }
        else
        {
            group = "other";
        }
    }
    
    return group;
}

// Namespace weapon
// Params 1
// Checksum 0x4dab73b5, Offset: 0x13ad
// Size: 0xc3
function getweapongroup( weapon )
{
    group = getbaseweapongroup( weapon );
    
    if ( !isdefined( group ) )
    {
        if ( issuperweapon( weapon ) )
        {
            group = "super";
        }
        else if ( iskillstreakweapon( weapon ) )
        {
            group = "killstreak";
        }
        else if ( isgamemodeweapon( weapon ) )
        {
            group = "gamemode";
        }
        else if ( isballisticspecial( weapon ) )
        {
            group = "weapon_ballisticSpecial";
        }
        else if ( isdragonsbreath( weapon ) )
        {
            group = "weapon_dragonsBreath";
        }
        else if ( isunderwaterweapon( weapon ) )
        {
            group = "weapon_underwater";
        }
        else if ( iswonderweapon( weapon ) )
        {
            group = "weapon_wonder";
        }
        else
        {
            group = "other";
        }
    }
    
    return group;
}

// Namespace weapon
// Params 1
// Checksum 0x686def6e, Offset: 0x1479
// Size: 0x3f
function function_adf5eaa819a6a257( weaponobj )
{
    if ( !isdefined( weaponobj ) || isnullweapon( weaponobj ) )
    {
        return "other";
    }
    
    rootname = function_170e300815e9c1a2( weaponobj );
    return weapongroupmap( rootname );
}

// Namespace weapon
// Params 1
// Checksum 0x510d5bef, Offset: 0x14c1
// Size: 0x81
function getbaseweapongroup( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return "other";
    }
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return "other";
    }
    
    if ( isstring( weapon ) && ( weapon == "none" || weapon == "alt_none" ) )
    {
        return "other";
    }
    
    rootname = getweaponrootname( weapon );
    group = weapongroupmap( rootname );
    return group;
}

// Namespace weapon
// Params 1
// Checksum 0xcaf5332b, Offset: 0x154b
// Size: 0x3e, Type: bool
function isstimpistolweapon( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return weapobj.var_5e3a1c87edc1edd5 == #"hash_a4d82011a2a333b3";
}

// Namespace weapon
// Params 1
// Checksum 0x2f576b32, Offset: 0x1592
// Size: 0x21, Type: bool
function function_5d5739e57e77d55b( weaponobj )
{
    return weaponobj.basenamehash == %"dragonsbreath_mp";
}

// Namespace weapon
// Params 1
// Checksum 0x4d4adb23, Offset: 0x15bc
// Size: 0x31, Type: bool
function isdragonsbreath( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return function_5d5739e57e77d55b( weapobj );
}

// Namespace weapon
// Params 1
// Checksum 0x95674a57, Offset: 0x15f6
// Size: 0x90
function function_a78e72fac3e9c073( weaponobj )
{
    switch ( weaponobj.basenamehash )
    {
        case %"semtex_bolt_splash_mp":
        case %"semtex_xmike109_mp":
        case %"semtex_bolt_mp":
        case %"thermite_xmike109_radius_mp":
        case %"thermite_bolt_mp":
        case %"semtex_xmike109_splash_mp":
        case %"thermite_xmike109_mp":
        case %"thermite_bolt_radius_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x53a2e780, Offset: 0x168e
// Size: 0x28
function isballisticspecial( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return function_a78e72fac3e9c073( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0x4f0644fd, Offset: 0x16bf
// Size: 0xcf
function getallselectableattachments( weapon )
{
    weaponname = getweaponrootname( weapon );
    weaponstrtok = strtok( weaponname, "_" );
    gunname = weaponstrtok[ 2 ];
    attachments = [];
    
    foreach ( attachmentindex, attachment in level.weaponattachments )
    {
        if ( issubstr( attachmentindex, gunname ) )
        {
            attachments[ attachments.size ] = attachmentindex;
        }
    }
    
    return attachments;
}

// Namespace weapon
// Params 1
// Checksum 0xceb58174, Offset: 0x1797
// Size: 0x64
function getdefaultweaponbasename( basename )
{
    rootname = getweaponrootname( basename );
    
    if ( isdefined( level.weaponmapdata[ rootname ] ) && isdefined( level.weaponmapdata[ rootname ].assetname ) )
    {
        basename = level.weaponmapdata[ rootname ].assetname;
    }
    
    return basename;
}

// Namespace weapon
// Params 1
// Checksum 0x5afa9925, Offset: 0x1804
// Size: 0x5c
function getweapongunsmithattachmenttable( weapon )
{
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    weaponrootname = getweaponrootname( weaponname );
    return "mp/gunsmith/" + getsubstr( weaponrootname, 4 ) + "_attachments.csv";
}

// Namespace weapon
// Params 1
// Checksum 0x8de9609b, Offset: 0x1869
// Size: 0x27
function getaltmodeweapon( objweapon )
{
    if ( isdefined( objweapon.underbarrel ) )
    {
        return objweapon.underbarrel;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x1e3fb42, Offset: 0x1899
// Size: 0x25, Type: bool
function isaltmodeweapon( weaponname )
{
    if ( weaponname == "none" )
    {
        return false;
    }
    
    return weaponinventorytype( weaponname ) == "altmode";
}

// Namespace weapon
// Params 1
// Checksum 0xb7fa90db, Offset: 0x18c7
// Size: 0x23
function removealtmodefromweaponname( weaponname )
{
    if ( isaltmodeweapon( weaponname ) )
    {
        weaponname = getsubstr( weaponname, 4 );
    }
    
    return weaponname;
}

// Namespace weapon
// Params 0
// Checksum 0xb8c6d7f6, Offset: 0x18f3
// Size: 0xf0
function getvalidextraammoweapons()
{
    weaponlist = [];
    primarylist = self getweaponslistprimaries();
    
    foreach ( primary in primarylist )
    {
        weapclass = weaponclass( primary );
        
        if ( !iskillstreakweapon( primary ) && weapclass != "grenade" && weapclass != "rocketlauncher" && self getweaponammostock( primary ) != 0 && ( !primary.isalternate || self getammotype( primary ) == "alternate" ) )
        {
            weaponlist[ weaponlist.size ] = primary;
        }
    }
    
    return weaponlist;
}

// Namespace weapon
// Params 2
// Checksum 0x491e859c, Offset: 0x19ec
// Size: 0xb7, Type: bool
function ispickedupweapon( weapon, weapongroup )
{
    if ( iscacprimaryorsecondary( weapon, weapongroup ) )
    {
        weapname = undefined;
        
        if ( isweapon( weapon ) )
        {
            weapname = getcompleteweaponname( weapon getnoaltweapon() );
        }
        else if ( isstring( weapon ) )
        {
            weapname = weapon;
            
            if ( issubstr( weapname, "alt_" ) )
            {
                weapname = getsubstr( weapname, 4, weapon.size );
            }
        }
        
        var_9288ec38b4bcaa57 = self.pers[ "primaryWeapon" ] == weapname;
        var_fdbabb69004c22f3 = self.pers[ "secondaryWeapon" ] == weapname;
        
        if ( !var_9288ec38b4bcaa57 && !var_fdbabb69004c22f3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x821b0c9d, Offset: 0x1aac
// Size: 0x52, Type: bool
function function_d57c5d3783f44042( objweapon )
{
    loadoutselected = class::function_c076a1e54ebf636a();
    
    if ( loadoutselected )
    {
        if ( issameweapon( loadoutselected.loadoutprimaryobject, objweapon ) )
        {
            return true;
        }
        
        if ( issameweapon( loadoutselected.loadoutsecondaryobject, objweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon
// Params 2
// Checksum 0xa9b70e13, Offset: 0x1b07
// Size: 0x28
function iscacprimaryweapon( weapon, weapongroup )
{
    return iscacprimaryweapongroup( weapongroup ?? getweapongroup( weapon ) );
}

// Namespace weapon
// Params 1
// Checksum 0xd347bacf, Offset: 0x1b38
// Size: 0xab
function iscacprimaryweapongroup( weapongroup )
{
    switch ( weapongroup )
    {
        case #"hash_bef5ec0b3e197ae":
        case #"hash_16cf6289ab06bd30":
        case #"hash_2535634d8bb5c955":
        case #"hash_3df32e3d76b9b4d4":
        case #"hash_47368bc0d2ef1565":
        case #"hash_86b11ac21f992552":
        case #"hash_8af0086b038622b5":
        case #"hash_ab10f9c080fe4faf":
        case #"hash_beb5fb9bd9c6cc5c":
        case #"hash_c095d67337b1f5a1":
        case #"hash_dd616da0b395a0b0":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 2
// Checksum 0x538170a4, Offset: 0x1beb
// Size: 0x29
function iscacsecondaryweapon( weapon, weapongroup )
{
    return iscacsecondaryweapongroup( weapongroup ?? getweapongroup( weapon ), weapon );
}

// Namespace weapon
// Params 2
// Checksum 0xc9c5c9b3, Offset: 0x1c1d
// Size: 0x79
function iscacsecondaryweapongroup( weapongroup, weapon )
{
    switch ( weapongroup )
    {
        case #"hash_34340d457a63e7f1":
        case #"hash_9d18adab1b65a661":
        case #"hash_cd7f87dc1cdeaa54":
            return 1;
        case #"hash_a1f27f97be15d620":
            return !ismeleeoverrideweapon( weapon );
        case #"hash_a4b73ae5b4b9158b":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 2
// Checksum 0xce3d1dbd, Offset: 0x1c9e
// Size: 0x39, Type: bool
function iscacprimaryorsecondary( weapon, weapongroup = getweapongroup( weapon ) )
{
    return iscacprimaryweapongroup( weapongroup ) || iscacsecondaryweapongroup( weapongroup, weapon );
}

// Namespace weapon
// Params 2
// Checksum 0x7057bb3e, Offset: 0x1ce0
// Size: 0x38, Type: bool
function iscacmeleeweapon( weapon, weapongroup = getweapongroup( weapon ) )
{
    return weapongroup == "weapon_melee" || weapongroup == "weapon_melee2";
}

// Namespace weapon
// Params 2
// Checksum 0xab6d1a18, Offset: 0x1d21
// Size: 0x2c, Type: bool
function function_ea250bfa8e4c904b( weapon, weapongroup = getweapongroup( weapon ) )
{
    return weapongroup == "weapon_projectile";
}

// Namespace weapon
// Params 0
// Checksum 0x8a3619e6, Offset: 0x1d56
// Size: 0x28
function enableweaponlaser()
{
    if ( !isdefined( self.weaponlasercalls ) )
    {
        self.weaponlasercalls = 0;
    }
    
    self.weaponlasercalls++;
    self laseron();
}

// Namespace weapon
// Params 0
// Checksum 0x66b871ff, Offset: 0x1d86
// Size: 0x59
function disableweaponlaser()
{
    assert( isdefined( self.weaponlasercalls ), "<dev string:x194>" );
    self.weaponlasercalls--;
    assert( self.weaponlasercalls >= 0, "<dev string:x1de>" );
    
    if ( self.weaponlasercalls == 0 )
    {
        self laseroff();
        self.weaponlasercalls = undefined;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x584c4e67, Offset: 0x1de7
// Size: 0x64
function weaponperkmap( weaponroot )
{
    assert( isdefined( level.weaponmapdata ), "<dev string:x249>" );
    
    if ( isdefined( level.weaponmapdata[ weaponroot ] ) && isdefined( level.weaponmapdata[ weaponroot ].perk ) )
    {
        return level.weaponmapdata[ weaponroot ].perk;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x9723f52, Offset: 0x1e54
// Size: 0x38
function getrandomweaponfromgroup( group )
{
    index = randomintrange( 0, level.weapongroupdata[ group ].size );
    return level.weapongroupdata[ group ][ index ];
}

// Namespace weapon
// Params 2
// Checksum 0xe1c59aea, Offset: 0x1e95
// Size: 0xcf
function getweaponvariantids( weaponroot, blockedids = [] )
{
    variantids = [];
    weaponasset = level.weaponmapdata[ weaponroot ].assetname;
    
    if ( isdefined( weaponasset ) )
    {
        foreach ( blueprint in getweaponblueprintnames( weaponasset ) )
        {
            if ( !arraycontains( blockedids, blueprint ) )
            {
                variantids[ variantids.size ] = blueprint;
            }
        }
    }
    
    return variantids;
}

// Namespace weapon
// Params 2
// Checksum 0x96a7a4b4, Offset: 0x1f6d
// Size: 0x52
function getweaponrandomvariantid( weaponroot, blockedids = [] )
{
    id = 0;
    validids = getweaponvariantids( weaponroot, blockedids );
    
    if ( validids.size > 0 )
    {
        id = validids[ randomint( validids.size ) ];
    }
    
    return id;
}

// Namespace weapon
// Params 1
// Checksum 0x17890d65, Offset: 0x1fc8
// Size: 0x19, Type: bool
function weaponexistsinstatstable( weaponroot )
{
    return isdefined( level.weaponmapdata[ weaponroot ] );
}

// Namespace weapon
// Params 2
// Checksum 0xe7f46771, Offset: 0x1fea
// Size: 0x35
function isattachmentsniperscopedefault( weaponname, attachname )
{
    tokens = strtok( weaponname, "_" );
    return isattachmentsniperscopedefaulttokenized( tokens, attachname );
}

// Namespace weapon
// Params 2
// Checksum 0x3ae71180, Offset: 0x2028
// Size: 0xc6
function isattachmentsniperscopedefaulttokenized( weapontokens, attachname )
{
    assert( isarray( weapontokens ), "<dev string:x288>" );
    result = 0;
    
    if ( weapontokens.size && isdefined( attachname ) )
    {
        idx = 0;
        
        if ( weapontokens[ 0 ] == "alt" )
        {
            idx = 1;
        }
        
        if ( weapontokens.size >= 3 + idx && ( weapontokens[ idx ] == "iw6" || weapontokens[ idx ] == "iw7" ) )
        {
            if ( weaponclass( weapontokens[ idx ] + "_" + weapontokens[ idx + 1 ] + "_" + weapontokens[ idx + 2 ] ) == "sniper" )
            {
                result = weapontokens[ idx + 1 ] + "scope" == attachname;
            }
        }
    }
    
    return result;
}

// Namespace weapon
// Params 0
// Checksum 0xcd77317, Offset: 0x20f7
// Size: 0xa0
function getnonopticattachmentlistbasenames()
{
    attachmentlist = [];
    numrows = tablelookupgetnumrows( "mp/attachmenttable.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        attachmentname = tablelookupbyrow( "mp/attachmenttable.csv", index, 5 );
        group = tablelookupbyrow( "mp/attachmenttable.csv", index, 2 );
        
        if ( attachmentname != "" && group != "none" && group != "rail" && !arraycontains( attachmentlist, attachmentname ) )
        {
            attachmentlist[ attachmentlist.size ] = attachmentname;
        }
    }
    
    return attachmentlist;
}

// Namespace weapon
// Params 0
// Checksum 0x414cfa6a, Offset: 0x21a0
// Size: 0xc2
function getopticattachmentlistbasenames()
{
    var_7237854e3be197ca = level.opticattachmentbasenames;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    attachmentlist = [];
    numrows = tablelookupgetnumrows( "mp/attachmenttable.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        group = tablelookupbyrow( "mp/attachmenttable.csv", index, 2 );
        attachmentname = tablelookupbyrow( "mp/attachmenttable.csv", index, 5 );
        
        if ( attachmentname != "" && group == "rail" && !arraycontains( attachmentlist, attachmentname ) )
        {
            attachmentlist[ attachmentlist.size ] = attachmentname;
        }
    }
    
    level.opticattachmentbasenames = attachmentlist;
    return level.opticattachmentbasenames;
}

// Namespace weapon
// Params 3
// Checksum 0xaa26b46a, Offset: 0x226b
// Size: 0x302
function mapweapon( objweapon, inflictor, var_df5e94f8769c3540 )
{
    var_c83b16a307b9c80d = objweapon ?? nullweapon();
    remapweapon = 0;
    
    if ( var_c83b16a307b9c80d.basename != "none" )
    {
        if ( isdefined( inflictor ) && !isplayer( inflictor ) )
        {
            altweapon = getaltmodeweapon( objweapon );
            
            if ( isdefined( altweapon ) )
            {
                switch ( altweapon )
                {
                    case #"hash_46f5e5d5dcc40a15":
                    case #"hash_4adaf4a688093960":
                    case #"hash_91c4e6c99dbd12fa":
                    case #"hash_bf9186d366bb0638":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "concussion_grenade_mp" );
                        break;
                    case #"hash_4aeb965aa988c369":
                    case #"hash_d376328b0052cc6d":
                    case #"hash_d78170432d48ea13":
                    case #"hash_e6645051b5b4b0d4":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "flash_grenade_mp" );
                        break;
                    case #"hash_3596cbf1c0965027":
                    case #"hash_8677a757b3bfd260":
                    case #"hash_9bf42678b7ceca81":
                    case #"hash_ad541933b23baadd":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "snapshot_grenade_mp" );
                        break;
                    case #"hash_1e9751b75f7cf232":
                    case #"hash_9bdd4a77de2178e1":
                    case #"hash_a29ecb3d754c1403":
                    case #"hash_a3991996e09eb513":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "thermite_mp" );
                        break;
                    case #"hash_1f2ad6f0a8a0da6b":
                    case #"hash_4d0defb6d4c7dd6c":
                    case #"hash_64b33ac96ed2f791":
                    case #"hash_a54bf40834af0df5":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "semtex_mp" );
                        break;
                    case #"hash_f8bbf06ce7865e4":
                    case #"hash_75e72e81c0590e87":
                    case #"hash_c3d0fe2d2f18a4fa":
                    case #"hash_e1e8d438ee4215de":
                        var_c83b16a307b9c80d = function_80745a4905e8ac4c( "bunkerbuster_mp" );
                        break;
                    case #"hash_b317f7e501b82072":
                        if ( objweapon.isalternate )
                        {
                            var_c83b16a307b9c80d = function_80745a4905e8ac4c( "jup_flash_grenade_ob" );
                        }
                        
                        break;
                }
            }
        }
        
        switch ( var_c83b16a307b9c80d.basename )
        {
            case #"hash_b833f98278746f9b":
                var_c83b16a307b9c80d = function_80745a4905e8ac4c( "pop_rocket_mp" );
                break;
            case #"hash_9a3452323e288ff3":
            case #"hash_c05ea160f6d9bb25":
                var_c83b16a307b9c80d = function_80745a4905e8ac4c( "iw8_turret_50cal_mp" );
                break;
            case #"hash_5f2ad7140f378ee1":
                var_c83b16a307b9c80d = nullweapon();
                break;
        }
    }
    else if ( isdefined( inflictor ) )
    {
        if ( isdefined( inflictor.objweapon ) )
        {
            var_c83b16a307b9c80d = function_80745a4905e8ac4c( inflictor.objweapon.basename );
            remapweapon = 1;
        }
        else if ( isdefined( inflictor.weapon_name ) )
        {
            var_c83b16a307b9c80d = function_80745a4905e8ac4c( inflictor.weapon_name );
            remapweapon = 1;
        }
    }
    
    if ( remapweapon && !var_df5e94f8769c3540 )
    {
        var_c83b16a307b9c80d = mapweapon( var_c83b16a307b9c80d, inflictor, 1 );
    }
    
    return var_c83b16a307b9c80d;
}

// Namespace weapon
// Params 2
// Checksum 0x1e440424, Offset: 0x2576
// Size: 0xba
function attachmentsfilterforstats( attachments, weapon )
{
    filtered = [];
    
    if ( !isdefined( attachments ) )
    {
        return filtered;
    }
    
    weaponrootname = getweaponrootname( weapon );
    
    foreach ( a in attachments )
    {
        if ( attachmentlogsstats( a, weaponrootname ) )
        {
            filtered[ filtered.size ] = a;
        }
    }
    
    return filtered;
}

// Namespace weapon
// Params 2
// Checksum 0x343930d8, Offset: 0x2639
// Size: 0x36, Type: bool
function attachmentlogsstats( attachment, weaponrootname )
{
    if ( !attachmentisselectablerootname( weaponrootname, attachment ) )
    {
        return false;
    }
    
    if ( isstartstr( attachment, "laststand_" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace weapon
// Params 2
// Checksum 0x5fbd0cbe, Offset: 0x2678
// Size: 0xb1, Type: bool
function weaponhasattachment( weapon, attachmentname )
{
    if ( !( isdefined( weapon ) && isdefined( attachmentname ) ) )
    {
        return false;
    }
    
    weaponattachments = getweaponattachments( weapon );
    
    if ( !isdefined( weaponattachments ) )
    {
        return false;
    }
    
    foreach ( attachment in weaponattachments )
    {
        if ( attachment == attachmentname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0xceb8121a, Offset: 0x2732
// Size: 0x107, Type: bool
function function_4476e03c10ef82b9( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    group = getweapongroup( weapon );
    
    switch ( group )
    {
        case #"hash_16cf6289ab06bd30":
            if ( weapon.basename == "iw9_sh_mviktor_mp" )
            {
                return true;
            }
            else
            {
                return false;
            }
        case #"hash_86b11ac21f992552":
        case #"hash_9d18adab1b65a661":
        case #"hash_a1f27f97be15d620":
            return false;
    }
    
    if ( isdefined( weapon.basename ) )
    {
        switch ( weapon.basename )
        {
            case #"hash_1ee4b4461a10e3f1":
            case #"hash_36493c758ad2ab7e":
            case #"hash_5e7bf75eb9db150e":
            case #"hash_87262a67e163f7c9":
            case #"hash_a86d4075406d2de4":
            case #"hash_bba2ab4d0ed302b6":
            case #"hash_d2d2f2854b7d8b7d":
            case #"hash_f6a8ecc6e13ca3b6":
                return false;
        }
    }
    
    return true;
}

// Namespace weapon
// Params 7
// Checksum 0xed175859, Offset: 0x2842
// Size: 0x13b
function _launchgrenade( weaponname, origin, velocity, var_f4f3f0356fef8102, notthrown, var_93e691e8536b5f6d, tickpercentoverride )
{
    grenade = self launchgrenade( weaponname, origin, velocity, var_f4f3f0356fef8102, var_93e691e8536b5f6d );
    
    if ( !isdefined( grenade ) )
    {
        mag = "weapon::_launchGrenade() failed! Weapon: " + weaponname;
        
        if ( isdefined( self ) && isdefined( self.name ) )
        {
            mag += ", Player: " + self.name;
        }
        
        if ( isdefined( origin ) )
        {
            mag += ", Origin: " + origin;
        }
        
        if ( isdefined( velocity ) )
        {
            mag += ", Velocity: " + velocity;
        }
        
        if ( isdefined( notthrown ) )
        {
            mag += ", NotThrown: " + notthrown;
        }
        
        if ( isdefined( var_93e691e8536b5f6d ) )
        {
            mag += ", RelaunchEnt: " + var_93e691e8536b5f6d;
        }
        
        assertmsg( mag );
        logstring( mag );
        return;
    }
    
    if ( !isdefined( notthrown ) )
    {
        grenade.notthrown = 1;
    }
    else
    {
        grenade.notthrown = notthrown;
    }
    
    if ( isdefined( tickpercentoverride ) )
    {
        grenade.tickpercent = tickpercentoverride;
    }
    
    grenade setotherent( self );
    return grenade;
}

// Namespace weapon
// Params 1
// Checksum 0x61b5ee6f, Offset: 0x2986
// Size: 0x18, Type: bool
function grenadethrown( grenade )
{
    return !grenade.notthrown;
}

// Namespace weapon
// Params 0
// Checksum 0x8513a5f1, Offset: 0x29a7
// Size: 0xc, Type: bool
function grenadeinpullback()
{
    return !isnullweapon( self getheldoffhand() );
}

// Namespace weapon
// Params 2
// Checksum 0x8a303355, Offset: 0x29bc
// Size: 0xd5
function weaponignoresblastshield( objweapon, shitloc )
{
    weapon = utility::function_64003742d8f5c781( objweapon );
    
    if ( issuperweapon( weapon ) )
    {
        return 1;
    }
    
    if ( function_6011e4dd56d52c6f( weapon ) )
    {
        return 1;
    }
    
    switch ( weapon.basenamehash )
    {
        case %"rex_concussion_grenade_mp":
        case %"sat_snowball_mp":
        case %"hash_1e97e937ff467dab":
        case %"concussion_grenade_mp":
        case %"snapshot_grenade_mp":
        case %"gas_mp":
        case %"hash_56e9bc574acd9d63":
        case %"flash_grenade_mp":
        case %"bomb_site_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x5ef03601, Offset: 0x2a99
// Size: 0x104
function issinglehitweapon( weaponname )
{
    weaponobj = utility::function_64003742d8f5c781( weaponname );
    
    switch ( weaponobj.basenamehash )
    {
        case %"jup_jp22_la_dromeo_mp":
        case %"iw9_la_kgolf_mp":
        case %"iw9_la_rpapa7_mp":
        case %"iw8_la_kgolf_mp":
        case %"iw8_la_gromeo_mp":
        case %"iw8_la_juliet_mp":
        case %"iw9_la_gromeo_mp":
        case %"iw8_la_gromeoks_mp":
        case %"t10_la_p18_stisaac_mp":
        case %"iw8_la_mike32_mp":
        case %"jup_jp26_la_mike32_mp":
        case %"iw8_la_rpapa7_mp":
        case %"iw9_la_mike32_mp":
        case %"t10_la_p17_pable3_mp":
        case %"iw9_la_juliet_mp":
        case %"t10_ks_m202":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x4cc38737, Offset: 0x2ba5
// Size: 0x3f
function function_41e030f22f72468c( attachment )
{
    attachmentassert = getscriptbundle( hashcat( %"hash_3c2c9813bb16552f", attachment ) );
    
    if ( !isdefined( attachmentassert ) )
    {
        return 0;
    }
    
    return attachmentassert.isdefault;
}

// Namespace weapon
// Params 1
// Checksum 0x16289027, Offset: 0x2bed
// Size: 0x86
function function_64ad6bd042bc51d3( attachment )
{
    if ( isdefined( level.var_de508af3885e2c0f[ attachment ] ) )
    {
        return level.var_de508af3885e2c0f[ attachment ];
    }
    
    value = getscriptbundlefieldvalue( hashcat( %"hash_3c2c9813bb16552f", attachment ), #"isprestige" );
    
    if ( !isdefined( level.var_de508af3885e2c0f ) )
    {
        level.var_de508af3885e2c0f = [];
    }
    
    level.var_de508af3885e2c0f[ attachment ] = value ?? 0;
    return level.var_de508af3885e2c0f[ attachment ];
}

// Namespace weapon
// Params 2
// Checksum 0xa335c199, Offset: 0x2c7c
// Size: 0x32
function attachmentisselectable( weaponobj, attachment )
{
    rootname = getweaponrootname( weaponobj );
    return attachmentisselectablerootname( rootname, attachment );
}

// Namespace weapon
// Params 2
// Checksum 0xa98f22c, Offset: 0x2cb7
// Size: 0x6c, Type: bool
function attachmentisselectablerootname( weaponrootname, attachment )
{
    assetname = level.weaponmapdata[ weaponrootname ].assetname;
    
    if ( isdefined( assetname ) )
    {
        slot = function_5b465daf157fa9a1( assetname, attachment );
        
        if ( isdefined( slot ) && slot != -1 )
        {
            return istrue( level.weaponattachments[ attachment ] );
        }
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0xf028b407, Offset: 0x2d2c
// Size: 0x9b
function weapongetflinchtype( weaponobj )
{
    class = "none";
    flinchtype = -1;
    
    if ( isdefined( weaponobj ) && !isnullweapon( weaponobj ) )
    {
        class = weaponclass( weaponobj );
        
        switch ( class )
        {
            case #"hash_719417cb1de832b6":
                flinchtype = 1;
                break;
            case #"hash_6191aaef9f922f96":
                if ( getweapongroup( weaponobj ) == "weapon_dmr" )
                {
                    flinchtype = 3;
                }
                else
                {
                    flinchtype = 4;
                }
                
                break;
            default:
                flinchtype = 0;
                break;
        }
    }
    
    return flinchtype;
}

// Namespace weapon
// Params 1
// Checksum 0x4b406037, Offset: 0x2dd0
// Size: 0x9b, Type: bool
function function_d565a7ddfefc76e2( weaponobj )
{
    switch ( weaponobj.basenamehash )
    {
        case %"counter_attack_bomb_silent_mp":
        case %"briefcase_defuse_silent_mp":
        case %"briefcase_bomb_defuse_mp":
        case %"counter_attack_bomb_mp":
        case %"briefcase_bomb_mp_nuke":
        case %"counter_attack_bomb_defuse_mp":
        case %"bomb_site_mp":
        case %"briefcase_silent_mp":
        case %"briefcase_bomb_mp":
        case %"counter_attack_bomb_defuse_silent_mp":
            return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x3ce780b, Offset: 0x2e74
// Size: 0x47, Type: bool
function isbombsiteweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x2d5>" );
        return false;
    }
    
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    return function_d565a7ddfefc76e2( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0x87bb343d, Offset: 0x2ec4
// Size: 0x2a, Type: bool
function iskillstreakvehicleinflictor( einflictor )
{
    return isdefined( einflictor ) && isdefined( einflictor.streakinfo ) && einflictor vehicle::is_vehicle();
}

// Namespace weapon
// Params 2
// Checksum 0xff7114f2, Offset: 0x2ef7
// Size: 0x66, Type: bool
function weaponbypassspawnprotection( weapon, streakname )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x312>" );
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( !function_d03dfbe9771a08a4( weaponname, streakname ) )
    {
        return false;
    }
    
    return true;
}

// Namespace weapon
// Params 2
// Checksum 0xf214a719, Offset: 0x2f66
// Size: 0x12e, Type: bool
function function_d03dfbe9771a08a4( weaponname, streakname )
{
    if ( iskillstreakweapon( weaponname ) )
    {
        if ( !isdefined( streakname ) || streakname == "" )
        {
            streakname = level.killstreakweaponmap[ weaponname ];
        }
        
        bundle = killstreak_utility::function_f943c0602acdc2af( streakname );
        
        if ( bundle.var_6016797a3fef0f60 )
        {
            return true;
        }
        
        weaponentries = killstreak_utility::function_b5d94c2d60f51b9d( streakname );
        
        foreach ( entry in weaponentries )
        {
            if ( entry.weaponname == weaponname && entry.weaponbypassspawnprotection )
            {
                return true;
            }
        }
        
        if ( isminigunweapon( weaponname ) )
        {
            return true;
        }
        
        if ( weaponname == "manual_turret_mp" || weaponname == "pac_sentry_turret_mp" )
        {
            return true;
        }
        
        return false;
    }
    
    return true;
}

// Namespace weapon
// Params 1
// Checksum 0xfa09f7c8, Offset: 0x309d
// Size: 0x4b
function function_7940d8028488f980( weaponname )
{
    switch ( weaponname )
    {
        case #"hash_1cb3f2dbe85b8540":
        case #"hash_33aef56fb95396fd":
        case #"hash_fc4c0a8ee31549bb":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0xc99d4dc5, Offset: 0x30f0
// Size: 0x54
function function_cbb4475c36fea5db( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x35a>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    return function_7940d8028488f980( weaponname );
}

// Namespace weapon
// Params 1
// Checksum 0x43810c61, Offset: 0x314d
// Size: 0x76
function isgesture( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x399>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( issubstr( weaponname, "ges_plyr" ) )
    {
        return 1;
    }
    
    if ( issubstr( weaponname, "devilhorns_mp" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace weapon
// Params 1
// Checksum 0xdac12268, Offset: 0x31cb
// Size: 0x38
function getweaponfullname( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x3cf>" );
        return 0;
    }
    
    if ( isstring( weapon ) )
    {
        return weapon;
    }
    
    return getcompleteweaponname( weapon );
}

// Namespace weapon
// Params 2
// Checksum 0xb84be624, Offset: 0x320b
// Size: 0x362
function playdeatomizefx( soundoverride, offset )
{
    loc[ 0 ][ 0 ][ "org" ] = self gettagorigin( "j_spineupper" );
    loc[ 0 ][ 0 ][ "angles" ] = self gettagangles( "j_spineupper" );
    loc[ 0 ][ 1 ][ "org" ] = self gettagorigin( "j_spinelower" );
    loc[ 0 ][ 1 ][ "angles" ] = self gettagangles( "j_spinelower" );
    loc[ 0 ][ 2 ][ "org" ] = self gettagorigin( "j_head" );
    loc[ 0 ][ 2 ][ "angles" ] = self gettagangles( "j_head" );
    loc[ 1 ][ 0 ][ "org" ] = self gettagorigin( "j_knee_ri" );
    loc[ 1 ][ 0 ][ "angles" ] = self gettagangles( "j_knee_ri" );
    loc[ 1 ][ 1 ][ "org" ] = self gettagorigin( "j_knee_le" );
    loc[ 1 ][ 1 ][ "angles" ] = self gettagangles( "j_knee_le" );
    loc[ 1 ][ 2 ][ "org" ] = self gettagorigin( "j_elbow_ri" );
    loc[ 1 ][ 2 ][ "angles" ] = self gettagangles( "j_elbow_ri" );
    loc[ 1 ][ 3 ][ "org" ] = self gettagorigin( "j_elbow_le" );
    loc[ 1 ][ 3 ][ "angles" ] = self gettagangles( "j_elbow_le" );
    loc[ 2 ][ 0 ][ "org" ] = self gettagorigin( "j_ankle_le" );
    loc[ 2 ][ 0 ][ "angles" ] = self gettagangles( "j_ankle_le" );
    loc[ 2 ][ 1 ][ "org" ] = self gettagorigin( "j_ankle_ri" );
    loc[ 2 ][ 1 ][ "angles" ] = self gettagangles( "j_ankle_ri" );
    loc[ 2 ][ 2 ][ "org" ] = self gettagorigin( "j_wrist_le" );
    loc[ 2 ][ 2 ][ "angles" ] = self gettagangles( "j_wrist_le" );
    loc[ 2 ][ 3 ][ "org" ] = self gettagorigin( "j_wrist_ri" );
    loc[ 2 ][ 3 ][ "angles" ] = self gettagangles( "j_wrist_ri" );
    soundtoplay = "bullet_atomizer_impact_npc";
    fxoffset = ( 0, 0, 0 );
    
    if ( isdefined( offset ) )
    {
        fxoffset = offset;
    }
    
    if ( isdefined( soundoverride ) )
    {
        soundtoplay = soundoverride;
    }
    
    self playsound( soundtoplay );
    
    foreach ( entry in loc )
    {
        foreach ( spot in entry )
        {
            playfx( level._effect[ "atomize_body" ], spot[ "org" ] + fxoffset, anglestoforward( spot[ "angles" ] ) );
        }
        
        wait 0.01;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x6d6a9638, Offset: 0x3575
// Size: 0x10f
function isprimaryweapon( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        assertmsg( "<dev string:x40d>" );
        return 0;
    }
    
    if ( objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode" )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"weapon", #"hash_2fa5c15c5e96d565" ) )
    {
        result = utility::callsharedfunc( #"weapon", #"hash_2fa5c15c5e96d565", objweapon );
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    switch ( objweapon.classname )
    {
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_61e969dacaaf9881":
        case #"hash_719417cb1de832b6":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x58828705, Offset: 0x368c
// Size: 0x28, Type: bool
function function_e93a21a657377115( objweapon )
{
    return objweapon == level.defaultknifestab || objweapon == level.defaultswimweapon;
}

// Namespace weapon
// Params 1
// Checksum 0x5bc881bc, Offset: 0x36bd
// Size: 0x3c, Type: bool
function ismeleeoverrideweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x44c>" );
        return false;
    }
    
    if ( !isweapon( weapon ) )
    {
        weapon = makeweapon( weapon );
    }
    
    return function_e93a21a657377115( weapon );
}

// Namespace weapon
// Params 1
// Checksum 0x39a4dc17, Offset: 0x3702
// Size: 0x46, Type: bool
function ismeleeonly( weapon )
{
    assert( isdefined( weapon ), "<dev string:x48e>" );
    assert( !isstring( weapon ), "<dev string:x4c6>" );
    return !isstring( weapon ) && weapon.ismelee;
}

// Namespace weapon
// Params 1
// Checksum 0x238d0ead, Offset: 0x3751
// Size: 0x54, Type: bool
function isfistsonly( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x503>" );
        return false;
    }
    
    rootweaponname = getweaponrootname( weapon );
    return rootweaponname == function_170e300815e9c1a2( level.defaultfist ) || rootweaponname == "iw9_me_superfists";
}

// Namespace weapon
// Params 1
// Checksum 0xf84102c1, Offset: 0x37ae
// Size: 0x48, Type: bool
function isballweapon( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        assertmsg( "<dev string:x53b>" );
        return false;
    }
    
    return objweapon.basename == "iw9_cyberemp_mp" || objweapon.basename == "iw7_tdefball_mp";
}

// Namespace weapon
// Params 1
// Checksum 0x2d7d159c, Offset: 0x37ff
// Size: 0x53, Type: bool
function function_251a6cf32459b82d( objweapon )
{
    return objweapon.basenamehash == %"jup_jp23_me_spear_mp" || objweapon.basenamehash == %"zul_me_spear_mp" || objweapon.basenamehash == %"hash_771017d9e29852be";
}

// Namespace weapon
// Params 1
// Checksum 0x9088abec, Offset: 0x385b
// Size: 0x34, Type: bool
function function_33e74163843b348e( weapon )
{
    weapon = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x577>" );
        return false;
    }
    
    return function_251a6cf32459b82d( weapon );
}

// Namespace weapon
// Params 1
// Checksum 0xfc03e615, Offset: 0x3898
// Size: 0x5e, Type: bool
function function_707f7162a89aa0e0( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x5b4>" );
        return false;
    }
    
    laststandweapon = level.gametypebundle.laststandweapon;
    var_9b50d2c267b0b8c9 = getweaponrootname( laststandweapon );
    return getweaponrootname( weapon ) == var_9b50d2c267b0b8c9;
}

// Namespace weapon
// Params 1
// Checksum 0xafd71925, Offset: 0x38ff
// Size: 0x42, Type: bool
function isakimbomeleeweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x605>" );
        return false;
    }
    
    return getweaponrootname( weapon ) == "iw8_me_akimboblunt" || getweaponrootname( weapon ) == "iw8_me_akimboblades";
}

// Namespace weapon
// Params 1
// Checksum 0x14f9581f, Offset: 0x394a
// Size: 0x82, Type: bool
function function_e1a6c47f66c6de20( objweapon )
{
    if ( objweapon.classname == "throwingknife" )
    {
        return true;
    }
    
    switch ( objweapon.basenamehash )
    {
        case %"throwingknife_wz":
        case %"throwingknife_mp":
        case %"throwingknife_fire_mp":
        case %"hash_1d0617a79d86a480":
        case %"shuriken_mp":
        case %"rex_throwingknife_mp":
            return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x95b2d5e6, Offset: 0x39d5
// Size: 0x3e, Type: bool
function isthrowingknife( weapon )
{
    if ( !isweapon( weapon ) )
    {
        weapon = utility::function_64003742d8f5c781( weapon );
    }
    
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x64a>" );
        return false;
    }
    
    return function_e1a6c47f66c6de20( weapon );
}

// Namespace weapon
// Params 1
// Checksum 0x45568d75, Offset: 0x3a1c
// Size: 0x6f
function isthrowingstar( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x68b>" );
        return 0;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return 0;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return 0;
        }
        
        weapname = weapon;
    }
    
    return issubstr( weapname, "throwstar" );
}

// Namespace weapon
// Params 1
// Checksum 0xb3dd031, Offset: 0x3a94
// Size: 0x7e, Type: bool
function issnowball( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x6cb>" );
        return false;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return false;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return false;
        }
        
        weapname = weapon;
    }
    
    return issubstr( weapname, "snowball" ) || issubstr( weapname, "pball" );
}

// Namespace weapon
// Params 1
// Checksum 0x12919b02, Offset: 0x3b1b
// Size: 0x6f
function function_b31ea04b0d6c8935( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x707>" );
        return 0;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return 0;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return 0;
        }
        
        weapname = weapon;
    }
    
    return issubstr( weapname, "pball" );
}

// Namespace weapon
// Params 1
// Checksum 0x940be8b5, Offset: 0x3b93
// Size: 0x6f
function isgoldengun( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x749>" );
        return 0;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return 0;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return 0;
        }
        
        weapname = weapon;
    }
    
    return issubstr( weapname, "goldengun" );
}

// Namespace weapon
// Params 1
// Checksum 0x3b21db37, Offset: 0x3c0b
// Size: 0x6f
function function_4c948bc86e32680a( var_b541b98c7febbc0 )
{
    switch ( var_b541b98c7febbc0 ?? %"" )
    {
        case %"iw8_gunless_last_stand_enter":
        case %"iw9_gunless_mp":
        case %"iw9_gunless":
        case %"iw8_gunless_infil":
        case %"iw8_gunless":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0xf5736953, Offset: 0x3c82
// Size: 0x70
function isgunlessweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x786>" );
        return 0;
    }
    
    var_8d8f75bf184a2a20 = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return 0;
        }
        
        var_8d8f75bf184a2a20 = weapon.basenamehash;
    }
    else
    {
        if ( weapon == "none" )
        {
            return 0;
        }
        
        var_8d8f75bf184a2a20 = getxhashasset( weapon );
    }
    
    return function_4c948bc86e32680a( var_8d8f75bf184a2a20 );
}

// Namespace weapon
// Params 3
// Checksum 0x7bdfe814, Offset: 0x3cfb
// Size: 0xe8
function infiniteammothread( waittime, weapons, refreshweaponlist )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ffdf18a9572c8f52" );
    
    if ( !isdefined( waittime ) )
    {
        waittime = level.framedurationseconds;
    }
    
    while ( true )
    {
        if ( !isdefined( weapons ) || refreshweaponlist )
        {
            weapons = self.equippedweapons;
        }
        
        foreach ( weapon in weapons )
        {
            self givemaxammo( weapon );
            self setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
        
        wait waittime;
    }
}

// Namespace weapon
// Params 4
// Checksum 0x1284b5cb, Offset: 0x3deb
// Size: 0x180
function function_df222ccdddfe64d1( percentage, max_bullets, var_b17bebce90c0d005, allow_alternate )
{
    assert( isplayer( self ) );
    
    if ( percentage <= 0 )
    {
        return;
    }
    
    current_weapon = self getcurrentweapon();
    
    if ( !allow_alternate && self isalternatemode( current_weapon ) )
    {
        current_weapon = current_weapon getnoaltweapon();
    }
    
    clip_size = weaponclipsize( current_weapon );
    to_fill = int( ceil( clip_size * percentage / 100 ) );
    
    if ( !isdefined( max_bullets ) )
    {
        max_bullets = 0;
    }
    
    if ( max_bullets > 0 )
    {
        to_fill = min( to_fill, max_bullets );
    }
    
    hand_array = self isdualwielding() ? [ "right", "left" ] : [ "right" ];
    
    foreach ( hand in hand_array )
    {
        current_ammo = self getweaponammoclip( current_weapon, hand );
        var_2ebdeecc1e334a0 = to_fill + current_ammo;
        
        if ( var_2ebdeecc1e334a0 >= clip_size )
        {
            var_2ebdeecc1e334a0 = clip_size;
            
            if ( var_b17bebce90c0d005 )
            {
                self cancelreload();
            }
        }
        
        self setweaponammoclip( current_weapon, var_2ebdeecc1e334a0, hand );
    }
}

// Namespace weapon
// Params 0
// Checksum 0x2e4e9760, Offset: 0x3f73
// Size: 0xe
function stopinfiniteammothread()
{
    self notify( #"hash_ffdf18a9572c8f52" );
}

// Namespace weapon
// Params 1
// Checksum 0xd72e0c08, Offset: 0x3f89
// Size: 0x98, Type: bool
function function_6b74ecd475e99b4( weapon )
{
    if ( utility::callsharedfunc( #"weapon", #"is_tertiary_weapon_override", weapon ) )
    {
        return true;
    }
    
    ismelee = weapon.ismelee || weapon.var_dc2f7d3f31dae9a4 == 3;
    return level.tertiaryweaponslotenabled && ismelee && !isfistweaponobject( weapon ) && !isclimbweaponobject( weapon ) && !isunderwaterweaponobject( weapon ) && !weapon_utility::isriotshieldobject( weapon );
}

// Namespace weapon
// Params 0
// Checksum 0x258e5404, Offset: 0x402a
// Size: 0x15
function function_dce93539f9791cd0()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    return self.primaryweaponobj;
}

// Namespace weapon
// Params 0
// Checksum 0x85980f0f, Offset: 0x4048
// Size: 0x15
function function_4816b0b66e714dd8()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    return self.secondaryweaponobj;
}

// Namespace weapon
// Params 2
// Checksum 0x9c04b949, Offset: 0x4066
// Size: 0x23, Type: bool
function iscurrenttertiaryweapon( player, weapon )
{
    return weapon == player.var_cc1262e66dbb1c79;
}

// Namespace weapon
// Params 1
// Checksum 0xe4189880, Offset: 0x4092
// Size: 0xc8
function function_b4c9549dee5d0fc5( weapon )
{
    var_1d1f0731baae74f4 = isundefinedweapon( weapon ) ? "none" : getweaponfullname( weapon );
    self.tertiaryWeapon = var_1d1f0731baae74f4;
    self.pers[ "tertiaryWeapon" ] = var_1d1f0731baae74f4;
    self.var_cc1262e66dbb1c79 = weapon;
    self notify( #"hash_418b511a577dd571" );
    var_807172a2f7700382 = !getdvarint( @"hash_9807be8848b25821", 1 );
    var_2792dece9bf7d433 = self function_2792dece9bf7d433();
    
    if ( !isundefinedweapon( weapon ) && ( !var_2792dece9bf7d433 || !var_807172a2f7700382 ) && self hasweapon( weapon ) )
    {
        self assignweaponmeleeslot( weapon );
    }
    
    if ( var_807172a2f7700382 )
    {
        thread class::function_c75ae4ad670c642c( weapon, var_2792dece9bf7d433 );
    }
}

