// script_6036f2305ff72eb5  (hash_6036f2305ff72eb5.gscc) (size: 2242 Bytes / 0x8c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c0e04a8 (2081293480)
// size ...... 2242 (0x8c2)
// includes .. 4   (offset: 0x84e)
// strings ... 1   (offset: 0x86e)
// dev strs .. 6   (offset: 0x87a)
// exports ... 9   (offset: 0x49e)
// cseg ...... 0x78 + 0x426 (0x49e)
// imports ... 19  (offset: 0x606)
// animtree1 . 0   (offset: 0x8c2)
// animtree2 . 0   (offset: 0x8c2)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_flame_blast_upgrade;

// Namespace skill_flame_blast_upgrade
// Params 0, eflags: 0x1
// Checksum 0xa27ddddd, Offset: 0x96
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"flame_blast_upgrade", &init );
}

// Namespace skill_flame_blast_upgrade
// Params 0
// Checksum 0xffcfa5be, Offset: 0xb5
// Size: 0x98
function init()
{
    utility::registersharedfunc( #"flame_blast_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"flame_blast_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"flame_blast_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"flame_blast_upgrade", #"hash_64e64b094ad00886", &function_6b5e652b3723897 );
    utility::registersharedfunc( #"flame_blast_upgrade", #"hash_4bed473d5147db4d", &function_547d04540d5b3e76 );
}

// Namespace skill_flame_blast_upgrade
// Params 1, eflags: 0x4
// Checksum 0xd0b1c592, Offset: 0x155
// Size: 0x61
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_a97cc56727123d15 )
    {
        fx_id = "flame_blast_upgrade_stun_vfx" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = loadfxasset( skill_bundle.var_a97cc56727123d15 );
        skill_bundle.var_c20bf8777741be70 = fx_id;
    }
}

// Namespace skill_flame_blast_upgrade
// Params 1, eflags: 0x4
// Checksum 0x238f3769, Offset: 0x1be
// Size: 0x104, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_364df38409e63865 )
        {
            assert( skill_bundle.var_4ab2714b61d3d9b3, "<dev string:x24>" );
            assert( skill_bundle.var_85e87f302d2fd762, "<dev string:x80>" );
            assert( skill_bundle.var_a3ed6f915e5067c4, "<dev string:xdc>" );
        }
    #/
    
    self.var_956e5cc6c1524223 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_feae510b6bef852c )
    {
        assert( skill_bundle.var_d739f4eb9b46abe5, "<dev string:x136>" );
        assert( skill_bundle.var_dfb7cf6a7ba38d43, "<dev string:x185>" );
        assert( skill_bundle.var_a97cc56727123d15, "<dev string:x1d6>" );
        assert( !callback::exists( #"super_flame_blast_begin_use", &function_ee43e7bfcf231268 ) );
        callback::add( #"super_flame_blast_begin_use", &function_ee43e7bfcf231268 );
    }
    
    return true;
}

// Namespace skill_flame_blast_upgrade
// Params 1, eflags: 0x4
// Checksum 0x2ac6b127, Offset: 0x2cb
// Size: 0x55
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_feae510b6bef852c )
    {
        assert( callback::exists( #"super_flame_blast_begin_use", &function_ee43e7bfcf231268 ) );
        callback::remove( #"super_flame_blast_begin_use", &function_ee43e7bfcf231268 );
    }
    
    self.var_956e5cc6c1524223 = undefined;
}

// Namespace skill_flame_blast_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc52f9ab1, Offset: 0x328
// Size: 0xd7
function private function_ee43e7bfcf231268( params )
{
    bundle = self.var_956e5cc6c1524223.bundle;
    stun_data = { #stunorigin:self.origin, #var_c27a2418f1d8f32d:1, #playersstunduration:bundle.var_dfb7cf6a7ba38d43, #aistunduration:bundle.var_dfb7cf6a7ba38d43, #stunradius:bundle.var_d739f4eb9b46abe5, #source:#"flame_blast_upgrade" };
    
    if ( bundle.var_c20bf8777741be70 )
    {
        playfx( utility::getfx( bundle.var_c20bf8777741be70 ), self.origin );
    }
    
    thread ob_stun::function_f3eb76017907e72f( stun_data );
}

// Namespace skill_flame_blast_upgrade
// Params 0, eflags: 0x4
// Checksum 0x55d29cfc, Offset: 0x407
// Size: 0x1f
function private function_6b5e652b3723897()
{
    return self.var_956e5cc6c1524223.bundle.var_8000ee4890a0ac94;
}

// Namespace skill_flame_blast_upgrade
// Params 0, eflags: 0x4
// Checksum 0x170fbca4, Offset: 0x42f
// Size: 0x6e
function private function_547d04540d5b3e76()
{
    bundle = self.var_956e5cc6c1524223.bundle;
    
    if ( !bundle.var_364df38409e63865 )
    {
        return;
    }
    
    return { #tick:bundle.var_a3ed6f915e5067c4, #height:bundle.var_85e87f302d2fd762, #radius:bundle.var_4ab2714b61d3d9b3 };
}

