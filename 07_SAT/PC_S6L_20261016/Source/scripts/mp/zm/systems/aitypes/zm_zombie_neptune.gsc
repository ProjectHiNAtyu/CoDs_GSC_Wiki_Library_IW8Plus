// scripts\mp\zm\systems\aitypes\zm_zombie_neptune.gsc  (hash_02e98167994052df.gscc) (size: 17789 Bytes / 0x457d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79278422 (2032632866)
// size ...... 17789 (0x457d)
// includes .. 14  (offset: 0x3dad)
// strings ... 38  (offset: 0x3e1d)
// dev strs .. 112 (offset: 0x3ffd)
// exports ... 31  (offset: 0x2bbd)
// cseg ...... 0x280 + 0x293d (0x2bbd)
// imports ... 95  (offset: 0x3095)
// animtree1 . 0   (offset: 0x457d)
// animtree2 . 0   (offset: 0x457d)
#using script_16ea1b94f0f381b3;
#using script_fd54ba823d404ad;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\zm\zm_utility;

#namespace zm_zombie_neptune;

// Namespace zm_zombie_neptune
// Params 2
// Checksum 0xd01f75e4, Offset: 0x29e
// Size: 0x68
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_ac48d872b6f948fa ) )
    {
        return;
    }
    
    level.var_ac48d872b6f948fa = 1;
    level callback::add( "on_zombie_neptune_spawned", &function_f6d9ff142018efb0 );
    utility::registersharedfunc( #"zombie_neptune", #"hash_158570cc727fd014", &spawn_neptune );
    
    /#
        devgui_init();
    #/
}

// Namespace zm_zombie_neptune
// Params 2
// Checksum 0x3b8a9adf, Offset: 0x30e
// Size: 0x5c
function spawn_neptune( pos, angles )
{
    aitype = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( "zombie_neptune" )[ 0 ];
    neptune = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, pos, angles, zm_utility::get_zombie_team() );
    neptune thread zombie_neptune_asm::function_59fce2d761088455();
    neptune zombie_boss_healthbar::init_zombie_boss_healthbar();
    return neptune;
}

// Namespace zm_zombie_neptune
// Params 1
// Checksum 0x3a7630c2, Offset: 0x373
// Size: 0x127
function function_f6d9ff142018efb0( params )
{
    val::set( "neptune", "ignore_ai_collision", 1 );
    val::set( "neptune", "trigger_hurt_damage", 0 );
    val::set( "neptune", "ignore_cleanup", 1 );
    val::set( "neptune", "allow_brot", 1 );
    val::set( "neptune", "allow_dismember", 0 );
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
    self.no_powerups = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.disallow_aether_shroud_shadow_blade = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_e0207904c8bca4eb = getdvarint( @"hash_629f6f9383e41de9", 1 );
    zombie_utils::function_dfae6a5bd222c586( &function_d03eb6b38108f2a7 );
}

