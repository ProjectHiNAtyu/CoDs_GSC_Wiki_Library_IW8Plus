// script_4b3372ce2591dc50  (hash_4b3372ce2591dc50.gscc) (size: 15388 Bytes / 0x3c1c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa1079c4 (4195383748)
// size ...... 15388 (0x3c1c)
// includes .. 7   (offset: 0x3860)
// strings ... 43  (offset: 0x3898)
// dev strs .. 0   (offset: 0x3c1c)
// exports ... 9   (offset: 0x2f78)
// cseg ...... 0x31c + 0x2c5c (0x2f78)
// imports ... 29  (offset: 0x30e0)
// animtree1 . 0   (offset: 0x3c1c)
// animtree2 . 0   (offset: 0x3c1c)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace zombie_wither;

// Namespace zombie_wither
// Params 1, eflags: 0x4
// Checksum 0x7d9d982e, Offset: 0x33a
// Size: 0xc
function private function_d3a3f72b3299a008( params )
{
    
}

// Namespace zombie_wither
// Params 1
// Checksum 0xaa9af945, Offset: 0x34e
// Size: 0x1d4
function function_3a5c9d982a3fdca1( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    
    if ( self.subclass == "zombie_wither_bomb" )
    {
        self.var_de67cb8723283501 = 1;
        utility::ent_flag_set( "zombie_asm_init_finished" );
    }
    
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    self.nocorpse = undefined;
    self.noragdoll = 1;
    self.script_noragdoll = 1;
    self.allowstrafe = 0;
    self.prevent_knockdown = 1;
    
    switch ( self.subclass )
    {
        case #"hash_a38a8f1e60b2e94":
        case #"hash_9aba444aeda95fcd":
            self.var_1e0c6c188b1cfd56 = "j_head";
            break;
        case #"hash_bd1aa87d8ed98be0":
            self.var_1e0c6c188b1cfd56 = "tag_origin";
            break;
        case #"hash_9de4699c88b66354":
            self.var_1e0c6c188b1cfd56 = "j_spine4";
            break;
    }
    
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    self enabletraversals( 0 );
    self function_43a971093c992365( 1 );
    callback::add( "on_first_ai_init", &function_d3a3f72b3299a008 );
    callback::add( "killed_body_cloned", &function_59e3b237f613fcef );
    
    switch ( self.subclass )
    {
        case #"hash_bd1aa87d8ed98be0":
            zombie_utils::function_dfae6a5bd222c586( &function_42b0c7035582a10e );
            break;
        case #"hash_a38a8f1e60b2e94":
            zombie_utils::function_dfae6a5bd222c586( &function_92d41fdd5de337e2 );
            break;
        case #"hash_9aba444aeda95fcd":
            zombie_utils::function_dfae6a5bd222c586( &function_e48d40fd3b9b84ad );
            break;
        case #"hash_9de4699c88b66354":
            self function_66dc8b6ae969f66d( 1 );
            zombie_utils::function_dfae6a5bd222c586( &function_faba622cd823ee5a );
            break;
    }
    
    return anim.success;
}

// Namespace zombie_wither
// Params 1, eflags: 0x4
// Checksum 0x7792c94e, Offset: 0x52b
// Size: 0xa24
function private function_42b0c7035582a10e( params )
{
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_3ff6735a516a741e", 1 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_d43be7606c36a985", 0.65 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_65cd8d5b13d70b7e", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_d18e524a9d9064ad", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_ee1071371ccf06e3", 1.5 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_7a7f6002b694a49f", 1 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_8446264d18045c54", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_e6f6d7fcb09b5b1b", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_638874b529eb9f64", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_d7d393204a2bad10", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_1dbe195e503260ef", 2 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_8a5f0c03a7730a7", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_490c37ffbeea959b", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_226d0d9e4a594b4f", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_f4a5e29e35967f3b", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_65f35ec5bcf1b43", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_3973eb497eea7f53", 1 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_eac2cb61d07a38b", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_ce9c15c369a7b7fc", 1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_75567221d5610ae3", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_408d3cd2eeadc5e7", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_8038c7d56257e31c", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_30859da801eca520", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_4cdf9f40ae5bbd40", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_a0fe9e2a0bfdaae4", 1 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_a8ec9dad08bfe9af", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_6944631f4f4ed3a4", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_e6616f7804e9c4e7", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_afb29c884ce0e383", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_6d8e22292e8525cc", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_c8dc599e767d2e96", 1 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
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
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        damage *= var_5ed48d2a95f6cd41;
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    return int( damage );
}

