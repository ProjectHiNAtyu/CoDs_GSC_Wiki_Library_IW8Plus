// scripts\mp\common\equipment\scripted_trophy.gsc  (hash_65b9a5fd75fb1b9a.gscc) (size: 12963 Bytes / 0x32a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd50bbe0a (3574316554)
// size ...... 12963 (0x32a3)
// includes .. 9   (offset: 0x3053)
// strings ... 38  (offset: 0x309b)
// dev strs .. 0   (offset: 0x3293)
// exports ... 45  (offset: 0x1ec7)
// cseg ...... 0x54a + 0x197d (0x1ec7)
// imports ... 90  (offset: 0x25cf)
// animtree1 . 0   (offset: 0x3293)
// animtree2 . 1   (offset: 0x3293)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;

#namespace scripted_trophy;

// Namespace scripted_trophy
// Params 0
// Checksum 0xc8d07d5d, Offset: 0x568
// Size: 0x65
function trophy_init()
{
    levelstruct = spawnstruct();
    levelstruct.tags = [];
    levelstruct.tags[ 0 ] = "tag_barrel_1";
    levelstruct.tags[ 1 ] = "tag_barrel_2";
    levelstruct.tags[ 3 ] = "tag_barrel_3";
    level.trophy = levelstruct;
}

// Namespace scripted_trophy
// Params 5
// Checksum 0x9762d7f8, Offset: 0x5d5
// Size: 0x21a
function trophy_create( loc, candamage, ammocount, maxhealthoverride, teamoverride )
{
    trophy = magicgrenademanual( "trophy_mp", loc.origin, ( 0, 0, 0 ) );
    trophy.var_ba2e8824e2e859e7 = 1;
    trophy.team = "axis";
    
    if ( isdefined( teamoverride ) )
    {
        trophy.team = teamoverride;
    }
    
    trophy.owner = trophy;
    loc.trophy = trophy;
    trophy setscriptablepartstate( "effects", "activeDeployStart" );
    wait 1.25;
    trophy setscriptablepartstate( "effects", "activeDeployEnd" );
    
    if ( candamage )
    {
        maxhealth = 100;
        
        if ( isdefined( maxhealthoverride ) )
        {
            maxhealth = maxhealthoverride;
        }
        
        damagefeedback = "hitequip";
        
        if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
        {
            trophy thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( maxhealth, damagefeedback, &trophy_handlefataldamage, &trophy_handledamage, 0 );
        }
        
        trophy thread trophy_destroyonemp();
    }
    
    if ( isdefined( ammocount ) )
    {
        trophy.max_ammo = ammocount;
    }
    
    trophy.ammo = trophy.max_ammo;
    trophy.usedcount = 0;
    trophy thread trophy_destroyongameend();
    trophy.explosion = trophy_createexplosion( trophy );
    
    if ( getdvarint( @"scr_trophy_use_entity_grid", 0 ) != 0 )
    {
        /#
            if ( getdvarint( @"hash_2fb6b2a16c2792d0", 0 ) != 0 )
            {
                trophy thread trophy_system::function_97100188ddfca70a( 45, 325, &function_77f58809e548a0be, &trophy_system::trophy_passthrough, 1 );
            }
        #/
        
        trophy thread trophy_system::function_97100188ddfca70a( 45, 325, &function_77f58809e548a0be, &function_3db5573072e32ef6, 0 );
        return;
    }
    
    trophy thread trophy_watchprotection( 45, 105625, &function_77f58809e548a0be, &function_3db5573072e32ef6 );
}

// Namespace scripted_trophy
// Params 0
// Checksum 0x88bcb404, Offset: 0x7f7
// Size: 0x3b
function trophy_destroyongameend()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread trophy_destroy();
}

// Namespace scripted_trophy
// Params 0
// Checksum 0xe804c175, Offset: 0x83a
// Size: 0x44
function trophy_destroyonemp()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self waittill( #"emp_applied", data );
    thread trophy_destroy( 1 );
}