// Namespace zm_zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x97bd75f6, Offset: 0x4a2
// Size: 0xd9c
function private function_d03eb6b38108f2a7( params )
{
    if ( self getaiblackboarddynamic( "immune" ) )
    {
        return 0;
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_fb2e22e32ab81b4d", 0.7 );
    var_d46222e3d16ad6af = getdvarfloat( @"hash_b88f4fb56601c3a8", 0.2 );
    var_e1109c97a3b39262 = getdvarfloat( @"hash_1a0242b2087ddff1", 0.37 );
    var_9bd3c7dd128879df = getdvarfloat( @"hash_c5a2e70b7dac6310", 1 );
    var_df68ad2e8963b034 = getdvarfloat( @"hash_8cd0d0267319e713", 0.5 );
    var_6f95fc7ebd06805f = getdvarfloat( @"hash_3453b01864db4540", 0.5 );
    var_e755d56925be6508 = getdvarint( @"hash_326b6b76ad76cdf2", 6 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_6cc697098eba4b8", 1.65 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_4f0486f92036030c", 1 );
    var_a30b1415bbfa6156 = getdvarfloat( @"hash_2b2496c45818375", 1 );
    var_f5143dbd99bdafc7 = getdvarfloat( @"hash_5a0778254c89c2c9", 0.68 );
    var_75c4603cdc6de7ca = getdvarfloat( @"hash_aada978972860ffc", 0.25 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_fb32d908922ab54b", 0.28 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_e2bd1941f873c3cc", 0.7 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_7d7068a426ee38fd", 0.5 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_c0dd0060b375c3cb", 0.7 );
    var_83fec4317983085b = getdvarfloat( @"hash_f2a6ccc07e46b2e1", 0.37 );
    var_cef89d00885df997 = getdvarfloat( @"hash_521db5bdff2586c", 4 );
    var_20ad41a7190f3038 = getdvarfloat( @"hash_7b789e7e60c56807", 0.5 );
    var_87adbecba0c9b50b = getdvarfloat( @"hash_f182f6a5e1a22c4c", 0.85 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_5dcac720338aa677", 0.35 );
    var_dc55a273e67437dd = getdvarfloat( @"hash_1d5a0ed63692af6a", 0.25 );
    var_6595dcc72d98ee64 = getdvarfloat( @"hash_ae7e0274a491bd4b", 0.65 );
    var_2ff583bbbb170181 = getdvarfloat( @"hash_6eba30782e724512", 0.4 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_4b44f9246bd6a6c8", 0.005 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_1b20d73598aa926e", 0.5 );
    var_807588323e023bd7 = getdvarfloat( @"hash_cd91c0ad3e37bf00", 0.57 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_f6562d4a55a60c98", 0.28 );
    var_d0977b6cf774e182 = getdvarfloat( @"hash_3c95f1bf501c0e61", 0.19 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_c39cf9bef992a803", 0.35 );
    var_a0bcd9de844d765d = getdvarfloat( @"hash_7b5258d9839d57b6", 0.6 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_67b65f744df57044", 0.25 );
    var_74e212ac00fe353 = getdvarfloat( @"hash_44cc2e51624429f4", 0.4 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_7d67b2f80f3f374e", 3 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_230d40d357cfaaf0", 0.45 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_afe0fcd989ae1059", 0.3 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_ee680b34c4edda52", 0.04 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_2d53e8c619c5d935", 0.28 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_bd43af1208619e81", 0.3 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= var_c5e0225cba147a92;
        }
    }
    
    if ( is_wonder )
    {
        damage *= var_d572e4d281047f87;
        is_ruby_ww = issubstr( params.sweapon.basename, "sat_ww_ruby" );
        
        if ( is_ruby_ww )
        {
            damage *= var_d46222e3d16ad6af;
            
            if ( weakspotdata )
            {
                damage *= var_e1109c97a3b39262;
            }
            
            if ( armordata )
            {
                damage *= var_9bd3c7dd128879df;
            }
            
            foreach ( rubyww_squadron in params.eattacker.var_c4e968598d81f3a5 )
            {
                if ( rubyww_squadron.target == self )
                {
                    if ( !isdefined( var_eb61da07016ced73 ) )
                    {
                        var_eb61da07016ced73 = -1;
                    }
                    
                    if ( var_eb61da07016ced73 < var_e755d56925be6508 - 1 )
                    {
                        var_eb61da07016ced73++;
                    }
                }
            }
            
            if ( isdefined( var_eb61da07016ced73 ) )
            {
                var_66ae3a9574b78982 = damage * var_df68ad2e8963b034 * var_eb61da07016ced73;
                damage += var_66ae3a9574b78982;
            }
            
            var_4172a9a824a57f1a = damage * var_6f95fc7ebd06805f * ( level.players.size - 1 );
            damage += var_4172a9a824a57f1a;
        }
        
        is_base_raygun = issubstr( params.objweapon.basename, "raygun" ) && !issubstr( params.objweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_83ea15fca05d5b09 = issubstr( params.objweapon.basename, "raygunmark2" );
        
        if ( var_83ea15fca05d5b09 )
        {
            damage *= var_f0edd71928ca1b53;
            
            if ( weakspotdata )
            {
                damage *= var_a30b1415bbfa6156;
            }
        }
        
        if ( armordata )
        {
            damage *= var_f5143dbd99bdafc7;
        }
        else if ( weakspotdata && !is_base_raygun )
        {
            damage *= var_75c4603cdc6de7ca;
        }
    }
    
    if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        ispolis = issubstr( params.objweapon.basename, "polis" );
        
        if ( ispolis )
        {
            damage *= var_cef89d00885df997;
        }
        
        var_7fdedb034882a3ec = issubstr( params.objweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    
    if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        isakita = issubstr( params.objweapon.basename, "akita" );
        
        if ( isakita )
        {
            damage *= var_20ad41a7190f3038;
        }
        else
        {
            damage *= var_23861e4bdfd87d52;
        }
    }
    
    if ( arraycontains( [ "rifle" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_5ed48d2a95f6cd41;
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    
    if ( arraycontains( [ "sniper" ], params.sweapon.classname ) && weakspotdata )
    {
        damage *= var_83fec4317983085b;
    }
    
    if ( issubstr( params.objweapon.basename, "oman" ) )
    {
        damage *= var_87adbecba0c9b50b;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_a1ae66d0c5f812f5", var_b614da05a3be6674 );
        
        if ( weakspotdata )
        {
            damage *= var_dc55a273e67437dd;
        }
    }
    
    if ( issubstr( params.objweapon.basename, "ballisticknife" ) )
    {
        if ( armordata )
        {
            damage *= var_6595dcc72d98ee64;
        }
        else if ( weakspotdata )
        {
            damage *= var_2ff583bbbb170181;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    
    if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
        
        if ( weakspotdata )
        {
            damage *= var_d0977b6cf774e182;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
        
        if ( weakspotdata )
        {
            damage *= var_a0bcd9de844d765d;
        }
    }
    
    if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_b47cc1e0d1ee010d", var_74e212ac00fe353 );
        }
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_fadee08e6c8bd518", 0.35 );
    }
    
    if ( issubstr( params.objweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.objweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.objweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    if ( !utility::ent_flag( "neptune_phase_disable" ) )
    {
        phase_health = self.var_474e63113b850e5d ? self.maxhealth : self.maxhealth / 3;
        
        if ( damage >= phase_health )
        {
            damage = phase_health + 1;
        }
        else if ( !self.var_474e63113b850e5d && self.n_fight_phase < 3 && self.health - damage < self.maxhealth - self.maxhealth / 3 * self.n_fight_phase )
        {
            damage = self.health - self.maxhealth - self.maxhealth / 3 * self.n_fight_phase + 1;
        }
    }
    
    if ( !utility::ent_flag( "kill_neptune" ) )
    {
        if ( damage >= self.health )
        {
            self.health = 1;
            self notify( #"death_transition", params );
            self function_786bb6aa1b76c7ee( "immune", 1 );
            damage = 0;
        }
    }
    else
    {
        damage = self.health + 1;
    }
    
    return damage;
}

/#

    // Namespace zm_zombie_neptune
    // Params 0
    // Checksum 0xf56174b9, Offset: 0x1247
    // Size: 0x3a3, Type: dev
    function devgui_init()
    {
        if ( level.mapname == "<dev string:x24>" )
        {
            devgui::function_9082edeb5db93280( "<dev string:x30>" );
        }
        else
        {
            devgui::function_9082edeb5db93280( "<dev string:x55>" );
        }
        
        devgui::add_devgui_func( "<dev string:x67>", "<dev string:x75>", &function_2dec09ea9c9fda3a );
        devgui::add_devgui_func( "<dev string:x83>", "<dev string:x95>", &function_cc74952092ebfa6f );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xb9>", &function_fe969fabf2c81dfb );
        devgui::add_devgui_func( "<dev string:xcb>", "<dev string:xdd>", &function_dc9a0d4db4ae0691 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xef>", "<dev string:x109>", &function_28794f9b869b8ca1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11f>", "<dev string:x13a>", &function_28794f9b869b8ca1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x151>", "<dev string:x16e>", &function_28794f9b869b8ca1 );
        devgui::add_devgui_func( "<dev string:x187>", "<dev string:x19e>", &function_2e2cbf7868fd83cd );
        devgui::add_devgui_func( "<dev string:x1b5>", "<dev string:x1c8>", &function_373d78ce9d6d773d );
        devgui::add_devgui_func( "<dev string:x1da>", "<dev string:x1ec>", &function_64f03d61bbd36d33 );
        devgui::add_devgui_func( "<dev string:x1fd>", "<dev string:x216>", &function_f637342ecae011ad );
        devgui::add_devgui_func( "<dev string:x22e>", "<dev string:x248>", &function_3669f31914ed1eeb );
        devgui::add_devgui_func( "<dev string:x261>", "<dev string:x271>", &devgui_disable_all_ai );
        devgui::add_devgui_func( "<dev string:x280>", "<dev string:x28e>", &devgui_toggle_think );
        devgui::add_devgui_func( "<dev string:x29b>", "<dev string:x2ca>", &function_8ada25f801bd42f8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>", "<dev string:x31c>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x343>", "<dev string:x37d>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a5>", "<dev string:x3e1>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x40b>", "<dev string:x444>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46b>", "<dev string:x4a7>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d1>", "<dev string:x50b>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x533>", "<dev string:x570>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x59b>", "<dev string:x5d7>", &function_84f4747f7b4d80d6, undefined, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x601>", "<dev string:x627>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x641>", "<dev string:x66c>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x692>", "<dev string:x6bf>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6e7>", "<dev string:x716>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x740>", "<dev string:x768>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x78b>", "<dev string:x7ae>", &function_ba37eafbbf947592 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7cc>", "<dev string:x7e2>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7f8>", "<dev string:x813>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x82e>", "<dev string:x852>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x876>", "<dev string:x892>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8ae>", "<dev string:x8c7>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8e0>", "<dev string:x8fe>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x91c>", "<dev string:x93b>", &function_8f610e802e1f0aa0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x95a>", "<dev string:x979>", &function_8f610e802e1f0aa0 );
        devgui::add_devgui_func( "<dev string:x998>", "<dev string:x9b6>", &function_2379ead26ddbc1c5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9c6>", "<dev string:x9e5>", &function_53afd4df57cba74c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_zombie_neptune
    // Params 1, eflags: 0x4
    // Checksum 0x3fabdd3e, Offset: 0x15f2
    // Size: 0x4e, Type: dev
    function private function_28794f9b869b8ca1( params )
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        value = int( params[ 0 ] );
        level.var_658fb0b2495595d4 = value;
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x36bbc784, Offset: 0x1648
    // Size: 0x1a, Type: dev
    function private devgui_disable_all_ai()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa04>", @"ai_enabled" );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0xe4628b4f, Offset: 0x166a
    // Size: 0x50, Type: dev
    function private devgui_toggle_think()
    {
        boss = level.zombie_neptune;
        
        if ( boss )
        {
            boss clearpath();
            boss setgoalpos( boss.origin );
            boss function_786bb6aa1b76c7ee( "<dev string:xa0f>", !boss getaiblackboarddynamic( "<dev string:xa0f>" ) );
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x7a5d003e, Offset: 0x16c2
    // Size: 0xb5, Type: dev
    function private function_2dec09ea9c9fda3a()
    {
        neptune_spawn_struct = level.var_4cf3138664b652b6;
        
        if ( !neptune_spawn_struct )
        {
            origin = devgui::function_97024c0a6d1256a6();
            angles = ( 0, 0, 0 );
        }
        else
        {
            origin = neptune_spawn_struct.origin;
            angles = neptune_spawn_struct.angles;
        }
        
        level.zombie_neptune = utility::callsharedfunc( #"zombie_neptune", #"hash_158570cc727fd014", origin, angles );
        
        if ( !level.var_4cf3138664b652b6 )
        {
            level.var_4cf3138664b652b6 = { #angles:angles, #origin:origin };
        }
    }

    // Namespace zm_zombie_neptune
    // Params 1, eflags: 0x4
    // Checksum 0xdb2a29ae, Offset: 0x177f
    // Size: 0xf, Type: dev
    function private function_b690a2fd43009080( params )
    {
        
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x4f810d10, Offset: 0x1796
    // Size: 0x42, Type: dev
    function private function_cc74952092ebfa6f()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa1d>", @"hash_b6f1a6ccd3fba548" );
        
        if ( getdvarint( @"hash_b6f1a6ccd3fba548", 0 ) )
        {
            level thread function_ced6456187445d53();
            return;
        }
        
        level notify( #"hash_c5f4ec9321b10bb3" );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0xc
    // Checksum 0x476790, Offset: 0x17e0
    // Size: 0x1fd, Type: dev
    function private function_ced6456187445d53()
    {
        self notify( #"hash_a153feb6183911ad" );
        self endon( #"hash_a153feb6183911ad" );
        
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_c5f4ec9321b10bb3" );
        level.zombie_neptune endon( #"death" );
        neptune = level.zombie_neptune;
        
        while ( true )
        {
            pos = neptune gettagorigin( "<dev string:xa39>", 1 ) ?? neptune.origin + ( 0, 0, 100 );
            print3d( pos + ( 0, 0, 30 ), "<dev string:xa40>" + neptune.n_fight_phase, ( 1, 1, 1 ), 1 );
            print3d( pos + ( 0, 0, 45 ), "<dev string:xa48>" + neptune.model, ( 1, 1, 1 ), 1 );
            print3d( pos + ( 0, 0, 60 ), "<dev string:xa50>" + 8, ( 1, 1, 1 ), 1 );
            print3d( pos + ( 0, 0, 75 ), "<dev string:xa5d>" + neptune.var_157122fd854d543d[ "<dev string:xa6b>" ].is_active, ( 1, 1, 1 ), 1 );
            print3d( pos + ( 0, 0, 90 ), "<dev string:xa76>" + neptune._blackboard.movetype, ( 1, 1, 1 ), 1 );
            print3d( pos + ( 0, 0, 105 ), "<dev string:xa82>" + neptune asmgetcurrentstate( neptune.asmname ), ( 1, 1, 1 ), 1 );
            waitframe();
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0xcc72b8a4, Offset: 0x19e5
    // Size: 0xec, Type: dev
    function private function_2e2cbf7868fd83cd()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        speed_string = [ "<dev string:xa8e>", "<dev string:xa93>", "<dev string:xa97>" ];
        init_index = 0;
        
        for ( i = 0; i < speed_string.size ; i++ )
        {
            if ( neptune._blackboard.movetype == speed_string[ i ] )
            {
                init_index = i;
                break;
            }
        }
        
        if ( !isdefined( neptune.debug_move_speed ) )
        {
            neptune.debug_move_speed = init_index;
        }
        
        neptune.debug_move_speed = ( neptune.debug_move_speed + 1 ) % speed_string.size;
        neptune zombie_utils::function_a8ce00e0448cb6f0( speed_string[ neptune.debug_move_speed ], "<dev string:xa9e>", 0 );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x690ec73a, Offset: 0x1ad9
    // Size: 0xc6, Type: dev
    function private function_fe969fabf2c81dfb()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        
        if ( neptune getaiblackboarddynamic( "<dev string:xaad>" ) )
        {
            return;
        }
        
        neptune.health = neptune.maxhealth - int( neptune.maxhealth / 3 * neptune.n_fight_phase ) + 1;
        damage = int( neptune.maxhealth * 0.01 ) + 1;
        
        if ( damage >= neptune.health )
        {
            damage = neptune.health - 1;
        }
        
        neptune dodamage( damage, neptune.origin );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x59975bad, Offset: 0x1ba7
    // Size: 0xde, Type: dev
    function private function_dc9a0d4db4ae0691()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        settings = neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        
        if ( !isdefined( var_3db8e18cb90e15f6 ) )
        {
            var_3db8e18cb90e15f6 = [ neptune.model, settings.var_8dd4e71c890f6f29, settings.var_8dd4e61c890f6cf6 ];
        }
        
        if ( !isdefined( neptune.debug_model_index ) )
        {
            neptune.debug_model_index = neptune.n_fight_phase - 1;
        }
        
        neptune.debug_model_index = ( neptune.debug_model_index + 1 ) % var_3db8e18cb90e15f6.size;
        neptune setmodel( var_3db8e18cb90e15f6[ neptune.debug_model_index ] );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0xb97f0721, Offset: 0x1c8d
    // Size: 0x42, Type: dev
    function private function_8ada25f801bd42f8()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xab4>", @"hash_9e9322001fd2b435" );
        
        if ( getdvarint( @"hash_9e9322001fd2b435", 0 ) )
        {
            level thread function_affa0fd155242964();
            return;
        }
        
        level notify( #"hash_d535d22003bb2fc4" );
    }

    // Namespace zm_zombie_neptune
    // Params 1, eflags: 0x4
    // Checksum 0x7b72c989, Offset: 0x1cd7
    // Size: 0x1c9, Type: dev
    function private function_84f4747f7b4d80d6( params )
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        metabones_def = metabone::get_metabones_def( level.zombie_neptune.metabones.bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            state_name = level.zombie_neptune metabone::get_metabone_state_name( metabone.name );
            tagname = metabone.tags[ 0 ].tagname;
            
            if ( tagname == params[ 0 ] )
            {
                neptune.debug_armor = metabone.name;
                break;
            }
        }
        
        foreach ( index, armor in neptune.armors )
        {
            if ( armor == neptune.debug_armor )
            {
                neptune.var_e9ec04918feedc6 = index;
                break;
            }
        }
    }

    // Namespace zm_zombie_neptune
    // Params 1, eflags: 0x4
    // Checksum 0xa8bcaa98, Offset: 0x1ea8
    // Size: 0x1d1, Type: dev
    function private function_ba37eafbbf947592( params )
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        
        if ( !isdefined( neptune.debug_armor ) || !isdefined( neptune.var_e9ec04918feedc6 ) || neptune.var_e9ec04918feedc6 >= neptune.armors.size )
        {
            neptune.debug_armor = neptune.armors[ 0 ];
            neptune.var_e9ec04918feedc6 = 0;
        }
        
        switch ( params[ 0 ] )
        {
            case #"hash_ab29d4b412427ec8":
                level.zombie_neptune zombie_neptune_metabones::function_c35ccbc3b1fbcab9();
                break;
            case #"hash_e0dbe0f4739dd26d":
                level.zombie_neptune zombie_neptune_metabones::reset_metabones();
                break;
            case #"hash_844050c52db95987":
                level.zombie_neptune zombie_neptune_metabones::function_70c027ae72258c9e( neptune.debug_armor, "<dev string:xb02>" );
                break;
            case #"hash_aff144b88fd25411":
                level.zombie_neptune zombie_neptune_metabones::function_70c027ae72258c9e( neptune.debug_armor, "<dev string:xb29>" );
                break;
            case #"hash_386a21cfae52e026":
                level.zombie_neptune zombie_neptune_metabones::function_70c027ae72258c9e( neptune.debug_armor, "<dev string:xb54>" );
                break;
            case #"hash_aa32b247c2f2320b":
                neptune.var_e9ec04918feedc6 = ( neptune.var_e9ec04918feedc6 + 1 ) % neptune.armors.size;
                neptune.debug_armor = neptune.armors[ neptune.var_e9ec04918feedc6 ];
                break;
            default:
                return;
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0xc
    // Checksum 0x521ab0d7, Offset: 0x2081
    // Size: 0x1c5, Type: dev
    function private function_affa0fd155242964()
    {
        self notify( #"hash_a067eebc74ae2600" );
        self endon( #"hash_a067eebc74ae2600" );
        
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_d535d22003bb2fc4" );
        level.zombie_neptune endon( #"death" );
        metabones_def = metabone::get_metabones_def( level.zombie_neptune.metabones.bundle_name );
        
        while ( true )
        {
            foreach ( metabone in metabones_def.metabones )
            {
                state_name = level.zombie_neptune metabone::get_metabone_state_name( metabone.name );
                
                if ( state_name == "<dev string:xb7a>" )
                {
                    continue;
                }
                
                tagname = metabone.tags[ 0 ].tagname;
                origin = level.zombie_neptune gettagorigin( tagname );
                
                if ( level.zombie_neptune.exposed_weakpoint == metabone.name )
                {
                    function_b2955304e5aeb5a6( origin, 5, 5, 0, ( 1, 1, 1 ), 0, 1 );
                    continue;
                }
                
                sphere( origin, 5, ( 1, 1, 1 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x5ae81411, Offset: 0x224e
    // Size: 0x42, Type: dev
    function private function_64f03d61bbd36d33()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb84>", @"hash_d194b6bbd6092732" );
        
        if ( getdvarint( @"hash_d194b6bbd6092732", 0 ) )
        {
            level thread function_ee2e5211a3b8991f();
            return;
        }
        
        level notify( #"hash_4e024b13bda029ff" );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0xc
    // Checksum 0x4f3ecdfb, Offset: 0x2298
    // Size: 0xc8, Type: dev
    function private function_ee2e5211a3b8991f()
    {
        self notify( #"hash_388db5362b263cb7" );
        self endon( #"hash_388db5362b263cb7" );
        
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_4e024b13bda029ff" );
        level.zombie_neptune endon( #"death" );
        settings = level.zombie_neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        
        while ( true )
        {
            thrown_rock = level.zombie_neptune.thrown_rock;
            
            if ( thrown_rock )
            {
                draw_circle( thrown_rock.origin, settings.var_b81e965f6476a2af );
            }
            
            waitframe();
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0
    // Checksum 0x19e11160, Offset: 0x2368
    // Size: 0x42, Type: dev
    function function_f637342ecae011ad()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb9f>", @"hash_28da906bd9ba80e2" );
        
        if ( getdvarint( @"hash_28da906bd9ba80e2", 0 ) )
        {
            level thread function_a3546fecf56caa49();
            return;
        }
        
        level notify( #"hash_ab31b557b1b788e9" );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0xc
    // Checksum 0x14b61d68, Offset: 0x23b2
    // Size: 0xbf, Type: dev
    function private function_a3546fecf56caa49()
    {
        self notify( #"hash_618ec1d99223f1bc" );
        self endon( #"hash_618ec1d99223f1bc" );
        
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_ab31b557b1b788e9" );
        level.zombie_neptune endon( #"death" );
        settings = level.zombie_neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        
        while ( true )
        {
            ground_slam_pos = level.zombie_neptune.origin;
            
            if ( ground_slam_pos )
            {
                draw_circle( ground_slam_pos, settings.var_e363b985435a2de6 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_zombie_neptune
    // Params 1
    // Checksum 0xd44e5d77, Offset: 0x2479
    // Size: 0x437, Type: dev
    function function_8f610e802e1f0aa0( params )
    {
        if ( !level.zombie_neptune || !isdefined( params[ 0 ] ) || params.size > 1 )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        
        if ( !level.var_2957f584a65f3482 )
        {
            level.var_2957f584a65f3482 = [];
            
            foreach ( behavior, value in neptune.var_157122fd854d543d )
            {
                level.var_2957f584a65f3482[ behavior ] = value.cooldown_sec;
            }
        }
        
        if ( params[ 0 ] != "<dev string:xbc1>" )
        {
            neptune function_786bb6aa1b76c7ee( "<dev string:xbc9>", 0 );
            neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 0 );
            
            foreach ( behavior, value in neptune.var_157122fd854d543d )
            {
                if ( behavior == "<dev string:xbf4>" )
                {
                    continue;
                }
                
                value.cooldown_sec = 999999;
                value.var_5a4e1b29b5d9d41a = gettime();
            }
        }
        else
        {
            foreach ( behavior, value in neptune.var_157122fd854d543d )
            {
                value.cooldown_sec = level.var_2957f584a65f3482[ behavior ];
                value.var_5a4e1b29b5d9d41a = gettime();
            }
        }
        
        neptune function_786bb6aa1b76c7ee( "<dev string:xbc9>", 1 );
        neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 1 );
        neptune function_786bb6aa1b76c7ee( "<dev string:xa0f>", 1 );
        
        switch ( params[ 0 ] )
        {
            case #"hash_d8108ea2b5d414f3":
                neptune clearbtgoal( 0 );
                break;
            case #"hash_8054bf81a1329aec":
                neptune setbtgoalpos( 0, neptune.enemy.origin );
                neptune setbtgoalradius( 0, 32 );
                break;
            case #"hash_c867f472f95fd32d":
                neptune function_786bb6aa1b76c7ee( "<dev string:xbc9>", 1 );
                neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 0 );
                break;
            case #"hash_9f8d243e9e31bac4":
                neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 1 );
                neptune function_786bb6aa1b76c7ee( "<dev string:xbc9>", 0 );
                break;
            case #"hash_bf53316041624d3c":
                neptune.var_157122fd854d543d[ "<dev string:xbf4>" ].cooldown_sec = 1;
                neptune.var_157122fd854d543d[ "<dev string:xc47>" ].cooldown_sec = 1;
                break;
            case #"hash_f444cc9906bb580a":
                neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 0 );
            case #"hash_b3ea28629134a559":
                neptune.var_157122fd854d543d[ "<dev string:xbf4>" ].cooldown_sec = 1;
                neptune.var_157122fd854d543d[ "<dev string:xc74>" ].cooldown_sec = 1;
                break;
            case #"hash_c0a19c237234e6df":
                neptune.var_157122fd854d543d[ "<dev string:xbf4>" ].cooldown_sec = 1;
                neptune.var_157122fd854d543d[ "<dev string:xa6b>" ].cooldown_sec = 1;
                break;
            case #"hash_5f39d019572500bb":
                neptune function_786bb6aa1b76c7ee( "<dev string:xbc9>", 0 );
                neptune function_786bb6aa1b76c7ee( "<dev string:xbdf>", 0 );
                neptune function_786bb6aa1b76c7ee( "<dev string:xa0f>", 0 );
                break;
            default:
                return;
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0xfc0ba4c6, Offset: 0x28b8
    // Size: 0x6c, Type: dev
    function private function_2379ead26ddbc1c5()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        
        if ( !isdefined( neptune.enemy ) )
        {
            return;
        }
        
        neptune orientmode( "<dev string:xc90>", vectortoyaw( neptune.enemy.origin - neptune.origin ), 1 );
    }

    // Namespace zm_zombie_neptune
    // Params 1, eflags: 0x4
    // Checksum 0xcd76a78b, Offset: 0x292c
    // Size: 0xa6, Type: dev
    function private function_53afd4df57cba74c( params )
    {
        if ( !level.zombie_neptune || !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        
        switch ( params[ 0 ] )
        {
            case #"hash_c1bea00dd02e1176":
                [ can_slam, pitch ] = neptune zombie_neptune::function_453044a736fb459a();
                
                if ( can_slam )
                {
                    neptune function_a8fe8d86843b9cee( pitch );
                    neptune thread zombie_neptune::do_ground_slam();
                }
                
                break;
            default:
                return;
        }
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x83cec858, Offset: 0x29da
    // Size: 0x5f, Type: dev
    function private function_373d78ce9d6d773d()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        neptune.health = 1;
        neptune.n_fight_phase = 3;
        neptune utility::ent_flag_set( "<dev string:xca7>" );
        neptune notify( #"death_transition" );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x3ddfe626, Offset: 0x2a41
    // Size: 0x3e, Type: dev
    function private function_3669f31914ed1eeb()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        neptune asm::function_d82cb83c9c260d49( 1 );
        neptune asm::asm_setmoveplaybackrate( 1 );
    }

    // Namespace zm_zombie_neptune
    // Params 0, eflags: 0x4
    // Checksum 0x63239772, Offset: 0x2a87
    // Size: 0x31, Type: dev
    function private function_aa7d42f20deaf4f5()
    {
        if ( !level.zombie_neptune )
        {
            return;
        }
        
        neptune = level.zombie_neptune;
        neptune zombie_neptune_metabones::reset_metabones();
    }

    // Namespace zm_zombie_neptune
    // Params 2, eflags: 0x4
    // Checksum 0x1cc668ad, Offset: 0x2ac0
    // Size: 0xfd, Type: dev
    function private draw_circle( loc, radius )
    {
        midpoint_org = loc;
        numpoints = 16;
        
        for ( i = 0; i < numpoints ; i++ )
        {
            angle = 360 / numpoints * i;
            x = midpoint_org[ 0 ] + radius * cos( angle );
            y = midpoint_org[ 1 ] + radius * sin( angle );
            nextangle = 360 / numpoints * ( i + 1 ) % numpoints;
            nextx = midpoint_org[ 0 ] + radius * cos( nextangle );
            nexty = midpoint_org[ 1 ] + radius * sin( nextangle );
            
            /#
                line( ( x, y, midpoint_org[ 2 ] ), ( nextx, nexty, midpoint_org[ 2 ] ), ( 1, 1, 1 ), 1, 1 );
            #/
        }
    }

#/
