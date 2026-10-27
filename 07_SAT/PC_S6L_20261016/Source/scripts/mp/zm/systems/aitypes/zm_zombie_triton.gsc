// scripts\mp\zm\systems\aitypes\zm_zombie_triton.gsc  (hash_2cd7773a34d8e51a.gscc) (size: 5705 Bytes / 0x1649 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1eda2d0b (517614859)
// size ...... 5705 (0x1649)
// includes .. 6   (offset: 0x14fd)
// strings ... 20  (offset: 0x152d)
// dev strs .. 0   (offset: 0x1649)
// exports ... 16  (offset: 0xe7d)
// cseg ...... 0x204 + 0xc79 (0xe7d)
// imports ... 32  (offset: 0x10fd)
// animtree1 . 0   (offset: 0x1649)
// animtree2 . 0   (offset: 0x1649)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zm_zombie_triton;

// Namespace zm_zombie_triton
// Params 2
// Checksum 0x500859e7, Offset: 0x222
// Size: 0x40
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_9825ce6b4093590b ) )
    {
        return;
    }
    
    level.var_9825ce6b4093590b = 1;
    level callback::add( "on_zombie_triton_spawned", &function_294e46cde27e4fdb );
}

// Namespace zm_zombie_triton
// Params 1
// Checksum 0x34455b2c, Offset: 0x26a
// Size: 0x144
function function_294e46cde27e4fdb( params )
{
    val::set( "triton", "trigger_hurt_damage", 0 );
    val::set( "triton", "ignore_cleanup", 1 );
    val::set( "triton", "allow_brot", 1 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.b_disable_annihilate = 1;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.var_bfa7ca2a8740bf7b = 1;
    self.ignore_enemy_count = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.var_5a9c952260ab1cf = 1;
    self.no_powerups = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.disallow_aether_shroud_shadow_blade = 1;
    metabone::function_23dfe92664fb40fd( &function_21422871f0d176e7 );
    zombie_utils::function_b021918a41e1df51( "t10_me_p19_bloodstoneww_fireball_mp", &function_e9bf42032a6688f7 );
    zombie_utils::function_b021918a41e1df51( "t10_me_p19_bloodstonedope_mp", &function_7f655758df6507d3 );
    zombie_utils::function_b021918a41e1df51( "t10_me_p19_bloodstoneeasy_mp", &function_b9e028a6d5957033 );
    zombie_utils::function_b021918a41e1df51( "t10_me_p19_bloodstonelife_mp", &function_f289720459cce9d6 );
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xeaef524d, Offset: 0x3b6
// Size: 0x1ca
function private function_21422871f0d176e7( dmgstruct )
{
    foreach ( bulletweapon in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_54487be7529dda04 )
    {
        if ( bulletweapon.var_d2903b1086f7b13a == dmgstruct.objweapon.basename )
        {
            var_c5d455ea1e795865 = 1;
            break;
        }
    }
    
    foreach ( projectileweapon in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e727fc989971033 )
    {
        if ( projectileweapon.var_310d3747437a3421 == dmgstruct.objweapon.basename )
        {
            var_dd931a49a368274c = 1;
            break;
        }
    }
    
    if ( isplayer( dmgstruct.eattacker ) && ( var_c5d455ea1e795865 || var_dd931a49a368274c ) )
    {
        weakspotdata = metabone::get_metabone_metadata( dmgstruct.metabonename, "Types_Weakspot" );
        
        if ( isdefined( weakspotdata ) )
        {
            return 1;
        }
    }
    
    return dmgstruct.biscritical;
}

// Namespace zm_zombie_triton
// Params 1
// Checksum 0x12a670b2, Offset: 0x589
// Size: 0x169
function function_e9bf42032a6688f7( params )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    if ( isplayer( params.eattacker ) && isdefined( params.metabonename ) )
    {
        armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
        
        if ( isdefined( armordata ) )
        {
            var_9c046d01d92613e = zombie_damage::is_explosive_damage( params.smeansofdeath ) ? armordata.explosivedamagemod : armordata.damagemod;
            
            if ( isdefined( var_9c046d01d92613e ) )
            {
                if ( !isdefined( self.var_7037157e68c4992b ) )
                {
                    if ( isdefined( params.idamage ) && isdefined( params.metabonename ) && isdefined( self.maxhealth ) && params.var_ff33243f5be1fe3b >= 0 && params.var_ff33243f5be1fe3b < 1 )
                    {
                        adjusteddamage = min( params.idamage, params.var_ff33243f5be1fe3b * self.maxhealth );
                        var_431e077e5f010419 = adjusteddamage * 1.5;
                        metabone::damage_metabone( params.metabonename, var_431e077e5f010419, params.eattacker, params.einflictor );
                    }
                }
            }
        }
    }
    
    return -1;
}

// Namespace zm_zombie_triton
// Params 1
// Checksum 0xa62c09bf, Offset: 0x6fb
// Size: 0x7a
function function_b9e028a6d5957033( params )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    wait 0.5;
    var_834ba862ac584cae = params.eattacker getscriptablepartstate( "bloodstoneww_easy_audio", 1 );
    
    if ( !self.var_e7e8fbd1c2f04bf8 && var_834ba862ac584cae == "firing" )
    {
        self.var_e7e8fbd1c2f04bf8 = 1;
        thread function_1b32c562fe9355b5( params.eattacker );
    }
    
    return -1;
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xc19efb83, Offset: 0x77e
// Size: 0x6a
function private function_1b32c562fe9355b5( attacker )
{
    self endon( #"death" );
    zombie_utils::function_dfae6a5bd222c586( &function_9789aab1e4d1e6df );
    callback::add( "on_zombie_ai_damaged", &monitor_lightning_strike_damage );
    attacker waittill( #"hash_b4229783b43a271f" );
    zombie_utils::function_10c0c35c21e3ed9d( &function_9789aab1e4d1e6df );
    callback::remove( "on_zombie_ai_damaged", &monitor_lightning_strike_damage );
    self.var_e7e8fbd1c2f04bf8 = undefined;
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0x392c60e2, Offset: 0x7f0
// Size: 0x5a
function private function_9789aab1e4d1e6df( params )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    if ( params.sweapon.basename != "t10_me_p19_bloodstoneeasy_mp" )
    {
        return -1;
    }
    
    damage = params.idamage * 0.15;
    return damage;
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0x340f13da, Offset: 0x853
// Size: 0x143
function private monitor_lightning_strike_damage( params )
{
    if ( isplayer( params.eattacker ) && isdefined( params.metabonename ) )
    {
        armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
        
        if ( isdefined( armordata ) )
        {
            var_9c046d01d92613e = zombie_damage::is_explosive_damage( params.smeansofdeath ) ? armordata.explosivedamagemod : armordata.damagemod;
            
            if ( isdefined( var_9c046d01d92613e ) )
            {
                if ( !isdefined( self.var_7037157e68c4992b ) )
                {
                    if ( params.var_ff33243f5be1fe3b >= 0 && params.var_ff33243f5be1fe3b < 1 && isdefined( self.maxhealth ) )
                    {
                        adjusteddamage = min( params.idamage, params.var_ff33243f5be1fe3b * self.maxhealth );
                    }
                }
                
                if ( isdefined( adjusteddamage ) )
                {
                    var_431e077e5f010419 = adjusteddamage * 6;
                    metabone::damage_metabone( params.metabonename, var_431e077e5f010419, params.eattacker, params.einflictor );
                }
            }
        }
    }
    
    return -1;
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0x1bb05a32, Offset: 0x99f
// Size: 0x2a
function private function_7f655758df6507d3( params )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    thread function_370545c6a21e3686();
    thread function_7ef08661df166840();
    return -1;
}

// Namespace zm_zombie_triton
// Params 0, eflags: 0x4
// Checksum 0xba91e825, Offset: 0x9d2
// Size: 0xa2
function private function_370545c6a21e3686()
{
    self endon( #"death" );
    self endon( #"hash_7a08ce9dc162aa6b" );
    
    if ( !self.var_541be3b52be2b6ac )
    {
        self.var_541be3b52be2b6ac = 1;
        level waittill( #"hash_eca7066defac6399", var_be3ddb862deb0056 );
        self.var_62e7f5154a496d1f = var_be3ddb862deb0056.var_be3ddb862deb0056.vortex_center;
        callback::add( "on_zombie_ai_damaged", &function_8aa563d5ff928d10 );
        wait 5;
        callback::remove( "on_zombie_ai_damaged", &function_8aa563d5ff928d10 );
        self.var_62e7f5154a496d1f = undefined;
        self.var_541be3b52be2b6ac = undefined;
    }
}

// Namespace zm_zombie_triton
// Params 0, eflags: 0x4
// Checksum 0x83f439c5, Offset: 0xa7c
// Size: 0x20
function private function_7ef08661df166840()
{
    self endon( #"death" );
    wait 6;
    self notify( #"hash_7a08ce9dc162aa6b" );
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xe8d4d867, Offset: 0xaa4
// Size: 0x1a9
function private function_8aa563d5ff928d10( params )
{
    var_79f9594f490c726f = params.smeansofdeath == "MOD_CRUSH" && isdefined( self.var_62e7f5154a496d1f ) && params.vpoint == self.var_62e7f5154a496d1f;
    
    if ( var_79f9594f490c726f )
    {
        if ( isplayer( params.eattacker ) )
        {
            rightvec = anglestoright( self.angles );
            
            if ( vectordot2( rightvec, params.vdir ) <= 0 )
            {
                metabonename = "armored_leg_right";
            }
            else
            {
                metabonename = "armored_leg_left";
            }
            
            armordata = metabone::get_metabone_metadata( metabonename, "Types_Armor" );
            
            if ( isdefined( armordata ) )
            {
                var_9c046d01d92613e = zombie_damage::is_explosive_damage( params.smeansofdeath ) ? armordata.explosivedamagemod : armordata.damagemod;
                
                if ( isdefined( var_9c046d01d92613e ) )
                {
                    if ( !isdefined( self.var_7037157e68c4992b ) )
                    {
                        if ( params.var_ff33243f5be1fe3b >= 0 && params.var_ff33243f5be1fe3b < 1 && isdefined( self.maxhealth ) )
                        {
                            adjusteddamage = min( params.idamage, params.var_ff33243f5be1fe3b * self.maxhealth );
                            var_431e077e5f010419 = adjusteddamage * 100;
                            metabone::damage_metabone( metabonename, var_431e077e5f010419, params.eattacker, params.einflictor );
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xe7ca1372, Offset: 0xc55
// Size: 0x7d
function private function_f289720459cce9d6( params )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    wait 0.5;
    var_5fc6af97db6c6101 = params.eattacker getscriptablepartstate( "SwordLightPlayerVFX", 1 );
    
    if ( !self.var_8cf25adc19a0768d && isdefined( level.var_8e1036669fbbf38a ) && var_5fc6af97db6c6101 == "on" )
    {
        self.var_8cf25adc19a0768d = 1;
        thread function_931edd2c5aa9dc7e();
    }
    
    return -1;
}

// Namespace zm_zombie_triton
// Params 0, eflags: 0x4
// Checksum 0x41030f5e, Offset: 0xcdb
// Size: 0x4a
function private function_931edd2c5aa9dc7e()
{
    self endon( #"death" );
    callback::add( "on_zombie_ai_damaged", &function_6f2a91b8251a4221 );
    wait utility::function_6f5d2e1f1ff70482( level.var_8e1036669fbbf38a );
    callback::remove( "on_zombie_ai_damaged", &function_6f2a91b8251a4221 );
    self.var_8cf25adc19a0768d = undefined;
}

// Namespace zm_zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xbf441332, Offset: 0xd2d
// Size: 0x150
function private function_6f2a91b8251a4221( params )
{
    if ( params.smeansofdeath == "MOD_ELEMENTAL_LIGHT" && isplayer( params.eattacker ) && isdefined( params.metabonename ) )
    {
        armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
        
        if ( isdefined( armordata ) )
        {
            var_9c046d01d92613e = zombie_damage::is_explosive_damage( params.smeansofdeath ) ? armordata.explosivedamagemod : armordata.damagemod;
            
            if ( isdefined( var_9c046d01d92613e ) )
            {
                if ( !isdefined( self.var_7037157e68c4992b ) )
                {
                    if ( params.var_ff33243f5be1fe3b >= 0 && params.var_ff33243f5be1fe3b < 1 && isdefined( self.maxhealth ) )
                    {
                        adjusteddamage = min( params.idamage, params.var_ff33243f5be1fe3b * self.maxhealth );
                        var_431e077e5f010419 = adjusteddamage * 150;
                        metabone::damage_metabone( params.metabonename, var_431e077e5f010419, params.eattacker, params.einflictor );
                    }
                }
            }
        }
    }
}

