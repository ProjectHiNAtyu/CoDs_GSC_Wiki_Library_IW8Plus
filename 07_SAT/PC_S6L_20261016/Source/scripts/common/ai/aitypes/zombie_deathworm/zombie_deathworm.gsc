// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm.gsc  (hash_34b3e395138f536a.gscc) (size: 6532 Bytes / 0x1984 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7cb64a29 (2092321321)
// size ...... 6532 (0x1984)
// includes .. 11  (offset: 0x17f0)
// strings ... 23  (offset: 0x1848)
// dev strs .. 0   (offset: 0x1984)
// exports ... 14  (offset: 0xedc)
// cseg ...... 0x212 + 0xcca (0xedc)
// imports ... 60  (offset: 0x110c)
// animtree1 . 0   (offset: 0x1984)
// animtree2 . 0   (offset: 0x1984)
#using script_16ea1b94f0f381b3;
#using script_200c1cd00f9ab885;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_audio;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_metabones;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_deathworm;

// Namespace zombie_deathworm
// Params 2
// Checksum 0x5fbc3940, Offset: 0x230
// Size: 0x67
function precache( classname, aitypescriptbundle )
{
    zombie_deathworm_asm::init_asm_precache( aitypescriptbundle );
    init_arena_precache( aitypescriptbundle );
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) && isdefined( settings.var_6c45690b19bc070f ) )
    {
        utility::add_fx( "deathworm_weakpoint_hit_vfx", settings.var_6c45690b19bc070f );
    }
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0x2d7d940c, Offset: 0x29f
// Size: 0x5a
function private function_5dcf3bb8aa3149be( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_dc190a42f74d9fd1 );
    zombie_deathworm_audio::function_2f6d38d0a0c29f62();
}

