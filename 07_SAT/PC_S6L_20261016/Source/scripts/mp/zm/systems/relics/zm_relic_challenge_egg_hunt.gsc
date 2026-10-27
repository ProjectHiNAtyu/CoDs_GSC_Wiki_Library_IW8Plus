// scripts\mp\zm\systems\relics\zm_relic_challenge_egg_hunt.gsc  (hash_1aa263aaeb3d6fdd.gscc) (size: 3779 Bytes / 0xec3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb336b981 (3006708097)
// size ...... 3779 (0xec3)
// includes .. 8   (offset: 0xda3)
// strings ... 14  (offset: 0xde3)
// dev strs .. 2   (offset: 0xeab)
// exports ... 10  (offset: 0x8c7)
// cseg ...... 0x13e + 0x789 (0x8c7)
// imports ... 29  (offset: 0xa57)
// animtree1 . 0   (offset: 0xec3)
// animtree2 . 0   (offset: 0xec3)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;

#namespace zm_relic_challenge_egg_hunt;

// Namespace zm_relic_challenge_egg_hunt
// Params 0, eflags: 0x5
// Checksum 0x32b86b23, Offset: 0x15c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_egg_hunt", undefined, &init_relic_challenge_egg_hunt, undefined );
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0x56d8100f, Offset: 0x17d
// Size: 0xa
function init_relic_challenge_egg_hunt()
{
    level thread function_d5571e8bb9dfa891();
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0x2f236502, Offset: 0x18f
// Size: 0x1c
function function_d5571e8bb9dfa891()
{
    zm_relic_challenges::register_relic_challenge_functions( #"egg_hunt", &function_f0c96abe2cd3daa5, &function_4e5cf8897a116df8 );
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0xb62dbe, Offset: 0x1b3
// Size: 0x1a7
function function_f0c96abe2cd3daa5()
{
    level.active_relic_challenge.eggs_hit = 0;
    level.active_relic_challenge.a_eggs = [];
    level.active_relic_challenge.var_314c989083fbb87d = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        struct = utility::getstruct( "ct_mb_" + i, "targetname" );
        var_ef4b37d1aaab7eba = utility::getstruct( "ct_mb_l_" + i, "targetname" );
        var_d3b253ecd2119f3f = utility::getstruct( "ct_mb_m_" + i, "targetname" );
        
        if ( struct )
        {
            wait 3;
            egg = spawn( "script_model", struct.origin );
            egg setscale( 5 );
            egg setmodel( "vfx_misc_easter_egg_01" );
            level.active_relic_challenge.a_eggs[ level.active_relic_challenge.a_eggs.size ] = egg;
            egg.var_ef4b37d1aaab7eba = var_ef4b37d1aaab7eba;
            egg.var_d3b253ecd2119f3f = var_d3b253ecd2119f3f;
            egg thread damage_watcher();
            level thread debug_utility::drawsphere( egg.origin, 30, 300, ( 0, 1, 0 ) );
        }
        
        if ( var_ef4b37d1aaab7eba )
        {
            level.active_relic_challenge.var_314c989083fbb87d[ level.active_relic_challenge.var_314c989083fbb87d.size ] = var_ef4b37d1aaab7eba;
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0xda269749, Offset: 0x362
// Size: 0x92
function egg_hunt_timer()
{
    level.active_relic_challenge.egg_timer = 300;
    var_4afbde91aae7019a = 1;
    
    while ( var_4afbde91aae7019a )
    {
        wait 1;
        
        if ( level.active_relic_challenge.egg_timer )
        {
            level.active_relic_challenge.egg_timer--;
        }
        
        if ( !level.active_relic_challenge.egg_timer || level.active_relic_challenge.egg_timer <= 0 )
        {
            var_4afbde91aae7019a = undefined;
            break;
        }
    }
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0x38f6440b, Offset: 0x3fc
// Size: 0x98
function function_4e5cf8897a116df8()
{
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x4c>" );
    #/
    
    foreach ( egg in level.active_relic_challenge.a_eggs )
    {
        if ( egg )
        {
            egg delete();
        }
    }
}

// Namespace zm_relic_challenge_egg_hunt
// Params 0
// Checksum 0xd1c02ed2, Offset: 0x49c
// Size: 0x1cf
function damage_watcher()
{
    self endon( #"death" );
    level endon( #"relic_challenge_end" );
    val::set( "egg", "damage", 1 );
    self.health = 99999;
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( !self.egg_hit )
            {
                self.egg_hit = 1;
                level.active_relic_challenge.eggs_hit++;
            }
        }
        
        round_number = zm_round_logic::get_rb_round_number();
        playfxontag( level._effect[ #"egg_trail" ], self, "tag_origin" );
        waitframe();
        utility::function_8001268940441423( self.origin, self.var_ef4b37d1aaab7eba.origin, self.var_d3b253ecd2119f3f.origin, 1.5, undefined, 1 );
        stopfxontag( level._effect[ #"egg_trail" ], self, "tag_origin" );
        level function_fcc576ce75ae207c( self.var_ef4b37d1aaab7eba, round_number );
        self.health += damage;
        break;
    }
    
    self delete();
}

// Namespace zm_relic_challenge_egg_hunt
// Params 2
// Checksum 0xb431ca59, Offset: 0x673
// Size: 0x108
function function_fcc576ce75ae207c( spawner, round_number )
{
    level endon( #"relic_challenge_end" );
    
    switch ( level.active_relic_challenge.eggs_hit )
    {
        case 1:
            zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_karkinos_hvt", spawner, round_number, "elite" );
            break;
        case 2:
            zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_ghoul_hvt_relic", spawner, round_number, "elite" );
            break;
        case 3:
            zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_amalgam_hvt", spawner, round_number, "elite" );
            break;
        case 4:
            zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_callisto_hvt_relic", spawner, round_number, "elite" );
            break;
    }
    
    if ( !zombie )
    {
        zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_karkinos_hvt", spawner, round_number, "elite" );
    }
    
    zombie callback::add( #"on_ai_killed", &egg_hunt_death );
}

// Namespace zm_relic_challenge_egg_hunt
// Params 1
// Checksum 0x85dff056, Offset: 0x783
// Size: 0x144
function egg_hunt_death( params )
{
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = level.active_relic_challenge.bundle.ref;
    step_ref = zm_relic_challenges::function_2877e19d99dc6597( step_ref );
    level.active_relic_challenge.timer += 180;
    zm_quest::function_612a9ad0db22c29c( level.active_relic_challenge.timer * 1000, 1, quest_bundle.ref, step_ref );
    level.active_relic_challenge.kills++;
    current_kills = level.active_relic_challenge.kills;
    progress_frac = current_kills;
    zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    
    if ( level.active_relic_challenge.kills >= 4 )
    {
        level zm_relic_challenges::end_relic_challenge();
    }
}

