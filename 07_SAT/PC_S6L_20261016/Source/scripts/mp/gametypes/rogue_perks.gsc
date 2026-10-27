// scripts\mp\gametypes\rogue_perks.gsc  (hash_0659fab11df906cc.gscc) (size: 3799 Bytes / 0xed7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8fdc14e (2835202382)
// size ...... 3799 (0xed7)
// includes .. 6   (offset: 0xddf)
// strings ... 13  (offset: 0xe0f)
// dev strs .. 1   (offset: 0xec3)
// exports ... 14  (offset: 0x8a7)
// cseg ...... 0x1a7 + 0x700 (0x8a7)
// imports ... 27  (offset: 0xad7)
// animtree1 . 0   (offset: 0xed7)
// animtree2 . 0   (offset: 0xed7)
#using scripts\common\utility;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\equipment\snapshot_grenade;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;

#namespace rogue_perks;

// Namespace rogue_perks
// Params 1
// Checksum 0x3f50cc48, Offset: 0x1c5
// Size: 0x58
function dohealing( amount )
{
    health = self.health;
    health += int( amount );
    
    if ( health > self.maxhealth )
    {
        health = self.maxhealth;
    }
    
    self.health = health;
    hud_message::function_32921bf72811da6e();
}

// Namespace rogue_perks
// Params 0
// Checksum 0xf08da6b4, Offset: 0x225
// Size: 0xe1
function function_c18cfe0308e7e51()
{
    level utility::flag_wait( "onStartGameTypeFinished" );
    level.perksetfuncs[ "specialty_rogue_snapshotkills" ] = &ability_snapshotkills;
    level.perkunsetfuncs[ "specialty_rogue_snapshotkills" ] = &function_56d755a09cd47fe3;
    level.perksetfuncs[ "specialty_rogue_shockstickkills" ] = &ability_shockstickkills;
    level.perkunsetfuncs[ "specialty_rogue_shockstickkills" ] = &function_13d222de5497df89;
    level.perksetfuncs[ "specialty_rogue_smokeheals" ] = &ability_smokeheals;
    level.perkunsetfuncs[ "specialty_rogue_smokeheals" ] = &function_663c9fcba9c7243e;
    level.perksetfuncs[ "specialty_rogue_infinitetacsprint" ] = &ability_infinitetacsprint;
    level.perkunsetfuncs[ "specialty_rogue_infinitetacsprint" ] = &function_b4e563eb9b27d77a;
    level.perksetfuncs[ "specialty_rogue_instantsmoke" ] = &ability_instantsmoke;
    level.perkunsetfuncs[ "specialty_rogue_instantsmoke" ] = &function_6919b9801f9ce68c;
}

