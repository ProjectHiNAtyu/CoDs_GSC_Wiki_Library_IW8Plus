// scripts\autotests\test_callback_sequence.gsc  (hash_068cf0f0233bc5f9.gscc) (size: 4959 Bytes / 0x135f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90cd73db (2429383643)
// size ...... 4959 (0x135f)
// includes .. 2   (offset: 0x1163)
// strings ... 31  (offset: 0x1173)
// dev strs .. 0   (offset: 0x135f)
// exports ... 16  (offset: 0xb87)
// cseg ...... 0x342 + 0x845 (0xb87)
// imports ... 24  (offset: 0xe07)
// animtree1 . 0   (offset: 0x135f)
// animtree2 . 0   (offset: 0x135f)
#using scripts\autotests\autotests;
#using scripts\common\callback_sequence;

#namespace test_callback_sequence;

// Namespace test_callback_sequence/testautomation
// Params 0, eflags: 0x20
// Checksum 0x3813419c, Offset: 0x360
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_callback_sequence.gsc", #"test", &start_test, &setup );
}

// Namespace test_callback_sequence
// Params 0
// Checksum 0x9e0606fb, Offset: 0x389
// Size: 0x8, Type: bool
function setup()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_callback_sequence
// Params 0, eflags: 0x4
// Checksum 0x120c355, Offset: 0x39a
// Size: 0xa, Type: bool
function private start_test()
{
    test_callback_sequence();
    return false;
}

