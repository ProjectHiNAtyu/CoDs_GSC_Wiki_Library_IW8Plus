// scripts\mp\crossbow.gsc  (hash_115d1fad3b173502.gscc) (size: 23626 Bytes / 0x5c4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb441d702 (3024213762)
// size ...... 23626 (0x5c4a)
// includes .. 8   (offset: 0x577a)
// strings ... 78  (offset: 0x57ba)
// dev strs .. 1   (offset: 0x5c3e)
// exports ... 88  (offset: 0x3546)
// cseg ...... 0x76c + 0x2dda (0x3546)
// imports ... 168 (offset: 0x4306)
// animtree1 . 0   (offset: 0x5c4a)
// animtree2 . 0   (offset: 0x5c4a)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;

#namespace crossbow;

// Namespace crossbow
// Params 1
// Checksum 0x2338fc9, Offset: 0x78a
// Size: 0x9b
function initcrossbowusage( weapon )
{
    if ( !isdefined( level.crossbowbolts ) )
    {
        level.crossbowbolts = [];
    }
    
    if ( !isdefined( self.crossbow ) )
    {
        self.crossbow = spawnstruct();
        self.crossbow.boltnumber = 0;
        self.crossbow.boltsinflight = [];
    }
    
    utility::registersharedfunc( #"crossbow", #"boltunlink", &boltunlink );
    self.crossbow.active = 1;
}

// Namespace crossbow
// Params 1
// Checksum 0x62f56d24, Offset: 0x82d
// Size: 0x4e
function crossbowusageloop( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"end_launcher" );
    ammotype = getcrossbowammotype( weapon );
    thread crossbowimpactwatcher( weapon, ammotype );
}

