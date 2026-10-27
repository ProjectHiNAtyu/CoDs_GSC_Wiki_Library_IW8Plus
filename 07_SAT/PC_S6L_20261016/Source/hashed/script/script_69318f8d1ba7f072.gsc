// script_69318f8d1ba7f072  (hash_69318f8d1ba7f072.gscc) (size: 20748 Bytes / 0x510c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6906babd (1762048701)
// size ...... 20748 (0x510c)
// includes .. 26  (offset: 0x480c)
// strings ... 113 (offset: 0x48dc)
// dev strs .. 44  (offset: 0x4e84)
// exports ... 19  (offset: 0x33e0)
// cseg ...... 0x7cf + 0x2c11 (0x33e0)
// imports ... 130 (offset: 0x36d8)
// animtree1 . 0   (offset: 0x510c)
// animtree2 . 0   (offset: 0x510c)
#using script_16ea1b94f0f381b3;
#using script_21453148428dc2c0;
#using script_28f8e299bbcf2c00;
#using script_2de83d6261680959;
#using script_315f1c0a3c1a8527;
#using script_4fb7a9021a570c8a;
#using script_6d4c5bf7d72d6d4a;
#using script_726b7f033a90911c;
#using script_75753577a55139f3;
#using script_79edb4ed1f52fb62;
#using script_7f0fdfedd9ca7570;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\nearby_player_scaling;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_talisman;

#namespace zombie_diana;

// Namespace zombie_diana
// Params 2
// Checksum 0xb106f7dd, Offset: 0x7ed
// Size: 0x5d
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "diana_weakspot_imapct_vfx", settings.var_2bf4dfb07dd1dd28 );
        utility::add_fx( "diana_necrotic_beam_attack_vfx", settings.var_9b2f081c57203e42 );
    }
}

// Namespace zombie_diana
// Params 2
// Checksum 0xc21849b1, Offset: 0x852
// Size: 0x35
function set_diana_tether( tetherpoint, tetherradius )
{
    self.var_4827856486127f11 = { #tetherradius:tetherradius, #tetherpoint:tetherpoint };
}

// Namespace zombie_diana
// Params 2
// Checksum 0x387bd17b, Offset: 0x88f
// Size: 0x34
function function_2c054e2c3e95b33e( var_3ab54a7e485a2a58, var_4b17a6e700e7843d )
{
    self.var_f8115155adde44d = [ 1, var_3ab54a7e485a2a58, var_4b17a6e700e7843d ];
}

// Namespace zombie_diana
// Params 1, eflags: 0x4
// Checksum 0xc0c25b49, Offset: 0x8cb
// Size: 0xa5
function private function_9f4f9cc3821ece50( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    zombie_diana_metabones::function_380db743947ddada();
    zombie_diana_move::function_68c6c5770986c491();
    zombie_diana_targeting::function_78c0a88763d5eef();
    namespace_11bfef4f5e98b9a1::function_401e01e15c94ef0();
    zombie_diana_necrotic_projectile::function_3baac86e7fec1b47();
    zombie_diana_necrotic_beam::function_6e5b3d623dea435f();
    zombie_diana_necrotic_fan::function_cb5c579bde7f861();
    zombie_diana_winged_tornado_attack::function_8bf6a89a142feeb1();
    zombie_diana_summon_agni_zombies::function_eb57bf24aadaee1d();
    zombie_diana_audio::function_d18a8e4e982c57a4();
    template = callback::get_template( self.animsetname );
    template callback::add( "killed_body_cloned", &play_death_fx );
    template callback::add( "new_diana_phase", &function_d9f177d8cb8e47e );
    
    /#
        level thread function_59cc9226f19857ec();
    #/
}

// Namespace zombie_diana
// Params 1
// Checksum 0x9282b294, Offset: 0x978
// Size: 0x1e7
function function_29efc5afcb6c6999( taskid )
{
    profilestart();
    assert( isdefined( self.zombieaisetting ) );
    callback::add( "on_first_ai_init", &function_9f4f9cc3821ece50 );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    zombie_diana_audio::init_zombie_diana_audio();
    val::set( "zombie_diana", "death", 0 );
    self.nocorpse = undefined;
    self.noragdoll = 1;
    self.script_noragdoll = 1;
    self.allowfriendlyfire = 1;
    self.allowstrafe = 0;
    self enabletraversals( 0 );
    self function_786bb6aa1b76c7ee( "in_armor_break", 0 );
    self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    self function_786bb6aa1b76c7ee( "in_death_sequence", 0 );
    self.var_13518fb33ec73cc = 30;
    self.var_317816f65dd8fd6c = 2;
    self.disable_brain_rot = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.bossfightphase = 1;
    self.prevent_knockdown = 1;
    val::set( "zombie_diana_init", "high_net_lod", 1 );
    self function_43a971093c992365( 1 );
    self disableaimassist();
    nearby_player_scaling::init_nearby_player_scaling();
    zombie_diana_metabones::init_zombie_diana_metabones();
    zombie_diana_move::init_zombie_diana_move();
    
    if ( getdvarint( @"hash_a1d96ea6d3fc434b", 1 ) )
    {
        zombie_diana_targeting::init_zombie_diana_targeting();
    }
    
    self.var_3738d1332f70b824 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3738d1332f70b824;
    zombie_diana_necrotic_projectile::init_diana_necrotic_projectile();
    zombie_diana_necrotic_beam::init_diana_necrotic_beam();
    zombie_diana_necrotic_fan::init_diana_necrotic_fan();
    zombie_diana_winged_tornado_attack::init_zombie_diana_winged_tornado_attack();
    zombie_diana_summon_agni_zombies::init_diana_summon_agni_zombies();
    self.var_f9e48b7ff2c39654 = [];
    self function_786bb6aa1b76c7ee( "combat_action_cooldown", gettime() );
    thread init_scriptable();
    zombie_utils::function_dfae6a5bd222c586( &function_5534378e35bbd419 );
    utility::ent_flag_set( "zombie_diana_init_finished" );
    thread function_8d21c90483b8739d();
    profilestop();
    return anim.success;
}

// Namespace zombie_diana
// Params 0, eflags: 0x4
// Checksum 0x1b9beb3c, Offset: 0xb69
// Size: 0x2b
function private function_8d21c90483b8739d()
{
    utility::ent_flag_wait_or_timeout( "zombie_diana_post_init_finished", 1 );
    
    if ( !utility::ent_flag_exist( "zombie_diana_post_init_finished" ) )
    {
        utility::ent_flag_set( "zombie_diana_post_init_finished" );
    }
}

// Namespace zombie_diana
// Params 0, eflags: 0x4
// Checksum 0x9565af70, Offset: 0xb9c
// Size: 0x9f
function private init_scriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    utility::function_32b24db3127bff40( "base", "base_on" );
    
    if ( !self.InAssaultRounds )
    {
        utility::function_32b24db3127bff40( "lower_torso_left", "armored" );
        utility::function_32b24db3127bff40( "upper_torso_right", "armored" );
        utility::function_32b24db3127bff40( "upper_neck_left", "armored" );
        utility::function_32b24db3127bff40( "lower_neck_right", "armored" );
        utility::function_32b24db3127bff40( "wing_left", "armored" );
        utility::function_32b24db3127bff40( "wing_right", "armored" );
    }
}

