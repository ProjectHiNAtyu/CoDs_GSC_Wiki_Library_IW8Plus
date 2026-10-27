// scripts\mp\ob\systems\ob_stealth.gsc  (hash_3ec1997cc944cda8.gscc) (size: 3234 Bytes / 0xca2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ebcc043 (2663170115)
// size ...... 3234 (0xca2)
// includes .. 8   (offset: 0xb7a)
// strings ... 18  (offset: 0xbba)
// dev strs .. 0   (offset: 0xca2)
// exports ... 10  (offset: 0x666)
// cseg ...... 0x1b4 + 0x4b2 (0x666)
// imports ... 31  (offset: 0x7f6)
// animtree1 . 0   (offset: 0xca2)
// animtree2 . 0   (offset: 0xca2)
#using script_4eb10b8076cd40c;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\player;
#using scripts\common\ai\stealth\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\stealth\manager;

#namespace ob_stealth;

// Namespace ob_stealth
// Params 0
// Checksum 0x6cd251f3, Offset: 0x1d2
// Size: 0xf7
function init_ob_stealth()
{
    utility::flag_init( "stealth_enabled" );
    utility::flag_init( "level_stealth_initialized" );
    utility::flag_init( "stealth_spotted" );
    stealth_manager_cpmp::main();
    utility::flag_set( "level_stealth_initialized" );
    callback::add( #"player_connect", &ob_stealth_on_connect );
    stealthsetcombatpingradius( 300 );
    stealthsetdefaulttimetodropthreatsight( 1000 );
    stealthsettocombatbyenemyaiproxpingradius( 600 );
    function_9a095954ba5e6db6( 500 );
    function_17333cf2186e7f61( 1 );
    utility::flag_wait( "sentientpoolmanager_initialized" );
    setthreatbiasignoreall( "Lethal_Static" );
    setthreatbiasagainstall( "Killstreak_Static", -10000 );
    setthreatbiasignoreall( "Tactical_Static" );
    callback::add( "on_zombie_ai_spawned", &function_9af35ef03e1ca34d );
    level utility::function_64b04fdefb6e65b5( "bulletwhizby", &function_aa26977ede76840b );
    level utility::function_64b04fdefb6e65b5( "footstep_walk", &function_fbc19a231426cd28 );
    level utility::function_64b04fdefb6e65b5( "footstep_sprint", &function_fbc19a231426cd28 );
    level.var_d42c6a76441fa1aa = &function_dc9cbab3bcdaf01;
}

// Namespace ob_stealth
// Params 1, eflags: 0x4
// Checksum 0xbe9fcbb6, Offset: 0x2d1
// Size: 0x2e, Type: bool
function private function_aa26977ede76840b( event )
{
    if ( event.receiver.unittype == "soldier" )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_stealth
// Params 1, eflags: 0x4
// Checksum 0xcd59111a, Offset: 0x308
// Size: 0x122, Type: bool
function private function_fbc19a231426cd28( event )
{
    if ( event.receiver.unittype == "soldier" )
    {
        return false;
    }
    else
    {
        dist = distancesquared( event.receiver.origin, event.origin );
        
        if ( event.typeorig == "footstep_walk" )
        {
            walk_detect_dist = 375;
            
            if ( event.receiver.footstepdetectdistwalk > 0 )
            {
                walk_detect_dist = event.receiver.footstepdetectdistwalk;
            }
            
            if ( dist > squared( walk_detect_dist ) )
            {
                return true;
            }
        }
        
        if ( event.typeorig == "footstep_sprint" )
        {
            sprint_detect_dist = 375;
            
            if ( event.receiver.footstepdetectdistsprint > 0 )
            {
                sprint_detect_dist = event.receiver.footstepdetectdistsprint;
            }
            
            if ( dist > squared( sprint_detect_dist ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_stealth
// Params 1, eflags: 0x4
// Checksum 0xaee37b27, Offset: 0x433
// Size: 0x54
function private function_9af35ef03e1ca34d( params )
{
    if ( level.var_d53163b0ef2a4488 || self.var_397efe49c831b963 )
    {
        return;
    }
    
    self.var_31ab1ef29534375a = 1;
    self.var_63f4aa2a79cf03f9 = 1;
    setup_stealth();
    utility::set_stealth_func( "should_hunt", &zombie_should_hunt );
}

// Namespace ob_stealth
// Params 0, eflags: 0x4
// Checksum 0xbda6d9de, Offset: 0x48f
// Size: 0xe5
function private function_dc9cbab3bcdaf01()
{
    agent = self;
    agent.var_e25e087f275efeb5 = 0;
    var_2aa84201bf032dfd = 1;
    
    if ( !level.var_bb86f77304f193c4.var_316ff482e90c3f4d )
    {
        var_2aa84201bf032dfd = 0;
    }
    else if ( agent.unittype == "zombie" || agent.unittype == "dog" || agent.agent_type == "sat_ob_ally_guild_bot" )
    {
        var_2aa84201bf032dfd = 0;
    }
    else if ( agent.script_stealthgroup || agent.directorspawndata.script_stealthgroup )
    {
        var_2aa84201bf032dfd = 0;
    }
    else if ( agent.directorspawndata.script_parameters == "disable_stealth" )
    {
        var_2aa84201bf032dfd = 0;
    }
    
    if ( var_2aa84201bf032dfd )
    {
        agent setup_stealth();
    }
}

// Namespace ob_stealth
// Params 0
// Checksum 0x51336fa7, Offset: 0x57c
// Size: 0x39
function setup_stealth()
{
    if ( !self.script_stealthgroup )
    {
        self.script_stealthgroup = function_ab78eca670dfe877();
    }
    
    if ( !self.stealth )
    {
        stealth::initstealthfunctions();
        thread enemy::main();
    }
}

// Namespace ob_stealth
// Params 0, eflags: 0x4
// Checksum 0x2cd6ba06, Offset: 0x5bd
// Size: 0x3, Type: bool
function private zombie_should_hunt()
{
    return false;
}

// Namespace ob_stealth
// Params 0, eflags: 0x4
// Checksum 0x9808abf4, Offset: 0x5c9
// Size: 0x82
function private function_ab78eca670dfe877()
{
    region = region_difficulty_manager::function_f9fbb630598afdc7( self.origin );
    
    if ( !isstring( region ) )
    {
        region = "default_stealth_group_";
    }
    
    for ( i = 0; i < 10 ; i++ )
    {
        stealthgroup = region + i;
        var_77484c12333d538d = function_ff2498f19618e5fa( stealthgroup );
        
        if ( !isdefined( var_77484c12333d538d ) || var_77484c12333d538d.members.size < 40 )
        {
            return stealthgroup;
        }
    }
}

// Namespace ob_stealth
// Params 1, eflags: 0x4
// Checksum 0x5d9a7835, Offset: 0x653
// Size: 0x13
function private ob_stealth_on_connect( params )
{
    player::main();
}

