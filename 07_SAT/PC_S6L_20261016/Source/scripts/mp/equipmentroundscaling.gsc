// scripts\mp\equipmentroundscaling.gsc  (hash_5a3ddb5a243b5221.gscc) (size: 6037 Bytes / 0x1795 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbeceab80 (3201215360)
// size ...... 6037 (0x1795)
// includes .. 3   (offset: 0x171d)
// strings ... 5   (offset: 0x1735)
// dev strs .. 2   (offset: 0x177d)
// exports ... 13  (offset: 0x1199)
// cseg ...... 0xc9 + 0x10d0 (0x1199)
// imports ... 29  (offset: 0x13a1)
// animtree1 . 0   (offset: 0x1795)
// animtree2 . 0   (offset: 0x1795)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace equipmentroundscaling;

// Namespace equipmentroundscaling
// Params 0
// Checksum 0x8976fe78, Offset: 0xe7
// Size: 0x14
function function_40d09bcb6ac535a()
{
    level.var_520a8b0a385e7a08 = [];
    level thread function_45b4e38fe2e8e723();
}

// Namespace equipmentroundscaling
// Params 0
// Checksum 0x4983206a, Offset: 0x103
// Size: 0x105
function function_45b4e38fe2e8e723()
{
    waitframe();
    str_equipment_list = level.gametypebundle.equipmentscaling ?? level.gamemodebundle.equipmentscaling;
    
    if ( !isdefined( str_equipment_list ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_7c3173b6ca783ff3 = getscriptbundle( "equipmentroundscaling:" + str_equipment_list );
    assert( isdefined( var_7c3173b6ca783ff3 ), "<dev string:x4b>" );
    function_cab16d427f8717a4( var_7c3173b6ca783ff3 );
    
    if ( var_7c3173b6ca783ff3.var_e587465ae6524cb0 )
    {
        utility::registersharedfunc( #"zombie", #"hash_8a860cb98efd603a", &function_b6b2ed27962a4762 );
    }
    else
    {
        utility::registersharedfunc( #"zombie", #"hash_8a860cb98efd603a", &function_622b283ee01f3de6 );
    }
    
    utility::registersharedfunc( #"zombie", #"scaleUnderbarrelDamageByRound", &function_1d2434e57ba055f2 );
    utility::registersharedfunc( #"game", #"hash_1e485ee80b4faab7", &function_4a6cf9bafc91e53 );
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0xf960cc00, Offset: 0x210
// Size: 0x3c2
function function_cab16d427f8717a4( var_7c3173b6ca783ff3 )
{
    foreach ( var_de31337da07f5b8c in var_7c3173b6ca783ff3.var_6cd3e7928549cf2b )
    {
        var_a53da7e49ccb1a50 = spawnstruct();
        var_a53da7e49ccb1a50.shouldscale = var_de31337da07f5b8c.shouldscale ?? 0;
        var_a53da7e49ccb1a50.var_a6a3e63068e01450 = var_de31337da07f5b8c.var_a6a3e63068e01450 ?? 0;
        var_a53da7e49ccb1a50.var_5274ef263c00a856 = var_de31337da07f5b8c.var_5274ef263c00a856 ?? 0;
        var_a53da7e49ccb1a50.var_7fdd7777657d5f9a = var_de31337da07f5b8c.var_7fdd7777657d5f9a ?? 0;
        var_a53da7e49ccb1a50.var_95be293581d948c0 = var_de31337da07f5b8c.var_95be293581d948c0 ?? 0;
        var_a53da7e49ccb1a50.basedamage = var_de31337da07f5b8c.basedamage ?? 0;
        var_a53da7e49ccb1a50.var_898e8386beadf818 = var_de31337da07f5b8c.var_898e8386beadf818 ?? 1;
        var_a53da7e49ccb1a50.var_ff210affa2793d35 = [];
        var_f7950ba72dbf2c53 = 0;
        var_1a00694869dac0a8 = var_de31337da07f5b8c.var_1a00694869dac0a8 ?? 0;
        var_68efb56350f30be1 = var_de31337da07f5b8c.var_68efb56350f30be1 ?? 0;
        var_3c30b393554f6cb9 = var_de31337da07f5b8c.var_3c30b393554f6cb9 ?? 0;
        var_c5f39ecc03055490 = var_de31337da07f5b8c.var_c5f39ecc03055490 ?? 0;
        var_d04c6c32e095a51f = var_de31337da07f5b8c.var_d04c6c32e095a51f ?? 0;
        var_5d868eb78a280f8c = var_de31337da07f5b8c.var_5d868eb78a280f8c ?? 0;
        var_fb2e4509d297aecf = var_de31337da07f5b8c.var_fb2e4509d297aecf ?? 0;
        var_fb521b816e17d61b = var_de31337da07f5b8c.var_fb521b816e17d61b ?? 0;
        
        for ( i = 1; i <= 55 ; i++ )
        {
            if ( i > 1 && i <= 10 )
            {
                var_f7950ba72dbf2c53 += var_1a00694869dac0a8;
            }
            else if ( i >= 11 && i <= 16 )
            {
                var_f7950ba72dbf2c53 += var_68efb56350f30be1;
            }
            else if ( i >= 17 && i <= 21 )
            {
                var_f7950ba72dbf2c53 += var_3c30b393554f6cb9;
            }
            else if ( i >= 22 && i <= 26 )
            {
                var_f7950ba72dbf2c53 += var_c5f39ecc03055490;
            }
            else if ( i >= 27 && i <= 31 )
            {
                var_f7950ba72dbf2c53 += var_d04c6c32e095a51f;
            }
            else if ( i >= 32 && i <= 36 )
            {
                var_f7950ba72dbf2c53 += var_5d868eb78a280f8c;
            }
            else if ( i >= 37 && i <= 54 )
            {
                var_f7950ba72dbf2c53 += var_fb2e4509d297aecf;
            }
            else if ( i == 55 )
            {
                var_f7950ba72dbf2c53 += var_fb521b816e17d61b;
            }
            
            var_a53da7e49ccb1a50.var_ff210affa2793d35[ i ] = var_f7950ba72dbf2c53;
        }
        
        var_a53da7e49ccb1a50.var_5aed70bc51b0a3cc = var_de31337da07f5b8c.var_5aed70bc51b0a3cc ?? 0;
        var_a53da7e49ccb1a50.var_6247f5684007eee0 = var_de31337da07f5b8c.var_6247f5684007eee0 ?? 0;
        var_a53da7e49ccb1a50.var_819c16b9698e5f44 = var_de31337da07f5b8c.var_819c16b9698e5f44 ?? 0;
        var_a53da7e49ccb1a50.var_9ce728dbf45c3fc3 = var_de31337da07f5b8c.var_9ce728dbf45c3fc3 ?? 0;
        var_a53da7e49ccb1a50.var_a23377788cf589ea = var_de31337da07f5b8c.var_a23377788cf589ea ?? 0;
        weaponrootname = var_de31337da07f5b8c.weaponrootname;
        level.var_520a8b0a385e7a08[ weaponrootname ] = var_a53da7e49ccb1a50;
    }
}

// Namespace equipmentroundscaling
// Params 0
// Checksum 0xa3437f53, Offset: 0x5da
// Size: 0x1f
function function_b5ae330285df840()
{
    var_c34f5bcaf57ca322 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    return var_c34f5bcaf57ca322;
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0xd4c6fc57, Offset: 0x602
// Size: 0x82
function function_14e55206505a342( weaponobject )
{
    if ( weaponobject.isalternate && isdefined( weaponobject.underbarrel ) )
    {
        var_6d03eea324f864e4 = getattachmentbasetype( weaponobject, weaponobject.underbarrel );
        
        if ( isdefined( level.var_520a8b0a385e7a08[ weaponobject.underbarrel ] ) )
        {
            return weaponobject.underbarrel;
        }
        
        if ( isdefined( level.var_520a8b0a385e7a08[ var_6d03eea324f864e4 ] ) )
        {
            return var_6d03eea324f864e4;
        }
    }
}

// Namespace equipmentroundscaling
// Params 2
// Checksum 0x7df07ab9, Offset: 0x68d
// Size: 0x38, Type: bool
function function_353043e671b15763( weaponobject, player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    var_8eba895acaf50a0c = function_14e55206505a342( weaponobject );
    return isdefined( var_8eba895acaf50a0c );
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0xfa657b7, Offset: 0x6ce
// Size: 0x145, Type: bool
function function_8ff546819f55c5b4( params )
{
    if ( !isdefined( params ) )
    {
        return false;
    }
    
    weaponobject = params.sweapon;
    
    if ( params.sweapon == level.weaponnone && isdefined( params.objweapon ) )
    {
        weaponobject = params.objweapon;
    }
    
    if ( !isdefined( weaponobject ) )
    {
        return false;
    }
    
    if ( isdefined( params.eattacker ) && isdefined( params.einflictor ) && isdefined( params.idamage ) && !params.eattacker.isequipment && !weapon::iskillstreakweapon( weaponobject ) && !weapon::isweaponequipment( weaponobject ) && ( isdefined( params.eattacker.vehicletype ) || isdefined( params.einflictor.vehicletype ) ) )
    {
        return false;
    }
    
    if ( !weapon::isweaponequipment( weaponobject ) && !weapon::iskillstreakweapon( weaponobject ) && !function_f18c9c85e5aae76d( weaponobject ) && !params.eattacker.isequipment )
    {
        return false;
    }
    
    return true;
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0xe9179635, Offset: 0x81c
// Size: 0x1bd
function function_b6b2ed27962a4762( params )
{
    var_f766beb090ba2cab = function_8ff546819f55c5b4( params );
    
    if ( !var_f766beb090ba2cab )
    {
        return params.idamage;
    }
    
    scaleddamage = params.idamage;
    weaponobject = params.sweapon;
    weaponrootname = getweaponrootstring( weaponobject );
    
    if ( isdefined( weaponrootname ) )
    {
        weaponrootname = getxhash( weaponrootname );
    }
    
    roundnumber = function_b5ae330285df840();
    
    if ( isdefined( level.var_520a8b0a385e7a08[ weaponrootname ] ) )
    {
        var_7347a9b041d183fd = level.var_520a8b0a385e7a08[ weaponrootname ];
    }
    else
    {
        var_7347a9b041d183fd = level.var_520a8b0a385e7a08[ #"default" ];
        weaponrootname = #"default";
    }
    
    if ( !isdefined( var_7347a9b041d183fd ) )
    {
        return params.idamage;
    }
    
    if ( params.smeansofdeath == "MOD_IMPACT" && !var_7347a9b041d183fd.var_5274ef263c00a856 )
    {
        return params.idamage;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" && !var_7347a9b041d183fd.var_7fdd7777657d5f9a )
    {
        return params.idamage;
    }
    
    if ( level.var_520a8b0a385e7a08[ weaponrootname ].basedamage >= 0 )
    {
        scaleddamage = level.var_520a8b0a385e7a08[ weaponrootname ].basedamage;
    }
    
    if ( level.var_520a8b0a385e7a08[ weaponrootname ].shouldscale )
    {
        scaleddamage = function_4a6cf9bafc91e53( scaleddamage, roundnumber, weaponrootname, self.aicategory, self.maxhealth, self.var_a03f571fe06a52b8, params );
    }
    
    return scaleddamage;
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0x222f57e7, Offset: 0x9e2
// Size: 0x272
function function_622b283ee01f3de6( params )
{
    if ( ( isdefined( params.eattacker ) && isdefined( params.eattacker.vehicletype ) || isdefined( params.einflictor ) && isdefined( params.einflictor.vehicletype ) ) && isdefined( params.idamage ) && isdefined( params.sweapon ) && !weapon::iskillstreakweapon( params.sweapon ) && !params.eattacker.isequipment )
    {
        return params.idamage;
    }
    
    var_f766beb090ba2cab = function_8ff546819f55c5b4( params );
    
    if ( !var_f766beb090ba2cab )
    {
        return params.idamage;
    }
    
    scaleddamage = params.idamage;
    weaponrootname = getweaponrootstring( params.sweapon );
    
    if ( isdefined( weaponrootname ) )
    {
        weaponrootname = getxhash( weaponrootname );
    }
    
    roundnumber = self.var_13518fb33ec73cc ?? level.round_number ?? 1;
    
    if ( isdefined( level.var_520a8b0a385e7a08[ weaponrootname ] ) )
    {
        var_7347a9b041d183fd = level.var_520a8b0a385e7a08[ weaponrootname ];
    }
    else
    {
        var_7347a9b041d183fd = level.var_520a8b0a385e7a08[ #"default" ];
        weaponrootname = #"default";
    }
    
    if ( !isdefined( var_7347a9b041d183fd ) )
    {
        return params.idamage;
    }
    
    if ( params.smeansofdeath == "MOD_IMPACT" && !var_7347a9b041d183fd.var_5274ef263c00a856 )
    {
        return params.idamage;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" && !var_7347a9b041d183fd.var_7fdd7777657d5f9a )
    {
        return params.idamage;
    }
    
    if ( level.var_520a8b0a385e7a08[ weaponrootname ].basedamage >= 0 )
    {
        scaleddamage = level.var_520a8b0a385e7a08[ weaponrootname ].basedamage;
    }
    
    if ( level.var_520a8b0a385e7a08[ weaponrootname ].shouldscale )
    {
        scaleddamage = function_4a6cf9bafc91e53( scaleddamage, roundnumber, weaponrootname, self.aicategory, self.maxhealth, self.var_a03f571fe06a52b8, params );
    }
    
    return scaleddamage;
}

// Namespace equipmentroundscaling
// Params 7
// Checksum 0x45b27d6b, Offset: 0xc5d
// Size: 0x3e0
function function_4a6cf9bafc91e53( var_509ff0895dc8ca44 = 0, roundnumber, weaponrootname, aicategory, maxhealth, var_1a849609f13352f4, dmg_struct )
{
    var_38ef4250e4e2c082 = roundnumber ?? 1;
    n_scaled_damage = var_509ff0895dc8ca44;
    
    if ( isstring( weaponrootname ) )
    {
        weaponrootname = getxhash( weaponrootname );
    }
    
    damagestruct = undefined;
    
    if ( isdefined( level.var_520a8b0a385e7a08[ weaponrootname ] ) )
    {
        damagestruct = level.var_520a8b0a385e7a08[ weaponrootname ];
    }
    else if ( isdefined( level.var_520a8b0a385e7a08[ #"default" ] ) )
    {
        damagestruct = level.var_520a8b0a385e7a08[ #"default" ];
    }
    
    if ( damagestruct.shouldscale )
    {
        if ( damagestruct.var_a6a3e63068e01450 )
        {
            round_difficulty = roundnumber ?? namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            attacker = dmg_struct.eattacker;
            
            if ( !isplayer( attacker ) )
            {
                attacker = attacker.owner;
            }
            
            if ( level.var_37f0dad872bed468 )
            {
                if ( getdvarint( @"hash_1f51ec8a4ab4540d", 0 ) )
                {
                    round_difficulty += attacker.var_4e1122995a3e50c8 ?? 0;
                }
                else
                {
                    round_difficulty = attacker.var_4e1122995a3e50c8 ?? 1;
                }
            }
            
            base_damage_percent = damagestruct.var_95be293581d948c0;
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            
            if ( !isdefined( zombie_base_health ) )
            {
                zombie_base_health = 125;
            }
            
            n_scaled_damage = zombie_base_health * base_damage_percent;
            zombie_start_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", 1 );
            
            if ( base_damage_percent == 0 )
            {
                base_damage_percent = 1;
            }
            
            var_c317aeaa4c9ad4e2 = zombie_start_health * base_damage_percent;
            damage_ratio = ( dmg_struct.idamage ?? var_c317aeaa4c9ad4e2 ) / var_c317aeaa4c9ad4e2;
            n_scaled_damage *= damage_ratio;
            
            if ( damagestruct.basedamage > n_scaled_damage )
            {
                n_scaled_damage = damagestruct.basedamage;
            }
        }
        else if ( var_38ef4250e4e2c082 > 1 )
        {
            if ( level.var_37f0dad872bed468 )
            {
                if ( getdvarint( @"hash_1f51ec8a4ab4540d", 0 ) )
                {
                    var_38ef4250e4e2c082 += dmg_struct.eattacker.var_4e1122995a3e50c8 ?? 0;
                }
                else
                {
                    var_38ef4250e4e2c082 = dmg_struct.eattacker.var_4e1122995a3e50c8 ?? 1;
                }
            }
            
            if ( var_38ef4250e4e2c082 > 55 )
            {
                var_38ef4250e4e2c082 = 55;
            }
            
            var_f7950ba72dbf2c53 = damagestruct.var_ff210affa2793d35[ var_38ef4250e4e2c082 ];
            var_f7950ba72dbf2c53 *= self.var_14a0f17932743155 ?? 1;
            n_scaled_damage += var_f7950ba72dbf2c53;
        }
        
        if ( !isdefined( aicategory ) )
        {
            aicategory = "normal";
        }
        
        var_848f75c0df76bd = 100;
        
        switch ( aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                var_848f75c0df76bd = damagestruct.var_5aed70bc51b0a3cc;
                break;
            case #"hash_8c089e813083e510":
                var_848f75c0df76bd = damagestruct.var_6247f5684007eee0;
                break;
            case #"hash_7b0e2f2ed84f34":
                var_848f75c0df76bd = damagestruct.var_819c16b9698e5f44;
                break;
            case #"hash_4e47eb6c32f5b165":
                var_848f75c0df76bd = damagestruct.var_9ce728dbf45c3fc3;
                break;
            case #"hash_7e8a002ed096276c":
                var_848f75c0df76bd = damagestruct.var_a23377788cf589ea;
                break;
        }
        
        if ( var_1a849609f13352f4 )
        {
            var_848f75c0df76bd *= var_1a849609f13352f4;
        }
        
        if ( dmg_struct )
        {
            if ( dmg_struct.var_ff33243f5be1fe3b && !self.var_479276b69a1296ee )
            {
                dmg_struct.var_ff33243f5be1fe3b = min( var_848f75c0df76bd / 100, dmg_struct.var_ff33243f5be1fe3b );
            }
        }
        else if ( maxhealth )
        {
            n_scaled_damage = min( n_scaled_damage, maxhealth * var_848f75c0df76bd );
        }
    }
    
    return int( n_scaled_damage );
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0x8ae53033, Offset: 0x1046
// Size: 0x28
function function_f18c9c85e5aae76d( sweapon )
{
    if ( isdefined( level.var_aa144e985816508e ) )
    {
        return [[ level.var_aa144e985816508e ]]( sweapon );
    }
    
    return 0;
}

// Namespace equipmentroundscaling
// Params 1
// Checksum 0xbeb4cb0f, Offset: 0x1077
// Size: 0x121
function function_1d2434e57ba055f2( dmg_struct )
{
    if ( !isdefined( dmg_struct ) )
    {
        return;
    }
    
    if ( !isplayer( dmg_struct.eattacker ) )
    {
        return dmg_struct.idamage;
    }
    
    weaponobject = dmg_struct.objweapon;
    var_fd599a9d46a2db31 = function_14e55206505a342( weaponobject );
    
    if ( !isdefined( var_fd599a9d46a2db31 ) )
    {
        return dmg_struct.idamage;
    }
    
    scaleddamage = dmg_struct.idamage;
    roundnumber = function_b5ae330285df840();
    var_7347a9b041d183fd = level.var_520a8b0a385e7a08[ var_fd599a9d46a2db31 ];
    
    if ( level.var_520a8b0a385e7a08[ var_fd599a9d46a2db31 ].basedamage >= 0 )
    {
        scaleddamage = level.var_520a8b0a385e7a08[ var_fd599a9d46a2db31 ].basedamage;
    }
    
    if ( level.var_520a8b0a385e7a08[ var_fd599a9d46a2db31 ].shouldscale )
    {
        scaleddamage = function_4a6cf9bafc91e53( scaleddamage, roundnumber, var_fd599a9d46a2db31, self.aicategory, self.maxhealth, self.var_a03f571fe06a52b8, dmg_struct );
    }
    
    return scaleddamage;
}

