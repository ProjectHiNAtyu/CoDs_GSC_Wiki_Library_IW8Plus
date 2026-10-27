// scripts\mp\br\gametypes\br_bosses_mi8jugg.gsc  (hash_66891f9189419213.gscc) (size: 3429 Bytes / 0xd65 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f1b0cf6 (1058737398)
// size ...... 3429 (0xd65)
// includes .. 5   (offset: 0xbd9)
// strings ... 26  (offset: 0xc01)
// dev strs .. 0   (offset: 0xd65)
// exports ... 7   (offset: 0x861)
// cseg ...... 0x221 + 0x640 (0x861)
// imports ... 21  (offset: 0x979)
// animtree1 . 0   (offset: 0xd65)
// animtree2 . 0   (offset: 0xd65)
#using scripts\mp\agents\agent_utils;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_bosses;
#using scripts\mp\juggernaut;

#namespace br_bosses_mi8jugg;

// Namespace br_bosses_mi8jugg
// Params 0
// Checksum 0x3794108, Offset: 0x23f
// Size: 0x8e
function mi8jugg_register()
{
    bossdetails = spawnstruct();
    bossdetails.spawnlocs = [];
    bossdetails.name = "mi8jugg";
    bossdetails.uiname = "MP_DMZ_MISSIONS/DMZ_BOSS_JUGG_NAME";
    bossdetails.initfunc = &mi8jugg_init;
    bossdetails.spawnfunc = &mi8jugg_spawn;
    bossdetails.spawnfunc_debug = &mi8jugg_spawn;
    bossdetails.var_3e06982b5b53e7a = &function_33d09fd69cc66d12;
    br_bosses::registerboss( bossdetails );
}

// Namespace br_bosses_mi8jugg
// Params 1
// Checksum 0x2f2d11cb, Offset: 0x2d5
// Size: 0xaa
function mi8jugg_init( bossdetails )
{
    level.var_efbb1e8a96a09aba = getdvarint( @"hash_6fed3b4aab176fe6", 2 );
    level.var_12e953673de2a6e = 0;
    level.var_5c07e73988d335ab = getdvarfloat( @"hash_1099eba3fc541217", 0 );
    level.var_5c07e73988d335ab *= level.var_5c07e73988d335ab;
    level.var_6697c2de42c7367 = getdvarfloat( @"hash_86e760e453e4b70b", 2500 );
    level.var_9790db6f259ff42c = getdvarint( @"hash_86c85cfc843c0b68", 1 );
    level.var_2a6012bfba95f75b = getdvarint( @"hash_a433661e4f79e427", 100 );
}

// Namespace br_bosses_mi8jugg
// Params 2
// Checksum 0x9a2366d0, Offset: 0x387
// Size: 0x2af
function mi8jugg_spawn( node, category = "elites" )
{
    aitype = undefined;
    var_7e5f2d65b2ec56c9 = level.var_f3f8f12f590587b7;
    
    if ( category == "gulag" )
    {
        aitype = "enemy_mp_jugg_gulag";
        var_7e5f2d65b2ec56c9 = [ "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "qamis", "thighpad_l", "thighpad_r" ];
    }
    else
    {
        aitype = ai_mp_controller::function_f7aef6871cda828( "jugg" );
    }
    
    jugg = ai_mp_controller::ai_mp_requestspawnagent( aitype, node.origin, node.angles, "absolute", category, "jugg", undefined, undefined, undefined, node.script_poi, 1, 0, 0 );
    weapon = undefined;
    agent_utils::overridejugg( jugg, weapon );
    jugg agent_utils::ai_blockexecution( 1 );
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
    juggcontext.var_5bd2193fb4972677 = &function_79daf211576e8f1b;
    juggcontext.lastpaintime = 0;
    juggcontext.paindamage = 0;
    juggcontext.var_17d6bfdbfca7e7bd = 6000;
    juggcontext.paincooldown = 20000;
    juggcontext.paindecay = 10;
    juggcontext.paindecaytime = 0.1;
    juggcontext.lastdamagedtime = 0;
    juggcontext.var_84756ab51a4bf8f = 250;
    jugg.juggcontext = juggcontext;
    jugg juggernaut::function_a1a46c7474f6db81( var_7e5f2d65b2ec56c9, "pristine" );
    jugg.bosstype = "mi8jugg";
    jugg br_bosses::function_2fc885345d040baf( "mi8jugg" );
    return jugg;
}

// Namespace br_bosses_mi8jugg
// Params 0
// Checksum 0xd2483805, Offset: 0x63f
// Size: 0x1a
function function_33d09fd69cc66d12()
{
    level endon( #"game_ended" );
    br_bosses::function_8c64e1696564998f( "mi8jugg" );
}

// Namespace br_bosses_mi8jugg
// Params 13
// Checksum 0x548bc899, Offset: 0x661
// Size: 0x121
function mi8jugg_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( level.var_9790db6f259ff42c == 1 )
    {
        overflow = idamage - level.var_2a6012bfba95f75b;
        
        if ( overflow > 0 )
        {
            idamage = level.var_2a6012bfba95f75b + sqrt( overflow );
        }
    }
    else
    {
        idamage = min( idamage, level.var_2a6012bfba95f75b );
    }
    
    remaininghealth = self.health - idamage;
    
    if ( remaininghealth <= 0 )
    {
        self notify( #"hash_8f948ff43d21829d" );
    }
    
    juggernaut::function_28d6476ed9716980( idamage, shitloc, smeansofdeath, eattacker );
    common_agent_damage::common_callbacksoldieragentdamaged( einflictor, eattacker, int( idamage ), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, 0 );
}

// Namespace br_bosses_mi8jugg
// Params 2
// Checksum 0x9a5b3723, Offset: 0x78a
// Size: 0xd7
function function_79daf211576e8f1b( part, damage )
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

