// script_293f54b8846d23b6  (hash_293f54b8846d23b6.gscc) (size: 3223 Bytes / 0xc97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb95d5310 (3109901072)
// size ...... 3223 (0xc97)
// includes .. 7   (offset: 0xb73)
// strings ... 17  (offset: 0xbab)
// dev strs .. 0   (offset: 0xc97)
// exports ... 11  (offset: 0x703)
// cseg ...... 0x1a2 + 0x561 (0x703)
// imports ... 24  (offset: 0x8bb)
// animtree1 . 0   (offset: 0xc97)
// animtree2 . 0   (offset: 0xc97)
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;

#namespace namespace_379a29e1b0037e79;

// Namespace namespace_379a29e1b0037e79
// Params 0, eflags: 0x1
// Checksum 0x35722fab, Offset: 0x1c0
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"champion_juggernaut", &init );
}

// Namespace namespace_379a29e1b0037e79
// Params 1
// Checksum 0xfa80d8e9, Offset: 0x1df
// Size: 0x79
function init( eventinfo )
{
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
    level.var_ed383266c014b22 = 1;
    level.var_c93ca2a1201216eb = 5000;
    level.var_6721bad5ee3a000e = &function_6721bad5ee3a000e;
    ai_mp_controller::function_71bf1a00b0b8d267();
    ai_mp_controller::init();
    jugg_init();
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0x34c0fba8, Offset: 0x260
// Size: 0x13
function function_6721bad5ee3a000e()
{
    ai_mp_controller::aibudget_registercategories( [ "elites" ] );
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0x491f61b4, Offset: 0x27b
// Size: 0x84
function jugg_init()
{
    level.var_efbb1e8a96a09aba = getdvarint( @"hash_44f5a24f308cfc24", 2 );
    level.var_12e953673de2a6e = 0;
    level.var_5c07e73988d335ab = getdvarfloat( @"hash_4ca0fb9b9e03ee41", 0 );
    level.var_6697c2de42c7367 = getdvarfloat( @"hash_630260e41cbfdc4d", 2500 );
    level.var_9790db6f259ff42c = getdvarint( @"hash_b46ab23f0795bdda", 1 );
    level.var_2a6012bfba95f75b = getdvarint( @"hash_bbd7e58197ff9761", 100 );
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0x91f3da2c, Offset: 0x307
// Size: 0x2
function postinitfunc()
{
    
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0x5b0c6149, Offset: 0x311
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0xcef586be, Offset: 0x348
// Size: 0x8a
function activatefunc()
{
    droplocation = br_jugg_common::showdroplocations( 1, 0 );
    hud_util::showsplashtoall( "br_champion_jugg_incoming" );
    node = spawnstruct();
    node.origin = droplocation[ 0 ].origin;
    node.angle = ( 0, 0, 0 );
    jugg = jugg_spawn( "enemy_mp_jugg_mgl", node );
    jugg thread ai_behavior::behavior_GuardWander( jugg, 1024, 512 );
}

// Namespace namespace_379a29e1b0037e79
// Params 0
// Checksum 0x65bae39d, Offset: 0x3da
// Size: 0x4b
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"hash_dc49c56a963ec655", 60 );
    maxstarttime = getdvarfloat( @"hash_dc6caf6a9664ddab", 120 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

// Namespace namespace_379a29e1b0037e79
// Params 2
// Checksum 0x1b653d9b, Offset: 0x42d
// Size: 0x1f6
function jugg_spawn( aitype, node )
{
    jugg = ai_mp_controller::ai_mp_requestspawnagent( aitype, node.origin, node.angles, "absolute", "elites", "jugg", undefined, undefined, undefined, node.poi, 1, 0, 0 );
    agent_utils::overridejugg( jugg );
    juggcontext = spawnstruct();
    juggcontext.partshealth = [];
    juggcontext.partshealth[ "head_health" ] = 100;
    juggcontext.partshealth[ "damaged_helmet_health" ] = 100;
    juggcontext.partshealth[ "torso_upper_health" ] = 100;
    juggcontext.partshealth[ "torso_lower_health" ] = 100;
    juggcontext.partshealth[ "right_upper_arm_health" ] = 100;
    juggcontext.partshealth[ "right_lower_arm_health" ] = 100;
    juggcontext.partshealth[ "left_upper_arm_health" ] = 100;
    juggcontext.partshealth[ "left_lower_arm_health" ] = 100;
    juggcontext.partshealth[ "right_leg_health" ] = 100;
    juggcontext.partshealth[ "left_leg_health" ] = 100;
    juggcontext.var_5bd2193fb4972677 = &function_1906b245e14fc6b9;
    juggcontext.lastpaintime = 0;
    juggcontext.paindamage = 0;
    juggcontext.var_17d6bfdbfca7e7bd = 6000;
    juggcontext.paincooldown = 20000;
    juggcontext.paindecay = 10;
    juggcontext.paindecaytime = 0.1;
    juggcontext.lastdamagedtime = 0;
    juggcontext.var_84756ab51a4bf8f = 250;
    jugg.juggcontext = juggcontext;
    jugg juggernaut::function_a1a46c7474f6db81( level.var_f3f8f12f590587b7, "pristine" );
    return jugg;
}

// Namespace namespace_379a29e1b0037e79
// Params 2
// Checksum 0x82ca0254, Offset: 0x62c
// Size: 0xd7
function function_1906b245e14fc6b9( part, damage )
{
    if ( part == "head_health" && !isdefined( self.juggcontext.partshealth[ part ] ) )
    {
        if ( isdefined( self.juggcontext.partshealth[ "damaged_helmet_health" ] ) )
        {
            self.juggcontext.partshealth[ "damaged_helmet_health" ] = self.juggcontext.partshealth[ "damaged_helmet_health" ] - damage;
            
            if ( self.juggcontext.partshealth[ "damaged_helmet_health" ] <= 0 )
            {
                self.juggcontext.partshealth[ "damaged_helmet_health" ] = undefined;
                juggernaut::function_a1a46c7474f6db81( "head_health", "destroyed" );
            }
        }
    }
}