// Namespace zombie_diana
// Params 1, eflags: 0x4
// Checksum 0x29be8348, Offset: 0xc43
// Size: 0x17a0
function private function_5534378e35bbd419( params )
{
    if ( self.InAssaultRounds || self.var_382b3e1f72536e3c )
    {
        if ( isplayer( params.eattacker ) )
        {
            params.eattacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "immune", undefined, undefined, undefined, "hitimmune" );
        }
        
        params.var_d20799805edf0194 = 1;
        return 0;
    }
    
    var_94b67e97b730d03f = 0.05;
    var_4c2a0f4937888418 = 0.05;
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d317b176a4de4141 = getdvarfloat( @"hash_6250d479493c2d1", 237.5 );
    var_ef33853ed76c0939 = getdvarfloat( @"hash_199b7fe26c657ae9", 350 );
    var_7350c35793720f30 = getdvarfloat( @"hash_a803aa7f9f83a440", 262.5 );
    var_d317b076a4de3f0e = getdvarfloat( @"hash_6250c479493c09e", 475 );
    var_ef33843ed76c0706 = getdvarfloat( @"hash_199b7ee26c6578b6", 700 );
    var_7350c45793721163 = getdvarfloat( @"hash_a803ab7f9f83a673", 525 );
    var_d317af76a4de3cdb = getdvarfloat( @"hash_6250b479493be6b", 950 );
    var_ef33833ed76c04d3 = getdvarfloat( @"hash_199b7de26c657683", 1400 );
    var_7350c55793721396 = getdvarfloat( @"hash_a803ac7f9f83a8a6", 1050 );
    var_d317ae76a4de3aa8 = getdvarfloat( @"hash_6250a479493bc38", 1900 );
    var_ef33823ed76c02a0 = getdvarfloat( @"hash_199b7ce26c657450", 2800 );
    var_7350c657937215c9 = getdvarfloat( @"hash_a803ad7f9f83aad9", 2100 );
    var_d317b576a4de4a0d = getdvarfloat( @"hash_62511479493cb9d", 2375 );
    var_ef33893ed76c1205 = getdvarfloat( @"hash_199b83e26c6583b5", 3500 );
    var_7350c757937217fc = getdvarfloat( @"hash_a803ae7f9f83ad0c", 2625 );
    var_d572e4d281047f87 = getdvarfloat( @"hash_8ee17ef6236f3543", 2 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_7386f78d62ecf102", 5.8 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_8196f52b4572ccda", 2 );
    var_a30b1415bbfa6156 = getdvarfloat( @"hash_7b8d0797fa2c660f", 0.3 );
    var_f5143dbd99bdafc7 = getdvarfloat( @"hash_c7c7656874d7fd17", 1 );
    var_75c4603cdc6de7ca = getdvarfloat( @"hash_6898c30e138192f6", 1 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_efdde2899c38172d", 0.7 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_bbbcd831252ef52a", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_1a433757cca488c7", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_759536814cca7fd5", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_9a9fcd7fefbe9dca", 0.65 );
    var_83fec4317983085b = getdvarfloat( @"hash_18504800f119873f", 1.1 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_3d0b14c9a1fe0985", 2.3 );
    var_1b8b28636737013e = getdvarfloat( @"hash_18aee21800a8f6bb", 0.6 );
    var_cef89d00885df997 = getdvarfloat( @"hash_f491f1ad49ca76ae", 3.5 );
    var_d48cf9ae0101f824 = getdvarfloat( @"hash_f793763c5df91b1", 0.8 );
    var_d38e60852f9d06ed = getdvarfloat( @"hash_1d263615d3e9d270", 0.41 );
    var_20ad41a7190f3038 = getdvarfloat( @"hash_cd385af68f698035", 1 );
    var_87adbecba0c9b50b = getdvarfloat( @"hash_1df1e5a038a7df22", 1 );
    var_e53b66a0bc564ac7 = getdvarfloat( @"hash_480512a913831fe", 0.45 );
    var_e765f5af205d68c0 = getdvarfloat( @"hash_d5196779b41ed0cd", 1.2 );
    var_c7f17ea704ca95d0 = getdvarfloat( @"hash_14c1def95ce121bd", 0.3 );
    var_83d37edf201b2cfd = getdvarfloat( @"hash_93098a0e08755946", 1.25 );
    var_95511d95a93958e7 = getdvarfloat( @"hash_536499892b58e95e", 1.35 );
    var_e5ee15bc1309375a = getdvarfloat( @"hash_acced39991c29cb3", 0.85 );
    var_66b304267f9502e = getdvarfloat( @"hash_cd441cc7617451f7", 0.9 );
    var_d425946c0ecce92b = getdvarfloat( @"hash_44ebf81654faa862", 0.8 );
    var_e8ac91a5ef2b0fd1 = getdvarfloat( @"hash_1b40c53e2d9eb2d4", 0.65 );
    var_620f76de54a96190 = getdvarfloat( @"hash_88b55bd079acfa7d", 2.4 );
    var_18e2266ff0e121f5 = getdvarfloat( @"hash_e1e5364d971cb108", 1.15 );
    var_64021406c1e284a4 = getdvarfloat( @"hash_5e0485e183778b51", 0.35 );
    var_4902ecca444e0a0a = getdvarfloat( @"hash_1c1c2301d5399443", 0.55 );
    var_4b7fa7312581b7d3 = getdvarfloat( @"hash_fb4e6412ce615e9a", 0.7 );
    var_fcfd161a0dc116dc = getdvarfloat( @"hash_c3521842fa5716b9", 1.2 );
    var_16ae1125a6a7d307 = getdvarfloat( @"hash_f959b6fada5c263e", 0.6 );
    var_bcf3b1b24a202f81 = getdvarfloat( @"hash_b9f274e1bdf009c4", 1.4 );
    var_34b477322b758a7a = getdvarfloat( @"hash_1548254c341894d3", 1.25 );
    var_5224d35948c59281 = getdvarfloat( @"hash_afd70161b660ab2c", 0.15 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_17333ce441d64a81", 1 );
    var_dc55a273e67437dd = getdvarfloat( @"hash_6f570db7be0f8fe0", 1 );
    var_6595dcc72d98ee64 = getdvarfloat( @"hash_597a9637de621271", 1 );
    var_2ff583bbbb170181 = getdvarfloat( @"hash_c9cae2db8305e1c4", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_8fe5aa665535c53e", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_6a964aec8645a8ec", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_72e6e2904f52dd8e", 0.6 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_4be21b0090a1d236", 0.125 );
    var_d0977b6cf774e182 = getdvarfloat( @"hash_e18672ffcb7e932b", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_740e2c72d1718de1", 0.1 );
    var_a0bcd9de844d765d = getdvarfloat( @"hash_b79730dfd6999e80", 1.3 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_c5dc81f6013f479a", 1 );
    var_74e212ac00fe353 = getdvarfloat( @"hash_2d2db37dd9ede53a", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_6a214679fd99c030", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_f4f30f34194208f5", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_4b773b9be4b9991b", 0.6 );
    var_73d2a49b241e06e7 = getdvarfloat( @"hash_c7a253daf7ff775e", 0.26 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_2c372709a406d51b", 0.4 );
    var_77a41101b7511127 = getdvarfloat( @"hash_f225bebcbb41935e", 0.4 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_9a6043ea46aca893", 0.2 );
    var_dc3ec7b9494c335b = getdvarfloat( @"hash_145e7e789554a946", 0.72 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_46fe41564846476a", 0.4 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_58e8e5ceb59a3f47", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_cfa1e821a81c6d00", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_5424e7266f2f889e", 0.4 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_9786200fb4c90293", 0.7 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_bd3c106593716227", 1 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    var_1c5a5fe66c8c0724 = self.var_50718c08923dcdbb && self.health <= int( self.maxhealth * self.var_f8115155adde44d[ self.bossfightphase - 1 ] );
    var_e61527db42062cc1 = self getaiblackboarddynamic( "in_intro_sequence" );
    
    if ( var_1c5a5fe66c8c0724 )
    {
        damage *= var_94b67e97b730d03f;
    }
    
    if ( var_e61527db42062cc1 )
    {
        damage *= var_4c2a0f4937888418;
    }
    
    if ( weakspotdata )
    {
        if ( params.metabonename != "eye_left" && params.metabonename != "eye_right" && params.vpoint && params.vdir )
        {
            var_4f22ddb90a93fb15 = utility::getfx( "diana_weakspot_imapct_vfx" );
            var_30625e41d23fd878 = anglestoforward( vectortoangles( params.vdir ) );
            
            if ( var_4f22ddb90a93fb15 )
            {
                playfx( var_4f22ddb90a93fb15, params.vpoint, var_30625e41d23fd878 );
            }
        }
        else if ( params.metabonename == "eye_left" )
        {
            utility::function_32b24db3127bff40( "eye_le_impact", "weakpoint_impact" );
        }
        else if ( params.metabonename == "eye_right" )
        {
            utility::function_32b24db3127bff40( "eye_ri_impact", "weakpoint_impact" );
        }
    }
    
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
        is_hornet_ww = issubstr( params.objweapon.basename, "ww_hornet_zm" );
        
        if ( is_hornet_ww )
        {
            paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
            
            switch ( paplevel ?? 0 )
            {
                case 4:
                    damage = var_d317b576a4de4a0d;
                    
                    if ( armordata )
                    {
                        damage = var_ef33893ed76c1205;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_7350c757937217fc;
                    }
                    
                    break;
                case 3:
                    damage = var_d317ae76a4de3aa8;
                    
                    if ( armordata )
                    {
                        damage = var_ef33823ed76c02a0;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_7350c657937215c9;
                    }
                    
                    break;
                case 2:
                    damage = var_d317af76a4de3cdb;
                    
                    if ( armordata )
                    {
                        damage = var_ef33833ed76c04d3;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_7350c55793721396;
                    }
                    
                    break;
                case 1:
                    damage = var_d317b076a4de3f0e;
                    
                    if ( armordata )
                    {
                        damage = var_ef33843ed76c0706;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_7350c45793721163;
                    }
                    
                    break;
                case 0:
                default:
                    damage = var_d317b176a4de4141;
                    
                    if ( armordata )
                    {
                        damage = var_ef33853ed76c0939;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_7350c35793720f30;
                    }
                    
                    break;
            }
            
            if ( var_1c5a5fe66c8c0724 )
            {
                damage *= var_94b67e97b730d03f;
            }
            
            if ( var_e61527db42062cc1 )
            {
                damage *= var_4c2a0f4937888418;
            }
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
        
        iscrossbow = issubstr( params.objweapon.basename, "sl_crossbow" );
        
        if ( iscrossbow )
        {
            damage *= var_d48cf9ae0101f824;
            
            if ( weakspotdata )
            {
                damage *= var_d38e60852f9d06ed;
            }
        }
        
        var_7fdedb034882a3ec = issubstr( params.objweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
        
        ismanglercannon = issubstr( params.objweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7a37c47ccd17a049 = issubstr( params.objweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
            
            if ( weakspotdata )
            {
                damage *= var_73d2a49b241e06e7;
            }
        }
    }
    
    if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        isakita = issubstr( params.objweapon.basename, "akita" );
        isvulture = issubstr( params.objweapon.basename, "vulture" );
        
        if ( isvulture )
        {
            damage *= var_5224d35948c59281;
        }
        
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
        var_b564b55a357ad0a = issubstr( params.objweapon.basename, "ar_albatross" );
        
        if ( var_b564b55a357ad0a )
        {
            damage *= var_83d37edf201b2cfd;
        }
        
        var_e21b89a1a48eda24 = issubstr( params.objweapon.basename, "ar_egret" );
        
        if ( var_e21b89a1a48eda24 )
        {
            damage *= var_95511d95a93958e7;
        }
        
        var_f800804413f93d2a = issubstr( params.objweapon.basename, "ar_finch" );
        
        if ( var_f800804413f93d2a )
        {
            damage *= var_e5ee15bc1309375a;
        }
        
        var_2a51c3aa6c24cbdd = issubstr( params.objweapon.basename, "ar_heron" );
        
        if ( var_2a51c3aa6c24cbdd )
        {
            damage *= var_66b304267f9502e;
        }
        
        var_d2f5e7854e17e59c = issubstr( params.objweapon.basename, "ar_macaw" );
        
        if ( var_d2f5e7854e17e59c )
        {
            damage *= var_d425946c0ecce92b;
        }
        
        isrhino = issubstr( params.objweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
            
            if ( weakspotdata )
            {
                damage *= var_77a41101b7511127;
            }
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
        var_97497870082defe6 = issubstr( params.objweapon.basename, "lm_hades" );
        
        if ( var_97497870082defe6 )
        {
            damage *= var_e8ac91a5ef2b0fd1;
        }
        
        var_a95df4abd89a0a73 = issubstr( params.objweapon.basename, "lm_typhon" );
        
        if ( var_a95df4abd89a0a73 )
        {
            damage *= var_620f76de54a96190;
        }
        
        var_928626a121064218 = issubstr( params.objweapon.basename, "lm_zeus" );
        
        if ( var_928626a121064218 )
        {
            damage *= var_18e2266ff0e121f5;
        }
    }
    
    if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
        
        if ( weakspotdata )
        {
            damage *= var_83fec4317983085b;
        }
        
        var_8a43871038dc6168 = issubstr( params.objweapon.basename, "sn_drake" );
        
        if ( var_8a43871038dc6168 )
        {
            damage *= var_4b7fa7312581b7d3;
            
            if ( weakspotdata )
            {
                damage *= var_fcfd161a0dc116dc;
            }
        }
    }
    
    if ( arraycontains( [ "smg" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_3f56cee67435a21e;
        var_8ac364248fe9da03 = issubstr( params.objweapon.basename, "sm_orca" );
        
        if ( var_8ac364248fe9da03 )
        {
            damage *= var_64021406c1e284a4;
        }
        
        var_4ed004c75b6bb987 = issubstr( params.objweapon.basename, "sm_stoat" );
        
        if ( var_4ed004c75b6bb987 )
        {
            damage *= var_4902ecca444e0a0a;
        }
        
        var_a0793264c690be57 = issubstr( params.objweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    
    if ( issubstr( params.objweapon.basename, "oman" ) )
    {
        damage *= var_87adbecba0c9b50b;
    }
    
    if ( issubstr( params.objweapon.basename, "sn_baltic" ) )
    {
        damage *= var_16ae1125a6a7d307;
        
        if ( arraycontains( params.objweapon.attachments, "sat_ub_crossbar_sn_baltic" ) )
        {
            damage *= var_bcf3b1b24a202f81;
            
            if ( weakspotdata )
            {
                damage *= var_34b477322b758a7a;
            }
        }
    }
    
    if ( issubstr( params.objweapon.basename, "pi_atlas" ) )
    {
        damage *= var_e53b66a0bc564ac7;
        
        if ( weakspotdata )
        {
            damage *= var_e765f5af205d68c0;
        }
    }
    
    if ( issubstr( params.objweapon.basename, "pi_alcor" ) )
    {
        if ( weakspotdata )
        {
            damage *= var_c7f17ea704ca95d0;
        }
    }
    
    if ( issubstr( params.objweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
        
        if ( weakspotdata )
        {
            damage *= var_dc3ec7b9494c335b;
        }
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_69780c43058a5a83", var_b614da05a3be6674 );
        
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
            damage *= getdvarfloat( @"hash_dd2f53314c0564eb", var_74e212ac00fe353 );
        }
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_66222cab986d4dce", 0.35 );
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
    
    if ( issubstr( params.objweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    if ( getdvarint( @"hash_308871e6be295b74", 0 ) )
    {
        damage *= 25;
    }
    
    if ( damage >= self.health )
    {
        self.health = int( self.maxhealth * 0.01 );
        
        if ( !self.var_25e20a9045463946 )
        {
            self.var_25e20a9045463946 = 1;
            thread function_a805645c0f728aff( params );
        }
    }
    
    return damage;
}

// Namespace zombie_diana
// Params 1, eflags: 0x4
// Checksum 0x62cfc61, Offset: 0x23ec
// Size: 0x10b
function private function_a805645c0f728aff( params )
{
    if ( self getaiblackboarddynamic( "in_necrotic_projectile" ) || self getaiblackboarddynamic( "in_move" ) || self getaiblackboarddynamic( "in_summon_agni_zombies" ) || self getaiblackboarddynamic( "in_necrotic_beam" ) || self getaiblackboarddynamic( "in_necrotic_fan" ) || self getaiblackboarddynamic( "in_winged_tornado_attack" ) || self getaiblackboarddynamic( "in_armor_break" ) )
    {
        utility::waittill_any_in_array_or_timeout( [ "diana_move_end", "necrotic_projectile_end", "summon_agnis_end", "necrotic_beam_anim_end", "necrotic_fan_end", "winged_tornado_attack_end", "armor_break_end" ], 25 );
        
        if ( self.inflyover )
        {
            utility::waittill_notify_or_timeout( "move_fly_over_complete", 5.5 );
        }
    }
    
    asm::function_7256f5ba459c840b( "special_pain_in" );
    wait 2;
    self notify( #"diana_death_igc_transition" );
    self function_786bb6aa1b76c7ee( "in_death_sequence", 0 );
    level thread function_59f9edeae4147d3f( self, params );
}

// Namespace zombie_diana
// Params 2, eflags: 0x4
// Checksum 0xb06dc5c2, Offset: 0x24ff
// Size: 0x4ff
function private function_59f9edeae4147d3f( diana, params )
{
    var_8449f58ffb3b05aa = 1.5;
    var_f3d91defbf9c0b8d = 1;
    var_c92a4073bc5c5c7f = 0.2;
    var_c8f2a3acb5dba96f = 2;
    s_scene = utility::getstruct( "sat_cin_zm_vig_death_diana", "targetname" );
    s_scene thread scene::pre_stream();
    diana notify( #"hash_19a5f48a313fa8cd" );
    diana val::set( "zombie_diana", "ignoreall", 1 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player val::set( "zombie_diana", "ignoreme", 1 );
        player val::set( "zombie_diana", "damage", 0 );
        level thread utility::fadetoblackforplayer( player, 1, var_8449f58ffb3b05aa );
    }
    
    wait var_8449f58ffb3b05aa;
    utility::flag_wait_or_timeout( "diana_defeated_vo_played", 10 );
    diana notify( #"diana_fade_in_to_death_igc_complete" );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        
        if ( utility::getsharedfunc( #"zm_utility", #"force_revive_player" ) )
        {
            player utility::callsharedfunc( #"zm_utility", #"force_revive_player", undefined, player, 0 );
        }
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"deathigc" );
    var_5b3540b53b235dcc = 0;
    a_shot_names = s_scene scene::get_shot_names();
    
    foreach ( str_shot in a_shot_names )
    {
        var_5b3540b53b235dcc += s_scene scene::function_b3c7b792a7a154fa( str_shot );
    }
    
    diana val::set( "zombie_diana", "hide", 1 );
    wait var_f3d91defbf9c0b8d;
    s_scene scene::set_notify_state( level, "death_scene_done" );
    s_scene thread scene::play();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        level thread utility::fadetoblackforplayer( player, 0, 0.25 );
    }
    
    if ( var_5b3540b53b235dcc > var_c92a4073bc5c5c7f )
    {
        wait var_5b3540b53b235dcc - var_c92a4073bc5c5c7f;
    }
    
    foreach ( player in level.players )
    {
        level thread utility::fadetoblackforplayer( player, 1, var_c92a4073bc5c5c7f );
    }
    
    s_scene_outro = utility::getstruct( "sat_cin_zm_hornet_outro", "targetname" );
    
    if ( isdefined( s_scene_outro ) )
    {
        s_scene_outro thread scene::pre_stream();
    }
    
    level utility::waittill_notify_or_timeout( "death_scene_done", 15 );
    wait var_c8f2a3acb5dba96f;
    diana val::reset( "zombie_diana" );
    diana kill( diana.origin, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
    utility::flag_set( "diana_death_igc_complete" );
    waitframe();
    
    foreach ( player in level.players )
    {
        level thread utility::fadetoblackforplayer( player, 0, 0.25 );
        player val::reset_all( "zombie_diana" );
    }
}

// Namespace zombie_diana
// Params 1, eflags: 0x4
// Checksum 0xe05bdd99, Offset: 0x2a06
// Size: 0x2a
function private play_death_fx( params )
{
    if ( params.body )
    {
        params.body delete();
    }
}

// Namespace zombie_diana
// Params 1, eflags: 0x4
// Checksum 0xe965bca0, Offset: 0x2a38
// Size: 0x17
function private function_d9f177d8cb8e47e( params )
{
    self.var_50718c08923dcdbb = 1;
}

// Namespace zombie_diana
// Params 0
// Checksum 0xd06521f0, Offset: 0x2a57
// Size: 0xae
function function_9cc2b48802345520()
{
    foreach ( player in level.players )
    {
        if ( isalive( self ) )
        {
            if ( !self.var_382b3e1f72536e3c )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_diana_healthbar", self );
            }
            else
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_immune();
            }
            
            continue;
        }
        
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zombie_diana
// Params 2
// Checksum 0xf86f7286, Offset: 0x2b0d
// Size: 0x128
function function_a05652f49bf7b98a( taskid, params )
{
    var_4ec75972615abcfb = 1;
    var_41843da23a1fb735 = 2.5;
    cooldownmin = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_eb5ab520902bc5ab;
    cooldownmax = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_eb37cb209005ae55;
    
    if ( self.var_f9e48b7ff2c39654.size > 0 && self.var_f9e48b7ff2c39654[ 0 ] == "necrotic_beam" )
    {
        cooldownmin += var_4ec75972615abcfb;
        cooldownmax += var_4ec75972615abcfb;
    }
    else if ( self.var_f9e48b7ff2c39654.size > 0 && self.var_f9e48b7ff2c39654[ 0 ] == "necrotic_fan" )
    {
        cooldownmin += var_41843da23a1fb735;
        cooldownmax += var_41843da23a1fb735;
    }
    
    var_39db3a60e16ee0d1 = int( utility::function_4b74c15943231980( randomfloatrange( cooldownmin, cooldownmax ) ) );
    self function_786bb6aa1b76c7ee( "combat_action_cooldown", gettime() + var_39db3a60e16ee0d1 );
    self function_786bb6aa1b76c7ee( "set_action_cooldown", 0 );
    return anim.success;
}

/#

    // Namespace zombie_diana
    // Params 0
    // Checksum 0x4feedd7c, Offset: 0x2c3e
    // Size: 0x47, Type: dev
    function function_59cc9226f19857ec()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x52>", &function_7ae218b7ae882503, 1 );
        devgui::add_devgui_func( "<dev string:x6f>", "<dev string:x85>", &function_93bba488ecf463d8, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana
    // Params 1
    // Checksum 0x98549136, Offset: 0x2c8d
    // Size: 0x5a, Type: dev
    function function_93bba488ecf463d8( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x9d>" );
        
        if ( isdefined( diana ) && isalive( diana ) )
        {
            diana.health = 1;
        }
    }

    // Namespace zombie_diana
    // Params 1
    // Checksum 0x7c98b155, Offset: 0x2cef
    // Size: 0xbf, Type: dev
    function function_7ae218b7ae882503( params )
    {
        if ( !isdefined( level.var_6bbd8ed801846ad8 ) )
        {
            level.var_6bbd8ed801846ad8 = 0;
        }
        
        level.var_6bbd8ed801846ad8 = !level.var_6bbd8ed801846ad8;
        iprintln( "<dev string:xaa>" + ( level.var_6bbd8ed801846ad8 ? "<dev string:xc2>" : "<dev string:xc5>" ) );
        
        if ( !level.var_6bbd8ed801846ad8 )
        {
            return;
        }
        
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x9d>" );
        
        if ( isdefined( diana ) )
        {
            diana thread function_5468f09b7bdb19d4();
            return;
        }
        
        iprintln( "<dev string:xc9>" );
        level.var_6bbd8ed801846ad8 = 0;
    }

    // Namespace zombie_diana
    // Params 0, eflags: 0x4
    // Checksum 0x275e4209, Offset: 0x2db6
    // Size: 0x62a, Type: dev
    function private function_5468f09b7bdb19d4()
    {
        self endon( #"death" );
        info_color = ( 1, 1, 0 );
        var_8df03247a75f2e7c = ( 1, 1, 1 );
        winner_color = ( 0, 1, 0 );
        
        while ( level.var_6bbd8ed801846ad8 )
        {
            var_38ba5acedcedb599 = zombie_diana_targeting::function_10d6f02505095c17( 0, undefined );
            var_63f2e20b477b6b = zombie_diana_targeting::function_78f078359188e6c7( 0, undefined );
            var_2974b8b806eb13b = zombie_diana_targeting::function_2f460c8a53065b7f( 0, undefined );
            talismanscore = zm_sat_hornet_talisman::function_96e2e12ddf2498e5( 0, undefined );
            movecd = zombie_diana_move::function_9a8a210f3bc285e9( 0, undefined );
            moverep = zombie_diana_move::function_45950a19ede544a3( 0, undefined );
            movetotal = movecd * moverep * var_38ba5acedcedb599 * var_63f2e20b477b6b;
            flycd = zombie_diana_move::function_f9e38c6ac25d9e73( 0, undefined );
            flyphase = zombie_diana_move::function_83e525487564462d( 0, undefined );
            flyrep = zombie_diana_move::function_db31e403339a5e63( 0, undefined );
            flytotal = flycd * flyphase * flyrep * var_38ba5acedcedb599 * var_2974b8b806eb13b;
            projlos = zombie_diana_targeting::function_2b33707ad8c5ac95( 0, undefined );
            projcd = zombie_diana_necrotic_projectile::function_9e247b8febfbdae0( 0, undefined );
            projrep = zombie_diana_necrotic_projectile::function_4b1479d8d62f435a( 0, undefined );
            projtotal = projlos * projcd * projrep * var_2974b8b806eb13b;
            beamlos = zombie_diana_targeting::function_b7c73a02d9ed9751( 0, undefined );
            beamcd = zombie_diana_necrotic_beam::function_4f40e1bd28157c18( 0, undefined );
            beamrep = zombie_diana_necrotic_beam::function_7581cc981b5c4302( 0, undefined );
            var_3e3aa3c64f865598 = zombie_diana_targeting::function_5f58749846f33a09( 0, undefined );
            beamtotal = beamlos * beamcd * beamrep * var_3e3aa3c64f865598 * talismanscore * var_2974b8b806eb13b;
            agnicd = zombie_diana_summon_agni_zombies::function_53270f5108d8c335( 0, undefined );
            agnirep = zombie_diana_summon_agni_zombies::function_5ba912c8446fe909( 0, undefined );
            agnitotal = agnicd * agnirep * var_38ba5acedcedb599 * var_2974b8b806eb13b;
            fancd = zombie_diana_necrotic_fan::function_7d6b05af39c385d2( 0, undefined );
            fanrep = zombie_diana_necrotic_fan::function_4f6dc6642e3076e0( 0, undefined );
            fantotal = fancd * fanrep * var_63f2e20b477b6b;
            tornadophase = zombie_diana_winged_tornado_attack::function_6f9caac5837a4d5d( 0, undefined );
            tornadocd = zombie_diana_winged_tornado_attack::function_1cb2023a9be7540f( 0, undefined );
            tornadorep = zombie_diana_winged_tornado_attack::function_ed516f5f939ae3b3( 0, undefined );
            tornadototal = tornadophase * tornadocd * tornadorep * talismanscore * var_63f2e20b477b6b;
            sequencenames = [ "<dev string:xf6>", "<dev string:xfb>", "<dev string:x103>", "<dev string:x10b>", "<dev string:x113>", "<dev string:x118>", "<dev string:x11f>" ];
            sequencescores = [ movetotal, flytotal, projtotal, beamtotal, agnitotal, fantotal, tornadototal ];
            winneridx = 0;
            
            for ( i = 1; i < sequencescores.size ; i++ )
            {
                if ( sequencescores[ i ] > sequencescores[ winneridx ] )
                {
                    winneridx = i;
                }
            }
            
            lastatk = "<dev string:x127>";
            
            if ( self.var_f9e48b7ff2c39654.size > 0 )
            {
                lastatk = self.var_f9e48b7ff2c39654[ 0 ];
            }
            
            level debug::function_298a6c4895b8935d( ( 400, 600, 0 ) );
            level debug::function_ce323c1a383e915( "<dev string:x12c>" + self.bossfightphase + "<dev string:x149>" + lastatk + "<dev string:x153>", info_color );
            level debug::function_ce323c1a383e915( "<dev string:x159>" + var_38ba5acedcedb599 + "<dev string:x168>" + var_63f2e20b477b6b + "<dev string:x16f>" + var_2974b8b806eb13b + "<dev string:x176>" + talismanscore, info_color );
            level debug::function_ce323c1a383e915( "<dev string:x17c>" + movetotal + "<dev string:x186>" + movecd + "<dev string:x18c>" + moverep + "<dev string:x192>" + var_38ba5acedcedb599 + "<dev string:x168>" + var_63f2e20b477b6b + "<dev string:x19a>", winneridx == 0 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x19c>" + flytotal + "<dev string:x186>" + flycd + "<dev string:x1a6>" + flyphase + "<dev string:x18c>" + flyrep + "<dev string:x192>" + var_38ba5acedcedb599 + "<dev string:x16f>" + var_2974b8b806eb13b + "<dev string:x19a>", winneridx == 1 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1ae>" + projtotal + "<dev string:x1b8>" + projlos + "<dev string:x1bf>" + projcd + "<dev string:x18c>" + projrep + "<dev string:x16f>" + var_2974b8b806eb13b + "<dev string:x19a>", winneridx == 2 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1c4>" + beamtotal + "<dev string:x1b8>" + beamlos + "<dev string:x1bf>" + beamcd + "<dev string:x18c>" + beamrep + "<dev string:x1ce>" + var_3e3aa3c64f865598 + "<dev string:x176>" + talismanscore + "<dev string:x16f>" + var_2974b8b806eb13b + "<dev string:x19a>", winneridx == 3 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1d4>" + agnitotal + "<dev string:x186>" + agnicd + "<dev string:x18c>" + agnirep + "<dev string:x192>" + var_38ba5acedcedb599 + "<dev string:x16f>" + var_2974b8b806eb13b + "<dev string:x19a>", winneridx == 4 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1de>" + fantotal + "<dev string:x186>" + fancd + "<dev string:x18c>" + fanrep + "<dev string:x168>" + var_63f2e20b477b6b + "<dev string:x19a>", winneridx == 5 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1e8>" + tornadototal + "<dev string:x1f2>" + tornadophase + "<dev string:x1bf>" + tornadocd + "<dev string:x18c>" + tornadorep + "<dev string:x176>" + talismanscore + "<dev string:x168>" + var_63f2e20b477b6b + "<dev string:x19a>", winneridx == 6 ? winner_color : var_8df03247a75f2e7c );
            level debug::function_ce323c1a383e915( "<dev string:x1fb>" + sequencenames[ winneridx ] + "<dev string:x208>" + sequencescores[ winneridx ] + "<dev string:x20b>", winner_color );
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

#/
