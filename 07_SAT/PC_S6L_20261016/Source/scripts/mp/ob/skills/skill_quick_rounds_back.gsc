// scripts\mp\ob\skills\skill_quick_rounds_back.gsc  (hash_1d6780dc9a6d24b4.gscc) (size: 2561 Bytes / 0xa01 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c1643ee (2350269422)
// size ...... 2561 (0xa01)
// includes .. 5   (offset: 0x9d9)
// strings ... 0   (offset: 0xa01)
// dev strs .. 0   (offset: 0xa01)
// exports ... 11  (offset: 0x53d)
// cseg ...... 0x58 + 0x4e5 (0x53d)
// imports ... 26  (offset: 0x6f5)
// animtree1 . 0   (offset: 0xa01)
// animtree2 . 0   (offset: 0xa01)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon_utility;

#namespace skill_quick_rounds_back;

// Namespace skill_quick_rounds_back
// Params 0, eflags: 0x1
// Checksum 0xea689c12, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"quick_rounds_back", &init );
}

// Namespace skill_quick_rounds_back
// Params 0
// Checksum 0x9f941d3d, Offset: 0x95
// Size: 0x68
function init()
{
    utility::registersharedfunc( #"quick_rounds_back", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"quick_rounds_back", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    callback::add( #"on_ai_killed", &on_enemy_killed );
    callback::add( #"player_death", &on_enemy_killed );
}

// Namespace skill_quick_rounds_back
// Params 1, eflags: 0x4
// Checksum 0x2eef543b, Offset: 0x105
// Size: 0x2d, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_6a53e73c69aa08cc = { #var_771bfe6acfb7ecf2:[], #bundle:skill_bundle };
    return true;
}

// Namespace skill_quick_rounds_back
// Params 1, eflags: 0x4
// Checksum 0xa3bad356, Offset: 0x13b
// Size: 0x1cd
function private on_enemy_killed( params )
{
    current_weapon = params.sweapon ?? params.objweapon;
    
    if ( !isweapon( current_weapon ) )
    {
        return;
    }
    
    attacker = params.attacker ?? params.eattacker;
    attacker_skill_data = attacker.var_6a53e73c69aa08cc;
    
    if ( !attacker_skill_data )
    {
        return;
    }
    
    attacker_bundle = attacker_skill_data.bundle;
    
    if ( attacker_bundle.var_c1b5896ab0230f04 && function_3570a8eeb582562c( attacker, current_weapon ) )
    {
        current_time = gettime();
        duration = attacker_bundle.var_c1b5896ab0230f04;
        attacker function_ca2e5f490ad5fa48( attacker_skill_data, current_time, duration );
        attacker function_c563a32a0faeb144( attacker_skill_data, current_time );
        
        if ( attacker function_15d936e87b8255bd( attacker_skill_data, attacker_bundle ) )
        {
            random_max = attacker_bundle.var_d6ad21af0a77e4c8;
            random_value = randomint( 100 );
            
            if ( random_value < random_max )
            {
                var_58da65984ec56b0a = attacker_bundle.var_57579505fd474827;
                var_b22e3b73bc8da820 = var_58da65984ec56b0a && function_7b564354201b30ca( current_weapon );
                
                if ( var_b22e3b73bc8da820 )
                {
                    current_ammo = attacker getweaponammoclip( current_weapon );
                }
                else
                {
                    current_ammo = attacker getweaponammostock( current_weapon );
                }
                
                gift_amount = attacker_bundle.var_1e810d31eabcd9d2;
                final_ammo = current_ammo + gift_amount;
                
                if ( var_b22e3b73bc8da820 )
                {
                    attacker setweaponammoclip( current_weapon, final_ammo );
                }
                else
                {
                    attacker setweaponammostock( current_weapon, final_ammo, 1 );
                }
                
                if ( attacker_bundle.var_ad379bd56878cf4d )
                {
                    attacker playlocalsound( attacker_bundle.var_ad379bd56878cf4d );
                }
            }
        }
    }
}

// Namespace skill_quick_rounds_back
// Params 1, eflags: 0x4
// Checksum 0xb00889ec, Offset: 0x310
// Size: 0x41, Type: bool
function private function_7b564354201b30ca( weapon )
{
    isprojectile = weapon_utility::function_186e07887b6bbeb1( weapon );
    isknife = weapon_utility::isknifeonly( weapon );
    
    if ( isprojectile && isknife )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_quick_rounds_back
// Params 2, eflags: 0x4
// Checksum 0x6e23bf18, Offset: 0x35a
// Size: 0x7a
function private function_3570a8eeb582562c( eattacker, current_weapon )
{
    var_986e11544cc674e6 = weapon::iskillstreakweapon( current_weapon );
    is_grenade_weapon = weapon_utility::isgrenadeweapon( current_weapon );
    is_same_weapon = eattacker getcurrentweapon() == current_weapon;
    var_5418253ed5dabd77 = !current_weapon.reloaddisabled && !var_986e11544cc674e6 && !is_grenade_weapon && is_same_weapon;
    return var_5418253ed5dabd77;
}

// Namespace skill_quick_rounds_back
// Params 3, eflags: 0x4
// Checksum 0x6c5c0893, Offset: 0x3dd
// Size: 0xc6
function private function_ca2e5f490ad5fa48( var_da55798eb12048a0, current_time, max_live )
{
    var_7e4a8fa5e67bd230 = var_da55798eb12048a0.var_771bfe6acfb7ecf2;
    future_list = [];
    
    foreach ( time in var_7e4a8fa5e67bd230 )
    {
        if ( time + max_live > current_time )
        {
            future_list[ future_list.size ] = time;
        }
    }
    
    var_da55798eb12048a0.var_771bfe6acfb7ecf2 = future_list;
}

// Namespace skill_quick_rounds_back
// Params 2, eflags: 0x4
// Checksum 0x1c6f4ec2, Offset: 0x4ab
// Size: 0x30
function private function_c563a32a0faeb144( var_da55798eb12048a0, current_time )
{
    var_da55798eb12048a0.var_771bfe6acfb7ecf2[ var_da55798eb12048a0.var_771bfe6acfb7ecf2.size ] = current_time;
}

// Namespace skill_quick_rounds_back
// Params 2, eflags: 0x4
// Checksum 0x8c9ef9e3, Offset: 0x4e3
// Size: 0x3b, Type: bool
function private function_15d936e87b8255bd( var_da55798eb12048a0, bundle )
{
    min_kills = bundle.var_ca61406eeba8ca76;
    return var_da55798eb12048a0.var_771bfe6acfb7ecf2.size >= min_kills;
}

// Namespace skill_quick_rounds_back
// Params 1, eflags: 0x4
// Checksum 0x8d1f9cc0, Offset: 0x527
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_6a53e73c69aa08cc = undefined;
}