// Namespace crossbow
// Params 0
// Checksum 0xb60f35cb, Offset: 0x883
// Size: 0x25
function cleanupafterweaponswitch()
{
    self waittill( #"end_launcher" );
    function_3becd532a834f345();
    wait 6;
    self notify( #"hash_68a1109f2f46b0f3" );
}

// Namespace crossbow
// Params 2
// Checksum 0x393db15, Offset: 0x8b0
// Size: 0x5d
function crossbowimpactwatcher( watcherweapon, ammotype )
{
    self notify( #"hash_68a1109f2f46b0f3" );
    self endon( #"disconnect" );
    self endon( #"hash_68a1109f2f46b0f3" );
    childthread cleanupafterweaponswitch();
    childthread watchforimpact( watcherweapon, ammotype );
    childthread function_682bdd7e31c2ddd1( watcherweapon );
    childthread function_beeff12dd0a9589e( watcherweapon, ammotype );
}

// Namespace crossbow
// Params 2
// Checksum 0x3931b468, Offset: 0x915
// Size: 0x10a
function watchforimpact( watcherweapon, ammotype )
{
    crossbowimpactfunc = getcrossbowimpactfunc( ammotype );
    
    while ( true )
    {
        self waittill( #"bullet_first_impact", impacts );
        
        if ( watcherweapon != impacts[ 0 ].weapon )
        {
            continue;
        }
        
        bolt = spawncrossbowbolt( impacts[ 0 ].hitpos, impacts[ 0 ].hitdir, ammotype, impacts[ 0 ].weapon );
        handleimpact( bolt, impacts[ 0 ].hitent, impacts[ 0 ].hitentpart, impacts[ 0 ].hitloc, impacts[ 0 ].surfacenormal, impacts[ 0 ].surfacetype, impacts[ 0 ].weapon, impacts[ 0 ].hitdir, impacts[ 0 ].hitpos, crossbowimpactfunc );
    }
}

// Namespace crossbow
// Params 2
// Checksum 0x7924a957, Offset: 0xa27
// Size: 0x86
function function_beeff12dd0a9589e( watcherweapon, ammotype )
{
    var_1128637eb0714e2a = function_89994eb37340c2a6( ammotype );
    
    while ( true )
    {
        self waittill( #"bullet_terminated", weapon, bulletdir, var_d6cddc63cc5fd962 );
        
        if ( watcherweapon != weapon )
        {
            continue;
        }
        
        bolt = spawncrossbowbolt( var_d6cddc63cc5fd962, bulletdir, ammotype, weapon );
        function_9d6d68a8ef5cf3be( bolt, var_1128637eb0714e2a );
    }
}

// Namespace crossbow
// Params 10
// Checksum 0x5727f017, Offset: 0xab5
// Size: 0xd5
function handleimpact( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, crossbowimpactfunc )
{
    if ( shouldreflect( surfacetype, bolt, hitent, hitentpart, weapon ) )
    {
        reflectbolt( bolt, surfacenormal, bulletdir, impactpos );
    }
    else if ( shoulddeleteimmediately( hitent, weapon ) )
    {
        bolt delete();
        return;
    }
    else if ( shoulddrop( hitent, hitloc ) )
    {
        dropbolt( bolt );
    }
    else if ( shouldlink( hitent ) )
    {
        function_6db52ce8e25a40a5( bolt, hitent, hitentpart );
    }
    
    if ( isdefined( crossbowimpactfunc ) )
    {
        [[ crossbowimpactfunc ]]( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype );
    }
}

// Namespace crossbow
// Params 2
// Checksum 0xffa16cee, Offset: 0xb92
// Size: 0x21
function function_9d6d68a8ef5cf3be( bolt, var_1128637eb0714e2a )
{
    if ( isdefined( var_1128637eb0714e2a ) )
    {
        [[ var_1128637eb0714e2a ]]( bolt );
    }
}

// Namespace crossbow
// Params 6
// Checksum 0x9ffde354, Offset: 0xbbb
// Size: 0x150
function impactfunc_explo( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype )
{
    bolt setscriptablepartstate( "effects", "impact" );
    
    if ( isdefined( hitent ) && ( isplayer( hitent ) || isagent( hitent ) ) )
    {
        fusetime = 1.1;
    }
    else
    {
        fusetime = 2;
    }
    
    objweapon = makeweapon( "semtex_bolt_mp" );
    
    if ( objweapon.basename != "none" )
    {
        bolt.grenade = magicgrenademanual( "semtex_bolt_mp", bolt.origin, ( 0, 0, 0 ), fusetime );
        
        if ( bolt.grenade )
        {
            bolt.grenade.angles = bolt.angles;
            bolt.grenade linkto( bolt, "tag_origin" );
            
            if ( isagent( hitent ) && !hitent.var_2f7b28254901f8d6 )
            {
                ai::function_9b5d55d642edff87( bolt.grenade, hitent );
            }
        }
    }
    
    thread exploboltexplode( bolt, fusetime, surfacenormal );
}

// Namespace crossbow
// Params 6
// Checksum 0x46361850, Offset: 0xd13
// Size: 0x46
function impactfunc_fire( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype )
{
    thread function_12a7131021c4ede7( bolt, hitent, hitentpart, hitloc );
}

// Namespace crossbow
// Params 6
// Checksum 0x97d00943, Offset: 0xd61
// Size: 0x73
function impactfunc_stun( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype )
{
    if ( !stunshoulddetonate( hitent, surfacetype ) )
    {
        thread stunboltdud( bolt );
        return;
    }
    
    if ( stununderwater( bolt ) )
    {
        thread function_4744c665476cbe51( bolt );
        return;
    }
    
    thread stunboltdetonate( bolt, surfacenormal );
}

// Namespace crossbow
// Params 6
// Checksum 0xaa9aa04c, Offset: 0xddc
// Size: 0x46
function impactfunc_molotov( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype )
{
    thread function_5f45be40107548bf( bolt, hitent, hitentpart, hitloc );
}

// Namespace crossbow
// Params 6
// Checksum 0x271ea22a, Offset: 0xe2a
// Size: 0xe5
function impactfunc_snapshot( bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype )
{
    bundle = level.equipment.table[ "equip_snapshot_grenade" ].bundle;
    bolt.owner = self;
    
    if ( utility::issharedfuncdefined( #"weapons", #"snapshot_bolt_detect" ) )
    {
        bolt thread [[ utility::getsharedfunc( #"weapons", #"snapshot_bolt_detect" ) ]]( 256, 750, bundle );
    }
    
    playfx( utility::getfx( "vfx_snap_gren_pulse" ), bolt.origin );
    playsoundatpos( bolt.origin, "iw9_snapshot_expl" );
}

// Namespace crossbow
// Params 1
// Checksum 0x2d996f1e, Offset: 0xf17
// Size: 0xc
function function_888faec9ceb06667( bolt )
{
    
}

// Namespace crossbow
// Params 1
// Checksum 0xbc319f7b, Offset: 0xf2b
// Size: 0xc
function function_b92518105b8919af( bolt )
{
    
}

// Namespace crossbow
// Params 1
// Checksum 0x179b47ba, Offset: 0xf3f
// Size: 0xc
function function_4e99db0c39be700f( bolt )
{
    
}

// Namespace crossbow
// Params 3
// Checksum 0x57f8742e, Offset: 0xf53
// Size: 0x1e7
function exploboltexplode( bolt, fusetime, surfacenormal )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    
    if ( bolt.grenade )
    {
        bolt.grenade utility::waittill_any_timeout_no_endon_death( fusetime, "explode" );
    }
    else
    {
        wait fusetime;
    }
    
    bolt function_5799063fd00c05b5( surfacenormal );
    bolt setscriptablepartstate( "effects", "explode" );
    stuckweapon = makeweapon( "semtex_bolt_mp" );
    splashweapon = makeweapon( "semtex_bolt_splash_mp" );
    weapon_utility::function_502496613f00eb2a( stuckweapon, bolt.weapon );
    weapon_utility::function_502496613f00eb2a( splashweapon, bolt.weapon );
    stuckdamage = 200;
    outerdamage = 50;
    innerdamage = 150;
    idamageradius = 160;
    
    if ( isdefined( bolt.weapon ) && bolt.weapon.basename == "jup_jp31_dm_compound_mp" )
    {
        stuckdamage = 200;
        outerdamage = 50;
        innerdamage = 150;
        idamageradius = 160;
    }
    
    if ( isalive( bolt.stuckenemyentity ) )
    {
        bolt.stuckenemyentity damage_utility::forcestuckdamage();
        bolt.stuckenemyentity dodamage( stuckdamage, bolt.origin, self, undefined, "MOD_EXPLOSIVE", stuckweapon, "none" );
        bolt.stuckenemyentity damage_utility::forcestuckdamageclear();
        bolt.stuckenemyentity thread function_7a34faea2f3c515f( self );
    }
    
    radiusdamage( bolt.origin, idamageradius, innerdamage, outerdamage, self, "MOD_EXPLOSIVE", splashweapon );
    wait 0.4;
    
    if ( !bolt validateboltent() )
    {
        return;
    }
    
    bolt delete();
}

// Namespace crossbow
// Params 1
// Checksum 0xd7a87e7c, Offset: 0x1142
// Size: 0x68
function function_7a34faea2f3c515f( inflictor )
{
    self endon( #"disconnect" );
    self notify( #"crossbow_semtex_blockdamage" );
    self endon( #"crossbow_semtex_blockdamage" );
    
    if ( !isdefined( self.var_672320809c1c1c21 ) )
    {
        self.var_672320809c1c1c21 = [];
    }
    
    self.var_672320809c1c1c21[ self.var_672320809c1c1c21.size ] = inflictor;
    waittillframeend();
    self.var_672320809c1c1c21 = undefined;
}

// Namespace crossbow
// Params 4
// Checksum 0x246bf9d7, Offset: 0x11b2
// Size: 0x77
function function_12a7131021c4ede7( bolt, hitent, hitentpart, hitloc )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    wait 0.18;
    bolt setscriptablepartstate( "effects", "impact" );
    thread thermiteboltstuckto( bolt, hitent, hitentpart, hitloc );
    thread thermiteboltradiusdamage( bolt, hitent );
    thread thermiteboltburnout( bolt );
}

// Namespace crossbow
// Params 4
// Checksum 0x41c91700, Offset: 0x1231
// Size: 0x154
function thermiteboltstuckto( bolt, hitent, hitentpart, hitloc )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    stuckweapon = makeweapon( "thermite_bolt_mp" );
    weapon_utility::function_502496613f00eb2a( stuckweapon, bolt.weapon );
    
    if ( ( isplayer( hitent ) || isbot( hitent ) ) && isdefined( hitloc ) && hitloc == "shield" )
    {
        hitloc = "torso_upper";
        bolt thread function_43dd396be454b029( hitent );
    }
    
    if ( isalive( bolt.stuckenemyentity ) )
    {
        if ( isdefined( hitent vehicle::get_ref() ) || hitent.classname == "misc_turret" )
        {
            damage_interval = 1;
        }
        else
        {
            damage_interval = 0.25;
        }
        
        ticks = int( 4.5 / damage_interval );
        
        while ( isdefined( bolt ) && isalive( hitent ) && ticks > 0 )
        {
            hitent damage_utility::forcestuckdamage();
            hitent dodamage( 5, bolt.origin, self, bolt, "MOD_FIRE", stuckweapon, hitloc );
            hitent damage_utility::forcestuckdamageclear();
            ticks--;
            wait damage_interval;
        }
    }
}

// Namespace crossbow
// Params 1
// Checksum 0xf60181c7, Offset: 0x138d
// Size: 0x45
function function_43dd396be454b029( hitent )
{
    hitent endon( #"disconnect" );
    self endon( #"entitydeleted" );
    hitent waittill( #"death" );
    
    if ( !validateboltent() )
    {
        return;
    }
    
    boltunlink();
}

// Namespace crossbow
// Params 2
// Checksum 0x877dc5dc, Offset: 0x13da
// Size: 0x13b
function thermiteboltradiusdamage( bolt, hitent )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    ticks = int( 18 );
    radiusweapon = makeweapon( "thermite_bolt_radius_mp" );
    weapon_utility::function_502496613f00eb2a( radiusweapon, bolt.weapon );
    bolt.thermiteradiusweaponref = radiusweapon.basename;
    
    if ( !isdefined( bolt.stuckenemyentity ) )
    {
        bolt.badplace = thermitebadplace( bolt.origin );
    }
    
    while ( ticks > 0 )
    {
        if ( isalive( bolt.stuckenemyentity ) )
        {
            bolt.stuckenemyentity damage_utility::adddamagemodifier( "thermiteBoltStuck", 0, 0, &thermite_damagemodifierignorefunc );
        }
        
        bolt radiusdamage( bolt.origin, 50, 5, 3, self, "MOD_FIRE", radiusweapon );
        
        if ( isalive( bolt.stuckenemyentity ) )
        {
            bolt.stuckenemyentity damage_utility::removedamagemodifier( "thermiteBoltStuck", 0 );
        }
        
        ticks--;
        wait 0.25;
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x611023e4, Offset: 0x151d
// Size: 0x3a
function thermitebadplace( impactpoint )
{
    badplace = createnavbadplacebybounds( impactpoint, ( 50, 50, 50 ), ( 0, 0, 0 ) );
    return badplace;
}

// Namespace crossbow
// Params 7
// Checksum 0x3b55a04e, Offset: 0x1560
// Size: 0x78, Type: bool
function thermite_damagemodifierignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( !isdefined( inflictor ) )
    {
        return true;
    }
    
    if ( inflictor.thermiteradiusweaponref != "thermite_bolt_radius_mp" )
    {
        return true;
    }
    
    if ( inflictor.stuckenemyentity != victim )
    {
        return true;
    }
    
    return false;
}

// Namespace crossbow
// Params 1
// Checksum 0x27016245, Offset: 0x15e1
// Size: 0x80
function thermiteboltburnout( bolt )
{
    bolt endon( #"entitydeleted" );
    wait 4.5;
    
    if ( !bolt validateboltent() )
    {
        return;
    }
    
    bolt setscriptablepartstate( "effects", "burnEnd" );
    wait randomfloatrange( 0.3, 2 );
    
    if ( isdefined( bolt.badplace ) )
    {
        destroynavobstacle( bolt.badplace );
    }
    
    bolt boltunlink();
    bolt setmodel( "weapon_wm_sn_crossbow_bolt_fire_static_dst" );
}

// Namespace crossbow
// Params 2
// Checksum 0x3b3123b3, Offset: 0x1669
// Size: 0xf9
function stunboltdetonate( bolt, surfacenormal )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    wait 0.16;
    bolt function_5799063fd00c05b5( surfacenormal );
    bolt setscriptablepartstate( "impact", "active" );
    
    if ( utility::issharedfuncdefined( #"weapons", #"gas_createtrigger" ) )
    {
        paplevel = 0;
        
        if ( isdefined( bolt.weapon ) && utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
        {
            paplevel = namespace_9d8e359c3b1041e5::function_1d4087075103b248( bolt.weapon );
        }
        
        thread [[ utility::getsharedfunc( #"weapons", #"gas_createtrigger" ) ]]( bolt.origin, self, self.team, 5, 0.45, 1, paplevel );
    }
    
    thread stunboltdelete( bolt );
}

// Namespace crossbow
// Params 1
// Checksum 0x60cecd3b, Offset: 0x176a
// Size: 0x3c
function stunboltdud( bolt )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    wait 0.1;
    bolt setscriptablepartstate( "impact", "dud" );
}

// Namespace crossbow
// Params 1
// Checksum 0xc09d8172, Offset: 0x17ae
// Size: 0x3c
function function_4744c665476cbe51( bolt )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    wait 0.1;
    bolt setscriptablepartstate( "impact", "dudUnderwater" );
}

// Namespace crossbow
// Params 1
// Checksum 0x2613c07e, Offset: 0x17f2
// Size: 0x33
function stunboltdelete( bolt )
{
    bolt endon( #"entitydeleted" );
    wait 0.5;
    
    if ( !bolt validateboltent() )
    {
        return;
    }
    
    bolt delete();
}

// Namespace crossbow
// Params 4
// Checksum 0x87b0c66, Offset: 0x182d
// Size: 0xdf
function function_5f45be40107548bf( bolt, hitent, hitentpart, hitloc )
{
    self endon( #"disconnect" );
    bolt endon( #"entitydeleted" );
    launchangles = self getgunangles();
    launchtimems = gettime();
    launchvelocity = anglestoforward( launchangles ) * 940 + anglestoup( launchangles ) * 120;
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    
    if ( isdefined( hitent ) && ( isplayer( hitent ) || isagent( hitent ) ) )
    {
        thread function_55aab84a1cfcf1ac( bolt, hitent, launchangles, impactvelocity );
        return;
    }
    
    thread function_c92d596d8d38d761( bolt, hitent, launchangles, impactvelocity );
}

// Namespace crossbow
// Params 4
// Checksum 0xef7dd7dd, Offset: 0x1914
// Size: 0x1d2
function function_55aab84a1cfcf1ac( bolt, hitent, launchangles, impactvelocity )
{
    if ( utility::issharedfuncdefined( #"molotov", #"molotov_burn_for_time" ) )
    {
        hitent thread [[ utility::getsharedfunc( #"molotov", #"molotov_burn_for_time" ) ]]( 6, self, bolt, bolt );
    }
    
    impactvelocity *= ( 0, 0, 1 );
    caststart = bolt.origin;
    castdir = ( 0, 0, -1 );
    castend = caststart + castdir * 128;
    contents = utility::callsharedfunc( #"molotov", #"molotov_get_cast_contents" );
    castresults = physics_raycast( caststart, castend, contents, bolt, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        casthitnorm = castresults[ 0 ][ "normal" ];
        casthitent = castresults[ 0 ][ "entity" ];
        castend -= casthitnorm * 1;
        d = vectordot( castend - caststart, castdir );
        t = sqrt( 2 * d / 800 );
        up = casthitnorm;
        right = anglestoright( launchangles );
        impactangles = utility::callsharedfunc( #"molotov", #"molotov_rebuild_angles_up_right", up, right );
        function_bb38e98b6937d00b( bolt, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000 );
        return;
    }
    
    bolt notify( #"death" );
    level thread function_4992085a27550df8( bolt );
}

// Namespace crossbow
// Params 4
// Checksum 0x4ab2e6d0, Offset: 0x1aee
// Size: 0xda
function function_c92d596d8d38d761( bolt, stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( bolt.angles );
    right = anglestoright( launchangles );
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = utility::callsharedfunc( #"molotov", #"molotov_rebuild_angles_up_right", up, right );
    }
    else
    {
        angles = utility::callsharedfunc( #"molotov", #"molotov_rebuild_angles_up_forward", up, forward );
    }
    
    function_bb38e98b6937d00b( bolt, bolt.origin, angles, stuckto, impactvelocity, gettime() );
}

// Namespace crossbow
// Params 6
// Checksum 0x1ff4a3d5, Offset: 0x1bd0
// Size: 0x6c
function function_bb38e98b6937d00b( bolt, castend, impactangles, casthitent, impactvelocity, impacttime )
{
    bolt setscriptablepartstate( "effects", "explode", 0 );
    utility::callsharedfunc( #"molotov", #"molotov_simulate_impact", bolt, castend, impactangles, casthitent, impactvelocity, impacttime );
}

// Namespace crossbow
// Params 1
// Checksum 0x512137f0, Offset: 0x1c44
// Size: 0x33
function function_4992085a27550df8( bolt )
{
    bolt endon( #"entitydeleted" );
    wait 0.5;
    
    if ( !bolt validateboltent() )
    {
        return;
    }
    
    bolt delete();
}

// Namespace crossbow
// Params 2
// Checksum 0xf4dd15b8, Offset: 0x1c7f
// Size: 0x75, Type: bool
function stunshoulddetonate( hitent, surfacetype )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    if ( hitent.targetname == "enemyTarget" )
    {
        return true;
    }
    
    if ( !isplayer( hitent ) && !isagent( hitent ) )
    {
        return false;
    }
    
    if ( issameteamplayer( hitent ) )
    {
        return false;
    }
    
    if ( issameteamagent( hitent ) )
    {
        return false;
    }
    
    if ( surfacetype == "riotshield" )
    {
        return false;
    }
    
    return true;
}

// Namespace crossbow
// Params 1
// Checksum 0x61c88042, Offset: 0x1cfd
// Size: 0x32, Type: bool
function stununderwater( bolt )
{
    if ( utility::ispointinwater( bolt.origin + ( 0, 0, 10 ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace crossbow
// Params 4
// Checksum 0xc5b395ce, Offset: 0x1d38
// Size: 0xdb
function spawncrossbowbolt( impactpos, bulletdir, ammotype, weapon )
{
    model = getboltmodel( ammotype );
    bolt = spawn( "script_model", impactpos );
    bolt setmodel( model );
    bolt notsolid();
    bolt.angles = vectortoangles( bulletdir );
    bolt setdeleteable( ammotype );
    bolt.owner = self;
    bolt.ammotype = ammotype;
    bolt.weapon = weapon;
    bolt.iscrossbowbolt = 1;
    
    if ( shouldpickup( ammotype ) )
    {
        bolt = makepickup( bolt );
    }
    
    bolt thread boltdeletethread();
    manageworldspawnedbolts( bolt );
    return bolt;
}

// Namespace crossbow
// Params 1
// Checksum 0x842d5d84, Offset: 0x1e1c
// Size: 0x57, Type: bool
function shouldpickup( ammotype )
{
    if ( ammotype == "bolt_default" || ammotype == "bolt_stun" || ammotype == "bolt_stun_vday" || ammotype == "bolt_snapshot" || ammotype == "bolt_ripper" || ammotype == "jup_ammo_arrow_std" )
    {
        return true;
    }
    
    return false;
}

// Namespace crossbow
// Params 1
// Checksum 0xfda4c710, Offset: 0x1e7c
// Size: 0xd2
function makepickup( bolt )
{
    triggerorg = bolt.origin + anglestoforward( bolt.angles ) * 15;
    triggerang = axistoangles( anglestoup( bolt.angles ), anglestoright( bolt.angles ), anglestoforward( bolt.angles ) );
    trigger = spawn( "trigger_rotatable_radius", triggerorg, 0, 64, 79 );
    trigger.angles = triggerang;
    trigger.targetname = "bolt_pickup";
    trigger enablelinkto();
    trigger linkto( bolt );
    bolt.pickuptrigger = trigger;
    bolt thread bolt_watchpickup();
    return bolt;
}

// Namespace crossbow
// Params 1
// Checksum 0xe461bd58, Offset: 0x1f57
// Size: 0x38
function removepickup( bolt )
{
    bolt notify( #"removepickup" );
    
    if ( isdefined( bolt.pickuptrigger ) )
    {
        bolt.pickuptrigger delete();
    }
}

// Namespace crossbow
// Params 0
// Checksum 0x957af350, Offset: 0x1f97
// Size: 0xba
function bolt_watchpickup()
{
    self endon( #"entitydeleted" );
    self endon( #"removepickup" );
    wait 2;
    
    while ( true )
    {
        self.pickuptrigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( isalive( self.stuckenemyentity ) && !isdefined( self.stuckenemyentity vehicle::get_ref() ) )
        {
            continue;
        }
        
        var_74c0eea1de4191a0 = get_weapon_ammo_matched( player getweaponslistprimaries() );
        
        if ( !isdefined( var_74c0eea1de4191a0 ) )
        {
            continue;
        }
        
        if ( player bolt_trytopickup( var_74c0eea1de4191a0 ) )
        {
            self delete();
        }
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x642d3271, Offset: 0x2059
// Size: 0x144
function get_weapon_ammo_matched( weapons )
{
    foreach ( weapon in weapons )
    {
        if ( weapon.basename == "iw9_dm_crossbow_mp" || weapon.basename == "jup_jp31_dm_compound_mp" )
        {
            if ( weapon.modifier == "ammo_bolt_std" && self.ammotype == "bolt_default" )
            {
                return weapon;
            }
            
            if ( weapon.modifier == "ammo_bolt_gas" && ( self.ammotype == "bolt_stun" || self.ammotype == "bolt_stun_vday" ) || weapon.modifier == "jup_ammo_arrow_snapshot" || weapon.modifier == "jup_ammo_arrow_rip" || weapon.modifier == "jup_ammo_arrow_std" )
            {
                return weapon;
            }
        }
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x730c3cf5, Offset: 0x21a6
// Size: 0x98, Type: bool
function bolt_trytopickup( weapon )
{
    maxammo = weaponmaxammo( weapon );
    ogammo = self getweaponammostock( weapon );
    
    if ( ogammo >= maxammo )
    {
        return false;
    }
    
    finalammo = int( min( maxammo, ogammo + 1 ) );
    self setweaponammostock( weapon, finalammo );
    
    if ( utility::issharedfuncdefined( #"damage", #"hudicontype" ) )
    {
        self [[ utility::getsharedfunc( #"damage", #"hudicontype" ) ]]( "crossbowbolt" );
    }
    
    return true;
}

// Namespace crossbow
// Params 1
// Checksum 0xf40155f1, Offset: 0x2247
// Size: 0x99
function setdeleteable( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_5565a4776393e4b7":
            thread setdeleteabletimer( 5 );
            self.deleteable = 0;
            break;
        case #"hash_546f43dd604e633f":
            self.deleteable = 0;
            break;
        case #"hash_3f2013439426f0b8":
        case #"hash_f2adc5f71cba34f7":
            thread setdeleteabletimer( 0.5 );
            self.deleteable = 0;
            break;
        default:
            self.deleteable = 1;
            break;
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x4a596328, Offset: 0x22e8
// Size: 0x2d
function setdeleteabletimer( time )
{
    self endon( #"entitydeleted" );
    wait time;
    self.deleteable = 1;
    manageworldspawnedbolts();
}

// Namespace crossbow
// Params 1
// Checksum 0xd7f7f12, Offset: 0x231d
// Size: 0xdd
function manageworldspawnedbolts( newbolt )
{
    if ( isdefined( newbolt ) )
    {
        temparr = [ newbolt ];
    }
    else
    {
        temparr = [];
    }
    
    foreach ( bolt in level.crossbowbolts )
    {
        if ( !isdefined( bolt ) )
        {
            continue;
        }
        
        if ( isdefined( bolt ) )
        {
            if ( temparr.size >= 24 && bolt.deleteable )
            {
                bolt delete();
                continue;
            }
            
            temparr[ temparr.size ] = bolt;
        }
    }
    
    level.crossbowbolts = temparr;
}

// Namespace crossbow
// Params 1
// Checksum 0xade07eca, Offset: 0x2402
// Size: 0xf1
function getcrossbowammotype( weapon )
{
    if ( !isdefined( weapon.modifier ) )
    {
        return "bolt_default";
    }
    
    switch ( weapon.modifier )
    {
        case #"hash_1384dc17fea40a53":
        case #"hash_54394a972b4ae6e1":
            return "bolt_explo";
        case #"hash_135ed917fe85f086":
        case #"hash_542d33972b41c850":
            return "bolt_fire";
        case #"hash_19baf8c5b7e79ee1":
        case #"hash_bb2800f912ce65eb":
            if ( weapon.modifiervarindex == 1 )
            {
                return "bolt_stun_vday";
            }
            else
            {
                return "bolt_stun";
            }
        case #"hash_464357c5cf40c360":
            return "bolt_molotov";
        case #"hash_fc78a991420fd12e":
            return "bolt_snapshot";
        case #"hash_dd886f93e6f7e11":
            return "bolt_ripper";
        default:
            return "bolt_default";
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x5f3c2590, Offset: 0x24fb
// Size: 0x89
function getcrossbowimpactfunc( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_546f43dd604e633f":
            return &impactfunc_explo;
        case #"hash_5565a4776393e4b7":
            return &impactfunc_fire;
        case #"hash_3f2013439426f0b8":
        case #"hash_f2adc5f71cba34f7":
            return &impactfunc_stun;
        case #"hash_ae030c32020d2f3b":
            return &impactfunc_molotov;
        case #"hash_841d3280c0d224ab":
            return &impactfunc_snapshot;
        default:
            return;
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x16de0705, Offset: 0x258c
// Size: 0x6b
function function_89994eb37340c2a6( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_546f43dd604e633f":
            return &impactfunc_explo;
        case #"hash_5565a4776393e4b7":
            return &impactfunc_fire;
        case #"hash_f2adc5f71cba34f7":
            return &impactfunc_stun;
        case #"hash_ae030c32020d2f3b":
            return &impactfunc_molotov;
        default:
            return;
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x36cc6171, Offset: 0x25ff
// Size: 0x82
function getboltmodel( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_546f43dd604e633f":
            return "weapon_wm_sn_crossbow_bolt_explosive_static";
        case #"hash_5565a4776393e4b7":
            return "weapon_wm_sn_crossbow_bolt_fire_static";
        case #"hash_f2adc5f71cba34f7":
            return "weapon_wm_sn_crossbow_bolt_stun_static";
        case #"hash_3f2013439426f0b8":
            return "weapon_wm_sn_crossbow_bolt_stun_vday_static";
        case #"hash_ae030c32020d2f3b":
            return "weapon_wm_sn_crossbow_bolt_molotov_static";
        default:
            return "weapon_wm_sn_crossbow_bolt_static";
    }
}

// Namespace crossbow
// Params 5
// Checksum 0x4f97c257, Offset: 0x2689
// Size: 0x200
function shouldreflect( surfacetype, bolt, hitent, hitentpart, weapon )
{
    if ( !isdefined( hitent ) && hitentpart == getxhash( "tag_origin" ) )
    {
        return 1;
    }
    
    if ( isdefined( hitent ) && hitent.var_fb9c152a3bef72e1 )
    {
        return 1;
    }
    
    if ( isdefined( hitent ) && hitent.code_classname == "scriptable" )
    {
        return 1;
    }
    
    if ( issameteamplayer( hitent ) || issameteamagent( hitent ) )
    {
        if ( weapon.basename == "iw9_dm_crossbow_mp" )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    if ( !isdefined( surfacetype ) )
    {
        return 0;
    }
    
    switch ( surfacetype )
    {
        case #"hash_886109ae17c9aa73":
        case #"hash_8c9d4c67dcde81f2":
        case #"hash_d1caa6f32509652e":
            return 1;
    }
    
    if ( function_368d97d5df26034c( hitent, hitentpart ) )
    {
        return 1;
    }
    
    if ( bolt.ammotype == "bolt_explo" )
    {
        return 0;
    }
    
    if ( getcrossbowammotype( weapon ) == "bolt_stun_vday" && ( isplayer( hitent ) || isagent( hitent ) ) && !isalive( hitent ) )
    {
        return 1;
    }
    
    switch ( surfacetype )
    {
        case #"hash_dacf073cf66fde4":
        case #"hash_67e845c97d1f9eda":
        case #"hash_f9100fc94321f813":
            return 1;
        case #"hash_fb5a4fd62140d3d":
        case #"hash_321a9678047d0a4e":
        case #"hash_519950fd846289c6":
        case #"hash_7fe735e403d9fe08":
        case #"hash_91afe7576024a903":
        case #"hash_b72d9dbb666bc59c":
        case #"hash_d70d4c17673f4162":
        case #"hash_f4d3c7f04f8ef31d":
            if ( bolt.ammotype == "bolt_fire" )
            {
                return 0;
            }
            else
            {
                return 1;
            }
        default:
            return 0;
    }
}

// Namespace crossbow
// Params 4
// Checksum 0x76579c34, Offset: 0x2891
// Size: 0x7f
function reflectbolt( bolt, surfacenormal, bulletdir, impactpos )
{
    vec = math::vector_reflect( bulletdir, surfacenormal );
    dot = abs( vectordot( bulletdir, surfacenormal ) );
    reflect_velocity = math::factor_value( 2300, 1000, dot );
    vec *= reflect_velocity;
    bolt solid();
    bolt physicslaunchserver( impactpos, vec );
}

// Namespace crossbow
// Params 2
// Checksum 0x1c124bd3, Offset: 0x2918
// Size: 0x95, Type: bool
function shoulddeleteimmediately( hitent, weapon )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    if ( isdefined( hitent ) && hitent.var_a8a5be77d852fc77 )
    {
        return true;
    }
    
    if ( isagent( hitent ) && hitent is_suicidebomber() && !isalive( hitent ) && !isdefined( hitent getcorpseentity() ) )
    {
        return true;
    }
    
    if ( ( issameteamplayer( hitent ) || issameteamagent( hitent ) ) && weapon.basename != "iw9_dm_crossbow_mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace crossbow
// Params 2
// Checksum 0x47e46fc7, Offset: 0x29b6
// Size: 0xac, Type: bool
function shoulddrop( hitent, hitloc )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    if ( isdefined( hitent ) && hitent.var_ba274cd730dfbf99 )
    {
        return true;
    }
    
    if ( ( isplayer( hitent ) || isagent( hitent ) ) && !isalive( hitent ) && !isdefined( hitent getcorpseentity() ) )
    {
        return true;
    }
    
    if ( isagent( hitent ) && utility::issharedfuncdefined( #"ai", #"isLimbDismembered" ) )
    {
        if ( hitent [[ utility::getsharedfunc( #"ai", #"isLimbDismembered" ) ]]( hitloc ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace crossbow
// Params 1
// Checksum 0xd9d6848f, Offset: 0x2a6b
// Size: 0x1a
function dropbolt( bolt )
{
    bolt solid();
    bolt physicslaunchserver();
}

// Namespace crossbow
// Params 3
// Checksum 0x9bcc4c3c, Offset: 0x2a8d
// Size: 0x29, Type: bool
function shouldlink( hitent, hitentpart, weapon )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace crossbow
// Params 0
// Checksum 0x549074ba, Offset: 0x2abf
// Size: 0x11, Type: bool
function is_suicidebomber()
{
    return self.unittype == "suicidebomber";
}

// Namespace crossbow
// Params 3
// Checksum 0x8cced135, Offset: 0x2ad9
// Size: 0x183
function function_6db52ce8e25a40a5( bolt, hitent, hitentpart )
{
    if ( ( isplayer( hitent ) || isagent( hitent ) ) && !isalive( hitent ) )
    {
        corpse = hitent getcorpseentity();
        
        if ( isdefined( corpse ) )
        {
            hitent = corpse;
        }
    }
    
    if ( isplayer( hitent ) && bolt.ammotype != "bolt_stun" )
    {
        bolt hidefromplayer( hitent );
        
        if ( isdefined( bolt.pickuptrigger ) )
        {
            bolt.pickuptrigger hidefromplayer( hitent );
        }
        
        if ( bolt.ammotype == "bolt_fire" )
        {
            hitent thread doCrossbowHitPlayerThermiteSounds();
        }
    }
    
    if ( isdefined( hitentpart ) && hitent tagexists( hitentpart ) )
    {
        bolt linkto( hitent, hitentpart );
        bolt function_db6fe503e774d9fb( hitent, hitentpart );
    }
    else
    {
        bolt linkto( hitent );
    }
    
    bolt.linked = 1;
    
    if ( cansticktoent( hitent ) )
    {
        bolt.stuckenemyentity = hitent;
        bolt thread removestuckenemyondeathordisconnect( hitent );
    }
    else if ( isenemycorpse( hitent ) )
    {
        bolt thread function_7fe4adcb73afa36d();
    }
    
    bolt function_b398682b38f521f5( 1 );
    bolt thread boltunlinkonnote( hitent );
    bolt thread boltdeleteonnote( hitent, "vehicle_deleted" );
    bolt thread boltdeleteonnote( hitent, "detonated" );
    bolt thread boltdeleteonnote( hitent, "beginC130" );
    bolt thread boltdeleteonnote( hitent, "recycled_to_uibot" );
}

// Namespace crossbow
// Params 0
// Checksum 0x4647228b, Offset: 0x2c64
// Size: 0x27
function validateboltent()
{
    if ( isdefined( self ) && self.iscrossbowbolt )
    {
        return 1;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace crossbow
// Params 1
// Checksum 0x805329e2, Offset: 0x2c93
// Size: 0x67
function removestuckenemyondeathordisconnect( hitent )
{
    self endon( #"entitydeleted" );
    hitent utility::waittill_any( "entitydeleted", "death", "disconnect" );
    
    if ( !validateboltent() )
    {
        return;
    }
    
    self.stuckenemyentity = undefined;
    
    if ( isdefined( hitent ) && isdefined( hitent.nocorpse ) )
    {
        self delete();
    }
    
    function_7fe4adcb73afa36d();
}

// Namespace crossbow
// Params 1
// Checksum 0x8dd8052b, Offset: 0x2d02
// Size: 0x28
function isenemycorpse( hitent )
{
    if ( hitent.targetname == "player_corpse" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace crossbow
// Params 0
// Checksum 0x9696198f, Offset: 0x2d32
// Size: 0x22
function function_7fe4adcb73afa36d()
{
    self endon( #"entitydeleted" );
    wait 45;
    
    if ( !validateboltent() )
    {
        return;
    }
    
    self delete();
}

// Namespace crossbow
// Params 1
// Checksum 0x39ead8d1, Offset: 0x2d5c
// Size: 0x32
function boltunlinkonnote( hitent )
{
    self endon( #"entitydeleted" );
    hitent utility::waittill_any( "entitydeleted", "disconnect" );
    boltunlink();
}

// Namespace crossbow
// Params 1
// Checksum 0x2e6edd79, Offset: 0x2d96
// Size: 0x9e
function boltunlink( launchvec )
{
    if ( !validateboltent() )
    {
        return;
    }
    
    if ( !isdefined( self.linked ) )
    {
        return;
    }
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    self.linked = undefined;
    
    if ( !isdefined( launchvec ) )
    {
        launchvec = ( 0, 0, 100 );
    }
    
    if ( !isdefined( self.model ) || self.model == "tag_origin" )
    {
        return;
    }
    
    if ( self.classname != "script_model" )
    {
        return;
    }
    
    self solid();
    self physicslaunchserver( self.origin, launchvec );
}

// Namespace crossbow
// Params 2
// Checksum 0xa0398e56, Offset: 0x2e3c
// Size: 0x38
function boltdeleteonnote( hitent, note )
{
    self endon( #"entitydeleted" );
    hitent waittill( note );
    
    if ( !validateboltent() )
    {
        return;
    }
    
    self delete();
}

// Namespace crossbow
// Params 0
// Checksum 0x1cc5b608, Offset: 0x2e7c
// Size: 0x45
function boltdeletethread()
{
    self waittill( #"entitydeleted" );
    
    if ( isdefined( self.pickuptrigger ) )
    {
        self.pickuptrigger delete();
    }
    
    if ( isdefined( self.grenade ) )
    {
        self.grenade delete();
    }
}

// Namespace crossbow
// Params 1
// Checksum 0xa3fd60e4, Offset: 0x2ec9
// Size: 0x2a
function function_5799063fd00c05b5( surfacenormal )
{
    if ( isdefined( surfacenormal ) )
    {
        self dontinterpolate();
        self.angles = vectortoangles( surfacenormal * -1 );
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x62e37b4, Offset: 0x2efb
// Size: 0x2b
function issameteamplayer( hitent )
{
    if ( !isplayer( hitent ) )
    {
        return 0;
    }
    
    if ( player_utility::isenemy( hitent ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace crossbow
// Params 1
// Checksum 0x89c80adf, Offset: 0x2f2e
// Size: 0x34, Type: bool
function issameteamagent( hitent )
{
    if ( !isagent( hitent ) )
    {
        return false;
    }
    
    if ( self.team == hitent.agentteam )
    {
        return true;
    }
    
    return false;
}

// Namespace crossbow
// Params 1
// Checksum 0x9af69865, Offset: 0x2f6b
// Size: 0x24, Type: bool
function iscrossbowweapon( objweapon )
{
    return isdefined( objweapon ) && objweapon.basename == "iw9_dm_crossbow_mp";
}

// Namespace crossbow
// Params 1
// Checksum 0xec33d627, Offset: 0x2f98
// Size: 0x11e, Type: bool
function cansticktoent( hitent )
{
    if ( isai( hitent ) )
    {
        return true;
    }
    
    if ( isplayer( hitent ) || isagent( hitent ) )
    {
        return true;
    }
    
    if ( isdefined( hitent vehicle::get_ref() ) )
    {
        return true;
    }
    
    if ( isdefined( hitent.classname ) )
    {
        if ( hitent.classname == "misc_turret" )
        {
            return true;
        }
        
        if ( hitent.classname == "script_model" )
        {
            if ( isdefined( hitent.streakinfo ) && isdefined( hitent.streakinfo.streakname ) && ( hitent.streakinfo.streakname == "uav" || hitent.streakinfo.streakname == "gunship" ) )
            {
                return true;
            }
            
            if ( hitent.targetname == "enemyTarget" )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( hitent.equipmentref ) )
    {
        if ( hitent.equipmentref == "equip_tac_cover" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace crossbow
// Params 1
// Checksum 0xfb2583b4, Offset: 0x30bf
// Size: 0x2e, Type: bool
function isthermitecrossbow( objweapon )
{
    if ( isdefined( objweapon.modifier ) )
    {
        return ( objweapon.modifier == "ammo_bolt_db" );
    }
    
    return false;
}

// Namespace crossbow
// Params 0
// Checksum 0x82bf53f6, Offset: 0x30f6
// Size: 0x7
function function_aa9fd31c54910c8()
{
    return 4.5;
}

// Namespace crossbow
// Params 1
// Checksum 0x3ef8635c, Offset: 0x3106
// Size: 0x5e
function function_682bdd7e31c2ddd1( watcherweapon )
{
    if ( !function_e91ae2ccca2d456( watcherweapon ) )
    {
        return;
    }
    
    function_3becd532a834f345();
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        function_30c5047d8c1ee4ce();
        childthread function_ad6efda3fc22e6f6();
        childthread function_a265bd8528bd5787();
        self waittill( #"reload_ammo_added" );
        function_c39894740165284f();
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x31d82d5, Offset: 0x316c
// Size: 0x3a
function function_e91ae2ccca2d456( objweapon )
{
    if ( objweapon.scope == "fourx04" && objweapon.scopevarindex == 4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace crossbow
// Params 0
// Checksum 0x1511a16a, Offset: 0x31ae
// Size: 0x67
function function_ad6efda3fc22e6f6()
{
    self endon( #"bullet_terminated" );
    self endon( #"reload" );
    self waittill( #"bullet_first_impact", impacts );
    
    if ( stunshoulddetonate( impacts[ 0 ].hitent, impacts[ 0 ].surfacetype ) )
    {
        function_f1f9d2266ab06cb();
        return;
    }
    
    function_74eac2c923061355();
}

// Namespace crossbow
// Params 0
// Checksum 0x761b8af8, Offset: 0x321d
// Size: 0x2e
function function_a265bd8528bd5787()
{
    self endon( #"bullet_first_impact" );
    self endon( #"reload" );
    self waittill( #"bullet_terminated" );
    function_74eac2c923061355();
}

// Namespace crossbow
// Params 0
// Checksum 0x3a7bda64, Offset: 0x3253
// Size: 0xe
function function_3becd532a834f345()
{
    self setclientomnvar( "ui_reticle_mtx_action", 0 );
}

// Namespace crossbow
// Params 0
// Checksum 0x7e41d977, Offset: 0x3269
// Size: 0xf
function function_30c5047d8c1ee4ce()
{
    self setclientomnvar( "ui_reticle_mtx_action", 1 );
}

// Namespace crossbow
// Params 0
// Checksum 0x915b18c7, Offset: 0x3280
// Size: 0xf
function function_f1f9d2266ab06cb()
{
    self setclientomnvar( "ui_reticle_mtx_action", 2 );
}

// Namespace crossbow
// Params 0
// Checksum 0x2f99a07c, Offset: 0x3297
// Size: 0xf
function function_74eac2c923061355()
{
    self setclientomnvar( "ui_reticle_mtx_action", 3 );
}

// Namespace crossbow
// Params 0
// Checksum 0x7ba75155, Offset: 0x32ae
// Size: 0xf
function function_c39894740165284f()
{
    self setclientomnvar( "ui_reticle_mtx_action", 4 );
}

// Namespace crossbow
// Params 0
// Checksum 0xfffab2b4, Offset: 0x32c5
// Size: 0x8e
function doCrossbowHitPlayerThermiteSounds()
{
    thermite_bolt_sfx = spawn( "script_origin", self.origin );
    thermite_bolt_sfx.targetname = "doCrossbowHitPlayerThermiteSounds";
    thermite_bolt_sfx linkto( self );
    thermite_bolt_sfx playsound( "thermite_bomb_crossbow_impact" );
    thermite_bolt_sfx playloopsound( "thermite_bomb_crossbow_fire_lp" );
    utility::waittill_any_timeout( 4.5, "entitydeleted", "death", "disconnect" );
    thermite_bolt_sfx playsound( "thermite_bomb_crossbow_fire_end" );
    thermite_bolt_sfx stoploopsound( "thermite_bomb_crossbow_fire_lp" );
    wait 5;
    thermite_bolt_sfx delete();
}

// Namespace crossbow
// Params 2
// Checksum 0xadb1991c, Offset: 0x335b
// Size: 0xaf, Type: bool
function function_368d97d5df26034c( hitent, hitentpart )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    if ( !isdefined( hitentpart ) )
    {
        return false;
    }
    
    var_a3dce8b16e28153e = function_d88b357b027cbaed( hitentpart );
    
    if ( !function_7f710e67938d4db4( var_a3dce8b16e28153e ) )
    {
        return false;
    }
    
    if ( isdefined( hitent.damageableparts[ var_a3dce8b16e28153e ] ) && isdefined( hitent.damageableparts[ var_a3dce8b16e28153e ].healthvalue ) && var_a3dce8b16e28153e != "" )
    {
        part = hitent.damageableparts[ var_a3dce8b16e28153e ];
        
        if ( part.healthvalue == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace crossbow
// Params 2
// Checksum 0xe2efa737, Offset: 0x3413
// Size: 0xbd
function function_db6fe503e774d9fb( hitent, hitentpart )
{
    var_a3dce8b16e28153e = function_d88b357b027cbaed( hitentpart );
    
    if ( !function_7f710e67938d4db4( var_a3dce8b16e28153e ) )
    {
        return;
    }
    
    if ( isdefined( hitent.damageableparts[ var_a3dce8b16e28153e ] ) && var_a3dce8b16e28153e != "" )
    {
        if ( !isdefined( hitent.damageableparts[ var_a3dce8b16e28153e ].linkedbolts ) )
        {
            hitent.damageableparts[ var_a3dce8b16e28153e ].linkedbolts = [];
        }
        
        hitent.damageableparts[ var_a3dce8b16e28153e ].linkedbolts[ hitent.damageableparts[ var_a3dce8b16e28153e ].linkedbolts.size ] = self;
    }
}

// Namespace crossbow
// Params 1
// Checksum 0x336d6fc4, Offset: 0x34d8
// Size: 0x34
function function_d88b357b027cbaed( xhash )
{
    if ( !isdefined( level.var_a3dce8b16e28153e ) )
    {
        return "";
    }
    
    return level.var_a3dce8b16e28153e[ xhash ] ?? "";
}

// Namespace crossbow
// Params 1
// Checksum 0xd4974ca1, Offset: 0x3515
// Size: 0x31
function function_7f710e67938d4db4( partstring )
{
    if ( issubstr( partstring, "tag_wheel" ) || issubstr( partstring, "tag_door" ) )
    {
        return 1;
    }
    
    return 0;
}

