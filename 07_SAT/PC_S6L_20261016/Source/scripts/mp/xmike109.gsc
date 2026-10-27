// scripts\mp\xmike109.gsc  (hash_172b715fc4f21a44.gscc) (size: 11079 Bytes / 0x2b47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5966a54b (1499899211)
// size ...... 11079 (0x2b47)
// includes .. 6   (offset: 0x2907)
// strings ... 37  (offset: 0x2937)
// dev strs .. 1   (offset: 0x2b3b)
// exports ... 40  (offset: 0x187b)
// cseg ...... 0x2c7 + 0x15b4 (0x187b)
// imports ... 86  (offset: 0x1ebb)
// animtree1 . 0   (offset: 0x2b47)
// animtree2 . 0   (offset: 0x2b47)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;

#namespace xmike109;

// Namespace xmike109
// Params 1
// Checksum 0x3d4919e1, Offset: 0x2e5
// Size: 0x51
function initusage( weapon )
{
    if ( !isdefined( level.xmike109projectiles ) )
    {
        level.xmike109projectiles = [];
    }
    
    if ( !isdefined( self.xmike109 ) )
    {
        self.xmike109 = spawnstruct();
    }
    
    self.xmike109.active = 1;
}

// Namespace xmike109
// Params 1
// Checksum 0x29caa403, Offset: 0x33e
// Size: 0x6d
function usageloop( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"end_launcher" );
    ammotype = getxmike109ammotype( weapon );
    
    if ( ammotype == "mag_xmike109" )
    {
        return;
    }
    
    impactfunc = getxmike109impactfunc( ammotype );
    thread impactwatcher( weapon, ammotype, impactfunc );
}

