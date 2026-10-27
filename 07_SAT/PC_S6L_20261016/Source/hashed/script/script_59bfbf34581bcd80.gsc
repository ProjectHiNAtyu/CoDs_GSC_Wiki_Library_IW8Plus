// script_59bfbf34581bcd80  (hash_59bfbf34581bcd80.gscc) (size: 1360 Bytes / 0x550 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77737ab8 (2004056760)
// size ...... 1360 (0x550)
// includes .. 3   (offset: 0x4f0)
// strings ... 0   (offset: 0x508)
// dev strs .. 6   (offset: 0x508)
// exports ... 6   (offset: 0x2e8)
// cseg ...... 0x58 + 0x290 (0x2e8)
// imports ... 9   (offset: 0x3d8)
// animtree1 . 0   (offset: 0x550)
// animtree2 . 0   (offset: 0x550)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_5ad87ac882bc3875;

// Namespace namespace_5ad87ac882bc3875
// Params 0, eflags: 0x1
// Checksum 0xabdd87ec, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"hash_d340abf7e37cda34", &init );
}

// Namespace namespace_5ad87ac882bc3875
// Params 0
// Checksum 0x3b803a5d, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"hash_d340abf7e37cda34", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"hash_d340abf7e37cda34", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace namespace_5ad87ac882bc3875
// Params 1, eflags: 0x4
// Checksum 0xf8c4ebbf, Offset: 0xdb
// Size: 0xc8, Type: bool
function private on_give_skill( skill_bundle )
{
    callback::add( #"hash_e62e1bb16840185b", &process_percent );
    assert( skill_bundle.var_53f424ee33dac81, "<dev string:x24>" );
    assert( skill_bundle.var_8bc748e0d420fc99, "<dev string:x81>" );
    assert( skill_bundle.var_d58eefe3e38d1219, "<dev string:xd7>" );
    assert( skill_bundle.var_b8aedd0f3843701, "<dev string:x12b>" );
    assert( skill_bundle.var_1691f8e10dbfde0d, "<dev string:x17f>" );
    assert( skill_bundle.var_78a20b84c0eae605, "<dev string:x1d3>" );
    self.var_cf59b97f309af340 = { #bundle:skill_bundle };
    return true;
}

// Namespace namespace_5ad87ac882bc3875
// Params 1, eflags: 0x4
// Checksum 0xb92dc64, Offset: 0x1ac
// Size: 0x2b
function private function_c51f1692ecb73bfe( skill_bundle )
{
    callback::remove( #"hash_e62e1bb16840185b", &process_percent );
    self.var_cf59b97f309af340 = undefined;
}

// Namespace namespace_5ad87ac882bc3875
// Params 1, eflags: 0x4
// Checksum 0x4e96d79e, Offset: 0x1df
// Size: 0x109
function private process_percent( percent_data )
{
    bundle = self.var_cf59b97f309af340.bundle;
    percent_data.soldierexecution = bundle.var_5c3dc1a44fdc7826 ?? percent_data.soldierexecution;
    percent_data.execution = bundle.executionpercentage ?? percent_data.execution;
    percent_data.soldierdeath = bundle.soldierpercentage ?? percent_data.soldierdeath;
    percent_data.var_523f42d5076356fa = bundle.var_a76b4cde02a3c78 ?? percent_data.var_523f42d5076356fa;
    percent_data.var_3b40d48b1fb3042e = bundle.var_6a4f8627d3368a2c ?? percent_data.var_3b40d48b1fb3042e;
    percent_data.var_ddc04754c8c96d14 = bundle.var_32dca66400819f06 ?? percent_data.var_ddc04754c8c96d14;
}

