// scripts\mp\common\equipment\wristrocket.gsc  (hash_194d7441baeaed20.gscc) (size: 5218 Bytes / 0x1462 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xddbcd3c8 (3720139720)
// size ...... 5218 (0x1462)
// includes .. 5   (offset: 0x131a)
// strings ... 18  (offset: 0x1342)
// dev strs .. 0   (offset: 0x1462)
// exports ... 22  (offset: 0xae6)
// cseg ...... 0x1b8 + 0x92e (0xae6)
// imports ... 41  (offset: 0xe56)
// animtree1 . 0   (offset: 0x1462)
// animtree2 . 0   (offset: 0x1462)
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\shellshock;
#using scripts\mp\weapons;

#namespace wristrocket;

// Namespace wristrocket
// Params 0
// Checksum 0x24ac0c9f, Offset: 0x1d6
// Size: 0x45
function wristrocketinit()
{
    level._effect[ "wristrocket_explode" ] = loadfxasset( "vfx_iw7_requests_mp_power_wrist_rocket_explo" );
    level._effect[ "wristrocket_thruster" ] = loadfxasset( "vfx_iw7_requests_mp_power_wrist_rocket_thruster" );
    weapons::registerusedcallback( "pop_rocket", &wristrocketused );
}

// Namespace wristrocket
// Params 0
// Checksum 0xdba029d6, Offset: 0x223
// Size: 0x9
function wristrocket_set()
{
    thread wristrocket_watcheffects();
}

