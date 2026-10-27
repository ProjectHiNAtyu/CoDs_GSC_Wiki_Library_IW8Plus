// script_497ff7fb3c0b15e4  (hash_497ff7fb3c0b15e4.gscc) (size: 5372 Bytes / 0x14fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x395c85ce (962364878)
// size ...... 5372 (0x14fc)
// includes .. 3   (offset: 0x1404)
// strings ... 17  (offset: 0x141c)
// dev strs .. 0   (offset: 0x14fc)
// exports ... 19  (offset: 0xb6c)
// cseg ...... 0x173 + 0x9f9 (0xb6c)
// imports ... 48  (offset: 0xe64)
// animtree1 . 0   (offset: 0x14fc)
// animtree2 . 0   (offset: 0x14fc)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace juggerbot;

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0x83b8b93f, Offset: 0x191
// Size: 0x3f
function private on_first_init( params )
{
    if ( !level callback::exists( "on_agent_spawned", &agent_on_spawned ) )
    {
        level callback::add( "on_agent_spawned", &agent_on_spawned );
    }
    
    callback::callback( "on_juggerbot_first_init" );
}

// Namespace juggerbot
// Params 1
// Checksum 0x813fde39, Offset: 0x1d8
// Size: 0x20
function is_agent_juggerbot( agent )
{
    return issubstr( agent.subclass, "juggerbot" );
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0xc47303ff, Offset: 0x201
// Size: 0x245
function private agent_on_spawned( params )
{
    agent = params.agent;
    
    if ( !is_agent_juggerbot( agent ) )
    {
        return;
    }
    
    agent setcanusecover( 0 );
    self.goalradius = 4096;
    self.noragdoll = 1;
    self.var_c21cefdb0d231840 = 3000;
    self.var_1db1f2ef9c7f9036 = randomintrange( 400, 600 );
    self.var_aaf12cbad4692c1b = randomintrange( 250, 500 );
    self.var_47627bac27bc94ff = self.var_aaf12cbad4692c1b + 100;
    self.var_e5d5b423587e876 = 50;
    self.var_bd7dc728ded0f3d = self.var_aaf12cbad4692c1b - 200;
    self.var_de04c2fb38eec74a = 1;
    self.var_1f8b3b00067dec6c = 40;
    self.var_d4b1e70a1931ada9 = 128;
    utility::set_movement_speed( 40 );
    self aisettargetspeed( 40 );
    self.var_3914bff7867d9adc = 1;
    self.var_2a0169739aae22f4 = 1;
    self.turnthreshold = 60;
    self.disablereload = 1;
    self.runngun = 1;
    self.var_376245277a92fde3 = -1;
    self.var_4fb7740c7ac5d31d = 0.35;
    self.disabledropfromcombat = 1;
    self allowvehiclepredictiveragdoll( 0 );
    self enabletraversals( 0 );
    self.dontmeleeme = 1;
    self.dontsyncmelee = 1;
    self.meleechargedistvsplayer = 200;
    self.meleechargedist = 200;
    self.meleebashmaxdistsq = squared( 110 );
    self.minpaindamage = 1;
    self.var_2ffc71aa3aa17005 = 500;
    self.var_cf5b234b05d52123 = 30;
    
    if ( self.agent_damage_callback )
    {
        self.var_5ee871ef271a9323 = self.agent_damage_callback;
    }
    
    self.agent_damage_callback = &function_8f6d340ee3e19bb4;
    self.var_2e7cd1e5b6deabc7 = 0;
    self function_74b305f055e8341d( "metal_thick" );
    utility::registersharedfunc( #"ai_juggerbot", #"hack", &hack );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( self, &on_emp_applied );
    callback::add( #"stun", &on_stun );
    utility::ent_flag_wait( "stealth_enabled" );
    self setstealthstate( "combat" );
}

// Namespace juggerbot
// Params 14, eflags: 0x4
// Checksum 0x2c56ae14, Offset: 0x44e
// Size: 0x137
function private function_8f6d340ee3e19bb4( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    soldierdamage = idamage;
    
    if ( self.var_5ee871ef271a9323 )
    {
        soldierdamage = [[ self.var_5ee871ef271a9323 ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    currhealth = self.health - soldierdamage;
    healthpercent = currhealth / self.maxhealth;
    
    if ( healthpercent <= 0.6 )
    {
        utility::function_32b24db3127bff40( "body_damage", "medium" );
    }
    else if ( healthpercent <= 0.9 )
    {
        utility::function_32b24db3127bff40( "body_damage", "light" );
    }
    else
    {
        utility::function_32b24db3127bff40( "body_damage", "off" );
    }
    
    return soldierdamage;
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0xc352465c, Offset: 0x58e
// Size: 0x23
function private on_ai_init( params )
{
    utility::ent_flag_wait( "stealth_enabled" );
    self setstealthstate( "combat" );
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0x8f9b66f1, Offset: 0x5b9
// Size: 0x23
function private function_805562c8447d2538( params )
{
    function_2a2327927ea865f6();
    thread destroy_corpse( self.body );
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0xab8b1af, Offset: 0x5e4
// Size: 0x1b
function private destroy_corpse( corpseent )
{
    wait 3;
    
    if ( corpseent )
    {
        corpseent delete();
    }
}

// Namespace juggerbot
// Params 1
// Checksum 0xcc43592b, Offset: 0x607
// Size: 0x3b
function juggerbotinit( taskid )
{
    callback::add( "on_first_ai_init", &on_first_init );
    callback::add( #"on_ai_killed", &function_805562c8447d2538 );
    return anim.success;
}

// Namespace juggerbot
// Params 1
// Checksum 0x3283523b, Offset: 0x64b
// Size: 0x15
function juggerbot_updateeveryframe_noncombat( taskid )
{
    return anim.success;
}

// Namespace juggerbot
// Params 1
// Checksum 0x2a660563, Offset: 0x669
// Size: 0x9d
function function_c1b2c794ccd4430e( taskid )
{
    if ( self.var_b65c21b6930b6109 )
    {
        return "";
    }
    
    if ( self.enemy && self seerecently( self.enemy, 5000 ) )
    {
        closestpoint = self getclosestreachablepointonnavmesh( self.enemy.origin );
        
        if ( distance2dsquared( closestpoint, self.enemy.origin ) > 4096 )
        {
            return "JuggerbotCombatCantReach";
        }
        
        utility::set_movement_speed( 40 );
        return "JuggerbotCombatPursue";
    }
    
    return "JuggerbotCombatWander";
}

// Namespace juggerbot
// Params 1
// Checksum 0xfb42e05e, Offset: 0x70f
// Size: 0x83
function JuggerbotCombatWander( taskid )
{
    if ( !self.var_c9f5d65422b3b451 || self.var_c9f5d65422b3b451 < gettime() )
    {
        goal_pos = getrandomnavpoint( self.origin, 500 );
        
        if ( goal_pos )
        {
            utility::set_movement_speed( 40 );
            self setbtgoalpos( 1, goal_pos );
            self setbtgoalradius( 1, 32 );
        }
        
        self.var_c9f5d65422b3b451 = gettime() + 10000;
    }
    
    return anim.success;
}

// Namespace juggerbot
// Params 1
// Checksum 0xcfc9a64d, Offset: 0x79b
// Size: 0x124
function JuggerbotCombatCantReach( taskid )
{
    var_1352276d948d52ca = 0;
    
    if ( self.lastenemypos )
    {
        var_1352276d948d52ca = distance2dsquared( self.enemy.origin, self.lastenemypos );
    }
    
    if ( !self.var_c9f5d65422b3b451 || self.var_c9f5d65422b3b451 < gettime() || var_1352276d948d52ca > 10000 )
    {
        tacpoint = function_5a577f4e6e89a130( self.enemy.origin, self.origin, 200, 2000, 1000 );
        
        if ( tacpoint )
        {
            utility::set_movement_speed( 40 );
            var_fbb0440a8bb765ad = self function_c0c45783d07df34c( tacpoint.groundpos );
            goalpos = getclosestpointonnavmesh( var_fbb0440a8bb765ad );
            self setbtgoalpos( 1, goalpos );
            self setbtgoalradius( 1, 32 );
            self.lastenemypos = self.enemy.origin;
            self.var_c9f5d65422b3b451 = gettime() + 10000;
        }
    }
    
    return anim.success;
}

// Namespace juggerbot
// Params 0, eflags: 0x4
// Checksum 0x64b7e06, Offset: 0x8c8
// Size: 0xae
function private function_2a2327927ea865f6()
{
    var_46063ece3767f60b = self.origin;
    var_3b1f1c5413269a8d = function_709a16da4823c25d();
    var_b5cfbcc86057839e = var_3b1f1c5413269a8d.basesettings;
    
    if ( !var_b5cfbcc86057839e || !var_b5cfbcc86057839e.var_f26740d0b3bcb0f )
    {
        return;
    }
    
    shellshockradius = var_b5cfbcc86057839e.shellshockradius ?? 600;
    var_4c7589c6d41d81db = var_b5cfbcc86057839e.var_4c7589c6d41d81db ?? 50;
    shellshockmaxdamage = var_b5cfbcc86057839e.shellshockmaxdamage ?? 50;
    self radiusdamage( var_46063ece3767f60b, shellshockradius, shellshockmaxdamage, var_4c7589c6d41d81db );
}

// Namespace juggerbot
// Params 0, eflags: 0x4
// Checksum 0x7886fc2d, Offset: 0x97e
// Size: 0x65
function private function_709a16da4823c25d()
{
    aitypescriptbundle = getaitypescriptbundle( self.classname );
    aisettingsbundle = getscriptbundle( "aisettingsbundle:" + aitypescriptbundle.aisettingsbundle );
    
    if ( !aisettingsbundle.var_c72b569453167cda )
    {
        return;
    }
    
    var_a7504a3b26becde1 = getscriptbundle( aisettingsbundle.var_c72b569453167cda );
    return var_a7504a3b26becde1;
}

// Namespace juggerbot
// Params 2, eflags: 0x4
// Checksum 0x6a3e089a, Offset: 0x9ec
// Size: 0x52
function private hack( hackeffect, attacker )
{
    hackduration = 5000;
    
    if ( isnumber( hackeffect.hackduration ) )
    {
        hackduration = int( hackeffect.hackduration );
    }
    
    thread stun( hackduration, 1 );
}

// Namespace juggerbot
// Params 2, eflags: 0x4
// Checksum 0x17688f18, Offset: 0xa46
// Size: 0x9c
function private stun( var_772501ce9a0c24da, stun_damage )
{
    self endon( #"death_or_disconnect" );
    self.var_b98e9791f01fb72d = 1;
    self.stunduration = int( var_772501ce9a0c24da );
    self dodamage( stun_damage, self.origin );
    utility::function_32b24db3127bff40( #"emp", #"on" );
    self.stunduration = 0;
    utility::waittill_notify_or_timeout( "cancel_stun", var_772501ce9a0c24da * 0.001 );
    utility::function_32b24db3127bff40( #"emp", #"off" );
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0xddb18002, Offset: 0xaea
// Size: 0x36
function private on_emp_applied( data )
{
    var_772501ce9a0c24da = randomintrange( 3000, 5000 );
    thread stun( var_772501ce9a0c24da, data.damage );
}

// Namespace juggerbot
// Params 1, eflags: 0x4
// Checksum 0x2b1e4036, Offset: 0xb28
// Size: 0x44
function private on_stun( params )
{
    var_772501ce9a0c24da = params.duration;
    
    if ( params.var_c27a2418f1d8f32d )
    {
        var_772501ce9a0c24da *= 1000;
    }
    
    thread stun( var_772501ce9a0c24da, 1 );
}

