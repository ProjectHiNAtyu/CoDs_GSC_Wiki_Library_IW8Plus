// scripts\mp\ob\ob_shock_util.gsc  (hash_46770d2f87eb2745.gscc) (size: 1430 Bytes / 0x596 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa31780c3 (2736226499)
// size ...... 1430 (0x596)
// includes .. 3   (offset: 0x4f6)
// strings ... 10  (offset: 0x50e)
// dev strs .. 0   (offset: 0x596)
// exports ... 4   (offset: 0x312)
// cseg ...... 0xf6 + 0x21c (0x312)
// imports ... 11  (offset: 0x3b2)
// animtree1 . 0   (offset: 0x596)
// animtree2 . 0   (offset: 0x596)
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\mp\common\utility\shellshock_utility;

#namespace ob_shock_util;

// Namespace ob_shock_util
// Params 2
// Checksum 0x1d5478af, Offset: 0x114
// Size: 0xa1
function stun_target( attacker, stun_duration )
{
    if ( self.type == "zombie" )
    {
        effect_stun::stun( "shocking_reload", stun_duration, attacker, undefined, undefined, "electrical", 1 );
        return;
    }
    
    if ( self.type == "human" )
    {
        self notify( #"flashbang", self.origin, 1, undefined, attacker, attacker.team, stun_duration );
        return;
    }
    
    if ( isplayer( self ) )
    {
        thread shellshock_utility_cpmp::_shellshock( %"bomb_stun_mp", #"stun", stun_duration );
    }
}

// Namespace ob_shock_util
// Params 2
// Checksum 0x3bc5cd38, Offset: 0x1bd
// Size: 0x10f
function shock_fx( attacker, stun_duration )
{
    self endon( #"death" );
    
    if ( self.type == "zombie" )
    {
        if ( self.classname == "actor_sat_spawner_zombie_base_ob_harrow" )
        {
            function_a66ea1eb4963bfe2( stun_duration );
        }
        else
        {
            params = spawnstruct();
            params.attacker = attacker;
            callback::callback( "shocked", params );
            wait stun_duration;
            callback::callback( "shocked_end", params );
        }
        
        return;
    }
    
    if ( self.type == "human" )
    {
        firstshock = gettime() > self._blackboard.var_ba9517cfc0287af8 + stun_duration;
        self._blackboard.var_ba9517cfc0287af8 = gettime();
        
        if ( self asmhaspainstate( self.asmname ) && firstshock )
        {
            self asmevalpaintransition( self.asmname );
        }
        
        function_a66ea1eb4963bfe2( stun_duration );
    }
}

// Namespace ob_shock_util
// Params 1, eflags: 0x4
// Checksum 0x8ee0ed3d, Offset: 0x2d4
// Size: 0x3e
function private function_a66ea1eb4963bfe2( stun_duration )
{
    self setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    wait stun_duration;
    
    if ( self getscriptablehaspart( "shockStickVfx" ) )
    {
        self setscriptablepartstate( "shockStickVfx", "off", 0 );
    }
}

