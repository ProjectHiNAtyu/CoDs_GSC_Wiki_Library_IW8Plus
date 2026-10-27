// scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_web.gsc  (hash_41b1474d00ad9bdd.gscc) (size: 3765 Bytes / 0xeb5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d892795 (763963285)
// size ...... 3765 (0xeb5)
// includes .. 4   (offset: 0xd61)
// strings ... 20  (offset: 0xd81)
// dev strs .. 0   (offset: 0xeb5)
// exports ... 14  (offset: 0x75d)
// cseg ...... 0x1e3 + 0x57a (0x75d)
// imports ... 32  (offset: 0x98d)
// animtree1 . 0   (offset: 0xeb5)
// animtree2 . 0   (offset: 0xeb5)
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom_minion_web;

// Namespace zombie_loom_minion_web
// Params 0
// Checksum 0x7ab23f1f, Offset: 0x201
// Size: 0x5e
function function_e5c4221a1bd3de40()
{
    if ( !val::is_registered( "webbed" ) )
    {
        val::register( "webbed", 0, 1, "$self" );
    }
    
    if ( !val::is_registered( "recently_webbed" ) )
    {
        val::register( "recently_webbed", 0, 1, "$self" );
    }
    
    level function_487b0789fb3aac34();
    self.var_7f8ab9bb9f4957fc = &function_b5f6b47915a06582;
}

// Namespace zombie_loom_minion_web
// Params 2
// Checksum 0xaaac6ee3, Offset: 0x267
// Size: 0x32, Type: bool
function function_5bb4500fdc442e03( taskid, params )
{
    return self.enemy && !is_entity_recently_webbed( self.enemy );
}

// Namespace zombie_loom_minion_web
// Params 2
// Checksum 0xd01aeae9, Offset: 0x2a2
// Size: 0x58, Type: bool
function is_entity_webbed( ent, var_13705529e983b8e7 )
{
    if ( !ent val::get( "webbed" ) )
    {
        if ( var_13705529e983b8e7 && ent.var_963a530349ac7cff && gettime() - ent.var_963a530349ac7cff < var_13705529e983b8e7 )
        {
            return true;
        }
        
        return false;
    }
    
    return true;
}

// Namespace zombie_loom_minion_web
// Params 1
// Checksum 0xe935dc33, Offset: 0x303
// Size: 0x19
function is_entity_recently_webbed( ent )
{
    return ent val::get( "recently_webbed" );
}

// Namespace zombie_loom_minion_web
// Params 4
// Checksum 0x9eb5a8cf, Offset: 0x325
// Size: 0x13b
function web_target( attacker, slow_factor, slow_duration, slow_cooldown )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isplayer( self ) && function_a76b284e8414acbb() )
    {
        return;
    }
    
    val::set( "loom_minion_webbed_projectile", "recently_webbed", 1 );
    val::set( "loom_minion_webbed_projectile", "webbed", 1 );
    utility::function_32b24db3127bff40( "web_fx", "web_on" );
    effect_slow::slow( "loom_minion_webbed_projectile", slow_factor, slow_duration, attacker, &function_c56003a2409a610d, undefined, undefined, slow_cooldown );
    min_time_s = attacker.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3f7cbf6f5e4833c6 ?? 1;
    max_time_s = attacker.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6e2778e796115d44 ?? 2;
    self.var_e66475cc61690441 = randomfloatrange( min_time_s * 1000, max_time_s * 1000 );
    
    if ( isplayer( self ) )
    {
        var_62e858c45bbf3f11 = utility::getfx( "loom_minion_ranged_attack_screen_fx" );
        
        if ( var_62e858c45bbf3f11 )
        {
            playfxontagforclients( var_62e858c45bbf3f11, self, "j_head", self );
        }
    }
}