// Namespace scripted_trophy
// Params 0
// Checksum 0xb2d9bfc9, Offset: 0x886
// Size: 0xe
function trophy_deployanimation()
{
    self endon( #"death" );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x5c3fe914, Offset: 0x89c
// Size: 0x15
function trophy_remote_destroy( player )
{
    trophy_destroy( 1 );
}

// Namespace scripted_trophy
// Params 0
// Checksum 0xdb96ebae, Offset: 0x8b9
// Size: 0x1b
function sweeptrophy()
{
    thread trophy_delete( 0 );
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x947f7c17, Offset: 0x8dc
// Size: 0x2b
function trophy_destroy( wasdestroyed )
{
    thread trophy_delete( 0.1, wasdestroyed );
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x43aecccc, Offset: 0x90f
// Size: 0x42
function trophy_shutdownanddestroy( wasdestroyed )
{
    thread trophy_delete( 2.6, wasdestroyed );
    self setscriptablepartstate( "effects", "activeDestroyStart", 0 );
    wait 2.5;
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
}

// Namespace scripted_trophy
// Params 2
// Checksum 0xfb124db1, Offset: 0x959
// Size: 0x7a
function trophy_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "hack_usable", "off" );
    self setcandamage( 0 );
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace scripted_trophy
// Params 4
// Checksum 0x82726010, Offset: 0x9db
// Size: 0x284
function trophy_watchprotection( protectionoffset, protectiondistsqr, var_2049c089ca33e54c, var_b464e409f2bae785 )
{
    self endon( #"death" );
    trophy_castcontents = trophy_castcontents();
    
    while ( [[ var_2049c089ca33e54c ]]() )
    {
        if ( self.isdisabled )
        {
            waitframe();
            continue;
        }
        
        castorigin = trophy_castorigin( protectionoffset );
        arr2d = [];
        arr2d[ 0 ] = level.grenades;
        arr2d[ 1 ] = level.missiles;
        arr2d[ 2 ] = weapon::function_3aafcaf7ff6dea9e();
        arr2d[ 3 ] = level.mortars;
        trophytargets = utility::array_combine_multiple( arr2d );
        
        foreach ( trophytarget in trophytargets )
        {
            if ( !isdefined( trophytarget ) )
            {
                continue;
            }
            
            if ( trophytarget.exploding )
            {
                continue;
            }
            
            if ( trophytarget == self )
            {
                continue;
            }
            
            if ( trophy_checkignorelist( trophytarget ) )
            {
                continue;
            }
            
            trophytargetowner = trophytarget.owner;
            
            if ( !isdefined( trophytargetowner ) && isdefined( trophytarget.vehicle ) )
            {
                trophytargetowner = trophytarget.vehicle.owner;
            }
            
            if ( !isdefined( trophytargetowner ) && isdefined( trophytarget.weapon_name ) && weaponclass( trophytarget.weapon_name ) == "grenade" )
            {
                trophytargetowner = getmissileowner( trophytarget );
            }
            
            var_7abb8ea921e296dc = 1;
            
            /#
                if ( getdvarint( @"hash_3c6c485214ca7673", 0 ) == 1 )
                {
                    var_7abb8ea921e296dc = 0;
                }
            #/
            
            if ( var_7abb8ea921e296dc )
            {
                if ( isdefined( trophytargetowner ) && !player_utility::playersareenemies( self, trophytargetowner ) )
                {
                    continue;
                }
            }
            
            if ( distancesquared( trophytarget.origin, self.origin ) > trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr ) )
            {
                continue;
            }
            
            castresults = physics_raycast( castorigin, trophytarget.origin, trophy_castcontents, [ self, trophytarget ], 0, "physicsquery_closest" );
            
            if ( castresults.size > 0 )
            {
                continue;
            }
            
            self [[ var_b464e409f2bae785 ]]( trophytarget );
        }
        
        waitframe();
    }
}

// Namespace scripted_trophy
// Params 0
// Checksum 0x6cf8bd6a, Offset: 0xc67
// Size: 0xc, Type: bool
function function_77f58809e548a0be()
{
    return isdefined( self.owner );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0xcf1d1bd1, Offset: 0xc7c
// Size: 0x15
function function_3db5573072e32ef6( trophytarget )
{
    thread trophy_fireontarget( trophytarget );
}

// Namespace scripted_trophy
// Params 1, eflags: 0x4
// Checksum 0xd5967b6, Offset: 0xc99
// Size: 0x6a
function private function_2307e0849e493c48( trophytarget )
{
    outnum = 1;
    
    if ( isdefined( trophytarget ) && isdefined( trophytarget.weapon_name ) )
    {
        switch ( trophytarget.weapon_name )
        {
            case #"hash_85ea99fcbe4116a4":
                outnum = 3;
                break;
            case #"hash_5c272c0617caebf0":
                outnum = 3;
                break;
        }
    }
    
    return outnum;
}

// Namespace scripted_trophy
// Params 1, eflags: 0x4
// Checksum 0xf69324b2, Offset: 0xd0c
// Size: 0xc1
function private trophy_fireontarget( trophytarget )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_end" );
    
    if ( !isdefined( self.usedcount ) )
    {
        self.usedcount = 0;
    }
    
    self.usedcount++;
    var_db7c1d0a31bd8f51 = trophytarget.origin;
    numshots = function_2307e0849e493c48( trophytarget );
    
    if ( self.ammo >= numshots )
    {
        function_3ef7d9b33d884442( trophytarget );
    }
    
    for ( i = 0; i < numshots ; i++ )
    {
        childthread function_1b1128fd01282c79( var_db7c1d0a31bd8f51, i );
        wait 0.2;
    }
}

// Namespace scripted_trophy
// Params 2, eflags: 0x4
// Checksum 0xfea55f1, Offset: 0xdd5
// Size: 0x109
function private function_1b1128fd01282c79( trophytarget, shotnum )
{
    if ( self.ammo <= 0 )
    {
        thread trophy_shutdownanddestroy( 0 );
        return 0;
    }
    
    explorigin = trophytarget;
    
    if ( shotnum > 1 )
    {
        explorigin = function_bb1db0d2858dce73( explorigin );
    }
    
    tag = trophy_getbesttag( explorigin );
    part = trophy_getpartbytag( tag );
    self setscriptablepartstate( part, "active", 0 );
    dirangles = vectortoangles( self gettagorigin( tag ) - explorigin );
    explangles = combineangles( dirangles, ( -90, 0, 0 ) );
    self.explosion thread trophy_explode( explorigin, explangles );
    self.ammo--;
    
    /#
        if ( getdvarint( @"hash_20d714b15057681f", 0 ) == 1 )
        {
            self.ammo = 10;
        }
    #/
    
    if ( self.ammo <= 0 )
    {
        thread trophy_shutdownanddestroy( 0 );
    }
}

// Namespace scripted_trophy
// Params 1, eflags: 0x4
// Checksum 0xf7e53cb2, Offset: 0xee6
// Size: 0x105
function private function_bb1db0d2858dce73( var_dfe0e3d330e71d26 )
{
    var_bf8625ead07389c4 = 0.05;
    x_scatter = randomfloatrange( 0.9, 1.1 );
    y_scatter = randomfloatrange( 0.9, 1.1 );
    z_scatter = randomfloatrange( 0.8, 1.2 );
    x = var_dfe0e3d330e71d26[ 0 ];
    y = var_dfe0e3d330e71d26[ 1 ];
    z = var_dfe0e3d330e71d26[ 2 ];
    x_delta = x * x_scatter;
    y_delta = y * y_scatter;
    z_delta = z * z_scatter;
    
    if ( abs( x - x_delta ) < x * var_bf8625ead07389c4 )
    {
        x_delta += x_delta * var_bf8625ead07389c4;
    }
    
    if ( abs( y - y_delta ) < y * var_bf8625ead07389c4 )
    {
        y_delta += y_delta * var_bf8625ead07389c4;
    }
    
    if ( abs( z - z_delta ) < z * var_bf8625ead07389c4 )
    {
        z_delta += z_delta * var_bf8625ead07389c4;
    }
    
    return ( x_delta, y_delta, z_delta );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x7407092f, Offset: 0xff4
// Size: 0x157
function function_3ef7d9b33d884442( trophytarget )
{
    trophytarget setcandamage( 0 );
    trophytarget.exploding = 1;
    trophytarget stopsounds();
    attacker = undefined;
    
    if ( isdefined( trophytarget.owner ) )
    {
        attacker = trophytarget.owner;
    }
    
    explorigin = trophytarget.origin;
    explangles = trophytarget.angles;
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_d1613d1359f2871d" ) )
    {
        if ( [[ utility::getsharedfunc( #"equipment", #"hash_d1613d1359f2871d" ) ]]( trophytarget ) )
        {
            if ( utility::issharedfuncdefined( #"equipment", #"hash_a3b7ff10e1ed3f9" ) )
            {
                trophytarget [[ utility::getsharedfunc( #"equipment", #"hash_a3b7ff10e1ed3f9" ) ]]();
            }
        }
        else
        {
            trophytarget delete();
        }
    }
    else
    {
        trophytarget delete();
    }
    
    self.explosion thread trophy_explode( explorigin, explangles );
    
    if ( !isdefined( self.trophy_usedcount ) )
    {
        self.trophy_usedcount = 0;
    }
    
    self.trophy_usedcount++;
    
    if ( isdefined( attacker ) )
    {
        level notify( #"trophyused", attacker );
        attacker thread damagefeedback::updatedamagefeedback( "hittrophysystem" );
    }
}

// Namespace scripted_trophy
// Params 0
// Checksum 0x6d8dc1bf, Offset: 0x1153
// Size: 0x1d
function trophy_watchgameended()
{
    self endon( #"death" );
    trophy_watchgameendedinternal();
    thread trophy_shutdownanddestroy( 0 );
}

// Namespace scripted_trophy
// Params 0
// Checksum 0x5600d395, Offset: 0x1178
// Size: 0xe
function trophy_watchgameendedinternal()
{
    level endon( #"game_ended" );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0xaa1d05ea, Offset: 0x118e
// Size: 0x31
function trophy_handledamage( data )
{
    damage = data.damage;
    modifieddamage = damage;
    return modifieddamage;
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x626b8295, Offset: 0x11c8
// Size: 0x39
function trophy_handlefataldamage( data )
{
    if ( isplayer( data.attacker ) )
    {
        trophy_givepointsfordeath( data.attacker );
    }
    
    thread trophy_destroy( 1 );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x6bb1afdb, Offset: 0x1209
// Size: 0x1e
function trophy_givepointsfordeath( attacker )
{
    attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"destroyed_equipment" );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0xe73c20ca, Offset: 0x122f
// Size: 0x20
function trophy_applyempcallback( data )
{
    data.victim thread trophy_disable( data );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x1ab17eea, Offset: 0x1257
// Size: 0x3d
function function_96c5799246de8829( data )
{
    data.victim trophy_givepointsfordeath( data.attacker );
    data.victim thread trophy_destroy( 1 );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x1068788b, Offset: 0x129c
// Size: 0x55
function trophy_disable( data )
{
    self endon( #"death" );
    self.isdisabled = 1;
    self setscriptablepartstate( "empd", "active", 0 );
    wait 6;
    self.isdisabled = 0;
    self setscriptablepartstate( "empd", "neutral", 0 );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x98480733, Offset: 0x12f9
// Size: 0xe5
function trophy_createexplosion( trophy )
{
    explosion = spawn( "script_model", trophy.origin );
    explosion.killcament = trophy;
    explosion.owner = trophy.owner;
    explosion.team = trophy.team;
    explosion.equipmentref = trophy.equipmentref;
    explosion.weapon_name = trophy.weapon_name;
    explosion setotherent( explosion.owner );
    explosion setentityowner( explosion.owner );
    explosion setmodel( "trophy_system_mp_explode" );
    explosion.explode1available = 1;
    explosion thread trophy_cleanuponparentdeath( trophy, 0.1 );
    return explosion;
}

// Namespace scripted_trophy
// Params 2
// Checksum 0xb51cad8a, Offset: 0x13e7
// Size: 0x77
function trophy_explode( position, angles )
{
    self dontinterpolate();
    self.origin = position;
    self.angles = angles;
    
    if ( self.explode1available )
    {
        self setscriptablepartstate( "explode1", "activeDirectional", 0 );
        self.explode1available = 0;
        return;
    }
    
    self setscriptablepartstate( "explode2", "activeDirectional", 0 );
    self.explode1available = 1;
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x2fb55880, Offset: 0x1466
// Size: 0x26
function trophy_castorigin( protectionoffset )
{
    return self.origin + anglestoup( self.angles ) * protectionoffset;
}

// Namespace scripted_trophy
// Params 0
// Checksum 0x11a06463, Offset: 0x1495
// Size: 0x34
function trophy_castcontents()
{
    return physics_createcontents( [ "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item" ] );
}

// Namespace scripted_trophy
// Params 2
// Checksum 0x6a19c13b, Offset: 0x14d2
// Size: 0xbe
function trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr )
{
    if ( isdefined( trophytarget.weapon_name ) && isdefined( trophytarget.owner ) )
    {
        switch ( trophytarget.classname )
        {
            case #"hash_4af55147c6098215":
                if ( 211250 > protectiondistsqr )
                {
                    protectiondistsqr = 211250;
                }
                
                break;
            case #"hash_8b48887639da2db5":
                if ( 126750 > protectiondistsqr )
                {
                    protectiondistsqr = 126750;
                }
                
                break;
        }
        
        switch ( trophytarget.weapon_name )
        {
            case #"hash_c500a77b6bb7c5d0":
                if ( 126750 > protectiondistsqr )
                {
                    protectiondistsqr = 126750;
                }
                
                break;
        }
    }
    
    return protectiondistsqr;
}

// Namespace scripted_trophy
// Params 1
// Checksum 0xc7348762, Offset: 0x1599
// Size: 0x222, Type: bool
function trophy_checkignorelist( trophytarget )
{
    if ( isdefined( trophytarget.bundle ) )
    {
        if ( trophytarget.bundle.trophy_system_should_ignore )
        {
            return true;
        }
    }
    
    weaponname = trophytarget.weapon_name;
    
    if ( !isdefined( weaponname ) && isdefined( trophytarget.weapon_object ) )
    {
        weaponname = trophytarget.weapon_object.basename;
    }
    
    if ( isdefined( trophytarget.var_959f5b74ce8cab47 ) )
    {
        return true;
    }
    
    if ( isdefined( weaponname ) )
    {
        if ( weapon::iskillstreakweapon( weaponname ) && weaponname != "cruise_proj_mp" && weaponname != "chopper_gunner_proj_mp" && !issubstr( weaponname, "missile_turret_proj" ) )
        {
            return true;
        }
        
        if ( isdefined( trophytarget.weapon_object ) && weapon::iswonderweapon( trophytarget.weapon_object ) )
        {
            return true;
        }
        
        switch ( weaponname )
        {
            case #"hash_5e3fa526a48eaaa5":
                if ( utility::issharedfuncdefined( #"equipment", #"hash_d1613d1359f2871d" ) )
                {
                    if ( [[ utility::getsharedfunc( #"equipment", #"hash_d1613d1359f2871d" ) ]]( trophytarget ) )
                    {
                        return true;
                    }
                }
                
                break;
            case #"hash_1a30d3a1753a5b6":
            case #"hash_22f1c67a16accbe":
            case #"hash_34f28162f0f54c6e":
            case #"hash_51a6d4a5612754d2":
            case #"hash_523f0c8fe1ead306":
            case #"hash_53d34fb712dd4235":
            case #"hash_571e95536d9682a1":
            case #"hash_5be4c94863c15240":
            case #"hash_5cc52f4b3d579bc3":
            case #"hash_617feab345ee4f01":
            case #"hash_829141045b36cf1c":
            case #"hash_83ef591efa62a73b":
            case #"hash_badacfdae124cc01":
            case #"hash_c4b9b21ecac2ced4":
            case #"hash_cce14c95e4764532":
            case #"hash_e4aed4089cbf3bc9":
            case #"hash_ef5768c3c9f00e10":
            case #"hash_ffdabdde3cb352ca":
                return true;
        }
    }
    
    return false;
}

// Namespace scripted_trophy
// Params 3
// Checksum 0x926d6ffd, Offset: 0x17c4
// Size: 0xcc
function trophy_notifytrophytargetowner( trophytarget, trophyweaponname, trophyowner )
{
    if ( !isplayer( trophytarget.owner ) )
    {
        return;
    }
    
    trophytarget.owner damagefeedback::updatedamagefeedback( "hittrophysystem" );
    
    if ( isdefined( trophytarget.weapon_name ) )
    {
        switch ( trophytarget.weapon_name )
        {
            case #"hash_5b1e7be1304d43db":
            case #"hash_94c7880dca9ccc3f":
            case #"hash_b23a0686850cd666":
                trophytarget.owner notify( #"hash_e48f56f6b662855f", trophyowner, trophyweaponname, trophytarget.weapon_name, trophytarget.origin, trophytarget.angles );
                break;
        }
    }
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x7a1113ab, Offset: 0x1898
// Size: 0x10b
function trophy_getbesttag( position )
{
    tags = level.trophy.tags;
    bestdot = undefined;
    besttag = undefined;
    
    foreach ( id, tag in tags )
    {
        origin = self gettagorigin( tag );
        angles = self gettagangles( tag );
        forward = anglestoforward( angles );
        dot = vectordot( vectornormalize( position - origin ), forward );
        
        if ( id == 0 || dot > bestdot )
        {
            bestdot = dot;
            besttag = tag;
        }
    }
    
    return besttag;
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x8e994c58, Offset: 0x19ac
// Size: 0xa5
function trophy_getpartbytag( tag )
{
    tags = level.trophy.tags;
    
    foreach ( id, t in tags )
    {
        if ( t == tag )
        {
            return ( "barrel" + id + 1 );
        }
    }
}

#using_animtree( "scriptables" );

// Namespace scripted_trophy
// Params 0
// Checksum 0xebc39ae5, Offset: 0x1a5a
// Size: 0xf
function trophy_getdeployanimtime()
{
    return getanimlength( %wm_trophy_system_deploy_landing );
}

// Namespace scripted_trophy
// Params 1
// Checksum 0x258b1fe2, Offset: 0x1a72
// Size: 0x43
function trophy_givedamagefeedback( attacker )
{
    damagefeedback = "";
    
    if ( self.hasruggedeqp )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
}

// Namespace scripted_trophy
// Params 5
// Checksum 0xbae517d5, Offset: 0x1abd
// Size: 0xf1
function trophy_modifieddamage( attacker, victim, sweapon, damage, damageadd )
{
    if ( !isdefined( sweapon ) )
    {
        return [ damage, damageadd ];
    }
    
    if ( damage == 0 )
    {
        return [ damage, damageadd ];
    }
    
    damageclamp = undefined;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        switch ( sweapon )
        {
            case #"hash_5e3fa526a48eaaa5":
            case #"hash_6f08e94ea93bfaf9":
            case #"hash_f085b57dce639767":
                maxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
                damageclamp = 0.66 * maxhealth;
                break;
        }
    }
    
    modifieddamageadd = damageadd;
    
    if ( isdefined( damageclamp ) )
    {
        modifieddamageadd = damageclamp - damage;
    }
    
    modifieddamageadd = min( modifieddamageadd, damageadd );
    return [ damage, modifieddamageadd ];
}

// Namespace scripted_trophy
// Params 2
// Checksum 0x901c0e86, Offset: 0x1bb7
// Size: 0x38
function trophy_cleanuponparentdeath( parent, delay )
{
    self endon( #"death" );
    parent waittill( #"death" );
    wait delay;
    self delete();
}

/#

    // Namespace scripted_trophy
    // Params 0
    // Checksum 0xe53b1756, Offset: 0x1bf7
    // Size: 0x13, Type: dev
    function function_f453d73a546e6575()
    {
        thread function_930a202b638f2e65();
        thread function_f802b31ae55e758d();
    }

    // Namespace scripted_trophy
    // Params 0
    // Checksum 0x2185b097, Offset: 0x1c12
    // Size: 0x11, Type: dev
    function function_7132775d51cfb5e7()
    {
        self notify( #"hash_1904dc5d7becad98" );
    }

    // Namespace scripted_trophy
    // Params 0
    // Checksum 0x9a80d302, Offset: 0x1c2b
    // Size: 0x13e, Type: dev
    function function_930a202b638f2e65()
    {
        level endon( #"game_end" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self endon( #"hash_1904dc5d7becad98" );
        baserange = 105625;
        var_b9a7e500b3a86f02 = 126750;
        var_b9a7e400b3a86ccf = 211250;
        baserange = sqrt( baserange );
        var_b9a7e500b3a86f02 = sqrt( var_b9a7e500b3a86f02 );
        var_b9a7e400b3a86ccf = sqrt( var_b9a7e400b3a86ccf );
        ranges = [];
        ranges[ 0 ] = baserange;
        ranges[ 1 ] = var_b9a7e500b3a86f02;
        ranges[ 2 ] = var_b9a7e400b3a86ccf;
        spherecolor = ( 1, 0, 0 );
        
        while ( true )
        {
            foreach ( range in ranges )
            {
                sphere( self.origin, range, spherecolor, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace scripted_trophy
    // Params 0
    // Checksum 0x7af8a26e, Offset: 0x1d71
    // Size: 0xe5, Type: dev
    function function_f802b31ae55e758d()
    {
        level endon( #"game_end" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self endon( #"hash_1904dc5d7becad98" );
        self.var_20c5ec8e75a719f8 = [];
        spherecolor = ( 0, 1, 0 );
        
        while ( true )
        {
            foreach ( var_1b53f79c2495115d in self.var_20c5ec8e75a719f8 )
            {
                sphere( var_1b53f79c2495115d, 5, spherecolor, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace scripted_trophy
    // Params 1
    // Checksum 0x938cdb0a, Offset: 0x1e5e
    // Size: 0x69, Type: dev
    function function_e88a1fe9d0a3d31b( inent )
    {
        if ( isdefined( self.var_20c5ec8e75a719f8 ) )
        {
            self.var_20c5ec8e75a719f8[ self.var_20c5ec8e75a719f8.size ] = inent.origin;
            return;
        }
        
        self.var_20c5ec8e75a719f8 = [];
        self.var_20c5ec8e75a719f8[ self.var_20c5ec8e75a719f8.size ] = inent.origin;
    }

#/
