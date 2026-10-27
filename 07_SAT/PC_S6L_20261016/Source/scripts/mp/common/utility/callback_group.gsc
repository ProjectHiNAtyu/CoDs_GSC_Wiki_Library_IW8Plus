// scripts\mp\common\utility\callback_group.gsc  (hash_4bf0b4a1156254d0.gscc) (size: 3369 Bytes / 0xd29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd2effdd (4247715805)
// size ...... 3369 (0xd29)
// includes .. 0   (offset: 0xc7d)
// strings ... 0   (offset: 0xc7d)
// dev strs .. 13  (offset: 0xc7d)
// exports ... 12  (offset: 0x7b9)
// cseg ...... 0x58 + 0x761 (0x7b9)
// imports ... 20  (offset: 0x999)
// animtree1 . 0   (offset: 0xd29)
// animtree2 . 0   (offset: 0xd29)
#namespace callback_group;

// Namespace callback_group
// Params 0
// Checksum 0xdac19537, Offset: 0x76
// Size: 0x21
function callback_create()
{
    group = spawnstruct();
    group.subscriptions = [];
    return group;
}

// Namespace callback_group
// Params 2
// Checksum 0xc77d56c8, Offset: 0xa0
// Size: 0x140
function callback_subscribe( callback, target )
{
    assert( isdefined( callback ), "<dev string:x24>" );
    assert( isdefined( target ), "<dev string:x3f>" );
    
    /#
        foreach ( sub in self.subscriptions )
        {
            if ( sub.callback == callback )
            {
                if ( sub.target == target )
                {
                    if ( sub.target == target )
                    {
                        assert( "<dev string:x58>" + target + "<dev string:x61>" );
                    }
                }
            }
        }
    #/
    
    sub = spawnstruct();
    sub.target = target;
    sub.callback = callback;
    self.subscriptions = function_5713d46873b29625( self.subscriptions );
    self.subscriptions[ self.subscriptions.size ] = sub;
}

// Namespace callback_group
// Params 2
// Checksum 0xa2adb15c, Offset: 0x1e8
// Size: 0xea
function callback_unsubscribe( callback, target )
{
    assert( isdefined( callback ), "<dev string:x24>" );
    assert( isdefined( target ), "<dev string:x3f>" );
    
    foreach ( index, sub in self.subscriptions )
    {
        if ( sub.callback == callback )
        {
            if ( sub.target == target )
            {
                self.subscriptions[ index ] = undefined;
                return;
            }
        }
    }
    
    assertmsg( "<dev string:x58>" + target + "<dev string:x80>" );
}

// Namespace callback_group
// Params 2, eflags: 0x40 variadic
// Checksum 0xf01073a2, Offset: 0x2da
// Size: 0x130
function callback_trigger( ... )
{
    foreach ( index, sub in self.subscriptions )
    {
        if ( !isdefined( sub.target ) )
        {
            self.subscriptions[ index ] = undefined;
        }
    }
    
    subscriptions = self.subscriptions;
    
    foreach ( sub in subscriptions )
    {
        sub.target [[ sub.callback ]]( flat_args( vararg, varargcount ) );
    }
}

/#

    // Namespace callback_group
    // Params 0
    // Checksum 0x633028fc, Offset: 0x412
    // Size: 0x21, Type: dev
    function callback_test()
    {
        function_188a2de20e957b7a();
        callback_test_parameters();
        callback_test_unsubscribe();
        function_c254853686fc7a2a();
    }

    // Namespace callback_group
    // Params 0
    // Checksum 0xfdb3057, Offset: 0x43b
    // Size: 0xae, Type: dev
    function function_188a2de20e957b7a()
    {
        teststruct = spawnstruct();
        teststruct.num = 0;
        cba = callback_create();
        cba callback_subscribe( &function_5b05288b8f349765, teststruct );
        cba callback_trigger( 1 );
        assert( teststruct.num == 1, "<dev string:x9b>" );
        cbb = callback_create();
        cbb callback_subscribe( &function_5b05288b8f349765, teststruct );
        cbb callback_trigger( 1 );
        assert( teststruct.num == 2, "<dev string:xc6>" );
    }

    // Namespace callback_group
    // Params 0
    // Checksum 0x512ca5bd, Offset: 0x4f1
    // Size: 0x68, Type: dev
    function callback_test_parameters()
    {
        teststruct = spawnstruct();
        teststruct.num = 0;
        cb = callback_create();
        cb callback_subscribe( &function_5b05288b8f349765, teststruct );
        cb callback_trigger( 2 );
        assert( teststruct.num == 2, "<dev string:xf1>" );
    }

    // Namespace callback_group
    // Params 0
    // Checksum 0x9ea948d9, Offset: 0x561
    // Size: 0x173, Type: dev
    function callback_test_unsubscribe()
    {
        teststruct = spawnstruct();
        teststruct.num = 0;
        cba = callback_create();
        cba callback_subscribe( &function_5b05288b8f349765, teststruct );
        cba callback_unsubscribe( &function_5b05288b8f349765, teststruct );
        cba callback_trigger( 1 );
        assert( teststruct.num == 0, "<dev string:x112>" );
        var_3fed0f7831d4a2b6 = spawnstruct();
        var_3fed0f7831d4a2b6.num = 0;
        var_3fed0e7831d4a083 = spawnstruct();
        var_3fed0e7831d4a083.num = 0;
        var_3fed0d7831d49e50 = spawnstruct();
        var_3fed0d7831d49e50.num = 0;
        cbb = callback_create();
        cbb callback_subscribe( &function_5b05288b8f349765, var_3fed0f7831d4a2b6 );
        cbb callback_subscribe( &function_5b05288b8f349765, var_3fed0e7831d4a083 );
        cbb callback_unsubscribe( &function_5b05288b8f349765, var_3fed0f7831d4a2b6 );
        cbb callback_subscribe( &function_5b05288b8f349765, var_3fed0d7831d49e50 );
        cbb callback_trigger( 1 );
        assert( var_3fed0f7831d4a2b6.num == 0, "<dev string:x133>" );
        assert( var_3fed0e7831d4a083.num == 1, "<dev string:x133>" );
        assert( var_3fed0d7831d49e50.num == 1, "<dev string:x17c>" );
    }

    // Namespace callback_group
    // Params 0
    // Checksum 0x34bd481e, Offset: 0x6dc
    // Size: 0x85, Type: dev
    function function_c254853686fc7a2a()
    {
        testent = spawn( "<dev string:x1c5>", ( 0, 0, 0 ) );
        level.var_bb6c2ddc1020d7b1 = 0;
        cb = callback_create();
        cb callback_subscribe( &function_2d7fcdafdd3c3d0e, testent );
        testent delete();
        cb callback_trigger( 1 );
        assert( level.var_bb6c2ddc1020d7b1 == 0, "<dev string:x1d3>" );
        level.var_bb6c2ddc1020d7b1 = undefined;
    }

    // Namespace callback_group
    // Params 1
    // Checksum 0xe3164873, Offset: 0x769
    // Size: 0x24, Type: dev
    function function_5b05288b8f349765( increment )
    {
        self.num += increment;
    }

    // Namespace callback_group
    // Params 1
    // Checksum 0xc8265493, Offset: 0x795
    // Size: 0x24, Type: dev
    function function_2d7fcdafdd3c3d0e( increment )
    {
        level.var_bb6c2ddc1020d7b1 += increment;
    }

#/
