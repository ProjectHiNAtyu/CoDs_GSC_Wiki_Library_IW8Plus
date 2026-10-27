// scripts\mp\ob\skills\skill_last_resort.gsc  (hash_2a44d0bce9567749.gscc) (size: 6118 Bytes / 0x17e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7fdc065a (2145125978)
// size ...... 6118 (0x17e6)
// includes .. 8   (offset: 0x169e)
// strings ... 8   (offset: 0x16de)
// dev strs .. 14  (offset: 0x173e)
// exports ... 18  (offset: 0xdea)
// cseg ...... 0xea + 0xd00 (0xdea)
// imports ... 50  (offset: 0x10ba)
// animtree1 . 0   (offset: 0x17e6)
// animtree2 . 0   (offset: 0x17e6)
#using script_2fe74ee229c972c3;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;

#namespace skill_last_resort;

// Namespace skill_last_resort
// Params 0, eflags: 0x1
// Checksum 0x3e499e6a, Offset: 0x108
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"last_resort", &init );
}

// Namespace skill_last_resort
// Params 0
// Checksum 0x7f2648f4, Offset: 0x127
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"last_resort", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"last_resort", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"last_resort", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"last_resort", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0x62634d44, Offset: 0x1a9
// Size: 0x115
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_8a3ebf1316f9fdba && skill_bundle.var_d66b89c5fc670d3c )
    {
        fx_asset = loadfxasset( skill_bundle.var_8a3ebf1316f9fdba );
        var_994e57629d8f02df = "last_resort_principal_vfx_" + skill_bundle.skilllevel;
        level._effect[ var_994e57629d8f02df ] = fx_asset;
        fx_asset = loadfxasset( skill_bundle.var_d66b89c5fc670d3c );
        var_c9ac32d253744ab5 = "last_resort_remote_vfx_" + skill_bundle.skilllevel;
        level._effect[ var_c9ac32d253744ab5 ] = fx_asset;
        skill_bundle.var_2681612b9f84e4b7 = var_994e57629d8f02df;
        skill_bundle.var_a81ffd4fc6f954b1 = var_c9ac32d253744ab5;
    }
    
    if ( skill_bundle.lastresortcooldown )
    {
        skill_bundle.var_f5d74431dd8ed4da = skill_bundle.lastresortcooldown * 1000;
    }
    
    if ( skill_bundle.var_f08486444734ee18 )
    {
        skill_bundle.var_495d859af27fb969 = squared( skill_bundle.var_f08486444734ee18 );
    }
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0x15517bdb, Offset: 0x2c6
// Size: 0x1fa, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( !callback::exists( #"player_damaged", &on_player_damaged ) );
    callback::add( #"player_damaged", &on_player_damaged );
    
    if ( !level._effect[ skill_bundle.var_2681612b9f84e4b7 ] || !level._effect[ skill_bundle.var_a81ffd4fc6f954b1 ] )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    assert( skill_bundle.var_f5d74431dd8ed4da, "<dev string:x47>" );
    assert( skill_bundle.var_f81f6c9c2eedaed4, "<dev string:x71>" );
    assert( skill_bundle.var_22dfa091ee9af79, "<dev string:xa3>" );
    assert( skill_bundle.var_261babe11e76f6c7, "<dev string:xd8>" );
    assert( skill_bundle.var_838dd405babcab19, "<dev string:x10e>" );
    assert( skill_bundle.var_940e59dceaf5dca, "<dev string:x151>" );
    assert( skill_bundle.var_495d859af27fb969, "<dev string:x193>" );
    assert( skill_bundle.var_5fe24612f859a5bd, "<dev string:x1cf>" );
    assert( skill_bundle.var_c285bce17969b40f, "<dev string:x208>" );
    assert( skill_bundle.var_abad5540a4e92244, "<dev string:x248>" );
    assert( skill_bundle.var_ef84926d8ac93c46, "<dev string:x287>" );
    assert( skill_bundle.var_ac0f10c5ddc6b53f, "<dev string:x2c0>" );
    self.var_6f4acb3147fe644e = { #var_1324388ce5393121:0, #var_db2621b9f36e19b8:0, #bundle:skill_bundle };
    
    if ( skill_bundle.var_1d802e38ff2c7fa9 )
    {
        thread function_32957c36fd2c0150( self.var_6f4acb3147fe644e, self.var_6f4acb3147fe644e.bundle );
    }
    
    return true;
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0xc059447, Offset: 0x4c9
// Size: 0x53
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"player_damaged", &on_player_damaged ) );
    callback::remove( #"player_damaged", &on_player_damaged );
    self.var_6f4acb3147fe644e = undefined;
    self notify( #"hash_a58775c9caf69f67" );
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x95181253, Offset: 0x524
// Size: 0x14a
function private function_32957c36fd2c0150( var_da55798eb12048a0, bundle )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a58775c9caf69f67" );
    
    while ( true )
    {
        if ( !var_da55798eb12048a0.var_db2621b9f36e19b8 && is_cooldown_complete( var_da55798eb12048a0, bundle ) )
        {
            var_da55798eb12048a0.var_db2621b9f36e19b8 = 1;
            
            if ( bundle.var_db18a1a4de937b40 )
            {
                playsoundatpos( self.origin, bundle.var_db18a1a4de937b40 );
            }
            
            if ( bundle.var_171183af47576aca && bundle.var_a23d3211566865e1 )
            {
                self setscriptablepartstate( bundle.var_171183af47576aca, bundle.var_a23d3211566865e1, 0 );
            }
            
            if ( bundle.var_42331e5bcf393b0a )
            {
                pbgpostfxbundlestart( self, bundle.var_42331e5bcf393b0a );
            }
            
            wait bundle.var_1d802e38ff2c7fa9;
            
            if ( bundle.var_171183af47576aca && bundle.var_81586f5d569bf9dd )
            {
                self setscriptablepartstate( bundle.var_171183af47576aca, bundle.var_81586f5d569bf9dd, 0 );
            }
            
            if ( bundle.var_42331e5bcf393b0a )
            {
                pbgpostfxbundleend( self, bundle.var_42331e5bcf393b0a );
            }
        }
        
        wait 0.1;
    }
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x43ddead9, Offset: 0x676
// Size: 0x40, Type: bool
function private is_cooldown_complete( var_da55798eb12048a0, bundle )
{
    return var_da55798eb12048a0.var_1324388ce5393121 && gettime() - var_da55798eb12048a0.var_1324388ce5393121 >= bundle.var_f5d74431dd8ed4da;
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0x8e98e149, Offset: 0x6bf
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_461d79e703a5521 ];
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0x97445c86, Offset: 0x6e4
// Size: 0x1a2
function private on_player_damaged( params )
{
    var_da55798eb12048a0 = self.var_6f4acb3147fe644e;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    health_percent_activation = bundle.var_f81f6c9c2eedaed4;
    health_threshold = self.maxhealth * health_percent_activation;
    
    if ( self.health <= health_threshold )
    {
        if ( !var_da55798eb12048a0.var_1324388ce5393121 || gettime() - var_da55798eb12048a0.var_1324388ce5393121 >= bundle.var_f5d74431dd8ed4da )
        {
            if ( bundle.var_461d79e703a5521 )
            {
                thread utility::function_72b6372d2d8c997( bundle.var_461d79e703a5521, 1 );
            }
            
            thread do_explosions( var_da55798eb12048a0, bundle );
            thread apply_ignore_me( bundle );
            
            if ( bundle.var_19b9f7255308e875 > 0 )
            {
                invulnerability_data = { #duration:bundle.var_19b9f7255308e875, #pbg_post_fx:bundle.var_ec234ac163ae3b70, #scriptable_state_off:bundle.var_91b5c30bc3521eb3, #scriptable_state_on:bundle.var_e342b45db0c5e04f, #scriptable_part:bundle.var_2e0b93f742c03a54, #id:"last_resort_immunity" };
                thread utility::callsharedfunc( #"skills", #"apply_invulnerability", invulnerability_data );
            }
            
            thread function_2d2e7bf4eb808ce7( bundle );
            function_1b890692cb82d22( bundle );
            var_da55798eb12048a0.var_db2621b9f36e19b8 = 0;
        }
    }
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0xbf5f5687, Offset: 0x88e
// Size: 0x55
function private apply_ignore_me( bundle )
{
    self endon( #"death_or_disconnect" );
    ai::contribute_ignoreme( #"last_resort", 1 );
    
    if ( bundle.var_2646095f3cbce551 )
    {
        wait bundle.var_2646095f3cbce551;
    }
    
    ai::contribute_ignoreme( #"last_resort", 0 );
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0x38db354e, Offset: 0x8eb
// Size: 0x5f
function private function_1b890692cb82d22( bundle )
{
    health_regen_amount = self.maxhealth * bundle.var_261babe11e76f6c7;
    new_health = int( self.health + health_regen_amount );
    self.health = minint( new_health, self.maxhealth );
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x26a72185, Offset: 0x952
// Size: 0x173
function private do_explosions( var_da55798eb12048a0, bundle )
{
    self endon( #"death_or_disconnect" );
    enemies_in_range = function_d51b4d2bee3ead3b( bundle.var_ef84926d8ac93c46, bundle );
    var_da55798eb12048a0.var_1324388ce5393121 = gettime();
    function_b72d46af97dea9b3( bundle.var_2681612b9f84e4b7, bundle.var_5fe24612f859a5bd );
    
    if ( !enemies_in_range.size )
    {
        return;
    }
    
    foreach ( enemy in enemies_in_range )
    {
        distance = distancesquared( self.origin, enemy.origin );
        
        if ( distance <= bundle.var_495d859af27fb969 )
        {
            function_38564ed5f2c68089( enemy, bundle.var_838dd405babcab19, bundle.var_940e59dceaf5dca, bundle );
            continue;
        }
        
        enemy function_b72d46af97dea9b3( bundle.var_a81ffd4fc6f954b1, bundle.var_ac0f10c5ddc6b53f );
        function_38564ed5f2c68089( enemy, bundle.var_c285bce17969b40f, bundle.var_abad5540a4e92244, bundle );
    }
}

// Namespace skill_last_resort
// Params 4, eflags: 0x4
// Checksum 0x7e7ed222, Offset: 0xacd
// Size: 0x10c
function private function_38564ed5f2c68089( enemy, zombie_damage, human_damage, bundle )
{
    damage = 0;
    
    if ( enemy.type == "zombie" )
    {
        if ( bundle.lastresortknockdown )
        {
            enemy utility::callsharedfunc( #"zombie", #"knockdownzombie", self.origin, bundle.var_f9794c752ee1a9b1 );
        }
        
        damage = zombie_damage;
    }
    else if ( enemy.type == "human" )
    {
        if ( bundle.lastresortknockdown )
        {
            enemy notify( #"flashbang", enemy.origin, 1, undefined, self, self.team, bundle.var_16ba2d09542a8b21 );
        }
        
        damage = human_damage;
    }
    
    enemy dodamage( damage, enemy.origin, self, self, "MOD_EXPLOSIVE", bundle.var_461d79e703a5521, "torso_upper" );
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x1f50b589, Offset: 0xbe1
// Size: 0x46
function private function_b72d46af97dea9b3( vfx, sfx )
{
    fx = utility::getfx( vfx );
    playfxontag( fx, self, "tag_origin" );
    playsoundatpos( self.origin, sfx );
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x74d57edc, Offset: 0xc2f
// Size: 0xbb
function private function_d51b4d2bee3ead3b( range, bundle )
{
    enemies_in_range = [];
    agents_nearby = getaiarrayinradius( self.origin, range );
    
    foreach ( agent in agents_nearby )
    {
        if ( !function_4de5a741f5baa1c4( agent, bundle ) )
        {
            continue;
        }
        
        enemies_in_range[ enemies_in_range.size ] = agent;
    }
    
    return enemies_in_range;
}

// Namespace skill_last_resort
// Params 2, eflags: 0x4
// Checksum 0x3f36bc67, Offset: 0xcf3
// Size: 0x6c, Type: bool
function private function_4de5a741f5baa1c4( agent, bundle )
{
    if ( agent.team == self.team )
    {
        return false;
    }
    
    enemy_tier = agent ai_utility::get_power_tier();
    
    if ( !enemy_tier || enemy_tier > bundle.var_22dfa091ee9af79 )
    {
        return false;
    }
    
    if ( agent zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_last_resort
// Params 1, eflags: 0x4
// Checksum 0xa1d8215b, Offset: 0xd68
// Size: 0x82
function private function_2d2e7bf4eb808ce7( bundle )
{
    self endon( #"death_or_disconnect" );
    weapons_list = self getweaponslistprimaries();
    
    if ( bundle.var_65f076f9ed49bc6a )
    {
        assert( bundle.var_c2be81da6f2f7dd1, "<dev string:x2f6>" );
        reload_time = bundle.var_36e5d972819cf161;
        thread weapon::infiniteammothread( reload_time, weapons_list, 0 );
        wait bundle.var_c2be81da6f2f7dd1;
        thread weapon::stopinfiniteammothread();
    }
}

