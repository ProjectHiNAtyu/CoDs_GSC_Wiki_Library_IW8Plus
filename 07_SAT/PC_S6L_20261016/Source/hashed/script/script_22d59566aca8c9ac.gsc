// script_22d59566aca8c9ac  (hash_22d59566aca8c9ac.gscc) (size: 1853 Bytes / 0x73d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5c75f2e (2781306670)
// size ...... 1853 (0x73d)
// includes .. 3   (offset: 0x709)
// strings ... 1   (offset: 0x721)
// dev strs .. 1   (offset: 0x731)
// exports ... 7   (offset: 0x3e5)
// cseg ...... 0x6d + 0x378 (0x3e5)
// imports ... 17  (offset: 0x4fd)
// animtree1 . 0   (offset: 0x73d)
// animtree2 . 0   (offset: 0x73d)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_9026c87d57ac0cb1;

// Namespace namespace_9026c87d57ac0cb1
// Params 0, eflags: 0x1
// Checksum 0x47607fd5, Offset: 0x8b
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"equipment_charger", &init );
}

// Namespace namespace_9026c87d57ac0cb1
// Params 0
// Checksum 0xee900e99, Offset: 0xaa
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"equipment_charger", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"equipment_charger", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace namespace_9026c87d57ac0cb1
// Params 1, eflags: 0x4
// Checksum 0x582894d2, Offset: 0xf0
// Size: 0xad, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_a922cc2f0785df91, "<dev string:x24>" );
    self.var_f6d5679991f653c5 = { #bundle:skill_bundle };
    assert( !callback::exists( #"player_item_pickup", &on_item_picked_up ) );
    callback::add( #"player_item_pickup", &on_item_picked_up );
    
    if ( skill_bundle.var_cc7e15c8c26e12cc )
    {
        assert( !callback::exists( #"can_pickup_ammo_pouch", &function_6cd74fa98bc8a795 ) );
        callback::add( #"can_pickup_ammo_pouch", &function_6cd74fa98bc8a795 );
    }
    
    return true;
}

// Namespace namespace_9026c87d57ac0cb1
// Params 1, eflags: 0x4
// Checksum 0x896a0505, Offset: 0x1a6
// Size: 0x73
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"player_item_pickup", &on_item_picked_up ) );
    callback::remove( #"player_item_pickup", &on_item_picked_up );
    
    if ( callback::exists( #"can_pickup_ammo_pouch", &function_6cd74fa98bc8a795 ) )
    {
        callback::remove( #"can_pickup_ammo_pouch", &function_6cd74fa98bc8a795 );
    }
    
    self.var_f6d5679991f653c5 = undefined;
}

// Namespace namespace_9026c87d57ac0cb1
// Params 1, eflags: 0x4
// Checksum 0xa03cee0d, Offset: 0x221
// Size: 0x125
function private on_item_picked_up( params )
{
    if ( params.itembundlename != %"itemspawnentry:ob_sat_item_ammo" )
    {
        return;
    }
    
    bundle = self.var_f6d5679991f653c5.bundle;
    
    if ( !bundle )
    {
        return;
    }
    
    percent = bundle.var_a922cc2f0785df91;
    
    foreach ( equip in self.pers[ "rechargeEquipment" ] )
    {
        if ( equip.rechargeremaining > 0 )
        {
            var_f9932ff4c5a76be8 = min( equip.rechargetime * percent, equip.rechargeremaining );
            equip.rechargeremaining -= var_f9932ff4c5a76be8;
        }
    }
}

// Namespace namespace_9026c87d57ac0cb1
// Params 1, eflags: 0x4
// Checksum 0x173424c3, Offset: 0x34e
// Size: 0x96, Type: bool
function private function_6cd74fa98bc8a795( params )
{
    foreach ( equip in self.pers[ "rechargeEquipment" ] )
    {
        if ( equip.rechargeremaining > 0 )
        {
            return true;
        }
    }
    
    return false;
}

