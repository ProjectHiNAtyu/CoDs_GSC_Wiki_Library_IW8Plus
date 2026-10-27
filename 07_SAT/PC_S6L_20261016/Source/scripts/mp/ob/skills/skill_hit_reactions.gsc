// scripts\mp\ob\skills\skill_hit_reactions.gsc  (hash_58a9f34b924fd1d3.gscc) (size: 2910 Bytes / 0xb5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xffeb0257 (4293591639)
// size ...... 2910 (0xb5e)
// includes .. 3   (offset: 0xae6)
// strings ... 6   (offset: 0xafe)
// dev strs .. 2   (offset: 0xb46)
// exports ... 9   (offset: 0x726)
// cseg ...... 0xfa + 0x62c (0x726)
// imports ... 21  (offset: 0x88e)
// animtree1 . 0   (offset: 0xb5e)
// animtree2 . 0   (offset: 0xb5e)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_hit_reactions;

// Namespace skill_hit_reactions
// Params 0, eflags: 0x1
// Checksum 0x9c1fe83, Offset: 0x118
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"hit_reactions", &init );
}

// Namespace skill_hit_reactions
// Params 0
// Checksum 0xbfc1e930, Offset: 0x137
// Size: 0x72
function init()
{
    utility::registersharedfunc( #"hit_reactions", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"hit_reactions", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"hit_reactions", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"player_damaged", &function_d6ca434eb1a4b739 );
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0xb2aaab4e, Offset: 0x1b1
// Size: 0x6c
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_76ec751bc2114097 )
    {
        fx_asset = loadfxasset( skill_bundle.var_76ec751bc2114097 );
        fx_id = "hit_reactions_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_6e1095f18510989a = fx_id;
    }
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0x3b829ca, Offset: 0x225
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_6d8a513f53f8c3b8 = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0xa048e154, Offset: 0x251
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_6d8a513f53f8c3b8 = undefined;
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0x7d54c09, Offset: 0x26f
// Size: 0x3b5
function private function_242d14352c43a777( params )
{
    attacker = params.attacker ?? params.eattacker;
    var_da55798eb12048a0 = self.var_6d8a513f53f8c3b8;
    
    if ( !isalive( attacker ) || !var_da55798eb12048a0 || !isalive( self ) || isplayer( attacker ) || !isagent( attacker ) )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    data = { #skill_name:#"hit_reactions", #cooldown:bundle.var_d752948964122c81, #var_3b55b60765b98d29:[], #var_b8f3721c1cf18fb7:{ #var_4ffaa10c855d8342:1, #var_9aac268dc1b55d9b:bundle.var_a1fdd168f493eebd, #var_224f265fd5efc9ff:"shadow_vortex_special_impact_fx", #var_e085937a3498110c:"shadow_vortex_teleport_trail", #var_75653cbca1a6c623:"shadow_vortex_warp_air_fx", #var_ea11f196c7e0e9a4:"shadow_vortex_warp_ground_fx", #var_ad5d8364fc4272f:bundle.var_73679764546fd50f, #var_20baf5221f9d6a68:bundle.var_a8661127cca921bc, #var_20de0b221fc3e282:bundle.var_a888ff27cccf41de, #var_e20efab7b51bd48c:bundle.var_94eaa27ec2ce6428, #lethalradius:bundle.var_286655dfc679872a, #var_b2dd3f86af2d2115:bundle.var_22b35ca0f9d0d96c, #vortexduration:0 }, #weights_table:bundle.var_48ba2410934772a2, #objweapon:params.objweapon, #partname:params.partname, #modelindex:params.modelindex, #timeoffset:params.timeoffset, #shitloc:params.shitloc, #vdir:params.vdir, #vpoint:params.vpoint, #idflags:params.idflags, #idamage:params.idamage, #inflictor:params.inflictor, #probability:bundle.var_49a88b549c3413b4, #player:self };
    var_46629f9a8025bc14 = bundle.var_aaeb04191eaca117;
    
    if ( var_46629f9a8025bc14 )
    {
        if ( var_46629f9a8025bc14 >= 1 )
        {
            data.var_3b55b60765b98d29[ data.var_3b55b60765b98d29.size ] = 1;
        }
        
        if ( var_46629f9a8025bc14 >= 2 )
        {
            data.var_3b55b60765b98d29[ data.var_3b55b60765b98d29.size ] = 2;
        }
        
        if ( var_46629f9a8025bc14 >= 3 )
        {
            data.var_3b55b60765b98d29[ data.var_3b55b60765b98d29.size ] = 3;
        }
    }
    
    assert( data.var_3b55b60765b98d29.size > 0, "<dev string:x24>" );
    
    if ( utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
    {
        result = attacker utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", data );
        
        if ( result )
        {
            effect_id = utility::getfx( bundle.var_6e1095f18510989a );
            
            if ( !effect_id )
            {
                return;
            }
            
            playfxontag( effect_id, self, "j_spine4" );
        }
    }
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0xa662db3b, Offset: 0x62c
// Size: 0xcf, Type: bool
function private can_trigger_effect( dmg_struct )
{
    var_da55798eb12048a0 = self.var_6d8a513f53f8c3b8;
    
    if ( !var_da55798eb12048a0 )
    {
        return false;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !bundle.var_f712ab5e6d421ed5 && !bundle.var_f4a487a85d32e9b4 )
    {
        assertmsg( "<dev string:x91>" );
        return false;
    }
    
    is_dmg_melee = utility::ismeleedamage( dmg_struct.smeansofdeath );
    var_79ac4b022ebc2f9b = is_dmg_melee && !bundle.var_f712ab5e6d421ed5;
    var_b8df8c22f3fe302 = !is_dmg_melee && !bundle.var_f4a487a85d32e9b4;
    
    if ( var_79ac4b022ebc2f9b || var_b8df8c22f3fe302 )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_hit_reactions
// Params 1, eflags: 0x4
// Checksum 0x72ece1e0, Offset: 0x704
// Size: 0x22
function private function_d6ca434eb1a4b739( dmg_struct )
{
    if ( !can_trigger_effect( dmg_struct ) )
    {
        return;
    }
    
    function_242d14352c43a777( dmg_struct );
}

