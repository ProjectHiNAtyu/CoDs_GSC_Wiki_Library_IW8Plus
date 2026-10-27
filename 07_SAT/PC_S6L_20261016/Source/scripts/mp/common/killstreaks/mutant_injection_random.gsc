// scripts\mp\common\killstreaks\mutant_injection_random.gsc  (hash_25acaafc5dee0fc9.gscc) (size: 3355 Bytes / 0xd1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a0be41f (1510728735)
// size ...... 3355 (0xd1b)
// includes .. 6   (offset: 0xc2b)
// strings ... 2   (offset: 0xc5b)
// dev strs .. 12  (offset: 0xc8b)
// exports ... 12  (offset: 0x72b)
// cseg ...... 0x6b + 0x6c0 (0x72b)
// imports ... 27  (offset: 0x90b)
// animtree1 . 0   (offset: 0xd1b)
// animtree2 . 0   (offset: 0xd1b)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace mutant_injection_random;

// Namespace mutant_injection_random
// Params 0, eflags: 0x1
// Checksum 0x2292331f, Offset: 0x89
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"minj_random", &init );
}

// Namespace mutant_injection_random
// Params 0
// Checksum 0xa4c3a650, Offset: 0xa8
// Size: 0x13
function init()
{
    initkillstreak();
    
    /#
        function_90254e330acee834();
    #/
}

// Namespace mutant_injection_random
// Params 1, eflags: 0x4
// Checksum 0xc2f11918, Offset: 0xc3
// Size: 0xe5
function private onavailable( streakitem )
{
    bundle = level.streakglobals.streakbundles[ streakitem.streakname ];
    
    foreach ( table in bundle.var_a86adb3b47a628c7 )
    {
        setupinfo = killstreaks::getkillstreaksetupinfo( table.ref );
        
        if ( isfunction( setupinfo.availablefunc ) )
        {
            self [[ setupinfo.availablefunc ]]( streakitem );
        }
    }
}

// Namespace mutant_injection_random
// Params 1, eflags: 0x4
// Checksum 0xb4c3ed00, Offset: 0x1b0
// Size: 0xaa
function private tryusemutantinjection( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    self.var_9d3e2d06ce7e8383 = function_6f91d1479434c703( bundle );
    
    if ( !self.var_9d3e2d06ce7e8383 )
    {
        return 0;
    }
    
    streaksetupinfo = killstreaks::getkillstreaksetupinfo( self.var_9d3e2d06ce7e8383 );
    
    if ( isfunction( streaksetupinfo.triggeredfunc ) )
    {
        result = self [[ streaksetupinfo.triggeredfunc ]]( streakinfo );
    }
    
    if ( result )
    {
        function_99341c73d1493873();
    }
    
    return result;
}

// Namespace mutant_injection_random
// Params 0, eflags: 0x4
// Checksum 0xee4508cb, Offset: 0x263
// Size: 0x5e
function private initkillstreak()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "minj_random", &tryusemutantinjection, &onavailable );
    }
    
    level callback::add( #"hash_d558db2dac47d5f7", &function_43c2582abd661f1f );
}

// Namespace mutant_injection_random
// Params 1, eflags: 0x4
// Checksum 0xd2074836, Offset: 0x2c9
// Size: 0x1fc
function private function_6f91d1479434c703( bundle )
{
    randinj = undefined;
    
    if ( getdvar( @"hash_2597c208520a5900", "" ) != "" && getdvar( @"hash_2597c208520a5900", "" ) != "minj_random" )
    {
        return getdvar( @"hash_2597c208520a5900", "" );
    }
    
    totalweight = 0;
    randomtable = [];
    
    foreach ( entry in bundle.var_a86adb3b47a628c7 )
    {
        if ( !isdefined( level.mutantinjections[ entry.ref ] ) || level.mutantinjections[ entry.ref ] < entry.limit )
        {
            totalweight += entry.weight;
            pair = { #weight:totalweight, #ref:entry.ref };
            randomtable[ randomtable.size ] = pair;
        }
    }
    
    randfloat = randomfloatrange( 0, totalweight );
    
    foreach ( pair in randomtable )
    {
        if ( pair.weight >= randfloat )
        {
            randinj = pair.ref;
            break;
        }
    }
    
    return randinj;
}

// Namespace mutant_injection_random
// Params 1, eflags: 0x4
// Checksum 0xa7e87436, Offset: 0x4ce
// Size: 0x72
function private function_99341c73d1493873( params )
{
    if ( self.micontext.streakinfo.streakname != "minj_random" )
    {
        return;
    }
    
    inj = self.var_9d3e2d06ce7e8383;
    
    if ( !isdefined( level.mutantinjections[ inj ] ) )
    {
        level.mutantinjections[ inj ] = 0;
    }
    
    level.mutantinjections[ inj ]++;
}

// Namespace mutant_injection_random
// Params 1, eflags: 0x4
// Checksum 0xb84ceda9, Offset: 0x548
// Size: 0x64
function private function_43c2582abd661f1f( params )
{
    if ( self.micontext.streakinfo.streakname != "minj_random" )
    {
        return;
    }
    
    inj = self.var_9d3e2d06ce7e8383;
    
    if ( level.mutantinjections[ inj ] )
    {
        level.mutantinjections[ inj ]--;
    }
}

/#

    // Namespace mutant_injection_random
    // Params 0, eflags: 0x4
    // Checksum 0xee7c106e, Offset: 0x5b4
    // Size: 0x70, Type: dev
    function private function_90254e330acee834()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x39>", "<dev string:x50>", &function_c3348da953340ca0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x74>", "<dev string:x94>", &function_19ce108ef499a55a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xba>", "<dev string:xdb>", &function_19ce108ef499a55a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x101>", "<dev string:x120>", &function_19ce108ef499a55a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace mutant_injection_random
    // Params 1, eflags: 0x4
    // Checksum 0x4dd2c064, Offset: 0x62c
    // Size: 0x3c, Type: dev
    function private function_19ce108ef499a55a( params )
    {
        if ( params[ 0 ] )
        {
            setdvar( @"hash_2597c208520a5900", params[ 0 ] );
            return;
        }
        
        setdvar( @"hash_2597c208520a5900", "<dev string:x13f>" );
    }

    // Namespace mutant_injection_random
    // Params 0
    // Checksum 0x774c3574, Offset: 0x670
    // Size: 0xbb, Type: dev
    function function_c3348da953340ca0()
    {
        mi_player = undefined;
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                mi_player = player;
            }
        }
        
        if ( isdefined( mi_player ) && !mi_player.ismutantinjection )
        {
            mi_player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "<dev string:x140>", "<dev string:x14c>", undefined, undefined, undefined, 1 );
        }
    }

#/
