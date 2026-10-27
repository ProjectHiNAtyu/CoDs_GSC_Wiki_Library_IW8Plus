// scripts\autotests\gscunittest\test_gscunittest_patch.gsc  (hash_5ac37e007aba969a.gscc) (size: 10057 Bytes / 0x2749 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b23cd19 (2065943833)
// size ...... 10057 (0x2749)
// includes .. 3   (offset: 0x2495)
// strings ... 40  (offset: 0x24ad)
// dev strs .. 0   (offset: 0x2749)
// exports ... 47  (offset: 0x1531)
// cseg ...... 0x32a + 0x1207 (0x1531)
// imports ... 54  (offset: 0x1c89)
// animtree1 . 0   (offset: 0x2749)
// animtree2 . 0   (offset: 0x2749)
#using scripts\autotests\autotests;
#using scripts\autotests\gscunittest\test_gscunittest_patch_far;
#using scripts\unittest\util;

#namespace gscunittest_patch;

// Namespace gscunittest_patch
// Params 0
// Checksum 0x73491cc7, Offset: 0x348
// Size: 0x53
function add()
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "add: ", self, level.autotests.test_runtime, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 15 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x7682dd3, Offset: 0x3a3
// Size: 0x4d
function patch_self_check()
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "patch_self_check: ", self.methcheck, "yes", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 20 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xcaf56a4a, Offset: 0x3f8
// Size: 0xd
function meth_patch()
{
    self.value = 1;
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x19d66564, Offset: 0x40d
// Size: 0x6a
function meth()
{
    s = spawnstruct();
    s meth_patch();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "meth: ", s.value, 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 33 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    patch_self_check();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x6cdef2bb, Offset: 0x47f
// Size: 0x3, Type: bool
function func_patch()
{
    return false;
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x98814edf, Offset: 0x48b
// Size: 0x52
function func()
{
    x = func_patch();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "func: ", x, 0, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 46 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x4df423c9, Offset: 0x4e5
// Size: 0x99
function vars_before( s )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s.active: 1:", s.active, 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s.notcanon: 1:", s.notcanon, "hi", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 52 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x3305915c, Offset: 0x586
// Size: 0x99
function vars_after( s )
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s.active: 2:", s.active, 2, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 57 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "s.notcanon: 2:", s.notcanon, "bye", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x31b59de2, Offset: 0x627
// Size: 0x2b
function vars_update( s )
{
    s.active = 2;
    s.notcanon = "bye";
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x6110162b, Offset: 0x65a
// Size: 0x4c
function vars()
{
    s = spawnstruct();
    s.active = 1;
    s.notcanon = "hi";
    vars_before( s );
    vars_update( s );
    vars_after( s );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x2e28b7e7, Offset: 0x6ae
// Size: 0x17
function func_thread()
{
    autotests::function_d84657f448aaeef6( "func_thread", 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 84 );
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0xa20854ca, Offset: 0x6cd
// Size: 0xd1
function thread_wait_patch( deep )
{
    x = 0;
    
    if ( deep == 0 )
    {
        level.autotests.test_runtime.thread_wait_patch = 0;
        level waittill( #"thread_wait" );
        level.autotests.test_runtime.thread_wait_patch = 111;
        return;
    }
    
    if ( deep > 0 )
    {
        level.autotests.test_runtime.thread_wait_patch = deep;
        thread_wait_native( deep - 1 );
        return;
    }
    
    level.autotests.test_runtime.thread_wait_patch = deep;
    thread thread_wait_native( deep + 1 );
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x76bea4e4, Offset: 0x7a6
// Size: 0x15
function thread_wait_native( deep )
{
    thread_wait_patch( deep );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x77d7740c, Offset: 0x7c3
// Size: 0x18
function thread_wait_local()
{
    x = 0;
    thread_wait( 1 );
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x6782cdf1, Offset: 0x7e3
// Size: 0x1f4
function thread_wait( ignorelocal )
{
    local = ignorelocal ? "2:" : "1:";
    level.autotests.test_runtime.thread_wait_patch = -10;
    thread thread_wait_native( 0 );
    level notify( #"thread_wait" );
    waittillframeend();
    x = level.autotests.test_runtime.thread_wait_patch;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "thread_wait_native: 0:" + local, x, 111, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 128 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.thread_wait_patch = -10;
    thread thread_wait_native( 1 );
    level notify( #"thread_wait" );
    waittillframeend();
    x = level.autotests.test_runtime.thread_wait_patch;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "thread_wait_native: 0:" + local, x, 111, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.thread_wait_patch = -10;
    thread thread_wait_native( -1 );
    level notify( #"thread_wait" );
    waittillframeend();
    x = level.autotests.test_runtime.thread_wait_patch;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "thread_wait_native: 0:" + local, x, 111, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 142 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( !ignorelocal )
    {
        thread_wait_local();
        waittillframeend();
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x4bf462a0, Offset: 0x9df
// Size: 0x3
function native_wait()
{
    waittillframeend();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x2fa9d4ad, Offset: 0x9ea
// Size: 0x43
function patch_wait_frameend()
{
    level.autotests.test_runtime.patch_wait = 2;
    waittillframeend();
    level.autotests.test_runtime.patch_wait = 3;
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x5f641ade, Offset: 0xa35
// Size: 0x108
function patch_wait()
{
    level.autotests.test_runtime.patch_wait = 1;
    patch_wait_frameend();
    x = level.autotests.test_runtime.patch_wait;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "patch_wait:", x, 3, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 170 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.patch_wait = 4;
    waittillframeend();
    x = level.autotests.test_runtime.patch_wait;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "patch_wait: end", x, 4, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 174 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x7bd2c5c4, Offset: 0xb45
// Size: 0x80
function define()
{
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "define: int: ", 1, 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 179 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "define: float: ", 2.2, 2.2, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 180 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xc0727ea2, Offset: 0xbcd
// Size: 0x17
function f1()
{
    autotests::function_d84657f448aaeef6( "fp1", 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 185 );
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x13376102, Offset: 0xbec
// Size: 0x5b
function f2( tp )
{
    [[ tp ]]( "fp2" );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "fp2: tp:", isfunction( tp ), 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 191 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xac7140bc, Offset: 0xc4f
// Size: 0xae
function func_pointer()
{
    fp1 = &f1;
    [[ fp1 ]]();
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "fp1", isfunction( fp1 ), 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 198 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    fp2 = &util::test_print;
    f2( fp2 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "fp2", isfunction( fp2 ), 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 202 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xcfdc25a1, Offset: 0xd05
// Size: 0x9
function far()
{
    test_gscunittest_patch_far::patch_far();
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0xcb26cc56, Offset: 0xd16
// Size: 0x23
function e5( t, n )
{
    f = 6;
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0x8379cbb9, Offset: 0xd41
// Size: 0x2d
function e4( t, n )
{
    e = 5;
    e5( t, n );
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0x1d1d5e1b, Offset: 0xd76
// Size: 0x2d
function e3( t, n )
{
    d = 4;
    e4( t, n );
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0x6a1a6e8a, Offset: 0xdab
// Size: 0x2d
function e2( t, n )
{
    c = 3;
    e3( t, n );
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0xf3133f31, Offset: 0xde0
// Size: 0x2d
function e1( t, n )
{
    b = 2;
    e2( t, n );
}

// Namespace gscunittest_patch
// Params 2
// Checksum 0xff73f508, Offset: 0xe15
// Size: 0x38
function endontest_endon( t, n )
{
    test = "endontest_" + t;
    level endon( test );
    e1( t, n );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xaf21073d, Offset: 0xe55
// Size: 0xe
function stack_patch_waittill_leaf()
{
    stack_patch_log( "stack_patch_waittill_leaf" );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xee606c95, Offset: 0xe6b
// Size: 0x15
function stack_patch_waittill_node()
{
    stack_patch_log( "stack_patch_waittill_node" );
    stack_patch_waittill_leaf();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xee606c95, Offset: 0xe88
// Size: 0x15
function stack_patch_waittill_stack()
{
    stack_patch_log( "stack_patch_waittill_stack" );
    stack_patch_waittill_leaf();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xecf67370, Offset: 0xea5
// Size: 0x1c
function stack_patch_waittill_root()
{
    stack_patch_log( "stack_patch_waittill_root" );
    stack_patch_waittill_node();
    stack_patch_waittill_stack();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xa129db81, Offset: 0xec9
// Size: 0x2
function stack_patch_waittill_context_patch()
{
    
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x94437317, Offset: 0xed3
// Size: 0x44
function stack_patch_waittill_context( s )
{
    stack_patch_waittill_context_log( s.value );
    s.value++;
    stack_patch_waittill_context_patch();
    waittillframeend();
    stack_patch_waittill_context_log( s.value );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xc42aa656, Offset: 0xf1f
// Size: 0x2
function stack_patch_waittill_context_far_patch()
{
    
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0xf19766cc, Offset: 0xf29
// Size: 0x44
function stack_patch_waittill_context_far( s )
{
    stack_patch_waittill_context_log( s.value );
    s.value++;
    stack_patch_waittill_context_far_patch();
    waittillframeend();
    stack_patch_waittill_context_log( s.value );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x24649810, Offset: 0xf75
// Size: 0xf
function stack_patch_thread()
{
    level waittill( #"stack_patch" );
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xcee98b54, Offset: 0xf8c
// Size: 0x9
function stack_patch_thread_leaf()
{
    stack_patch_thread();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0xdacb2067, Offset: 0xf9d
// Size: 0x2
function stack_patch_thread_node()
{
    
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x882f9049, Offset: 0xfa7
// Size: 0x9
function stack_patch_thread_root()
{
    stack_patch_thread_node();
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x772ec711, Offset: 0xfb8
// Size: 0x64
function stack_patch_log( str )
{
    x = level.autotests.test_runtime.stack_patch;
    
    if ( !isdefined( x ) )
    {
        x = [];
    }
    
    x[ x.size ] = str;
    level.autotests.test_runtime.stack_patch = x;
}

// Namespace gscunittest_patch
// Params 1
// Checksum 0x417b434c, Offset: 0x1024
// Size: 0x64
function stack_patch_waittill_context_log( val )
{
    x = level.autotests.test_runtime.stack_patch_s;
    
    if ( !isdefined( x ) )
    {
        x = [];
    }
    
    x[ x.size ] = val;
    level.autotests.test_runtime.stack_patch_s = x;
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x62bce81c, Offset: 0x1090
// Size: 0x3bb
function stack_patch()
{
    stack_patch_log( "stack_patch" );
    thread stack_patch_waittill_root();
    x = level.autotests.test_runtime.stack_patch;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 0:", x[ 0 ], "stack_patch", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 341 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 1:", x[ 1 ], "stack_patch_waittill_root", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 342 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 2:", x[ 2 ], "stack_patch_waittill_node", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 343 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 3:", x[ 3 ], "stack_patch_waittill_leaf", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 344 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 4:", x[ 4 ], "stack_patch_waittill_stack", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 345 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch: 5:", x[ 5 ], "stack_patch_waittill_leaf", "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 346 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    s = spawnstruct();
    s.value = 0;
    thread stack_patch_waittill_context( s );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_waittill_context:", s.value, 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 351 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    x = level.autotests.test_runtime.stack_patch_s;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_s: 0:", x[ 0 ], 0, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 353 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    thread stack_patch_waittill_context_far( s );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_waittill_context:", s.value, 2, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 356 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    x = level.autotests.test_runtime.stack_patch_s;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_s: 1:", x[ 1 ], 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 358 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    waittillframeend();
    x = level.autotests.test_runtime.stack_patch_s;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_s: 3:", x[ 2 ], 2, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 362 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "stack_patch_s: 3:", x[ 3 ], 2, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 363 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    waitframe();
    stack_patch_thread_root();
    level notify( #"stack_patch" );
    waittillframeend();
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x7c551bb4, Offset: 0x1453
// Size: 0x5d
function builtin_patch()
{
    x = getdvarint( @"builtin_patch", 1 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "builtin_patch:", x, 1, "scripts/autotests/gscunittest/test_gscunittest_patch.gsc", 376 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_patch
// Params 0
// Checksum 0x9c78d5ee, Offset: 0x14b8
// Size: 0x79
function main()
{
    s = spawnstruct();
    s.methcheck = "yes";
    func();
    s meth();
    add();
    vars();
    thread func_thread();
    thread_wait();
    patch_wait();
    define();
    func_pointer();
    far();
    stack_patch();
    builtin_patch();
}

