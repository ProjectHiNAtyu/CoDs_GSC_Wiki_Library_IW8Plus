// scripts\mp\common\utility\damage.gsc  (hash_5ad24b30e5045cbe.gscc) (size: 11878 Bytes / 0x2e66 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd651ea9 (224730793)
// size ...... 11878 (0x2e66)
// includes .. 20  (offset: 0x2c6e)
// strings ... 25  (offset: 0x2d0e)
// dev strs .. 2   (offset: 0x2e4e)
// exports ... 39  (offset: 0x1e02)
// cseg ...... 0x391 + 0x1a71 (0x1e02)
// imports ... 72  (offset: 0x241a)
// animtree1 . 0   (offset: 0x2e66)
// animtree2 . 0   (offset: 0x2e66)
#using scripts\common\bots\bots_util;
#using scripts\common\damage_effects;
#using scripts\common\string;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\armor;
#using scripts\mp\common\supers\super_suppression_rounds;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\dragonsbreath;
#using scripts\mp\heavyarmor;

#namespace damage;

// Namespace damage
// Params 2
// Checksum 0xd9b7c160, Offset: 0x3af
// Size: 0x5e
function get_damageable_player( player, playerpos )
{
    newent = spawnstruct();
    newent.isplayer = 1;
    newent.isadestructable = 0;
    newent.entity = player;
    newent.damagecenter = playerpos;
    return newent;
}

// Namespace damage
// Params 2
// Checksum 0x4166e18c, Offset: 0x416
// Size: 0x6b
function get_damageable_sentry( sentry, sentrypos )
{
    newent = spawnstruct();
    newent.isplayer = 0;
    newent.isadestructable = 0;
    newent.issentry = 1;
    newent.entity = sentry;
    newent.damagecenter = sentrypos;
    return newent;
}

// Namespace damage
// Params 2
// Checksum 0xcd185307, Offset: 0x48a
// Size: 0x5d
function get_damageable_grenade( grenade, entpos )
{
    newent = spawnstruct();
    newent.isplayer = 0;
    newent.isadestructable = 0;
    newent.entity = grenade;
    newent.damagecenter = entpos;
    return newent;
}

// Namespace damage
// Params 2
// Checksum 0xff4a6ef0, Offset: 0x4f0
// Size: 0x5d
function get_damageable_mine( mine, entpos )
{
    newent = spawnstruct();
    newent.isplayer = 0;
    newent.isadestructable = 0;
    newent.entity = mine;
    newent.damagecenter = entpos;
    return newent;
}

// Namespace damage
// Params 1
// Checksum 0x6f0c3391, Offset: 0x556
// Size: 0x25
function get_damageable_player_pos( player )
{
    return player.origin + ( 0, 0, 32 );
}

// Namespace damage
// Params 1
// Checksum 0xbc9383ed, Offset: 0x584
// Size: 0x17
function get_damageable_grenade_pos( grenade )
{
    return grenade.origin;
}