// Namespace zombie_loom_minion_web
// Params 1, eflags: 0x4
// Checksum 0x795a6c, Offset: 0x468
// Size: 0x53
function private function_c56003a2409a610d( cooldown )
{
    val::reset( "loom_minion_webbed_projectile", "webbed" );
    self.var_963a530349ac7cff = gettime();
    
    if ( !val::get( "webbed" ) )
    {
        utility::function_32b24db3127bff40( "web_fx", "web_off" );
    }
    
    thread clear_recently_webbed( cooldown );
}

// Namespace zombie_loom_minion_web
// Params 1, eflags: 0xc
// Checksum 0xcee11929, Offset: 0x4c3
// Size: 0x41
function private clear_recently_webbed( cooldown )
{
    self notify( #"hash_1bf4a90992a37dc4" );
    self endon( #"hash_1bf4a90992a37dc4" );
    
    if ( cooldown )
    {
        wait cooldown;
    }
    
    if ( self )
    {
        val::reset( "loom_minion_webbed_projectile", "recently_webbed" );
    }
}

// Namespace zombie_loom_minion_web
// Params 5, eflags: 0x4
// Checksum 0xcf2f34e1, Offset: 0x50c
// Size: 0x6f
function private function_b5f6b47915a06582( damage, eattacker, weapon, mod, vpoint )
{
    if ( isdefined( eattacker ) && issubstr( eattacker.subclass, "zombie_loom_minion" ) && is_entity_webbed( self ) )
    {
        damage = int( damage * eattacker.var_440882cde5a176f6 );
    }
    
    return damage;
}

// Namespace zombie_loom_minion_web
// Params 0, eflags: 0x4
// Checksum 0x4c5b0fd4, Offset: 0x584
// Size: 0x74
function private function_487b0789fb3aac34()
{
    callback::add( #"player_damaged", &function_74aba2c9e0c82d18 );
    callback::add( #"on_used_super", &function_f6857bf535618581 );
    callback::add( "usurped_power_deploying", &function_cf765afc7357fd63 );
    callback::add( "on_healingaura_healed", &function_cf765afc7357fd63 );
    callback::add( #"on_adrenaline_used", &function_cf765afc7357fd63 );
    callback::add( "lightray_healing", &function_cf765afc7357fd63 );
}

// Namespace zombie_loom_minion_web
// Params 0
// Checksum 0x399edb03, Offset: 0x600
// Size: 0x65, Type: bool
function function_a76b284e8414acbb()
{
    var_a486f1d1629803ac = isplayer( self ) && self.mask_ee.var_73e37bf886655ce7.ref == "zmloot_scarab_loom_ride_ee_mask";
    return var_a486f1d1629803ac || utility::ent_flag( "wiley_fox_active" ) || utility::ent_flag( "is_usurped_power_grabbed" ) || is_entity_recently_webbed( self );
}

// Namespace zombie_loom_minion_web
// Params 1, eflags: 0x4
// Checksum 0x46798d58, Offset: 0x66e
// Size: 0x3c
function private function_74aba2c9e0c82d18( params )
{
    if ( params.smeansofdeath == "MOD_BURNED" || params.smeansofdeath == "MOD_FIRE" )
    {
        function_cf765afc7357fd63();
    }
}

// Namespace zombie_loom_minion_web
// Params 1, eflags: 0x4
// Checksum 0x616d3ae, Offset: 0x6b2
// Size: 0x72
function private function_f6857bf535618581( params )
{
    if ( isplayer( params.player ) )
    {
        var_e93a67c34276fb3f = params.superinfo.staticdata.ref;
        
        if ( var_e93a67c34276fb3f == "super_healing_aura" || var_e93a67c34276fb3f == "super_wiley_fox" )
        {
            params.player function_cf765afc7357fd63();
        }
    }
}

// Namespace zombie_loom_minion_web
// Params 1, eflags: 0x4
// Checksum 0xa4a4e27c, Offset: 0x72c
// Size: 0x31
function private function_cf765afc7357fd63( params )
{
    if ( is_entity_webbed( self ) && effect_slow::function_6fab6266b5f636c3( "loom_minion_webbed_projectile" ) )
    {
        effect_slow::function_80a4bd13b5ba303a( "loom_minion_webbed_projectile" );
    }
}

