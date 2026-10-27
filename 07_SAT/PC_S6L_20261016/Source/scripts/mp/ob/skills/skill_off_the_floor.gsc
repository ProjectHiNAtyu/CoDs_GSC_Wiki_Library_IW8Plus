// scripts\mp\ob\skills\skill_off_the_floor.gsc  (hash_339359e34f4cecc5.gscc) (size: 3018 Bytes / 0xbca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b2b9719 (724277017)
// size ...... 3018 (0xbca)
// includes .. 4   (offset: 0xb6a)
// strings ... 5   (offset: 0xb8a)
// dev strs .. 0   (offset: 0xbca)
// exports ... 13  (offset: 0x626)
// cseg ...... 0xc3 + 0x563 (0x626)
// imports ... 26  (offset: 0x82e)
// animtree1 . 0   (offset: 0xbca)
// animtree2 . 0   (offset: 0xbca)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\laststand;

#namespace skill_off_the_floor;

// Namespace skill_off_the_floor
// Params 0, eflags: 0x1
// Checksum 0x844d56e1, Offset: 0xe1
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"off_the_floor", &init );
}

// Namespace skill_off_the_floor
// Params 0
// Checksum 0x66659b8a, Offset: 0x100
// Size: 0x98
function init()
{
    utility::registersharedfunc( #"off_the_floor", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"off_the_floor", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"off_the_floor", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    callback::add( #"on_ai_killed", &on_enemy_killed );
    callback::add( #"player_death", &on_enemy_killed );
    level callback::add( "on_turned", &function_5c7fbb8348a0dae8 );
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x3f96464b, Offset: 0x1a0
// Size: 0x35
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_f88792822b66dfd1 )
    {
        skill_bundle.var_e84c6fbc71700d65 = skill_bundle.var_f88792822b66dfd1 * 1000;
    }
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0xfc2999d2, Offset: 0x1dd
// Size: 0x91, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( !callback::exists( #"player_laststand_revived", &function_b0f8cce4da821455 ) );
    assert( !callback::exists( #"player_laststand", &function_b1a70274e9508a18 ) );
    callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::add( #"player_laststand", &function_b1a70274e9508a18 );
    self.var_f7ba809236b4e633 = { #currentcooldown:undefined, #bundle:skill_bundle };
    return true;
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x907c820e, Offset: 0x277
// Size: 0x39
function private on_enemy_killed( params )
{
    owner = function_3bbf335229c110a7( params );
    
    if ( !owner.var_f7ba809236b4e633 )
    {
        return;
    }
    
    owner function_8650bbd7e3299518();
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x66b93279, Offset: 0x2b8
// Size: 0x76
function private function_3bbf335229c110a7( params )
{
    attacker = params.attacker ?? params.eattacker;
    inflictor = params.inflictor ?? params.einflictor;
    owner = get_owner_from_entity( attacker );
    
    if ( owner )
    {
        return owner;
    }
    
    return get_owner_from_entity( inflictor );
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0xc9aa291f, Offset: 0x337
// Size: 0x79
function private get_owner_from_entity( entity )
{
    if ( !entity )
    {
        return;
    }
    
    if ( isplayer( entity ) )
    {
        return entity;
    }
    
    if ( isplayer( entity.var_bd22ba6c600a23a3 ) )
    {
        return entity.var_bd22ba6c600a23a3;
    }
    
    if ( isplayer( entity.var_fb2e0070ae6f04e4 ) )
    {
        return entity.var_fb2e0070ae6f04e4;
    }
    
    if ( isplayer( entity.owner ) )
    {
        return entity.owner;
    }
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x698cd150, Offset: 0x3b9
// Size: 0x38
function private function_5c7fbb8348a0dae8( params )
{
    owner = get_owner_from_entity( self );
    
    if ( !owner.var_f7ba809236b4e633 )
    {
        return;
    }
    
    owner function_8650bbd7e3299518();
}

// Namespace skill_off_the_floor
// Params 0, eflags: 0x4
// Checksum 0x622e6fd0, Offset: 0x3f9
// Size: 0xca
function private function_8650bbd7e3299518()
{
    var_da55798eb12048a0 = self.var_f7ba809236b4e633;
    bundle = var_da55798eb12048a0.bundle;
    curr_time = gettime();
    is_in_cooldown = var_da55798eb12048a0.currentcooldown && curr_time < var_da55798eb12048a0.currentcooldown;
    can_use = self.inlaststand && !is_in_cooldown;
    
    if ( can_use )
    {
        if ( bundle.var_e84c6fbc71700d65 )
        {
            var_da55798eb12048a0.currentcooldown = curr_time + bundle.var_e84c6fbc71700d65;
        }
        
        laststand::exit( "last_stand_revived_skill_off_the_floor", self );
        utility::function_7c10ea82c1e305b8( #"off_the_floor_fx", "on_skill_activation" );
    }
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0xf09f33d, Offset: 0x4cb
// Size: 0x97
function private function_b1a70274e9508a18( params )
{
    self endon( #"last_stand_exit", #"death_or_disconnect" );
    var_da55798eb12048a0 = self.var_f7ba809236b4e633;
    
    while ( true )
    {
        curr_time = gettime();
        is_in_cooldown = var_da55798eb12048a0.currentcooldown && curr_time < var_da55798eb12048a0.currentcooldown;
        
        if ( !is_in_cooldown )
        {
            utility::function_7c10ea82c1e305b8( #"off_the_floor_fx", "on_enter_laststand" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x298ad38d, Offset: 0x56a
// Size: 0x8d
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"player_laststand_revived", &function_b0f8cce4da821455 ) );
    assert( callback::exists( #"player_laststand", &function_b1a70274e9508a18 ) );
    callback::remove( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::remove( #"player_laststand", &function_b1a70274e9508a18 );
    utility::function_32b24db3127bff40( #"off_the_floor_fx", "off" );
    self.var_f7ba809236b4e633 = undefined;
}

// Namespace skill_off_the_floor
// Params 1, eflags: 0x4
// Checksum 0x7cb4d7c5, Offset: 0x5ff
// Size: 0x27
function private function_b0f8cce4da821455( params )
{
    wait 0.5;
    utility::function_32b24db3127bff40( #"off_the_floor_fx", "off" );
}

