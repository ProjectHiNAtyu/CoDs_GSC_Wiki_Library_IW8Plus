// script_9add55567111158  (hash_09add55567111158.gscc) (size: 2298 Bytes / 0x8fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x338372f7 (864252663)
// size ...... 2298 (0x8fa)
// includes .. 5   (offset: 0x846)
// strings ... 10  (offset: 0x86e)
// dev strs .. 0   (offset: 0x8fa)
// exports ... 5   (offset: 0x57a)
// cseg ...... 0xf3 + 0x487 (0x57a)
// imports ... 18  (offset: 0x642)
// animtree1 . 0   (offset: 0x8fa)
// animtree2 . 0   (offset: 0x8fa)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\utility;

#namespace namespace_55d38ee0bc42059f;

// Namespace namespace_55d38ee0bc42059f
// Params 1
// Checksum 0x962ce1ca, Offset: 0x111
// Size: 0x3d
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "rocket_boots_burn_fx", settings.var_e64eb891295031d7 );
    }
}

// Namespace namespace_55d38ee0bc42059f
// Params 0
// Checksum 0x38f3fd21, Offset: 0x156
// Size: 0x9
function function_5e4e942574025b35()
{
    zombie_melee::init_zombie_melee_global();
}

// Namespace namespace_55d38ee0bc42059f
// Params 0
// Checksum 0x8775887d, Offset: 0x167
// Size: 0x108
function init_zombie_viper_mini_melee()
{
    zombie_melee::init_zombie_melee();
    self function_786bb6aa1b76c7ee( "melee_attack_cooldown", 2000 );
    self function_695b8e1b655c2796( "melee", "melee" );
    self.var_d6ab292256a5595 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3690a3771af28b16 ?? 75;
    self.var_948252794d3c5c78 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b6111dba6e6674fc ?? 100;
    self.var_dd22fbc019e4597 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_208686cdb1998b3b ?? 5;
    self.var_417bf93553f3e986 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8e916c1349db68e2 ?? 2;
    self.var_8e300490f3a118b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e8e2fdd1f60ac27 ?? 0.5;
    thread burn_kick_watcher();
}

// Namespace namespace_55d38ee0bc42059f
// Params 0, eflags: 0x4
// Checksum 0x73fea87c, Offset: 0x277
// Size: 0x303
function private burn_kick_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"burn_kick" );
        var_c6ef046cc74180c4 = getaiarrayinradius( self.origin, self.var_948252794d3c5c78 );
        
        foreach ( ai in var_c6ef046cc74180c4 )
        {
            if ( ai != self && isalive( ai ) )
            {
                if ( ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
                {
                    ai zombie_knockdown::function_6fc167d4a3590991( self.origin, 200 );
                }
                
                ai effect_burn::burn( self.var_417bf93553f3e986, self.var_dd22fbc019e4597, self.var_8e300490f3a118b, self, "rocket_boots", "_rocket_boots", undefined, "fire" );
            }
        }
        
        var_1d3c3a0252927eb8 = getplayersinradius( self.origin, self.var_948252794d3c5c78 );
        
        foreach ( player in var_1d3c3a0252927eb8 )
        {
            if ( isalive( player ) )
            {
                if ( self.var_417bf93553f3e986 > 0 )
                {
                    var_dd22fbc019e4597 = self.var_dd22fbc019e4597;
                    
                    if ( isdefined( self.var_fe048a2106d8ef00[ #"rocket_boots_burn" ] ) )
                    {
                        var_dd22fbc019e4597 *= self.var_fe048a2106d8ef00[ #"rocket_boots_burn" ];
                    }
                    
                    player effect_burn::burn( self.var_417bf93553f3e986, var_dd22fbc019e4597, self.var_8e300490f3a118b, self, "rocket_boots", "_rocket_boots", undefined, "fire" );
                    playfxontagforclients( utility::getfx( "rocket_boots_burn_fx" ), player, "j_head", player );
                }
                
                if ( self.var_c8cf90daee0f67a3 > 0 )
                {
                    player utility::knockback_flat( player.origin - self.origin, self.var_c8cf90daee0f67a3 );
                }
                
                if ( self.var_d6ab292256a5595 > 0 )
                {
                    var_d6ab292256a5595 = self.var_d6ab292256a5595;
                    
                    if ( isdefined( self.var_fe048a2106d8ef00[ #"rocket_boots_kick" ] ) )
                    {
                        var_d6ab292256a5595 *= self.var_fe048a2106d8ef00[ #"rocket_boots_kick" ];
                    }
                    
                    player dodamage( var_d6ab292256a5595, player.origin, self, self, "MOD_FIRE", "<explicitweaponnone>" );
                }
            }
        }
    }
}