// Namespace test_callback_sequence
// Params 0, eflags: 0x4
// Checksum 0x413bc9, Offset: 0x3ad
// Size: 0x5cf
function private test_callback_sequence()
{
    level callback::register_sequence( #"callback_sequence_test", [ 4:#"hash_95ae327751c12574", 3:#"hash_95ae337751c12727", #"test_step_c", 1:#"test_step_b", 0:#"test_step_a" ] );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_c", &handle_step_c );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_a", &handle_step_a );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"hash_95ae327751c12574", &function_d07b01ed28c2613f );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_b", &handle_step_b );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"hash_95ae337751c12727", &function_d07b00ed28c25f0c );
    params = setup_callback_params();
    level callback::callback_sequence( #"callback_sequence_test", params );
    autotests::function_e50d1006e5d65c04( "Step A Handled", params.step_a_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 55 );
    autotests::function_e50d1006e5d65c04( "Step B Handled", params.step_b_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 56 );
    autotests::function_e50d1006e5d65c04( "Step C Handled", params.step_c_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 57 );
    autotests::function_e50d1006e5d65c04( "Step D Handled", params.var_2e7a5b047861730e, 1, "scripts/autotests/test_callback_sequence.gsc", 58 );
    autotests::function_e50d1006e5d65c04( "Step E Handled", params.var_21cc49b38aa6a521, 1, "scripts/autotests/test_callback_sequence.gsc", 59 );
    autotests::function_e50d1006e5d65c04( "Step A Order Handled", params.step_a_hitcount, 1, "scripts/autotests/test_callback_sequence.gsc", 61 );
    autotests::function_e50d1006e5d65c04( "Step B Order Handled", params.step_b_hitcount, 2, "scripts/autotests/test_callback_sequence.gsc", 62 );
    autotests::function_e50d1006e5d65c04( "Step C Order Handled", params.step_c_hitcount, 3, "scripts/autotests/test_callback_sequence.gsc", 63 );
    autotests::function_e50d1006e5d65c04( "Step D Order Handled", params.var_4bd00228c8984a6c, 4, "scripts/autotests/test_callback_sequence.gsc", 64 );
    autotests::function_e50d1006e5d65c04( "Step E Order Handled", params.var_3723f55ac0656255, 5, "scripts/autotests/test_callback_sequence.gsc", 65 );
    level callback::function_a5ba9bab3a8b0b6( #"callback_sequence_test", #"test_step_b", &handle_step_b );
    level callback::function_a5ba9bab3a8b0b6( #"callback_sequence_test", #"hash_95ae337751c12727", &function_d07b00ed28c25f0c );
    params = setup_callback_params();
    level callback::callback_sequence( #"callback_sequence_test", params );
    autotests::function_e50d1006e5d65c04( "2.Step A Handled", params.step_a_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 75 );
    autotests::function_dbbd10e009ede41e( "2.Step B Not Handled", params.step_b_handled, "scripts/autotests/test_callback_sequence.gsc", 76 );
    autotests::function_e50d1006e5d65c04( "2.Step C Handled", params.step_c_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 77 );
    autotests::function_dbbd10e009ede41e( "2.Step D Not Handled", params.var_2e7a5b047861730e, "scripts/autotests/test_callback_sequence.gsc", 78 );
    autotests::function_e50d1006e5d65c04( "2.Step E Handled", params.var_21cc49b38aa6a521, 1, "scripts/autotests/test_callback_sequence.gsc", 79 );
    autotests::function_e50d1006e5d65c04( "2.Step A Order Handled", params.step_a_hitcount, 1, "scripts/autotests/test_callback_sequence.gsc", 81 );
    autotests::function_dbbd10e009ede41e( "2.Step B No Order Handled", params.step_b_hitcount, "scripts/autotests/test_callback_sequence.gsc", 82 );
    autotests::function_e50d1006e5d65c04( "2.Step C Order Handled", params.step_c_hitcount, 2, "scripts/autotests/test_callback_sequence.gsc", 83 );
    autotests::function_dbbd10e009ede41e( "2.Step D No Order Handled", params.var_4bd00228c8984a6c, "scripts/autotests/test_callback_sequence.gsc", 84 );
    autotests::function_e50d1006e5d65c04( "2.Step E Order Handled", params.var_3723f55ac0656255, 3, "scripts/autotests/test_callback_sequence.gsc", 85 );
    waitframe();
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_a", &function_fb7d47175d8552cf );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_a", &function_fb7d48175d855502 );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_a", &function_fb7d49175d855735 );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_c", &function_184d151772906e19 );
    level callback::function_dc654a4d4126a928( #"callback_sequence_test", #"test_step_c", &function_184d121772906780 );
    params = setup_callback_params();
    level callback::callback_sequence( #"callback_sequence_test", params );
    autotests::function_e50d1006e5d65c04( "3.Step A Handled", params.step_a_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 102 );
    autotests::function_dbbd10e009ede41e( "3.Step B Not Handled", params.step_b_handled, "scripts/autotests/test_callback_sequence.gsc", 103 );
    autotests::function_e50d1006e5d65c04( "3.Step C Handled", params.step_c_handled, 1, "scripts/autotests/test_callback_sequence.gsc", 104 );
    autotests::function_dbbd10e009ede41e( "3.Step D Not Handled", params.var_2e7a5b047861730e, "scripts/autotests/test_callback_sequence.gsc", 105 );
    autotests::function_e50d1006e5d65c04( "3.Step E Handled", params.var_21cc49b38aa6a521, 1, "scripts/autotests/test_callback_sequence.gsc", 106 );
    autotests::function_e50d1006e5d65c04( "3.Step A Order Handled", params.step_a_hitcount, 4, "scripts/autotests/test_callback_sequence.gsc", 108 );
    autotests::function_dbbd10e009ede41e( "3.Step B No Order Handled", params.step_b_hitcount, "scripts/autotests/test_callback_sequence.gsc", 109 );
    autotests::function_e50d1006e5d65c04( "3.Step C Order Handled", params.step_c_hitcount, 7, "scripts/autotests/test_callback_sequence.gsc", 110 );
    autotests::function_dbbd10e009ede41e( "3.Step D No Order Handled", params.var_4bd00228c8984a6c, "scripts/autotests/test_callback_sequence.gsc", 111 );
    autotests::function_e50d1006e5d65c04( "3.Step E Order Handled", params.var_3723f55ac0656255, 8, "scripts/autotests/test_callback_sequence.gsc", 112 );
}

// Namespace test_callback_sequence
// Params 0, eflags: 0x4
// Checksum 0xa06f8187, Offset: 0x984
// Size: 0x18
function private setup_callback_params()
{
    return { #var_edaa7b796202470f:0, #is_unit_test:1 };
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0xc60d2c8a, Offset: 0x9a5
// Size: 0x3d
function private handle_step_a( params )
{
    params.var_edaa7b796202470f++;
    params.step_a_hitcount = params.var_edaa7b796202470f;
    params.step_a_handled = 1;
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x8dbefaf6, Offset: 0x9ea
// Size: 0x3d
function private handle_step_b( params )
{
    params.var_edaa7b796202470f++;
    params.step_b_hitcount = params.var_edaa7b796202470f;
    params.step_b_handled = 1;
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x200b51d, Offset: 0xa2f
// Size: 0x3d
function private handle_step_c( params )
{
    params.var_edaa7b796202470f++;
    params.step_c_hitcount = params.var_edaa7b796202470f;
    params.step_c_handled = 1;
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x1ad9560e, Offset: 0xa74
// Size: 0x3d
function private function_d07b00ed28c25f0c( params )
{
    params.var_edaa7b796202470f++;
    params.var_4bd00228c8984a6c = params.var_edaa7b796202470f;
    params.var_2e7a5b047861730e = 1;
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x956719e5, Offset: 0xab9
// Size: 0x3d
function private function_d07b01ed28c2613f( params )
{
    params.var_edaa7b796202470f++;
    params.var_3723f55ac0656255 = params.var_edaa7b796202470f;
    params.var_21cc49b38aa6a521 = 1;
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x57a34625, Offset: 0xafe
// Size: 0x15
function private function_fb7d47175d8552cf( params )
{
    handle_step_a( params );
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0xceaa179f, Offset: 0xb1b
// Size: 0x15
function private function_fb7d48175d855502( params )
{
    handle_step_a( params );
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0xb9ad2709, Offset: 0xb38
// Size: 0x15
function private function_fb7d49175d855735( params )
{
    handle_step_a( params );
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0xba29f367, Offset: 0xb55
// Size: 0x15
function private function_184d151772906e19( params )
{
    handle_step_c( params );
}

// Namespace test_callback_sequence
// Params 1, eflags: 0x4
// Checksum 0x2320a2dd, Offset: 0xb72
// Size: 0x15
function private function_184d121772906780( params )
{
    handle_step_c( params );
}

