// scripts\mp\common\equipment\butterfly_mine.gsc  (hash_696c5fdcb7fb31e0.gscc) (size: 13890 Bytes / 0x3642 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1f00465 (3522167909)
// size ...... 13890 (0x3642)
// includes .. 22  (offset: 0x32fa)
// strings ... 43  (offset: 0x33aa)
// dev strs .. 1   (offset: 0x3636)
// exports ... 33  (offset: 0x1fa2)
// cseg ...... 0x35e + 0x1c44 (0x1fa2)
// imports ... 120 (offset: 0x24ca)
// animtree1 . 0   (offset: 0x3642)
// animtree2 . 0   (offset: 0x3642)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace butterfly_mine;

// Namespace butterfly_mine
// Params 0, eflags: 0x1
// Checksum 0x87402a45, Offset: 0x37c
// Size: 0x1c
function autoexec main()
{
    utility::registersharedfunc( "equip_butterfly_mine", #"init", &butterfly_mine_init );
}

// Namespace butterfly_mine
// Params 0
// Checksum 0x95967d87, Offset: 0x3a0
// Size: 0x6b
function butterfly_mine_init()
{
    minetriggerdata = vehicle_mines::get_data( "equip_butterfly_mine", 1 );
    minetriggerdata.triggercallback = &function_96e298b6ed03eccb;
    level.var_aec6e5502dfcb566 = getdvarint( @"hash_eb66ecc15316468f", 1 );
    weapons::registerusedcallback( "butterfly_mine", &butterfly_mine_used );
    equipment_mp::registercallback( "equip_butterfly_mine", "onOwnerChanged", &butterfly_mine_onownerchanged );
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x62068825, Offset: 0x413
// Size: 0x1a7
function butterfly_mine_used( grenade )
{
    grenade setotherent( self );
    grenade setcandamage( 0 );
    grenade hudoutlinedisable();
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade.playerhits = [];
    grenade.givenscore = 0;
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    launchangles = self getgunangles();
    launchtimems = gettime();
    launchvelocity = anglestoforward( launchangles ) * 500 + anglestoup( launchangles ) * 0;
    grenade waittill( #"missile_stuck", stuckto );
    grenade setscriptablepartstate( "plant", "active", 0 );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    weapons::onequipmentplanted( grenade, "equip_butterfly_mine", &function_3ad11a42dd9cf271 );
    wait grenade.tableinfo.bundle.scatterdelay;
    grenade butterfly_mine_spread( grenade, launchangles, impactvelocity );
    grenade setscriptablepartstate( "launch", "land", 0 );
    wait 0.25;
    grenade setscriptablepartstate( "visibility", "hide", 0 );
    grenade hide();
}

// Namespace butterfly_mine
// Params 3
// Checksum 0xb5ed1957, Offset: 0x5c2
// Size: 0x61
function butterfly_mine_spread( grenade, launchangles, impactvelocity )
{
    grenade.ownedmines = [];
    grenade function_32a859cdbe8a2d85( grenade.tableinfo.bundle.damageweapons, 3, impactvelocity, 45, 120, 35, 360, 0 );
}

// Namespace butterfly_mine
// Params 8
// Checksum 0xcc7f6c28, Offset: 0x62b
// Size: 0x241
function function_32a859cdbe8a2d85( minename, nummines, impactvelocity, stepstartradius, var_a761ed5c98c5f82f, launchangle, fandegrees, var_a84da0b4d2585b2c )
{
    for ( mineindex = 0; mineindex < nummines ; mineindex++ )
    {
        minenum = "0" + mineindex;
        launchlocation = self gettagorigin( "j_mine_" + minenum, 1 );
        
        if ( !isdefined( launchlocation ) )
        {
            continue;
        }
        
        launchdirection = vectornormalize( launchlocation - self.origin );
        launchdirection = function_58967cd15ec7683e( launchdirection, launchlocation, 10 );
        verticalangle = randomfloatrange( -1, 1 ) * 5 + launchangle;
        angledeviation = randomfloatrange( -1, 1 ) * 15;
        var_75416a4465bb5ef5 = 360 - verticalangle - angledeviation;
        targetradius = randomfloatrange( stepstartradius, var_a761ed5c98c5f82f );
        launchangles = vectortoangles( launchdirection ) + ( var_75416a4465bb5ef5, 0, 0 );
        totalvelocity = sqrt( 800 * targetradius / sin( 2 * verticalangle ) );
        var_b4cccb42ec5e174e = vectornormalize( anglestoforward( launchangles ) );
        velocityvec = totalvelocity * var_b4cccb42ec5e174e;
        
        if ( isdefined( self ) && isdefined( self.owner ) )
        {
            scatteredmine = weapon::_launchgrenade( minename, launchlocation, velocityvec, self.tableinfo.bundle.scatterlifetime );
            function_dd7451455fa6e8c3( scatteredmine, self.owner, self );
            self.ownedmines[ mineindex + var_a84da0b4d2585b2c ] = scatteredmine;
            scatteredmine thread butterfly_mine_watchtrigger( self.tableinfo.bundle );
            
            if ( utility::issharedfuncdefined( #"entity", #"hash_c7672f71e7dbfe82" ) )
            {
                [[ utility::getsharedfunc( #"entity", #"hash_c7672f71e7dbfe82" ) ]]( scatteredmine, self.owner, "butterfly_mine" );
                scatteredmine thread function_da2c7f8b3acda973();
                waitframe();
            }
        }
    }
    
    thread function_a4b9b164704b892e();
}

// Namespace butterfly_mine
// Params 0
// Checksum 0xdb5416d9, Offset: 0x874
// Size: 0x57
function function_a4b9b164704b892e()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    thread utility::delaythread( 1, &challenges::function_3d7a169dbae062fb, "equip_butterfly_mine", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace butterfly_mine
// Params 3
// Checksum 0xb569af6e, Offset: 0x8d3
// Size: 0x1bf
function function_58967cd15ec7683e( launchdirection, launchlocation, raycastdistance )
{
    var_30adaa05203a0b0b = launchdirection;
    var_d45959a588908ba0 = ( launchdirection[ 0 ], launchdirection[ 1 ], 0 );
    var_f5452e54f414600 = self.origin + ( 0, 0, 1 );
    var_900714756a603f1 = self.origin + ( 0, 0, 1 ) + var_d45959a588908ba0 * raycastdistance;
    raycastcontents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    hitents = physics_raycast( var_f5452e54f414600, var_900714756a603f1, raycastcontents, undefined, 0, "physicsquery_all" );
    i = 0;
    var_fec454307af89050 = var_d45959a588908ba0;
    var_9e923ada72846065 = 0;
    
    while ( hitents.size > 0 && i < 3 )
    {
        var_f5452e54f414600 = self.origin + ( 0, 0, 1 );
        var_900714756a603f1 = self.origin + ( 0, 0, 1 ) + var_fec454307af89050 * raycastdistance;
        
        if ( hitents.size > 0 )
        {
            if ( i == 0 )
            {
                var_fec454307af89050 = ( var_d45959a588908ba0[ 0 ] * -1, var_d45959a588908ba0[ 1 ] * -1, 0 );
                var_9e923ada72846065 = 1;
            }
            else if ( i == 1 )
            {
                var_fec454307af89050 = ( var_d45959a588908ba0[ 0 ], var_d45959a588908ba0[ 1 ] * -1, 0 );
                var_9e923ada72846065 = 1;
            }
            else if ( i == 2 )
            {
                var_fec454307af89050 = ( var_d45959a588908ba0[ 0 ] * -1, var_d45959a588908ba0[ 1 ], 0 );
                var_9e923ada72846065 = 1;
            }
        }
        
        i++;
    }
    
    if ( var_9e923ada72846065 )
    {
        return ( var_fec454307af89050 + ( 0, 0, launchdirection[ 2 ] ) );
    }
    
    return var_30adaa05203a0b0b;
}

// Namespace butterfly_mine
// Params 4
// Checksum 0x3714c858, Offset: 0xa9a
// Size: 0x310
function function_dd7451455fa6e8c3( butterflymine, owner, sourcegrenade, lifetimeOverride )
{
    butterflymine.owner = owner;
    butterflymine.team = owner.team;
    butterflymine.ownerid = owner getxuid();
    butterflymine.health = 99999;
    butterflymine.maxhealth = self.tableinfo.bundle.scatterhealth;
    butterflymine.lifetime = self.tableinfo.bundle.scatterlifetime;
    butterflymine.explosionradius = self.tableinfo.bundle.scatterexplosionradius;
    butterflymine.mindmg = self.tableinfo.bundle.var_d19d4966495e8837;
    butterflymine.maxdmg = self.tableinfo.bundle.var_3a188a92edc06d75;
    butterflymine.equipmentref = "equip_butterfly_mine";
    
    if ( isdefined( lifetimeOverride ) )
    {
        butterflymine.lifetime = lifetimeOverride;
    }
    
    if ( isdefined( sourcegrenade ) )
    {
        butterflymine.sourcegrenade = sourcegrenade;
    }
    
    butterflymine enableplayermarks( "equipment" );
    
    if ( level.teambased )
    {
        butterflymine filteroutplayermarks( butterflymine.owner.team );
    }
    else
    {
        butterflymine filteroutplayermarks( butterflymine.owner );
    }
    
    butterflymine.damagetaken = 0;
    butterflymine ent_manager::registerspawn( 1, &butterfly_mine_destroy );
    butterflymine.headiconid = entityheadicons::setheadicon_equipment( butterflymine );
    butterflymine setentityowner( owner );
    butterflymine setotherent( owner );
    butterflymine setcandamage( 1 );
    butterflymine thread damage::monitordamage( 1, "hitequip", &function_9a47728012b42b3f, &butterfly_mine_handle_damage );
    emp_debuff::add_emp_ent( butterflymine );
    butterflymine emp_debuff::set_apply_emp_callback( &butterfly_mine_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        butterflymine.ksempapplycallback = &butterfly_mine_empapplied;
    }
    
    butterflymine.dangerzone = spawnlogic::addspawninfluencer( #"equipment_mine", butterflymine.origin, butterflymine.owner.team );
    butterflymine thread butterfly_mine_watch_cleanup();
    butterflymine setscriptablepartstate( "visibility", "show", 0 );
    butterflymine haywire::function_7f69a1eb3d590f76( &butterfly_mine_haywire );
    butterflymine emp_debuff::set_start_emp_callback( &butterfly_mine_empstarted );
    
    if ( level.killstreak_emp_initialized )
    {
        butterflymine.var_5b3dbacfeda0fd01 = &butterfly_mine_empstarted;
    }
    
    butterflymine emp_debuff::set_clear_emp_callback( &butterfly_mine_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        butterflymine.ksempclearcallback = &butterfly_mine_empcleared;
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0xe950bad6, Offset: 0xdb2
// Size: 0x24f
function butterfly_mine_watchtrigger( bundle )
{
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    wait bundle.var_f88b472657b51099;
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self setscriptablepartstate( "arm", "active", 0 );
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        foreach ( ent in entarr )
        {
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent vehicle_mines::function_56d954c642e8acea( self ) )
                {
                    continue;
                }
                
                if ( !vehicle_mines::function_60d53a1a3bd504cd( ent, self ) )
                {
                    continue;
                }
                
                vehicle_mines::trigger_mine( ent, self );
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( ent ) )
                {
                    continue;
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                up = anglestoup( self.angles );
                castorigin = self.origin + up * 35;
                ignorelist = [ self ];
                castresults = physics_raycast( castorigin, ent.origin, contents, ignorelist, 0, "physicsquery_closest", 1 );
                
                if ( castresults.size > 0 )
                {
                    continue;
                }
                
                thread function_2f8a1ae87d5a5cd0( ent );
                break;
            }
        }
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0xd7a863ea, Offset: 0x1009
// Size: 0x2ff
function function_2f8a1ae87d5a5cd0( attacker )
{
    thread butterfly_mine_delete( 5 );
    
    if ( isai( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            attackerid = attacker getxuid();
        }
        else
        {
            attackerid = attacker.unique_id;
        }
    }
    else if ( attacker.classname == "script_vehicle" )
    {
        attackerid = attacker vehicle::get_ref();
    }
    else
    {
        attackerid = attacker getxuid();
    }
    
    if ( isplayer( attacker ) )
    {
        if ( isdefined( attacker.perks[ "specialty_delaymine" ] ) )
        {
            self setscriptablepartstate( "trigger", "active", 0 );
        }
    }
    
    weapons::explosivetrigger( attacker, 0 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.sourcegrenade.playerhits[ attackerid ] ) )
    {
        self.sourcegrenade.playerhits[ attackerid ] += 1;
    }
    else
    {
        self.sourcegrenade.playerhits[ attackerid ] = 1;
    }
    
    statestring = "";
    
    switch ( self.sourcegrenade.playerhits[ attackerid ] )
    {
        case 1:
            statestring = "fromPlayer";
            break;
        case 2:
            statestring = "fromPlayerSecond";
            break;
        case 3:
            statestring = "fromPlayerThird";
            break;
    }
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        statestring += "_hc";
    }
    
    if ( isplayer( attacker ) )
    {
        self.sourcegrenade.owner damagefeedback::updatedamagefeedback( "hitequip" );
    }
    
    self setscriptablepartstate( "arm", "neutral", 0 );
    
    if ( isbrgamemode() )
    {
        weaponname = isdefined( level.equipment.table[ "equip_butterfly_mine" ] ) && isdefined( level.equipment.table[ "equip_butterfly_mine" ].bundle.useweapon ) ? level.equipment.table[ "equip_butterfly_mine" ].bundle.useweapon : "butterfly_mine_mp";
        self radiusdamage( self.origin, self.explosionradius, self.maxdmg, self.mindmg, self.owner, "MOD_EXPLOSIVE", weaponname );
        self setscriptablepartstate( "explode", "fromPlayerBR", 0 );
    }
    else
    {
        self setscriptablepartstate( "explode", statestring, 0 );
    }
    
    challenges::function_3d7a169dbae062fb( "equip_butterfly_mine", self.sourcegrenade.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
}

// Namespace butterfly_mine
// Params 2
// Checksum 0xaff494b9, Offset: 0x1310
// Size: 0x1f
function function_96e298b6ed03eccb( vehicle, mine )
{
    mine thread function_2f8a1ae87d5a5cd0( vehicle );
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x77e57462, Offset: 0x1337
// Size: 0x37
function butterfly_mine_destroy( attacker )
{
    thread butterfly_mine_delete( 5 );
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "destroy", "active", 0 );
}

// Namespace butterfly_mine
// Params 0
// Checksum 0x1848f61d, Offset: 0x1376
// Size: 0x34
function function_b7f2150a0cbd0b8c()
{
    thread butterfly_mine_delete( 1, 1 );
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "arm", "neutral", 0 );
        self setscriptablepartstate( "visibility", "hide", 0 );
    }
}

// Namespace butterfly_mine
// Params 2
// Checksum 0x70813625, Offset: 0x13b2
// Size: 0x14a
function butterfly_mine_delete( deletiondelay, var_a66d24074bd20f1b )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"death" );
    self setcandamage( 0 );
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    self.headiconid = undefined;
    
    if ( isdefined( var_a66d24074bd20f1b ) )
    {
        if ( var_a66d24074bd20f1b )
        {
            self.exploding = 0;
        }
    }
    else
    {
        self.exploding = 1;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    if ( isdefined( self.sourcegrenade ) )
    {
        if ( isdefined( self.sourcegrenade.ownedmines ) )
        {
            self.sourcegrenade.ownedmines = arrayremove( self.sourcegrenade.ownedmines, self );
        }
    }
    
    weapon::deregistermine();
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    ent_manager::deregisterspawn();
    
    if ( isdefined( self.sourcegrenade ) )
    {
        if ( self.sourcegrenade.ownedmines.size == 0 )
        {
            self.sourcegrenade function_3ad11a42dd9cf271();
        }
    }
    
    self delete();
}

// Namespace butterfly_mine
// Params 0
// Checksum 0xa3e7c4b5, Offset: 0x1504
// Size: 0x95
function function_3ad11a42dd9cf271()
{
    if ( isdefined( self.ownedmines ) )
    {
        foreach ( mine in self.ownedmines )
        {
            mine thread function_b7f2150a0cbd0b8c();
        }
    }
    
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace butterfly_mine
// Params 0
// Checksum 0xd2b742f4, Offset: 0x15a1
// Size: 0x95
function function_3cf62952a9d79766()
{
    if ( isdefined( self.ownedmines ) )
    {
        foreach ( mine in self.ownedmines )
        {
            mine thread butterfly_mine_destroy();
        }
    }
    
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x8907c186, Offset: 0x163e
// Size: 0xd4
function butterfly_mine_handle_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    
    if ( utility::isbulletdamage( meansofdeath ) )
    {
        if ( isdefined( objweapon ) )
        {
            hits = 1;
            
            if ( damage >= weapons::minegettwohitthreshold() )
            {
                hits += 1;
            }
            
            if ( damage::isfmjdamage( objweapon, meansofdeath ) )
            {
                hits *= 2;
            }
            
            damage = hits * 5;
        }
    }
    else if ( function_e5e9f6441583ca59( meansofdeath ) )
    {
        damage = 1;
    }
    
    weapons::equipmenthit( self.owner, attacker, objweapon, meansofdeath );
    return damage;
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x94d9c08, Offset: 0x171b
// Size: 0x57
function function_e5e9f6441583ca59( meansofdeath )
{
    switch ( meansofdeath )
    {
        case #"hash_66cb246f3e55fbe2":
        case #"hash_b1078ff213fddba6":
        case #"hash_c22b13f81bed11f0":
        case #"hash_d8646db4e6ee3658":
            return 1;
        default:
            return 0;
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x38336c18, Offset: 0x177a
// Size: 0xc8
function function_9a47728012b42b3f( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) )
    {
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            if ( !self.sourcegrenade.givenscore )
            {
                attacker equipment_mp::function_ada7da3083a6c593( self, data.objweapon );
                self.sourcegrenade.givenscore = 1;
            }
        }
        
        if ( utility::isbulletdamage( data.meansofdeath ) || function_e5e9f6441583ca59( data.meansofdeath ) )
        {
            thread function_84b17b71973aa385( self.sourcegrenade, self.origin );
        }
    }
    
    thread butterfly_mine_destroy();
}

// Namespace butterfly_mine
// Params 2
// Checksum 0xce86f763, Offset: 0x184a
// Size: 0x12c
function function_84b17b71973aa385( sourcegrenade, previousexplosionpoint )
{
    wait 0.35;
    closestmine = self;
    closestdistsqr = 250000;
    minesinrange = 0;
    
    if ( isdefined( sourcegrenade ) && isdefined( sourcegrenade.ownedmines ) )
    {
        foreach ( mine in sourcegrenade.ownedmines )
        {
            if ( !isdefined( mine ) )
            {
                continue;
            }
            
            if ( mine == self )
            {
                continue;
            }
            
            thisdistsqr = distancesquared( mine.origin, previousexplosionpoint );
            
            if ( thisdistsqr < closestdistsqr )
            {
                closestmine = mine;
                closestdistsqr = thisdistsqr;
                minesinrange = 1;
            }
        }
    }
    
    if ( minesinrange )
    {
        closestmine thread function_84b17b71973aa385( sourcegrenade, closestmine.origin );
        closestmine thread butterfly_mine_destroy();
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0xc738463c, Offset: 0x197e
// Size: 0x9e
function butterfly_mine_empapplied( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( !self.sourcegrenade.givenscore )
        {
            attacker killstreaks::givescoreforequipment( self, undefined, 1 );
            self.sourcegrenade.givenscore = 1;
        }
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    thread butterfly_mine_destroy();
}

// Namespace butterfly_mine
// Params 0
// Checksum 0x5335ef33, Offset: 0x1a24
// Size: 0x21
function butterfly_mine_watch_cleanup()
{
    self endon( #"death" );
    function_566087b713c9448c();
    
    if ( isdefined( self ) )
    {
        thread butterfly_mine_destroy();
    }
}

// Namespace butterfly_mine
// Params 0
// Checksum 0xebc12732, Offset: 0x1a4d
// Size: 0x53
function function_566087b713c9448c()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
    }
}

// Namespace butterfly_mine
// Params 0
// Checksum 0x3c5909a7, Offset: 0x1aa8
// Size: 0x27
function function_da2c7f8b3acda973()
{
    self endon( #"death" );
    self waittill( #"hash_48859e1eba4d25f" );
    
    if ( isdefined( self ) )
    {
        thread butterfly_mine_destroy();
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x19595673, Offset: 0x1ad7
// Size: 0x41
function butterfly_mine_haywire( data )
{
    if ( self.isexploding )
    {
        return 0;
    }
    
    if ( isdefined( data.attacker ) )
    {
        self setentityowner( data.attacker );
    }
    
    thread butterfly_mine_destroy();
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x2e96f3f0, Offset: 0x1b20
// Size: 0x3b
function butterfly_mine_empstarted( data )
{
    if ( isdefined( self ) && !self.isexploding )
    {
        self.isdisabled = 1;
        self setscriptablepartstate( "empd", "active", 0 );
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0xfa56d40d, Offset: 0x1b63
// Size: 0x3a
function butterfly_mine_empcleared( data )
{
    if ( isdefined( self ) || !self.isexploding )
    {
        self.isdisabled = undefined;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace butterfly_mine
// Params 2
// Checksum 0x20fd1bd0, Offset: 0x1ba5
// Size: 0x3d
function function_4d2fa144de682a68( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace butterfly_mine
// Params 2
// Checksum 0x90ec349, Offset: 0x1beb
// Size: 0xeb
function function_14f4aa494c7b7509( inflictor, attacker )
{
    victim = self;
    
    if ( isdefined( victim.perks[ "specialty_tac_resist" ] ) || isdefined( victim.perks[ "specialty_tac_resist_br" ] ) )
    {
        return;
    }
    
    victim notify( #"hash_e54fe848d3100562" );
    bundle = inflictor.sourcegrenade.bundle;
    
    if ( isdefined( bundle ) && bundle.var_99c12fab558bb2d )
    {
        if ( isdefined( bundle.var_902c46565e123954 ) )
        {
            time = getdvarfloat( @"hash_32be7e91632bbd2c", bundle.var_902c46565e123954 );
        }
        else
        {
            time = getdvarfloat( @"hash_32be7e91632bbd2c", 3 );
        }
        
        attacker thread perkfunctions::ammodisabling_run( victim, 0, time );
        victim thread function_c5ad9a4c1172ae48( time );
    }
}

// Namespace butterfly_mine
// Params 1, eflags: 0x4
// Checksum 0xbd19acdc, Offset: 0x1cde
// Size: 0x88
function private function_c5ad9a4c1172ae48( timer )
{
    victim = self;
    victim endon( #"hash_e54fe848d3100562" );
    victim endon( #"death_or_disconnect" );
    victim thread function_9895196317ca0515( timer );
    
    if ( level.var_aec6e5502dfcb566 )
    {
        frequency = 1;
        
        while ( isalive( victim ) && timer > 0 )
        {
            self function_2c28e7684376dcc6( "vsp_fall" );
            self function_190b2e3379f9a500( "vsp_fall" );
            wait frequency;
            timer -= frequency;
        }
    }
}

// Namespace butterfly_mine
// Params 1, eflags: 0x4
// Checksum 0xc3d9d545, Offset: 0x1d6e
// Size: 0x7c
function private function_9895196317ca0515( timer )
{
    self endon( #"hash_e54fe848d3100562" );
    self endon( #"death_or_disconnect" );
    
    if ( utility::isusingremote() )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        self enableplayerbreathsystem( 0 );
        wait 1;
        
        while ( timer > 0 && isalive( self ) )
        {
            self playlocalsound( "plr_breath_pain_init" );
            timer -= 1.7;
            wait 1.7;
        }
        
        wait 0.5;
        self enableplayerbreathsystem( 1 );
    }
}

// Namespace butterfly_mine
// Params 1
// Checksum 0x2ecc35f3, Offset: 0x1df2
// Size: 0x1b0
function butterfly_mine_onownerchanged( oldowner )
{
    if ( self.exploding )
    {
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( isdefined( self.ownedmines ) )
        {
            foreach ( submine in self.ownedmines )
            {
                submine.owner = self.owner;
                submine.team = self.owner.team;
                submine.ownerid = self.owner getxuid();
                submine setentityowner( self.owner );
                submine setotherent( self.owner );
                
                if ( isdefined( submine.dangerzone ) )
                {
                    spawnlogic::removespawninfluencer( submine.dangerzone );
                    submine.dangerzone = undefined;
                }
                
                submine.dangerzone = spawnlogic::addspawninfluencer( #"equipment_mine", submine.origin, submine.owner.team );
                
                if ( level.teambased )
                {
                    submine filteroutplayermarks( self.owner.team );
                    continue;
                }
                
                submine filteroutplayermarks( self.owner );
            }
        }
    }
}

