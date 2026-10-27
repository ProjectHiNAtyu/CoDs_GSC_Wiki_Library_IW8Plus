// scripts\mp\common\killstreaks\nuke_mp.gsc  (hash_7d929265a240b1db.gscc) (size: 3708 Bytes / 0xe7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e039835 (1040422965)
// size ...... 3708 (0xe7c)
// includes .. 8   (offset: 0xdac)
// strings ... 10  (offset: 0xdec)
// dev strs .. 0   (offset: 0xe7c)
// exports ... 12  (offset: 0x814)
// cseg ...... 0xe3 + 0x731 (0x814)
// imports ... 32  (offset: 0x9f4)
// animtree1 . 0   (offset: 0xe7c)
// animtree2 . 0   (offset: 0xe7c)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\damage;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\rank;

#namespace nuke_mp;

// Namespace nuke_mp
// Params 0
// Checksum 0x7e031285, Offset: 0x101
// Size: 0x199
function init()
{
    killstreaks::registerkillstreak( "nuke", &nuke::tryusenukefromstruct );
    killstreaks::registerkillstreak( "nuke_select_location", &nuke::tryusenukefromstruct );
    killstreaks::registerkillstreak( "nuke_multi", &nuke::tryusenukefromstruct );
    utility::registersharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35", &nuke_hostmigration_waitlongdurationwithpause );
    utility::registersharedfunc( #"nuke", #"hostmigration_waittillhostmigrationdone", &nuke_hostmigration_waittillhostmigrationdone );
    utility::registersharedfunc( #"nuke", #"delayendgame", &nuke_delayendgame );
    utility::registersharedfunc( #"nuke", #"hash_f15ae3904539c3ac", &nuke_addteamrankxpmultiplier );
    utility::registersharedfunc( #"nuke", #"cankill", &nuke_cankill );
    utility::registersharedfunc( #"nuke", #"hash_578d8cafcdd67404", &nuke_killplayer );
    utility::registersharedfunc( #"nuke", #"killplayerwithattacker", &nuke_killplayerwithattacker );
    utility::registersharedfunc( #"nuke", #"hash_41868e03ee00f30d", &nuke_destroyactiveobjects );
    utility::registersharedfunc( #"nuke", #"isplayerinradzone", &nuke_isplayerinradzone );
    utility::registersharedfunc( #"nuke", #"stoptheclock", &nuke_stoptheclock );
    weaponname = utility::get_scripted_weapon_name( #"nuke_multi" );
    
    if ( isdefined( weaponname ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "nuke_multi", weaponname, #"donotregister" );
    }
}

// Namespace nuke_mp
// Params 1
// Checksum 0x69f484a5, Offset: 0x2a2
// Size: 0x15
function nuke_hostmigration_waitlongdurationwithpause( delay )
{
    hostmigration::waitlongdurationwithhostmigrationpause( delay );
}

// Namespace nuke_mp
// Params 0
// Checksum 0xaa4142ff, Offset: 0x2bf
// Size: 0x8
function nuke_hostmigration_waittillhostmigrationdone()
{
    return hostmigration::waittillhostmigrationdone();
}

// Namespace nuke_mp
// Params 2
// Checksum 0x3707511e, Offset: 0x2d0
// Size: 0x6f
function nuke_delayendgame( delaytime, winner )
{
    hostmigration::waitlongdurationwithpause( delaytime );
    
    if ( level.mercywintriggered )
    {
        level thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 1, 1 );
        return;
    }
    
    level thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "nuke_end" ], undefined, 1 );
}

// Namespace nuke_mp
// Params 3
// Checksum 0x200f0b0d, Offset: 0x347
// Size: 0x29
function nuke_addteamrankxpmultiplier( multiplier, team, ref )
{
    rank::addteamrankxpmultiplier( multiplier, team, ref );
}

// Namespace nuke_mp
// Params 2
// Checksum 0xfe94fae4, Offset: 0x378
// Size: 0xef, Type: bool
function nuke_cankill( character, var_a75c483bd9b64c5d )
{
    if ( level.blocknukekills )
    {
        return false;
    }
    
    if ( !isdefined( level.nukeinfo ) )
    {
        return false;
    }
    
    if ( var_a75c483bd9b64c5d )
    {
        return true;
    }
    
    if ( level.teambased )
    {
        if ( character.team == level.nukeinfo.team )
        {
            return false;
        }
    }
    else
    {
        iskillstreakplayer = character == level.nukeinfo.player;
        ownerisplayer = isdefined( level.nukeinfo.player ) && isdefined( character.owner ) && character.owner == level.nukeinfo.player;
        
        if ( iskillstreakplayer || ownerisplayer )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace nuke_mp
// Params 1
// Checksum 0x69449f56, Offset: 0x470
// Size: 0x169
function nuke_destroyactiveobjects( team )
{
    killstreakarray = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    activeobjects = undefined;
    
    if ( isdefined( killstreakarray ) && isdefined( equipmentarray ) )
    {
        activeobjects = arraycombineunique( killstreakarray, equipmentarray );
    }
    else if ( isdefined( killstreakarray ) )
    {
        activeobjects = killstreakarray;
    }
    else if ( isdefined( equipmentarray ) )
    {
        activeobjects = equipmentarray;
    }
    
    if ( isdefined( activeobjects ) )
    {
        foreach ( object in activeobjects )
        {
            if ( isdefined( object ) )
            {
                if ( utility::issharedfuncdefined( #"killstreak", #"hash_a32facf8aac952e6" ) )
                {
                    object [[ utility::getsharedfunc( #"killstreak", #"hash_a32facf8aac952e6" ) ]]( 10000, level.nukeinfo.player, level.nukeinfo.player, team, object.origin, "MOD_EXPLOSIVE", level.nukeinfo.weapon );
                }
            }
        }
    }
}

// Namespace nuke_mp
// Params 3
// Checksum 0xd2ddf820, Offset: 0x5e1
// Size: 0x3f, Type: bool
function nuke_isplayerinradzone( player, zoneorigin, zonesize )
{
    var_6eeb0b96697ddd94 = distance2dsquared( zoneorigin, player.origin );
    return var_6eeb0b96697ddd94 < zonesize;
}

// Namespace nuke_mp
// Params 1
// Checksum 0x7eeb09a7, Offset: 0x629
// Size: 0xf8
function nuke_killplayer( character )
{
    if ( isplayer( character ) )
    {
        objweapon = makeweapon( level.nukeinfo.weapon );
        damage::addattacker( character, level.nukeinfo.player, undefined, objweapon, 0, undefined, undefined, undefined, undefined, "MOD_UNKNOWN" );
        damagedirection = vectornormalize( character.origin + ( 0, 0, 1000 ) - level.nukeinfo.inflictor.origin );
        character thread damage::finishplayerdamagewrapper( level.nukeinfo.inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", objweapon, character.origin, damagedirection, "none", 0, 0, undefined, undefined );
    }
}

// Namespace nuke_mp
// Params 1
// Checksum 0x198cd3db, Offset: 0x729
// Size: 0xc1
function nuke_killplayerwithattacker( character )
{
    nukeattacker = level.nukeinfo.player;
    
    if ( level.teambased && character.team == nukeattacker.team )
    {
        nukeattacker = character;
    }
    
    objweapon = makeweapon( level.nukeinfo.weapon );
    character dodamage( 999999, level.nukeinfo.inflictor.origin, nukeattacker, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", objweapon, "none" );
}

// Namespace nuke_mp
// Params 1
// Checksum 0xf62c3f8c, Offset: 0x7f2
// Size: 0x21, Type: bool
function nuke_stoptheclock( gametype )
{
    level.timelimit = 0;
    level.extratime = 0;
    return false;
}