// Namespace damage
// Params 2
// Checksum 0xdbf176cc, Offset: 0x5a4
// Size: 0x111
function istacticaldamage( objweapon, smeansofdeath )
{
    if ( !isdefined( objweapon ) )
    {
        return 0;
    }
    
    if ( !isdefined( smeansofdeath ) || smeansofdeath == "MOD_IMPACT" )
    {
        return 0;
    }
    
    var_ebc014404044afa7 = level.sharedfuncs[ #"equipment" ][ #"getequipmentbundlefromweaponname" ];
    
    if ( isdefined( var_ebc014404044afa7 ) )
    {
        equipbundle = [[ var_ebc014404044afa7 ]]( objweapon.basename );
        return ( equipbundle.equipmenttype == "tactical" );
    }
    
    switch ( objweapon.basename )
    {
        case #"hash_1ecab60787f72ae":
        case #"hash_34e7a4cd11aed6bc":
        case #"hash_954bb5f200a1b95a":
        case #"hash_9f73f49d822d9acc":
        case #"hash_aec9c140fca96664":
        case #"hash_cac2107b8e726d9d":
        case #"hash_d072a0adddda0068":
        case #"hash_e3575fdd14663ca9":
            return 1;
        default:
            return 0;
    }
}

// Namespace damage
// Params 3
// Checksum 0xb94c6d19, Offset: 0x6bd
// Size: 0x5e, Type: bool
function function_17032bfefd0f2bff( weapon, smeansofdeath, attacker )
{
    if ( weapon_utility::isbulletweapon( weapon ) )
    {
        if ( isdefined( attacker ) && isdefined( attacker.perks[ "specialty_incendiary" ] ) )
        {
            return true;
        }
        
        if ( isdefined( weapon ) && dragonsbreath::function_7feebca326ca7376( weapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0x272949af, Offset: 0x724
// Size: 0x40, Type: bool
function function_c9250d055b095b66( weapon, attacker )
{
    if ( weapon_utility::isbulletweapon( weapon ) )
    {
        if ( isdefined( attacker ) && isdefined( attacker.perks[ "specialty_explosivebullet" ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0x1366aec9, Offset: 0x76d
// Size: 0x3f, Type: bool
function isfmjdamage( weapon, smeansofdeath )
{
    if ( isdefined( weapon ) && isdefined( smeansofdeath ) && utility::isbulletdamage( smeansofdeath ) )
    {
        if ( getweaponhasperk( weapon, "specialty_armorpiercing" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0x486823f1, Offset: 0x7b5
// Size: 0x35, Type: bool
function function_7e7e4fed88045f3e( smeansofdeath, attacker )
{
    if ( !isplayer( attacker ) )
    {
        return false;
    }
    
    return utility::isbulletdamage( smeansofdeath ) && attacker super_suppression_rounds::suppressionrounds_hasaprrounds();
}

// Namespace damage
// Params 4
// Checksum 0xa7dd6905, Offset: 0x7f3
// Size: 0xa1, Type: bool
function function_a76bfa0c2b49b5c5( attacker, victim, smeansofdeath, idflags )
{
    if ( super_suppression_rounds::function_e6b3ada0b717e4ce( attacker ) )
    {
        return false;
    }
    
    var_e1852df15b08c312 = function_7e7e4fed88045f3e( smeansofdeath, attacker );
    
    if ( var_e1852df15b08c312 )
    {
        if ( isplayer( victim ) || isagent( victim ) )
        {
            if ( armor::isbulletpenetration( idflags ) )
            {
                return true;
            }
            
            if ( isdefined( victim.vehicle ) )
            {
                return true;
            }
            
            if ( victim armor::hasarmor() )
            {
                return true;
            }
            
            if ( victim.isjuggernaut )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace damage
// Params 4
// Checksum 0x7cda81c6, Offset: 0x89d
// Size: 0x175, Type: bool
function islethalmeleeweapon( attacker, victim, objweapon, smeansofdeath )
{
    if ( smeansofdeath != "MOD_MELEE" )
    {
        return false;
    }
    
    if ( !isplayer( victim ) )
    {
        return false;
    }
    
    if ( victim heavyarmor::hasheavyarmor() )
    {
        return false;
    }
    
    if ( !val::get( "one_hit_melee_victim" ) )
    {
        return false;
    }
    
    if ( weapon::isfistsonly( objweapon.basename ) )
    {
        return false;
    }
    
    if ( weapon::function_e93a21a657377115( objweapon ) )
    {
        return true;
    }
    
    if ( weapon_utility::isknifeonly( objweapon.basename ) )
    {
        return true;
    }
    
    if ( weapon::isballweapon( objweapon ) )
    {
        return true;
    }
    
    if ( objweapon.basename == "iw8_defibrillator_mp" )
    {
        return true;
    }
    
    if ( weapon::function_33e74163843b348e( objweapon.basename ) && attacker getweaponammoclip( objweapon ) > 0 )
    {
        return true;
    }
    
    foreach ( attachment in objweapon.attachments )
    {
        if ( isstartstr( attachment, "bayonet" ) || isstartstr( attachment, "tacknife" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace damage
// Params 3
// Checksum 0xe94b0f24, Offset: 0xa1b
// Size: 0x24a, Type: bool
function attackerishittingteam( victim, attacker, turretindex )
{
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !attacker || !victim )
    {
        return false;
    }
    
    isvehicle = attacker vehicle::is_vehicle();
    
    if ( isvehicle && turretindex )
    {
        turretoccupant = attacker function_9cd430b77c27eb1b( turretindex );
        
        if ( turretoccupant )
        {
            attacker = turretoccupant;
        }
    }
    
    if ( isdefined( attacker.owner ) )
    {
        if ( victim == attacker.owner && isdefined( attacker.streakinfo.streakname ) && killstreak::function_debef5ec569c4557( attacker.streakinfo.streakname ) )
        {
            return true;
        }
        
        attacker = attacker.owner;
    }
    
    if ( !( isdefined( victim.team ) && isdefined( attacker.team ) ) )
    {
        return false;
    }
    
    if ( victim == attacker )
    {
        return false;
    }
    
    if ( isdefined( attacker.teamchangedthisframe ) && game_utility::isinfectedgametype() )
    {
        if ( victim.pers[ "team" ] == attacker.team )
        {
            return false;
        }
        
        if ( victim.pers[ "team" ] != attacker.team )
        {
            return true;
        }
    }
    
    if ( attacker.scrambled )
    {
        return false;
    }
    
    if ( player::isplayerproxyagent( victim, attacker ) )
    {
        return false;
    }
    
    if ( isagent( victim ) )
    {
        if ( victim.skipfriendlyfire )
        {
            return false;
        }
        
        if ( victim.owner == attacker )
        {
            return false;
        }
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c3feadabb9698ca3" ][ #"hash_c96c38e2c1dbf64d" ];
    
    if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]( attacker, victim ) )
    {
        return false;
    }
    
    if ( victim.team == attacker.team )
    {
        return true;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c3feadabb9698ca3" ][ #"hash_7a56a72be10adcea" ];
    
    if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]( attacker, victim ) )
    {
        return true;
    }
    
    if ( function_baa09a9e75d8726c( attacker, victim ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0xd6fc051c, Offset: 0xc6e
// Size: 0x50, Type: bool
function function_baa09a9e75d8726c( eattacker, victim )
{
    return isplayer( eattacker ) && isplayer( victim ) && isdefined( victim.proxyteam ) && eattacker.proxyteam === victim.proxyteam;
}

// Namespace damage
// Params 2
// Checksum 0xca4addaf, Offset: 0xcc7
// Size: 0x66
function _validateattacker( eattacker, einflictor )
{
    if ( isagent( eattacker ) )
    {
        if ( !eattacker.isactive )
        {
            return;
        }
        
        if ( !isdefined( eattacker.classname ) )
        {
            return;
        }
        
        if ( isdefined( einflictor ) && isplayer( einflictor.owner ) )
        {
            return einflictor.owner;
        }
    }
    
    return eattacker;
}

// Namespace damage
// Params 1
// Checksum 0x94764e93, Offset: 0xd36
// Size: 0x1b
function _validatevictim( victim )
{
    if ( !victim player::isreallyalive() )
    {
        return;
    }
    
    return victim;
}

// Namespace damage
// Params 7
// Checksum 0x604d2ed1, Offset: 0xd5a
// Size: 0x52
function _radiusdamage( origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon )
{
    self radiusdamage( origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon );
}

// Namespace damage
// Params 10
// Checksum 0xa3fe53e7, Offset: 0xdb4
// Size: 0x280
function radiusplayerdamage( origin, minradius, maxradius, mindamage, maxdamage, attacker, inflictor, meansofdeath, weaponname, ignoreattacker )
{
    assert( isdefined( origin ) && isdefined( minradius ) && isdefined( maxradius ) && isdefined( mindamage ) && isdefined( maxdamage ) && isdefined( attacker ) && isdefined( meansofdeath ) );
    
    if ( !isdefined( ignoreattacker ) )
    {
        ignoreattacker = 0;
    }
    
    var_22736568541dd936 = trace::create_character_contents();
    castcontents = trace::create_contents( 0, 1, 1, 0, 1, 0 );
    ignorelist = [];
    
    foreach ( character in level.characters )
    {
        if ( !isdefined( character ) )
        {
            continue;
        }
        
        if ( !character player::isreallyalive() )
        {
            ignorelist[ ignorelist.size ] = character;
            continue;
        }
        
        if ( ignoreattacker && character == attacker )
        {
            ignorelist[ ignorelist.size ] = character;
            continue;
        }
        
        if ( level.teambased && character.team == attacker.team )
        {
            ignorelist[ ignorelist.size ] = character;
        }
    }
    
    var_dca2d78dc0797f1a = physics_querypoint( attacker.origin, maxradius, var_22736568541dd936, ignorelist, "physicsquery_all" );
    
    if ( var_dca2d78dc0797f1a.size > 0 )
    {
        for ( i = 0; i < var_dca2d78dc0797f1a.size ; i++ )
        {
            ent = var_dca2d78dc0797f1a[ i ][ "entity" ];
            dist = var_dca2d78dc0797f1a[ i ][ "distance" ];
            point = var_dca2d78dc0797f1a[ i ][ "position" ];
            
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            castresults = physics_raycast( origin, point, castcontents, undefined, 0, "physicsquery_closest" );
            
            if ( castresults.size > 0 )
            {
                continue;
            }
            
            distratio = max( dist, minradius ) / maxradius;
            damage = mindamage + ( maxdamage - mindamage ) * distratio;
            ent dodamage( damage, origin, attacker, inflictor, meansofdeath, weaponname );
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x4b2f13d, Offset: 0x103c
// Size: 0x18, Type: bool
function hashealthshield( player )
{
    return isdefined( player.healthshield );
}

// Namespace damage
// Params 1
// Checksum 0x8f87b6bf, Offset: 0x105d
// Size: 0x33
function gethealthshielddamage( damage )
{
    assert( isdefined( self.healthshieldmod ), "<dev string:x24>" );
    return int( damage * self.healthshieldmod );
}

// Namespace damage
// Params 1
// Checksum 0xe9bffbee, Offset: 0x1099
// Size: 0x6b
function sethealthshield( shieldvalue )
{
    self.healthshield = 1;
    
    if ( !isdefined( self.healthshieldmod ) )
    {
        self.healthshieldmod = 1;
    }
    
    shieldvalue = int( clamp( shieldvalue, 0, 100 ) );
    var_a6f2701f9886040e = ( 100 - shieldvalue ) / 100;
    
    if ( var_a6f2701f9886040e < self.healthshieldmod )
    {
        self.healthshieldmod = var_a6f2701f9886040e;
    }
}

// Namespace damage
// Params 0
// Checksum 0x29e275b9, Offset: 0x110c
// Size: 0x16
function clearhealthshield()
{
    self.healthshield = undefined;
    self.healthshieldmod = undefined;
}

// Namespace damage
// Params 3
// Checksum 0x150a147f, Offset: 0x112a
// Size: 0xd3
function _suicide( checkremote, var_b81970474665ea57, damageflags = 0 )
{
    if ( self.sessionstate != "playing" )
    {
        println( "<dev string:x9f>" );
        return;
    }
    
    shoulddofauxdeath = playershoulddofauxdeath( checkremote );
    
    if ( shoulddofauxdeath && !isdefined( self.fauxdead ) )
    {
        thread playerkilled_internal( self, self, self, 10000, damageflags, "MOD_SUICIDE", nullweapon(), ( 0, 0, 0 ), "none", 0, 1116, 1 );
        return;
    }
    
    if ( !shoulddofauxdeath && !isdefined( self.fauxdead ) && ( !isdefined( self.vehicle ) || var_b81970474665ea57 ) )
    {
        self suicide( damageflags );
    }
}

// Namespace damage
// Params 0
// Checksum 0x6c6ad29a, Offset: 0x1205
// Size: 0x3a
function suicide_on_end_remote()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"stopped_using_remote" );
    thread suicide_on_alive();
}

// Namespace damage
// Params 0
// Checksum 0x8ddf1f1e, Offset: 0x1247
// Size: 0x5b
function suicide_on_alive()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_a9d0cb677e1581bb" );
    self endon( #"hash_a9d0cb677e1581bb" );
    
    while ( !player::isreallyalive( self ) || self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    _suicide();
}

// Namespace damage
// Params 1
// Checksum 0x20a95866, Offset: 0x12aa
// Size: 0x125, Type: bool
function playershoulddofauxdeath( checkremote = 1 )
{
    if ( self.isusingcamera )
    {
        return false;
    }
    
    var_c2002c0bd0ade935 = level.gametypebundle.var_c2002c0bd0ade935;
    
    if ( checkremote && utility::isusingremote() && ( var_c2002c0bd0ade935 || !game_utility_mp::islifelimited() ) )
    {
        bundle = level.streakglobals.streakbundles[ self.usingremote ];
        
        if ( !bundle )
        {
            bundle = level.equipment.table[ self.usingremote ].bundle;
            
            if ( bundle )
            {
                return ( !bundle.var_217264015ae88213 && !self.var_1df90882c6490925 );
            }
        }
        
        var_a8eda09bf487c604 = !bundle.var_217264015ae88213;
        
        if ( var_a8eda09bf487c604 && !self.var_1df90882c6490925 )
        {
            return true;
        }
    }
    
    if ( isdefined( level.modeshoulddofauxdeathfunc ) && self [[ level.modeshoulddofauxdeathfunc ]]() )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0x9974caf2, Offset: 0x13d8
// Size: 0x2b, Type: bool
function isprojectiledamage( meansofdeath )
{
    projdamage = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";
    
    if ( issubstr( projdamage, meansofdeath ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0x93cc29f5, Offset: 0x140c
// Size: 0xf1
function non_player_log_attacker_data( data, attacker )
{
    if ( data.damage == 0 )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = data.attacker;
    }
    
    if ( !isplayer( attacker ) )
    {
        inflictor = data.inflictor;
        
        if ( isdefined( inflictor ) )
        {
            if ( isplayer( inflictor ) )
            {
                attacker = inflictor;
            }
            else
            {
                attacker = inflictor.owner;
            }
        }
        else
        {
            attacker = undefined;
        }
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( !player_utility::playersareenemies( self.owner, attacker ) )
        {
            return;
        }
    }
    else if ( level.teambased && isdefined( self.team ) && self.team == attacker.team )
    {
        return;
    }
    
    non_player_add_attacker_data( data, attacker );
}

// Namespace damage
// Params 2
// Checksum 0x42895274, Offset: 0x1505
// Size: 0x1c9
function non_player_add_attacker_data( data, attacker = data.attacker )
{
    firsttimedamaged = undefined;
    attackerdata = non_player_get_attacker_data( attacker );
    
    if ( !isdefined( attackerdata ) )
    {
        attackerdata = non_player_get_attacker_data( attacker, 1 );
        firsttimedamaged = gettime();
    }
    
    attackerdata.damage += data.damage;
    attackerdata.objweapon = data.objweapon;
    attackerdata.point = data.point;
    attackerdata.direction = data.direction_vec;
    attackerdata.partname = data.partname;
    attackerdata.meansofdeath = data.meansofdeath;
    attackerdata.firsttimedamaged = firsttimedamaged ?? attackerdata.firsttimedamaged;
    attackerdata damage_effects::updatefirsttimedamaged();
    attackerdata.lasttimedamaged = gettime();
    
    if ( vehicle::is_common_vehicle() && isplayer( attacker ) && bots_util::function_deef484b5b3a3977() )
    {
        driver = vehicle_occupancy::get_driver( self, 1 );
        
        if ( isbot( driver ) || isautopilot( driver ) )
        {
            if ( !isdefined( attacker.guid ) )
            {
                attacker.guid = attacker player::getuniqueid();
            }
            
            if ( !isdefined( attackerdata.attackerent ) )
            {
                attackerdata.attackerent = attacker;
            }
            
            driver function_a413e91ba3513105( string::to_string( attacker.guid ), attackerdata );
        }
    }
}

// Namespace damage
// Params 2
// Checksum 0xb69a0206, Offset: 0x16d6
// Size: 0x16b
function non_player_get_attacker_data( attacker, create )
{
    attackerdata = undefined;
    
    if ( create )
    {
        if ( !isdefined( self.attackerdata ) )
        {
            self.attackerdata = [];
        }
    }
    
    if ( isdefined( self.attackerdata ) )
    {
        guid = attacker.guid;
        
        if ( isdefined( guid ) )
        {
            attackerdata = self.attackerdata[ guid ];
            
            if ( isdefined( attackerdata ) )
            {
                if ( attackerdata.isvalid || level.teambased && isdefined( attacker.team ) && isdefined( attackerdata.team ) && attacker.team != attackerdata.team )
                {
                    attackerdata = undefined;
                    self.attackerdata[ guid ] = undefined;
                }
            }
            
            if ( !isdefined( attackerdata ) && create )
            {
                attackerdata = spawnstruct();
                attackerdata.attacker = attacker;
                attackerdata.team = attacker.team;
                attackerdata.guid = guid;
                attackerdata.isvalid = 1;
                attackerdata.damage = 0;
                attackerdata.hitcount = 0;
                attackerdata.firsttimehit = gettime();
                self.attackerdata[ guid ] = attackerdata;
            }
        }
    }
    
    return attackerdata;
}

// Namespace damage
// Params 0
// Checksum 0x39ae823f, Offset: 0x184a
// Size: 0xc
function non_player_clear_attacker_data()
{
    self.attackerdata = undefined;
}

// Namespace damage
// Params 4
// Checksum 0x2ebd6a00, Offset: 0x185e
// Size: 0x193, Type: bool
function non_player_should_ignore_damage( attacker, objweapon, inflictor, meansofdeath )
{
    if ( non_player_should_ignore_damage_signature( attacker, objweapon, inflictor, meansofdeath ) )
    {
        return true;
    }
    
    if ( utility::callsharedfunc( #"equipment_interaction", #"ignore_damage", self, attacker, inflictor, objweapon ) )
    {
        return true;
    }
    
    if ( isdefined( objweapon.basename ) )
    {
        if ( meansofdeath != "MOD_MELEE" )
        {
            switch ( objweapon.basename )
            {
                case #"hash_405f9521b5ee8402":
                case #"hash_807ae3204119bd41":
                    return true;
            }
        }
        
        if ( meansofdeath == "MOD_IMPACT" )
        {
            switch ( objweapon.basename )
            {
                case #"hash_e5bd5c73b30f4a5":
                case #"hash_435258fc47768fa7":
                case #"hash_4b87af60037f526f":
                case #"hash_4c7de5619284e175":
                case #"hash_56ee829cc162271a":
                case #"hash_5e8f81314553dd36":
                case #"hash_6a2e4f9c54756dc7":
                case #"hash_d6565ec12efca627":
                    return true;
            }
        }
        else
        {
            switch ( objweapon.basename )
            {
                case #"hash_1ecab60787f72ae":
                case #"hash_34e7a4cd11aed6bc":
                case #"hash_aec9c140fca96664":
                case #"hash_b2a8e1829f433bd7":
                case #"hash_c7ce3f77814f7950":
                case #"hash_cac2107b8e726d9d":
                case #"hash_d072a0adddda0068":
                    return true;
            }
        }
    }
    
    return false;
}

// Namespace damage
// Params 4
// Checksum 0x3f05338e, Offset: 0x19fa
// Size: 0x12e
function non_player_add_ignore_damage_signature( attacker, objweapon, inflictor, meansofdeath )
{
    if ( !isdefined( self.ignoredamageid ) )
    {
        self.ignoredamageid = 0;
    }
    
    if ( !isdefined( self.ignoredamagesignatures ) )
    {
        self.ignoredamagesignatures = [];
    }
    
    id = self.ignoredamageid;
    self.ignoredamageid++;
    
    if ( isstring( objweapon ) )
    {
        objweapon = makeweapon( objweapon );
    }
    
    signature = spawnstruct();
    signature.id = id;
    signature.attacker = attacker;
    signature.objweapon = objweapon;
    signature.inflictor = inflictor;
    signature.meansofdeath = meansofdeath;
    signature.checkattacker = isdefined( attacker );
    signature.checkobjweapon = isdefined( objweapon ) && !isnullweapon( objweapon );
    signature.checkinflictor = isdefined( inflictor );
    signature.checkmeansofdeath = isdefined( meansofdeath );
    self.ignoredamagesignatures[ id ] = signature;
    return id;
}

// Namespace damage
// Params 1
// Checksum 0x10a63906, Offset: 0x1b31
// Size: 0x27
function non_player_remove_ignore_damage_signature( id )
{
    if ( !isdefined( self.ignoredamagesignatures ) )
    {
        return;
    }
    
    self.ignoredamagesignatures[ id ] = undefined;
}

// Namespace damage
// Params 0
// Checksum 0x98d34fd3, Offset: 0x1b60
// Size: 0xc
function non_player_clear_ignore_damage_signatures()
{
    self.ignoredamagesignatures = undefined;
}

// Namespace damage
// Params 4
// Checksum 0xe99c2c4d, Offset: 0x1b74
// Size: 0x1ee, Type: bool
function non_player_should_ignore_damage_signature( attacker, objweapon, inflictor, meansofdeath )
{
    if ( !isdefined( self.ignoredamagesignatures ) )
    {
        return false;
    }
    
    if ( isstring( objweapon ) )
    {
        objweapon = makeweapon( objweapon );
    }
    
    foreach ( signature in self.ignoredamagesignatures )
    {
        if ( !isdefined( signature ) )
        {
            return false;
        }
        
        if ( signature.checkattacker )
        {
            if ( !isdefined( signature.attacker ) )
            {
                non_player_remove_ignore_damage_signature( signature.id );
                continue;
            }
            else if ( !isdefined( attacker ) )
            {
                continue;
            }
            else if ( attacker != signature.attacker )
            {
                continue;
            }
        }
        
        if ( signature.checkobjweapon )
        {
            if ( !isdefined( objweapon ) || isnullweapon( objweapon ) )
            {
                continue;
            }
            else if ( objweapon.basename != signature.objweapon.basename )
            {
                continue;
            }
        }
        
        if ( signature.checkinflictor )
        {
            if ( !isdefined( signature.inflictor ) )
            {
                non_player_remove_ignore_damage_signature( signature.id );
                continue;
            }
            else if ( !isdefined( inflictor ) )
            {
                continue;
            }
            else if ( inflictor != signature.inflictor )
            {
                continue;
            }
        }
        
        if ( signature.checkmeansofdeath )
        {
            if ( !isdefined( meansofdeath ) )
            {
                continue;
            }
            else if ( meansofdeath != signature.meansofdeath )
            {
                continue;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 3
// Checksum 0x58b3abf9, Offset: 0x1d6b
// Size: 0x96, Type: bool
function islauncherdirectimpactdamage( objweapon, meansofdeath, var_8e54b077e4a4e203 )
{
    if ( objweapon.type != "projectile" )
    {
        return false;
    }
    
    if ( var_8e54b077e4a4e203 && objweapon.isalternate && isdefined( objweapon.underbarrel ) )
    {
        return false;
    }
    
    return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_HEAD_SHOT" && weaponclass( objweapon ) == "rocketlauncher";
}

