// scripts\mp\ob\skills\skill_w_mod.gsc  (hash_03c850b8fd986e1f.gscc) (size: 3694 Bytes / 0xe6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e7854fc (1584944380)
// size ...... 3694 (0xe6e)
// includes .. 5   (offset: 0xdda)
// strings ... 1   (offset: 0xe02)
// dev strs .. 8   (offset: 0xe0e)
// exports ... 11  (offset: 0x862)
// cseg ...... 0x78 + 0x7ea (0x862)
// imports ... 33  (offset: 0xa1a)
// animtree1 . 0   (offset: 0xe6e)
// animtree2 . 0   (offset: 0xe6e)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\perk_w_mod;

#namespace skill_w_mod;

// Namespace skill_w_mod
// Params 0, eflags: 0x1
// Checksum 0xcfc6037e, Offset: 0x96
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"w_mod", &init );
}

// Namespace skill_w_mod
// Params 0
// Checksum 0x2656a9a7, Offset: 0xb5
// Size: 0x105
function init()
{
    utility::registersharedfunc( #"w_mod", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"w_mod", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"w_mod", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"w_mod", #"hash_8698c290a2e85469", &get_skill_weapons );
    callback::add( #"on_ai_killed", &on_enemy_killed );
    callback::add( #"player_death", &on_enemy_killed );
    level._effect[ #"hash_8efbce72bda25a2" ] = loadfxasset( "vfx_sat_coop_conjuration_off" );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4a>", "<dev string:x56>", &function_d195fa39d4938a85, 0 );
        devgui::add_devgui_func( "<dev string:x68>", "<dev string:x74>", &function_778f38ddf231b5e0, 0 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace skill_w_mod
// Params 1, eflags: 0x4
// Checksum 0xf0b7b457, Offset: 0x1c2
// Size: 0x1d9
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_b13c6b8290c43a30 )
    {
        skill_bundle.var_ab4c1afe21ac069c = utility::function_4b74c15943231980( skill_bundle.var_b13c6b8290c43a30 );
    }
    
    if ( skill_bundle.wmodcooldown )
    {
        skill_bundle.var_30c61e6b937c0b98 = utility::function_4b74c15943231980( skill_bundle.wmodcooldown );
    }
    
    skill_bundle.var_5b2e4750bfb318c = { #var_112369a470e1652:1, #var_cb7b53471c8f3170:skill_bundle.var_59cbe83d8d3e430c, #var_f289150eafcfea7e:1, #var_a7c29cfa649167e0:skill_bundle.var_fbe49475015973ae, #attack_rate:skill_bundle.var_4e6632480cfff133, #use_fixed_damage:skill_bundle.var_43ca8673c4e4f107, #player_damage_multiplier:skill_bundle.var_990ae4ab6dffedb6, #human_damage_multiplier:skill_bundle.var_a3ea15f1c39b0ee0, #zombie_damage_multiplier:skill_bundle.var_547b9cc4b23498d, #fixed_attack_damage:skill_bundle.var_ceea2c6379d57af0, #var_c2613e85d84857b:skill_bundle.var_e5b71c71413a6e94, #base_max_speed:skill_bundle.var_dd48f9b991f5732b, #var_1d14185e5468202d:skill_bundle.var_61db20a999482609, #search_range:skill_bundle.var_bb035c0551548452, #summon_time:skill_bundle.var_bb063e46d21339cf, #kill_time_window:skill_bundle.var_b13c6b8290c43a30, #cooldown:skill_bundle.wmodcooldown, #kills_required:skill_bundle.var_8c49731557408243, #scriptable:skill_bundle.wmodscriptable };
}

// Namespace skill_w_mod
// Params 1, eflags: 0x4
// Checksum 0xbc01e6e5, Offset: 0x3a3
// Size: 0xc2, Type: bool
function private on_give_skill( skill_bundle )
{
    override_vfx = level._effect[ #"hash_8efbce72bda25a2" ];
    assert( override_vfx, "<dev string:x87>" );
    assert( skill_bundle, "<dev string:xaa>" );
    self.var_c55a23d7402c588c = { #firstspawn:1, #var_38ab74b0227b60d6:[], #bundle:skill_bundle };
    self.var_3f4ab11e0fd7c0e6 = 0;
    self.var_d20938c9e42e667d = skill_bundle.var_3339ea1a6ce40378;
    self.var_f719974045aab983 = skill_bundle.var_abfe679e2bb4f63b;
    perk_w_mod::function_8266614527308805( override_vfx );
    perk_w_mod::function_bde7ad132a5210c7( override_vfx );
    perk_w_mod::function_8b4439e8e8b05190( override_vfx );
    return true;
}

// Namespace skill_w_mod
// Params 1, eflags: 0x4
// Checksum 0x5bae41d3, Offset: 0x46e
// Size: 0x1f5
function private on_enemy_killed( params )
{
    attacker = params.attacker ?? params.eattacker;
    var_da55798eb12048a0 = attacker.var_c55a23d7402c588c;
    
    if ( attacker.var_4fd5ac47a9bd8c18 || !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    current_time = gettime();
    var_da55798eb12048a0.var_38ab74b0227b60d6[ var_da55798eb12048a0.var_38ab74b0227b60d6.size ] = current_time;
    
    if ( bundle.var_ab4c1afe21ac069c )
    {
        var_d30e5c3d1ae57c0d = current_time - bundle.var_ab4c1afe21ac069c;
        var_d6c77036808a7aa = [];
        
        foreach ( timestamp in var_da55798eb12048a0.var_38ab74b0227b60d6 )
        {
            if ( timestamp >= var_d30e5c3d1ae57c0d )
            {
                var_d6c77036808a7aa[ var_d6c77036808a7aa.size ] = timestamp;
            }
        }
        
        var_da55798eb12048a0.var_38ab74b0227b60d6 = var_d6c77036808a7aa;
    }
    
    cooldown = bundle.var_30c61e6b937c0b98 ?? 0;
    var_70e604b5fe408dad = var_da55798eb12048a0.var_38ab74b0227b60d6.size >= bundle.var_8c49731557408243;
    is_off_cooldown = var_da55798eb12048a0.firstspawn || current_time >= attacker.var_3f4ab11e0fd7c0e6 + cooldown;
    
    if ( var_70e604b5fe408dad && is_off_cooldown )
    {
        attacker thread perk_w_mod::function_d46674d3b5d32438( bundle.var_5b2e4750bfb318c );
        var_da55798eb12048a0.var_38ab74b0227b60d6 = [];
        var_da55798eb12048a0.firstspawn = 0;
    }
}

// Namespace skill_w_mod
// Params 1, eflags: 0x4
// Checksum 0x791cec79, Offset: 0x66b
// Size: 0x5e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_ab824d5918dfb5a5" );
    
    if ( self.var_4fd5ac47a9bd8c18 )
    {
        self.var_4fd5ac47a9bd8c18 thread perk_w_mod::delete_wisp( self );
    }
    
    self.var_c55a23d7402c588c = undefined;
    self.var_3f4ab11e0fd7c0e6 = undefined;
    perk_w_mod::function_1c2aa29489437190();
    perk_w_mod::function_e9cfd9ce98cc289b();
    perk_w_mod::function_1ff2345cd091e1cc();
}

// Namespace skill_w_mod
// Params 1, eflags: 0x4
// Checksum 0x63ce5175, Offset: 0x6d1
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_59cbe83d8d3e430c ];
}

/#

    // Namespace skill_w_mod
    // Params 0, eflags: 0x4
    // Checksum 0x97a9965b, Offset: 0x6f6
    // Size: 0x63, Type: dev
    function private function_d195fa39d4938a85()
    {
        cheat_player = get_cheat_player();
        
        if ( !cheat_player.var_c55a23d7402c588c )
        {
            skill_bundle = level.skillbundles[ #"w_mod" ][ 0 ];
            cheat_player on_give_skill( skill_bundle );
            cheat_player thread perk_w_mod::function_d46674d3b5d32438( skill_bundle.var_5b2e4750bfb318c );
        }
    }

    // Namespace skill_w_mod
    // Params 0, eflags: 0x4
    // Checksum 0xb4e8c5a3, Offset: 0x761
    // Size: 0x4e, Type: dev
    function private function_778f38ddf231b5e0()
    {
        cheat_player = get_cheat_player();
        
        if ( cheat_player.var_c55a23d7402c588c )
        {
            skill_bundle = level.skillbundles[ #"w_mod" ][ 0 ];
            cheat_player function_c51f1692ecb73bfe( skill_bundle );
        }
    }

    // Namespace skill_w_mod
    // Params 0, eflags: 0x4
    // Checksum 0xce0d443d, Offset: 0x7b7
    // Size: 0xab, Type: dev
    function private get_cheat_player()
    {
        player_name_dvar = getdvar( @"cheat_player" );
        
        if ( player_name_dvar != "<dev string:xd0>" )
        {
            foreach ( player in level.players )
            {
                if ( player.name == player_name_dvar )
                {
                    return player;
                }
            }
        }
    }

#/
