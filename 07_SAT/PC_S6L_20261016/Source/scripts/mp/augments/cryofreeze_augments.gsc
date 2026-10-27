// scripts\mp\augments\cryofreeze_augments.gsc  (hash_01c525881cb5d316.gscc) (size: 5080 Bytes / 0x13d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd235e1a5 (3526746533)
// size ...... 5080 (0x13d8)
// includes .. 8   (offset: 0x12d0)
// strings ... 14  (offset: 0x1310)
// dev strs .. 0   (offset: 0x13d8)
// exports ... 12  (offset: 0xbb4)
// cseg ...... 0x162 + 0xa52 (0xbb4)
// imports ... 45  (offset: 0xd94)
// animtree1 . 0   (offset: 0x13d8)
// animtree2 . 0   (offset: 0x13d8)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\cryofreeze;

#namespace cryofreeze_augments;

// Namespace cryofreeze_augments
// Params 0, eflags: 0x5
// Checksum 0x62710a56, Offset: 0x180
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"cryofreeze_augments", undefined, &init_cryofreeze_augments, undefined );
}

// Namespace cryofreeze_augments
// Params 0
// Checksum 0x8dc72f7b, Offset: 0x1a1
// Size: 0x60
function init_cryofreeze_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level._effect[ "vfx_cryofreeze_cloud" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_aat_cryofreeze_cloud" );
    callback::add( #"on_ai_killed", &function_88e821e08c48ac7e );
    callback::add( "on_cryofreeze_proc", &on_cryofreeze_proc );
    callback::add( "on_cryofreeze_end", &on_cryofreeze_end );
}

// Namespace cryofreeze_augments
// Params 1
// Checksum 0xf24de76f, Offset: 0x209
// Size: 0x209
function on_cryofreeze_proc( sparams )
{
    if ( sparams.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_aoe_proc" ) )
    {
        var_c1b4bee94a5cb1e7 = level.zombie_augments[ #"cryofreeze_aoe_proc" ].var_1909c3d46d92a1cb ?? 0.2;
        var_c1b4bee94a5cb1e7 *= 100;
        
        if ( utility::percent_chance( var_c1b4bee94a5cb1e7 ) )
        {
            var_7d43ccfa569e3184 = level.zombie_augments[ #"cryofreeze_aoe_proc" ].var_f96f4ff13705dfa1 ?? 80;
            var_fdc5e4472f1e2a76 = getaiarrayinradius( self.origin, var_7d43ccfa569e3184 );
            
            foreach ( enemy in var_fdc5e4472f1e2a76 )
            {
                if ( !isalive( enemy ) )
                {
                    continue;
                }
                
                if ( sparams.attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( sparams.attacker, enemy ) )
                    {
                        continue;
                    }
                }
                
                enemy_ai_tier = enemy ai_utility::get_ai_tier();
                
                if ( enemy_ai_tier == 1 || enemy_ai_tier == 2 )
                {
                    enemy cryofreeze::function_2c6acf2c700ce10c( sparams.death, sparams.attacker, sparams.mod, sparams.sweapon, sparams.vpoint, sparams.shitloc, sparams.modelindex );
                }
            }
        }
    }
}

// Namespace cryofreeze_augments
// Params 2, eflags: 0x4
// Checksum 0x26342273, Offset: 0x41a
// Size: 0x70, Type: bool
function private function_5334db04552010b( sparams, agent_target )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_post_freeze_damage" ) )
    {
        post_damage_percent = level.zombie_augments[ #"cryofreeze_aoe_proc" ].var_6c14fd4a16173a0d ?? 0.2;
    }
    
    return post_damage_percent ?? 0;
}

// Namespace cryofreeze_augments
// Params 2, eflags: 0x4
// Checksum 0x32538dc1, Offset: 0x493
// Size: 0x86, Type: bool
function private function_4b452410be58ea71( sparams, agent_target )
{
    var_b7431aebc8f57943 = [ 3:sparams.elitedamage, 2:sparams.var_b9b58463138b2998, 1:sparams.normaldamage ];
    ai_tier = sparams.var_2a910b69b3bb40ff ? agent_target [[ sparams.var_2a910b69b3bb40ff ]]() : agent_target ai_utility::get_ai_tier();
    return var_b7431aebc8f57943[ ai_tier ] ?? 0;
}

// Namespace cryofreeze_augments
// Params 1, eflags: 0x4
// Checksum 0xdd0b6405, Offset: 0x522
// Size: 0x38, Type: bool
function private function_97ad5a71581918a2( sparams )
{
    return isdefined( sparams.normaldamage ) || isdefined( sparams.var_b9b58463138b2998 ) || isdefined( sparams.elitedamage );
}

// Namespace cryofreeze_augments
// Params 1
// Checksum 0x6a83de48, Offset: 0x563
// Size: 0x108
function on_cryofreeze_end( sparams )
{
    if ( !isplayer( sparams.attacker ) || !isalive( self ) )
    {
        return;
    }
    
    if ( function_97ad5a71581918a2( sparams ) )
    {
        damage = sparams.attacker function_4b452410be58ea71( sparams, self );
    }
    else
    {
        post_damage_percent = sparams.attacker function_5334db04552010b( sparams, self );
        
        if ( post_damage_percent )
        {
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            damage = int( base_zombie_maxhealth * post_damage_percent );
            var_7dfd56bef4ead19f = 1073807360;
        }
    }
    
    if ( damage )
    {
        self dodamage( damage, self.origin, sparams.attacker, sparams.attacker, "MOD_ELEMENTAL_COLD", sparams.sweapon, "none", undefined, var_7dfd56bef4ead19f );
    }
}

// Namespace cryofreeze_augments
// Params 0
// Checksum 0x3a7f954e, Offset: 0x673
// Size: 0x48
function is_ice_slowed()
{
    isslowed = status_effects::function_fa35fc2723e956eb( "slow", "cryofreeze" ) || status_effects::function_fa35fc2723e956eb( "slow", "frost_blast" ) || status_effects::function_fa35fc2723e956eb( "slow", "frost_blast_frozen" );
    return isslowed;
}

// Namespace cryofreeze_augments
// Params 1
// Checksum 0x5120e98, Offset: 0x6c4
// Size: 0x153
function function_88e821e08c48ac7e( sparams )
{
    if ( isplayer( sparams.eattacker ) && is_ice_slowed() && sparams.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_ice_cloud" ) )
    {
        if ( isdefined( sparams.sweapon ) && sparams.eattacker utility::callsharedfunc( #"ammo_mod", #"hash_dd0e24457cb788c3", sparams.sweapon, "cryofreeze" ) )
        {
            var_19ca8537b8a10b4a = level.zombie_augments[ #"cryofreeze_ice_cloud" ].var_83c6d0ab77ec2a58 ?? 0.1;
            var_19ca8537b8a10b4a *= 100;
            
            if ( utility::percent_chance( var_19ca8537b8a10b4a ) )
            {
                if ( !isdefined( sparams.eattacker.var_b04406898fd71d03 ) )
                {
                    sparams.eattacker.var_b04406898fd71d03 = 0;
                }
                
                if ( sparams.eattacker.var_b04406898fd71d03 < 2 )
                {
                    sparams.eattacker.var_b04406898fd71d03++;
                    thread cryofreeze_ice_cloud( sparams.eattacker );
                }
            }
        }
    }
}

// Namespace cryofreeze_augments
// Params 1
// Checksum 0xfc3c91c, Offset: 0x81f
// Size: 0x2ac
function cryofreeze_ice_cloud( attacker )
{
    level endon( #"game_ended" );
    duration = level.zombie_augments[ #"cryofreeze_ice_cloud" ].var_3de6cfb938e4b9f4 ?? 5;
    radius = level.zombie_augments[ #"cryofreeze_ice_cloud" ].var_759d342d28adc6e2 ?? 200;
    duration *= 1000;
    starttime = gettime();
    lasttime = gettime();
    attacker.var_bcd1358d847dc63a = gettime();
    cloudorigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 60 );
    area = utility::spawn_tag_origin( cloudorigin, anglestoforward( self.angles ) );
    area show();
    fxid = utility::getfx( "vfx_cryofreeze_cloud" );
    playfxontag( fxid, area, "tag_origin" );
    area playsound( #"hash_8b5b74a11146138f" );
    
    while ( lasttime - starttime < duration )
    {
        lasttime = gettime();
        var_fdc5e4472f1e2a76 = getaiarrayinradius( area.origin, radius );
        
        foreach ( enemy in var_fdc5e4472f1e2a76 )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, enemy ) )
                {
                    continue;
                }
            }
            
            enemy_ai_tier = enemy ai_utility::get_ai_tier();
            
            if ( enemy_ai_tier == 1 || enemy_ai_tier == 2 )
            {
                enemy thread function_fa254d81097de275( attacker );
                waitframe();
            }
        }
        
        wait 1;
    }
    
    killfxontag( fxid, area, "tag_origin" );
    
    if ( isplayer( attacker ) )
    {
        if ( !isdefined( attacker.var_b04406898fd71d03 ) )
        {
            attacker.var_b04406898fd71d03 = 0;
        }
        
        attacker.var_b04406898fd71d03--;
        
        if ( attacker.var_b04406898fd71d03 < 0 )
        {
            attacker.var_b04406898fd71d03 = 0;
        }
    }
    
    area delete();
}

// Namespace cryofreeze_augments
// Params 1, eflags: 0x4
// Checksum 0x2ceda738, Offset: 0xad3
// Size: 0xe1
function private function_fa254d81097de275( attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( cryofreeze::get_is_slowed() )
    {
        return;
    }
    
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    thread cryofreeze::function_9bffdecb8a0a3a1e();
    utility::ent_flag_init( "cryofreeze_active" );
    utility::ent_flag_set( "cryofreeze_active" );
    self.var_e957ff879042cc5f = attacker;
    slowpercent = level.zombie_augments[ #"cryofreeze_ice_cloud" ].var_1fd59878126a6ee9 ?? 0.5;
    cryofreezetime = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].ammomodduration ?? 5;
    effect_slow::slow( "cryofreeze", slowpercent, cryofreezetime, attacker, &cryofreeze::function_cb9164f240124e13, 0, "cold" );
}

