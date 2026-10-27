// scripts\common\ai\aitypes\shared\zombie\zombie_stun.gsc  (hash_4bc38131d8ecd20b.gscc) (size: 2607 Bytes / 0xa2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x993f798c (2571073932)
// size ...... 2607 (0xa2f)
// includes .. 4   (offset: 0x9c3)
// strings ... 5   (offset: 0x9e3)
// dev strs .. 0   (offset: 0xa2f)
// exports ... 10  (offset: 0x573)
// cseg ...... 0x9c + 0x4d7 (0x573)
// imports ... 24  (offset: 0x703)
// animtree1 . 0   (offset: 0xa2f)
// animtree2 . 0   (offset: 0xa2f)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_stun;

// Namespace zombie_stun
// Params 0, eflags: 0x5
// Checksum 0x4a11200b, Offset: 0xba
// Size: 0x5c
function private autoexec init()
{
    utility::registersharedfunc( #"zombie", #"stunZombie", &stun_ai );
    utility::registersharedfunc( #"zombie", #"hash_d7f49b93c0ea3526", &is_stunned );
    utility::registersharedfunc( #"zombie", #"clearstunzombie", &function_d738299157923d28 );
}

// Namespace zombie_stun
// Params 2
// Checksum 0x6ff9d648, Offset: 0x11e
// Size: 0x38
function function_b95ca7c43a70440f( taskid, params )
{
    if ( !is_stunned() )
    {
        return anim.failure;
    }
    
    self clearpath();
    return anim.running;
}

// Namespace zombie_stun
// Params 3
// Checksum 0x4c90f83c, Offset: 0x15f
// Size: 0x242
function stun_ai( duration, var_b829b772b5d2f70f, var_9b125af63f9377cc )
{
    assert( isdefined( duration ) );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.aisettings ) && !self.aisettings.var_b11b8458c44f3024 )
    {
        return;
    }
    
    if ( self.disallow_stun )
    {
        return;
    }
    
    if ( self.postpone_stun || zombie_traverse::is_traversing() && !self._blackboard.var_397bfb4ed7256a7a )
    {
        self notify( #"postpone_stun_attempted_made" );
        var_d5fb0299fe2722c2 = spawnstruct();
        var_d5fb0299fe2722c2.duration = duration;
        var_d5fb0299fe2722c2.var_b829b772b5d2f70f = var_b829b772b5d2f70f;
        var_d5fb0299fe2722c2.var_9b125af63f9377cc = var_9b125af63f9377cc;
        
        if ( self.postpone_stun )
        {
            var_f8d9a1b3e7334466 = &in_postpone_stun;
        }
        else
        {
            var_f8d9a1b3e7334466 = &function_729369ef73014d0e;
        }
        
        thread postpone_stun( var_f8d9a1b3e7334466, var_d5fb0299fe2722c2 );
        return;
    }
    
    var_caa67496e8434636 = self findoverridearchetype( "animscript" );
    
    if ( isdefined( var_caa67496e8434636 ) && var_caa67496e8434636 != self getbasearchetype() )
    {
        return;
    }
    
    if ( !isdefined( self.asmname ) || !self asmhasstate( self.asmname, "stun_in" ) )
    {
        return;
    }
    
    end_time = gettime() + int( duration * 1000 );
    
    if ( self.stun_end_time > end_time )
    {
        return;
    }
    
    var_9b125af63f9377cc = isint( var_9b125af63f9377cc ) && var_9b125af63f9377cc > 0 ? var_9b125af63f9377cc : 0;
    
    if ( !self._blackboard.var_32718cfc9c01dd9b || !( self._blackboard.var_f0516406be0fd993 === var_9b125af63f9377cc ) )
    {
        self._blackboard.var_f0516406be0fd993 = var_9b125af63f9377cc;
        self._blackboard.var_32718cfc9c01dd9b = 1;
        self._blackboard.var_adea0ee486214124 = end_time;
        asm::function_7256f5ba459c840b( "stun_in" );
        
        if ( isdefined( var_b829b772b5d2f70f ) )
        {
            thread set_stun_state( duration, var_b829b772b5d2f70f );
        }
        
        callback::callback( "on_ai_stunned", { #duration:duration } );
    }
}

// Namespace zombie_stun
// Params 0, eflags: 0x4
// Checksum 0xf0cb485b, Offset: 0x3a9
// Size: 0xc, Type: bool
function private in_postpone_stun()
{
    return istrue( self.postpone_stun );
}

// Namespace zombie_stun
// Params 0, eflags: 0x4
// Checksum 0x89e2817d, Offset: 0x3be
// Size: 0x8
function private function_729369ef73014d0e()
{
    return zombie_traverse::is_traversing();
}

// Namespace zombie_stun
// Params 0
// Checksum 0xc3cf35c4, Offset: 0x3cf
// Size: 0x1a, Type: bool
function is_stunned()
{
    return gettime() < self._blackboard.var_adea0ee486214124;
}

// Namespace zombie_stun
// Params 0
// Checksum 0x5cbe5103, Offset: 0x3f2
// Size: 0x6b
function function_d738299157923d28()
{
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.var_f0516406be0fd993 = 0;
        self._blackboard.var_adea0ee486214124 = 0;
        self._blackboard.var_32718cfc9c01dd9b = 0;
        self notify( #"zombie_stun_end" );
    }
    
    utility::function_7c10ea82c1e305b8( "stunned", "stunned_off" );
}

// Namespace zombie_stun
// Params 2, eflags: 0xc
// Checksum 0x35fe4af0, Offset: 0x465
// Size: 0x73
function private set_stun_state( duration, var_b829b772b5d2f70f )
{
    self notify( #"hash_4ea4cc2d51ad3fcf" );
    self endon( #"hash_4ea4cc2d51ad3fcf" );
    
    if ( utility::function_7c10ea82c1e305b8( "stunned", var_b829b772b5d2f70f ) )
    {
        self endon( #"death" );
        wait duration;
        utility::function_7c10ea82c1e305b8( "stunned", "stunned_off" );
        
        if ( self.var_a8e9ab5fba96d982 )
        {
            self.var_a8e9ab5fba96d982 = undefined;
        }
    }
}

// Namespace zombie_stun
// Params 2, eflags: 0x4
// Checksum 0x39279ed9, Offset: 0x4e0
// Size: 0x93
function private postpone_stun( var_8c9969473dc5427d, var_18f6d754f926d5cd )
{
    self endon( #"death" );
    self endon( #"postpone_stun_attempted_made" );
    var_9800ce294e3a9809 = 10000;
    postpone_stun_start_time = gettime();
    
    while ( [[ var_8c9969473dc5427d ]]() )
    {
        if ( gettime() - postpone_stun_start_time >= var_9800ce294e3a9809 )
        {
            break;
        }
        
        waitframe();
    }
    
    wait 0.2;
    stun_ai( var_18f6d754f926d5cd.duration, var_18f6d754f926d5cd.var_b829b772b5d2f70f, var_18f6d754f926d5cd.var_9b125af63f9377cc );
}

