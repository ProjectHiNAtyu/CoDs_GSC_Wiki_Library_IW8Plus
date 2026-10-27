// scripts\mp\meatshield.gsc  (hash_55e6a436b6b3048c.gscc) (size: 15007 Bytes / 0x3a9f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x867594ac (2255852716)
// size ...... 15007 (0x3a9f)
// includes .. 16  (offset: 0x3743)
// strings ... 47  (offset: 0x37c3)
// dev strs .. 5   (offset: 0x3a63)
// exports ... 38  (offset: 0x223f)
// cseg ...... 0x42b + 0x1e14 (0x223f)
// imports ... 125 (offset: 0x282f)
// animtree1 . 0   (offset: 0x3a9f)
// animtree2 . 0   (offset: 0x3a9f)
#using scripts\common\callbacks;
#using scripts\common\snapshot;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\entityheadicons;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;

#namespace meatshield;

// Namespace meatshield
// Params 0
// Checksum 0xd8a22c3e, Offset: 0x449
// Size: 0x183
function init()
{
    level.meatshieldduration = getmatchrulesdata( "commonOption", "meatShieldDuration" ) * 1000;
    level.meatshieldhealthscale = getmatchrulesdata( "commonOption", "meatShieldHealthScale" );
    level.meatshieldallowrelease = getmatchrulesdata( "commonOption", "meatShieldAllowRelease" ) || getdvarint( @"hash_78c7f180d6f5e7c4", 0 ) == 1;
    level.meatShieldAllowAirRelease = getmatchrulesdata( "commonOption", "meatShieldAllowAirRelease" ) || getdvarint( @"hash_6859431604dba0b2", 0 ) == 1;
    level.meatShieldDisableAutoAirRelease = getmatchrulesdata( "commonOption", "meatShieldDisableAutoAirRelease" ) || getdvarint( @"hash_635cea5d3e68185c", 0 ) == 1;
    level.meatshieldallowgiveup = getmatchrulesdata( "commonOption", "meatShieldAllowGiveUp" ) || getdvarint( @"hash_f656f5ce91f063d3", 0 ) == 1;
    level.meatshieldgiveupdelay = getmatchrulesdata( "commonOption", "meatShieldGiveUpDelay" );
    level.meatshieldgiveupspeed = getmatchrulesdata( "commonOption", "meatShieldGiveUpSpeed" );
    level.meatShieldOutlineVictimTeam = getmatchrulesdata( "commonOption", "meatShieldOutlineVictimTeam" );
    level.var_30443771afd8aeec = &function_90a9cd29f7f35d5a;
    level.var_c01db9496d27edfb = &function_7b409178ac9e2b21;
    setdvarifuninitialized( @"hash_c345ae56660f18a9", 1 );
    setdvarifuninitialized( @"hash_933400a8bdb6c6c9", 0 );
    
    /#
        thread function_56ddfe9d781201fa();
    #/
    
    callback::add( #"on_ping", &function_3d3511fdf8fede84 );
}

// Namespace meatshield
// Params 0
// Checksum 0xefe9f6e4, Offset: 0x5d4
// Size: 0xa0
function meatshield_initplayer()
{
    player = self;
    player.meatshielddamagetaken = 0;
    player.meatshieldendtime = 0;
    player.var_8a43cc698bcca00d = 0;
    player.meatshielddamageblocked = 0;
    player.meatshieldmaxhealth = max( 1, player.maxhealth * ( level.meatshieldhealthscale ?? 1 ) );
    player.meatshieldicons = [];
    player.meatshieldtracking = [];
    thread function_29d75b2568cf0227();
    thread function_3c340a73450fda3a();
    player thread function_8fd32ae6a25decc2();
}

// Namespace meatshield
// Params 0
// Checksum 0x339df22c, Offset: 0x67c
// Size: 0x6b
function function_29d75b2568cf0227()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player = self;
    
    while ( true )
    {
        player waittill( #"meatshield_victim_start" );
        meatshield_victim_startmeatshield();
        player thread function_a27ec35c5417a6a();
        player thread function_997fa737d556a945();
        player waittill( #"meatshield_victim_stop" );
        meatshield_victim_stopmeatshield();
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x3e07dc73, Offset: 0x6ef
// Size: 0x135
function function_a27ec35c5417a6a()
{
    self endon( #"meatshield_victim_stop" );
    self endon( #"hash_61b26892048f0552" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player = self;
    attacker = player getmeatshieldpartner();
    var_a98fa63b20ffa9a7 = ( player.meatshieldendtime - player.var_8a43cc698bcca00d ) * 0.001;
    damagepertick = player.meatshieldmaxhealth / ( var_a98fa63b20ffa9a7 + 1 ) / 20;
    var_365f14bad812d04c = player.meatshieldmaxhealth / level.meatshieldgiveupspeed / 20;
    
    while ( true )
    {
        isgivingup = istrue( player.var_cbe460eee3c10787 );
        tickdamagemode = getdvarint( @"hash_c345ae56660f18a9", 1 );
        
        if ( tickdamagemode != 0 || isgivingup )
        {
            if ( player.var_8a43cc698bcca00d < gettime() )
            {
                damage = isgivingup ? var_365f14bad812d04c : damagepertick;
                function_1fd576a60f12c8da( attacker, damage, 0, 0 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace meatshield
// Params 0
// Checksum 0xbee0a453, Offset: 0x82c
// Size: 0x1af
function meatshield_victim_startmeatshield()
{
    victim = self;
    victim.meatshielddamagetaken = 0;
    victim.meatshieldendtime = gettime() + level.meatshieldduration;
    victim.meatshieldmaxhealth = max( 1, victim.maxhealth * level.meatshieldhealthscale );
    victim.var_8a43cc698bcca00d = gettime();
    victim.var_8a43cc698bcca00d = min( victim.var_8a43cc698bcca00d, victim.meatshieldendtime );
    victim function_762ceecbf20a7b88( 0 );
    thread battlechatter_mp::trysaylocalsound( self, #"bc_combat_body_shield_react", 1 );
    
    if ( !victim utility::isusingremote() )
    {
        victim shellshock( "meatshield_victim", 3 );
    }
    
    victim notify( #"meatshield_victim_grabbed" );
    victim setclientomnvar( "ui_meat_shield_health", 1 );
    gamelogic_mp::sethasdonecombat( victim, 1 );
    victim thread function_cd6e209b266f19c();
    
    foreach ( player in level.players )
    {
        if ( victim.team == player.team )
        {
            player thread hud_message::showsplash( "used_meatshield_victim", undefined, victim );
        }
    }
    
    victim function_242ded1f477206e6( 1 );
    victim thread function_dab648630e11b489();
    outofbounds::enableoobimmunity( victim );
}

// Namespace meatshield
// Params 0
// Checksum 0xa643efc2, Offset: 0x9e3
// Size: 0x8c
function meatshield_victim_stopmeatshield()
{
    player = self;
    player.meatshieldhealth = 0;
    player.var_8a43cc698bcca00d = 0;
    player.meatshieldendtime = 0;
    player.meatshielddamagetaken = 0;
    player function_762ceecbf20a7b88( 1 );
    player stopshellshock();
    player setclientomnvar( "ui_meat_shield_health", 0 );
    player function_242ded1f477206e6( 0 );
    player function_54ea3f3fa2c73a8a( 0 );
    
    if ( isdefined( player.oobimmunity ) )
    {
        outofbounds::disableoobimmunity( player );
    }
}

// Namespace meatshield
// Params 1
// Checksum 0x5b9a2f4e, Offset: 0xa77
// Size: 0x2f
function function_762ceecbf20a7b88( enabled )
{
    self allowprone( enabled );
    self allowcrouch( enabled );
    val::set( "meatshield", "killstreaks", enabled );
}

// Namespace meatshield
// Params 1
// Checksum 0x43e994d2, Offset: 0xaae
// Size: 0x19f
function function_242ded1f477206e6( enabled )
{
    if ( isbot( self ) || !level.meatshieldallowgiveup )
    {
        return;
    }
    
    commands = [ [ "meatShieldGiveUpPressed", "+stancedown" ], [ "meatShieldGiveUpPressed", "+movedown" ], [ "meatShieldGiveUpPressed", "+prone" ], [ "meatShieldGiveUpPressed", "+stance" ], [ "meatShieldGiveUpPressed", "+togglecrouch" ], [ "meatShieldGiveUpReleased", "-stancedown" ], [ "meatShieldGiveUpReleased", "-movedown" ], [ "meatShieldGiveUpReleased", "-prone" ], [ "meatShieldGiveUpReleased", "-stance" ], [ "meatShieldGiveUpReleased", "-togglecrouch" ] ];
    
    foreach ( command in commands )
    {
        if ( enabled )
        {
            self notifyonplayercommand( command[ 0 ], command[ 1 ] );
            continue;
        }
        
        self notifyonplayercommandremove( command[ 0 ], command[ 1 ] );
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x8291260f, Offset: 0xc55
// Size: 0x71
function function_dab648630e11b489()
{
    self endon( #"disconnect" );
    self endon( #"meatshield_victim_stop" );
    level endon( #"game_ended" );
    self.var_cbe460eee3c10787 = 0;
    wait level.meatshieldgiveupdelay;
    
    while ( true )
    {
        self waittill( #"meatShieldGiveUpPressed" );
        self.var_cbe460eee3c10787 = 1;
        self waittill( #"meatShieldGiveUpReleased" );
        self.var_cbe460eee3c10787 = 0;
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x7a2ea5d5, Offset: 0xcce
// Size: 0x4d
function function_997fa737d556a945()
{
    self endon( #"disconnect" );
    self endon( #"meatshield_victim_stop" );
    level endon( #"game_ended" );
    
    if ( !level.meatshieldallowgiveup )
    {
        return;
    }
    
    self function_54ea3f3fa2c73a8a( 0 );
    wait level.meatshieldgiveupdelay;
    self function_54ea3f3fa2c73a8a( 1 );
}

// Namespace meatshield
// Params 1
// Checksum 0x13c863d1, Offset: 0xd23
// Size: 0x48, Type: bool
function function_222c414f9985817e( einflictor )
{
    victim = self;
    
    if ( !isdefined( einflictor ) )
    {
        return false;
    }
    
    if ( !einflictor.remotekillstreak )
    {
        return false;
    }
    
    if ( einflictor.owner != victim )
    {
        return false;
    }
    
    return true;
}

// Namespace meatshield
// Params 4
// Checksum 0xbe0bffdf, Offset: 0xd74
// Size: 0x17e
function function_1fd576a60f12c8da( attacker, damage, issuicide, bulletdamage )
{
    victim = self;
    victim.meatshielddamagetaken += damage;
    var_9bdf3d31ef8b116 = 0;
    
    if ( victim.meatshielddamagetaken >= victim.meatshieldmaxhealth )
    {
        victim.meatshielddamagetaken = 0;
        
        if ( issuicide )
        {
            victim stopmeatshield( 12 );
        }
        else
        {
            victim stopmeatshield( 11 );
        }
    }
    else if ( victim.meatshielddamagetaken > 0 )
    {
        shield_health_fraction = victim.meatshielddamagetaken / victim.meatshieldmaxhealth;
        var_9bdf3d31ef8b116 = 1 - shield_health_fraction;
    }
    
    victim setclientomnvar( "ui_meat_shield_health", var_9bdf3d31ef8b116 );
    meatshieldattacker = victim getmeatshieldpartner();
    
    if ( isdefined( meatshieldattacker ) )
    {
        meatshieldattacker setclientomnvar( "ui_meat_shield_health", var_9bdf3d31ef8b116 );
        
        if ( bulletdamage )
        {
            if ( !isdefined( meatshieldattacker.meatshielddamageblocked ) )
            {
                meatshieldattacker.meatshielddamageblocked = 0;
            }
            
            newdamageblocked = meatshieldattacker.meatshielddamageblocked + damage;
            
            if ( int( newdamageblocked / 100 ) > int( meatshieldattacker.meatshielddamageblocked / 100 ) )
            {
                meatshieldattacker thread points::doscoreevent( #"meat_shield_block" );
            }
            
            meatshieldattacker.meatshielddamageblocked = newdamageblocked;
        }
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x39d5fe3b, Offset: 0xefa
// Size: 0x65
function function_3c340a73450fda3a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player = self;
    
    while ( true )
    {
        player waittill( #"meatshield_attacker_start" );
        meatshield_attacker_startmeatshield();
        player waittill( #"meatshield_attacker_stop", end_state );
        function_a26990d521c708c1( end_state );
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x26a6bba0, Offset: 0xf67
// Size: 0x7c
function function_a7d16f424c62b261()
{
    self endon( #"disconnect" );
    self endon( #"meatshield_attacker_stop" );
    level endon( #"game_ended" );
    player = self;
    
    while ( true )
    {
        enemies = teams::getenemyplayers( player.team, 1 );
        
        if ( enemies.size == 1 && player.var_6a1a9d1f0ece4501 == enemies[ 0 ] )
        {
            player function_d3b9062b19a5a613();
        }
        
        waitframe();
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x164ff7d7, Offset: 0xfeb
// Size: 0x137
function meatshield_attacker_startmeatshield()
{
    attacker = self;
    attacker function_1504fe8f55f64724();
    attacker val::set( "meatshield", "killstreaks", 0 );
    attacker.meatshielddamageblocked = 0;
    attacker.var_6a1a9d1f0ece4501 = attacker getmeatshieldpartner();
    attacker function_da68d58a27cc4413( 1 );
    attacker setclientomnvar( "ui_meat_shield_health", 1 );
    attacker function_e64aed648414c0e3();
    
    if ( !isdefined( level.nbmeatshield ) )
    {
        level.nbmeatshield = 0;
    }
    
    level.nbmeatshield++;
    attacker.var_5fb71583e042b0bd = gettime();
    gamelogic_mp::sethasdonecombat( attacker, 1 );
    attacker thread function_cd6e209b266f19c();
    attacker thread points::doscoreevent( #"meat_shield_start" );
    
    if ( level.meatshieldallowrelease )
    {
        attacker function_c75226e65cdb5d07( 1 );
        attacker function_7512e0b0f6708ce4( level.meatShieldAllowAirRelease );
        attacker function_9a8e875c0add0efb( !level.meatShieldDisableAutoAirRelease );
    }
    
    attacker thread hud_message::showsplash( "used_meatshield_attacker", undefined, attacker );
    attacker thread meatshield_attacker_watchgameend();
    
    if ( isbrgamemode() && !gamelogic_mp::inprematch() )
    {
        attacker thread function_a7d16f424c62b261();
    }
    
    attacker thread function_995c5a99f24e0bec();
}

// Namespace meatshield
// Params 1
// Checksum 0xefbfecc9, Offset: 0x112a
// Size: 0x7d
function function_a26990d521c708c1( end_state )
{
    player = self;
    player function_53e956e7639bc10a();
    player val::set( "meatshield", "killstreaks", 1 );
    player.meatshielddamageblocked = 0;
    player function_da68d58a27cc4413( 0 );
    player setclientomnvar( "ui_meat_shield_health", 0 );
    player.end_state = end_state;
    player function_4c60393cae9dd54d();
    player.var_6a1a9d1f0ece4501 = undefined;
}

// Namespace meatshield
// Params 0
// Checksum 0x20e1481e, Offset: 0x11af
// Size: 0x115
function function_ac4443348fd72c45()
{
    meatshieldweapon = weapon_utility::function_d2c8356dc369d9ce( "sat_pi_timir_mp" );
    
    foreach ( weap in self.primaryweapons )
    {
        if ( function_dba007d7ce101368( weap ) )
        {
            if ( weapon::isbackuppistol( weap ) )
            {
                max_ammo = weaponmaxammo( weap );
                clipsize = weaponclipsize( weap );
                self setweaponammoclip( weap, clipsize );
                self setweaponammostock( weap, max_ammo );
                return;
            }
            
            if ( self getweaponammostock( weap ) > 0 )
            {
                return;
            }
            
            if ( meatshieldweapon == weap )
            {
                startammo = weaponstartammo( weap );
                clipsize = weaponclipsize( weap );
                self setweaponammoclip( weap, clipsize );
                self setweaponammostock( weap, startammo - clipsize );
            }
        }
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x42a40033, Offset: 0x12cc
// Size: 0x9c
function function_1504fe8f55f64724()
{
    player = self;
    player function_ac4443348fd72c45();
    
    if ( !player function_ffd4a8346a530948() )
    {
        player.switchweapon = player getcurrentweapon();
        meatshieldweapon = weapon_utility::function_d2c8356dc369d9ce( "sat_pi_timir_mp" );
        player giveweapon( meatshieldweapon );
        player.var_7b43fa401e246af5 = meatshieldweapon;
    }
    
    if ( !player function_b9f2d25082351152() && player function_4b34705f9545ab8b() )
    {
        meatshieldweapon = weapon_utility::function_d2c8356dc369d9ce( "sat_semtex_mp" );
        player giveweapon( meatshieldweapon, 0, 0, 0, 0, 1 );
        player.var_9bd38cf80eb211b1 = meatshieldweapon;
    }
}

// Namespace meatshield
// Params 0
// Checksum 0xaeb40db0, Offset: 0x1370
// Size: 0x86
function function_53e956e7639bc10a()
{
    player = self;
    
    if ( isdefined( player.var_7b43fa401e246af5 ) )
    {
        player takeweapon( player.var_7b43fa401e246af5 );
        player.var_7b43fa401e246af5 = undefined;
        player inventory_utility::domonitoredweaponswitch( player.switchweapon );
        player.switchweapon = undefined;
    }
    
    if ( isdefined( player.var_9bd38cf80eb211b1 ) )
    {
        player takeweapon( player.var_9bd38cf80eb211b1 );
        player.var_9bd38cf80eb211b1 = undefined;
    }
}

// Namespace meatshield
// Params 1
// Checksum 0xc9c0cca7, Offset: 0x13fe
// Size: 0x138
function function_da68d58a27cc4413( show )
{
    victim = self.var_6a1a9d1f0ece4501;
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    victimteam = victim.team;
    var_885912bf9e3b1e64 = teams::getteamdata( victimteam, "players" );
    
    foreach ( trackedplayer in var_885912bf9e3b1e64 )
    {
        if ( isdefined( trackedplayer ) && trackedplayer != victim )
        {
            self setplayercompassoriginstoclient( 2, trackedplayer, show );
            entnum = trackedplayer getentitynumber();
            
            if ( isdefined( entnum ) )
            {
                self.meatshieldtracking[ entnum ] = show;
                
                if ( !show )
                {
                    self.var_bdafa8b75c3b0948[ entnum ] = gettime();
                }
            }
            
            if ( show && level.meatShieldOutlineVictimTeam )
            {
                meatshield_attacker_markplayer( trackedplayer );
            }
        }
    }
    
    if ( !show )
    {
        function_a245c98ce4b5d1d7();
    }
}

// Namespace meatshield
// Params 2
// Checksum 0x6e074aa9, Offset: 0x153e
// Size: 0x67
function meatshield_attacker_markplayer( victim, show )
{
    if ( isplayer( victim ) )
    {
        icon = victim entityheadicons::setheadicon_singleimage( self, "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1 );
        victim snapshot::function_c802f1ac50040a2c();
        self.meatshieldicons[ self.meatshieldicons.size ] = icon;
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x7f879888, Offset: 0x15ad
// Size: 0x85
function function_a245c98ce4b5d1d7()
{
    foreach ( icon in self.meatshieldicons )
    {
        entityheadicons::setheadicon_deleteicon( icon );
    }
    
    self.meatshieldicons = [];
}

// Namespace meatshield
// Params 0
// Checksum 0x6e4881a1, Offset: 0x163a
// Size: 0x2f
function meatshield_attacker_watchgameend()
{
    self endon( #"disconnect" );
    self endon( #"meatshield_attacker_stop" );
    level waittill( #"game_ended" );
    self stopmeatshield( 8 );
}

// Namespace meatshield
// Params 1
// Checksum 0x7f475b8e, Offset: 0x1671
// Size: 0xe8
function function_995c5a99f24e0bec( victimcorpse )
{
    self endon( #"disconnect" );
    self endon( #"meatshield_attacker_stop" );
    self waittill( #"hash_10cb09392cc58136" );
    victimcorpse = self.var_6a1a9d1f0ece4501 getcorpseentity();
    
    if ( !isdefined( victimcorpse ) || !isdefined( self ) )
    {
        return;
    }
    
    fusetime = getdvarint( @"hash_1f53a3229cd0ed39", 3000 ) / 1000;
    grenade = magicgrenademanual( "sat_semtex_mp", ( 0, 0, 0 ), ( 0, 0, 0 ), fusetime, self );
    grenade linkto( victimcorpse, "tag_ik_target_right_character", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    grenade.var_2805eec786427e6a = 1;
    victimcorpse thread function_dfb630780420556( grenade, fusetime );
    victimcorpse thread function_3436e9891a7de127();
}

// Namespace meatshield
// Params 0
// Checksum 0x90d899ec, Offset: 0x1761
// Size: 0x38
function function_cd6e209b266f19c()
{
    self endon( #"disconnect" );
    self endon( #"meatshield_attacker_stop" );
    self endon( #"meatshield_victim_stop" );
    
    while ( true )
    {
        class::function_e441c383fc2c59c9();
        wait 1;
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x41f4a18e, Offset: 0x17a1
// Size: 0x35, Type: bool
function function_b5218f19fcb8e4d8()
{
    if ( self.var_20fb6d9e02a1d35 )
    {
        return true;
    }
    
    if ( !self ismeatshieldvictim() )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_933400a8bdb6c6c9", 0 ) == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace meatshield
// Params 0
// Checksum 0xecd748ab, Offset: 0x17df
// Size: 0x12
function function_db06fbfec0ffa2eb()
{
    if ( self ismeatshieldattacker() )
    {
        self stopmeatshield( 4 );
    }
}

// Namespace meatshield
// Params 1
// Checksum 0x7d2ed1a, Offset: 0x17f9
// Size: 0x14
function function_90a9cd29f7f35d5a( enabled )
{
    self function_3181733c19782bcc( enabled );
}

// Namespace meatshield
// Params 1
// Checksum 0xed55e138, Offset: 0x1815
// Size: 0x14
function function_7b409178ac9e2b21( enabled )
{
    self function_134cd2c60d3a7edf( enabled );
}

// Namespace meatshield
// Params 2
// Checksum 0x2beb868f, Offset: 0x1831
// Size: 0x30
function function_260649e43b07711d( fusetime, grenadeentity )
{
    wait fusetime;
    
    if ( grenadeentity )
    {
        grenadeentity detonate();
    }
    
    self notify( #"hash_7c4c1b2094aa9251" );
}

// Namespace meatshield
// Params 2
// Checksum 0x29169d2, Offset: 0x1869
// Size: 0x58
function function_dfb630780420556( grenadeentity, fusetime )
{
    level endon( #"game_ended" );
    self endon( #"hash_7c4c1b2094aa9251" );
    childthread function_260649e43b07711d( fusetime, grenadeentity );
    self waittill( #"hash_90075ccbe6206a41", var_f70a336c0f3f06b0 );
    grenadeentity function_1422f0860a2af301( var_f70a336c0f3f06b0 );
}

// Namespace meatshield
// Params 0
// Checksum 0x78a8c7a8, Offset: 0x18c9
// Size: 0x146
function function_3436e9891a7de127()
{
    level endon( #"game_ended" );
    self endon( #"hash_7c4c1b2094aa9251" );
    self endon( #"hash_90075ccbe6206a41" );
    
    if ( !level.a_e_portals )
    {
        return;
    }
    
    while ( true )
    {
        contents = physics_createcontents( [ "physicscontents_trigger" ] );
        var_ab3e1c6b6c053625 = trace::sphere_trace_get_all_results( self.origin, self.origin, 10, self, contents );
        has_debug = isdefined( var_ab3e1c6b6c053625[ #"debugdata" ] ) + isdefined( var_ab3e1c6b6c053625[ var_ab3e1c6b6c053625.size - 1 ][ "type" ] );
        
        for ( i = 0; i < var_ab3e1c6b6c053625.size - has_debug ; i++ )
        {
            traceinfo = var_ab3e1c6b6c053625[ i ];
            
            switch ( traceinfo[ "hittype" ] )
            {
                case #"hash_c9ca635313f9bc38":
                    traced_entity = traceinfo[ "entity" ];
                    
                    if ( issubstr( traced_entity.code_classname, "trigger" ) )
                    {
                        if ( traced_entity.script_noteworthy === "portal_grenade_catcher" )
                        {
                            traced_entity notify( #"portal", self );
                            return;
                        }
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        waitframe();
    }
}

// Namespace meatshield
// Params 0
// Checksum 0xbe69c5ea, Offset: 0x1a17
// Size: 0x149
function function_8fd32ae6a25decc2()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player = self;
    
    while ( true )
    {
        player waittill( #"meatshield_state_change", newmode );
        isattacker = player ismeatshieldattacker();
        
        if ( newmode == 0 )
        {
        }
        else if ( newmode >= 1 && newmode <= 2 )
        {
            if ( isattacker )
            {
                self playsoundtoplayer( #"hash_d451ea9ae114f25d", self );
                player.is_meat_shield_grab = 1;
            }
            else
            {
                self playsoundtoplayer( #"hash_8ae0bc9be9e5a54c", self );
            }
        }
        else if ( newmode == 3 )
        {
            if ( isattacker )
            {
                player.is_meat_shield_grab = 0;
            }
        }
        else if ( newmode >= 4 && newmode <= 14 )
        {
            if ( isattacker )
            {
                self playsoundtoplayer( #"hash_ee46122c811799c6", self );
            }
            else
            {
                self playsoundtoplayer( #"hash_af2eb4ee552ab479", self );
            }
        }
        
        self.meatshieldstate = newmode;
        callbackparams = { #newmode:newmode, #isattacker:isattacker, #player:self };
        callback::callback( #"hash_a4ace31d68ec84e2", callbackparams );
    }
}

// Namespace meatshield
// Params 0
// Checksum 0x59961afe, Offset: 0x1b68
// Size: 0xcd
function function_4c60393cae9dd54d()
{
    self.var_5fb71583e042b0bd = ( gettime() - self.var_5fb71583e042b0bd ) / 1000;
    
    if ( !isdefined( self.end_state ) )
    {
        self.end_state = 0;
    }
    
    self dlog_recordplayerevent( "dlog_event_meat_shield", [ "damage_dealt", self.meat_shield_damage_dealt, "total_time_spent", self.var_5fb71583e042b0bd, "eliminations", self.meat_shield_eliminations, "end_state", self.end_state ] );
    
    if ( self.is_meat_shield_grab == 1 )
    {
        if ( !isdefined( level.var_8b935d1f6cdc1b6 ) )
        {
            level.var_8b935d1f6cdc1b6 = 0;
        }
        
        level.var_8b935d1f6cdc1b6++;
    }
    
    function_e64aed648414c0e3();
}

// Namespace meatshield
// Params 0
// Checksum 0xa9e09f88, Offset: 0x1c3d
// Size: 0x2a
function function_e64aed648414c0e3()
{
    self.meat_shield_damage_dealt = 0;
    self.var_5fb71583e042b0bd = 0;
    self.meat_shield_eliminations = 0;
    self.end_state = 0;
}

// Namespace meatshield
// Params 1
// Checksum 0xd55703be, Offset: 0x1c6f
// Size: 0x146
function function_3d3511fdf8fede84( params )
{
    pingowner = params.player;
    pingindex = params.pingindex;
    
    if ( isdefined( pingowner ) && isdefined( pingindex ) )
    {
        var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
        
        if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 16 ) )
        {
            attacker = pingowner getmeatshieldpartner();
            
            if ( isdefined( attacker ) )
            {
                attacker thread hud_message::showsplash( "callforhelp_meatshield_attacker", undefined, pingowner );
            }
            
            foreach ( player in level.players )
            {
                splashref = undefined;
                
                if ( player == pingowner )
                {
                    splashref = "callforhelp_meatshield_victim";
                }
                else if ( player.team == pingowner.team )
                {
                    splashref = "callforhelp_meatshield_team";
                }
                
                if ( isdefined( splashref ) )
                {
                    player thread hud_message::showsplash( splashref, undefined, pingowner );
                }
            }
        }
    }
}

/#

    // Namespace meatshield
    // Params 0
    // Checksum 0x361cf3b8, Offset: 0x1dbd
    // Size: 0x482, Type: dev
    function function_56ddfe9d781201fa()
    {
        setdevdvarifuninitialized( @"hash_752231be3b803e3d", -1 );
        setdevdvarifuninitialized( @"hash_ec059bc7573bd896", -1 );
        setdevdvarifuninitialized( @"hash_752705d2d75a78dd", -1 );
        setdevdvarifuninitialized( @"hash_678df4f4212353c0", -1 );
        setdevdvarifuninitialized( @"hash_7be3e689347d36c3", -1 );
        setdevdvarifuninitialized( @"hash_8330887aabaa5995", -1 );
        setdevdvarifuninitialized( @"hash_4647a1b5b41936ae", -1 );
        var_28970dc560cc17f = [];
        
        while ( true )
        {
            wait 1;
            attackerentnum = getdvarint( @"hash_752231be3b803e3d", -1 );
            victimentnum = getdvarint( @"hash_ec059bc7573bd896", -1 );
            splashdebug = getdvarint( @"hash_752705d2d75a78dd", -1 );
            disableattacker = getdvarint( @"hash_678df4f4212353c0", -1 );
            disablevictim = getdvarint( @"hash_7be3e689347d36c3", -1 );
            var_f3e93c84993b493b = getdvarint( @"hash_8330887aabaa5995", -1 );
            var_d314624fca7bace0 = getdvarint( @"hash_4647a1b5b41936ae", -1 );
            
            if ( splashdebug > 0 )
            {
                splashref = undefined;
                
                switch ( splashdebug )
                {
                    case 1:
                        splashref = "<dev string:x24>";
                        break;
                    case 2:
                        splashref = "<dev string:x3d>";
                        break;
                    case 3:
                        splashref = "<dev string:x54>";
                        break;
                    case 4:
                        splashref = "<dev string:x74>";
                        break;
                    case 5:
                        splashref = "<dev string:x92>";
                        break;
                }
                
                if ( isdefined( splashref ) )
                {
                    foreach ( player in level.players )
                    {
                        player thread hud_message::showsplash( splashref, undefined, player );
                    }
                }
                
                setdvar( @"hash_752705d2d75a78dd", -1 );
            }
            
            if ( disableattacker >= 0 )
            {
                disableent = getentbynum( disableattacker );
                disableent function_3181733c19782bcc( 0 );
                setdvar( @"hash_678df4f4212353c0", -1 );
            }
            else if ( disablevictim >= 0 )
            {
                disableent = getentbynum( disablevictim );
                disableent function_134cd2c60d3a7edf( 0 );
                setdvar( @"hash_7be3e689347d36c3", -1 );
            }
            else if ( var_f3e93c84993b493b >= 0 )
            {
                disableent = getentbynum( var_f3e93c84993b493b );
                disableent function_3181733c19782bcc( 1 );
                setdvar( @"hash_8330887aabaa5995", -1 );
            }
            else if ( var_d314624fca7bace0 >= 0 )
            {
                disableent = getentbynum( var_d314624fca7bace0 );
                disableent function_134cd2c60d3a7edf( 1 );
                setdvar( @"hash_4647a1b5b41936ae", -1 );
            }
            
            if ( attackerentnum == -2 || victimentnum == -2 )
            {
                for ( i = 0; i < var_28970dc560cc17f.size ; i++ )
                {
                    victim = var_28970dc560cc17f[ i ].victim;
                    attacker = var_28970dc560cc17f[ i ].attacker;
                    
                    if ( !( isdefined( victim ) && isdefined( attacker ) ) || !isplayer( victim ) || !isplayer( attacker ) )
                    {
                        continue;
                    }
                    
                    if ( victim ismeatshieldvictim() && attacker ismeatshieldattacker() )
                    {
                        victim stopmeatshield( 14 );
                    }
                }
                
                attackerentnum = setdvar( @"hash_752231be3b803e3d", -1 );
                victimentnum = setdvar( @"hash_ec059bc7573bd896", -1 );
                var_28970dc560cc17f = [];
                continue;
            }
            
            if ( attackerentnum == -1 || victimentnum == -1 )
            {
                continue;
            }
            
            victiment = getentbynum( victimentnum );
            attackerent = getentbynum( attackerentnum );
            
            if ( !( isdefined( victiment ) && isdefined( attackerent ) ) || !isplayer( victiment ) || !isplayer( attackerent ) )
            {
                continue;
            }
            
            meatshieldpair = spawnstruct();
            meatshieldpair.attacker = attackerent;
            meatshieldpair.victim = victiment;
            var_28970dc560cc17f[ var_28970dc560cc17f.size ] = meatshieldpair;
            victiment startmeatshield( attackerent );
            attackerentnum = setdvar( @"hash_752231be3b803e3d", -1 );
            victimentnum = setdvar( @"hash_ec059bc7573bd896", -1 );
        }
    }

#/
