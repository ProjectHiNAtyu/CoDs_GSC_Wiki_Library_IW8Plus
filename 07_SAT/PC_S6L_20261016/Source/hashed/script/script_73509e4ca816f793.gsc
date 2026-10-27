// script_73509e4ca816f793  (hash_73509e4ca816f793.gscc) (size: 1671 Bytes / 0x687 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3539b07 (3545471751)
// size ...... 1671 (0x687)
// includes .. 3   (offset: 0x66f)
// strings ... 0   (offset: 0x687)
// dev strs .. 0   (offset: 0x687)
// exports ... 9   (offset: 0x357)
// cseg ...... 0x58 + 0x2ff (0x357)
// imports ... 15  (offset: 0x4bf)
// animtree1 . 0   (offset: 0x687)
// animtree2 . 0   (offset: 0x687)
#using script_38b3a2dd00d469d7;
#using scripts\common\callbacks;
#using scripts\mp\gamescore;

#namespace namespace_91ed183d78607bac;

// Namespace namespace_91ed183d78607bac
// Params 0
// Checksum 0x6925696d, Offset: 0x76
// Size: 0xac
function register()
{
    namespace_65703d98c062a7d0::register_task( #"streakPoints", { #description:undefined, #title:undefined, #var_a0b28827c4a84871:500, #var_d510f1926ab220cf:1, #defaulttimelimit:level.var_4e147a96a4a5740d.taskduration ?? 120, #var_a689daceff70fb12:25, #callbacks:{ #onspawn:&onspawn, #ondisconnect:&ondisconnect, #end:&end, #begin:&begin } } );
}

// Namespace namespace_91ed183d78607bac
// Params 1
// Checksum 0xdeab4d7c, Offset: 0x12a
// Size: 0x9b
function begin( task )
{
    level callback::add( #"hash_fa7263897b3164e", &scoreeventcallback );
    
    foreach ( player in level.players )
    {
        player function_b3348dc4576c0b31();
    }
}

// Namespace namespace_91ed183d78607bac
// Params 1
// Checksum 0xed1856f0, Offset: 0x1cd
// Size: 0x22
function end( task )
{
    level callback::remove( #"hash_fa7263897b3164e", &scoreeventcallback );
}

// Namespace namespace_91ed183d78607bac
// Params 1
// Checksum 0x47df59eb, Offset: 0x1f7
// Size: 0x13
function onspawn( spawndata )
{
    function_b3348dc4576c0b31();
}

// Namespace namespace_91ed183d78607bac
// Params 1
// Checksum 0x22b15835, Offset: 0x212
// Size: 0x20
function ondisconnect( disconnectdata )
{
    self.var_1782c70df17dc221 = undefined;
    self.var_2bdf28a7c911141d = undefined;
}

// Namespace namespace_91ed183d78607bac
// Params 0, eflags: 0x4
// Checksum 0x640bcbb8, Offset: 0x23a
// Size: 0x1c
function private function_b3348dc4576c0b31()
{
    self.var_1782c70df17dc221 = gamescore::getplayerscore( self );
    self.var_2bdf28a7c911141d = 0;
}

// Namespace namespace_91ed183d78607bac
// Params 1
// Checksum 0xd2be2cd0, Offset: 0x25e
// Size: 0xb7
function scoreeventcallback( params )
{
    task = level.var_1304fc1c8fb51e7b.active;
    
    if ( task.taskreference != #"streakPoints" )
    {
        return;
    }
    
    if ( !self.team )
    {
        return;
    }
    
    streakpoints = gamescore::getplayerscore( self ) - ( self.var_1782c70df17dc221 ?? gamescore::getplayerscore( self ) );
    var_35984ea168f26cc6 = self.var_2bdf28a7c911141d + function_59c1da9efe149288( task );
    
    if ( streakpoints >= var_35984ea168f26cc6 )
    {
        self.var_2bdf28a7c911141d = streakpoints;
        namespace_65703d98c062a7d0::function_3e454447aae37e67( self.team, 1 );
    }
}

// Namespace namespace_91ed183d78607bac
// Params 1, eflags: 0x4
// Checksum 0xac61f0ff, Offset: 0x31d
// Size: 0x39
function private function_59c1da9efe149288( task )
{
    requirement = int( task.var_35984ea168f26cc6 ?? 500 );
    
    if ( requirement <= 0 )
    {
        return 1;
    }
    
    return requirement;
}

