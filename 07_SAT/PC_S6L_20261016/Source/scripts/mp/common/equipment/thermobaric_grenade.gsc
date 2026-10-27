// scripts\mp\common\equipment\thermobaric_grenade.gsc  (hash_4f6dcf0779e7f2f2.gscc) (size: 10352 Bytes / 0x2870 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b539fc (162871804)
// size ...... 10352 (0x2870)
// includes .. 11  (offset: 0x26d8)
// strings ... 23  (offset: 0x2730)
// dev strs .. 0   (offset: 0x2870)
// exports ... 18  (offset: 0x1a6c)
// cseg ...... 0x233 + 0x1839 (0x1a6c)
// imports ... 77  (offset: 0x1d3c)
// animtree1 . 0   (offset: 0x2870)
// animtree2 . 0   (offset: 0x2870)
#using script_13865ca76df87ea;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace thermobaric_grenade;

// Namespace thermobaric_grenade
// Params 0, eflags: 0x1
// Checksum 0x1a10b1ab, Offset: 0x251
// Size: 0xba
function autoexec main()
{
    utility::registersharedfunc( #"thermobaric_grenade", #"thermobaric_grenade_used", &thermobaric_grenade_used );
    utility::registersharedfunc( #"thermobaric_grenade", #"thermobaric_shellshock_interrupt_delay", &thermobaric_shellshock_interrupt_delay );
    utility::registersharedfunc( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage", &thermobaric_additional_explosive_damage );
    utility::registersharedfunc( #"thermobaric_grenade", #"thermobaric_grenade_init", &thermobaric_grenade_init );
    utility::registersharedfunc( #"thermobaric_grenade", #"thermobaric_grenade_get_onplayerdamaged", &thermobaric_grenade_get_onplayerdamaged );
    weapons::registerusedcallback( "thermobaric_grenade", &thermobaric_grenade_used );
    weapons::registeragentusedcallback( "thermobaric_grenade", &thermobaric_grenade_used );
}

// Namespace thermobaric_grenade
// Params 0
// Checksum 0xe0b5d2c0, Offset: 0x313
// Size: 0xaf
function thermobaric_grenade_init()
{
    if ( !equipment_mp::function_ae4237ff60a6e452( "equip_thermobaric_grenade" ) )
    {
        return;
    }
    
    equipmenttable = equipment_mp::getequipmenttableinfo( "equip_thermobaric_grenade" );
    
    if ( isdefined( equipmenttable.bundle.var_473476caf27c6703 ) )
    {
        utility::add_fx( "thermobaric_explosion_ground", equipmenttable.bundle.var_473476caf27c6703 );
    }
    
    if ( isdefined( equipmenttable.bundle.var_cb6afa7d55ef3c22 ) )
    {
        utility::add_fx( "thermobaric_explosion_air", equipmenttable.bundle.var_cb6afa7d55ef3c22 );
    }
    
    namespace_de7b719e85d98dcc::function_2cc937b1eb09aabb( equipmenttable.bundle );
}

// Namespace thermobaric_grenade
// Params 2
// Checksum 0x577ab606, Offset: 0x3ca
// Size: 0x489
function thermobaric_grenade_init_params( grenade, bundle )
{
    level.thermobaric_weapon_ref = grenade.weapon_name;
    level.var_21868dbe26f4957e = grenade.weapon_object.basenamehash;
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_object.basenamehash );
    equipment_utility::function_2d044a0367c41bbf( level.thermobaric_weapon_ref, #"do_stun", @"thermobaric_do_stun", bundle.do_stun, 1 );
    equipment_utility::function_2d044a0367c41bbf( level.thermobaric_weapon_ref, #"hash_b52d0dd2ab9ca8fb", @"hash_9823776fa6f2b6bd", bundle.var_5793209a07503d90, 1 );
    equipment_utility::function_2d044a0367c41bbf( level.thermobaric_weapon_ref, #"do_fire", @"thermobaric_do_fire", bundle.do_fire, 1 );
    equipment_utility::function_2d044a0367c41bbf( level.thermobaric_weapon_ref, #"hash_3561a8bad495bd9f", @"hash_82eeaa9e860b9595", bundle.var_ee02c9810fc3e8ae, 1 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"stun_time_min", @"thermobaric_stun_time_min", bundle.stun_time_min, 1.5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"stun_time_max", @"thermobaric_stun_time_max", bundle.stun_time_max, 2.5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_8018351b231b05ca", @"hash_a880efcc3e0951f9", bundle.var_e30512b73518ab9, 0.5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_469e0c07d101aa90", @"hash_229530fdb1a3e9f2", bundle.var_38a0eb8e47016c65, 0.75 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_e6153cc1a9d834d6", @"hash_986c99cc9347e974", bundle.var_684a1223fe71bd3f, 0.5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_6ce1773bbe616b11", @"hash_739c7df4562556b7", bundle.var_96787ced0a7da800, 0.25 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_fd943806d8f5c319", @"hash_ad13e849de08290f", bundle.var_213cd1018a22725a, 5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_a02f369aef3c6b3b", @"hash_444197ac5856ef55", bundle.var_f0911c96f6fcb976, 20 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"fire_impact_angle", @"thermobaric_fire_impact_angle", bundle.fire_impact_angle, 75 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"fire_impact_velocity", @"thermobaric_fire_impact_velocity", bundle.fire_impact_velocity, 50 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_d98d6e38f81f7c43", @"hash_11e932953e047b51", bundle.var_8758deab14a534b6, 5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_d511323888718c", @"hash_814d7e5d855a1936", bundle.var_17f492e2cd4f96d1, 10 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_99081da968d2dc99", @"hash_bfa2cab0f930aa5b", bundle.var_7653932f12fb2804, 15 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_409cbd0f5f8928d8", @"hash_ab38be00deb0ffba", bundle.var_39784c997c206ff, 1 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"hash_a8a98335d9870657", @"hash_4bf79f13ab850b71", bundle.var_a9c9581ed0ef9b20, 1 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"burnbundle_time_interval", @"thermobaric_burnbundle_time_interval", bundle.burnbundle_time_interval, 0.5 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"burnbundle_min_duration", @"thermobaric_burnbundle_min_duration", bundle.burnbundle_min_duration, 4 );
    equipment_utility::function_19ac700f043604( level.thermobaric_weapon_ref, #"burnbundle_max_duration", @"thermobaric_burnbundle_max_duration", bundle.burnbundle_max_duration, 4.25 );
}

// Namespace thermobaric_grenade
// Params 0
// Checksum 0x7ccad301, Offset: 0x85b
// Size: 0x7
function thermobaric_grenade_get_onplayerdamaged()
{
    return &onplayerdamaged;
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0xb52cd449, Offset: 0x86b
// Size: 0x47b
function thermobaric_grenade_used( grenade )
{
    level endon( #"game_ended" );
    grenade endon( #"death" );
    childthread thermobaric_watchownerdisconnect( grenade );
    thermobaric_grenade_init_params( grenade );
    blueprintindex = grenade.weapon_object.variantid;
    
    if ( !isdefined( blueprintindex ) )
    {
        blueprintindex = 0;
    }
    
    tableinfo = weapon::getequipmenttableinfo( "equip_thermobaric_grenade" );
    bundle = tableinfo.bundle;
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    
    if ( isdefined( genericblueprintname ) )
    {
        grenade setgenericblueprint( genericblueprintname );
    }
    
    if ( grenade.ticks >= 1 )
    {
        grenade.iscooked = 1;
    }
    
    gunangle = grenade.owner getgunangles();
    gunforward = anglestoforward( gunangle );
    thermobaricweaponname = grenade.weapon_name;
    var_7fc4c0389b0d514 = 0;
    
    if ( var_7fc4c0389b0d514 )
    {
        hintscriptable( "equip_thermobaric_pool_mp_p", grenade.spawnpos, 5000 );
        thread function_adfe97cac0db1983( gunforward, thermobaricweaponname, undefined, bundle, blueprintindex, grenade );
    }
    
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_object.basenamehash );
    ignitiondelay = bundle.var_e8e1c3a4ebc685cc ?? 0;
    scriptableref = bundle.thermobaric_scriptable ?? "equip_thermobaric_pool_mp_p";
    heightoffset = bundle.var_3414395f45d6ab92 ?? 0;
    maxradius = bundle.var_306a2fba80f5d9e4 ?? 0;
    damagedelay = bundle.var_62deefeb30d8595 ?? 0;
    mindamage = bundle.var_98b95dff64806b45 ?? 0;
    maxdamage = bundle.var_35d8021c44476be3 ?? 0;
    grenade forcehidegrenadehudwarning( 1 );
    hintscriptable( scriptableref, grenade.spawnpos, 5000 );
    var_2096094c4703a515 = grenade utility::waittill_any_return_params_or_timeout( utility::function_6f5d2e1f1ff70482( getgrenadefusetime( grenade.weapon_name ) ), "missile_water_impact", "swallowed", "instant_explode" );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    grenade hide( 1 );
    explosionorigin = grenade.origin + ( 0, 0, heightoffset );
    scriptable = spawnscriptable( scriptableref, explosionorigin, ( 0, randomintrange( 0, 360 ), 0 ) );
    movingplatformcheck = spawnstruct();
    movingplatformcheck.origin = explosionorigin;
    movingplatformcheck.angles = ( 0, 0, 0 );
    movingplatforminfo = movingplatformcheck utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo.groundent ) )
    {
        scriptable utility::scriptable_setparententity( movingplatforminfo.groundent );
    }
    
    hitwater = var_2096094c4703a515[ "message" ] == "missile_water_impact";
    b_swallowed = var_2096094c4703a515[ "message" ] == "swallowed";
    var_29ef996162898445 = var_2096094c4703a515[ "message" ] == "instant_explode";
    scriptable utility::delaycall( ignitiondelay + damagedelay + 2, &freescriptable );
    
    if ( !var_29ef996162898445 )
    {
        if ( b_swallowed )
        {
            scriptable setscriptablepartstate( #"effects", #"explodeswallowed" );
        }
        else
        {
            scriptable setscriptablepartstate( #"effects", hitwater ? #"explodegaswater" : #"explodegas" );
        }
        
        grenade forcehidegrenadehudwarning( 0 );
        wait ignitiondelay;
    }
    
    if ( isdefined( scriptable ) )
    {
        if ( b_swallowed )
        {
            scriptable setscriptablepartstate( #"effects", #"explodeswallowedignite" );
        }
        else
        {
            scriptable setscriptablepartstate( #"effects", hitwater ? #"explodegasignitewater" : #"explodegasignite" );
        }
        
        thermobaric_scriptable_origin = scriptable.origin;
    }
    
    if ( !var_29ef996162898445 )
    {
        wait damagedelay;
    }
    
    if ( isdefined( grenade ) )
    {
        grenade forcehidegrenadehudwarning( 1 );
        
        if ( thermobaric_scriptable_origin )
        {
            grenade radiusdamage( thermobaric_scriptable_origin - ( 0, 0, heightoffset ), maxradius, maxdamage, mindamage, grenade.owner, "MOD_EXPLOSIVE", makeweapon( thermobaricweaponname ) );
        }
        
        grenade delete();
    }
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0xf2fea251, Offset: 0xcee
// Size: 0x2f
function thermobaric_watchownerdisconnect( grenade )
{
    self waittill( #"disconnect" );
    
    if ( isdefined( grenade ) )
    {
        grenade forcehidegrenadehudwarning( 1 );
        grenade delete();
    }
}

// Namespace thermobaric_grenade
// Params 6
// Checksum 0x51a9df1, Offset: 0xd25
// Size: 0x1e3, Type: bool
function function_adfe97cac0db1983( gunforward, thermobaricweaponname, forceteam, bundle, blueprintindex, grenade )
{
    grenade waittill( #"explode", position );
    objweapon = grenade.weapon_object;
    groundposition = getgroundposition( position, 5 );
    istouchingground = distancesquared( position, groundposition ) <= squared( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_a02f369aef3c6b3b" ) );
    function_91aff4621ef9f06d( istouchingground, position, bundle, blueprintindex );
    
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"do_fire" ) == 1 && istouchingground && utility::issharedfuncdefined( #"molotov", #"molotov_simulate_impact" ) )
    {
        blueprintdefindex = namespace_de7b719e85d98dcc::function_5bf49f3d5bab75bc( bundle, blueprintindex );
        thread thermobaric_fire( gunforward, groundposition, blueprintdefindex, objweapon );
    }
    
    explosionradius = getgrenadedamageradius( thermobaricweaponname );
    agents = getaiarrayinradius( position, explosionradius );
    var_d2057df950688685 = isdefined( forceteam ) ? self.team : forceteam;
    
    foreach ( agent in agents )
    {
        if ( agent utility::function_92f6c5dd7f8b6166( "thermobaric", var_d2057df950688685 ) || agent.team == var_d2057df950688685 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace thermobaric_grenade
// Params 4
// Checksum 0x990e597, Offset: 0xf11
// Size: 0x77
function function_91aff4621ef9f06d( istouchingground, position, bundle, blueprintindex )
{
    if ( istouchingground )
    {
        if ( isdefined( bundle.var_473476caf27c6703 ) )
        {
            namespace_de7b719e85d98dcc::genericblueprint_playfx( bundle, blueprintindex, #"ground_explosion", position );
        }
        
        return;
    }
    
    if ( isdefined( bundle.var_cb6afa7d55ef3c22 ) )
    {
        namespace_de7b719e85d98dcc::genericblueprint_playfx( bundle, blueprintindex, #"air_explosion", position );
    }
}

// Namespace thermobaric_grenade
// Params 4
// Checksum 0xbfb9dafe, Offset: 0xf90
// Size: 0x137
function thermobaric_fire( gunforward, groundposition, blueprintdefindex, objweapon )
{
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( level.var_21868dbe26f4957e );
    damagedelay = bundle.var_62deefeb30d8595 ?? 0;
    wait damagedelay;
    worldup = ( 0, 0, 1 );
    right = vectorcross( gunforward, worldup );
    forward = vectorcross( right, worldup );
    angles = axistoangles( forward, right, worldup );
    angles = ( angles[ 0 ], angles[ 1 ], 0 );
    velocity = rotatepointaroundvector( right, forward, equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"fire_impact_angle" ) ) * equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"fire_impact_velocity" );
    firesource = thermobaric_make_fire_source( angles, groundposition, blueprintdefindex, objweapon );
    [[ utility::getsharedfunc( #"molotov", #"molotov_simulate_impact" ) ]]( firesource, groundposition, angles, undefined, velocity, gettime(), "equip_thermobaric_pool_mp_p" );
}

// Namespace thermobaric_grenade
// Params 4
// Checksum 0xfca1b983, Offset: 0x10cf
// Size: 0x280
function thermobaric_make_fire_source( angles, position, blueprintdefindex, objweapon )
{
    firesource = spawn( "script_origin", position );
    firesource.targetname = "thermobaric_make_fire_source";
    firesource.angles = angles;
    firesource.owner = self;
    firesource.team = self.team;
    firesource.script_noteworthy = "thermobaric_fire";
    firesource.weapon_name = level.thermobaric_weapon_ref;
    firesource.blueprintdefindex = blueprintdefindex;
    firesource.var_5b038f631de3ad97 = spawnstruct();
    firesource.var_5b038f631de3ad97.var_c3f25b11c2247a29 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_d98d6e38f81f7c43" );
    firesource.var_5b038f631de3ad97.var_78880e1476d45684 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_d511323888718c" );
    firesource.var_5b038f631de3ad97.var_7ceb375188b38c13 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_99081da968d2dc99" );
    firesource.var_5b038f631de3ad97.var_209153533613c440 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_409cbd0f5f8928d8" );
    firesource.var_5b038f631de3ad97.var_726e9b33a65af54f = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_a8a98335d9870657" );
    firesource.var_5b038f631de3ad97.var_29dd3c8b7a515774 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"burnbundle_time_interval" );
    firesource.var_5b038f631de3ad97.var_17b6db336154419b = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"burnbundle_min_duration" );
    firesource.var_5b038f631de3ad97.flamemaxduration = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"burnbundle_max_duration" );
    firesource.var_5b038f631de3ad97.means_of_death = "MOD_FIRE";
    firesource.var_5b038f631de3ad97.useweapon = objweapon;
    firesource.var_5b038f631de3ad97.var_35807474702938c6 = 1;
    return firesource;
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0x39b4a148, Offset: 0x1358
// Size: 0x21b, Type: bool
function onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    if ( !isdefined( data.inflictor ) && data.meansofdeath == "MOD_SUICIDE" )
    {
        return true;
    }
    else if ( !isdefined( data.inflictor ) )
    {
        return false;
    }
    
    if ( data.inflictor.script_noteworthy == "thermobaric_fire" )
    {
        return true;
    }
    
    victim = data.victim;
    attacker = data.attacker;
    point = data.point;
    explosionradius = getgrenadedamageradius( data.objweapon.basename );
    var_a825f236b03e1009 = explosionradius * equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_e6153cc1a9d834d6" );
    
    if ( isdefined( attacker ) )
    {
        var_b660048a0793257a = attacker == victim;
    }
    else
    {
        var_b660048a0793257a = 0;
    }
    
    /#
        if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
        {
            var_b660048a0793257a = 0;
        }
    #/
    
    if ( var_b660048a0793257a && distance( point, victim.origin ) > var_a825f236b03e1009 )
    {
        return true;
    }
    
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"do_stun" ) == 1 )
    {
        victim function_c792573b8d7ef5e( data.inflictor, attacker, explosionradius, var_b660048a0793257a );
    }
    
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_b52d0dd2ab9ca8fb" ) == 1 )
    {
        victim thread function_c9ac53995a06e4ae( attacker );
    }
    
    if ( isdefined( attacker ) && utility::issharedfuncdefined( #"pers", #"incpersstat" ) )
    {
        attacker [[ utility::getsharedfunc( #"pers", #"incpersstat" ) ]]( "thermobaricGrenadeHits", 1 );
    }
    
    data.victim thread damage_effects::enableburnfxfortime( 0.5 );
    return true;
}

// Namespace thermobaric_grenade
// Params 3
// Checksum 0x35768fa6, Offset: 0x157c
// Size: 0x10f
function function_44fd750b638fbc4a( attacker, explosionpos, explosionradius )
{
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_b52d0dd2ab9ca8fb" ) == 1 )
    {
        thread function_c9ac53995a06e4ae( attacker );
    }
    
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"do_stun" ) == 1 )
    {
        stuntimemin = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"stun_time_min" );
        stuntimemax = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"stun_time_max" );
        scale = clamp( 1 - distance( self.origin, explosionpos ) / explosionradius, 0, 1 );
        scalevalue = stuntimemax - stuntimemin;
        time = stuntimemin + scalevalue * scale;
        self notify( #"flashbang", self.origin, 1, 1, attacker, "axis", time );
    }
}

// Namespace thermobaric_grenade
// Params 4
// Checksum 0x6003817f, Offset: 0x1693
// Size: 0x177
function function_c792573b8d7ef5e( einflictor, eattacker, explosionradius, var_b660048a0793257a )
{
    if ( utility::isusingremote() )
    {
        return;
    }
    
    if ( self.concussionimmune )
    {
        return;
    }
    
    if ( !val::get( "stunned" ) )
    {
        return;
    }
    
    stuntimemin = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"stun_time_min" );
    stuntimemax = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"stun_time_max" );
    var_4b5891e4ae10c740 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_469e0c07d101aa90" );
    scale = clamp( 1 - distance( self.origin, einflictor.origin ) / explosionradius, 0, 1 );
    scalevalue = stuntimemax - stuntimemin;
    time = stuntimemin + scalevalue * scale;
    
    if ( var_b660048a0793257a )
    {
        time *= var_4b5891e4ae10c740;
    }
    
    if ( utility::issharedfuncdefined( #"specialty_stun_resistance", #"applystunresistence" ) )
    {
        time = [[ utility::getsharedfunc( #"specialty_stun_resistance", #"applystunresistence" ) ]]( eattacker, self, time );
    }
    
    utility::setplayerstunned();
    thread weapon_utility::cleanupconcussionstun( time );
    shellshock_utility_cpmp::_shellshock( %"thermobaric_grenade", #"stun", time, 1 );
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0x106d3476, Offset: 0x1812
// Size: 0xd4
function function_c9ac53995a06e4ae( thermobaricowner )
{
    waittillframeend();
    
    if ( equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_3561a8bad495bd9f" ) == 1 && isdefined( self.perks[ "specialty_blastshield" ] ) )
    {
        return;
    }
    
    var_e2c540e6d4a51614 = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_6ce1773bbe616b11" );
    var_2e396fc50c3c5c2e = equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_fd943806d8f5c319" );
    self.var_adcd3cbd776a306f = spawnstruct();
    self.var_adcd3cbd776a306f.value = var_e2c540e6d4a51614;
    self.var_adcd3cbd776a306f.owner = thermobaricowner;
    self notify( #"hash_c18a0047abb03a26" );
    thread function_201133d41e95df3f( var_2e396fc50c3c5c2e );
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0x7f7d111b, Offset: 0x18ee
// Size: 0x30
function function_201133d41e95df3f( waittime )
{
    self endon( #"hash_c18a0047abb03a26" );
    utility::waittill_any_timeout( waittime, "death_or_disconnect" );
    self.var_adcd3cbd776a306f = undefined;
}

// Namespace thermobaric_grenade
// Params 3
// Checksum 0x33697e51, Offset: 0x1926
// Size: 0x115
function thermobaric_additional_explosive_damage( victim, attacker, damage )
{
    if ( !isdefined( victim.var_adcd3cbd776a306f ) || victim.var_adcd3cbd776a306f.value == 0 )
    {
        return 0;
    }
    else if ( isplayer( victim.var_adcd3cbd776a306f.owner ) )
    {
        victim.var_adcd3cbd776a306f.owner damagefeedback::updatedamagefeedback( "thermobaricexplosiveboost" );
        
        if ( victim.var_adcd3cbd776a306f.owner != attacker && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            victim.var_adcd3cbd776a306f.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"thermobaric_explosive_assist" );
        }
        
        return ( damage * victim.var_adcd3cbd776a306f.value );
    }
    
    return 0;
}

// Namespace thermobaric_grenade
// Params 1
// Checksum 0xe789a740, Offset: 0x1a44
// Size: 0x27
function thermobaric_shellshock_interrupt_delay( duration )
{
    return equipment_utility::function_ba332b3b54d2a9c4( level.thermobaric_weapon_ref, #"hash_8018351b231b05ca" ) * duration;
}