// Namespace rogue_perks
// Params 0
// Checksum 0x7e90e728, Offset: 0x30e
// Size: 0xa9
function ability_snapshotkills()
{
    level endon( #"game_ended" );
    self endon( #"hash_504033799171a581" );
    snapshotbundle = getscriptbundle( level.roguedata.var_d495ccc141e46f41 );
    
    if ( !isdefined( snapshotbundle ) )
    {
        assertmsg( "<dev string:x24>" + level.roguedata.var_d495ccc141e46f41 );
    }
    
    while ( true )
    {
        self waittill( #"killed_enemy", meansofdeath, victim );
        thread snapshot_grenade::snapshot_grenade_watch_flight( victim.origin, 0, 380, 1250, snapshotbundle );
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0x891665f3, Offset: 0x3bf
// Size: 0xe
function function_56d755a09cd47fe3()
{
    self notify( #"hash_504033799171a581" );
}

// Namespace rogue_perks
// Params 0
// Checksum 0x338a045b, Offset: 0x3d5
// Size: 0x109
function ability_shockstickkills()
{
    level endon( #"game_ended" );
    self endon( #"hash_728fc257659f89f7" );
    shockstickbundle = getscriptbundle( level.roguedata.var_99d77ccaaaf05b57 );
    
    if ( !isdefined( shockstickbundle ) )
    {
        assertmsg( "<dev string:x24>" + level.roguedata.var_99d77ccaaaf05b57 );
    }
    
    while ( true )
    {
        self waittill( #"killed_enemy", meansofdeath, victim );
        grenade = weapon::_launchgrenade( "shock_stick_mp", victim.origin, ( 0, 0, 0 ), 0, 1 );
        grenade.bundle = shockstickbundle;
        grenade.owner = self;
        grenade.team = self.team;
        grenade.weapon_name = "shock_stick_mp";
        shock_stick::shockstick_use( grenade, 0 );
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0xfabad8a0, Offset: 0x4e6
// Size: 0xe
function function_13d222de5497df89()
{
    self notify( #"hash_728fc257659f89f7" );
}

// Namespace rogue_perks
// Params 2
// Checksum 0x91b922d7, Offset: 0x4fc
// Size: 0x14e
function function_580385eacf65cd4c( origin, bundle )
{
    self endon( #"hash_5dc34dff31ec4690" );
    ticks = 10;
    
    for ( k = 0; k < ticks ; k++ )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( distance( origin, player.origin ) > bundle.smokeradius )
            {
                continue;
            }
            
            if ( player.team == self.team )
            {
                player dohealing( level.roguedata.var_84490aeb4f5977d );
                continue;
            }
            
            player dodamage( level.roguedata.var_de75f50db38b0dca, origin, player, undefined, "MOD_TRIGGER_HURT" );
        }
        
        wait bundle.smokeduration / ticks;
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0x83da300f, Offset: 0x652
// Size: 0x4f
function ability_smokeheals()
{
    level endon( #"game_ended" );
    self endon( #"hash_5dc34dff31ec4690" );
    
    while ( true )
    {
        self waittill( #"smokegrenadedetonated", origin, grenadebundle );
        thread function_580385eacf65cd4c( origin, grenadebundle );
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0xa5bc6f81, Offset: 0x6a9
// Size: 0xe
function function_663c9fcba9c7243e()
{
    self notify( #"hash_5dc34dff31ec4690" );
}

// Namespace rogue_perks
// Params 0
// Checksum 0x3321d44d, Offset: 0x6bf
// Size: 0x37
function ability_infinitetacsprint()
{
    level endon( #"game_ended" );
    self endon( #"hash_7a24f60c09300b75" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        self refreshsprinttime();
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0x79409d7c, Offset: 0x6fe
// Size: 0xe
function function_b4e563eb9b27d77a()
{
    self notify( #"hash_7a24f60c09300b75" );
}

// Namespace rogue_perks
// Params 0
// Checksum 0x1752e54e, Offset: 0x714
// Size: 0x17d
function ability_instantsmoke()
{
    level endon( #"game_ended" );
    self endon( #"unset_instantsmoke" );
    smokebundle = getscriptbundle( level.roguedata.var_53963777b9fea260 );
    
    if ( !isdefined( smokebundle ) )
    {
        assertmsg( "<dev string:x24>" + level.roguedata.var_53963777b9fea260 );
    }
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction, damagelocation, meansofdeath, modelname, tagname, partname, flags, weapon );
        
        if ( meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_EXPLOSIVE_BULLET" && meansofdeath != "MOD_PROJECTILE" )
        {
            continue;
        }
        
        if ( attacker == self )
        {
            continue;
        }
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        grenade = weapon::_launchgrenade( "smoke_grenade_mp", self.origin, ( 0, 0, 0 ), 0, 1 );
        grenade.bundle = smokebundle;
        grenade.owner = self;
        smoke_grenade::smokegrenadeused( grenade, 0 );
        break;
    }
}

// Namespace rogue_perks
// Params 0
// Checksum 0xfa1b753a, Offset: 0x899
// Size: 0xe
function function_6919b9801f9ce68c()
{
    self notify( #"unset_instantsmoke" );
}