// Namespace zombie_wither
// Params 1, eflags: 0x4
// Checksum 0xc7b3ac51, Offset: 0xf58
// Size: 0xadd
function private function_92d41fdd5de337e2( params )
{
    if ( self.var_70e2cd76631d2140 && params.smeansofdeath == "MOD_MELEE" && isplayer( params.eattacker ) )
    {
        return self.health;
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_9f9bcfe5473ef132 = getdvarfloat( @"hash_8e495c0c842b0579", 0.03 );
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_106e3ce4fd0f5182", 1 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_61c05fbb80be8e69", 0.6 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_5dd296ba30a14c0a", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_df841cb089a17c1", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_fc2c5b36100d4dc7", 1.5 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_c488d07014df323b", 1 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_6a8455e3321e58d8", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_277e39e371f49e4f", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_781dc3538b373458", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_94f5cfef5422cd74", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_d4a362e82ffa9433", 1.75 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_6e20efa89e3dfe23", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_601488e11fbae0e7", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_226d0d9e4a594b4f", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_522ffcabe504e307", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_b303519abf67542f", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_ecd0b9feef1595a7", 1 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_68d9292cd8ac551f", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_195f68c1cacc3150", 1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_2ac88ccf96e0b967", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_c092759a383cc853", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_b24cf350e35dddb0", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_132e1588965685dc", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_8ea386f84c874a4c", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_ab41bbcb701dc4d0", 1 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_9de2d1ebbff2afdb", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_6fea3eaea0ddb340", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_584a5a47bc162cb", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_9b42a5d50530bf2f", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_a1543d17782a8bd0", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_6127ea01b0af5b2", 1 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
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
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        damage *= var_5ed48d2a95f6cd41;
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    if ( self.shadow_soul_shield_active )
    {
        params.var_4f9d5587bf9a2b1e = 1;
        damage *= var_9f9bcfe5473ef132;
        var_1d4d1f382e7d2c0c = utility::getfx( "shadow_soul_shield_impact_immune" );
        
        if ( isdefined( var_1d4d1f382e7d2c0c ) && isdefined( params.vpoint ) )
        {
            playfx( var_1d4d1f382e7d2c0c, params.vpoint );
        }
    }
    
    return int( damage );
}

// Namespace zombie_wither
// Params 1, eflags: 0x4
// Checksum 0x1c08c1ba, Offset: 0x1a3e
// Size: 0xa24
function private function_e48d40fd3b9b84ad( params )
{
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_900f78ff423ff3cd", 1 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_c57bfd5cd5086292", 0.5 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_f132d7894ec87749", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_921466a1fb8310bc", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_c2a220b59e455538", 1 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_8486495720ab3f8c", 1 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_925e386c946969cb", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_39a0b4177dde644c", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_1cc538f1d4dd967d", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_55be567ccafd9c4b", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_ef553b9ea00aad98", 1.5 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_efc2712b29ba431a", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_af6b06182e8418", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_226d0d9e4a594b4f", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_5c0a9d6f21935348", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_3cbbcbf09a7e9fee", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_90bcaa8cd725a780", 1 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_2bd7efa8561b4918", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_86c7e39e92809083", 1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_238c16b9534f20c4", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_fe95b68c78be30ce", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_dd387d1160fb6f03", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_ef1fadc59e9833c5", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_5312f0fef890674d", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_f7cde5b07d8a67fd", 1 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_e6382ab2f0bd9370", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_d529d396dce461d9", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_13b0e1f218242bd2", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_4e8904fb5ff3ba8", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_ae81ec5a8344d2b5", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_791966570dbb4f01", 1 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
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
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        damage *= var_5ed48d2a95f6cd41;
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    return int( damage );
}

// Namespace zombie_wither
// Params 1, eflags: 0x4
// Checksum 0x33aaef58, Offset: 0x246b
// Size: 0xa62
function private function_faba622cd823ee5a( params )
{
    if ( self.var_70e2cd76631d2140 && params.smeansofdeath == "MOD_MELEE" && isplayer( params.eattacker ) )
    {
        return self.health;
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_ead96e72849a7d54", 1 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_501468342c625ab", 0.25 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_7c097a6529e327d4", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_911e686a3ff055a3", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_4f396e8eab3964ed", 1 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_23417194f4a6252d", 1 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_ef95a33bf9f17066", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_8ebe3c549010c579", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_e3ee6e3b050eb1a6", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_efb8660d5e819782", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_ecac5e9bfefb17f1", 1 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_6731538edf095919", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_ae4ea03312a59099", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_717ba3aa9b0e2ecc", 2 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_62b41f5df74ecb49", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_f9799420f31772f9", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_5b3e51aecfbfb059", 1 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_f459e66bc94c9b61", 1 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_95f03547e7b7f012", 1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_9899f0017d4e8281", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_2bcf149934c908f1", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_4a3682a955ca107e", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_850566368583ed46", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_35c225102579f7fe", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_9b1457587e911b2a", 1 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_59e152186e5d0f09", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_b4a4339985404152", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_eba353d248f71f3d", 0.4 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_b7dee8f993a2c301", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_782725ff10c2fef2", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_e82da0ef5a8f3b34", 1 );
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
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
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        damage *= var_5ed48d2a95f6cd41;
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= var_4a0cd941a5b615d1;
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        
        if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        
        if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        damage *= var_2067935b2ea13ba;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
    {
        damage *= var_3b1f952caa88011e;
    }
    
    return int( damage );
}

// Namespace zombie_wither
// Params 1
// Checksum 0x15cf4558, Offset: 0x2ed6
// Size: 0x84
function function_59e3b237f613fcef( params )
{
    if ( isdefined( params.body ) )
    {
        params.body.noragdoll = 1;
        wait 0.25;
        
        if ( isdefined( params.body ) )
        {
            params.body utility::function_7c10ea82c1e305b8( "wither_fx", "death" );
        }
        
        waitframe();
        
        if ( isdefined( params.body ) )
        {
            params.body delete();
        }
    }
}

// Namespace zombie_wither
// Params 1
// Checksum 0x1c7e336c, Offset: 0x2f62
// Size: 0x15
function function_6a29a724b2396239( taskid )
{
    return anim.success;
}

