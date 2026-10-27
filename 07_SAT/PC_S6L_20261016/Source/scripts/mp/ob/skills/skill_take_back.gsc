// scripts\mp\ob\skills\skill_take_back.gsc  (hash_251eb536bc807bb2.gscc) (size: 2399 Bytes / 0x95f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf0da83 (217111171)
// size ...... 2399 (0x95f)
// includes .. 6   (offset: 0x8e7)
// strings ... 1   (offset: 0x917)
// dev strs .. 5   (offset: 0x923)
// exports ... 10  (offset: 0x4df)
// cseg ...... 0x66 + 0x479 (0x4df)
// imports ... 21  (offset: 0x66f)
// animtree1 . 0   (offset: 0x95f)
// animtree2 . 0   (offset: 0x95f)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;

#namespace skill_take_back;

// Namespace skill_take_back
// Params 0, eflags: 0x1
// Checksum 0x88f63046, Offset: 0x84
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"take_back", &init );
}

// Namespace skill_take_back
// Params 0
// Checksum 0x5eb21842, Offset: 0xa3
// Size: 0x6a
function init()
{
    utility::registersharedfunc( #"take_back", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"take_back", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"equipment_use_success", &on_equipment_used );
    level callback::add( #"killstreak_activated", &on_killstreak_used );
}

// Namespace skill_take_back
// Params 1, eflags: 0x4
// Checksum 0x3b1f606, Offset: 0x115
// Size: 0xfb, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_be63fce0f9d4213a, "<dev string:x24>" );
    assert( skill_bundle.var_f61d2028c7d21fe8, "<dev string:x65>" );
    assert( skill_bundle.var_d64c5015353218e, "<dev string:xa7>" );
    assert( skill_bundle.var_9208a70846fd9def, "<dev string:xdf>" );
    assert( skill_bundle.var_2678fea872169ebf, "<dev string:x12e>" );
    self.var_e687acbcf45e7dc7 = { #var_71a643fcad6f7618:0, #bundle:skill_bundle };
    
    if ( skill_bundle.var_c4fcbbb43c405925 )
    {
        assert( !callback::exists( #"player_item_pickup", &function_1795214a928c3bc7 ) );
        callback::add( #"player_item_pickup", &function_1795214a928c3bc7 );
        
        if ( !isdefined( self.var_3904c5fa8d957527 ) )
        {
            self.var_3904c5fa8d957527 = 0;
        }
    }
    
    return true;
}

// Namespace skill_take_back
// Params 1, eflags: 0x4
// Checksum 0x90bc10dc, Offset: 0x219
// Size: 0x55
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_c4fcbbb43c405925 )
    {
        assert( callback::exists( #"player_item_pickup", &function_1795214a928c3bc7 ) );
        callback::remove( #"player_item_pickup", &function_1795214a928c3bc7 );
    }
    
    self.var_e687acbcf45e7dc7 = undefined;
}

// Namespace skill_take_back
// Params 1, eflags: 0x4
// Checksum 0xc25e2673, Offset: 0x276
// Size: 0x80
function private on_equipment_used( params )
{
    bundle = self.var_e687acbcf45e7dc7.bundle;
    
    if ( !bundle || !params.ref )
    {
        return;
    }
    
    if ( !try_take_back( self.var_e687acbcf45e7dc7, bundle, bundle.var_be63fce0f9d4213a ) )
    {
        return;
    }
    
    equipment_mp::incrementequipmentammo( params.ref, bundle.var_d64c5015353218e );
}

// Namespace skill_take_back
// Params 1, eflags: 0x4
// Checksum 0xf44ab515, Offset: 0x2fe
// Size: 0xb9
function private on_killstreak_used( params )
{
    bundle = self.var_e687acbcf45e7dc7.bundle;
    
    if ( !bundle || !params.streakslot )
    {
        return;
    }
    
    if ( self.var_3904c5fa8d957527 >= bundle.var_c4fcbbb43c405925 || !try_take_back( self.var_e687acbcf45e7dc7, bundle, bundle.var_f61d2028c7d21fe8 ) )
    {
        return;
    }
    
    self.var_3904c5fa8d957527++;
    killstreaks::awardkillstreak( params.streakitem.streakname, #"take_back", undefined, undefined, undefined, params.streakslot );
}

// Namespace skill_take_back
// Params 3, eflags: 0x4
// Checksum 0x24ab9d1a, Offset: 0x3bf
// Size: 0x71, Type: bool
function private try_take_back( var_da55798eb12048a0, bundle, base_chance )
{
    chance = var_da55798eb12048a0.var_71a643fcad6f7618 ? bundle.var_2678fea872169ebf : base_chance;
    
    if ( !utility::percent_chance( chance ) )
    {
        return false;
    }
    
    if ( !var_da55798eb12048a0.var_71a643fcad6f7618 )
    {
        thread function_729024249facadde( var_da55798eb12048a0, bundle );
    }
    
    return true;
}

// Namespace skill_take_back
// Params 2, eflags: 0xc
// Checksum 0xb05cb53c, Offset: 0x439
// Size: 0x60
function private function_729024249facadde( var_da55798eb12048a0, bundle )
{
    self notify( #"hash_348f3f2a22b08c5e" );
    self endon( #"hash_348f3f2a22b08c5e" );
    self endon( #"hash_a35808f532d8b26c" );
    var_da55798eb12048a0.var_71a643fcad6f7618 = 1;
    wait bundle.var_9208a70846fd9def;
    var_da55798eb12048a0.var_71a643fcad6f7618 = 0;
}

// Namespace skill_take_back
// Params 1, eflags: 0x4
// Checksum 0x82b0a886, Offset: 0x4a1
// Size: 0x3e
function private function_1795214a928c3bc7( params )
{
    item_type = common_item::function_16e8c106491eeaca( params.itembundle );
    
    if ( item_type == "killstreak" )
    {
        self.var_3904c5fa8d957527 = 0;
    }
}

