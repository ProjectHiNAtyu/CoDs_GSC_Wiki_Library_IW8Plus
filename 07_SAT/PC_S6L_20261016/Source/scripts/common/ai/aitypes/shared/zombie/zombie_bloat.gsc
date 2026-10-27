// scripts\common\ai\aitypes\shared\zombie\zombie_bloat.gsc  (hash_524a786d8eddd2bd.gscc) (size: 1551 Bytes / 0x60f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1d4e787 (3251955591)
// size ...... 1551 (0x60f)
// includes .. 3   (offset: 0x5bf)
// strings ... 4   (offset: 0x5d7)
// dev strs .. 0   (offset: 0x60f)
// exports ... 7   (offset: 0x2bb)
// cseg ...... 0x96 + 0x225 (0x2bb)
// imports ... 17  (offset: 0x3d3)
// animtree1 . 0   (offset: 0x60f)
// animtree2 . 0   (offset: 0x60f)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\utility;

#namespace zombie_bloat;

// Namespace zombie_bloat
// Params 0, eflags: 0x5
// Checksum 0x5b69d678, Offset: 0xb4
// Size: 0x3e
function private autoexec init()
{
    utility::registersharedfunc( #"zombie", #"bloatzombie", &function_2cd238f58ce9245b );
    utility::registersharedfunc( #"zombie", #"hash_c4551fbc625eab56", &function_283d2dbdc4ac8f96 );
}

// Namespace zombie_bloat
// Params 2
// Checksum 0x9143745e, Offset: 0xfa
// Size: 0xa6
function function_2cd238f58ce9245b( duration, attacker )
{
    assert( isdefined( duration ) );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_caa67496e8434636 = self findoverridearchetype( "animscript" );
    
    if ( isdefined( var_caa67496e8434636 ) && var_caa67496e8434636 != self getbasearchetype() )
    {
        return;
    }
    
    if ( !isdefined( self.asmname ) )
    {
        return;
    }
    
    if ( !self asmhasstate( self.asmname, "bloat_in" ) )
    {
        return;
    }
    
    if ( self.disallow_bloat )
    {
        return;
    }
    
    if ( zombie_vehicle_attack::is_in_vehicle_attack() )
    {
        thread function_caa523468e74fe2d( duration, attacker );
        return;
    }
    
    activate_bloat( duration );
}

// Namespace zombie_bloat
// Params 0
// Checksum 0x289e1ce7, Offset: 0x1a8
// Size: 0x10, Type: bool
function function_515d0ff3aa6cc5d2()
{
    return gettime() < self.bloat_end_time;
}

// Namespace zombie_bloat
// Params 0
// Checksum 0x120b8444, Offset: 0x1c1
// Size: 0x18
function function_283d2dbdc4ac8f96()
{
    self.bloat_end_time = undefined;
    self function_786bb6aa1b76c7ee( "bloat_end_time", 0 );
}

// Namespace zombie_bloat
// Params 2, eflags: 0x4
// Checksum 0xb921b464, Offset: 0x1e1
// Size: 0x77
function private function_caa523468e74fe2d( duration, attacker )
{
    self endon( #"death" );
    var_dbc7bd1946222dea = 8;
    
    if ( isdefined( attacker ) )
    {
        var_3b47613711457bbd = self.origin - attacker.origin;
    }
    
    zombie_vehicle_attack::function_1103fe44822e8b55( var_3b47613711457bbd );
    utility::waittill_notify_or_timeout( "cannonball_end", var_dbc7bd1946222dea );
    activate_bloat( duration );
}

// Namespace zombie_bloat
// Params 1, eflags: 0x4
// Checksum 0x5fea0198, Offset: 0x260
// Size: 0x5b
function private activate_bloat( duration )
{
    end_time = gettime() + int( duration * 1000 );
    
    if ( self.bloat_end_time > end_time )
    {
        return;
    }
    
    self.bloat_end_time = end_time;
    self function_786bb6aa1b76c7ee( "bloat_end_time", end_time );
    asm::function_7256f5ba459c840b( "bloat_in" );
}

