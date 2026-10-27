// scripts\common\ai\aitypes\zombie_mimic\zombie_mimic.gsc  (hash_75a1a11e65df495a.gscc) (size: 18828 Bytes / 0x498c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec6a717c (3966398844)
// size ...... 18828 (0x498c)
// includes .. 17  (offset: 0x4330)
// strings ... 105 (offset: 0x43b8)
// dev strs .. 2   (offset: 0x4974)
// exports ... 45  (offset: 0x2834)
// cseg ...... 0x791 + 0x20a3 (0x2834)
// imports ... 163 (offset: 0x2f3c)
// animtree1 . 0   (offset: 0x498c)
// animtree2 . 0   (offset: 0x498c)
#using script_16ea1b94f0f381b3;
#using script_1bfe8e965532ee8a;
#using script_40510196b9a59795;
#using script_5133812eb5db429a;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_audio;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_mimic;

// Namespace zombie_mimic
// Params 2
// Checksum 0x8e3f037, Offset: 0x7af
// Size: 0xa2
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "player_grabbed_by_mimic_fx", settings.var_b25f3bcabe238bd8 );
        utility::add_fx( "player_bitten_by_mimic_fx", settings.var_3c526f9cc68fe4b4 );
        utility::add_fx( "player_hit_by_mimic_ranged_attack_fx", settings.var_b2c1e3de26fca6ef );
        
        if ( settings.weakpointvfx )
        {
            utility::add_fx( "mimic_weakspot_impact_fx", settings.weakpointvfx );
        }
    }
    
    zombie_mimic_prop_spawn::function_2ff4d4f70bcc117c( aitypescriptbundle );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xb5de11fc, Offset: 0x859
// Size: 0x25e
function private function_605e0a8069ae6367( params )
{
    zombie_mimic_audio::init_zombie_mimic_audio_global();
    zombie_melee::init_zombie_melee_global();
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_d5250e7181797cd0 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( #"on_ai_killed", &function_8aa77779eb1a5e0b );
    callback::get_template( self.animsetname ) callback::add( "on_entity_revealed", &function_c324319cb0998b2a );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_2802303eac82dd24 );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_f31324b865459466 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee_pre", &function_228e8912965dd65f );
}