// Namespace wristrocket
// Params 0
// Checksum 0xc174ca53, Offset: 0x234
// Size: 0xe
function wristrocket_unset()
{
    self notify( #"hash_52ae678de81eba52" );
}

// Namespace wristrocket
// Params 1
// Checksum 0xb9600387, Offset: 0x24a
// Size: 0xe0
function wristrocketused( grenade )
{
    if ( grenade.ticks >= 1 )
    {
        grenade.iscooked = 1;
    }
    
    grenade.originalowner = self;
    
    if ( grenade.tickpercent == 1 )
    {
        return;
    }
    
    rocket = wristrocket_createrocket( grenade );
    rocket.grenade = grenade;
    grenade = weapon::_launchgrenade( "pop_rocket_mp", self.origin, ( 0, 0, 0 ), 100, 1, grenade );
    grenade forcehidegrenadehudwarning( 1 );
    grenade linkto( rocket );
    grenade thread wristrocket_cleanuponparentdeath( rocket );
    grenade thread wristrocket_cleanuponownerdisconnect( self );
    rocket setscriptablepartstate( "launch", "active", 0 );
    rocket thread wristrocket_watchfuse( 2 );
    rocket thread wristrocket_watchstuck();
}

// Namespace wristrocket
// Params 1
// Checksum 0x20e62d2b, Offset: 0x332
// Size: 0x4e
function wristrocket_watchfuse( fusetime )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self notify( #"hash_6de16ed11ab97b25" );
    self endon( #"hash_6de16ed11ab97b25" );
    wait fusetime;
    thread wristrocket_explode();
}

// Namespace wristrocket
// Params 0
// Checksum 0x4fdfec19, Offset: 0x388
// Size: 0x9a
function wristrocket_watchstuck()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self waittill( #"missile_stuck", stuckto );
    
    if ( isplayer( stuckto ) )
    {
        self.owner weapons::grenadestuckto( self, stuckto );
    }
    
    self stoploopsound();
    self setscriptablepartstate( "stuck", "active", 0 );
    self setscriptablepartstate( "beacon", "active", 0 );
    self.grenade forcehidegrenadehudwarning( 0 );
    thread wristrocket_watchfuse( 1.35 );
}

// Namespace wristrocket
// Params 0
// Checksum 0xe9b6f57c, Offset: 0x42a
// Size: 0x3c
function wristrocket_explode()
{
    self setscriptablepartstate( "stuck", "neutral", 0 );
    self setscriptablepartstate( "beacon", "neutral", 0 );
    self setscriptablepartstate( "explode", "active", 0 );
    thread wristrocket_delete();
}

// Namespace wristrocket
// Params 0
// Checksum 0x86156ff6, Offset: 0x46e
// Size: 0x25
function wristrocket_delete()
{
    self notify( #"death" );
    self.exploding = 1;
    wait 0.1;
    self delete();
}

// Namespace wristrocket
// Params 1
// Checksum 0x884261ef, Offset: 0x49b
// Size: 0xa8
function wristrocket_createrocket( grenade )
{
    rocket = weapon_utility::_magicbullet( makeweapon( "pop_rocket_proj_mp" ), grenade.origin, grenade.origin + anglestoforward( self getgunangles() ), self );
    rocket.owner = self;
    rocket.team = self.team;
    rocket.weapon_name = "pop_rocket_proj_mp";
    rocket.power = "power_wristrocket";
    rocket setotherent( self );
    rocket setentityowner( self );
    rocket thread wristrocket_cleanuponownerdisconnect( self );
    return rocket;
}

// Namespace wristrocket
// Params 0
// Checksum 0x9a321814, Offset: 0x54c
// Size: 0x19d
function wristrocket_watcheffects()
{
    self endon( #"disconnect" );
    self notify( #"hash_b1f5c75362168986" );
    self endon( #"hash_b1f5c75362168986" );
    watchheldoffhandbreak = 0;
    
    while ( true )
    {
        raceresult = spawnstruct();
        
        if ( watchheldoffhandbreak )
        {
            childthread wristrocket_watcheffectsraceheldoffhandbreak( raceresult );
        }
        else
        {
            childthread wristrocket_watcheffectsracegrenadepullback( raceresult );
        }
        
        childthread wristrocket_watcheffectsracegrenadefired( raceresult );
        childthread wristrocket_watcheffectsracesuperstarted( raceresult );
        childthread wristrocket_watcheffectsracedeath( raceresult );
        childthread wristrocket_watcheffectsraceunset( raceresult );
        watchheldoffhandbreak = 0;
        self waittill( #"hash_f352049ead013b29" );
        waittillframeend();
        grenadepullback = istrue( raceresult.grenadepullback );
        grenadefire = istrue( raceresult.grenadefire );
        superstarted = istrue( raceresult.superstarted );
        death = istrue( raceresult.death );
        unset = istrue( raceresult.unset );
        heldoffhandbreak = istrue( raceresult.heldoffhandbreak );
        
        if ( death )
        {
            self notify( #"hash_2d8f6047e4d65f18" );
            thread wristrocket_endeffects();
            return;
        }
        else if ( unset )
        {
            self notify( #"hash_2d8f6047e4d65f18" );
            thread wristrocket_endeffects();
            return;
        }
        else if ( superstarted )
        {
            thread wristrocket_endeffects();
        }
        else if ( heldoffhandbreak )
        {
            thread wristrocket_endeffects();
        }
        else if ( grenadefire )
        {
            thread wristrocket_endeffects();
        }
        else if ( grenadepullback )
        {
            thread wristrocket_begineffects();
            watchheldoffhandbreak = 1;
        }
        
        self notify( #"hash_2d8f6047e4d65f18" );
    }
}

// Namespace wristrocket
// Params 1
// Checksum 0x162fae8a, Offset: 0x6f1
// Size: 0x6a
function wristrocket_watcheffectsracegrenadepullback( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    
    while ( true )
    {
        self waittill( #"grenade_pullback", objweapon );
        
        if ( objweapon.basename == "pop_rocket_mp" )
        {
            break;
        }
    }
    
    raceresult.grenadepullback = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 1
// Checksum 0x85b62781, Offset: 0x763
// Size: 0x74
function wristrocket_watcheffectsracegrenadefired( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon );
        
        if ( objweapon.basename == "pop_rocket_mp" )
        {
            break;
        }
    }
    
    raceresult.grenadefire = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 1
// Checksum 0xc4369ec7, Offset: 0x7df
// Size: 0x3f
function wristrocket_watcheffectsracesuperstarted( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    self waittill( #"super_started" );
    raceresult.superstarted = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 1
// Checksum 0x3f3422d6, Offset: 0x826
// Size: 0x3f
function wristrocket_watcheffectsracedeath( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    self waittill( #"death" );
    raceresult.death = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 1
// Checksum 0x601bcfe9, Offset: 0x86d
// Size: 0x3f
function wristrocket_watcheffectsraceunset( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    self waittill( #"hash_52ae678de81eba52" );
    raceresult.unset = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 1
// Checksum 0xf1ce140e, Offset: 0x8b4
// Size: 0x57
function wristrocket_watcheffectsraceheldoffhandbreak( raceresult )
{
    self endon( #"hash_2d8f6047e4d65f18" );
    waitframe();
    weapon = makeweapon( "pop_rocket_mp" );
    
    while ( self getheldoffhand() == weapon )
    {
        waitframe();
    }
    
    raceresult.heldoffhandbreak = 1;
    self notify( #"hash_f352049ead013b29" );
}

// Namespace wristrocket
// Params 0
// Checksum 0xc30f3bae, Offset: 0x913
// Size: 0x4e
function wristrocket_begineffects()
{
    self notify( #"hash_a74277fa81fb0038" );
    self endon( #"hash_a74277fa81fb0038" );
    self endon( #"hash_7613af118216fe34" );
    self setscriptablepartstate( "wristRocketWorld", "neutral", 0 );
    wait 0.15;
    self setscriptablepartstate( "wristRocketWorld", "active", 0 );
}

// Namespace wristrocket
// Params 0
// Checksum 0xab4c2891, Offset: 0x969
// Size: 0x1f
function wristrocket_endeffects()
{
    self notify( #"hash_7613af118216fe34" );
    self setscriptablepartstate( "wristRocketWorld", "neutral", 0 );
}

// Namespace wristrocket
// Params 5
// Checksum 0x4e1968c6, Offset: 0x990
// Size: 0xb9
function wristrocketcooksuicideexplodecheck( inflictor, attacker, victim, meansofdeath, objweapon )
{
    if ( attacker != victim )
    {
        return;
    }
    
    if ( meansofdeath != "MOD_SUICIDE" )
    {
        return;
    }
    
    if ( inflictor != attacker )
    {
        return;
    }
    
    if ( !isdefined( objweapon ) || objweapon.basename != "pop_rocket_mp" )
    {
        return;
    }
    
    explodepos = victim gettagorigin( "tag_weapon_left" );
    radiusdamage( explodepos, 175, 200, 70, attacker, "MOD_EXPLOSIVE", "pop_rocket_mp" );
    shellshock::grenade_earthquakeatposition( explodepos, 0.6 );
    playfx( utility::getfx( "wristrocket_explode" ), explodepos );
}

// Namespace wristrocket
// Params 2
// Checksum 0xba6dc7bb, Offset: 0xa51
// Size: 0x5c
function wristrocket_cleanuponparentdeath( parent, delay )
{
    self endon( #"death" );
    self notify( #"cleanuponparentdeath" );
    self endon( #"cleanuponparentdeath" );
    
    if ( isdefined( parent ) )
    {
        parent waittill( #"death" );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self delete();
}

// Namespace wristrocket
// Params 1
// Checksum 0xdf7f4a86, Offset: 0xab5
// Size: 0x31
function wristrocket_cleanuponownerdisconnect( owner )
{
    self endon( #"death" );
    owner waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

