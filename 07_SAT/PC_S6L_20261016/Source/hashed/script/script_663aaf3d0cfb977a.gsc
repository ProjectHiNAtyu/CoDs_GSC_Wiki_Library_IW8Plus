// script_663aaf3d0cfb977a  (hash_663aaf3d0cfb977a.gscc) (size: 2296 Bytes / 0x8f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d53f591 (2639525265)
// size ...... 2296 (0x8f8)
// includes .. 4   (offset: 0x8ac)
// strings ... 3   (offset: 0x8cc)
// dev strs .. 0   (offset: 0x8f8)
// exports ... 9   (offset: 0x53c)
// cseg ...... 0x87 + 0x4b5 (0x53c)
// imports ... 18  (offset: 0x6a4)
// animtree1 . 0   (offset: 0x8f8)
// animtree2 . 0   (offset: 0x8f8)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_drone_launcher_upgrade;

// Namespace skill_drone_launcher_upgrade
// Params 0, eflags: 0x1
// Checksum 0xae5531cd, Offset: 0xa5
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"drone_launcher_upgrade", &init );
}

// Namespace skill_drone_launcher_upgrade
// Params 0
// Checksum 0xb2dc8c41, Offset: 0xc4
// Size: 0x72
function init()
{
    utility::registersharedfunc( #"drone_launcher_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"drone_launcher_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( "super_drone_launcher", #"hash_3e5d87be73b16451", &function_bb5f86f3d3df0f08 );
    utility::registersharedfunc( "super_drone_launcher", #"hash_a7193167626b402f", &function_5f2e9426f20524da );
}

// Namespace skill_drone_launcher_upgrade
// Params 1, eflags: 0x4
// Checksum 0x32c95f7a, Offset: 0x13e
// Size: 0x42, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_27f1abdf2db225c = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_e0fe40d39aaa6d41 )
    {
        callback::add( "drone_destroyed", &function_d9362481f1713086 );
    }
    
    return true;
}

// Namespace skill_drone_launcher_upgrade
// Params 1, eflags: 0x4
// Checksum 0x4a3f933, Offset: 0x189
// Size: 0x35
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_e0fe40d39aaa6d41 )
    {
        callback::remove( "drone_destroyed", &function_d9362481f1713086 );
    }
    
    self.var_27f1abdf2db225c = undefined;
}

// Namespace skill_drone_launcher_upgrade
// Params 1, eflags: 0x4
// Checksum 0x4d042c21, Offset: 0x1c6
// Size: 0xe5
function private function_d9362481f1713086( params )
{
    drone = params.drone;
    
    if ( !drone.issuper )
    {
        return;
    }
    
    bundle = self.var_27f1abdf2db225c.bundle;
    
    if ( utility::percent_chance( bundle.var_f9ca3a9a7a2ddc69 ) )
    {
        stundata = { #stunorigin:params.origin, #var_c27a2418f1d8f32d:1, #aistunduration:bundle.var_193f319acc2a62c3, #playersstunduration:bundle.var_7495cacd1160e558, #stunradius:bundle.var_da081784097154eb, #source:#"drone_launcher_upgrade" };
        thread ob_stun::function_f3eb76017907e72f( stundata );
    }
}

// Namespace skill_drone_launcher_upgrade
// Params 1, eflags: 0x4
// Checksum 0x32d75add, Offset: 0x2b3
// Size: 0x224
function private function_5f2e9426f20524da( params )
{
    bundle = self.var_27f1abdf2db225c.bundle;
    
    if ( !bundle.var_1038788080958c07 )
    {
        return;
    }
    
    if ( params.deploy_id >= bundle.var_1038788080958c07 )
    {
        return;
    }
    
    if ( !utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
    {
        return;
    }
    
    ai_tiers = [];
    var_c04e417f8531bdb5 = bundle.var_1bdd357823734b60;
    
    if ( var_c04e417f8531bdb5 >= 1 )
    {
        ai_tiers[ ai_tiers.size ] = 1;
    }
    
    if ( var_c04e417f8531bdb5 >= 2 )
    {
        ai_tiers[ ai_tiers.size ] = 2;
    }
    
    if ( var_c04e417f8531bdb5 >= 3 )
    {
        ai_tiers[ ai_tiers.size ] = 3;
    }
    
    if ( var_c04e417f8531bdb5 >= 4 )
    {
        ai_tiers[ ai_tiers.size ] = 4;
    }
    
    ammomod_data = { #skill_name:#"drone_launcher_upgrade", #cooldown:0, #var_3b55b60765b98d29:ai_tiers, #weights_table:bundle.var_5c4be6c482c3dd21, #shitloc:"", #vpoint:params.origin, #idamage:0, #inflictor:self, #probability:bundle.var_16c8c1306b860bf1, #player:self };
    enemies = getaiarrayinradius( params.origin, params.damage_radius );
    
    foreach ( enemy in enemies )
    {
        if ( !function_4de5a741f5baa1c4( enemy ) )
        {
            continue;
        }
        
        enemy utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", ammomod_data );
    }
}

// Namespace skill_drone_launcher_upgrade
// Params 1, eflags: 0x4
// Checksum 0x8edbf787, Offset: 0x4df
// Size: 0x34, Type: bool
function private function_4de5a741f5baa1c4( agent )
{
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    if ( agent.team == self.team )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_drone_launcher_upgrade
// Params 0, eflags: 0x4
// Checksum 0x3cd1439b, Offset: 0x51c
// Size: 0x1f
function private function_bb5f86f3d3df0f08()
{
    return self.var_27f1abdf2db225c.bundle.var_6cb7606ff75756d6;
}

