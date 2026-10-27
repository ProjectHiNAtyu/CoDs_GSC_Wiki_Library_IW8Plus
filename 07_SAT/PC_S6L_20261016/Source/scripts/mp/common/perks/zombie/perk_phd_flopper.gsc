// scripts\mp\common\perks\zombie\perk_phd_flopper.gsc  (hash_2167bb17f6da435d.gscc) (size: 15626 Bytes / 0x3d0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c41590b (2353092875)
// size ...... 15626 (0x3d0a)
// includes .. 16  (offset: 0x395e)
// strings ... 43  (offset: 0x39de)
// dev strs .. 14  (offset: 0x3c56)
// exports ... 25  (offset: 0x2802)
// cseg ...... 0x4e9 + 0x2319 (0x2802)
// imports ... 115 (offset: 0x2bea)
// animtree1 . 0   (offset: 0x3d0a)
// animtree2 . 0   (offset: 0x3d0a)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\currency;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipmentroundscaling;
#using scripts\mp\outofbounds;

#namespace perk_phd_flopper;

// Namespace perk_phd_flopper
// Params 0, eflags: 0x5
// Checksum 0xe9c28baa, Offset: 0x507
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_phd_flopper", undefined, &__init__, undefined );
}

// Namespace perk_phd_flopper
// Params 0
// Checksum 0x89cdf578, Offset: 0x524
// Size: 0xa
function __init__()
{
    level thread perk_phd_flopper_init();
}