// Namespace xmike109
// Params 0
// Checksum 0xd6ad04b7, Offset: 0x3b3
// Size: 0x1e
function cleanupafterweaponswitch()
{
    self waittill( #"end_launcher" );
    wait 6;
    self notify( #"hash_7012f9a1cb32a475" );
}

// Namespace xmike109
// Params 3
// Checksum 0x64efeac2, Offset: 0x3d9
// Size: 0xfe
function impactwatcher( watcherweapon, ammotype, xmike109impactfunc )
{
    self notify( #"hash_7012f9a1cb32a475" );
    self endon( #"disconnect" );
    self endon( #"hash_7012f9a1cb32a475" );
    childthread cleanupafterweaponswitch();
    
    if ( ammotype == "default" )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"bullet_first_impact", impacts );
        
        if ( watcherweapon != impacts[ 0 ].weapon )
        {
            continue;
        }
        
        handleimpact( impacts[ 0 ].hitent, impacts[ 0 ].hitentpart, impacts[ 0 ].hitloc, impacts[ 0 ].surfacenormal, impacts[ 0 ].surfacetype, impacts[ 0 ].weapon, impacts[ 0 ].hitdir, impacts[ 0 ].hitpos, xmike109impactfunc, ammotype );
    }
}

// Namespace xmike109
// Params 10
// Checksum 0xf97cda16, Offset: 0x4df
// Size: 0xcf
function handleimpact( hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, xmike109impactfunc, ammotype )
{
    reflected = shouldreflect( surfacetype, ammotype, hitent, hitentpart, surfacenormal, bulletdir );
    projectile = spawnprojectile( impactpos, bulletdir, ammotype, weapon, reflected, surfacenormal );
    
    if ( shoulddeleteimmediately( hitent ) )
    {
        projectile delete();
        return;
    }
    else if ( shouldlink( hitent, reflected ) )
    {
        linktoent( projectile, hitent, hitentpart );
    }
    
    if ( isdefined( xmike109impactfunc ) )
    {
        [[ xmike109impactfunc ]]( projectile, hitent, hitentpart, hitloc, surfacetype, reflected );
    }
}

// Namespace xmike109
// Params 6
// Checksum 0x98fadb78, Offset: 0x5b6
// Size: 0xbc
function impactfunc_explo( projectile, hitent, hitentpart, hitloc, surfacetype, reflected )
{
    fusetime = 0.1;
    projectile.grenade = magicgrenademanual( "semtex_xmike109_mp", projectile.origin, ( 0, 0, 0 ), fusetime );
    projectile.grenade.angles = projectile.angles;
    projectile.grenade linkto( projectile, "tag_origin" );
    thread projectileimpactexplode( projectile, fusetime, hitloc );
}

// Namespace xmike109
// Params 6
// Checksum 0xdfb84d73, Offset: 0x67a
// Size: 0x47
function impactfunc_fire( projectile, hitent, hitentpart, hitloc, surfacetype, reflected )
{
    thread projectileimpactthermite( projectile, hitent, hitentpart, hitloc, reflected );
}

// Namespace xmike109
// Params 6
// Checksum 0x1e8f30ac, Offset: 0x6c9
// Size: 0x39
function impactfunc_null( projectile, hitent, hitentpart, hitloc, surfacetype, reflected )
{
    
}

// Namespace xmike109
// Params 3
// Checksum 0x2d64a19c, Offset: 0x70a
// Size: 0x162
function projectileimpactexplode( projectile, fusetime, hitloc )
{
    self endon( #"disconnect" );
    projectile endon( #"entitydeleted" );
    projectile.grenade utility::waittill_any_timeout_no_endon_death( fusetime, "explode" );
    projectile setscriptablepartstate( "effects", "explode" );
    stuckweapon = makeweapon( "semtex_xmike109_mp" );
    splashweapon = makeweapon( "semtex_xmike109_splash_mp" );
    weapon_utility::function_502496613f00eb2a( stuckweapon, projectile.weapon );
    weapon_utility::function_502496613f00eb2a( splashweapon, projectile.weapon );
    glassradiusdamage( projectile.origin, 150, 50, 1 );
    
    if ( isalive( projectile.stuckenemyentity ) )
    {
        projectile.stuckenemyentity damage_utility::forcestuckdamage();
        projectile.stuckenemyentity dodamage( 140, projectile.origin, self, self, "MOD_EXPLOSIVE", stuckweapon, hitloc );
        projectile.stuckenemyentity damage_utility::forcestuckdamageclear();
    }
    
    radiusdamagestepped( projectile.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", splashweapon );
    wait 0.4;
    
    if ( !projectile validateprojectileent() )
    {
        return;
    }
    
    projectile delete();
}

// Namespace xmike109
// Params 5
// Checksum 0x3ceda7a8, Offset: 0x874
// Size: 0x84
function projectileimpactthermite( projectile, hitent, hitentpart, hitloc, reflected )
{
    if ( projectile.isgrenade )
    {
        projectile setscriptablepartstate( "effects", "reflectThermite" );
        waitforstuck( projectile );
    }
    
    projectile setscriptablepartstate( "effects", "burn" );
    thread thermitestuckto( projectile );
    thread thermiteradiusdamage( projectile );
    thread thermiteburnout( projectile );
}

// Namespace xmike109
// Params 1
// Checksum 0x925d1367, Offset: 0x900
// Size: 0x65
function waitforstuck( projectile )
{
    projectile endon( #"hash_23241c44f34181e5" );
    projectile thread projectilewaittilstucktimeout();
    projectile waittill( #"missile_stuck", stuckto, stuckpart );
    
    if ( isdefined( stuckto ) )
    {
        linktoent( projectile, stuckto, stuckpart );
        projectile.bounceshot = 1;
    }
}

// Namespace xmike109
// Params 0
// Checksum 0xe06f1e58, Offset: 0x96d
// Size: 0x16
function projectilewaittilstucktimeout()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_23241c44f34181e5" );
    }
}

// Namespace xmike109
// Params 1
// Checksum 0xef29a755, Offset: 0x98b
// Size: 0x16c
function thermitestuckto( projectile )
{
    self endon( #"disconnect" );
    projectile endon( #"entitydeleted" );
    stuckweapon = makeweapon( "thermite_xmike109_mp" );
    weapon_utility::function_502496613f00eb2a( stuckweapon, projectile.weapon );
    
    if ( isalive( projectile.stuckenemyentity ) )
    {
        if ( projectile.stuckenemyentity vehicle::is_vehicle() || projectile.stuckenemyentity.classname == "misc_turret" )
        {
            damage_interval = 0.95;
        }
        else
        {
            damage_interval = 0.25;
        }
        
        if ( projectile.bounceshot )
        {
            projectile.stuckenemyentity dodamage( 80, projectile.origin, self, projectile, "MOD_FIRE", stuckweapon );
        }
        
        ticks = int( 3 / damage_interval );
        
        while ( isdefined( projectile ) && isalive( projectile.stuckenemyentity ) && ticks >= 0 )
        {
            projectile.stuckenemyentity damage_utility::forcestuckdamage();
            projectile.stuckenemyentity dodamage( 3, projectile.origin, self, projectile, "MOD_FIRE", stuckweapon );
            projectile.stuckenemyentity damage_utility::forcestuckdamageclear();
            ticks--;
            wait damage_interval;
        }
    }
}

// Namespace xmike109
// Params 1
// Checksum 0xecbbafc1, Offset: 0xaff
// Size: 0x105
function thermiteradiusdamage( projectile )
{
    self endon( #"disconnect" );
    projectile endon( #"entitydeleted" );
    ticks = int( 12 );
    radiusweapon = makeweapon( "thermite_xmike109_radius_mp" );
    weapon_utility::function_502496613f00eb2a( radiusweapon, projectile.weapon );
    projectile.thermiteradiusweaponref = radiusweapon.basename;
    
    while ( ticks > 0 )
    {
        if ( isalive( projectile.stuckenemyentity ) )
        {
            projectile.stuckenemyentity damage_utility::adddamagemodifier( "thermite25mmStuck", 0, 0, &thermite_damagemodifierignorefunc );
        }
        
        projectile radiusdamage( projectile.origin, 50, 2, 2, self, "MOD_FIRE", radiusweapon );
        
        if ( isalive( projectile.stuckenemyentity ) )
        {
            projectile.stuckenemyentity damage_utility::removedamagemodifier( "thermite25mmStuck", 0 );
        }
        
        ticks--;
        wait 0.25;
    }
}

// Namespace xmike109
// Params 7
// Checksum 0xd5e8fc95, Offset: 0xc0c
// Size: 0x78, Type: bool
function thermite_damagemodifierignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( !isdefined( inflictor ) )
    {
        return true;
    }
    
    if ( inflictor.thermiteradiusweaponref != "thermite_xmike109_radius_mp" )
    {
        return true;
    }
    
    if ( inflictor.stuckenemyentity != victim )
    {
        return true;
    }
    
    return false;
}

// Namespace xmike109
// Params 1
// Checksum 0x99d2d44b, Offset: 0xc8d
// Size: 0x7a
function thermiteburnout( projectile )
{
    projectile endon( #"entitydeleted" );
    wait 3;
    
    if ( !projectile validateprojectileent() )
    {
        return;
    }
    
    projectile setscriptablepartstate( "effects", "burnout" );
    projectile setscriptablepartstate( "visibility", "hide" );
    wait randomfloatrange( 0.3, 2 );
    
    if ( !projectile validateprojectileent() )
    {
        return;
    }
    
    wait randomfloatrange( 2, 3 );
    projectile delete();
}

// Namespace xmike109
// Params 6
// Checksum 0xa60005de, Offset: 0xd0f
// Size: 0x158
function spawnprojectile( impactpos, bulletdir, ammotype, weapon, reflected, surfacenormal )
{
    if ( reflected && ammotype == "thermal" )
    {
        vel = reflectprojectile( surfacenormal, bulletdir, impactpos, 1 );
        org = impactpos + surfacenormal * 10;
        projectile = magicgrenademanual( "xmike109_grenade", org, vel, 10 );
        projectile.isgrenade = 1;
        playfx( utility::getfx( "xmike109ThermiteBounce" ), impactpos, surfacenormal );
    }
    else
    {
        projectile = spawn( "script_model", impactpos );
        projectile setmodel( "weapon_wm_sn_xmike109_projectile" );
        projectile.origin = impactpos;
        
        if ( reflected )
        {
            vel = reflectprojectile( surfacenormal, bulletdir, impactpos, 0 );
            projectile physicslaunchserver( impactpos, vel );
        }
    }
    
    projectile.angles = vectortoangles( bulletdir );
    projectile setdeleteable( ammotype );
    projectile.owner = self;
    projectile.ammotype = ammotype;
    projectile.weapon = weapon;
    projectile.isxmike109projectile = 1;
    projectile thread projectiledeletethread();
    manageworldspawnedprojectiles( projectile );
    return projectile;
}

// Namespace xmike109
// Params 1
// Checksum 0xcce64634, Offset: 0xe70
// Size: 0x6b
function setdeleteable( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_fd8321f2ca4fc7a0":
            thread setdeleteabletimer( 3.5 );
            self.deleteable = 0;
            break;
        case #"hash_1cb749d9b456c694":
            self.deleteable = 0;
            break;
        default:
            self.deleteable = 1;
            break;
    }
}

// Namespace xmike109
// Params 1
// Checksum 0x46836424, Offset: 0xee3
// Size: 0x2d
function setdeleteabletimer( time )
{
    self endon( #"entitydeleted" );
    wait time;
    self.deleteable = 1;
    manageworldspawnedprojectiles();
}

// Namespace xmike109
// Params 1
// Checksum 0xf9f390c9, Offset: 0xf18
// Size: 0xdd
function manageworldspawnedprojectiles( newstruct )
{
    if ( isdefined( newstruct ) )
    {
        temparr = [ newstruct ];
    }
    else
    {
        temparr = [];
    }
    
    foreach ( projectiles in level.xmike109projectiles )
    {
        if ( !isdefined( projectiles ) )
        {
            continue;
        }
        
        if ( isdefined( projectiles ) )
        {
            if ( temparr.size >= 4 && projectiles.deleteable )
            {
                projectiles delete();
                continue;
            }
            
            temparr[ temparr.size ] = projectiles;
        }
    }
    
    level.xmike109projectiles = temparr;
}

// Namespace xmike109
// Params 1
// Checksum 0x8bee9024, Offset: 0xffd
// Size: 0xb1
function getxmike109ammotype( weapon )
{
    foreach ( attachment in weapon.attachmentshash )
    {
        switch ( attachment )
        {
            case %"hash_34512ca5dd87fd5c":
                return "thermal";
            case %"hash_637eb00267ff06ef":
                return "explosive";
        }
    }
    
    return "default";
}

// Namespace xmike109
// Params 1
// Checksum 0xaab6d7cf, Offset: 0x10b7
// Size: 0x4c
function getxmike109impactfunc( ammotype )
{
    switch ( ammotype )
    {
        case #"hash_fd8321f2ca4fc7a0":
            return &impactfunc_fire;
        case #"hash_1cb749d9b456c694":
            return &impactfunc_explo;
        default:
            return &impactfunc_null;
    }
}

// Namespace xmike109
// Params 6
// Checksum 0xf0042da5, Offset: 0x110b
// Size: 0x134
function shouldreflect( surfacetype = "", ammotype, hitent, hitentpart, surfacenormal, bulletdir )
{
    if ( surfacetype == "riotshield" )
    {
        return 1;
    }
    
    if ( ammotype != "thermal" )
    {
        return 0;
    }
    
    if ( !isdefined( hitent ) && isdefined( hitentpart ) )
    {
        return 1;
    }
    
    if ( issameteamplayer( hitent ) || issameteamagent( hitent ) )
    {
        return 1;
    }
    
    if ( isenemyteamplayer( hitent ) || isenemyteamagent( hitent ) )
    {
        return 0;
    }
    
    if ( isdefined( hitent ) )
    {
        if ( hitent vehicle::is_vehicle() )
        {
            return 0;
        }
        
        if ( hitent.equipmentref == "equip_tac_cover" )
        {
            return 0;
        }
    }
    
    switch ( surfacetype )
    {
        case #"hash_321a9678047d0a4e":
        case #"hash_886109ae17c9aa73":
        case #"hash_8c9d4c67dcde81f2":
            return 1;
        default:
            dot = abs( vectordot( bulletdir, surfacenormal ) );
            
            if ( dot < 0.2 )
            {
                return 1;
            }
            else
            {
                return 0;
            }
            
            break;
    }
}

// Namespace xmike109
// Params 4
// Checksum 0xe07d01a9, Offset: 0x1247
// Size: 0xf3
function reflectprojectile( surfacenormal, bulletdir, impactpos, isgrenade )
{
    if ( isgrenade )
    {
        speedmax = 1500;
        speedmid = 500;
        speedmin = 150;
    }
    else
    {
        speedmax = 500;
        speedmid = 500;
        speedmin = 500;
    }
    
    vec = math::vector_reflect( bulletdir, surfacenormal );
    vec = vectorlerp( vec, surfacenormal, 0.2 );
    dot = abs( vectordot( bulletdir, surfacenormal ) );
    
    if ( dot < 0.2 )
    {
        dot = math::normalize_value( 0, 0.2, dot );
        reflect_velocity = math::factor_value( speedmax, speedmid, dot );
    }
    else
    {
        dot = math::normalize_value( 0.2, 1, dot );
        reflect_velocity = math::factor_value( speedmid, speedmin, dot );
    }
    
    vec *= reflect_velocity;
    return vec;
}

// Namespace xmike109
// Params 1
// Checksum 0x2286df2b, Offset: 0x1343
// Size: 0x45, Type: bool
function shoulddeleteimmediately( hitent )
{
    if ( !isdefined( hitent ) )
    {
        return false;
    }
    
    if ( isagent( hitent ) && hitent is_suicidebomber() && !isalive( hitent ) && !isdefined( hitent getcorpseentity() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace xmike109
// Params 2
// Checksum 0x8495e635, Offset: 0x1391
// Size: 0x26, Type: bool
function shouldlink( hitent, reflected )
{
    if ( reflected || !isdefined( hitent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace xmike109
// Params 0
// Checksum 0x3b7c8f28, Offset: 0x13c0
// Size: 0x11, Type: bool
function is_suicidebomber()
{
    return self.unittype == "suicidebomber";
}

// Namespace xmike109
// Params 3
// Checksum 0x11a720a3, Offset: 0x13da
// Size: 0x102
function linktoent( projectile, hitent, hitentpart )
{
    if ( ( isplayer( hitent ) || isagent( hitent ) ) && !isalive( hitent ) )
    {
        corpse = hitent getcorpseentity();
        
        if ( isdefined( corpse ) )
        {
            hitent = corpse;
        }
    }
    
    if ( isplayer( hitent ) )
    {
        projectile hidefromplayer( hitent );
    }
    
    if ( isdefined( hitentpart ) )
    {
        projectile linkto( hitent, hitentpart );
    }
    else
    {
        projectile linkto( hitent );
    }
    
    if ( cansticktoent( hitent ) )
    {
        projectile.stuckenemyentity = hitent;
        projectile thread removestuckenemyondeathordisconnect( hitent );
    }
    
    if ( !projectile.isgrenade )
    {
        projectile notsolid();
    }
    
    projectile thread projectileunlinkonnote( hitent );
    projectile thread projectiledeleteonnote( hitent, "vehicle_deleted" );
    projectile thread projectiledeleteonnote( hitent, "detonated" );
    projectile thread projectiledeleteonnote( hitent, "beginC130" );
    projectile thread projectiledeleteonnote( hitent, "recycled_to_uibot" );
}

// Namespace xmike109
// Params 0
// Checksum 0x13ba223, Offset: 0x14e4
// Size: 0x27
function validateprojectileent()
{
    if ( isdefined( self ) && self.isxmike109projectile )
    {
        return 1;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace xmike109
// Params 1
// Checksum 0x3cab46f, Offset: 0x1513
// Size: 0x60
function removestuckenemyondeathordisconnect( hitent )
{
    self endon( #"entitydeleted" );
    hitent utility::waittill_any( "entitydeleted", "death", "disconnect" );
    
    if ( !validateprojectileent() )
    {
        return;
    }
    
    self.stuckenemyentity = undefined;
    
    if ( isdefined( hitent ) && isdefined( hitent.nocorpse ) )
    {
        self delete();
    }
}

// Namespace xmike109
// Params 1
// Checksum 0x87a6a91f, Offset: 0x157b
// Size: 0x57
function projectileunlinkonnote( hitent )
{
    self endon( #"entitydeleted" );
    
    if ( isagent( hitent ) )
    {
        hitent waittill( #"entitydeleted" );
    }
    else
    {
        hitent utility::waittill_any( "entitydeleted", "disconnect" );
    }
    
    if ( !validateprojectileent() )
    {
        return;
    }
    
    projectileunlink();
}

// Namespace xmike109
// Params 1
// Checksum 0x944d309b, Offset: 0x15da
// Size: 0x52
function projectileunlink( launchvec = ( 0, 0, 100 ) )
{
    if ( self islinked() )
    {
        self unlink();
    }
    
    if ( !self.isgrenade )
    {
        self solid();
    }
    
    self physicslaunchserver( self.origin, launchvec );
}

// Namespace xmike109
// Params 2
// Checksum 0x4b0e225b, Offset: 0x1634
// Size: 0x38
function projectiledeleteonnote( hitent, note )
{
    self endon( #"entitydeleted" );
    hitent waittill( note );
    
    if ( !validateprojectileent() )
    {
        return;
    }
    
    self delete();
}

// Namespace xmike109
// Params 0
// Checksum 0x2aea457c, Offset: 0x1674
// Size: 0x2a
function projectiledeletethread()
{
    self waittill( #"entitydeleted" );
    
    if ( isdefined( self.grenade ) )
    {
        self.grenade delete();
    }
}

// Namespace xmike109
// Params 1
// Checksum 0xe8838784, Offset: 0x16a6
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

// Namespace xmike109
// Params 1
// Checksum 0x5b34175b, Offset: 0x16d9
// Size: 0x2b
function isenemyteamplayer( hitent )
{
    if ( !isplayer( hitent ) )
    {
        return 0;
    }
    
    if ( player_utility::isenemy( hitent ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace xmike109
// Params 1
// Checksum 0x6765baef, Offset: 0x170c
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

// Namespace xmike109
// Params 1
// Checksum 0xb68f4b17, Offset: 0x1749
// Size: 0x34, Type: bool
function isenemyteamagent( hitent )
{
    if ( !isagent( hitent ) )
    {
        return false;
    }
    
    if ( self.team == hitent.agentteam )
    {
        return false;
    }
    
    return true;
}

// Namespace xmike109
// Params 1
// Checksum 0x9a932627, Offset: 0x1786
// Size: 0xf4
function cansticktoent( hitent )
{
    canstick = 0;
    
    if ( isplayer( hitent ) || isagent( hitent ) )
    {
        canstick = 1;
    }
    
    if ( hitent vehicle::is_vehicle() )
    {
        canstick = 1;
    }
    
    if ( isdefined( hitent.classname ) )
    {
        if ( hitent.classname == "misc_turret" )
        {
            canstick = 1;
        }
        
        if ( hitent.classname == "script_model" )
        {
            if ( isdefined( hitent.streakinfo ) && ( hitent.streakinfo.streakname == "uav" || hitent.streakinfo.streakname == "gunship" ) )
            {
                canstick = 1;
            }
        }
    }
    
    if ( isdefined( hitent.equipmentref ) )
    {
        if ( hitent.equipmentref == "equip_tac_cover" )
        {
            canstick = 1;
        }
    }
    
    return canstick;
}

