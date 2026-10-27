// script_236edd51aea4c314  (hash_236edd51aea4c314.gscc) (size: 22413 Bytes / 0x578d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dfc54e9 (2113688809)
// size ...... 22413 (0x578d)
// includes .. 17  (offset: 0x519d)
// strings ... 75  (offset: 0x5225)
// dev strs .. 13  (offset: 0x56e5)
// exports ... 48  (offset: 0x36ed)
// cseg ...... 0x779 + 0x2f74 (0x36ed)
// imports ... 152 (offset: 0x3e6d)
// animtree1 . 0   (offset: 0x578d)
// animtree2 . 0   (offset: 0x578d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\hud_util;
#using scripts\mp\zm\zm_utility;

#namespace namespace_e625df044ece0a58;

// Namespace namespace_e625df044ece0a58
// Params 0, eflags: 0x5
// Checksum 0x285b1dc8, Offset: 0x797
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_22c103fa0779e1d", undefined, &pre_main, &post_main );
}

// Namespace namespace_e625df044ece0a58
// Params 0, eflags: 0x4
// Checksum 0x805d512c, Offset: 0x7bc
// Size: 0x2
function private pre_main()
{
    
}

// Namespace namespace_e625df044ece0a58
// Params 0, eflags: 0x4
// Checksum 0x40502e9d, Offset: 0x7c6
// Size: 0x3ce
function private post_main()
{
    locust_ww_name = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
    var_36afe086a5f9dc15 = utility::get_scripted_weapon_name( #"hash_11a70248f1a9f7bf" );
    assert( isdefined( locust_ww_name ) );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = locust_ww_name;
    
    if ( !isdefined( level.var_35e19e0af705d62e ) )
    {
        level.var_35e19e0af705d62e = [];
    }
    
    level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = locust_ww_name;
    
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = locust_ww_name;
    level callback::add( #"player_weapon_change", &locust_ww_on_weapon_change, locust_ww_name );
    level callback::add( #"on_ai_killed", &function_469d9f6327f3ca55 );
    level callback::add( "on_powerup_pickup", &function_bd201b7db51f6757 );
    level callback::add( #"hash_3e4093a7794b1a98", &function_d51da26af2e1168e );
    level callback::add( #"hash_2fc46531ebe36dde", &function_855be43f67b04cdd );
    level callback::add( #"hash_7f9d491bb0ff6a88", &function_6064a66aee501487 );
    scene::function_85b13b837056bc8b( &function_550fc240c7cabf5c );
    scene::function_53de0775d8452750( &function_44be397e3ccb151a );
    level.var_f7d8c385fccc43b4[ locust_ww_name ] = &function_2631fd6016e01143;
    level.var_f7d8c385fccc43b4[ var_36afe086a5f9dc15 ] = &function_2a2e34878c6c6595;
    utility::registersharedfunc( #"locust_ww", #"get_ww_charge", &function_a6be57da5326f349 );
    utility::registersharedfunc( #"locust_ww", #"hash_75515290edb3968f", &function_5c33f8896eb22787 );
    utility::registersharedfunc( #"locust_ww", #"hash_5f2e6769ea79096e", &function_efd685233b44b1a5 );
    utility::registersharedfunc( #"locust_ww", #"hash_5d3ddb2290527878", &locust_ww_has_weapon );
    level._effect[ "locust_ww_chain_blast_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_blast_strong_w" );
    level._effect[ "locust_ww_chain_blast_vfx_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_blast_strong_pap_w" );
    level._effect[ "locust_ww_on_hit_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact" );
    level._effect[ "locust_ww_on_hit_vfx_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact_pap" );
    level._effect[ "locust_ww_on_hit_left_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact_ri" );
    level._effect[ "locust_ww_on_hit_left_vfx_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact_ri_pap" );
    level._effect[ "locust_ww_on_hit_right_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact_le" );
    level._effect[ "locust_ww_on_hit_right_vfx_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_melee_impact_le_pap" );
    level._effect[ "locust_ww_tendril_fx" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_tether_beam" );
    level._effect[ "locust_ww_tendril_fx_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_tether_beam_pap" );
    level._effect[ "ww_locust_tendril_hit" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_tether_beam_buff_w" );
    level._effect[ "ww_locust_tendril_hit_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_locust_tether_beam_buff_pap_w" );
    level.var_80b41dd94cf5bb1b = [];
    level.var_80b41dd94cf5bb1b[ 1 ] = 2;
    level.var_80b41dd94cf5bb1b[ 2 ] = 4;
    level.var_80b41dd94cf5bb1b[ 3 ] = 8;
    level.var_80b41dd94cf5bb1b[ 4 ] = 12;
    level.var_fe14fee093e2f74e = [];
    level.var_fe14fee093e2f74e[ 0 ] = 1;
    level.var_fe14fee093e2f74e[ 1 ] = 2;
    level.var_fe14fee093e2f74e[ 2 ] = 3;
    level.var_fe14fee093e2f74e[ 3 ] = 4;
    level.var_fe14fee093e2f74e[ 4 ] = 5;
    
    /#
        debug_init();
    #/
}

// Namespace namespace_e625df044ece0a58
// Params 2
// Checksum 0xcbf43ab6, Offset: 0xb9c
// Size: 0x1a8
function locust_ww_on_weapon_change( params, weapon_name )
{
    if ( !isweapon( params.weapon ) )
    {
        return;
    }
    
    if ( params.weapon.basename == weapon_name )
    {
        if ( !function_a6be57da5326f349() )
        {
            function_1873ace2fc909565( 0 );
        }
        
        thread function_836659818eb54851();
        thread function_19f029f13b831941( params, weapon_name );
        thread function_771654199f99429e( params, weapon_name );
        thread function_db102f3e5a246206( params, weapon_name );
        thread function_b4befc185db69bc2( params, weapon_name );
        thread function_18a5cad72fa7ddbc( params, weapon_name );
        function_6bbdd2f7d72b2d60( self.locust_ww_charge );
        
        if ( !utility::ent_flag( "locust_ww_tutorial" ) )
        {
            utility::ent_flag_set( "locust_ww_tutorial" );
            thread ww_shared::show_hud_tutorial_message( &"zm_sat_locust/ww_tutorial_message", 15 );
        }
    }
    else
    {
        foreach ( player_ent_num, tendril in self.locust_ww_tendril )
        {
            tendril delete();
            self.locust_ww_tendril[ player_ent_num ] = undefined;
        }
        
        utility::function_32b24db3127bff40( "ww_locust_tether", "off" );
        utility::function_32b24db3127bff40( "ww_locust_charge", "off" );
        utility::function_32b24db3127bff40( "ww_locust_fireball_charge", "off" );
        self notify( #"hash_ab64622ff9844c59" );
    }
    
    self.var_dce7b5a89390451 = 0;
    self.var_7ef92b7af95f2256 = 0;
}

// Namespace namespace_e625df044ece0a58
// Params 2
// Checksum 0xb8be06df, Offset: 0xd4c
// Size: 0xa7
function function_18a5cad72fa7ddbc( params, weapon_name )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        prev_charge = self.locust_ww_charge;
        start_time = gettime();
        function_1873ace2fc909565( 0 );
        
        while ( self function_985124b0e1e74f2e() && gettime() < start_time + 4640 )
        {
            waitframe();
        }
        
        function_1873ace2fc909565( prev_charge + self.locust_ww_charge );
    }
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x4c90dc57, Offset: 0xdfb
// Size: 0xd7
function function_469d9f6327f3ca55( params )
{
    corpse = self getcorpseentity();
    
    if ( self.var_9fae86fa742c4263 && corpse )
    {
        stopfxontag( utility::getfx( "ww_locust_tendril_hit" ), corpse, "j_spine4" );
        stopfxontag( utility::getfx( "ww_locust_tendril_hit_pap" ), corpse, "j_spine4" );
    }
    
    locust_ww_name = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
    
    if ( isplayer( params.eattacker ) && params.sweapon.basename == locust_ww_name )
    {
        params.eattacker function_5c33f8896eb22787( 4 );
        
        /#
            iprintlnbold( "<dev string:x24>" + params.eattacker function_a6be57da5326f349() );
        #/
    }
}

// Namespace namespace_e625df044ece0a58
// Params 0, eflags: 0xc
// Checksum 0xe7250836, Offset: 0xeda
// Size: 0x141
function private function_836659818eb54851()
{
    self notify( #"hash_58510925285657e3" );
    self endon( #"hash_58510925285657e3" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( true )
    {
        offhand = self getheldoffhand();
        
        if ( offhand.basename != "none" && !self.held_offhand )
        {
            self.held_offhand = 1;
            
            if ( offhand.type == "grenade" || offhand.type == "script" )
            {
                thread function_d586ef9cb44225a( offhand );
            }
            else
            {
                function_797fd9f49f8e8302( offhand );
            }
        }
        else if ( offhand.basename == "none" && self.held_offhand )
        {
            self.held_offhand = 0;
            self notify( #"hash_e60a880f147b4b9c" );
            
            if ( self.var_2c7a381c95d6dd8b )
            {
                if ( self.var_2c7a381c95d6dd8b == "both" )
                {
                    self notify( #"locust_ww_offhand_both_unequipped" );
                }
                
                self.var_2c7a381c95d6dd8b = undefined;
                function_6bbdd2f7d72b2d60( self.locust_ww_charge );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x2c2e6b50, Offset: 0x1023
// Size: 0x8e
function function_797fd9f49f8e8302( offhand )
{
    if ( offhand.offhandtype == "primary" || offhand.basename == "sat_combataxe_zm" || offhand.basename == "sat_impact_grenade_zm" || offhand.basename == "sat_thermobaric_grenade_zm" )
    {
        self.var_2c7a381c95d6dd8b = "both";
    }
    else
    {
        self.var_2c7a381c95d6dd8b = "left";
    }
    
    function_6bbdd2f7d72b2d60( self.locust_ww_charge );
}

// Namespace namespace_e625df044ece0a58
// Params 1, eflags: 0xc
// Checksum 0x3c6e8433, Offset: 0x10b9
// Size: 0xe0
function private function_d586ef9cb44225a( offhand )
{
    self notify( #"hash_70b847b86e9c1ecc" );
    self endon( #"hash_70b847b86e9c1ecc" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    self endon( #"hash_e60a880f147b4b9c" );
    function_797fd9f49f8e8302( offhand );
    
    if ( issubstr( offhand.basename, "perk" ) )
    {
        wait 2.5;
    }
    else
    {
        self waittill( #"grenade_fire", grenade, weapon );
    }
    
    if ( offhand.offhandtype == "secondary" )
    {
        wait 0.3;
        self.var_2c7a381c95d6dd8b = undefined;
        function_6bbdd2f7d72b2d60( self.locust_ww_charge );
        self notify( #"hash_e60a880f147b4b9c" );
    }
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0xc
// Checksum 0xfec5f738, Offset: 0x11a1
// Size: 0x181
function private function_b4befc185db69bc2( params, weapon_name )
{
    self notify( #"hash_c187ca07e358dc1c" );
    self endon( #"hash_c187ca07e358dc1c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( true )
    {
        self waittill( #"melee_fired" );
        current_time = gettime();
        
        if ( !isdefined( self.var_7190727ec94749eb ) )
        {
            self.var_7190727ec94749eb = 0;
        }
        
        if ( !isdefined( self.var_7ef92b7af95f2256 ) )
        {
            self.var_7ef92b7af95f2256 = 0;
        }
        
        is_finisher_lockout = self.var_7190727ec94749eb + 200 > current_time;
        is_heavy_lockout = self.var_7ef92b7af95f2256 + 200 > current_time;
        
        if ( !is_finisher_lockout && !is_heavy_lockout )
        {
            var_1faa2f7a7df21c95 = utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"m_mod_faster_melee" );
            wait_time = var_1faa2f7a7df21c95 ? 0.27 : 0.45;
            wait wait_time;
            dmg_struct = { #sweapon:params.weapon, #idamage:1750 };
            function_43cbce9601886ed1( dmg_struct, undefined, 3, 1 );
            waitframe();
        }
    }
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0xc
// Checksum 0xd936abc, Offset: 0x132a
// Size: 0x22c
function private function_db102f3e5a246206( params, weapon_name )
{
    self notify( #"hash_2a96e0a90bb45f19" );
    self endon( #"hash_2a96e0a90bb45f19" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    if ( !self.locust_ww_tendril )
    {
        self.locust_ww_tendril = [];
    }
    
    while ( true )
    {
        if ( function_a6be57da5326f349() >= 100 && !self.var_740de866b8cf5ceb )
        {
            var_6dba8695187633e = 0;
            
            foreach ( target_player in level.players )
            {
                var_5d422162957a0378 = target_player.locust_ww_tendril[ self.entnum ] || self.locust_ww_tendril[ target_player.entnum ];
                var_6dba8695187633e = !var_5d422162957a0378 && !target_player.var_740de866b8cf5ceb;
                
                if ( var_6dba8695187633e && self != target_player && isplayer( self ) && isplayer( target_player ) && function_a512dfca5d3792ff( target_player, 512, weapon_name, 0 ) )
                {
                    highest_pap_level = max( locust_ww_get_pap_level(), target_player locust_ww_get_pap_level() );
                    pap_suffix = highest_pap_level ? "_pap" : "";
                    vfx_name = function_c4bdbd02b5d1c627( "locust_ww_tendril_fx" );
                    self.locust_ww_tendril[ target_player.entnum ] = playfxontagsbetweenclients( utility::getfx( "locust_ww_tendril_fx" + pap_suffix ), self, "tag_fx_2", target_player, "tag_fx_2" );
                    thread function_d465438b086416c2( target_player, 512, weapon_name );
                }
            }
        }
        else
        {
            utility::function_32b24db3127bff40( "ww_locust_tether", "off" );
        }
        
        waitframe();
    }
}

// Namespace namespace_e625df044ece0a58
// Params 3
// Checksum 0x6abdc59c, Offset: 0x155e
// Size: 0x97
function function_d465438b086416c2( player, tendril_range, weapon_name )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( player function_a512dfca5d3792ff( self, tendril_range, weapon_name, 1 ) )
    {
        wait 0.1;
    }
    
    if ( self.locust_ww_tendril[ player.entnum ] )
    {
        self.locust_ww_tendril[ player.entnum ] delete();
        self.locust_ww_tendril[ player.entnum ] = undefined;
    }
}

// Namespace namespace_e625df044ece0a58
// Params 4
// Checksum 0xf4eb27c8, Offset: 0x15fd
// Size: 0x4fc, Type: bool
function function_a512dfca5d3792ff( player, tendril_range, weapon_name, do_damage )
{
    if ( !( isdefined( player ) && isdefined( self ) ) )
    {
        return false;
    }
    
    if ( player.var_740de866b8cf5ceb || self.var_740de866b8cf5ceb )
    {
        return false;
    }
    
    self_weapon = self getcurrentweapon();
    player_weapon = player getcurrentweapon();
    b_have_weapon = self_weapon.basename == weapon_name && player_weapon.basename == weapon_name;
    var_a09d89fcf671659c = function_a6be57da5326f349() >= 100 && player function_a6be57da5326f349() >= 100;
    var_ea89917cf883873e = !isalive( self ) || !isalive( player );
    b_any_player_in_vehicle = vehicle::is_in_vehicle() || player vehicle::is_in_vehicle();
    b_any_player_in_laststand = player::isinlaststand( self ) || player player::isinlaststand( player );
    var_e503994557e9877c = self.team == player.team;
    
    if ( b_have_weapon && var_a09d89fcf671659c && !var_ea89917cf883873e && !b_any_player_in_vehicle && !b_any_player_in_laststand && var_e503994557e9877c )
    {
        v_pos_1 = self gettagorigin( "tag_weapon_right" );
        v_pos_2 = player gettagorigin( "tag_weapon_right" );
        var_9c9f604f49279920 = distancesquared( v_pos_1, v_pos_2 ) < tendril_range * tendril_range;
        
        if ( var_9c9f604f49279920 )
        {
            contents = trace::create_solid_ai_contents();
            trace_results = trace::ray_trace_get_all_results( v_pos_1, v_pos_2, [ player, self ], contents );
            
            /#
                trace_results[ #"debugdata" ] = undefined;
            #/
            
            current_time = gettime();
            
            foreach ( hit in trace_results )
            {
                hit_entity = hit[ "entity" ];
                
                if ( !hit_entity || !isai( hit_entity ) && !isplayer( hit_entity ) )
                {
                    return false;
                }
            }
            
            if ( do_damage )
            {
                highest_pap_level = max( locust_ww_get_pap_level(), player locust_ww_get_pap_level() );
                pap_suffix = highest_pap_level ? "_pap" : "";
                utility::function_32b24db3127bff40( "ww_locust_tether", "on" + pap_suffix );
                player utility::function_32b24db3127bff40( "ww_locust_tether", "on" + pap_suffix );
                pap_mult = level.var_fe14fee093e2f74e[ highest_pap_level ] ?? 1;
                round_difficulty = self.var_13518fb33ec73cc ?? namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                tendril_dmg = base_zombie_maxhealth * 0.05 * pap_mult;
                
                foreach ( hit in trace_results )
                {
                    hit_entity = hit[ "entity" ];
                    position = hit[ "position" ];
                    
                    if ( hit_entity.team != self.team && isai( hit_entity ) && !hit_entity isragdoll() && ( !hit_entity.var_488f1e2ef639de11 || hit_entity.var_488f1e2ef639de11 < current_time ) )
                    {
                        hitpos = hit[ "position" ];
                        hit_entity dodamage( tendril_dmg, position, self, self, "MOD_FIRE", self_weapon, hitpos, undefined, 65536 );
                        hit_entity dodamage( tendril_dmg, position, player, player, "MOD_FIRE", player_weapon, hitpos, undefined, 65536 );
                        hit_entity.var_a933ff6f2cf57681 = current_time;
                        hit_entity.var_488f1e2ef639de11 = current_time + 1000;
                        
                        if ( hit_entity.health > 0 && !hit_entity.var_9fae86fa742c4263 )
                        {
                            vfx_name = highest_pap_level ? "ww_locust_tendril_hit_pap" : "ww_locust_tendril_hit";
                            tendril_hit_fx = utility::getfx( vfx_name );
                            hit_entity.var_9fae86fa742c4263 = 1;
                            playfxontag( tendril_hit_fx, hit_entity, "j_spine4" );
                            hit_entity thread function_1758d288f5a27706( tendril_hit_fx, "j_spine4" );
                        }
                    }
                }
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0xc
// Checksum 0x62d76897, Offset: 0x1b02
// Size: 0x90
function private function_1758d288f5a27706( vfx_name, tag_name )
{
    self notify( #"hash_3a02615b1b1291a7" );
    self endon( #"hash_3a02615b1b1291a7" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !self.var_a933ff6f2cf57681 || self.var_a933ff6f2cf57681 + 1000 < gettime() )
        {
            if ( isalive( self ) && !self isragdoll() )
            {
                stopfxontag( vfx_name, self, tag_name );
            }
            
            self.var_9fae86fa742c4263 = 0;
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0xc
// Checksum 0x1a3882da, Offset: 0x1b9a
// Size: 0x11a
function private function_19f029f13b831941( params, weapon_name )
{
    self notify( #"hash_43f37d0e19955215" );
    self endon( #"hash_43f37d0e19955215" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( true )
    {
        self waittill( #"heavy_melee_in" );
        
        if ( self.locust_ww_charge > 40 )
        {
            utility::function_32b24db3127bff40( "ww_locust_fireball_charge", "on" );
        }
        
        wait_return = utility::waittill_any_return( "heavy_melee_start", "locust_ww_offhand_both_unequipped", "mantle_start" );
        
        if ( wait_return != "heavy_melee_start" )
        {
            utility::function_32b24db3127bff40( "ww_locust_fireball_charge", "off" );
            continue;
        }
        
        self waittill( #"melee_fired" );
        weapon_charge = function_a6be57da5326f349();
        
        if ( weapon_charge && weapon_charge >= 40 )
        {
            thread function_1ee152b65a6bf46a( params, weapon_name );
        }
        
        self.var_7ef92b7af95f2256 = gettime();
        utility::function_32b24db3127bff40( "ww_locust_fireball_charge", "off" );
        waitframe();
    }
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0xc
// Checksum 0x3044e3d9, Offset: 0x1cbc
// Size: 0x11c
function private function_771654199f99429e( params, weapon_name )
{
    self notify( #"hash_ac14ff55282a057c" );
    self endon( #"hash_ac14ff55282a057c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    
    while ( true )
    {
        self waittill( #"hash_644acb9daca14c49" );
        self.var_dce7b5a89390451 = 1;
        self waittill( #"melee_fired" );
        trace_position_start = anglestoforward( self getplayerangles() ) * 15 + self geteye();
        trace_position_end = anglestoforward( self getplayerangles() ) * 128 + self geteye();
        trace = trace::ray_trace( trace_position_start, trace_position_end );
        dmg_struct = { #sweapon:params.weapon, #vpoint:trace[ "position" ] };
        locust_ww_chain_blast( dmg_struct, self );
        self.var_dce7b5a89390451 = 0;
        self.var_7190727ec94749eb = gettime();
        waitframe();
    }
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0x4
// Checksum 0xabc9d5b5, Offset: 0x1de0
// Size: 0x43
function private function_1ee152b65a6bf46a( params, weapon_name )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ab64622ff9844c59" );
    function_7393b46fd33b2ce6( params, weapon_name );
}

// Namespace namespace_e625df044ece0a58
// Params 2, eflags: 0x4
// Checksum 0x5b7cc101, Offset: 0x1e2b
// Size: 0x16f
function private function_7393b46fd33b2ce6( params, weapon_name )
{
    num_fireballs = 0;
    var_ae4a4b027c8fd43e = [];
    var_ae4a4b027c8fd43e[ 0 ] = 0;
    var_ae4a4b027c8fd43e[ 1 ] = 5;
    var_ae4a4b027c8fd43e[ 2 ] = -5;
    var_ae4a4b027c8fd43e[ 3 ] = 10;
    var_ae4a4b027c8fd43e[ 4 ] = -10;
    var_cd7a6ec2a08f3dd1 = [];
    var_cd7a6ec2a08f3dd1[ 0 ] = 0;
    var_cd7a6ec2a08f3dd1[ 1 ] = -2.5;
    var_cd7a6ec2a08f3dd1[ 2 ] = -2.5;
    var_cd7a6ec2a08f3dd1[ 3 ] = 2.5;
    var_cd7a6ec2a08f3dd1[ 4 ] = 2.5;
    var_951c89546ec50477 = locust_ww_get_pap_level();
    attachment_array = var_951c89546ec50477 ? [ "sat_ww_locust_fireball_pack" ] : [];
    fireballweapon = makeweapon( utility::get_scripted_weapon_name( #"hash_11a70248f1a9f7bf" ), attachment_array );
    
    if ( function_a6be57da5326f349() >= 40 )
    {
        dir = anglestoforward( self getgunangles() + ( var_cd7a6ec2a08f3dd1[ num_fireballs ], var_ae4a4b027c8fd43e[ num_fireballs ], 0 ) );
        startpos = self getvieworigin() + dir * 25;
        endpos = startpos + dir * 5000;
        fireball = weapon_utility::_magicbullet( fireballweapon, startpos, endpos, self );
        fireball.glgrenadeparent = params.weapon;
        num_fireballs++;
        function_5c33f8896eb22787( -40 );
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + function_a6be57da5326f349() );
    #/
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x669e306, Offset: 0x1fa2
// Size: 0x176
function function_2a2e34878c6c6595( dmg_struct )
{
    if ( !isent( self ) )
    {
        return dmg_struct.idamage;
    }
    
    if ( !isplayer( dmg_struct.eattacker ) )
    {
        return dmg_struct.idamage;
    }
    
    player = dmg_struct.eattacker;
    var_951c89546ec50477 = player locust_ww_get_pap_level();
    
    if ( level.var_80b41dd94cf5bb1b[ var_951c89546ec50477 ] )
    {
        dmg_struct.idamage *= level.var_80b41dd94cf5bb1b[ var_951c89546ec50477 ];
    }
    
    if ( self.aicategory == "boss" )
    {
        dmg_struct.idamage *= 1;
    }
    
    if ( var_951c89546ec50477 )
    {
        utility::ent_flag_set( "locust_ww_burned_pap" );
    }
    else
    {
        utility::ent_flag_set( "locust_ww_burned" );
    }
    
    burn_suffix = var_951c89546ec50477 ? "_locust_ww_pap" : "_locust_ww";
    
    if ( !self.status_effects[ "burn" ] || self.status_effects[ "burn" ].size == 0 )
    {
        weapon_name = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
        effect_burn::burn( 5, 500, 1, player, weapon_name, burn_suffix, player, "fire", 0, dmg_struct.sweapon );
    }
    
    return dmg_struct.idamage;
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0xb36776a2, Offset: 0x2121
// Size: 0x1b3
function function_2631fd6016e01143( dmg_struct )
{
    zombie_damage::check_damaged_armor( dmg_struct );
    
    if ( self.aicategory == "boss" )
    {
        dmg_struct.idamage *= 1;
    }
    
    if ( dmg_struct.smeansofdeath != "MOD_MELEE" )
    {
        return dmg_struct.idamage;
    }
    
    player = dmg_struct.eattacker;
    
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return dmg_struct.idamage;
    }
    
    var_1a7a881c4d4ee823 = dmg_struct.idflags & 1;
    var_a733b80a976997ff = dmg_struct.idflags & 8388608;
    var_127835d004d24b49 = dmg_struct.idflags & 262144;
    is_finisher = player.var_dce7b5a89390451;
    
    if ( is_finisher )
    {
        vfx_name = player function_c4bdbd02b5d1c627( "locust_ww_on_hit_vfx" );
        playfx( utility::getfx( vfx_name ), dmg_struct.vpoint );
    }
    else if ( var_127835d004d24b49 )
    {
        vfx_name = player function_c4bdbd02b5d1c627( "locust_ww_on_hit_left_vfx" );
        playfx( utility::getfx( vfx_name ), dmg_struct.vpoint );
    }
    else
    {
        vfx_name = player function_c4bdbd02b5d1c627( "locust_ww_on_hit_right_vfx" );
        playfx( utility::getfx( vfx_name ), dmg_struct.vpoint );
    }
    
    if ( !var_1a7a881c4d4ee823 && !var_a733b80a976997ff )
    {
        player thread function_43cbce9601886ed1( dmg_struct, self, 2 );
        
        if ( is_finisher )
        {
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace namespace_e625df044ece0a58
// Params 2
// Checksum 0x803e058, Offset: 0x22dd
// Size: 0x13b
function locust_ww_chain_blast( dmg_struct, player )
{
    vfx_name = function_c4bdbd02b5d1c627( "locust_ww_chain_blast_vfx" );
    playfx( utility::getfx( vfx_name ), dmg_struct.vpoint );
    zombies = getaiarrayinradius( dmg_struct.vpoint, 96, zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && !zombie isragdoll() )
        {
            dmg_point = zombie tagexists( "j_spine4" ) ? zombie gettagorigin( "j_spine4" ) : zombie getcentroid();
            zombie dodamage( 4750, dmg_point, player, player, "MOD_FIRE", dmg_struct.sweapon, dmg_struct.shitloc, undefined, 8388608 );
        }
    }
}

// Namespace namespace_e625df044ece0a58
// Params 4, eflags: 0x4
// Checksum 0xf3d07ff1, Offset: 0x2420
// Size: 0x43f
function private function_43cbce9601886ed1( dmg_struct, ignore_ai, max_num_hits, left_swing )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    trace_position_start = anglestoforward( self getplayerangles() ) * 64 + self geteye();
    trace_position_end = anglestoforward( self getplayerangles() ) * 80 + self geteye();
    ignore_ents = [ self ];
    
    if ( isent( ignore_ai ) )
    {
        ignore_ents[ ignore_ents.size ] = ignore_ai;
    }
    
    trace = trace::sphere_trace_get_all_results( trace_position_start, trace_position_end, 48, ignore_ents, undefined, undefined, 1 );
    zombies = [];
    ices = [];
    
    foreach ( trace_result in trace )
    {
        var_af1feabe896eff01 = isai( trace_result[ "entity" ] ) && isalive( trace_result[ "entity" ] ) && !isdefined( trace_result[ "entity" ].var_bd22ba6c600a23a3 ) && isdefined( trace_result[ "entity" ].aicategory );
        is_scriptable_ice = trace_result[ "scriptable" ] && trace_result[ "scriptable" ].type == "sat_zm_blocker_ice";
        is_entity_ice = trace_result[ "entity" ] && ( trace_result[ "entity" ].is_ice_wall || trace_result[ "entity" ].ice_wall_clumps );
        
        if ( var_af1feabe896eff01 || is_scriptable_ice || is_entity_ice )
        {
            if ( is_scriptable_ice )
            {
                ices = arraycombineunique( ices, [ trace_result[ "scriptable" ] ] );
                continue;
            }
            
            if ( is_entity_ice )
            {
                ices = arraycombineunique( ices, [ trace_result[ "entity" ] ] );
                continue;
            }
            
            if ( trace_result[ "entity" ] val::get( "damage" ) )
            {
                zombies[ zombies.size ] = trace_result[ "entity" ];
            }
        }
    }
    
    hit_count = 0;
    swing_dmg = self.var_dce7b5a89390451 ? 10000 : 1750;
    dflags = max_num_hits > 1 ? 1 : undefined;
    dflags |= left_swing ? 262144 : 0;
    
    while ( zombies.size > 0 && hit_count < max_num_hits )
    {
        zombie = utility::function_4113d68e8e0a401f( zombies );
        zombies = arrayremove( zombies, zombie );
        
        if ( isalive( zombie ) && !zombie isragdoll() )
        {
            hit_count++;
            dmg_point = zombie tagexists( "j_spine4" ) ? zombie gettagorigin( "j_spine4" ) : zombie getcentroid();
            zombie dodamage( swing_dmg, dmg_point, self, self, "MOD_MELEE", dmg_struct.sweapon, dmg_struct.shitloc, undefined, dflags );
        }
    }
    
    foreach ( ice in ices )
    {
        if ( isent( ice ) )
        {
            dmg_point = ice tagexists( "j_spine4" ) ? ice gettagorigin( "j_spine4" ) : ice getcentroid();
            ice dodamage( swing_dmg, dmg_point, self, self, "MOD_MELEE", dmg_struct.sweapon, dmg_struct.shitloc, undefined, dflags );
            continue;
        }
        
        if ( ice isscriptable() )
        {
            ice scriptabledodamage( swing_dmg, self, self, ice.origin + ( 0, 0, 10 ), undefined, "MOD_MELEE", dmg_struct.sweapon );
        }
    }
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x6a5354c2, Offset: 0x2867
// Size: 0x149
function function_bd201b7db51f6757( params )
{
    if ( params.str_powerup == "full_ammo" )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            locust_ww_name = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
            var_2dee1c96fa1e744d = player getweaponslistprimaries();
            
            foreach ( weapon in var_2dee1c96fa1e744d )
            {
                if ( weapon.basename == locust_ww_name )
                {
                    player function_1873ace2fc909565( 100 );
                }
            }
        }
    }
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0xd83b064d, Offset: 0x29b8
// Size: 0xa2
function function_550fc240c7cabf5c()
{
    if ( self.isskipping )
    {
        function_44be397e3ccb151a();
        return;
    }
    
    foreach ( player in level.players )
    {
        player function_6bbdd2f7d72b2d60( 0, 1 );
        player.var_740de866b8cf5ceb = 1;
    }
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0x7426b014, Offset: 0x2a62
// Size: 0x93
function function_44be397e3ccb151a()
{
    foreach ( player in level.players )
    {
        player function_6bbdd2f7d72b2d60( player.locust_ww_charge );
        player.var_740de866b8cf5ceb = 0;
    }
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0xb4c84a90, Offset: 0x2afd
// Size: 0x37
function function_d51da26af2e1168e( params )
{
    params.player function_6bbdd2f7d72b2d60( 0, 1, 1 );
    params.player thread function_3ea2cba8f0457785( params );
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x6bdd684b, Offset: 0x2b3c
// Size: 0x79
function function_3ea2cba8f0457785( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"touchdown_ejection" );
    weapon = self getcurrentweapon();
    
    if ( weapon && weapon.basename == utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" ) )
    {
        function_6bbdd2f7d72b2d60( self.locust_ww_charge, undefined, 1 );
    }
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x38254a8e, Offset: 0x2bbd
// Size: 0x23
function function_855be43f67b04cdd( params )
{
    self.var_eb14b48839f431a = 1;
    function_6bbdd2f7d72b2d60( 0, 1, 1 );
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x9e3d16b0, Offset: 0x2be8
// Size: 0x29
function function_6064a66aee501487( params )
{
    self.var_eb14b48839f431a = undefined;
    function_6bbdd2f7d72b2d60( self.locust_ww_charge, undefined, 1 );
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0x2970a901, Offset: 0x2c19
// Size: 0xa8, Type: bool
function locust_ww_has_weapon()
{
    weaponname = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
    inventory = self getweaponslistall();
    
    foreach ( weapon in inventory )
    {
        if ( weapon.basename == weaponname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0x10f67f9b, Offset: 0x2cca
// Size: 0x5b
function function_5c33f8896eb22787( amount )
{
    if ( self.var_eb14b48839f431a )
    {
        return;
    }
    
    if ( !isdefined( self.locust_ww_charge ) )
    {
        self.locust_ww_charge = 0;
    }
    
    self.locust_ww_charge = clamp( self.locust_ww_charge + amount, 0, 100 );
    function_6bbdd2f7d72b2d60( self.locust_ww_charge );
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0xc892bd0, Offset: 0x2d2d
// Size: 0x3b
function function_1873ace2fc909565( amount )
{
    if ( self.var_eb14b48839f431a )
    {
        return;
    }
    
    self.locust_ww_charge = clamp( amount, 0, 100 );
    function_6bbdd2f7d72b2d60( self.locust_ww_charge );
}

// Namespace namespace_e625df044ece0a58
// Params 3
// Checksum 0x6a7ecfa3, Offset: 0x2d70
// Size: 0x18a
function function_6bbdd2f7d72b2d60( amount, turn_off, ignore_weapon_check )
{
    pap_suffix = locust_ww_get_pap_level() ? "_pap" : "";
    weapon = self getcurrentweapon();
    is_locust_ww = ignore_weapon_check || weapon && weapon.basename == utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
    
    if ( !is_locust_ww || !isdefined( amount ) )
    {
        return;
    }
    
    if ( self.var_2c7a381c95d6dd8b == "both" || turn_off )
    {
        self.var_740de866b8cf5ceb = 1;
        utility::function_32b24db3127bff40( "ww_locust_tether", "off" );
        utility::function_32b24db3127bff40( "ww_locust_charge", "off" );
        utility::function_32b24db3127bff40( "ww_locust_fireball_charge", "off" );
        return;
    }
    
    self.var_740de866b8cf5ceb = 0;
    
    if ( amount >= 100 )
    {
        if ( self.var_2c7a381c95d6dd8b == "left" )
        {
            utility::function_32b24db3127bff40( "ww_locust_charge", "max_charge_right" + pap_suffix );
        }
        else
        {
            utility::function_32b24db3127bff40( "ww_locust_charge", "max_charge" + pap_suffix );
        }
        
        return;
    }
    
    if ( amount >= 80 )
    {
        utility::function_32b24db3127bff40( "ww_locust_charge", "high_charge" + pap_suffix );
        return;
    }
    
    if ( amount >= 40 )
    {
        utility::function_32b24db3127bff40( "ww_locust_charge", "low_charge" + pap_suffix );
        return;
    }
    
    utility::function_32b24db3127bff40( "ww_locust_charge", "no_charge" + pap_suffix );
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0x26d4b0cd, Offset: 0x2f02
// Size: 0xb
function function_a6be57da5326f349()
{
    return self.locust_ww_charge;
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0xc49b848b, Offset: 0x2f16
// Size: 0xf2, Type: bool
function function_efd685233b44b1a5()
{
    foreach ( player in utility::get_alive_players( 0 ) )
    {
        weapon = player getcurrentweapon();
        is_locust_ww = weapon && weapon.basename == utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
        var_1fd74ef6a2437555 = distancesquared( self.origin, player.origin ) < 16384;
        
        if ( is_locust_ww && player.locust_ww_charge >= 40 && var_1fd74ef6a2437555 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0xe1bb61aa, Offset: 0x3011
// Size: 0x127
function function_cc1d76ab2e16d9c0()
{
    self notify( #"hash_c7d3638b294bd120" );
    self endon( #"hash_c7d3638b294bd120" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_ccee6b247de0c042 = &"zm_sat_locust/ww_tutorial_message";
    
    if ( self.locustww_tutorial_message )
    {
        elem = self.locustww_tutorial_message;
        elem.alpha = 1;
    }
    else
    {
        elem = hud_util::createfontstring( "default", 1 );
    }
    
    elem hud_util::setpoint( "CENTER", "CENTER", 0, 55 );
    elem.label = var_ccee6b247de0c042;
    elem.archived = 0;
    elem.sort = 10;
    elem.showinkillcam = 0;
    self.locustww_tutorial_message = elem;
    wait self.var_420915a121e1cc41 ? 15 : 15;
    elem fadeovertime( 0.5 );
    elem.alpha = 0;
    wait 0.6;
    elem destroy();
    self.locustww_tutorial_message = undefined;
}

// Namespace namespace_e625df044ece0a58
// Params 0
// Checksum 0xd90194f3, Offset: 0x3140
// Size: 0xbe
function locust_ww_get_pap_level()
{
    var_951c89546ec50477 = 0;
    locust_ww_name = utility::get_scripted_weapon_name( #"hash_33d91b4ed0d33131" );
    var_2dee1c96fa1e744d = self getweaponslistprimaries();
    
    foreach ( weapon in var_2dee1c96fa1e744d )
    {
        if ( weapon.basename == locust_ww_name )
        {
            var_951c89546ec50477 = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weapon );
            break;
        }
    }
    
    return var_951c89546ec50477;
}

// Namespace namespace_e625df044ece0a58
// Params 3
// Checksum 0x363e6616, Offset: 0x3207
// Size: 0xef, Type: bool
function function_c531ee6013cf3d72( params, var_234c601eadc766b4 = 1, allow_fireball = 1 )
{
    var_b3cbd266eebbbb50 = params.meansofdeath ?? params.smeansofdeath;
    assert( isdefined( var_b3cbd266eebbbb50 ) );
    assert( isdefined( params.objweapon ) );
    
    if ( var_234c601eadc766b4 && utility::ismeleedamage( var_b3cbd266eebbbb50 ) && params.objweapon.basenamehash == %"sat_ww_locust_zm" )
    {
        return true;
    }
    
    if ( allow_fireball && ( damage::isprojectiledamage( var_b3cbd266eebbbb50 ) || var_b3cbd266eebbbb50 == "MOD_PROJECTILE_SPLASH" ) && params.objweapon.basenamehash == %"sat_ww_locust_fireball" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e625df044ece0a58
// Params 1
// Checksum 0xcc24b33f, Offset: 0x32ff
// Size: 0x30
function function_c4bdbd02b5d1c627( vfx_name )
{
    var_951c89546ec50477 = locust_ww_get_pap_level();
    return var_951c89546ec50477 ? vfx_name + "_pap" : vfx_name;
}

/#

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0x5dd476d5, Offset: 0x3338
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0xd3a2307a, Offset: 0x334c
    // Size: 0x86, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x34>" );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x6b>", &function_4abbf2e5e180bd1f );
        devgui::add_devgui_func( "<dev string:x7f>", "<dev string:x92>", &function_89087a2bf1ecf3d9 );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xb9>", &function_82fe442f563781b3 );
        devgui::add_devgui_func( "<dev string:xcd>", "<dev string:xde>", &function_42497d27bd8e8728 );
        devgui::add_devgui_func( "<dev string:xf1>", "<dev string:x101>", &function_a04e3a800002f2ad );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0x230c8468, Offset: 0x33da
    // Size: 0x80, Type: dev
    function private function_4abbf2e5e180bd1f()
    {
        foreach ( player in level.players )
        {
            player function_1873ace2fc909565( 100 );
        }
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0x5dd4461b, Offset: 0x3462
    // Size: 0x80, Type: dev
    function private function_89087a2bf1ecf3d9()
    {
        foreach ( player in level.players )
        {
            player function_1873ace2fc909565( 80 );
        }
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0xd3f7ae16, Offset: 0x34ea
    // Size: 0x80, Type: dev
    function private function_82fe442f563781b3()
    {
        foreach ( player in level.players )
        {
            player function_1873ace2fc909565( 40 );
        }
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0x99c60f00, Offset: 0x3572
    // Size: 0x7f, Type: dev
    function private function_42497d27bd8e8728()
    {
        foreach ( player in level.players )
        {
            player function_1873ace2fc909565( 0 );
        }
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0xf2b093e8, Offset: 0x35f9
    // Size: 0x7e, Type: dev
    function private function_a04e3a800002f2ad()
    {
        foreach ( player in level.players )
        {
            player thread function_9c4f3cf3fed6a550();
        }
    }

    // Namespace namespace_e625df044ece0a58
    // Params 0, eflags: 0x4
    // Checksum 0xb404bf2a, Offset: 0x367f
    // Size: 0x6e, Type: dev
    function private function_9c4f3cf3fed6a550()
    {
        if ( utility::flag( "<dev string:x11a>" ) )
        {
            utility::flag_clear( "<dev string:x11a>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x11a>" );
        }
        
        level endon( #"inf_charge" );
        self endon( #"death_or_disconnect" );
        function_1873ace2fc909565( 100 );
        
        for ( ;; )
        {
            if ( function_a6be57da5326f349() <= 40 )
            {
                function_1873ace2fc909565( 100 );
            }
            
            wait 1;
        }
    }

#/
