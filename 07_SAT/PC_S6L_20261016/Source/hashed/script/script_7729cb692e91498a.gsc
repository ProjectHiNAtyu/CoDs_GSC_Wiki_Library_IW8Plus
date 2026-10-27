// script_7729cb692e91498a  (hash_7729cb692e91498a.gscc) (size: 4642 Bytes / 0x1222 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5e91bbd (2783517629)
// size ...... 4642 (0x1222)
// includes .. 7   (offset: 0x1116)
// strings ... 14  (offset: 0x114e)
// dev strs .. 0   (offset: 0x1222)
// exports ... 14  (offset: 0x9de)
// cseg ...... 0x184 + 0x85a (0x9de)
// imports ... 43  (offset: 0xc0e)
// animtree1 . 0   (offset: 0x1222)
// animtree2 . 0   (offset: 0x1222)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_a081b0c1b6e9c2c7;

// Namespace namespace_a081b0c1b6e9c2c7
// Params 1
// Checksum 0xf715a6cc, Offset: 0x1a2
// Size: 0x54
function function_d57a6a86c7458019( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_scream_concussion_fx", settings.var_d2889c9b376d001e );
        utility::add_fx( "disciple_scream_wave_fx", settings.var_e375a3968755e24f );
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x11308580, Offset: 0x1fe
// Size: 0x2f
function function_426986ab805951c8()
{
    if ( self getaiblackboarddynamic( "can_scream_attack" ) )
    {
        callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_ca3be1986b98aafb );
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x7d9a56bb, Offset: 0x235
// Size: 0x18d
function init_zombie_disciple_scream_attack()
{
    if ( self getaiblackboarddynamic( "can_scream_attack" ) == 1 )
    {
        self.scream_attack_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f98aa3df95b91183;
        self.scream_attack_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_daadbe01a9d6eb26 ) );
        self.var_b1bbdb3c61d74e97 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9f76ee3a7387df29;
        self.var_5e09b9d5b2dd1d3e = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_dd3c663706b0647c;
        self.var_2217f34b3bcf8bad = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6fd798fbcdc03c99 );
        self.scream_attack_cancel_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9cbc084c4731a98 ) );
        self.scream_attack_damage = get_attack_damage( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.screamattackdamage );
        self.var_f2c6f80f142fc452 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b3c63d61cc617f1f;
        self.var_e5c6c9aca9e76bf3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d2889c9b376d001e;
        thread function_d3a8d611029d8b35();
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0xf8037d06, Offset: 0x3ca
// Size: 0xc7
function function_85013a23e58697b9()
{
    self notify( #"hash_33e4857d23eaf6d" );
    self endon( #"hash_33e4857d23eaf6d" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self function_786bb6aa1b76c7ee( "scream_attack_interrupted", 0 );
    thread function_fda8c859cf80cbe9();
    
    while ( self getaiblackboarddynamic( "in_scream_attack" ) )
    {
        if ( zombie_stun::is_stunned() )
        {
            self function_786bb6aa1b76c7ee( "scream_attack_interrupted", 1 );
        }
        
        if ( isdefined( self.enemy ) && distancesquared( self.enemy.origin, self.origin ) > self.var_2217f34b3bcf8bad )
        {
            self function_786bb6aa1b76c7ee( "scream_attack_interrupted", 1 );
            set_scream_cooldown();
        }
        
        waitframe();
    }
    
    self notify( #"scream_attack_done" );
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x5ee7d5b7, Offset: 0x499
// Size: 0x58
function function_fda8c859cf80cbe9()
{
    self notify( #"hash_6c79ecbd4423383a" );
    self endon( #"hash_6c79ecbd4423383a" );
    self endon( #"death" );
    self endon( #"scream_attack_done" );
    level endon( #"game_ended" );
    self waittill( #"hash_929016c302152e7f" );
    self function_786bb6aa1b76c7ee( "scream_attack_interrupted", 1 );
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0xc1f0a74f, Offset: 0x4f9
// Size: 0x35
function function_d3a8d611029d8b35()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"scream_attack_start" );
        self orientmode( "face enemy" );
        thread function_6054fdbce28d718d();
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x2d42cad9, Offset: 0x536
// Size: 0x253
function function_6054fdbce28d718d()
{
    self endon( #"death" );
    thread function_85013a23e58697b9();
    
    if ( isdefined( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) <= squared( self.scream_attack_dist ) )
    {
        self.var_9817e4a0466bf3c4 = 0;
        scream_time = 1.5;
        statename = self asmgetcurrentstate( self.asmname );
        animid = asm::asm_getanim( self.asmname, statename );
        xanim = asm::asm_getxanim( statename, animid );
        anim_length = getanimlength( xanim );
        
        if ( animhasnotetrack( xanim, "scream_start_fx" ) )
        {
            scream_frac = getnotetracktimes( xanim, "scream_start_fx" )[ 0 ];
            scream_time = anim_length * scream_frac;
        }
        
        wait scream_time;
        scream_attack_wave = playfxontag( utility::getfx( "disciple_scream_wave_fx" ), self, "tag_fx_head_weakspot" );
        
        if ( isalive( self.enemy ) )
        {
            self.enemy dodamage( self.scream_attack_damage, self.enemy.origin, self, self, "MOD_PROJECTILE", undefined, "torso_upper" );
        }
        
        nearby_players = getplayersinradius( self.origin, self.var_b1bbdb3c61d74e97 );
        
        foreach ( player in nearby_players )
        {
            if ( player val::get( "damage" ) && !player.ismutantinjection && player function_3d18e780bb2b451( self gettagorigin( "tag_fx_head_weakspot" ), anglestoforward( self.angles ), self.var_5e09b9d5b2dd1d3e, self.var_b1bbdb3c61d74e97 ) )
            {
                player shellshock( self.var_e5c6c9aca9e76bf3, self.var_f2c6f80f142fc452 );
            }
        }
        
        set_scream_cooldown();
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0xeefbb69b, Offset: 0x791
// Size: 0xb7, Type: bool
function can_scream_attack()
{
    if ( self.b_in_spawn_closet )
    {
        return false;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return false;
    }
    
    if ( isdefined( self getaiblackboarddynamic( "scream_attack_cooldown" ) ) && self getaiblackboarddynamic( "scream_attack_cooldown" ) > gettime() )
    {
        return false;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, self.enemy.origin ) > squared( self.scream_attack_dist ) || abs( self.enemy.origin[ 2 ] - self.origin[ 2 ] ) > 50 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 1
// Checksum 0x379469f8, Offset: 0x851
// Size: 0x27
function get_attack_damage( var_5454f57201136c19 )
{
    return var_5454f57201136c19 * ( self.var_fe048a2106d8ef00[ #"scream_attack" ] ?? 1 );
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 1, eflags: 0x4
// Checksum 0xb0e54002, Offset: 0x881
// Size: 0x8c
function private function_ca3be1986b98aafb( params )
{
    if ( isdefined( self.var_9817e4a0466bf3c4 ) )
    {
        self.var_9817e4a0466bf3c4 += params.idamage;
    }
    
    if ( !self.var_e3ff6b5a34e23c16 && self.var_9817e4a0466bf3c4 > self.var_f9c90a73b7d774 * self.maxhealth )
    {
        zombie_stun::stun_ai( 1 );
        set_scream_cooldown();
        self.var_9817e4a0466bf3c4 = undefined;
        self function_786bb6aa1b76c7ee( "scream_attack_interrupted", 1 );
    }
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x2c92a420, Offset: 0x915
// Size: 0x4b
function set_scream_cooldown()
{
    override_cooldown = getdvarint( @"hash_c87e92f15034e9ba", -1 );
    
    if ( override_cooldown > -1 )
    {
        ai::set_blackboard_cooldown( "scream_attack_cooldown", override_cooldown );
        return;
    }
    
    ai::set_blackboard_cooldown( "scream_attack_cooldown", self.scream_attack_cancel_cooldown );
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 0
// Checksum 0x21616990, Offset: 0x968
// Size: 0x3c
function function_8eae05addfac334a()
{
    self.force_scream_attack = undefined;
    self.scream_attack_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_daadbe01a9d6eb26 ) );
}

// Namespace namespace_a081b0c1b6e9c2c7
// Params 1
// Checksum 0x413ef9fe, Offset: 0x9ac
// Size: 0x32
function force_scream_attack( new_cooldown )
{
    self.force_scream_attack = 1;
    
    if ( isdefined( new_cooldown ) )
    {
        self.scream_attack_cooldown = int( utility::function_4b74c15943231980( new_cooldown ) );
    }
}