// Namespace zombie_deathworm
// Params 1
// Checksum 0x833f5169, Offset: 0x301
// Size: 0x158
function function_e87e7eda93105917( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_5dcf3bb8aa3149be );
    init_metabones();
    function_b99d9c9e039f92b0();
    zombie_utils::function_dfae6a5bd222c586( &function_630fcd45503541d8 );
    self.disable_brain_rot = 1;
    self.allowfriendlyfire = 1;
    self.b_ignore_death_perception = 1;
    utility::ent_flag_set( "snapshot_immunity" );
    self.var_24610c747736231e = &function_3a175c6c4a431ffe;
    self.var_3c8a8a999d3d0d2e = &function_b0b1528111da4e4e;
    self.var_6005157a6615b97f = function_3a175c6c4a431ffe();
    self.nearby_player_strong = function_7dde906adbe06b22();
    self.worm_spawn_time = gettime();
    val::set( "deathworm_no_instakill", "damageshield", 1 );
    self.use_lethal_attacks = self.subclass == "zombie_deathworm_boss";
    thread initscriptable();
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.bosshealthbar != "" )
    {
        thread manage_health_bar();
    }
    
    zombie_deathworm_audio::init_zombie_deathworm_audio();
    return anim.success;
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0x5ebab091, Offset: 0x462
// Size: 0x122
function private manage_health_bar()
{
    self endon( #"death" );
    wait 4;
    
    while ( self.health > 0 )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( distance2dsquared( self.origin, player.origin ) < 256000000 )
                {
                    if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.bosshealthbar ) )
                    {
                        player zombie_boss_healthbar::zombie_boss_healthbar_show( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.bosshealthbar, self );
                    }
                }
                else
                {
                    player zombie_boss_healthbar::zombie_boss_healthbar_hide();
                }
                
                continue;
            }
            
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        }
        
        wait 2;
    }
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0xfb4d15c3, Offset: 0x58c
// Size: 0x159
function private function_dc190a42f74d9fd1( sparams )
{
    if ( !isdefined( self.var_7b08611efca506f7 ) )
    {
        self.var_7b08611efca506f7 = [];
    }
    
    var_e31c53eb403a02dd = undefined;
    
    foreach ( struct in self.var_7b08611efca506f7 )
    {
        if ( isdefined( struct ) && struct.player == self )
        {
            var_e31c53eb403a02dd = struct;
            break;
        }
    }
    
    if ( !isdefined( var_e31c53eb403a02dd ) )
    {
        var_e31c53eb403a02dd = { #damage:0, #player:self };
        self.var_7b08611efca506f7[ self.var_7b08611efca506f7.size ] = var_e31c53eb403a02dd;
    }
    
    var_e31c53eb403a02dd.damage += sparams.idamage;
    
    if ( self.health <= 10 )
    {
        val::reset_all( "deathworm_no_instakill" );
    }
    
    if ( sparams.biscritical )
    {
        utility::function_7c10ea82c1e305b8( sparams.metabonename + "_impact", "weakpoint_impact" );
    }
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0x7824d154, Offset: 0x6ed
// Size: 0x40
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0xd4381765, Offset: 0x735
// Size: 0x2ae
function private play_death_fx( params )
{
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    if ( !isplayer( params.eattacker ) || params.idamage > self.maxhealth * 0.5 )
    {
        weaponname = isdefined( params.sweapon ) ? params.sweapon.basename : "";
        damage = isdefined( params.idamage ) ? string( params.idamage ) : "";
        entitynum = isdefined( params.eattacker ) ? string( params.eattacker getentitynumber() ) : "";
        classname = isdefined( params.eattacker ) && isdefined( params.eattacker.classname ) ? params.eattacker.classname : "";
        error_msg = "Deathworm slain incorrectly. Weapon: " + weaponname + " - Damage: " + damage + " - EntNum: " + entitynum + " - class: " + classname;
        assertmsg( error_msg );
        logstring( error_msg );
    }
    
    if ( isdefined( params.body ) )
    {
        params.body utility::function_32b24db3127bff40( "base", "off" );
        function_40598c4a26d847b9( params.body );
        params.body forcenetfieldhighlod( 1 );
        params.body function_dd258a3da9a2b4a1( 10 );
        params.body waittill( #"death_hide" );
        params.body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
        params.body setscriptablepartstate( "ambient_audio", "off" );
        wait 5;
        
        if ( isdefined( params.body ) )
        {
            params.body delete();
        }
    }
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0xfa3d6c26, Offset: 0x9eb
// Size: 0x294
function private function_630fcd45503541d8( params )
{
    var_80f5046785df08ac = 0.1;
    
    if ( isexplosivedamagemod( params.smeansofdeath ) )
    {
        var_80f5046785df08ac = 0.2;
    }
    
    val::set( "deathworm_no_instakill_but_allow_damage", "damageshield", 0 );
    thread function_8bfa3a7a5236a239();
    var_5f22a9e6fc2b6df5 = 0.002;
    var_254881114c351b9c = 0.1;
    params.var_ff33243f5be1fe3b = min( var_254881114c351b9c, params.var_ff33243f5be1fe3b );
    
    if ( function_a943c725a8657266( params ) )
    {
        return ( params.idamage * var_80f5046785df08ac );
    }
    
    damage = params.idamage;
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_175d51dac2e4e6d3 && self.var_6005157a6615b97f > 1 )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
        {
            var_951c89546ec50477 = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
            
            if ( var_951c89546ec50477 >= 3 )
            {
                damage *= 0.6;
            }
        }
    }
    
    if ( self.nearby_player_strong || self.use_lethal_attacks )
    {
        if ( self.var_6005157a6615b97f < 4 )
        {
            if ( !utility::time_has_passed( self.worm_spawn_time, 180 ) )
            {
                damage *= 0.6;
            }
        }
        else if ( !utility::time_has_passed( self.worm_spawn_time, 300 ) )
        {
            if ( self.var_6005157a6615b97f >= 4 && self.var_6005157a6615b97f < 7 )
            {
                damage *= 0.4;
            }
            else if ( self.var_6005157a6615b97f >= 7 && self.var_6005157a6615b97f < 13 )
            {
                damage *= 0.3;
            }
            else if ( self.var_6005157a6615b97f >= 13 && self.var_6005157a6615b97f < 19 )
            {
                damage *= 0.2;
            }
            else if ( self.var_6005157a6615b97f >= 19 )
            {
                damage *= 0.15;
            }
        }
    }
    
    if ( damage > self.maxhealth * var_5f22a9e6fc2b6df5 )
    {
        damage = ( damage - self.maxhealth * var_5f22a9e6fc2b6df5 ) * 0.3 + self.maxhealth * var_5f22a9e6fc2b6df5;
    }
    
    return damage;
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0xda046983, Offset: 0xc88
// Size: 0x1b
function private function_8bfa3a7a5236a239()
{
    self endon( #"death" );
    waittillframeend();
    val::reset_all( "deathworm_no_instakill_but_allow_damage" );
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0xe9efb29d, Offset: 0xcab
// Size: 0x20, Type: bool
function private function_a943c725a8657266( var_e31c53eb403a02dd )
{
    if ( !isdefined( var_e31c53eb403a02dd.metabonename ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0x74186d50, Offset: 0xcd4
// Size: 0x53
function function_3a175c6c4a431ffe()
{
    if ( getdvarint( @"hash_e7da760b9a7ca2c1", -1 ) > 0 )
    {
        return getdvarint( @"hash_e7da760b9a7ca2c1", -1 );
    }
    
    nearby_players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, 3000 );
    var_4912869f02b165bf = nearby_players.size;
    return var_4912869f02b165bf;
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0x66336870, Offset: 0xd30
// Size: 0xe6
function function_b0b1528111da4e4e()
{
    if ( getdvarint( @"hash_4ed7ea900c346cdb", -1 ) > 0 )
    {
        return getdvarint( @"hash_4ed7ea900c346cdb", -1 );
    }
    
    nearby_players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, 3000 );
    
    if ( nearby_players.size <= 0 )
    {
        return 1;
    }
    
    alive_count = 0;
    
    foreach ( player in nearby_players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            alive_count += 1;
        }
    }
    
    return alive_count / nearby_players.size;
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0xa9e16ee4, Offset: 0xe1f
// Size: 0xbc, Type: bool
function function_7dde906adbe06b22()
{
    foreach ( player in level.players )
    {
        objweapon = player getcurrentprimaryweapon();
        
        if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
        {
            var_951c89546ec50477 = player namespace_9d8e359c3b1041e5::function_1d4087075103b248( objweapon );
            
            if ( var_951c89546ec50477 >= 3 )
            {
                return true;
            }
        }
    }
    
    return false;
}