// Namespace zombie_mimic
// Params 1
// Checksum 0xa86ab847, Offset: 0xabf
// Size: 0x1e0
function function_8b0cbc74310f3dab( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_605e0a8069ae6367 );
    self.allowpain = 0;
    self.var_f579b144d4fc9343 = 0;
    self.grab_dist_sq = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.grabattackdistance );
    self.var_5fe4d069d4c73e7c = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.grabattackdamage * ( self.var_fe048a2106d8ef00[ #"grab_damage" ] ?? 1 );
    self.grab_cooldown_ms = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3daf0e351ab38c71 * 1000;
    self.var_56bfff892004a1af = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_27fe4da3d0d73b63;
    self.var_75a5a99c161237dc = tan( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b127ae6083ddef23 );
    self.grab_screen_fx = "player_grabbed_by_mimic_fx";
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 100 );
    zombie_melee::function_2cc3729a3cdeadbf( "run", 120 );
    callback::add( "on_zombie_ai_spawned", &function_67c29d368b137cf9 );
    callback::add( "on_entity_hidden_in_prop", &function_f600831f6db0c4de );
    zombie_melee::init_zombie_melee();
    init_zombie_mimic_ranged_attack( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f96fdf1a5c1afe1d );
    zombie_mimic_audio::init_zombie_mimic_audio();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_mimic
// Params 0, eflags: 0x4
// Checksum 0xcedd7795, Offset: 0xca8
// Size: 0x51
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    utility::function_32b24db3127bff40( "mouth", "mouth_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x849da56, Offset: 0xd01
// Size: 0x47
function private function_8aa77779eb1a5e0b( params )
{
    if ( isplayer( params.eattacker ) && !self.has_grabbed_player )
    {
        params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"mimic_swindled" );
    }
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x7e53b048, Offset: 0xd50
// Size: 0xb5
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        if ( utility::ent_flag( "locust_ww_burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
        }
        else if ( utility::ent_flag( "locust_ww_burned_pap" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
        }
        
        body utility::function_32b24db3127bff40( "gib_head", "gibbed" );
        wait 1.5;
        body = zombie_utils::function_4e99fb1239980783( params );
        
        if ( isdefined( body ) )
        {
            body hide();
        }
        
        wait 1;
        body = zombie_utils::function_4e99fb1239980783( params );
        
        if ( isdefined( body ) )
        {
            body delete();
        }
    }
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x82f8c9e1, Offset: 0xe0d
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x15696e51, Offset: 0xe32
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xe5464d7d, Offset: 0xe57
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xd8062f7d, Offset: 0xe7c
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x1e349ebe, Offset: 0xead
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xa29bc115, Offset: 0xed2
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x535cc244, Offset: 0xf03
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x40aae94a, Offset: 0xf4a
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xaa8a62ff, Offset: 0xf91
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xcc63cf5f, Offset: 0xfb6
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xd3b46599, Offset: 0xfdb
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x46a7dc66, Offset: 0x1000
// Size: 0x64
function private function_2802303eac82dd24( attacker )
{
    self.var_2dfd8b4c56744f49 = 1;
    self.var_cab75db7e9e5b64c = self.maxhealth * 0.2;
    zombie_utils::function_a8ce00e0448cb6f0( "run", "turned", 26 );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    utility::function_32b24db3127bff40( "mouth", "mouth_turned" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x1edf954f, Offset: 0x106c
// Size: 0x1d
function private function_f31324b865459466( params )
{
    utility::function_32b24db3127bff40( "mouth", "mouth_on" );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x71c05564, Offset: 0x1091
// Size: 0x56
function private function_d5250e7181797cd0( params )
{
    if ( params.metabonename == "weakspot_mouth" )
    {
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.weakpointvfx )
        {
            playfxontag( utility::getfx( "mimic_weakspot_impact_fx" ), self, "tag_weakpoint_mouth" );
        }
    }
}

// Namespace zombie_mimic
// Params 1
// Checksum 0x8c7a7cb4, Offset: 0x10ef
// Size: 0xa9
function function_228e8912965dd65f( params )
{
    var_5ddea964f429e3cf = params.meleetarget;
    n_damage = self.var_cab75db7e9e5b64c ?? params.meleedamage;
    
    if ( isai( var_5ddea964f429e3cf ) && n_damage >= var_5ddea964f429e3cf.health )
    {
        var_5ddea964f429e3cf.ragdollimpactvector = ( anglestoforward( self.angles ) + ( 0, 0, 0.4 ) ) * 6000;
        var_5ddea964f429e3cf.ragdollhitloc = "torso_lower";
        var_5ddea964f429e3cf.do_immediate_ragdoll = 1;
    }
}

// Namespace zombie_mimic
// Params 2
// Checksum 0xb0defd3c, Offset: 0x11a0
// Size: 0x4a
function function_f3f333a97d05526f( taskid, params )
{
    if ( !isdefined( self.var_82209d06b3fad29d ) || !self.var_82209d06b3fad29d.size )
    {
        zombie_mimic_prop_spawn::function_3d3b310d86c29df7( self );
    }
    
    namespace_3f4302086f947316::function_47a568ea856f2a8e();
    return anim.success;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0x640bcd7c, Offset: 0x11f3
// Size: 0x3b
function function_345b519ddc376e4( taskid, params )
{
    if ( asm::asm_ephemeraleventfired( "finish_hide", "end" ) )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0xce177ac, Offset: 0x1237
// Size: 0x24
function function_e8e4d11ba280454( taskid, params )
{
    zombie_mimic_hide();
    zombie_mimic_prop_spawn::function_e51a7d37ed94f968( self );
}

// Namespace zombie_mimic
// Params 0
// Checksum 0x10375968, Offset: 0x1263
// Size: 0x55, Type: bool
function function_fd0636371f71d2e6()
{
    if ( level.var_67625bb718718d94 && !self.var_2dfd8b4c56744f49 && !self.hidden_in_prop && ( isdefined( self.var_82209d06b3fad29d ) || zombie_mimic_prop_spawn::can_spawn_props( 1 ) ) )
    {
        self function_786bb6aa1b76c7ee( "should_hide", 1 );
        return true;
    }
    
    return false;
}

// Namespace zombie_mimic
// Params 0
// Checksum 0x89cc27a8, Offset: 0x12c1
// Size: 0x10d
function zombie_mimic_hide()
{
    if ( self.hidden_in_prop )
    {
        return;
    }
    
    self function_786bb6aa1b76c7ee( "should_hide", 0 );
    
    if ( isdefined( self.var_82209d06b3fad29d ) )
    {
        self.var_82209d06b3fad29d = function_5713d46873b29625( self.var_82209d06b3fad29d );
    }
    
    props = self.var_82209d06b3fad29d;
    var_b1f3dccf5a1b9bb7 = self.var_b1f3dccf5a1b9bb7;
    should_spawn_prop = !isdefined( var_b1f3dccf5a1b9bb7 );
    
    if ( isdefined( var_b1f3dccf5a1b9bb7 ) && isdefined( var_b1f3dccf5a1b9bb7.var_c47c1baf88389769 ) )
    {
        level thread zombie_mimic_prop_spawn::function_c727c09ec08aed83( var_b1f3dccf5a1b9bb7 );
        props = arrayremove( props, var_b1f3dccf5a1b9bb7 );
        var_b1f3dccf5a1b9bb7 = undefined;
        should_spawn_prop = props.size == 0;
    }
    
    if ( should_spawn_prop && zombie_mimic_prop_spawn::can_spawn_props( 1, self ) )
    {
        zombie_mimic_prop_spawn::function_c6b4aadecefb2d63( self.origin, self, undefined, self.spawn_prop_count );
        return;
    }
    
    if ( isdefined( var_b1f3dccf5a1b9bb7 ) )
    {
        var_b1f3dccf5a1b9bb7.origin = self.origin;
    }
    else if ( isdefined( props ) )
    {
        var_b1f3dccf5a1b9bb7 = props[ 0 ];
    }
    else
    {
        return;
    }
    
    zombie_mimic_prop_spawn::function_c9f4c7f5803b1ce5( props, self, var_b1f3dccf5a1b9bb7 );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x63e4b3cf, Offset: 0x13d6
// Size: 0x63
function private function_67c29d368b137cf9( params )
{
    callback::callback( "mimic_spawned" );
    self endon( #"death" );
    waitframe();
    
    if ( level.var_67625bb718718d94 && !self.hidden_in_prop && self.var_e1994f7442414a09 )
    {
        zombie_mimic_prop_spawn::function_3d3b310d86c29df7( self );
        zombie_mimic_hide();
        zombie_mimic_prop_spawn::function_e51a7d37ed94f968( self );
    }
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x41b8e9d0, Offset: 0x1441
// Size: 0x6a
function private function_f600831f6db0c4de( prop )
{
    self clearpath();
    self function_786bb6aa1b76c7ee( "hidden_in_prop", 1 );
    val::set( "mimic", "hide", 1 );
    val::set( "mimic", "ignore_cleanup", 1 );
    val::set( "mimic", "damage", 0 );
    val::set( "mimic", "ignoreme", 1 );
}

// Namespace zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x1a84ad9f, Offset: 0x14b3
// Size: 0x247
function private function_c324319cb0998b2a( params )
{
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "hidden_in_prop", 0 );
    var_d29aafaaeff765cd = utility::array_random( params.var_ea8a8c50c7c7f096 );
    self.favoriteenemy = var_d29aafaaeff765cd;
    prop = self.var_b1f3dccf5a1b9bb7;
    angles = prop.angles ?? self.angles;
    origin = prop.origin ?? self.origin;
    activator = undefined;
    
    if ( isdefined( params.var_ea8a8c50c7c7f096 ) && isent( params.var_ea8a8c50c7c7f096[ 0 ] ) )
    {
        activator = params.var_ea8a8c50c7c7f096[ 0 ];
        angles = vectortoangles( activator.origin - origin );
    }
    
    playfx( utility::getfx( "mimic_prop_emerge_fx" ), origin, anglestoforward( angles ) );
    self forceteleport( origin, angles, 10000, 1 );
    wait 0.5;
    val::reset_all( "mimic" );
    self setsolid( 1 );
    self.hidden_in_prop = undefined;
    dist_sq = 0;
    
    if ( isdefined( activator ) )
    {
        dist_sq = distancesquared( activator.origin, self.origin );
    }
    
    if ( isplayer( activator ) && dist_sq < self.grab_dist_sq && activator val::get( "allow_grab" ) && !function_4c376f4e2258a53( self gettagorigin( "j_spine4" ), self.angles ) && self tagexists( "tag_player" ) )
    {
        thread mimic_emerge_grab( activator );
    }
    else
    {
        animname = "emerge";
        
        if ( dist_sq > squared( 200 ) )
        {
            if ( isdefined( activator ) )
            {
                mimic_centroid = self getcentroid();
                end_point = mimic_centroid + vectornormalize( activator getcentroid() - mimic_centroid ) * 200;
                
                if ( trace::ray_trace_passed( mimic_centroid, end_point, undefined, trace::create_default_contents( 1 ) ) )
                {
                    animname = "emerge_sprint";
                }
            }
        }
        
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( animname, animname, origin, angles );
    }
    
    function_ed482d425e7163d1();
}

// Namespace zombie_mimic
// Params 0
// Checksum 0x715a422f, Offset: 0x1702
// Size: 0xb1
function function_ed482d425e7163d1()
{
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, 200 );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player utility::knockback_flat( player.origin - self.origin, 400 );
    }
}

// Namespace zombie_mimic
// Params 1
// Checksum 0x1e19fb89, Offset: 0x17bb
// Size: 0xa4
function init_zombie_mimic_ranged_attack( var_1c8f88e35704cf91 )
{
    thread function_c1583b59d9b9ef64();
    
    if ( var_1c8f88e35704cf91 )
    {
        thread function_c4dfb86154d91b24();
    }
    
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
}

// Namespace zombie_mimic
// Params 0, eflags: 0x4
// Checksum 0xb1936520, Offset: 0x1867
// Size: 0x3c
function private function_c1583b59d9b9ef64()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        self.ranged_attack_target = self.enemy;
        namespace_ad26fae8b8e8dfb9::function_8b1372bc3a2d158e();
    }
}

// Namespace zombie_mimic
// Params 0, eflags: 0x4
// Checksum 0x817afd6f, Offset: 0x18ab
// Size: 0x1c4
function private function_c4dfb86154d91b24()
{
    self endon( #"death" );
    self.var_78171ffded5f0cf1 = 0;
    
    while ( true )
    {
        wait 0.5;
        
        if ( self.hidden_in_prop || !isdefined( self.enemy ) || isdefined( self.target_attractor ) )
        {
            continue;
        }
        
        if ( self.var_78171ffded5f0cf1 > gettime() || distancesquared( self.enemy.origin, self.origin ) < 90000 )
        {
            continue;
        }
        
        if ( !function_cec1a4b7de22b436( self.enemy, 15 ) )
        {
            continue;
        }
        
        var_2fe5a7fc8f3b7a0 = [ self.enemy ];
        var_62014cf6653d5664 = physics_querypoint( self.enemy.origin, 500, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self, self.enemy ], "physicsquery_all" );
        
        foreach ( potential_target in var_62014cf6653d5664 )
        {
            target_ent = potential_target[ "entity" ];
            
            if ( function_cec1a4b7de22b436( target_ent, 60 ) )
            {
                var_2fe5a7fc8f3b7a0[ var_2fe5a7fc8f3b7a0.size ] = target_ent;
            }
        }
        
        self.ranged_attack_target = self.enemy;
        namespace_ad26fae8b8e8dfb9::function_8b1372bc3a2d158e( var_2fe5a7fc8f3b7a0 );
        self.var_78171ffded5f0cf1 = gettime() + 10000;
    }
}

// Namespace zombie_mimic
// Params 2, eflags: 0x4
// Checksum 0xbe3db511, Offset: 0x1a77
// Size: 0xdd, Type: bool
function private function_cec1a4b7de22b436( var_e1b150b361aa0993, var_e31e02e087ee15be )
{
    if ( !isalive( var_e1b150b361aa0993 ) || self.team == var_e1b150b361aa0993.team )
    {
        return false;
    }
    
    if ( distancesquared( var_e1b150b361aa0993.origin, self.origin ) > 2000000 )
    {
        return false;
    }
    
    yaw_to_target = vectortoyaw( var_e1b150b361aa0993.origin - self.origin );
    
    if ( absangleclamp180( self.angles[ 1 ] - yaw_to_target ) > var_e31e02e087ee15be )
    {
        return false;
    }
    
    pitch_to_target = vectortopitch( var_e1b150b361aa0993.origin - self.origin );
    
    if ( absangleclamp180( pitch_to_target ) > 50 )
    {
        return false;
    }
    
    if ( !self cansee( var_e1b150b361aa0993 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0x59497ae2, Offset: 0x1b5d
// Size: 0x19f, Type: bool
function function_4c376f4e2258a53( origin, angles )
{
    v_forward = anglestoforward( angles );
    end_origin = origin + v_forward * 202;
    ignore_ents = arraycombine( level.players, [ self ] );
    contents = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    b_passed = trace::sphere_trace_passed( origin, end_origin, 30, ignore_ents, contents );
    
    /#
        if ( getdvarint( @"hash_e71f45f0a0cebdbe", 0 ) )
        {
            debugstar( end_origin, ( 1, 0, 1 ), 40 );
            line( origin, end_origin, ( 1, 0, 1 ), 1, 1, 40 );
            
            if ( !b_passed )
            {
                print3d( end_origin, "<dev string:x24>", ( 1, 0, 0 ), 1, 1, 40 );
            }
        }
    #/
    
    if ( !b_passed )
    {
        return true;
    }
    
    toss_end_pos = origin + vectornormalize( ( v_forward[ 0 ], v_forward[ 1 ], self.var_75a5a99c161237dc ) ) * 80;
    b_passed = trace::sphere_trace_passed( origin, toss_end_pos, 30, ignore_ents, contents );
    
    /#
        if ( getdvarint( @"hash_e71f45f0a0cebdbe", 0 ) )
        {
            debugstar( toss_end_pos, ( 1, 0, 1 ), 40 );
            line( origin, toss_end_pos, ( 1, 0, 1 ), 1, 1, 40 );
            
            if ( !b_passed )
            {
                print3d( toss_end_pos, "<dev string:x3d>", ( 1, 0, 0 ), 1, 1, 40 );
            }
        }
    #/
    
    return !b_passed;
}

// Namespace zombie_mimic
// Params 1
// Checksum 0xbc3b9a7e, Offset: 0x1d05
// Size: 0x13e
function mimic_emerge_grab( player )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "emerge_attack", "emerge_attack", self.origin, self.angles, "mimic_emerge_grab" );
    utility::ent_flag_waitopen_any( "mimic_emerge_grab" );
    
    if ( isalive( player ) && distancesquared( self.origin, player.origin ) < self.grab_dist_sq && absangleclamp180( vectortoyaw( player.origin - self.origin ) - self.angles[ 1 ] ) < 30 )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "emerge_attack_hit", "emerge_attack_hit", self.origin, self.angles, "grab_end" );
        player thread function_78ed5da600a0065f( "ai_jup_zm_mimic_com_emerge_prop_atk_bite_f_01_hit_player", self, self.origin, self.angles );
    }
    else
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "emerge_attack_miss", "emerge_attack_miss", self.origin, self.angles );
    }
    
    self.var_f579b144d4fc9343 = gettime() + self.grab_cooldown_ms;
}

// Namespace zombie_mimic
// Params 4
// Checksum 0xd79cfc1f, Offset: 0x1e4b
// Size: 0x393
function function_78ed5da600a0065f( var_889fcdcdb5def3cd, mimic, origin, angles )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_5acd2f6fd6c4c28b = utility::spawn_model( "tag_origin", mimic gettagorigin( "tag_player" ), mimic gettagangles( "tag_player" ) );
    var_5acd2f6fd6c4c28b linkto( mimic, "tag_player", ( 0, 0, -40 ), ( 0, 0, 0 ) );
    thread utility::delete_on_death( var_5acd2f6fd6c4c28b );
    mimic thread utility::delete_on_death( var_5acd2f6fd6c4c28b );
    params = spawnstruct();
    params.attacker = mimic;
    callback::callback( "on_mimic_player_grab_start", params );
    val::set( "ai_mimic_grab", "ignoreme", 1 );
    val::set( "ai_mimic_grab", "freezecontrols", 1 );
    val::set( "ai_mimic_grab", "armor", 0 );
    val::set( "ai_mimic_grab", "killstreaks", 0 );
    val::set( "ai_mimic_grab", "weapon", 0 );
    mimic.var_8cb3c9f5176399ed = self;
    mimic.has_grabbed_player = 1;
    self setstance( "stand", 1, 1 );
    
    if ( self.insertingarmorplate )
    {
        self notify( #"try_armor_cancel", "mimic_grab" );
    }
    
    if ( self.revivingteammate )
    {
        self.var_3ded14e19d81ef7e = 1;
    }
    
    if ( !self islinked() )
    {
        self setvelocity( ( 0, 0, 0 ) );
        self playerlinktoblend( var_5acd2f6fd6c4c28b, "tag_origin", 0.3, 0.1, 0.05 );
    }
    
    if ( !self getcamerathirdperson() && isdefined( mimic.grab_screen_fx ) )
    {
        playfxontagforclients( utility::getfx( mimic.grab_screen_fx ), self, "j_head", self );
    }
    
    if ( isnullweapon( self gethighpriorityweapon() ) )
    {
        self playviewmodelanim( var_889fcdcdb5def3cd, 1 );
    }
    
    waitframe();
    
    if ( isalive( mimic ) && mimic getaiblackboarddynamic( "in_grab_attack" ) )
    {
        mimic thread utility::function_31522db4303bffeb( "mimic_bite", "grab_end", &function_8ecb9bb35e82388e );
        b_ended = mimic utility::function_31522db4303bffeb( "mimic_throw", "grab_end" );
    }
    else
    {
        b_ended = 1;
    }
    
    if ( isdefined( self ) )
    {
        if ( self isviewmodelanimplaying() )
        {
            self stopviewmodelanim();
        }
        
        if ( self islinked() && self getlinkedparent() === var_5acd2f6fd6c4c28b )
        {
            self unlink();
            var_1ea4bfa2bd61a698 = 1;
        }
        
        callback::callback( "on_mimic_player_grab_end", params );
        
        if ( isalive( mimic ) && b_ended )
        {
            mimic.var_8cb3c9f5176399ed = undefined;
            
            if ( var_1ea4bfa2bd61a698 )
            {
                var_c51215b779b5fe59 = vectornormalize2( self.origin - mimic.origin );
                self setorigin( self.origin + ( 0, 0, 5 ) );
                self knockback( ( var_c51215b779b5fe59[ 0 ], var_c51215b779b5fe59[ 1 ], mimic.var_75a5a99c161237dc ), mimic.var_56bfff892004a1af );
                mimic notify( #"vox_pushback_scream" );
                thread function_f8ef3671ec42ae8b();
            }
        }
        
        if ( var_1ea4bfa2bd61a698 )
        {
            self earthquakeforplayer( 0.5, 0.8, self.origin, 500 );
            utility::delaythread( 0.5, &val::reset_all, "ai_mimic_grab" );
        }
        else
        {
            val::reset_all( "ai_mimic_grab" );
        }
    }
    
    if ( isdefined( var_5acd2f6fd6c4c28b ) )
    {
        var_5acd2f6fd6c4c28b delete();
    }
}

// Namespace zombie_mimic
// Params 0
// Checksum 0xe676e550, Offset: 0x21e6
// Size: 0xf3
function function_f8ef3671ec42ae8b()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 0.1;
        a_zombies = getaiarrayinradius( self.origin, 64 );
        
        foreach ( zombie in a_zombies )
        {
            if ( zombie.aicategory == "normal" && !zombie zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
            }
        }
        
        if ( self isonground() )
        {
            stealtheventbroadcastsimple( "custom", self, self.origin, 500 );
            break;
        }
    }
}

// Namespace zombie_mimic
// Params 0
// Checksum 0xa1b87876, Offset: 0x22e1
// Size: 0x97
function function_8ecb9bb35e82388e()
{
    if ( isplayer( self.var_8cb3c9f5176399ed ) )
    {
        playfxontagforclients( utility::getfx( "player_bitten_by_mimic_fx" ), self.var_8cb3c9f5176399ed, "j_head", self.var_8cb3c9f5176399ed );
        self.var_8cb3c9f5176399ed dodamage( self.var_5fe4d069d4c73e7c, self.origin, self, self, "MOD_MELEE", self.weapon );
        self.var_8cb3c9f5176399ed earthquakeforplayer( 0.5, 0.8, self.var_8cb3c9f5176399ed.origin, 500 );
    }
}

// Namespace zombie_mimic
// Params 0
// Checksum 0x42489d, Offset: 0x2380
// Size: 0x20d, Type: bool
function function_9d4d2460cec1603e()
{
    if ( !self tagexists( "tag_player" ) )
    {
        return false;
    }
    
    player = function_47c86977a18df38b( level.players, self gettagorigin( "tag_player" ) );
    
    if ( isalive( player ) && !isdefined( player.vehicle ) && player val::get( "allow_grab" ) && !player.inlaststand && !killstreak_shared::isremotekillstreakweapon( player getcurrentweapon() ) && distancesquared( self.origin, player.origin ) < self.grab_dist_sq && absangleclamp180( vectortoyaw( player.origin - self.origin ) - self.angles[ 1 ] ) < 30 && abs( self.origin[ 2 ] - player.origin[ 2 ] ) < 64 )
    {
        content = [ "physicscontents_playerclip", "physicscontents_aiclip" ];
        var_7d3632b7dcf723d0 = physics_createcontents( content );
        grab_destination = self.origin + 64 * anglestoforward( self.angles ) + ( 0, 0, 16 );
        trace_result = trace::capsule_get_closest_point( grab_destination, 16, 72, undefined, 0, [ self, player ], var_7d3632b7dcf723d0 );
        trace_passed = trace_result[ "hittype" ] == "hittype_none";
        
        /#
            if ( getdvarint( @"hash_e71f45f0a0cebdbe", 0 ) )
            {
                utility::draw_capsule( grab_destination, 16, 72, undefined, trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 300 );
            }
        #/
        
        if ( trace_passed )
        {
            player thread function_78ed5da600a0065f( "ai_jup_zm_mimic_com_stn_atk_grab_01_hit_player", self, self.origin, self.angles );
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0xab19184c, Offset: 0x2596
// Size: 0x10d, Type: bool
function function_b07996844a45accd( taskid, params )
{
    curr_time = gettime();
    
    if ( self.var_f579b144d4fc9343 > curr_time || level.var_fa5af4b8fd716cf5 > curr_time || effect_slow::function_6fab6266b5f636c3() )
    {
        return false;
    }
    
    if ( !isplayer( self.enemy ) || distancesquared( self.enemy.origin, self.origin ) > squared( 130 ) )
    {
        return false;
    }
    
    if ( !self tagexists( "tag_player" ) )
    {
        return false;
    }
    
    if ( !self.enemy val::get( "allow_grab" ) )
    {
        return false;
    }
    
    if ( isdefined( self.valid_player_condition ) && ![[ self.valid_player_condition ]]( self.enemy ) )
    {
        return false;
    }
    
    if ( function_4c376f4e2258a53( self.origin + ( 0, 0, 40 ), self.angles ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0x4a7e4ef, Offset: 0x26ac
// Size: 0x9f
function function_422d24b630d8e5( taskid, params )
{
    self notify( #"vox_interrupt_amb_3" );
    namespace_c0ac77745b091869::function_acf2298db14eb020();
    var_aead62e4adde9ac3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_94ba1a44137cba42;
    
    if ( var_aead62e4adde9ac3 > 0 )
    {
        var_fa5af4b8fd716cf5 = gettime() + var_aead62e4adde9ac3 * 1000;
        
        if ( !isdefined( level.var_fa5af4b8fd716cf5 ) || var_fa5af4b8fd716cf5 > level.var_fa5af4b8fd716cf5 )
        {
            level.var_fa5af4b8fd716cf5 = var_fa5af4b8fd716cf5;
        }
    }
    
    return anim.success;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0x997f2f, Offset: 0x2754
// Size: 0x37
function function_cc28d59a7a51b23e( taskid, params )
{
    if ( self getaiblackboarddynamic( "in_grab_attack" ) <= 0 )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_mimic
// Params 2
// Checksum 0x57e43673, Offset: 0x2794
// Size: 0xa0
function function_3bb6a0135cb7d4ca( taskid, params )
{
    self.var_f579b144d4fc9343 = gettime() + self.grab_cooldown_ms;
    var_aead62e4adde9ac3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_94ba1a44137cba42;
    
    if ( var_aead62e4adde9ac3 > 0 )
    {
        var_fa5af4b8fd716cf5 = gettime() + var_aead62e4adde9ac3 * 1000;
        
        if ( !isdefined( level.var_fa5af4b8fd716cf5 ) || var_fa5af4b8fd716cf5 > level.var_fa5af4b8fd716cf5 )
        {
            level.var_fa5af4b8fd716cf5 = var_fa5af4b8fd716cf5;
        }
    }
    
    self clearpath();
}

