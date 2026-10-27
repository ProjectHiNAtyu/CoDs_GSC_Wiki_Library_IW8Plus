// script_5e22634c4be68808  (hash_5e22634c4be68808.gscc) (size: 3778 Bytes / 0xec2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39ec96d6 (971806422)
// size ...... 3778 (0xec2)
// includes .. 7   (offset: 0xe06)
// strings ... 5   (offset: 0xe3e)
// dev strs .. 6   (offset: 0xe7a)
// exports ... 13  (offset: 0x7d2)
// cseg ...... 0xc0 + 0x712 (0x7d2)
// imports ... 36  (offset: 0x9da)
// animtree1 . 0   (offset: 0xec2)
// animtree2 . 0   (offset: 0xec2)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\ob\systems\ob_stun;
#using scripts\mp\supers;

#namespace skill_annihilator_upgrade;

// Namespace skill_annihilator_upgrade
// Params 0, eflags: 0x1
// Checksum 0xc495ef5a, Offset: 0xde
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"annihilator_upgrade", &init );
}

// Namespace skill_annihilator_upgrade
// Params 0
// Checksum 0x2819c37, Offset: 0xfd
// Size: 0x9e
function init()
{
    utility::registersharedfunc( #"annihilator_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"annihilator_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"annihilator_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"player_damaged", &function_b3ef44fd26e51c0d );
    level callback::add( #"on_ai_killed", &function_169d1ccb4f276163 );
    level callback::add( #"player_death", &function_169d1ccb4f276163 );
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0x88f963c5, Offset: 0x1a3
// Size: 0x95
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_2ee51a5b1d102bdb )
    {
        skill_bundle.var_90684a23daf8fec3 = skill_bundle.var_2ee51a5b1d102bdb * 1000;
    }
    
    if ( skill_bundle.var_9d79b175a3c0bb6a )
    {
        fx_asset = loadfxasset( skill_bundle.var_9d79b175a3c0bb6a );
        fx_id = "annihilator_upgrade_explosion_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_6f3be7bd423f5167 = fx_id;
    }
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc05b2d86, Offset: 0x240
// Size: 0x100, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_86f8b37b9481f87 )
        {
            assert( skill_bundle.var_6095f1e88ab67854, "<dev string:x24>" );
            assert( skill_bundle.var_4cd90f98113d9a32, "<dev string:x86>" );
            assert( skill_bundle.var_812b66c2d3accb48, "<dev string:xe2>" );
            assert( skill_bundle.var_9f090130da58c5c7, "<dev string:x13e>" );
            assert( skill_bundle.var_97c390b3228ae47e, "<dev string:x19a>" );
            assert( skill_bundle.var_731d38758520636d, "<dev string:x1fc>" );
        }
    #/
    
    self.var_6a3b654082f6d347 = { #explosioncooldown:undefined, #bundle:skill_bundle };
    assert( !callback::exists( #"hash_2f7a081cd065e655", &function_b3ef44fd26e51c0d ) );
    callback::add( #"hash_2f7a081cd065e655", &function_b3ef44fd26e51c0d );
    return true;
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0xd9d0ec6d, Offset: 0x349
// Size: 0x47
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"hash_2f7a081cd065e655", &function_b3ef44fd26e51c0d ) );
    callback::remove( #"hash_2f7a081cd065e655", &function_b3ef44fd26e51c0d );
    self.var_6a3b654082f6d347 = undefined;
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0x8d6b91e7, Offset: 0x398
// Size: 0x44
function private function_169d1ccb4f276163( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( !attacker )
    {
        return;
    }
    
    attacker process_shot( self, params );
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0x14e328c8, Offset: 0x3e4
// Size: 0x38
function private function_b3ef44fd26e51c0d( params )
{
    victim = params.victim;
    
    if ( !isalive( victim ) )
    {
        return;
    }
    
    process_shot( victim, params );
}

// Namespace skill_annihilator_upgrade
// Params 2, eflags: 0x4
// Checksum 0x45a18488, Offset: 0x424
// Size: 0xb8
function private process_shot( victim, params )
{
    var_da55798eb12048a0 = self.var_6a3b654082f6d347;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !bundle.var_86f8b37b9481f87 )
    {
        return;
    }
    
    curr_time = bundle.var_90684a23daf8fec3 ? gettime() : undefined;
    weapon = params.sweapon ?? params.objweapon;
    
    if ( !function_67031c518c0d83d2( var_da55798eb12048a0, bundle, victim, weapon, curr_time ) )
    {
        return;
    }
    
    perform_explosion( var_da55798eb12048a0, bundle, victim, curr_time );
}

// Namespace skill_annihilator_upgrade
// Params 5, eflags: 0x4
// Checksum 0x2414c39a, Offset: 0x4e4
// Size: 0x84, Type: bool
function private function_67031c518c0d83d2( var_da55798eb12048a0, bundle, victim, weapon, curr_time )
{
    if ( var_da55798eb12048a0.explosioncooldown > curr_time )
    {
        return false;
    }
    
    if ( !function_a9bdbbc229bf8075( bundle, weapon ) )
    {
        return false;
    }
    
    if ( !victim function_8ef697ddcfb5f2ec( bundle.var_6095f1e88ab67854 ) )
    {
        return false;
    }
    
    if ( !utility::percent_chance( bundle.var_4cd90f98113d9a32 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_annihilator_upgrade
// Params 1, eflags: 0x4
// Checksum 0x1ff9e8d3, Offset: 0x571
// Size: 0x41, Type: bool
function private function_8ef697ddcfb5f2ec( ai_max_tier )
{
    if ( !isdefined( ai_max_tier ) )
    {
        return true;
    }
    
    if ( self.classname == "player" )
    {
        return true;
    }
    
    tiernumber = ai_utility::get_power_tier();
    return ai_max_tier >= tiernumber;
}

// Namespace skill_annihilator_upgrade
// Params 2, eflags: 0x4
// Checksum 0xc693cf58, Offset: 0x5bb
// Size: 0x44
function private function_a9bdbbc229bf8075( bundle, weapon )
{
    super_ref = supers_mp::getsuperrefforsuperweapon( weapon );
    return super_ref ? getxhash( super_ref ) == bundle.abilityref : 0;
}

// Namespace skill_annihilator_upgrade
// Params 4, eflags: 0x4
// Checksum 0x827ea3b2, Offset: 0x608
// Size: 0x1ca
function private perform_explosion( var_da55798eb12048a0, bundle, victim, curr_time )
{
    if ( curr_time )
    {
        var_da55798eb12048a0.explosioncooldown = curr_time + bundle.var_90684a23daf8fec3;
    }
    
    var_d0a9d177707a4448 = victim.origin;
    playfx( utility::getfx( bundle.var_6f3be7bd423f5167 ), var_d0a9d177707a4448 );
    playsoundatpos( var_d0a9d177707a4448, bundle.var_731d38758520636d );
    possible_enemies = utility::function_f754506ecfae9afb( var_d0a9d177707a4448, bundle.var_812b66c2d3accb48, undefined, 100, 0 );
    damaged_enemies = [];
    
    foreach ( enemy in possible_enemies )
    {
        if ( !player_utility::playersareenemies( self, enemy ) || enemy.teamshifted )
        {
            continue;
        }
        
        damaged_enemies[ damaged_enemies.size ] = enemy;
        enemy dodamage( bundle.var_9f090130da58c5c7, var_d0a9d177707a4448, self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>", "torso_upper" );
    }
    
    stun_data = { #stunorigin:var_d0a9d177707a4448, #var_c27a2418f1d8f32d:1, #aistunduration:bundle.var_97c390b3228ae47e, #playersstunduration:bundle.var_97c390b3228ae47e, #source:#"annihilator_upgrade" };
    thread ob_stun::function_336faa60d5212254( stun_data, damaged_enemies );
}

