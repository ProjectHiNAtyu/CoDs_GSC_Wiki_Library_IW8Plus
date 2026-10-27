// script_2fad375f508fe03  (hash_02fad375f508fe03.gscc) (size: 1239 Bytes / 0x4d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9e3dc3d (4192459837)
// size ...... 1239 (0x4d7)
// includes .. 1   (offset: 0x4af)
// strings ... 2   (offset: 0x4b7)
// dev strs .. 0   (offset: 0x4d7)
// exports ... 7   (offset: 0x26f)
// cseg ...... 0x81 + 0x1ee (0x26f)
// imports ... 10  (offset: 0x387)
// animtree1 . 0   (offset: 0x4d7)
// animtree2 . 0   (offset: 0x4d7)
#using scripts\common\callbacks;

#namespace specialty_quieter;

// Namespace specialty_quieter
// Params 0, eflags: 0x1
// Checksum 0x243df32, Offset: 0x9f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_quieter
// Params 1
// Checksum 0x475ac599, Offset: 0xbf
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_quieter", &setquieter, &unsetquieter, [] );
    }
}

// Namespace specialty_quieter
// Params 0
// Checksum 0x4f9c7751, Offset: 0x101
// Size: 0x22
function setquieter()
{
    if ( function_d386e595922b7936() )
    {
        thread function_c5adca2f0c0ed37b();
        return;
    }
    
    self function_70576dbab4f88e19( "dead_silence_mod", 1 );
}

// Namespace specialty_quieter
// Params 0, eflags: 0x4
// Checksum 0x1d5e48d7, Offset: 0x12b
// Size: 0xad
function private function_c5adca2f0c0ed37b()
{
    self endon( #"hash_f0051ec1cfa5259a" );
    self endon( #"hash_ab1a9478d69ab45a" );
    waitcount = 0;
    
    while ( self && !self isscriptable() && waitcount < 100 )
    {
        waitcount++;
        waitframe();
    }
    
    if ( waitcount > 0 )
    {
        wait 0.5;
        
        if ( self )
        {
            self setscriptablepartstate( #"specialty_quieter", #"specialty_quieter_off" );
        }
        
        wait 0.2;
    }
    else
    {
        wait 0.1;
    }
    
    if ( self && isdefined( self.perks[ "specialty_quieter" ] ) )
    {
        self setscriptablepartstate( #"specialty_quieter", #"specialty_quieter_on" );
    }
}

// Namespace specialty_quieter
// Params 0
// Checksum 0x3b7e284b, Offset: 0x1e0
// Size: 0x3e
function unsetquieter()
{
    self notify( #"hash_ab1a9478d69ab45a" );
    
    if ( function_d386e595922b7936() )
    {
        self setscriptablepartstate( #"specialty_quieter", #"specialty_quieter_off" );
        return;
    }
    
    self function_70576dbab4f88e19( "dead_silence_mod", 0 );
}

// Namespace specialty_quieter
// Params 0
// Checksum 0x26bc52d6, Offset: 0x226
// Size: 0x48, Type: bool
function function_d386e595922b7936()
{
    if ( level.gamemodebundle.var_635d7eebde8e014c && !getdvarint( @"hash_306d748ee13c2531", 0 ) )
    {
        return true;
    }
    
    if ( level.gamemodebundle.var_464caeb69d40c1ba )
    {
        return true;
    }
    
    return false;
}