// Namespace perk_phd_flopper
// Params 0
// Checksum 0x98c1e785, Offset: 0x536
// Size: 0x121
function perk_phd_flopper_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_phd_flopper" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_phd_flopper" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_phd_flopper" );
    level thread zombie_perks::enable_perk_for_level( "specialty_phd_flopper", str_currency, var_fcb7626c79b3c98f, &function_fab4f1a891d1f478, &function_ff957ad430e7cbea );
    level._effect[ "perk_phd_explode_sm" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_perk_pdh_explo" );
    level._effect[ "perk_phd_explode_md" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_perk_pdh_explo_med" );
    level._effect[ "perk_phd_explode_lg" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_perk_pdh_explo_lg" );
    damage::register_scripted_damage_override_func( &flopper_damage_override_func );
    level.perk_phd_flopper_throttle = throttle::throttle_initialize( "perk_phd_flopper", 2 );
    level utility::flag_set( "specialty_phd_flopper" + "init_complete" );
    utility::registersharedfunc( "specialty_phd_flopper", #"hash_6740cbe62b8dfc98", &function_58ec2d2f2ecbcddb );
}

// Namespace perk_phd_flopper
// Params 1
// Checksum 0x155caa7b, Offset: 0x65f
// Size: 0x21
function function_fab4f1a891d1f478( params )
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_phd_flopper" );
    childthread function_fb78d8c794488295( params );
}

// Namespace perk_phd_flopper
// Params 4
// Checksum 0xe54f2a39, Offset: 0x688
// Size: 0x2e
function function_ff957ad430e7cbea( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_fd9f97bb31254487();
}

// Namespace perk_phd_flopper
// Params 0
// Checksum 0x72ca64c, Offset: 0x6be
// Size: 0x1a
function function_fd9f97bb31254487()
{
    self notify( #"stop_dtp_fall_watcher" );
    zombie_perks::function_25539251d02082( "specialty_phd_flopper" );
}

// Namespace perk_phd_flopper
// Params 10
// Checksum 0x55eea604, Offset: 0x6e0
// Size: 0xc5
function flopper_damage_override_func( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( zombie_perks::has_perk( "specialty_phd_flopper" ) && !eattacker.var_a7339c2c551e2788 )
    {
        var_cf6abaccafe3cfbe = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_safe_slide" ) );
        var_5454f57201136c19 = 0;
        return function_bcaee79e28ebd4bf( var_5454f57201136c19, var_cf6abaccafe3cfbe, einflictor, eattacker, idamage, smeansofdeath, objweapon );
    }
}

// Namespace perk_phd_flopper
// Params 7
// Checksum 0x3fa1431c, Offset: 0x7ae
// Size: 0x2fe
function function_bcaee79e28ebd4bf( floppermodifieddamage, var_cf6abaccafe3cfbe, einflictor, eattacker, idamage, smeansofdeath, objweapon )
{
    switch ( smeansofdeath )
    {
        case #"hash_b15027ffbdc0ecb":
            if ( self isdiving() || self isactiverolling() )
            {
                return floppermodifieddamage;
            }
            
            break;
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a86d8c43482948a4":
        case #"hash_c22b13f81bed11f0":
            if ( eattacker === self )
            {
                return floppermodifieddamage;
            }
            
            break;
        case #"hash_a911a1880d996edb":
            equipref = equipment_mp::function_fdc4a655fbde0dec( objweapon.basename );
            
            if ( isdefined( equipref ) )
            {
                switch ( equipref )
                {
                    case #"hash_142a787e36d7d7ce":
                    case #"hash_311ee0f6295873c1":
                    case #"hash_4320d77f90725183":
                    case #"hash_4b6ab8d07b349016":
                        return floppermodifieddamage;
                }
            }
            
            killstreakref = killstreak::getkillstreaknamefromweapon( objweapon );
            
            if ( isdefined( killstreakref ) )
            {
                switch ( killstreakref )
                {
                    case #"hash_4d2e080857f4ddbe":
                    case #"hash_b4ac3581c343a029":
                        return floppermodifieddamage;
                }
            }
            
            if ( eattacker.owner === self && eattacker.streakname == "ground_drone_unit" )
            {
                return floppermodifieddamage;
            }
            
            if ( isdefined( equipref ) && eattacker === self && equipref == "equip_molotov" )
            {
                return floppermodifieddamage;
            }
            
            if ( eattacker === self && isarray( level.rockablecars.cars ) && einflictor && arraycontains( level.rockablecars.cars, einflictor ) )
            {
                return floppermodifieddamage;
            }
            
            if ( !isdefined( equipref ) && isdefined( objweapon ) && objweapon.basename == "t10_ied_mp" && eattacker === self )
            {
                return floppermodifieddamage;
            }
            
            break;
        case #"hash_ae0707fb5f8f9655":
        case #"hash_d8646db4e6ee3658":
            if ( eattacker === self && einflictor.classname == "grenade" || var_cf6abaccafe3cfbe && self issprintsliding() )
            {
                return floppermodifieddamage;
            }
            
            break;
        case #"hash_daad53adb4557616":
            isoob = outofbounds::isoob( self );
            isvalidzone = istrue( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", self.origin ) );
            
            if ( var_cf6abaccafe3cfbe && !isoob && isvalidzone && self issprintsliding() )
            {
                return floppermodifieddamage;
            }
            
            break;
        case #"hash_f20a45acf43bdb30":
            if ( objweapon.classname == "grenade" )
            {
                return floppermodifieddamage;
            }
            
            break;
    }
}

// Namespace perk_phd_flopper
// Params 4
// Checksum 0x17339ec3, Offset: 0xab5
// Size: 0x682
function flopper_explode( attacker, var_51ef870503967f06, augmentused, params )
{
    attacker callback::callback( #"hash_9456270bf9577eb1" );
    bundle = level.perkbundles[ "specialty_phd_flopper" ];
    
    if ( isdefined( params ) )
    {
        n_base_height = params.base_height ?? 96;
        n_base_radius = params.base_radius ?? 300;
        var_349d86d21f41eaa0 = params.dive_base_radius ?? 300;
        var_edde811fb15b364d = params.slide_base_radius ?? 300;
        n_base_min_damage = params.var_578d71b7c00fc4ba ?? 150;
        var_b85fd4acf4359eb1 = params.height_step ?? 32;
        n_base_damage_step = params.damage_step ?? 50;
        n_boost_source = params.boost_source ?? "HEIGHT";
        var_b735e7458084cc99 = params.medium_radius_multiplier ?? 2;
        var_5c2b49b1577449ea = params.big_radius_multiplier ?? 4;
        var_7a0fdf619e527e52 = params.explosion_vfx ?? "perk_phd_explode_sm";
        var_b5ec61eeadb4d23f = params.explosion_vfx ?? "perk_phd_explode_md";
        var_c384e4882469592f = params.explosion_vfx ?? "perk_phd_explode_lg";
        s_mod = params.smeansofdeath ?? "MOD_EXPLOSIVE";
    }
    else
    {
        n_base_height = bundle.var_780c4632c0f4b55f ?? 96;
        n_base_radius = bundle.var_f84b315c44aff282 ?? 300;
        var_349d86d21f41eaa0 = 300;
        var_edde811fb15b364d = 300;
        n_base_min_damage = bundle.var_76d0bf6ffba85b41 ?? 150;
        var_b85fd4acf4359eb1 = bundle.var_e5111f927a5a5d8d ?? 32;
        n_base_damage_step = bundle.var_bd5f0d79b9988ba7 ?? 50;
        n_boost_source = "HEIGHT";
        var_b735e7458084cc99 = 2;
        var_5c2b49b1577449ea = 4;
        var_7a0fdf619e527e52 = "perk_phd_explode_sm";
        var_b5ec61eeadb4d23f = "perk_phd_explode_md";
        var_c384e4882469592f = "perk_phd_explode_lg";
        s_mod = params.smeansofdeath ?? "MOD_EXPLOSIVE";
    }
    
    if ( augmentused == #"phdflopper_explosive_fall" )
    {
        n_base_height = level.zombie_augments[ #"phdflopper_explosive_fall" ].var_d081481e85881d0b ?? 120;
    }
    else if ( params.fall_explosion_distance )
    {
        n_base_height = params.fall_explosion_distance;
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_hair_trigger" ) )
    {
        var_b9e8363f5ee96839 = level.zombie_augments[ #"phdflopper_hair_trigger" ].var_eed2e5e9c5ecd5ff ?? 0.15;
        n_height_down = n_base_height * var_b9e8363f5ee96839;
        n_base_height = int( clamp( n_base_height - n_height_down, 0, n_base_height ) );
    }
    
    if ( n_boost_source == "HEIGHT" )
    {
        if ( augmentused == #"phdflopper_slider" )
        {
            if ( var_51ef870503967f06 < 128 )
            {
                n_radius = n_base_radius;
                var_309d3d200b85f4ed = n_base_min_damage;
                var_1f43a1a5ec69808 = 5000;
                fx = utility::getfx( var_7a0fdf619e527e52 );
            }
            else if ( var_51ef870503967f06 >= 128 )
            {
                n_radius = n_base_radius * var_b735e7458084cc99;
                var_309d3d200b85f4ed = n_base_min_damage + n_base_damage_step;
                var_1f43a1a5ec69808 = 8000;
                fx = utility::getfx( var_b5ec61eeadb4d23f );
            }
        }
        else if ( augmentused == #"phdflopper_wall_flopper" )
        {
            n_radius = 200;
            var_309d3d200b85f4ed = n_base_min_damage + n_base_damage_step;
            var_1f43a1a5ec69808 = 8000;
            fx = utility::getfx( var_7a0fdf619e527e52 );
        }
        else if ( var_51ef870503967f06 < n_base_height )
        {
            n_radius = n_base_radius;
            var_309d3d200b85f4ed = n_base_min_damage;
            var_1f43a1a5ec69808 = 5000;
            fx = utility::getfx( var_7a0fdf619e527e52 );
        }
        else if ( var_51ef870503967f06 >= n_base_height && var_51ef870503967f06 < n_base_height * 3 )
        {
            n_radius = n_base_radius * var_b735e7458084cc99;
            var_309d3d200b85f4ed = n_base_min_damage + n_base_damage_step;
            var_1f43a1a5ec69808 = 8000;
            fx = utility::getfx( var_b5ec61eeadb4d23f );
        }
        else
        {
            n_radius = n_base_radius * var_5c2b49b1577449ea;
            var_309d3d200b85f4ed = n_base_min_damage + n_base_damage_step * 2;
            var_1f43a1a5ec69808 = 15000;
            fx = utility::getfx( var_c384e4882469592f );
        }
    }
    else if ( n_boost_source == "RADIUS" )
    {
        var_309d3d200b85f4ed = n_base_min_damage;
        
        if ( augmentused == #"phdflopper_slider" )
        {
            n_radius = var_edde811fb15b364d;
        }
        else
        {
            n_radius = var_349d86d21f41eaa0;
        }
        
        if ( n_radius <= 50 )
        {
            var_1f43a1a5ec69808 = 5000;
            fx = utility::getfx( var_7a0fdf619e527e52 );
        }
        else if ( n_radius <= 65 )
        {
            var_1f43a1a5ec69808 = 6500;
            fx = utility::getfx( var_b5ec61eeadb4d23f );
        }
        else if ( n_radius <= 80 )
        {
            var_1f43a1a5ec69808 = 8000;
            fx = utility::getfx( var_b5ec61eeadb4d23f );
        }
        else
        {
            var_1f43a1a5ec69808 = 15000;
            fx = utility::getfx( var_c384e4882469592f );
        }
    }
    
    fx = params.custom_fx ?? fx;
    println( "<dev string:x24>" + var_51ef870503967f06 + "<dev string:x34>" + n_radius + "<dev string:x3c>" );
    v_origin = attacker gettagorigin( "tag_eye" ) + anglestoforward( ( 0, attacker getplayerangles()[ 1 ], 0 ) ) * 60;
    
    if ( augmentused == #"phdflopper_explosive_fall" || params.use_fall_explosions )
    {
        v_origin = attacker.origin;
    }
    else if ( augmentused == #"phdflopper_slider" )
    {
        v_velocity_dir = attacker getvelocity();
        v_velocity_dir = vectornormalize( v_velocity_dir );
        v_origin = attacker gettagorigin( "j_ankle_ri" ) + v_velocity_dir * 60;
    }
    
    playfx( fx, v_origin );
    attacker thread function_1dc603c111c571f( v_origin, n_radius, var_309d3d200b85f4ed, s_mod, var_1f43a1a5ec69808, bundle, augmentused, params );
    
    if ( !params.var_da2505a8cf14a513 && attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_double_whammy" ) )
    {
        attacker thread flopper_double_whammy( fx, v_origin, n_radius, var_309d3d200b85f4ed, var_1f43a1a5ec69808, bundle, augmentused, params );
    }
    
    if ( params.var_56222268cad7065f )
    {
        playsoundatpos( v_origin, params.var_56222268cad7065f );
    }
    
    if ( params.var_656a72993752979f && params.var_5603a67f23e5e542 && params.var_8e8ed638a48f555c )
    {
        earthquake( params.var_656a72993752979f, params.var_5603a67f23e5e542, v_origin, params.var_8e8ed638a48f555c );
    }
}

// Namespace perk_phd_flopper
// Params 8
// Checksum 0x9f167333, Offset: 0x113f
// Size: 0xb5
function flopper_double_whammy( fx, v_origin, n_radius, var_309d3d200b85f4ed, var_1f43a1a5ec69808, bundle, augmentused, params )
{
    self endon( #"death_or_disconnect" );
    wait 0.75;
    s_mod = params.smeansofdeath ?? "MOD_EXPLOSIVE";
    v_origin = self gettagorigin( "tag_eye" ) + anglestoforward( ( 0, self getplayerangles()[ 1 ], 0 ) ) * 60;
    playfx( fx, v_origin );
    thread function_1dc603c111c571f( v_origin, n_radius, var_309d3d200b85f4ed, s_mod, var_1f43a1a5ec69808, bundle, augmentused, params );
}

// Namespace perk_phd_flopper
// Params 8
// Checksum 0xab4e6812, Offset: 0x11fc
// Size: 0x74e
function function_1dc603c111c571f( origin, radius, var_578d71b7c00fc4ba, var_b3cbd266eebbbb50, var_1f43a1a5ec69808, bundle, augmentused, params )
{
    self endon( #"disconnect" );
    utility::ent_flag_set( "is_phd_flopping" );
    function_d442aa33e9d708f4( origin, radius, params.kfe_damage, var_b3cbd266eebbbb50, var_1f43a1a5ec69808, bundle, augmentused, params );
    
    if ( params.break_glass_on_impact )
    {
        glassradiusdamage( origin, radius, var_578d71b7c00fc4ba, var_578d71b7c00fc4ba );
    }
    
    if ( params.var_8880111ae981c5c2 )
    {
        halfheight = params.var_81f2b8482f9b5294;
        assert( halfheight, "<dev string:x3f>" );
        cylinder_offset = ( 0, 0, params.var_8191cca50e08a247 ?? 0 );
        cylinder_origin = origin + cylinder_offset;
        a_ai = function_51b8ce76eb43aed5( cylinder_origin, radius, halfheight );
        
        /#
            if ( getdvarint( @"hash_e14db71b15fea9c9", 0 ) == 1 )
            {
                var_d4618b70ea2e3eee = 200;
                debugstar( origin, ( 1, 1, 1 ), var_d4618b70ea2e3eee, "<dev string:x72>" );
                line( origin, cylinder_origin, ( 1, 1, 1 ), 1, 0, var_d4618b70ea2e3eee );
                debugstar( cylinder_origin, ( 1, 1, 1 ), var_d4618b70ea2e3eee, "<dev string:x80>" );
                cylinder( cylinder_origin - ( 0, 0, halfheight ), cylinder_origin + ( 0, 0, halfheight ), radius, ( 1, 0, 0 ), 0, var_d4618b70ea2e3eee );
            }
        #/
    }
    else
    {
        a_ai = getplayersandaiarrayinradius( origin, radius );
    }
    
    var_6f5c0bece5deb66e = [];
    
    foreach ( ai in a_ai )
    {
        if ( ai.team == self.team || ai.team == "neutral" )
        {
            continue;
        }
        
        var_6f5c0bece5deb66e[ var_6f5c0bece5deb66e.size ] = ai;
    }
    
    if ( params.var_8fa7bfe3e393854f )
    {
        var_6f5c0bece5deb66e = function_36182da959b473ce( var_6f5c0bece5deb66e );
    }
    
    var_375c3e35770652f = 0;
    var_59419e7814190b1d = 0;
    radiusdamage( origin, radius, 1, 1, self, undefined, undefined, 1, 1 );
    
    for ( i = 0; i < var_6f5c0bece5deb66e.size ; i++ )
    {
        var_4ce3921a39b02032 = var_6f5c0bece5deb66e[ i ];
        explosion_damage = params.explosion_damage ?? var_4ce3921a39b02032.maxhealth;
        
        if ( !isalive( var_4ce3921a39b02032 ) )
        {
            continue;
        }
        
        damage = 0;
        enemy_is_player = isplayer( var_4ce3921a39b02032 );
        
        if ( var_4ce3921a39b02032.type == "human" )
        {
            damage = params.var_3e786258d33d4042 ?? bundle.var_b994e6f33d79a72;
        }
        
        if ( enemy_is_player )
        {
            damage = params.var_3ee726f82780ea1 ?? bundle.var_b994e6f33d79a72;
        }
        
        if ( enemy_is_player && params.player_damage_multiplier )
        {
            damage *= params.player_damage_multiplier;
        }
        
        if ( damage == 0 && isdefined( var_4ce3921a39b02032.aicategory ) )
        {
            explosion_damage = params.var_d988de028a0c0c19 ?? explosion_damage;
            
            switch ( var_4ce3921a39b02032.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                    damage = explosion_damage;
                    break;
                case #"hash_8c089e813083e510":
                    damage = explosion_damage * function_94cd6db602aa4b23( bundle, params );
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    damage = explosion_damage * function_51dafa789530df86( bundle, params );
                    break;
                case #"hash_7e8a002ed096276c":
                    damage = explosion_damage * function_8569ca9a8073ce3b( bundle, params );
                    break;
            }
        }
        
        if ( damage == 0 )
        {
            var_38ef4250e4e2c082 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_4ce3921a39b02032.origin );
            damage = namespace_35d7a88a59082733::function_4a6cf9bafc91e53( var_578d71b7c00fc4ba, var_38ef4250e4e2c082, "frag_grenade", var_4ce3921a39b02032.aicategory, var_4ce3921a39b02032.maxhealth, var_4ce3921a39b02032.var_a03f571fe06a52b8 );
        }
        
        v_dir = vectornormalize( var_4ce3921a39b02032.origin - self.origin );
        victim_aicategory = var_4ce3921a39b02032.aicategory;
        victim_subclass = var_4ce3921a39b02032.subclass;
        var_4ce3921a39b02032.killed_by_phd_flopper = 1;
        
        if ( augmentused == #"phdflopper_slider" )
        {
            var_4ce3921a39b02032.killed_by_phd_slider = 1;
        }
        
        if ( params.is_fall_explosions )
        {
            var_4ce3921a39b02032.is_fall_explosions_damage = 1;
        }
        
        var_4ce3921a39b02032 dodamage( damage, var_4ce3921a39b02032.origin, self, self, var_b3cbd266eebbbb50, "<explicitweaponnone>", "torso_upper" );
        
        if ( !isalive( var_4ce3921a39b02032 ) && !var_4ce3921a39b02032.var_33df89471a965163 )
        {
            var_4ce3921a39b02032.var_33df89471a965163 = 1;
            var_24ed309d808c077a = var_4ce3921a39b02032 getcorpseentity();
            var_b19ce51dfc12b7f8 = spawnstruct();
            var_b19ce51dfc12b7f8.player = self;
            var_b19ce51dfc12b7f8.augmentused = augmentused;
            var_b19ce51dfc12b7f8.victim_aicategory = victim_aicategory;
            var_b19ce51dfc12b7f8.victim_subclass = victim_subclass;
            var_4ce3921a39b02032 callback::callback( "phd_flopper_killed", var_b19ce51dfc12b7f8 );
            var_59419e7814190b1d++;
            callback::callback( "perk_stats_track", { #stats:"kills", #var_ffc1674def575bfa:"specialty_phd_flopper" } );
            
            if ( augmentused == #"phdflopper_slider" )
            {
                if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
                {
                    utility::callsharedfunc( #"medal", #"track_rapid_kill", "phdflopper_augment_s" );
                }
            }
            
            if ( var_375c3e35770652f < 5 )
            {
                if ( isdefined( var_24ed309d808c077a ) )
                {
                    launchx = clamp( v_dir[ 0 ] * var_1f43a1a5ec69808, -5000, 5000 );
                    launchy = clamp( v_dir[ 1 ] * var_1f43a1a5ec69808, -5000, 5000 );
                    launchz = clamp( ( v_dir[ 2 ] + 150 ) * var_1f43a1a5ec69808, 0, 5000 );
                    v_launch = ( launchx, launchy, launchz );
                    var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
                    var_375c3e35770652f++;
                }
            }
        }
        
        if ( isalive( var_4ce3921a39b02032 ) )
        {
            if ( augmentused == #"phdflopper_slider" )
            {
                var_4ce3921a39b02032.killed_by_phd_slider = undefined;
            }
            
            var_4ce3921a39b02032.killed_by_phd_flopper = undefined;
            
            if ( params.is_fall_explosions )
            {
                var_4ce3921a39b02032.is_fall_explosions_damage = undefined;
            }
        }
        
        throttle::throttle_wait_in_queue( level.perk_phd_flopper_throttle, var_4ce3921a39b02032 );
    }
    
    if ( var_59419e7814190b1d >= 5 )
    {
        callback::callback( "perk_stats_track", { #stats:"multi_kills", #var_ffc1674def575bfa:"specialty_phd_flopper" } );
    }
    
    utility::ent_flag_clear( "is_phd_flopping" );
}

// Namespace perk_phd_flopper
// Params 1
// Checksum 0xee4d8630, Offset: 0x1952
// Size: 0x555
function function_fb78d8c794488295( params )
{
    self endon( #"death_or_disconnect" );
    self endon( #"stop_dtp_fall_watcher" );
    is_in_dtp = 0;
    is_airborne = 0;
    is_roll_airborne = 0;
    var_bf227e93244da01c = undefined;
    var_96f68dad4590a19e = undefined;
    
    while ( true )
    {
        var_911706cb675b75a6 = undefined;
        
        if ( !is_roll_airborne && !self isonground() )
        {
            if ( !is_roll_airborne )
            {
                is_roll_airborne = 1;
                var_96f68dad4590a19e = self.origin[ 2 ];
            }
        }
        
        if ( is_roll_airborne && self isactiverolling() && !is_in_dtp && !params.var_746edbdabdf64773 )
        {
            var_911706cb675b75a6 = var_96f68dad4590a19e - self.origin[ 2 ];
            level flopper_explode( self, var_911706cb675b75a6, undefined, params );
            var_96f68dad4590a19e = undefined;
            
            while ( self isactiverolling() )
            {
                wait 0.1;
            }
            
            is_roll_airborne = 0;
            continue;
        }
        
        if ( self isdiving() && !params.var_2f4fcf4e4190c74f )
        {
            if ( !is_in_dtp )
            {
                is_in_dtp = 1;
                var_bf227e93244da01c = self.origin[ 2 ];
            }
            
            if ( self isonground() && is_in_dtp && !self.swim.underwater && isdefined( var_bf227e93244da01c ) )
            {
                var_911706cb675b75a6 = var_bf227e93244da01c - self.origin[ 2 ];
                level flopper_explode( self, var_911706cb675b75a6, undefined, params );
                var_bf227e93244da01c = undefined;
                is_in_dtp = 0;
                
                while ( self isdiving() )
                {
                    wait 0.1;
                }
            }
        }
        else
        {
            use_fall_explosions = params.use_fall_explosions ?? istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_explosive_fall" ) );
            is_skydive_state = self isparachuting() || self isinfreefall();
            disable_conditions = is_skydive_state || self.swim.underwater || vehicle::is_in_vehicle( 1 ) || self.isjuggernaut;
            
            if ( params.var_99dd695670e3f5b3 )
            {
                disable_conditions = disable_conditions || self isonascender();
            }
            
            if ( disable_conditions )
            {
                if ( self.swim.underwater )
                {
                    is_airborne = 0;
                }
                
                if ( params.var_db4ca47bfdadd17c && is_skydive_state && use_fall_explosions && !self isonground() )
                {
                    is_airborne = 1;
                    
                    if ( !isdefined( var_bf227e93244da01c ) || self.origin[ 2 ] > var_bf227e93244da01c )
                    {
                        var_bf227e93244da01c = self.origin[ 2 ];
                    }
                }
                else
                {
                    var_bf227e93244da01c = undefined;
                }
                
                is_in_dtp = 0;
            }
            else if ( is_in_dtp && isdefined( var_bf227e93244da01c ) )
            {
                var_911706cb675b75a6 = var_bf227e93244da01c - self.origin[ 2 ];
                level flopper_explode( self, var_911706cb675b75a6, undefined, params );
                var_bf227e93244da01c = undefined;
                is_in_dtp = 0;
            }
            else if ( !is_airborne && !self isonground() && use_fall_explosions )
            {
                if ( !is_airborne )
                {
                    is_airborne = 1;
                    var_bf227e93244da01c = self.origin[ 2 ];
                }
            }
            else if ( is_airborne )
            {
                if ( !isdefined( var_bf227e93244da01c ) || self.origin[ 2 ] > var_bf227e93244da01c )
                {
                    var_bf227e93244da01c = self.origin[ 2 ];
                }
                
                if ( var_bf227e93244da01c )
                {
                    var_911706cb675b75a6 = var_bf227e93244da01c - self.origin[ 2 ];
                    n_height_check = params.fall_explosion_distance ?? level.zombie_augments[ #"phdflopper_explosive_fall" ].var_d081481e85881d0b ?? 120;
                    
                    if ( params.var_8fee2f14e90784df && params.var_d4011240b855eb2e && !self.var_c7b08e28a6f1989b )
                    {
                        var_a794fcf3cf1c0f92 = 0;
                        raytrace_contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_itemclip", "physicscontents_water", "physicscontents_vehicle" ] );
                        trace = trace::ray_trace( self.origin, self.origin + ( 0, 0, -10000 ), undefined, raytrace_contents );
                        
                        if ( trace[ "fraction" ] < 1 )
                        {
                            var_a794fcf3cf1c0f92 = abs( trace[ "position" ][ 2 ] - self.origin[ 2 ] );
                            
                            if ( var_a794fcf3cf1c0f92 > n_height_check )
                            {
                                self.var_c7b08e28a6f1989b = 1;
                                playfxontag( params.var_8fee2f14e90784df, self, params.var_d4011240b855eb2e );
                            }
                        }
                    }
                    
                    if ( self isonground() )
                    {
                        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_hair_trigger" ) )
                        {
                            var_b9e8363f5ee96839 = level.zombie_augments[ #"phdflopper_hair_trigger" ].var_eed2e5e9c5ecd5ff ?? 0.15;
                            n_height_down = n_height_check * var_b9e8363f5ee96839;
                            n_height_check = int( clamp( n_height_check - n_height_down, 0, n_height_check ) );
                        }
                        
                        if ( var_911706cb675b75a6 > n_height_check )
                        {
                            level flopper_explode( self, var_911706cb675b75a6, #"phdflopper_explosive_fall", params );
                        }
                        
                        if ( self.var_c7b08e28a6f1989b )
                        {
                            stopfxontag( params.var_8fee2f14e90784df, self, params.var_d4011240b855eb2e );
                            self.var_c7b08e28a6f1989b = undefined;
                        }
                        
                        var_bf227e93244da01c = undefined;
                        is_airborne = 0;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace perk_phd_flopper
// Params 2
// Checksum 0x4a6b47af, Offset: 0x1eaf
// Size: 0x2e, Type: bool
function function_94cd6db602aa4b23( bundle, params )
{
    return params.var_c0620c080291fa7e ?? bundle.var_57ba101772bb2898;
}

// Namespace perk_phd_flopper
// Params 2
// Checksum 0x1fcff1d3, Offset: 0x1ee6
// Size: 0x2e, Type: bool
function function_51dafa789530df86( bundle, params )
{
    return params.var_9ca502d06aa386ac ?? bundle.var_5cf6c2ec27e0663c;
}

// Namespace perk_phd_flopper
// Params 2
// Checksum 0x58178300, Offset: 0x1f1d
// Size: 0x2e, Type: bool
function function_8569ca9a8073ce3b( bundle, params )
{
    return params.var_14a03f706f832132 ?? bundle.var_61910efe1da8e2d4;
}

// Namespace perk_phd_flopper
// Params 8, eflags: 0x4
// Checksum 0x44227f3, Offset: 0x1f54
// Size: 0x116
function private function_d442aa33e9d708f4( origin, radius, damage, var_b3cbd266eebbbb50, var_1f43a1a5ec69808, bundle, augmentused, params )
{
    if ( !damage )
    {
        return;
    }
    
    kfes = function_58ec2d2f2ecbcddb( origin, radius );
    
    foreach ( kfe in kfes )
    {
        if ( isent( kfe ) )
        {
            kfe dodamage( damage, kfe.origin, self, self, var_b3cbd266eebbbb50, "<explicitweaponnone>" );
            continue;
        }
        
        if ( kfe.classname == "scriptable" )
        {
            kfe scriptabledodamage( damage, self, self, undefined, undefined );
        }
    }
}

// Namespace perk_phd_flopper
// Params 2, eflags: 0x4
// Checksum 0x25cba373, Offset: 0x2072
// Size: 0xb3
function private function_58ec2d2f2ecbcddb( origin, radius )
{
    killstreak_array = level.activekillstreaks;
    var_cb22c35e3c5f04e4 = [[ level.getactiveequipmentarray ]]();
    turrets = getentarray( "misc_turret", #classname );
    mines = weapon::function_3aafcaf7ff6dea9e();
    var_9f3d72016a8b1747 = level.aisentryturrets.spawnedturrets;
    kfes = arraycombineunique( killstreak_array, var_cb22c35e3c5f04e4, turrets, mines, var_9f3d72016a8b1747 );
    var_3bb76653241dfeb9 = function_98d066e899de07f3( origin, radius, kfes );
    return var_3bb76653241dfeb9;
}

// Namespace perk_phd_flopper
// Params 3, eflags: 0x4
// Checksum 0x51dcd945, Offset: 0x212e
// Size: 0xdb
function private function_98d066e899de07f3( origin, radius, var_1a3360c0c0b637b9 )
{
    radiussq = radius * radius;
    var_3bb76653241dfeb9 = [];
    
    foreach ( kfe in var_1a3360c0c0b637b9 )
    {
        if ( !player_utility::playersareenemies( self, kfe ) )
        {
            continue;
        }
        
        dist = distance2dsquared( origin, kfe.origin );
        
        if ( dist <= radiussq )
        {
            var_3bb76653241dfeb9[ var_3bb76653241dfeb9.size ] = kfe;
        }
    }
    
    return var_3bb76653241dfeb9;
}

// Namespace perk_phd_flopper
// Params 1, eflags: 0x4
// Checksum 0xf8a6acd2, Offset: 0x2212
// Size: 0x21f
function private function_36182da959b473ce( allai )
{
    start = self geteye();
    result = [];
    var_792e11054502c04b = [];
    
    if ( getdvarint( @"hash_8a928550763f7683", 0 ) == 1 )
    {
        /#
            debug_data = { #debug_color:( 0, 1, 1 ), #var_d4618b70ea2e3eee:200, #var_19a11e8f8a4d1fa3:0 };
        #/
    }
    
    foreach ( ai in allai )
    {
        if ( ai == self )
        {
            continue;
        }
        
        entity_id = ai getentitynumber();
        
        if ( var_792e11054502c04b[ entity_id ] )
        {
            continue;
        }
        
        detected_entities = function_1c1f23a4ca6ef855( ai, start, debug_data );
        
        foreach ( detected_entity in detected_entities )
        {
            result[ result.size ] = detected_entity;
            var_792e11054502c04b[ detected_entity getentitynumber() ] = 1;
        }
    }
    
    /#
        if ( getdvarint( @"hash_8a928550763f7683", 0 ) == 1 )
        {
            msg = "<dev string:x90>" + allai.size + "<dev string:xa6>";
            msg += "<dev string:xa8>" + debug_data.var_19a11e8f8a4d1fa3 + "<dev string:xa6>";
            msg += "<dev string:xba>" + result.size + "<dev string:xa6>";
            printtoscreen2d( 300, 300, msg, debug_data.debug_color, 2, debug_data.var_d4618b70ea2e3eee );
        }
    #/
    
    return result;
}

// Namespace perk_phd_flopper
// Params 3, eflags: 0x4
// Checksum 0x8a3dbaf3, Offset: 0x243a
// Size: 0xfd
function private function_1c1f23a4ca6ef855( ai, startray, debug_data )
{
    if ( function_1634d44f0fbc0199( ai, debug_data ) )
    {
        return [ ai ];
    }
    
    var_2535f195507fe72b = [ ai geteye(), ai getcentroid(), ai.origin ];
    
    foreach ( ray_end_position in var_2535f195507fe72b )
    {
        /#
            if ( debug_data )
            {
                debug_data.var_19a11e8f8a4d1fa3++;
            }
        #/
        
        detected_entities = function_33c92c9598fd9161( startray, ray_end_position, debug_data );
        
        if ( detected_entities.size > 0 )
        {
            return detected_entities;
        }
    }
    
    return [];
}

// Namespace perk_phd_flopper
// Params 2, eflags: 0x4
// Checksum 0xf1304984, Offset: 0x2540
// Size: 0xbb
function private function_1634d44f0fbc0199( ai, debug_data )
{
    navtracesuccess = !navtrace( self.origin, ai.origin, self, 0 );
    
    if ( navtracesuccess )
    {
        /#
            if ( getdvarint( @"hash_8a928550763f7683", 0 ) == 1 )
            {
                color = debug_data.debug_color;
                line( self.origin, ai.origin, color, 1, 1, debug_data.var_d4618b70ea2e3eee );
                debugstar( ai.origin, color, debug_data.var_d4618b70ea2e3eee, "<dev string:xd0>" );
            }
        #/
    }
    
    return navtracesuccess;
}

// Namespace perk_phd_flopper
// Params 3, eflags: 0x4
// Checksum 0x6e57bfb9, Offset: 0x2604
// Size: 0xa5
function private function_33c92c9598fd9161( startray, ray_end_position, debug_data )
{
    trace_result = trace::ray_trace_get_all_results( startray, ray_end_position, self );
    
    if ( trace_result[ 0 ][ "hittype" ] == "hittype_world" )
    {
        /#
            function_63b14a3ccde334c9( debug_data, startray, ray_end_position, trace_result[ 0 ][ "<dev string:xea>" ], "<dev string:xf3>", ( 1, 0, 0 ) );
        #/
        
        return [];
    }
    
    detected_entities = function_84923c763d49c54d( trace_result );
    
    /#
        function_63b14a3ccde334c9( debug_data, startray, ray_end_position, trace_result[ 0 ][ "<dev string:xea>" ], "<dev string:x106>" + detected_entities.size );
    #/
    
    return detected_entities;
}

// Namespace perk_phd_flopper
// Params 1, eflags: 0x4
// Checksum 0xdd3e5f27, Offset: 0x26b2
// Size: 0xa7
function private function_84923c763d49c54d( trace_result )
{
    result = [];
    
    foreach ( hit in trace_result )
    {
        var_43f442316cce824b = hit[ "entity" ];
        
        if ( var_43f442316cce824b )
        {
            result = arraycombineunique( result, [ var_43f442316cce824b ] );
        }
    }
    
    return result;
}

/#

    // Namespace perk_phd_flopper
    // Params 6, eflags: 0x4
    // Checksum 0x55d5d4af, Offset: 0x2762
    // Size: 0xa0, Type: dev
    function private function_63b14a3ccde334c9( debug_data, startray, endray, collisionpoint, message, overide_color )
    {
        if ( !debug_data )
        {
            return;
        }
        
        if ( getdvarint( @"hash_8a928550763f7683", 0 ) == 1 )
        {
            color = overide_color ?? debug_data.debug_color;
            line( startray, endray, color, 1, 1, debug_data.var_d4618b70ea2e3eee );
            debugstar( collisionpoint, color, debug_data.var_d4618b70ea2e3eee, message );
        }
    }

#/
