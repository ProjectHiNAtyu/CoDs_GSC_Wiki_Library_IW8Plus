// scripts\mp\ob\skills\skill_equipment_pop.gsc  (hash_0dd956f3b206ecc5.gscc) (size: 4249 Bytes / 0x1099 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1cb3c15b (481542491)
// size ...... 4249 (0x1099)
// includes .. 5   (offset: 0x104d)
// strings ... 2   (offset: 0x1075)
// dev strs .. 1   (offset: 0x108d)
// exports ... 14  (offset: 0xa0d)
// cseg ...... 0x7a + 0x993 (0xa0d)
// imports ... 34  (offset: 0xc3d)
// animtree1 . 0   (offset: 0x1099)
// animtree2 . 0   (offset: 0x1099)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\supers;

#namespace skill_equipment_pop;

// Namespace skill_equipment_pop
// Params 0, eflags: 0x1
// Checksum 0x522c8791, Offset: 0x98
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"equipment_pop", &init );
}

// Namespace skill_equipment_pop
// Params 0
// Checksum 0x1ca02711, Offset: 0xb7
// Size: 0x88
function init()
{
    utility::registersharedfunc( #"equipment_pop", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"equipment_pop", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"equipment_pop", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_damaged", &function_e6d3aa1da950bd63 );
    level callback::add( #"on_ai_killed", &function_5c1cbf37de0d859c );
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x516492ed, Offset: 0x147
// Size: 0x95
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_62d1258ee9a7f587 )
    {
        skill_bundle.var_2c3acd5ab20ac37 = skill_bundle.var_62d1258ee9a7f587 * 1000;
    }
    
    if ( skill_bundle.var_7c8bbd1c44f89693 )
    {
        fx_asset = loadfxasset( skill_bundle.var_7c8bbd1c44f89693 );
        fx_id = "equipment_pop_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_1ef7771135ecdade = fx_id;
    }
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x99884f09, Offset: 0x1e4
// Size: 0xa5, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_da9e9ea52c3a20fc = { #var_827b6a0825d4e729:undefined, #var_f3d1266e5454bfe8:undefined, #var_1132b60cd0d9bf92:undefined, #bundle:skill_bundle };
    assert( !callback::exists( #"hash_b99dff90394eb45e", &function_e6d3aa1da950bd63 ) );
    assert( !callback::exists( #"sensor_grenade_watch_enemy", &function_e6d3aa1da950bd63 ) );
    callback::add( #"hash_b99dff90394eb45e", &function_e6d3aa1da950bd63 );
    callback::add( #"sensor_grenade_watch_enemy", &function_e6d3aa1da950bd63 );
    return true;
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x3a7887f7, Offset: 0x292
// Size: 0x78
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_da9e9ea52c3a20fc = undefined;
    assert( callback::exists( #"hash_b99dff90394eb45e", &function_e6d3aa1da950bd63 ) );
    assert( callback::exists( #"sensor_grenade_watch_enemy", &function_e6d3aa1da950bd63 ) );
    callback::remove( #"hash_b99dff90394eb45e", &function_e6d3aa1da950bd63 );
    callback::remove( #"sensor_grenade_watch_enemy", &function_e6d3aa1da950bd63 );
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x83a997ef, Offset: 0x312
// Size: 0x16
function private function_e6d3aa1da950bd63( params )
{
    return function_476907648f24b616( params, 1 );
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x74a77ba9, Offset: 0x331
// Size: 0x15
function private function_5c1cbf37de0d859c( params )
{
    return function_476907648f24b616( params, 0 );
}

// Namespace skill_equipment_pop
// Params 2, eflags: 0x4
// Checksum 0x501b7ed1, Offset: 0x34f
// Size: 0x32a
function private function_476907648f24b616( params, var_40d49da6a16c69ad )
{
    victim = params.victim ?? self;
    original_attacker = params.attacker ?? params.eattacker;
    attacker = original_attacker.owner ?? original_attacker;
    weapon = params.objweapon ?? params.sweapon;
    inflictor = params.einflictor ?? params.inflictor;
    var_da55798eb12048a0 = attacker.var_da9e9ea52c3a20fc;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( victim function_731392e441f8fd56( original_attacker, attacker, weapon, var_40d49da6a16c69ad, inflictor, var_da55798eb12048a0, bundle ) )
    {
        var_7bf66648a3f62aa9 = { #var_3b55b60765b98d29:[], #weights_table:bundle.var_c6fe186ad8aa3e66, #objweapon:params.objweapon, #partname:params.partname, #modelindex:params.modelindex, #timeoffset:params.timeoffset, #shitloc:params.shitloc, #vdir:params.vdir, #vpoint:params.vpoint, #idflags:params.idflags, #idamage:params.idamage, #inflictor:attacker, #probability:bundle.var_26c0fd7eff8da3a8, #player:attacker };
        
        if ( bundle.var_ef8ca4c7d696075b )
        {
            var_c04e417f8531bdb5 = bundle.var_ef8ca4c7d696075b;
            
            if ( var_c04e417f8531bdb5 >= 1 )
            {
                var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 1;
            }
            
            if ( var_c04e417f8531bdb5 >= 2 )
            {
                var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 2;
            }
            
            if ( var_c04e417f8531bdb5 >= 3 )
            {
                var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 3;
            }
        }
        
        assert( var_7bf66648a3f62aa9.var_3b55b60765b98d29.size > 0, "<dev string:x24>" );
        
        if ( utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
        {
            result = victim utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", var_7bf66648a3f62aa9 );
            
            if ( result )
            {
                effect_id = utility::getfx( bundle.var_1ef7771135ecdade );
                
                if ( !effect_id )
                {
                    return;
                }
                
                playfxontag( effect_id, attacker, "j_spine4" );
                attacker function_b01a7648f257a5ef( var_da55798eb12048a0, inflictor );
            }
        }
    }
    
    return params.idamage;
}

// Namespace skill_equipment_pop
// Params 3, eflags: 0x4
// Checksum 0x5694fe86, Offset: 0x682
// Size: 0x76, Type: bool
function private function_17dc33a346056044( var_da55798eb12048a0, bundle, inflictor )
{
    if ( !inflictor || !bundle.var_d860eea14b9a1ee5 || !var_da55798eb12048a0.var_1132b60cd0d9bf92[ inflictor.birthtime ] )
    {
        return true;
    }
    
    return var_da55798eb12048a0.var_1132b60cd0d9bf92[ inflictor.birthtime ] < bundle.var_d860eea14b9a1ee5;
}

// Namespace skill_equipment_pop
// Params 1, eflags: 0x4
// Checksum 0x93d87eeb, Offset: 0x701
// Size: 0xf5
function private function_6d5dfde0e8a91d01( var_da55798eb12048a0 )
{
    now_ms = gettime();
    
    if ( !var_da55798eb12048a0.var_1132b60cd0d9bf92.size || var_da55798eb12048a0.var_f3d1266e5454bfe8 && now_ms - var_da55798eb12048a0.var_f3d1266e5454bfe8 < 60000 )
    {
        return;
    }
    
    foreach ( birthtime_ms, _ in var_da55798eb12048a0.var_1132b60cd0d9bf92 )
    {
        lifetime_ms = now_ms - birthtime_ms;
        
        if ( lifetime_ms >= 60000 )
        {
            var_da55798eb12048a0.var_1132b60cd0d9bf92[ birthtime_ms ] = undefined;
        }
    }
    
    var_da55798eb12048a0.var_f3d1266e5454bfe8 = now_ms;
}

// Namespace skill_equipment_pop
// Params 2, eflags: 0x4
// Checksum 0xf754e18e, Offset: 0x7fe
// Size: 0x95
function private function_b01a7648f257a5ef( var_da55798eb12048a0, inflictor )
{
    function_6d5dfde0e8a91d01( var_da55798eb12048a0 );
    
    if ( !inflictor || isplayer( inflictor ) )
    {
        return;
    }
    
    if ( !isdefined( var_da55798eb12048a0.var_1132b60cd0d9bf92 ) )
    {
        var_da55798eb12048a0.var_1132b60cd0d9bf92 = [];
    }
    
    if ( !isdefined( var_da55798eb12048a0.var_1132b60cd0d9bf92[ inflictor.birthtime ] ) )
    {
        var_da55798eb12048a0.var_1132b60cd0d9bf92[ inflictor.birthtime ] = 0;
    }
    
    var_da55798eb12048a0.var_1132b60cd0d9bf92[ inflictor.birthtime ]++;
}

// Namespace skill_equipment_pop
// Params 2, eflags: 0x4
// Checksum 0xb08aa32d, Offset: 0x89b
// Size: 0x5e, Type: bool
function private function_ef01d966d84d672b( var_da55798eb12048a0, bundle )
{
    cooldown_ms = bundle.var_2c3acd5ab20ac37 ?? 0;
    last_timestamp = var_da55798eb12048a0.var_827b6a0825d4e729;
    
    if ( !cooldown_ms || !last_timestamp )
    {
        return false;
    }
    
    return gettime() - last_timestamp < cooldown_ms;
}

// Namespace skill_equipment_pop
// Params 7, eflags: 0x4
// Checksum 0x4444a6c0, Offset: 0x902
// Size: 0x10a, Type: bool
function private function_731392e441f8fd56( original_attacker, attacker, weapon, var_40d49da6a16c69ad, inflictor, var_da55798eb12048a0, bundle )
{
    if ( !var_da55798eb12048a0 || !isalive( attacker ) || !isagent( self ) )
    {
        return false;
    }
    
    if ( self.kfe_ignore )
    {
        return false;
    }
    
    if ( var_40d49da6a16c69ad && !isalive( self ) )
    {
        return false;
    }
    
    if ( !original_attacker.isequipment && !weapon::isweaponequipment( weapon ) )
    {
        return false;
    }
    
    if ( supers_mp::getsuperrefforsuperweapon( weapon ) )
    {
        return false;
    }
    
    if ( utility::callsharedfunc( #"skill", #"hash_51e6fd623b95a9a9", weapon, bundle.var_4113c7e6aaa938aa ?? [] ) )
    {
        return false;
    }
    
    if ( !attacker function_17dc33a346056044( var_da55798eb12048a0, bundle, inflictor ) )
    {
        return false;
    }
    
    if ( attacker function_ef01d966d84d672b( var_da55798eb12048a0, bundle ) )
    {
        return false;
    }
    
    var_da55798eb12048a0.var_827b6a0825d4e729 = gettime();
    return true;
}

