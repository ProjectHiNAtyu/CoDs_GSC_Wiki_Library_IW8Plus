// scripts\mp\magicbox.gsc  (hash_4ccf8f7e270f2426.gscc) (size: 69161 Bytes / 0x10e29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c42abd8 (2084744152)
// size ...... 69161 (0x10e29)
// includes .. 18  (offset: 0xfddd)
// strings ... 154 (offset: 0xfe6d)
// dev strs .. 120 (offset: 0x1080d)
// exports ... 100 (offset: 0xc075)
// cseg ...... 0xb13 + 0xb562 (0xc075)
// imports ... 332 (offset: 0xd015)
// animtree1 . 0   (offset: 0x10e29)
// animtree2 . 0   (offset: 0x10e29)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;

#namespace magicbox;

// Namespace magicbox
// Params 1
// Checksum 0x3b2aef8e, Offset: 0xb31
// Size: 0x1ba
function function_bfabc0b272ff94ad( a_s_magicbox_weapons )
{
    /#
        level thread setup_magicbox_devgui();
    #/
    
    utility::flag_init( "magicbox_ready" );
    level.magicbox_currency_type = currency::get_magicbox_currency() ?? #"essence";
    level.var_afd75d0da8d05e42 = currency::get_magicbox_cost() ?? 950;
    level.var_c94175b5e96b794c = [];
    level.var_3d89727cba6243b2 = [];
    level.var_1bbb5557537e2c0c = [];
    level.var_e0e84452fe117b5f = [];
    level.var_410b736ba41817c2 = 0;
    level.var_1c98168ff9213851 = 0;
    level.var_3c501ff44580327b = [];
    content_manager::function_3209da123476142f( "magicbox", &on_spawn_magicbox );
    content_manager::register_disable_toggle( "magicbox", &content_manager::function_5d04e50a29a2142c, &function_682f5d6d99881879, &function_905cbfe12b2fdf2 );
    
    if ( !level.gamemodebundle.var_c214fc63695cd685 )
    {
        level thread init_magicbox_postmain();
    }
    else
    {
        callback::add( "ob_content_process_create_script", &init_magicbox_postmain );
    }
    
    level thread setup_magicbox_weapons( a_s_magicbox_weapons );
    level thread setup_magicbox_limits();
    callback::add( "on_round_end", &on_round_end );
    scriptable::scriptable_addnotifycallback( "magicbox_closed", &on_magicbox_closed );
    level callback::add( #"grenade_fire", &on_grenade_fire );
    utility::registersharedfunc( #"zombie", #"hash_d66633c1e4eea8f1", &show_magicbox );
    utility::registersharedfunc( #"zombie", #"hash_ba00127cec14a5b2", &hide_magicbox );
    utility::registersharedfunc( #"zombie", #"on_use_magicbox", &on_use_magicbox );
    utility::registersharedfunc( #"zombie", #"abort_magicbox", &abort_magicbox );
}

// Namespace magicbox
// Params 1, eflags: 0x4
// Checksum 0x75ec6f43, Offset: 0xcf3
// Size: 0x1b9
function private on_grenade_fire( params )
{
    params.grenade endon( #"death", #"explode" );
    params.grenade waittill( #"missile_stuck", var_b85242acc18ff917, stuckpart, surfacetype, velocity, position, normal );
    
    if ( isdefined( var_b85242acc18ff917.var_349a0723ed9ac19c ) )
    {
        if ( params.grenade.weapon_object.var_25b0062cbe4d9c99 == #"mini_sentry" )
        {
            params.grenade thread mini_sentry_setup( var_b85242acc18ff917, position );
            return;
        }
        else
        {
            if ( !isdefined( var_b85242acc18ff917.a_grenades_stuck ) )
            {
                var_b85242acc18ff917.a_grenades_stuck = [];
            }
            
            var_b85242acc18ff917.a_grenades_stuck = function_5713d46873b29625( var_b85242acc18ff917.a_grenades_stuck );
            var_b85242acc18ff917.a_grenades_stuck[ var_b85242acc18ff917.a_grenades_stuck.size ] = params.grenade;
            grenade = params.grenade;
        }
        
        if ( var_b85242acc18ff917.var_349a0723ed9ac19c.b_is_moving )
        {
            var_b85242acc18ff917 thread cleanup_magicbox_grenades();
            return;
        }
        
        if ( var_b85242acc18ff917.interact.b_opened_magicbox )
        {
            if ( var_b85242acc18ff917 tagexists( "tag_hint" ) )
            {
                var_cd5845af0d9109a1 = var_b85242acc18ff917 gettagorigin( "tag_hint" )[ 2 ];
                
                if ( position[ 2 ] >= var_cd5845af0d9109a1 )
                {
                    grenade thread function_70d12dbf879faf5d( var_b85242acc18ff917 );
                }
            }
        }
    }
}

// Namespace magicbox
// Params 2, eflags: 0x4
// Checksum 0x8b436255, Offset: 0xeb4
// Size: 0x11e
function private mini_sentry_setup( var_b85242acc18ff917, position )
{
    while ( !isdefined( self.turret ) )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        waitframe();
    }
    
    grenade = self.turret;
    
    while ( !isdefined( grenade.mineid ) )
    {
        waitframe();
    }
    
    if ( !isdefined( var_b85242acc18ff917.a_grenades_stuck ) )
    {
        var_b85242acc18ff917.a_grenades_stuck = [];
    }
    
    var_b85242acc18ff917.a_grenades_stuck = function_5713d46873b29625( var_b85242acc18ff917.a_grenades_stuck );
    var_b85242acc18ff917.a_grenades_stuck[ var_b85242acc18ff917.a_grenades_stuck.size ] = grenade;
    
    if ( var_b85242acc18ff917.var_349a0723ed9ac19c.b_is_moving )
    {
        var_b85242acc18ff917 thread cleanup_magicbox_grenades();
        return;
    }
    
    if ( var_b85242acc18ff917.interact.b_opened_magicbox )
    {
        if ( var_b85242acc18ff917 tagexists( "tag_hint" ) )
        {
            var_cd5845af0d9109a1 = var_b85242acc18ff917 gettagorigin( "tag_hint" )[ 2 ];
            
            if ( position[ 2 ] >= var_cd5845af0d9109a1 )
            {
                grenade thread function_70d12dbf879faf5d( var_b85242acc18ff917 );
            }
        }
    }
}

// Namespace magicbox
// Params 1, eflags: 0xc
// Checksum 0xb75bce41, Offset: 0xfda
// Size: 0x116
function private function_70d12dbf879faf5d( var_b85242acc18ff917 )
{
    self notify( #"hash_abb63f97ddd74883" );
    self endon( #"hash_abb63f97ddd74883" );
    self notify( #"detonateexplosive" );
    self notify( #"forcedeath" );
    
    if ( self.vehicletype == %"veh_mini_sentry" )
    {
        utility::callsharedfunc( #"mini_sentry", #"destroy" );
        
        if ( isdefined( self ) && isarray( var_b85242acc18ff917.a_grenades_stuck ) )
        {
            var_b85242acc18ff917.a_grenades_stuck = arrayremove( var_b85242acc18ff917.a_grenades_stuck, self );
        }
    }
    
    waitframe();
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.var_b914fa7e22321b2a ) )
        {
            self [[ self.var_b914fa7e22321b2a ]]();
        }
        else if ( isdefined( self ) && !self.exploding && !self.isdying )
        {
            self detonate();
        }
    }
    
    if ( isarray( var_b85242acc18ff917.a_grenades_stuck ) )
    {
        var_b85242acc18ff917.a_grenades_stuck = function_5713d46873b29625( var_b85242acc18ff917.a_grenades_stuck );
    }
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0xe8fd15be, Offset: 0x10f8
// Size: 0x9e
function private cleanup_magicbox_grenades()
{
    self endon( #"death" );
    
    if ( isarray( self.a_grenades_stuck ) )
    {
        foreach ( grenade in self.a_grenades_stuck )
        {
            if ( isdefined( grenade ) )
            {
                grenade thread function_70d12dbf879faf5d( self );
            }
        }
    }
}

// Namespace magicbox
// Params 0
// Checksum 0x6618509f, Offset: 0x119e
// Size: 0x9b
function get_magicbox_bundle_name()
{
    var_cd16a2e74383ea61 = getactivemapinfobundle();
    var_c6bc87a61cb4cf91 = var_cd16a2e74383ea61.magicboxbundle ?? level.gametypebundle.magicboxbundle ?? level.gamemodebundle.magicboxbundle;
    assert( isdefined( var_c6bc87a61cb4cf91 ), "<dev string:x24>" );
    str_bundle_name = self.script_modelname ?? level.var_cfa81adfb2d8231c ?? var_c6bc87a61cb4cf91;
    
    if ( isxhashasset( str_bundle_name ) )
    {
        return str_bundle_name;
    }
    
    return "magicbox:" + str_bundle_name;
}

// Namespace magicbox
// Params 0
// Checksum 0xcc33de54, Offset: 0x1242
// Size: 0xc
function get_magicbox_bundle()
{
    return getscriptbundle( get_magicbox_bundle_name() );
}

// Namespace magicbox
// Params 2
// Checksum 0x24888970, Offset: 0x1257
// Size: 0x42
function function_72f7be2f9191b13d( str_base_name, str_timeline )
{
    if ( str_timeline == "past" )
    {
        return ( str_base_name + "Past" );
    }
    else if ( str_timeline == "future" )
    {
        return ( str_base_name + "Future" );
    }
    
    return str_base_name;
}

/#

    // Namespace magicbox
    // Params 0
    // Checksum 0x37ada923, Offset: 0x12a2
    // Size: 0x178, Type: dev
    function setup_magicbox_devgui()
    {
        utility::flag_wait( "<dev string:x7c>" );
        devgui::function_9082edeb5db93280( "<dev string:x93>" );
        devgui::add_devgui_func( "<dev string:xa3>", "<dev string:xb9>", &function_6fe2408779419280, 1 );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xea>", &devgui_move_magicbox );
        devgui::add_devgui_func( "<dev string:xf8>", "<dev string:x114>", &function_36a8596f743d5e8c );
        devgui::add_devgui_func( "<dev string:x128>", "<dev string:x13c>", &function_b473f4691f56f89a );
        devgui::add_devgui_func( "<dev string:x14f>", "<dev string:x161>", &function_c294b46f5a28ad4e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x172>", "<dev string:x18f>", &function_2398d096a9283156 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a5>", "<dev string:x1c3>", &function_2398d096a9283156 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1da>", "<dev string:x1f8>", &function_2398d096a9283156 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x210>", "<dev string:x23d>", &function_2398d096a9283156 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x253>", "<dev string:x27a>", &function_e1c2e07b5aab60ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x296>", "<dev string:x2bc>", &function_1a1a7df7e76e0a05 );
        function_91a85f5f9f860ab6( level.var_54989577c4e434aa );
        function_91a85f5f9f860ab6( level.var_278a6b84a3269b8c );
        function_91a85f5f9f860ab6( level.var_b29a644f57572450 );
        function_91a85f5f9f860ab6( level.var_8b6bf63f61fe01f9 );
        function_91a85f5f9f860ab6( level.var_ae71d4cfe02b434e );
        function_91a85f5f9f860ab6( level.var_85de712d04e11e60 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace magicbox
    // Params 1
    // Checksum 0x12735836, Offset: 0x1422
    // Size: 0x84, Type: dev
    function function_2398d096a9283156( params )
    {
        var_6cf84ad3f940f099 = int( params[ 0 ] );
        setdvar( @"hash_5b9243049e98ac25", var_6cf84ad3f940f099 );
        
        if ( var_6cf84ad3f940f099 >= 0 )
        {
            minutes = int( var_6cf84ad3f940f099 / 60 );
            seconds = var_6cf84ad3f940f099 % 60;
            iprintlnbold( "<dev string:x2cc>" + minutes + "<dev string:x2ec>" + seconds + "<dev string:x2ee>" );
            return;
        }
        
        iprintlnbold( "<dev string:x2f0>" );
    }

    // Namespace magicbox
    // Params 1
    // Checksum 0x9be8f6ee, Offset: 0x14ae
    // Size: 0x235, Type: dev
    function function_91a85f5f9f860ab6( str_item_spawn_list )
    {
        if ( !isdefined( str_item_spawn_list ) )
        {
            return;
        }
        
        s_bundle = getscriptbundle( str_item_spawn_list );
        
        if ( !isdefined( s_bundle ) )
        {
            s_bundle = getscriptbundle( hashcat( %"itemspawnlist:", str_item_spawn_list ) );
        }
        
        if ( isarray( s_bundle.itementries ) )
        {
            foreach ( s_itementry in s_bundle.itementries )
            {
                if ( !isdefined( s_itementry.itemspawnentry ) )
                {
                    println( "<dev string:x316>" + getxhashsourcename( str_item_spawn_list ) + "<dev string:x337>" );
                    continue;
                }
                
                if ( !isdefined( s_itementry.weight ) || s_itementry.weight == 0 )
                {
                    continue;
                }
                
                devgui::function_cd4e263c1f3018ae( "<dev string:x381>" + common_item::clean_name( s_itementry.itemspawnentry ), "<dev string:x392>" + common_item::clean_name( s_itementry.itemspawnentry ), &function_e1c2e07b5aab60ea );
            }
        }
        
        if ( isarray( s_bundle.itemlistentries ) )
        {
            foreach ( var_8fe1c40c3cabe229 in s_bundle.itemlistentries )
            {
                if ( !isdefined( var_8fe1c40c3cabe229.itemspawnlist ) )
                {
                    println( "<dev string:x316>" + getxhashsourcename( str_item_spawn_list ) + "<dev string:x337>" );
                    continue;
                }
                
                if ( !isdefined( var_8fe1c40c3cabe229.weight ) || var_8fe1c40c3cabe229.weight == 0 )
                {
                    continue;
                }
                
                function_91a85f5f9f860ab6( var_8fe1c40c3cabe229.itemspawnlist );
            }
        }
    }

    // Namespace magicbox
    // Params 1
    // Checksum 0x74fecb73, Offset: 0x16eb
    // Size: 0x5a, Type: dev
    function function_e1c2e07b5aab60ea( params )
    {
        if ( params[ 0 ] == "<dev string:x3a9>" )
        {
            setdvar( @"hash_5bf38da5a2eda0c8", "<dev string:x3af>" );
            iprintlnbold( "<dev string:x3b0>" );
            return;
        }
        
        setdvar( @"hash_5bf38da5a2eda0c8", params[ 0 ] );
        iprintlnbold( "<dev string:x3cb>" + params[ 0 ] );
    }

    // Namespace magicbox
    // Params 0
    // Checksum 0x2550f5a5, Offset: 0x174d
    // Size: 0x185, Type: dev
    function function_36a8596f743d5e8c()
    {
        level.var_5542fc8f8eafa0c0 = !level.var_5542fc8f8eafa0c0;
        
        if ( level.var_5542fc8f8eafa0c0 )
        {
            iprintlnbold( "<dev string:x3de>" );
            return;
        }
        
        if ( level.var_70c5979783790e1b )
        {
            iprintlnbold( "<dev string:x3f3>" );
            return;
        }
        
        var_6356a5030ce91076 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "<dev string:x416>" );
        
        if ( var_6356a5030ce91076 )
        {
            if ( !level.var_1c98168ff9213851 )
            {
                iprintlnbold( "<dev string:x431>" + function_f3335515689aea95() - level.var_410b736ba41817c2 + "<dev string:x44d>" );
            }
            else
            {
                iprintlnbold( "<dev string:x454>" + function_e3b0708d3db476e7() - level.var_410b736ba41817c2 + "<dev string:x44d>" );
            }
            
            return;
        }
        
        foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
        {
            if ( !var_349a0723ed9ac19c.var_1c98168ff9213851 )
            {
                iprintlnbold( "<dev string:x431>" + function_f3335515689aea95() - var_349a0723ed9ac19c.var_410b736ba41817c2 + "<dev string:x44d>" );
                continue;
            }
            
            iprintlnbold( "<dev string:x454>" + function_e3b0708d3db476e7() - var_349a0723ed9ac19c.var_410b736ba41817c2 + "<dev string:x44d>" );
        }
    }

    // Namespace magicbox
    // Params 0
    // Checksum 0x2e25687d, Offset: 0x18da
    // Size: 0x4d, Type: dev
    function function_b473f4691f56f89a()
    {
        b_new_value = !getdvarint( @"hash_6965cd369482e004", 1 );
        setdvar( @"hash_6965cd369482e004", b_new_value );
        
        if ( b_new_value )
        {
            iprintlnbold( "<dev string:x47a>" );
            return;
        }
        
        iprintlnbold( "<dev string:x49a>" );
    }

    // Namespace magicbox
    // Params 0
    // Checksum 0xd16dcf17, Offset: 0x192f
    // Size: 0x10, Type: dev
    function devgui_move_magicbox()
    {
        level.var_70c5979783790e1b = 1;
    }

    // Namespace magicbox
    // Params 0
    // Checksum 0x921d6bc0, Offset: 0x1947
    // Size: 0x226, Type: dev
    function function_c294b46f5a28ad4e()
    {
        foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
        {
            if ( isdefined( var_349a0723ed9ac19c.mdl_magicbox ) && var_349a0723ed9ac19c.var_f14b2b4820b635e7 )
            {
                origin = var_349a0723ed9ac19c.mdl_magicbox.origin;
                forward = anglestoforward( var_349a0723ed9ac19c.mdl_magicbox.angles );
                right = anglestoright( var_349a0723ed9ac19c.mdl_magicbox.angles );
                plangles = vectortoangles( right );
                var_dfcdb500ce642a84 = origin - 48 * right;
                
                foreach ( player in level.players )
                {
                    entnum = player getentitynumber();
                    
                    switch ( entnum )
                    {
                        case 0:
                            var_dfcdb500ce642a84 += 16 * right;
                            break;
                        case 1:
                            var_dfcdb500ce642a84 += 16 * forward;
                            break;
                        case 2:
                            var_dfcdb500ce642a84 -= 16 * right;
                            break;
                        case 3:
                            var_dfcdb500ce642a84 -= 16 * forward;
                            break;
                        default:
                            return;
                    }
                    
                    player setorigin( var_dfcdb500ce642a84 );
                    player setplayerangles( plangles );
                }
                
                break;
            }
        }
    }

    // Namespace magicbox
    // Params 1, eflags: 0x4
    // Checksum 0xe061ea43, Offset: 0x1b75
    // Size: 0x16, Type: dev
    function private function_1a1a7df7e76e0a05( params )
    {
        function_c4a68c6c8799c00c();
    }

    // Namespace magicbox
    // Params 0
    // Checksum 0x9336420b, Offset: 0x1b93
    // Size: 0x700, Type: dev
    function function_c4a68c6c8799c00c()
    {
        item_map = [];
        category_map = [];
        tries_per_round = 1000;
        round_number = 1;
        inc = 100 / tries_per_round;
        round_number = 1;
        
        while ( round_number < 40 )
        {
            for ( try_index = 0; try_index < tries_per_round ; try_index++ )
            {
                fake_magicbox = spawnstruct();
                fake_magicbox setup_magicbox_weapon_array( undefined, round_number );
                
                if ( isdefined( fake_magicbox.var_182083fc5337ebe9 ) )
                {
                    var_e883a56cd422913 = getxhashsourcename( fake_magicbox.var_182083fc5337ebe9 );
                    
                    if ( !isdefined( item_map[ round_number ] ) )
                    {
                        item_map[ round_number ] = [];
                    }
                    
                    if ( !isdefined( category_map[ round_number ] ) )
                    {
                        category_map[ round_number ] = [];
                    }
                    
                    if ( !isdefined( item_map[ round_number ][ var_e883a56cd422913 ] ) )
                    {
                        item_map[ round_number ][ var_e883a56cd422913 ] = 0;
                    }
                    
                    item_map[ round_number ][ var_e883a56cd422913 ] += inc;
                    category = undefined;
                    var_6dbea279a7db76a7 = strtok( var_e883a56cd422913, "<dev string:x4bc>" );
                    
                    for ( token_i = 0; token_i < var_6dbea279a7db76a7.size ; token_i++ )
                    {
                        if ( var_6dbea279a7db76a7[ token_i ] == "<dev string:x4be>" )
                        {
                            category = "<dev string:x4c9>";
                            
                            for ( token_o = token_i + 1; token_o < var_6dbea279a7db76a7.size ; token_o++ )
                            {
                                category += var_6dbea279a7db76a7[ token_o ] + "<dev string:x4d5>";
                            }
                        }
                    }
                    
                    if ( !isdefined( category ) )
                    {
                        rarities = [ "<dev string:x4d7>", "<dev string:x4dd>", "<dev string:x4e2>", "<dev string:x4e9>", "<dev string:x4f0>" ];
                        
                        if ( var_6dbea279a7db76a7.size > 1 && arraycontains( rarities, var_6dbea279a7db76a7[ var_6dbea279a7db76a7.size - 1 ] ) )
                        {
                            category = var_6dbea279a7db76a7[ var_6dbea279a7db76a7.size - 1 ];
                        }
                        else
                        {
                            for ( token_i = 0; token_i < var_6dbea279a7db76a7.size ; token_i++ )
                            {
                                if ( var_6dbea279a7db76a7[ token_i ] == "<dev string:x4f6>" )
                                {
                                    category = "<dev string:x4fd>";
                                    
                                    for ( token_o = token_i + 1; token_o < var_6dbea279a7db76a7.size ; token_o++ )
                                    {
                                        category += var_6dbea279a7db76a7[ token_o ] + "<dev string:x4d5>";
                                    }
                                }
                            }
                        }
                    }
                    
                    for ( token_i = 0; token_i < var_6dbea279a7db76a7.size ; token_i++ )
                    {
                        if ( var_6dbea279a7db76a7[ token_i ] == "<dev string:x505>" && var_6dbea279a7db76a7[ token_i + 1 ] == "<dev string:x50c>" )
                        {
                            var_1b8a2a086e4d0732 = var_6dbea279a7db76a7[ token_i + 2 ];
                            
                            if ( var_1b8a2a086e4d0732 == "<dev string:x511>" )
                            {
                                category = "<dev string:x513>";
                                continue;
                            }
                            
                            if ( var_1b8a2a086e4d0732 == "<dev string:x525>" )
                            {
                                category = "<dev string:x527>";
                                continue;
                            }
                            
                            if ( var_1b8a2a086e4d0732 == "<dev string:x53a>" )
                            {
                                category = "<dev string:x53c>";
                                continue;
                            }
                            
                            if ( var_1b8a2a086e4d0732 == "<dev string:x54f>" )
                            {
                                category = "<dev string:x551>";
                                continue;
                            }
                            
                            category = "<dev string:x562>";
                        }
                    }
                    
                    if ( !isdefined( category ) )
                    {
                        category = "<dev string:x574>";
                    }
                    
                    if ( !isdefined( category_map[ round_number ][ category ] ) )
                    {
                        category_map[ round_number ][ category ] = 0;
                    }
                    
                    category_map[ round_number ][ category ] += inc;
                }
            }
            
            waitframe();
            round_number += 5;
        }
        
        var_96a2eb89edc45304 = [];
        var_a321a95482e90b4e = 0;
        
        foreach ( round_number, category_list in category_map )
        {
            foreach ( category, perc in category_list )
            {
                if ( !isdefined( var_96a2eb89edc45304[ category ] ) )
                {
                    var_96a2eb89edc45304[ category ] = var_a321a95482e90b4e;
                    var_a321a95482e90b4e++;
                }
            }
        }
        
        var_664dda53b3e8f906 = [];
        var_ae67b853e899c2bc = [];
        
        foreach ( round_number, category_list in category_map )
        {
            var_4e0d5dd355923e8a = [];
            
            for ( category_i = 0; category_i < var_a321a95482e90b4e ; category_i++ )
            {
                var_4e0d5dd355923e8a[ category_i ] = 0;
            }
            
            foreach ( category, perc in category_list )
            {
                var_4e0d5dd355923e8a[ var_96a2eb89edc45304[ category ] ] = perc;
            }
            
            var_afec73b6a54579e8 = string( round_number ) + "<dev string:x57c>";
            var_3489c5b7073b0352 = string( round_number ) + "<dev string:x57e>";
            
            foreach ( count in var_4e0d5dd355923e8a )
            {
                var_afec73b6a54579e8 += string( count ) + "<dev string:x57c>";
                var_3489c5b7073b0352 += string( count ) + "<dev string:x583>";
            }
            
            var_664dda53b3e8f906[ var_664dda53b3e8f906.size ] = var_afec73b6a54579e8;
            var_ae67b853e899c2bc[ var_ae67b853e899c2bc.size ] = var_3489c5b7073b0352;
        }
        
        var_234761f7f3a3cf59 = "<dev string:x586>";
        var_9f36dff792492e3f = "<dev string:x594>";
        
        for ( column_i = 0; column_i < var_96a2eb89edc45304.size ; column_i++ )
        {
            category = function_f02c63b99c9614c9( var_96a2eb89edc45304, column_i );
            var_234761f7f3a3cf59 += category + "<dev string:x57c>";
            var_9f36dff792492e3f += category + "<dev string:x5a4>";
        }
        
        filenum = openfile( "<dev string:x5a6>", "<dev string:x5b9>" );
        fprintln( filenum, var_234761f7f3a3cf59 );
        
        foreach ( printed_line in var_664dda53b3e8f906 )
        {
            fprintln( filenum, printed_line );
        }
        
        closefile( filenum );
        logstring( "<dev string:x5bf>" + tries_per_round + "<dev string:x5d3>" );
        logstring( var_9f36dff792492e3f );
        
        foreach ( printed_line in var_ae67b853e899c2bc )
        {
            logstring( printed_line );
        }
        
        logstring( "<dev string:x607>" );
        iprintlnbold( "<dev string:x63d>" );
    }

#/

// Namespace magicbox
// Params 1
// Checksum 0xb109a6c7, Offset: 0x229b
// Size: 0x856
function init_magicbox_postmain( params )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    level thread function_d81f48f88df7d05d();
    
    if ( utility::flag_exist( "zone_setup_finished" ) )
    {
        utility::flag_wait( "zone_setup_finished" );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        function_49f4d3157c8ba98d( destination );
    }
    
    if ( isdefined( level.var_2f699c8203773173 ) )
    {
        function_32d641e5e2d224a4();
    }
    
    var_80fa3110dde576c1 = utility::getstructarray( "magicbox_spawn", "script_noteworthy" );
    
    foreach ( i, s_magicbox_info in var_80fa3110dde576c1 )
    {
        if ( !arraycontains( level.var_1bbb5557537e2c0c, s_magicbox_info ) )
        {
            var_93e4a0a8514ca47e = s_magicbox_info.targetname ?? "Magic Box Location " + i;
            
            if ( !isdefined( level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] ) )
            {
                level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] = [];
            }
            
            level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ][ level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ].size ] = s_magicbox_info;
            level.var_1bbb5557537e2c0c[ level.var_1bbb5557537e2c0c.size ] = s_magicbox_info;
        }
    }
    
    if ( level.var_1bbb5557537e2c0c.size || level.force_init_magicbox )
    {
        s_magicbox_bundle = get_magicbox_bundle();
        var_cd16a2e74383ea61 = getactivemapinfobundle();
        var_673bddc38406ad31 = level.var_6a45d9ce4d5f5e82 ?? var_cd16a2e74383ea61.var_d11b33756104cc3d ?? s_magicbox_bundle.var_56dfb8e8df924697;
        assert( isdefined( var_673bddc38406ad31 ), "<dev string:x65a>" + get_magicbox_bundle_name() );
        level.s_magicbox_scaling = level.s_magicbox_scaling ?? getscriptbundle( var_673bddc38406ad31 );
        totalweight = 0;
        
        foreach ( var_c5fb7b9c0ca383b7 in level.s_magicbox_scaling.weaponclassweights )
        {
            totalweight += var_c5fb7b9c0ca383b7.weight;
            level.var_3d89727cba6243b2[ var_c5fb7b9c0ca383b7.weaponclass ] = totalweight;
        }
        
        foreach ( var_93e4a0a8514ca47e, var_1bbb5557537e2c0c in level.var_e0e84452fe117b5f )
        {
            foreach ( s_magicbox_info in var_1bbb5557537e2c0c )
            {
                if ( s_magicbox_info content_manager::function_e0f0562adcd2c071() )
                {
                    s_magicbox_info.var_93e4a0a8514ca47e = var_93e4a0a8514ca47e;
                    s_magicbox_info function_ab59e6993557d5b6();
                    continue;
                }
                
                foreach ( destination, magicboxes in level.var_e0e84452fe117b5f )
                {
                    foreach ( s_magicbox_struct in magicboxes )
                    {
                        if ( s_magicbox_struct == s_magicbox_info )
                        {
                            level.var_e0e84452fe117b5f[ destination ] = arrayremove( magicboxes, s_magicbox_struct );
                            level.var_1bbb5557537e2c0c = arrayremove( level.var_1bbb5557537e2c0c, s_magicbox_struct );
                        }
                    }
                }
                
                if ( isdefined( s_magicbox_info.target2 ) )
                {
                    a_clips = getentarray( s_magicbox_info.target2, "targetname" );
                    
                    foreach ( clip in a_clips )
                    {
                        clip connectpaths();
                        clip delete();
                    }
                }
            }
        }
        
        waitframe();
        
        if ( s_magicbox_bundle.var_e530993a5997e8fb )
        {
            return;
        }
        
        foreach ( var_93e4a0a8514ca47e, var_1bbb5557537e2c0c in level.var_e0e84452fe117b5f )
        {
            if ( utility::issharedfuncdefined( #"zombie", #"hash_ba1f273364ecd5ca" ) )
            {
                s_magicbox_start = utility::callsharedfunc( #"zombie", #"hash_ba1f273364ecd5ca", var_1bbb5557537e2c0c );
            }
            
            if ( !isdefined( s_magicbox_start ) )
            {
                var_1351807dd8cbe3e6 = [];
                
                if ( level.gametypebundle.var_158a0bbfa7870e17 )
                {
                    utility::flag_wait_or_timeout( "zone_setup_finished", 10 );
                    
                    foreach ( s_magicbox_struct in var_1bbb5557537e2c0c )
                    {
                        if ( s_magicbox_struct.script_flag == "never_start" )
                        {
                            continue;
                        }
                        
                        if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", s_magicbox_struct.origin ) )
                        {
                            var_1351807dd8cbe3e6 = arraycombineunique( var_1351807dd8cbe3e6, [ s_magicbox_struct ] );
                        }
                    }
                }
                
                var_1be230eadbb84e94 = [];
                
                foreach ( s_magicbox_start in var_1bbb5557537e2c0c )
                {
                    if ( s_magicbox_start.script_start )
                    {
                        var_1be230eadbb84e94 = arraycombineunique( var_1be230eadbb84e94, [ s_magicbox_start ] );
                    }
                }
                
                if ( var_1351807dd8cbe3e6.size > 0 )
                {
                    s_magicbox_start = utility::array_random( var_1351807dd8cbe3e6 );
                }
                else if ( var_1be230eadbb84e94.size > 0 )
                {
                    s_magicbox_start = utility::array_random( var_1be230eadbb84e94 );
                }
                else
                {
                    s_magicbox_start = utility::array_random( var_1bbb5557537e2c0c );
                }
            }
            
            assert( isdefined( s_magicbox_start ), "<dev string:x686>" );
            s_magicbox_start thread initial_show_magicbox( 1 );
            s_magicbox_start.var_f14b2b4820b635e7 = 1;
            
            if ( isdefined( level.var_3a91404b9ff1b693 ) )
            {
                s_magicbox_start [[ level.var_3a91404b9ff1b693 ]]();
            }
        }
    }
    
    utility::flag_set( "magicbox_ready" );
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0x63175234, Offset: 0x2af9
// Size: 0x26
function private function_d81f48f88df7d05d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "common_items_init" );
    common_item::function_9c9e4c71569f3ae8( &function_b190a58d96c55ce6 );
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0x296722cc, Offset: 0x2b27
// Size: 0xe7
function private setup_magicbox_limits()
{
    level.var_8d848b3dc37f33a9 = [];
    s_magicbox_bundle = get_magicbox_bundle();
    
    if ( !isdefined( s_magicbox_bundle.var_d989f475071a2625 ) )
    {
        return;
    }
    
    foreach ( itemlimit in s_magicbox_bundle.var_d989f475071a2625 )
    {
        if ( !isdefined( itemlimit.itementry ) )
        {
            continue;
        }
        
        level.var_8d848b3dc37f33a9[ itemlimit.itementry ] = { #itemmax:itemlimit.itemmax, #spawneditems:[] };
    }
}

// Namespace magicbox
// Params 2
// Checksum 0x69bb9750, Offset: 0x2c16
// Size: 0x60
function function_6c4ffb8218367c4b( var_827e6c420604dd2, n_count = 1 )
{
    if ( !isdefined( level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ] ) )
    {
        return;
    }
    
    level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ].itemmax += n_count;
}

// Namespace magicbox
// Params 1
// Checksum 0x10111875, Offset: 0x2c7e
// Size: 0x123, Type: bool
function function_239d5db0d6aabc4c( var_827e6c420604dd2 )
{
    if ( !isdefined( level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ] ) )
    {
        return false;
    }
    
    level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ].spawneditems = function_5713d46873b29625( level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ].spawneditems );
    var_e04e968d3586de35 = level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ].spawneditems.size;
    s_item_entry = getscriptbundle( var_827e6c420604dd2 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player function_a8d6931ced6667c5( s_item_entry ) )
        {
            var_e04e968d3586de35++;
        }
    }
    
    return level.var_8d848b3dc37f33a9[ var_827e6c420604dd2 ].itemmax <= var_e04e968d3586de35;
}

// Namespace magicbox
// Params 1
// Checksum 0xaa0fa273, Offset: 0x2daa
// Size: 0x1cd, Type: bool
function function_104dda0cb2a785ee( weapon_root_name )
{
    var_420357ec922c43fa = undefined;
    found_item_entry = undefined;
    var_a86bcbe6852d23b1 = undefined;
    
    foreach ( var_827e6c420604dd2, limit_struct in level.var_8d848b3dc37f33a9 )
    {
        s_item_entry = getscriptbundle( var_827e6c420604dd2 );
        
        if ( s_item_entry.ref === weapon_root_name )
        {
            var_420357ec922c43fa = limit_struct;
            found_item_entry = var_827e6c420604dd2;
            var_a86bcbe6852d23b1 = s_item_entry;
            break;
        }
    }
    
    if ( !var_420357ec922c43fa )
    {
        return false;
    }
    
    var_da7cae5e61c475bb = max( var_420357ec922c43fa.itemmax, 1 );
    level.var_8d848b3dc37f33a9[ found_item_entry ].spawneditems = function_5713d46873b29625( level.var_8d848b3dc37f33a9[ found_item_entry ].spawneditems );
    var_e04e968d3586de35 = level.var_8d848b3dc37f33a9[ found_item_entry ].spawneditems.size;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player function_a8d6931ced6667c5( var_a86bcbe6852d23b1 ) )
        {
            var_e04e968d3586de35++;
        }
    }
    
    return var_da7cae5e61c475bb <= var_e04e968d3586de35;
}

// Namespace magicbox
// Params 1, eflags: 0x4
// Checksum 0x5c783310, Offset: 0x2f80
// Size: 0x120
function private function_b190a58d96c55ce6( params )
{
    if ( isdefined( params.item ) && isdefined( params.itembundle ) )
    {
        item_name = common_item::function_e044c3e813daec3a( params.itembundle );
        
        if ( !isdefined( level.var_8d848b3dc37f33a9[ item_name ] ) )
        {
            if ( !isdefined( params.spawnoptions.weapon ) )
            {
                return;
            }
            
            item_name = item_weapon::function_3da93a43aae4473d( params.spawnoptions.weapon.basename, params.spawnoptions.rarity, params.spawnoptions.weapon.variantid );
            
            if ( !( isdefined( item_name ) && isdefined( level.var_8d848b3dc37f33a9[ item_name ] ) ) )
            {
                return;
            }
        }
        
        level.var_8d848b3dc37f33a9[ item_name ].spawneditems[ level.var_8d848b3dc37f33a9[ item_name ].spawneditems.size ] = params.item;
    }
}

// Namespace magicbox
// Params 1
// Checksum 0x9fb80b14, Offset: 0x30a8
// Size: 0x13b
function setup_magicbox_weapons( a_s_magicbox_weapons )
{
    if ( isdefined( level.weaponmetadata ) )
    {
        var_cd16a2e74383ea61 = getactivemapinfobundle();
        s_magicbox_bundle = get_magicbox_bundle();
        level.var_54989577c4e434aa = s_magicbox_bundle.weaponitemspawnlist ?? level.weaponmetadata[ "magicbox_settings" ].weaponitemspawnlist;
        level.var_278a6b84a3269b8c = var_cd16a2e74383ea61.var_6498b8ae36b31bc0 ?? s_magicbox_bundle.supportitemspawnlist ?? level.weaponmetadata[ "magicbox_settings" ].var_cdf3904616e50bf8;
        level.var_b29a644f57572450 = s_magicbox_bundle.equipmentitemspawnlist;
        level.var_8b6bf63f61fe01f9 = s_magicbox_bundle.wonderweaponitemspawnlist ?? level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist;
        level.var_ae71d4cfe02b434e = s_magicbox_bundle.miscitemspawnlist;
        level.var_85de712d04e11e60 = var_cd16a2e74383ea61.var_469602557e792d37 ?? s_magicbox_bundle.var_56dea7386526b2c5;
        function_99cb99fedb71b3b2();
        function_8e43becf2ff168b5();
    }
    
    utility::flag_set( "setup_magicbox_weapons" );
}

// Namespace magicbox
// Params 0
// Checksum 0x710025d5, Offset: 0x31eb
// Size: 0x61f
function function_99cb99fedb71b3b2()
{
    s_magicbox_bundle = get_magicbox_bundle();
    
    if ( isdefined( level.var_278a6b84a3269b8c ) )
    {
        var_77994755fc6af2b9 = getscriptbundle( level.var_278a6b84a3269b8c );
    }
    
    if ( isdefined( level.var_b29a644f57572450 ) )
    {
        s_equipment_itemspawnlist = getscriptbundle( level.var_b29a644f57572450 );
    }
    
    if ( isdefined( level.var_8b6bf63f61fe01f9 ) )
    {
        var_d91f931cb51882ba = getscriptbundle( level.var_8b6bf63f61fe01f9 );
    }
    
    if ( isdefined( level.var_ae71d4cfe02b434e ) )
    {
        var_57748a5a033c2d89 = getscriptbundle( level.var_ae71d4cfe02b434e );
    }
    
    if ( isdefined( level.var_85de712d04e11e60 ) )
    {
        var_9ade968842806e95 = getscriptbundle( level.var_85de712d04e11e60 );
    }
    
    if ( isdefined( s_magicbox_bundle.var_a046db76735092e8 ) )
    {
        foreach ( var_86f37deaf36aa86c in s_magicbox_bundle.var_a046db76735092e8 )
        {
            if ( isdefined( var_86f37deaf36aa86c.wonderweaponlist ) && var_86f37deaf36aa86c.mapname == getxhash( level.mapname ) )
            {
                level.var_8b6bf63f61fe01f9 = var_86f37deaf36aa86c.wonderweaponlist;
                var_d91f931cb51882ba = getscriptbundle( level.var_8b6bf63f61fe01f9 );
                break;
            }
        }
    }
    
    if ( isarray( var_77994755fc6af2b9.itementries ) )
    {
        if ( !isdefined( level.var_d369ca5ece90f60a ) )
        {
            level.var_d369ca5ece90f60a = [];
        }
        
        foreach ( s_itementry in var_77994755fc6af2b9.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x6ac>" + level.var_278a6b84a3269b8c + "<dev string:x337>" );
                continue;
            }
            
            level.var_d369ca5ece90f60a = arraycombineunique( level.var_d369ca5ece90f60a, [ s_itementry.itemspawnentry ] );
        }
    }
    
    if ( isarray( s_equipment_itemspawnlist.itementries ) )
    {
        if ( !isdefined( level.var_799d08d7b7ba522e ) )
        {
            level.var_799d08d7b7ba522e = [];
        }
        
        foreach ( s_itementry in s_equipment_itemspawnlist.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x6ac>" + level.var_b29a644f57572450 + "<dev string:x337>" );
                continue;
            }
            
            level.var_799d08d7b7ba522e = arraycombineunique( level.var_799d08d7b7ba522e, [ s_itementry.itemspawnentry ] );
        }
    }
    
    if ( isarray( var_d91f931cb51882ba.itementries ) )
    {
        if ( !isdefined( level.var_c5111f0d24e5789a ) )
        {
            level.var_c5111f0d24e5789a = [];
        }
        
        foreach ( s_itementry in var_d91f931cb51882ba.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x6ac>" + level.var_8b6bf63f61fe01f9 + "<dev string:x337>" );
                continue;
            }
            
            level.var_c5111f0d24e5789a = arraycombineunique( level.var_c5111f0d24e5789a, [ s_itementry.itemspawnentry ] );
        }
    }
    
    if ( isarray( var_57748a5a033c2d89.itementries ) )
    {
        if ( !isdefined( level.var_7b6a48d1d8229d18 ) )
        {
            level.var_7b6a48d1d8229d18 = [];
        }
        
        foreach ( s_itementry in var_57748a5a033c2d89.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x6db>" + level.var_ae71d4cfe02b434e + "<dev string:x337>" );
                continue;
            }
            
            level.var_7b6a48d1d8229d18 = arraycombineunique( level.var_7b6a48d1d8229d18, [ s_itementry.itemspawnentry ] );
        }
    }
    
    if ( isarray( var_9ade968842806e95.itementries ) )
    {
        if ( !isdefined( level.var_d46bd3e7f2f3e08e ) )
        {
            level.var_d46bd3e7f2f3e08e = [];
        }
        
        foreach ( s_itementry in var_9ade968842806e95.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x6db>" + level.var_85de712d04e11e60 + "<dev string:x337>" );
                continue;
            }
            
            level.var_d46bd3e7f2f3e08e = arraycombineunique( level.var_d46bd3e7f2f3e08e, [ s_itementry.itemspawnentry ] );
        }
    }
}

// Namespace magicbox
// Params 0
// Checksum 0x484d87bf, Offset: 0x3812
// Size: 0x117
function function_8e43becf2ff168b5()
{
    level.var_c94175b5e96b794c = [];
    function_46f699d4f5fd8dba( level.var_54989577c4e434aa );
    function_46f699d4f5fd8dba( level.var_278a6b84a3269b8c );
    function_46f699d4f5fd8dba( level.var_b29a644f57572450 );
    function_46f699d4f5fd8dba( level.var_ae71d4cfe02b434e );
    
    if ( !level.var_641b7c91f663ea4f )
    {
        function_46f699d4f5fd8dba( level.var_8b6bf63f61fe01f9 );
    }
    
    /#
        if ( !isdefined( level.var_c94175b5e96b794c ) || level.var_c94175b5e96b794c.size == 0 )
        {
            assertmsg( "<dev string:x70b>" );
        }
    #/
    
    foreach ( var_757fdb560c65df00 in level.var_c94175b5e96b794c )
    {
        assert( isdefined( var_757fdb560c65df00 ), "<dev string:x72d>" );
    }
}

// Namespace magicbox
// Params 0
// Checksum 0x58d1a675, Offset: 0x3931
// Size: 0x11a
function function_b787d845dbbfa18e()
{
    function_8e43becf2ff168b5();
    var_d91f931cb51882ba = getscriptbundle( hashcat( %"itemspawnlist:", level.var_8b6bf63f61fe01f9 ) );
    
    if ( isarray( var_d91f931cb51882ba.itementries ) )
    {
        level.var_c5111f0d24e5789a = [];
        
        foreach ( s_itementry in var_d91f931cb51882ba.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                continue;
            }
            
            level.var_c5111f0d24e5789a = arraycombineunique( level.var_c5111f0d24e5789a, [ s_itementry.itemspawnentry ] );
        }
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x93>" );
        function_91a85f5f9f860ab6( level.var_8b6bf63f61fe01f9 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace magicbox
// Params 1
// Checksum 0x2acbf124, Offset: 0x3a53
// Size: 0x283
function function_46f699d4f5fd8dba( str_item_spawn_list )
{
    if ( !isdefined( str_item_spawn_list ) )
    {
        return;
    }
    
    s_bundle = getscriptbundle( str_item_spawn_list );
    
    if ( !isdefined( s_bundle ) && isstring( str_item_spawn_list ) )
    {
        s_bundle = getscriptbundle( hashcat( %"itemspawnlist:", str_item_spawn_list ) );
    }
    
    if ( isarray( s_bundle.itementries ) )
    {
        foreach ( s_itementry in s_bundle.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:x316>" + str_item_spawn_list + "<dev string:x337>" );
                continue;
            }
            
            if ( !isdefined( s_itementry.weight ) || s_itementry.weight == 0 )
            {
                continue;
            }
            
            sb_itementry = getscriptbundle( s_itementry.itemspawnentry );
            
            if ( !isdefined( sb_itementry.ref ) )
            {
                continue;
            }
            
            item_name = getxhashasset( sb_itementry.ref );
            
            if ( getdvarint( @"hash_fc74f94143cf660f", 1 ) )
            {
                level.var_c94175b5e96b794c[ item_name ] = sb_itementry.worldmodel ?? "tag_origin";
                continue;
            }
            
            if ( isdefined( sb_itementry.worldmodel ) )
            {
                level.var_c94175b5e96b794c[ item_name ] = sb_itementry.worldmodel;
            }
        }
    }
    
    if ( isarray( s_bundle.itemlistentries ) )
    {
        foreach ( var_8fe1c40c3cabe229 in s_bundle.itemlistentries )
        {
            if ( !isdefined( var_8fe1c40c3cabe229.weight ) || var_8fe1c40c3cabe229.weight == 0 )
            {
                continue;
            }
            
            if ( isdefined( var_8fe1c40c3cabe229.itemspawnlist ) )
            {
                function_46f699d4f5fd8dba( var_8fe1c40c3cabe229.itemspawnlist );
            }
        }
    }
}

// Namespace magicbox
// Params 1
// Checksum 0xdb57f769, Offset: 0x3cde
// Size: 0x118
function function_49f4d3157c8ba98d( destination )
{
    foreach ( location in destination.locations )
    {
        var_ca27c2d35d7a1248 = location.instances[ "magicbox" ];
        
        if ( isdefined( var_ca27c2d35d7a1248 ) )
        {
            foreach ( instance in var_ca27c2d35d7a1248.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace magicbox
// Params 0
// Checksum 0x20d41be8, Offset: 0x3dfe
// Size: 0x280
function function_32d641e5e2d224a4()
{
    a_spawn_points = [];
    var_aa72fc23f7515d32 = utility::getstructarray( "content_struct", "variantname" );
    
    foreach ( struct in var_aa72fc23f7515d32 )
    {
        if ( struct.content_key == "magicbox_spawn" )
        {
            a_spawn_points = arraycombineunique( a_spawn_points, [ struct ] );
        }
    }
    
    var_612cc3eb25889394 = utility::getstructarray( "magicbox_spawn", "script_noteworthy" );
    
    foreach ( s_magicbox_info in var_612cc3eb25889394 )
    {
        a_spawn_points = arraycombineunique( a_spawn_points, [ s_magicbox_info ] );
    }
    
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        a_spawn_points = [[ level.var_37ee95c5464d47be ]]( "magicbox", a_spawn_points );
    }
    
    foreach ( spawn_point in a_spawn_points )
    {
        region = [[ level.var_2f699c8203773173 ]]( spawn_point.origin );
        
        if ( isdefined( region ) )
        {
            if ( isstruct( region ) )
            {
                str_region_name = region.name;
            }
            else
            {
                str_region_name = region;
            }
            
            if ( !isdefined( level.var_e0e84452fe117b5f[ str_region_name ] ) )
            {
                level.var_e0e84452fe117b5f[ str_region_name ] = [];
            }
            
            level.var_e0e84452fe117b5f[ str_region_name ] = arraycombineunique( level.var_e0e84452fe117b5f[ str_region_name ], [ spawn_point ] );
            level.var_1bbb5557537e2c0c = arraycombineunique( level.var_1bbb5557537e2c0c, [ spawn_point ] );
        }
    }
    
    callback::callback( "ob_mysteryboxes_create_script_done" );
}

// Namespace magicbox
// Params 1, eflags: 0x4
// Checksum 0x1f6f193e, Offset: 0x4086
// Size: 0x83
function private on_spawn_magicbox( instance )
{
    var_5020a2bdb0452018 = instance.var_1d6cddfc47031bff[ "magicbox_spawn" ];
    
    if ( !isarray( var_5020a2bdb0452018 ) )
    {
        return;
    }
    
    var_93e4a0a8514ca47e = instance.location.destination.targetname;
    level.var_1bbb5557537e2c0c = arraycombineunique( level.var_1bbb5557537e2c0c, var_5020a2bdb0452018 );
    level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] = var_5020a2bdb0452018;
}

// Namespace magicbox
// Params 0
// Checksum 0xa82a0a5a, Offset: 0x4111
// Size: 0x44a
function function_ab59e6993557d5b6()
{
    if ( !arraycontains( level.var_1bbb5557537e2c0c, self ) )
    {
        var_93e4a0a8514ca47e = self.targetname ?? "Magic Box Location " + level.var_1bbb5557537e2c0c.size;
        
        if ( !isdefined( level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] ) )
        {
            level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] = [];
        }
        
        level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ][ level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ].size ] = self;
        level.var_1bbb5557537e2c0c[ level.var_1bbb5557537e2c0c.size ] = self;
    }
    
    s_bundle = get_magicbox_bundle();
    
    if ( getdvar( @"hash_c54cb1665ac3afb6", "" ) != "" )
    {
        self.var_16c78d02bcf00cbc = getdvar( @"hash_c54cb1665ac3afb6" );
    }
    
    if ( !isdefined( self.mdl_magicbox ) )
    {
        str_model_field = function_72f7be2f9191b13d( "model", self.script_parameters );
        var_1479f07b528e4ff7 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), str_model_field );
        
        if ( isdefined( s_bundle.model ) && !isdefined( self.var_16c78d02bcf00cbc ) )
        {
            self.mdl_magicbox = content_manager::spawn_script_model( self, var_1479f07b528e4ff7, 1, 1 );
        }
        else
        {
            self.mdl_magicbox = spawnscriptable( self.var_16c78d02bcf00cbc, self.origin, self.angles );
        }
    }
    
    self.mdl_magicbox setnodeploy( 1 );
    
    if ( !isdefined( self.script_currency ) )
    {
        self.script_currency = level.magicbox_currency_type;
    }
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 80;
    }
    
    if ( !isdefined( self.script_cost ) )
    {
        self.script_cost = level.var_afd75d0da8d05e42;
    }
    
    self.var_410b736ba41817c2 = 0;
    self.var_1c98168ff9213851 = 0;
    assert( isdefined( s_bundle.var_982ed114d477beb0 ) && isdefined( s_bundle.var_42ce210854a6b3b1 ), "<dev string:x765>" );
    self.str_hint_default = s_bundle.var_982ed114d477beb0;
    self.var_f57236aa9220f37e = s_bundle.var_42ce210854a6b3b1;
    self.interact_hint_title = s_bundle.var_9a0a55bbe0b5f083;
    self.interact_hint_description = s_bundle.var_29067727e2acffa7;
    self.interact_hint_icon = s_bundle.objectiveicon;
    self.var_799bdecb01eaf2 = s_bundle.var_38acce84763092b6;
    self.var_3c2514205dd47251 = s_bundle.var_ffba0987b7a8a418;
    self.var_d9574a179687fbd5 = s_bundle.var_f6222b001103654;
    self.var_5388b359bbe47fbe = s_bundle.var_77d7cc7e1abf495d;
    
    if ( !isdefined( self.mdl_magicbox.interact ) )
    {
        self.mdl_magicbox.interact = interaction::register_interact( self.mdl_magicbox, self.radius, &on_use_magicbox, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
        self.mdl_magicbox.interact interaction::set_interact_hint_callback( &function_c8c676b5313274 );
        self.mdl_magicbox.interact setusefov( 80 );
    }
    
    if ( self.mdl_magicbox.interact tagexists( "tag_hint" ) )
    {
        self.mdl_magicbox.interact sethinttag( "tag_hint" );
    }
    
    self.icon = s_bundle.objectiveicon;
    self.mdl_magicbox.interact.var_349a0723ed9ac19c = self;
    self.mdl_magicbox thread function_18eef21819174f94();
    
    if ( !self.mdl_magicbox callback::exists( #"on_ping", &magicbox_on_ping ) )
    {
        self.mdl_magicbox callback::add( #"on_ping", &magicbox_on_ping );
    }
    
    hide_magicbox( 1 );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.mdl_magicbox, "icon", 0 );
    callback::callback( #"hash_ad40d2adc92426c" );
}

// Namespace magicbox
// Params 1
// Checksum 0xb59cf937, Offset: 0x4563
// Size: 0x3d
function magicbox_on_ping( params )
{
    thread calloutmarkerping::function_3c501da3379eca0a( params.player, params.pingindex, undefined, [ "death", "delete_magicbox_pings" ] );
}

// Namespace magicbox
// Params 0, eflags: 0xc
// Checksum 0xb27c4564, Offset: 0x45a8
// Size: 0x49
function private function_18eef21819174f94()
{
    self notify( #"hash_9c523ad313f07700" );
    self endon( #"hash_9c523ad313f07700" );
    var_3f8d9d22e4f9ac4c = self.origin;
    self waittill( #"death" );
    logstring( "====Magic Box Deleted at location " + var_3f8d9d22e4f9ac4c );
}

// Namespace magicbox
// Params 2
// Checksum 0x88460d49, Offset: 0x45f9
// Size: 0x221
function hide_magicbox( b_immediate, var_c9120d51fd7baa41 )
{
    self notify( #"hash_ddfdafddc7c57f89" );
    self endon( #"hash_ddfdafddc7c57f89" );
    
    if ( isdefined( self.var_7a56e95c47567b86 ) )
    {
        self.var_7a56e95c47567b86 delete();
    }
    
    if ( isdefined( self.mdl_magicbox ) )
    {
        self.mdl_magicbox endon( #"death" );
        level endon( #"run_fire_sale" );
        
        while ( self.mdl_magicbox.interact.b_opened_magicbox )
        {
            waitframe();
        }
        
        self.mdl_magicbox.interact setusableenabled( 0 );
        self.var_9870f882980ab31b = undefined;
        
        if ( b_immediate )
        {
            if ( var_c9120d51fd7baa41 )
            {
                self.mdl_magicbox setscriptablepartstate( "audio_oneshots", "firesale_disappear" );
            }
            
            self.mdl_magicbox setscriptablepartstate( "base", "hide" );
            b_set_state = self.mdl_magicbox utility::function_7c10ea82c1e305b8( "model_and_collision", "hide" );
            
            if ( b_set_state && isent( self.mdl_magicbox ) )
            {
                self.mdl_magicbox notsolid();
            }
        }
        else
        {
            base_state = self.mdl_magicbox getscriptablepartstate( "base" );
            
            if ( base_state != "hide" && base_state != "leaving" )
            {
                self.mdl_magicbox setscriptablepartstate( "base", "leaving" );
            }
        }
        
        self.mdl_magicbox thread cleanup_magicbox_grenades();
        
        if ( isdefined( level.var_a681fe81093a1924 ) )
        {
            self.mdl_magicbox thread [[ level.var_a681fe81093a1924 ]]( 0 );
        }
        else
        {
            self.mdl_magicbox setscriptablepartstate( "beam", "off" );
        }
        
        self.mdl_magicbox utility::function_7c10ea82c1e305b8( "plinth", "off" );
        self.mdl_magicbox setscriptablepartstate( "icon", "hidden" );
        self.mdl_magicbox notify( #"delete_magicbox_pings" );
    }
}

// Namespace magicbox
// Params 2
// Checksum 0xb9e70ab6, Offset: 0x4822
// Size: 0x1a3
function show_magicbox( b_immediate, var_c9120d51fd7baa41 )
{
    self notify( #"hash_fab2c9093b579a97" );
    self endon( #"hash_fab2c9093b579a97" );
    
    if ( isdefined( self.mdl_magicbox ) )
    {
        self.var_9870f882980ab31b = 1;
        
        if ( b_immediate )
        {
            self.mdl_magicbox setscriptablepartstate( "base", "closed" );
            self.mdl_magicbox.interact function_de48127d5b3b7e8c();
        }
        else
        {
            self.mdl_magicbox setscriptablepartstate( "base", "arriving" );
            self.mdl_magicbox.interact utility::delaythread( 5, &function_de48127d5b3b7e8c );
        }
        
        if ( isdefined( level.var_a681fe81093a1924 ) )
        {
            self.mdl_magicbox thread [[ level.var_a681fe81093a1924 ]]( 1 );
        }
        else
        {
            self.mdl_magicbox setscriptablepartstate( "beam", "on" );
        }
        
        self.mdl_magicbox utility::function_7c10ea82c1e305b8( "plinth", "on" );
        
        if ( isent( self.mdl_magicbox ) )
        {
            self.mdl_magicbox solid();
        }
        
        self.mdl_magicbox utility::function_7c10ea82c1e305b8( "model_and_collision", "default" );
        self.mdl_magicbox setscriptablepartstate( "icon", "active" );
        
        if ( !isdefined( self.var_7a56e95c47567b86 ) )
        {
            self.var_7a56e95c47567b86 = utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "magicbox" );
        }
        
        callback::callback( #"hash_1476c6ebca52a63f" );
    }
}

// Namespace magicbox
// Params 2, eflags: 0x4
// Checksum 0xc63cea62, Offset: 0x49cd
// Size: 0x40
function private initial_show_magicbox( b_immediate, var_c9120d51fd7baa41 )
{
    level endon( #"game_ended" );
    self.mdl_magicbox utility::ent_flag_wait( "minimap_floor_setup_complete" );
    show_magicbox( b_immediate, var_c9120d51fd7baa41 );
}

// Namespace magicbox
// Params 0
// Checksum 0x71f62790, Offset: 0x4a15
// Size: 0x3a
function function_de48127d5b3b7e8c()
{
    if ( !self.var_349a0723ed9ac19c utility::ent_flag( "magicbox_weapon_roulette_active" ) && !self.var_349a0723ed9ac19c.var_9e211bca8759c579 )
    {
        self setusableenabled( 1 );
    }
}

// Namespace magicbox
// Params 2, eflags: 0x4
// Checksum 0xd88f9155, Offset: 0x4a57
// Size: 0x2a0
function private function_c8c676b5313274( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) && !player.interactions_disabled && !player.var_432159241a2f9367 )
    {
        if ( isdefined( usable.interact.var_349a0723ed9ac19c ) )
        {
            magicbox = usable.interact.var_349a0723ed9ac19c;
            legacy_string = "";
            hint_aux_text = "";
            var_776a268784e089af = magicbox.var_799bdecb01eaf2;
            can_interact = 1;
            buttoncallout = magicbox.var_5388b359bbe47fbe;
            cost = player function_e034b4cbe8f5aed6( magicbox.script_cost, magicbox );
            is_locked = 0;
            
            if ( utility::issharedfuncdefined( #"zombie", #"hash_94c031f0ec7f54c7" ) )
            {
                [ is_locked, custom_hint_string, var_6f8481a51699cef ] = utility::callsharedfunc( #"zombie", #"hash_94c031f0ec7f54c7", magicbox );
            }
            
            if ( is_locked )
            {
                buttoncallout = custom_hint_string;
                
                if ( !player currency::can_afford( magicbox.script_currency, cost ) )
                {
                    hint_aux_text = var_6f8481a51699cef;
                    can_interact = 0;
                }
            }
            else if ( player currency::can_afford( magicbox.script_currency, cost ) )
            {
                legacy_string = magicbox.str_hint_default;
            }
            else
            {
                legacy_string = magicbox.var_f57236aa9220f37e;
                hint_aux_text = magicbox.var_d9574a179687fbd5;
                var_776a268784e089af = magicbox.var_3c2514205dd47251;
                can_interact = 0;
            }
            
            return { #interactable:can_interact, #icon_text_value:cost, #var_776a268784e089af:magicbox.var_799bdecb01eaf2, #buttoncallout:buttoncallout, #icon:magicbox.interact_hint_icon, #aux_text:hint_aux_text, #description:magicbox.interact_hint_description, #title:magicbox.interact_hint_title, #params:[ cost ], #string:legacy_string, #type:"HINT_BUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace magicbox
// Params 0
// Checksum 0xa7279e8f, Offset: 0x4d00
// Size: 0x2cb
function function_4f9ffedb29cd4a7e()
{
    level notify( #"end_firesale_start" );
    level endon( #"end_firesale_start" );
    
    if ( isdefined( level.var_38c8e837d5227f73 ) )
    {
        self [[ level.var_38c8e837d5227f73 ]]();
    }
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        if ( !isdefined( var_349a0723ed9ac19c.mdl_magicbox ) )
        {
            continue;
        }
        
        if ( isdefined( level.timetravel.timeline.name ) && isdefined( var_349a0723ed9ac19c.script_parameters ) && var_349a0723ed9ac19c.script_parameters != level.timetravel.timeline.name )
        {
            continue;
        }
        
        if ( var_349a0723ed9ac19c.b_skip_firesale )
        {
            continue;
        }
        
        if ( isdefined( var_349a0723ed9ac19c.mdl_magicbox ) )
        {
            var_349a0723ed9ac19c.mdl_magicbox setscriptablepartstate( "firesale_audio", "activate" );
        }
        
        if ( !isdefined( var_349a0723ed9ac19c.n_original_cost ) )
        {
            var_349a0723ed9ac19c.n_original_cost = var_349a0723ed9ac19c.script_cost;
            var_349a0723ed9ac19c.script_cost = currency::get_magicbox_cost_firesale() ?? 10;
        }
        
        if ( !var_349a0723ed9ac19c.var_f14b2b4820b635e7 && !var_349a0723ed9ac19c.var_9870f882980ab31b )
        {
            var_349a0723ed9ac19c show_magicbox();
            continue;
        }
        
        if ( utility::flag( "magicbox_moving" ) )
        {
            if ( var_349a0723ed9ac19c.var_f14b2b4820b635e7 )
            {
                var_349a0723ed9ac19c.var_1c98168ff9213851--;
                level.var_1c98168ff9213851--;
            }
            
            if ( isdefined( var_349a0723ed9ac19c.mdl_current_weapon ) )
            {
                var_349a0723ed9ac19c.mdl_current_weapon delete();
            }
            
            var_349a0723ed9ac19c.mdl_magicbox function_433f50cee49f0757();
            var_349a0723ed9ac19c show_magicbox( 1 );
        }
        
        var_349a0723ed9ac19c.mdl_magicbox.interact function_de48127d5b3b7e8c();
    }
    
    utility::flag_clear( "magicbox_moving" );
    utility::flag_waitopen( "powerup_fire_sale_active" );
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        var_349a0723ed9ac19c thread function_593e5d172cd1dd27();
    }
}

// Namespace magicbox
// Params 0
// Checksum 0x20d9207f, Offset: 0x4fd3
// Size: 0x9b
function function_6d085c8f7f79538d()
{
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( var_349a0723ed9ac19c.mdl_magicbox ) )
        {
            var_349a0723ed9ac19c.mdl_magicbox setscriptablepartstate( "firesale_audio", "10_seconds_left" );
        }
    }
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0x93760643, Offset: 0x5076
// Size: 0xc2
function private function_593e5d172cd1dd27()
{
    if ( !self.var_f14b2b4820b635e7 )
    {
        hide_magicbox( 1, 1 );
    }
    
    if ( isdefined( self.n_original_cost ) )
    {
        self.script_cost = self.n_original_cost;
        self.n_original_cost = undefined;
        
        if ( self.var_f14b2b4820b635e7 )
        {
            if ( isdefined( self.mdl_magicbox.interact ) )
            {
                if ( self.var_9e211bca8759c579 )
                {
                    self.mdl_magicbox.interact setusableenabled( 0 );
                }
                else
                {
                    self.mdl_magicbox.interact function_de48127d5b3b7e8c();
                }
            }
            
            if ( isdefined( level.var_3a91404b9ff1b693 ) )
            {
                self [[ level.var_3a91404b9ff1b693 ]]();
            }
        }
    }
}

// Namespace magicbox
// Params 0
// Checksum 0xc6531e7c, Offset: 0x5140
// Size: 0xbe
function function_fffa70799bd5381e()
{
    if ( !soundexists( "dx_ob_joav_oban_oann_abox" ) )
    {
        return;
    }
    
    wait 2;
    a_players_nearby = getplayersinradius( self.mdl_current_weapon.origin, 2500 );
    
    foreach ( player in a_players_nearby )
    {
        self.mdl_current_weapon playsoundtoplayer( "dx_ob_joav_oban_oann_abox", player, self.mdl_current_weapon );
    }
}

// Namespace magicbox
// Params 1
// Checksum 0x7e9430ec, Offset: 0x5206
// Size: 0x17
function function_193ed9e2a7303c24( str_scriptable_state )
{
    level.var_e28fc9c2ccfdfe06 = str_scriptable_state;
}

// Namespace magicbox
// Params 0
// Checksum 0x123e6583, Offset: 0x5225
// Size: 0x6e1
function function_69dbb1d398532e24()
{
    level endon( #"powerup_fire_sale_active" );
    self endon( #"stop_moving" );
    utility::flag_set( "magicbox_moving" );
    self.var_1c98168ff9213851++;
    level.var_1c98168ff9213851++;
    
    if ( isdefined( self.mdl_magicbox.interact ) )
    {
        self.mdl_magicbox.interact.b_opened_magicbox = undefined;
    }
    
    self.b_is_moving = 1;
    level.var_70c5979783790e1b = undefined;
    
    if ( isdefined( self.mdl_magicbox ) )
    {
        self.mdl_magicbox utility::function_7c10ea82c1e305b8( "audio_oneshots", level.var_e28fc9c2ccfdfe06 ?? "bunny_sound" );
    }
    
    thread function_fffa70799bd5381e();
    
    if ( !isdefined( level._effect[ "magic_box_bunny_fly_away_fx" ] ) )
    {
        var_1d17203dd7783b1d = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicBoxJokerVFX" );
        assert( isdefined( var_1d17203dd7783b1d ), "<dev string:x79a>" );
        level._effect[ "magic_box_bunny_fly_away_fx" ] = loadfxasset( var_1d17203dd7783b1d );
    }
    
    waitframe();
    playfxontag( utility::getfx( "magic_box_bunny_fly_away_fx" ), self.mdl_current_weapon, getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicBoxJokerModelVFXTag" ) ?? "tag_origin" );
    var_d6ace126b1edd698 = function_72f7be2f9191b13d( "magicBoxJokerFlyAwayType", self.script_parameters );
    var_d36b7ae7f812c693 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_d6ace126b1edd698 );
    
    if ( var_d36b7ae7f812c693 == "FlyVertical" )
    {
        wait 3;
        
        if ( isdefined( self.mdl_magicbox ) )
        {
            var_1ea0799cfac16dfd = self.mdl_magicbox.origin + anglestoup( self.mdl_magicbox.angles ) * 500;
        }
        else
        {
            var_1ea0799cfac16dfd = self.origin + anglestoup( self.angles ) * 500;
        }
        
        self.mdl_current_weapon moveto( var_1ea0799cfac16dfd, 4, 3 );
        self.mdl_current_weapon waittill( #"movedone" );
    }
    else if ( var_d36b7ae7f812c693 == "SpinningYaw" )
    {
        wait 2;
        var_1ea0799cfac16dfd = self.v_start_weapon_position;
        var_93e4c198656b5ba6 = 5;
        n_start_time_ms = gettime();
        var_1e66e3dc6a65e71e = gettime() + var_93e4c198656b5ba6 * 1000;
        n_rotate_time = 0.5;
        
        while ( gettime() < var_1e66e3dc6a65e71e )
        {
            var_4aecf4a42bd3345b = ( gettime() - n_start_time_ms ) / 1000;
            
            if ( var_4aecf4a42bd3345b > 4 )
            {
                n_rotate_time = 0.25;
            }
            else if ( var_4aecf4a42bd3345b > 3 )
            {
                n_rotate_time = 0.4;
            }
            else if ( var_4aecf4a42bd3345b > 2 )
            {
                n_rotate_time = 0.55;
            }
            else if ( var_4aecf4a42bd3345b > 1 )
            {
                n_rotate_time = 0.75;
            }
            else
            {
                n_rotate_time = 1;
            }
            
            self.mdl_current_weapon rotateyaw( 360, n_rotate_time );
            wait n_rotate_time - 0.05;
        }
        
        n_rotate_time = 0.25;
        self.mdl_current_weapon rotateyaw( 360, n_rotate_time );
        self.mdl_current_weapon moveto( var_1ea0799cfac16dfd, n_rotate_time );
        wait n_rotate_time;
    }
    else
    {
        var_1ea0799cfac16dfd = self.mdl_current_weapon.origin;
        wait 4;
    }
    
    if ( !isdefined( level._effect[ "magic_box_bunny_disappear_fx" ] ) )
    {
        var_13e3fae800bb834f = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicBoxJokerDisappearVFX" );
        assert( isdefined( var_13e3fae800bb834f ), "<dev string:x7da>" );
        level._effect[ "magic_box_bunny_disappear_fx" ] = loadfxasset( var_13e3fae800bb834f );
    }
    
    playfx( utility::getfx( "magic_box_bunny_disappear_fx" ), self.mdl_current_weapon.origin );
    self.mdl_current_weapon delete();
    hide_magicbox();
    
    while ( isdefined( self.mdl_magicbox ) && self.mdl_magicbox getscriptablepartstate( "base", 1 ) == "leaving" )
    {
        waitframe();
    }
    
    self notify( #"magicbox_left" );
    self.var_f14b2b4820b635e7 = undefined;
    hide_magicbox( 1 );
    
    if ( !getscriptbundlefieldvalue( get_magicbox_bundle_name(), #"hash_5285d25fff0ac97f" ) )
    {
        var_79387de0bdfb519f = 0;
        
        if ( isdefined( level.var_8734476d4fee1150 ) )
        {
            if ( isdefined( level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] ) )
            {
                foreach ( var_349a0723ed9ac19c in level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] )
                {
                    if ( var_349a0723ed9ac19c == level.var_8734476d4fee1150 )
                    {
                        var_349a0723ed9ac19c show_magicbox();
                        var_349a0723ed9ac19c.var_f14b2b4820b635e7 = 1;
                        var_79387de0bdfb519f = 1;
                        
                        if ( isdefined( level.var_3a91404b9ff1b693 ) )
                        {
                            var_349a0723ed9ac19c [[ level.var_3a91404b9ff1b693 ]]();
                        }
                        
                        level.var_8734476d4fee1150 = undefined;
                        break;
                    }
                }
            }
            
            if ( !var_79387de0bdfb519f )
            {
                assertmsg( "<dev string:x824>" );
                level.var_8734476d4fee1150 = undefined;
            }
        }
        
        if ( !var_79387de0bdfb519f && isdefined( level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] ) )
        {
            level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] = arrayrandomize( level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] );
            
            foreach ( var_349a0723ed9ac19c in level.var_e0e84452fe117b5f[ self.var_93e4a0a8514ca47e ] )
            {
                if ( var_349a0723ed9ac19c.mdl_magicbox != self.mdl_magicbox && ( !isdefined( var_349a0723ed9ac19c.script_flag ) || level utility::flag( var_349a0723ed9ac19c.script_flag ) ) )
                {
                    if ( isdefined( level.timetravel.timeline ) )
                    {
                        if ( var_349a0723ed9ac19c.script_parameters != level.timetravel.timeline.name )
                        {
                            continue;
                        }
                    }
                    
                    var_349a0723ed9ac19c show_magicbox();
                    var_349a0723ed9ac19c.var_f14b2b4820b635e7 = 1;
                    var_79387de0bdfb519f = 1;
                    
                    if ( isdefined( level.var_3a91404b9ff1b693 ) )
                    {
                        var_349a0723ed9ac19c [[ level.var_3a91404b9ff1b693 ]]();
                    }
                    
                    break;
                }
            }
        }
        
        if ( !var_79387de0bdfb519f )
        {
            thread function_dd2026d5df39bc4d();
        }
    }
    
    self.b_is_moving = undefined;
    utility::flag_clear( "magicbox_moving" );
}

// Namespace magicbox
// Params 0
// Checksum 0xec4b8b2f, Offset: 0x590e
// Size: 0x17
function function_dd2026d5df39bc4d()
{
    wait 60;
    show_magicbox();
    self.var_f14b2b4820b635e7 = 1;
}

// Namespace magicbox
// Params 3
// Checksum 0xb1c25e23, Offset: 0x592d
// Size: 0x245
function on_use_magicbox( player, ignorecost = 0, forceuse = 0 )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( self.b_opened_magicbox )
    {
        return;
    }
    
    if ( player.var_432159241a2f9367 )
    {
        return;
    }
    
    if ( !forceuse && !utility::flag( "powerup_fire_sale_active" ) && !self.var_349a0723ed9ac19c.var_f14b2b4820b635e7 )
    {
        return;
    }
    
    if ( !ignorecost )
    {
        if ( isdefined( player ) && isdefined( self.var_349a0723ed9ac19c.script_currency ) && isdefined( self.var_349a0723ed9ac19c.script_cost ) )
        {
            cost = player function_e034b4cbe8f5aed6( self.var_349a0723ed9ac19c.script_cost, self.var_349a0723ed9ac19c );
            
            if ( !player currency::attempt_purchase( self.var_349a0723ed9ac19c.script_currency, cost, undefined, undefined, #"magicbox" ) )
            {
                return;
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_94c031f0ec7f54c7" ) )
    {
        [ is_locked, hint, string ] = utility::callsharedfunc( #"zombie", #"hash_94c031f0ec7f54c7", self.var_349a0723ed9ac19c );
        
        if ( is_locked )
        {
            if ( utility::issharedfuncdefined( #"zombie", #"hash_d742108a4f8fc408" ) )
            {
                utility::callsharedfunc( #"zombie", #"hash_d742108a4f8fc408", self.var_349a0723ed9ac19c );
            }
            
            return;
        }
    }
    
    self.var_349a0723ed9ac19c.var_37f3a4cd8252c9f0 = player;
    params = spawnstruct();
    params.player = player;
    params.var_349a0723ed9ac19c = self.var_349a0723ed9ac19c;
    player callback::callback( "magicbox_used", params );
    self.var_349a0723ed9ac19c.mdl_magicbox thread function_b64213ee0ff83883( forceuse );
}

// Namespace magicbox
// Params 1
// Checksum 0x94e2712f, Offset: 0x5b7a
// Size: 0x85
function function_b64213ee0ff83883( var_b674a7b202792f5a = 0 )
{
    self.interact.b_opened_magicbox = 1;
    
    if ( !utility::flag( "powerup_fire_sale_active" ) )
    {
        level.var_410b736ba41817c2++;
        self.interact.var_349a0723ed9ac19c.var_410b736ba41817c2++;
    }
    
    thread cleanup_magicbox_grenades();
    self.interact.var_349a0723ed9ac19c thread do_weapon_roulette( undefined, var_b674a7b202792f5a );
}

// Namespace magicbox
// Params 4
// Checksum 0xd08558b, Offset: 0x5c07
// Size: 0x47
function on_magicbox_closed( instance, note, param, var_64ffacba090c91be )
{
    self notify( #"magicbox_closed" );
    self.var_349a0723ed9ac19c notify( #"magicbox_closed" );
}

// Namespace magicbox
// Params 0
// Checksum 0xe5ad7b3e, Offset: 0x5c56
// Size: 0x73
function function_433f50cee49f0757()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    self setscriptablepartstate( "base", "closing" );
    self.interact.var_349a0723ed9ac19c.var_4da360839b7baec4 = undefined;
    utility::waittill_any_timeout( 5, "magicbox_closed" );
    self.interact function_de48127d5b3b7e8c();
    self.interact.b_opened_magicbox = undefined;
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0x59437ca2, Offset: 0x5cd1
// Size: 0xae
function private abort_magicbox()
{
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( !magicbox utility::ent_flag( "magicbox_weapon_roulette_active" ) )
        {
            continue;
        }
        
        magicbox.mdl_magicbox notify( #"abort_magicbox" );
        magicbox cleanup_and_close_magicbox();
        magicbox refund_player();
    }
}

// Namespace magicbox
// Params 0, eflags: 0x4
// Checksum 0x2ed02a87, Offset: 0x5d87
// Size: 0x52
function private refund_player()
{
    if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
    {
        cost = self.var_37f3a4cd8252c9f0 function_e034b4cbe8f5aed6( self.script_cost, self );
        self.var_37f3a4cd8252c9f0 currency::add_currency_amount( self.script_currency, cost );
    }
}

// Namespace magicbox
// Params 1
// Checksum 0xaf582814, Offset: 0x5de1
// Size: 0x4a, Type: bool
function is_map_wonder_weapon( var_4450ba6666aac19a )
{
    s_magicbox_bundle = get_magicbox_bundle();
    s_weaponmetadata = level.weaponmetadata[ getxhashasset( var_4450ba6666aac19a ) ];
    
    if ( s_weaponmetadata.var_3e8739d232e1b023 )
    {
        return true;
    }
    
    return false;
}

// Namespace magicbox
// Params 3
// Checksum 0x2650d9d7, Offset: 0x5e34
// Size: 0xfff
function setup_magicbox_weapon_array( str_override_rarity, round_number_override, var_4b076b5c2a1741db )
{
    self.a_weapon_roulette = [];
    var_937cb6239365a95e = 0;
    var_752fe757816cf4e9 = getarraykeys( level.var_c94175b5e96b794c );
    var_752fe757816cf4e9 = arrayrandomize( var_752fe757816cf4e9 );
    
    foreach ( var_2e08e94c9cb1747c in var_752fe757816cf4e9 )
    {
        if ( var_937cb6239365a95e >= getdvarint( @"hash_2fd0e751c46c5e2c", 7 ) )
        {
            break;
        }
        
        if ( level.var_20cf5eda0c956d52 && is_map_wonder_weapon( var_2e08e94c9cb1747c ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.a_weapon_roulette, var_2e08e94c9cb1747c ) )
        {
            var_937cb6239365a95e++;
            self.a_weapon_roulette[ self.a_weapon_roulette.size ] = var_2e08e94c9cb1747c;
        }
    }
    
    self.a_weapon_roulette = arrayrandomize( self.a_weapon_roulette );
    self.var_15753dbab545fb1d = [];
    self.var_c522add80c32ae2e = undefined;
    var_8e8b89c77b22b0de = [];
    var_eca62771fcdab5f3 = 0;
    var_bbf9e038dd1a8b94 = 0;
    var_f47990d83c7467ca = 0;
    var_ab234575f400af66 = 0;
    var_b13421f35066d980 = 0;
    n_uncommon_pct = 0;
    n_rare_pct = 0;
    n_epic_pct = 0;
    n_legendary_pct = 0;
    n_roll = randomfloat( 100 );
    
    /#
        var_85a87fcb9ac7da01 = getdvarint( @"hash_803f1e8bbe65ac37", -1 );
        
        if ( var_85a87fcb9ac7da01 != -1 )
        {
            n_roll = var_85a87fcb9ac7da01;
        }
    #/
    
    if ( !isdefined( round_number_override ) && isdefined( self.round_number_override ) )
    {
        round_number_override = self.round_number_override;
    }
    
    n_round = round_number_override ?? namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    var_6cf84ad3f940f099 = -1;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_9b0dc89d7217eab6" ) )
    {
        var_6cf84ad3f940f099 = utility::function_6f5d2e1f1ff70482( [[ utility::getsharedfunc( #"game", #"hash_9b0dc89d7217eab6" ) ]]() );
    }
    
    /#
        if ( getdvarint( @"hash_5b9243049e98ac25", -1 ) >= 0 )
        {
            var_6cf84ad3f940f099 = getdvarint( @"hash_5b9243049e98ac25", -1 );
        }
    #/
    
    var_fc65e6b04e7f2b86 = 0;
    var_ed0698e5718fcac3 = 0;
    
    if ( level.s_magicbox_scaling.var_c45c0cb8475a9598 && var_6cf84ad3f940f099 >= 0 )
    {
        foreach ( s_magicbox_scaling in level.s_magicbox_scaling.var_e706c54ff9d8cadc )
        {
            if ( !isdefined( s_magicbox_scaling.var_9fb59ac594b81145 ) )
            {
                s_magicbox_scaling.var_9fb59ac594b81145 = 0;
            }
            
            if ( !isdefined( s_magicbox_scaling.var_1cdf082fd9d95f4b ) )
            {
                s_magicbox_scaling.var_1cdf082fd9d95f4b = 0;
            }
            
            if ( var_6cf84ad3f940f099 >= s_magicbox_scaling.var_9fb59ac594b81145 && var_6cf84ad3f940f099 <= s_magicbox_scaling.var_1cdf082fd9d95f4b )
            {
                var_eca62771fcdab5f3 = 100 - ( s_magicbox_scaling.supportchance ?? 0 );
                var_bbf9e038dd1a8b94 = var_eca62771fcdab5f3 - ( s_magicbox_scaling.equipmentchance ?? 0 );
                var_f47990d83c7467ca = var_bbf9e038dd1a8b94 - ( s_magicbox_scaling.ultrachance ?? 0 );
                var_ab234575f400af66 = var_f47990d83c7467ca - ( s_magicbox_scaling.miscchance ?? 0 );
                var_b13421f35066d980 = var_ab234575f400af66 - ( s_magicbox_scaling.var_a25c417a19b1a275 ?? 0 );
                n_uncommon_pct = s_magicbox_scaling.uncommonchance ?? 0;
                n_rare_pct = s_magicbox_scaling.rarechance ?? 0;
                n_epic_pct = s_magicbox_scaling.epicchance ?? 0;
                n_legendary_pct = s_magicbox_scaling.legendarychance ?? 0;
                var_ed0698e5718fcac3 = 1;
                break;
            }
        }
    }
    else
    {
        foreach ( s_magicbox_scaling in level.s_magicbox_scaling.var_e706c54ff9d8cadc )
        {
            if ( n_round >= s_magicbox_scaling.minround && n_round <= s_magicbox_scaling.maxround )
            {
                var_eca62771fcdab5f3 = 100 - ( s_magicbox_scaling.supportchance ?? 0 );
                var_bbf9e038dd1a8b94 = var_eca62771fcdab5f3 - ( s_magicbox_scaling.equipmentchance ?? 0 );
                var_f47990d83c7467ca = var_bbf9e038dd1a8b94 - ( s_magicbox_scaling.ultrachance ?? 0 );
                var_ab234575f400af66 = var_f47990d83c7467ca - ( s_magicbox_scaling.miscchance ?? 0 );
                var_b13421f35066d980 = var_ab234575f400af66 - ( s_magicbox_scaling.var_a25c417a19b1a275 ?? 0 );
                n_uncommon_pct = s_magicbox_scaling.uncommonchance ?? 0;
                n_rare_pct = s_magicbox_scaling.rarechance ?? 0;
                n_epic_pct = s_magicbox_scaling.epicchance ?? 0;
                n_legendary_pct = s_magicbox_scaling.legendarychance ?? 0;
                var_fc65e6b04e7f2b86 = 1;
                break;
            }
        }
    }
    
    assert( var_fc65e6b04e7f2b86 || var_ed0698e5718fcac3, "<dev string:x86b>" + n_round + "<dev string:x8ab>" + var_6cf84ad3f940f099 + "<dev string:x8da>" );
    var_3aa7e1c5fceaf569 = 0;
    var_4c21ae42ea6db361 = 0;
    var_66cc1f7599eef34b = 0;
    self.rolled_scorestreak = undefined;
    self.var_c472ba9c1811f8cf = undefined;
    self.rolled_wonder = undefined;
    self.var_5875ea9ebe2e7c9d = undefined;
    self.rolled_aether_tool = undefined;
    self.rolled_equipment = undefined;
    self.str_weapon_rarity = undefined;
    str_item_list = level.var_54989577c4e434aa;
    str_override_list = get_override_itemspawnlist( self.var_37f3a4cd8252c9f0, str_override_rarity, var_4b076b5c2a1741db );
    
    if ( isdefined( str_override_list ) )
    {
        str_item_list = str_override_list;
        
        if ( str_item_list == level.var_8b6bf63f61fe01f9 && level.var_20cf5eda0c956d52 )
        {
            str_item_list = level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist ?? "zm_t10_items_magicbox_weapon_wonder_list";
            str_override_list = level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist ?? "zm_t10_items_magicbox_weapon_wonder_list";
        }
    }
    else if ( isdefined( level.var_278a6b84a3269b8c ) && n_roll >= var_eca62771fcdab5f3 )
    {
        str_item_list = level.var_278a6b84a3269b8c;
    }
    else if ( isdefined( level.var_b29a644f57572450 ) && n_roll >= var_bbf9e038dd1a8b94 )
    {
        str_item_list = level.var_b29a644f57572450;
    }
    else if ( isdefined( level.var_8b6bf63f61fe01f9 ) && n_roll >= var_f47990d83c7467ca && !level.var_641b7c91f663ea4f )
    {
        str_item_list = level.var_8b6bf63f61fe01f9;
        
        if ( level.var_20cf5eda0c956d52 )
        {
            str_item_list = level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist ?? "zm_t10_items_magicbox_weapon_wonder_list";
        }
    }
    else if ( isdefined( level.var_ae71d4cfe02b434e ) && n_roll >= var_ab234575f400af66 )
    {
        str_item_list = level.var_ae71d4cfe02b434e;
    }
    else if ( isdefined( level.var_85de712d04e11e60 ) && n_roll >= var_b13421f35066d980 )
    {
        str_item_list = level.var_85de712d04e11e60;
    }
    else
    {
        str_item_list = level.var_54989577c4e434aa;
    }
    
    a_items_rolled = [];
    n_item_tries = 0;
    
    while ( !a_items_rolled.size && n_item_tries < 10 )
    {
        a_items_rolled = common_item::items_selectfromlist( str_item_list, 1 );
        self.var_182083fc5337ebe9 = a_items_rolled[ 0 ];
        n_item_tries += 1;
    }
    
    var_ed255444a88933ed = getdvar( @"hash_5bf38da5a2eda0c8" );
    
    if ( ( isdefined( self.var_a28a6b70b096f4e5 ) || isdefined( level.var_a28a6b70b096f4e5 ) ) && var_ed255444a88933ed == "" )
    {
        var_ed255444a88933ed = self.var_a28a6b70b096f4e5 ?? level.var_a28a6b70b096f4e5;
    }
    else if ( isdefined( self.var_aef038a20b4915b3 ) || isdefined( level.var_aef038a20b4915b3 ) )
    {
        var_ed255444a88933ed = self.var_aef038a20b4915b3 ?? level.var_aef038a20b4915b3;
    }
    else if ( isdefined( self.var_1eb327601c5d083f ) || isdefined( level.var_1eb327601c5d083f ) )
    {
        var_ed255444a88933ed = self.var_1eb327601c5d083f ?? level.var_1eb327601c5d083f;
    }
    else if ( isdefined( self.var_1d277c93fff5ec4d ) || isdefined( level.var_1d277c93fff5ec4d ) )
    {
        var_ed255444a88933ed = self.var_1d277c93fff5ec4d ?? level.var_1d277c93fff5ec4d;
    }
    else if ( isdefined( self.var_3c704de0975a27cf ) || isdefined( level.var_3c704de0975a27cf ) )
    {
        var_ed255444a88933ed = self.var_3c704de0975a27cf ?? level.var_3c704de0975a27cf;
    }
    else if ( isdefined( self.var_63e8ca608d91f693 ) || isdefined( level.var_63e8ca608d91f693 ) )
    {
        var_ed255444a88933ed = self.var_63e8ca608d91f693 ?? level.var_63e8ca608d91f693;
    }
    
    if ( var_ed255444a88933ed )
    {
        logstring( "====Magic Box Forced Item To Select: " + var_ed255444a88933ed );
        self.var_182083fc5337ebe9 = hashcat( %"itemspawnentry:", var_ed255444a88933ed );
    }
    
    if ( !isdefined( self.var_182083fc5337ebe9 ) )
    {
        assertmsg( "<dev string:x8e3>" + str_item_list );
    }
    
    var_9ff2f93ccbf71b93 = getscriptbundle( self.var_182083fc5337ebe9 );
    
    for ( n_item_tries = 0; ( isdefined( self.var_37f3a4cd8252c9f0 ) && !isdefined( str_override_list ) && self.var_37f3a4cd8252c9f0 function_a8d6931ced6667c5( var_9ff2f93ccbf71b93 ) || function_239d5db0d6aabc4c( self.var_182083fc5337ebe9 ) ) && n_item_tries < 10 ; n_item_tries++ )
    {
        if ( isdefined( str_override_list ) )
        {
            a_items_rolled = common_item::items_selectfromlist( str_override_list, 1 );
        }
        else
        {
            a_items_rolled = common_item::items_selectfromlist( level.var_54989577c4e434aa, 1 );
        }
        
        if ( a_items_rolled.size )
        {
            self.var_182083fc5337ebe9 = a_items_rolled[ 0 ];
            var_9ff2f93ccbf71b93 = getscriptbundle( self.var_182083fc5337ebe9 );
        }
    }
    
    if ( !isdefined( self.var_182083fc5337ebe9 ) )
    {
        assertmsg( "<dev string:x8e3>" + str_item_list );
        return;
    }
    
    if ( !isdefined( var_9ff2f93ccbf71b93 ) )
    {
        assertmsg( "<dev string:x90d>" + getxhashsourcename( self.var_182083fc5337ebe9 ) + "<dev string:x913>" );
        return;
    }
    
    if ( isdefined( self.var_1eb327601c5d083f ) || isdefined( level.var_1eb327601c5d083f ) || isdefined( level.var_d369ca5ece90f60a ) && arraycontains( level.var_d369ca5ece90f60a, self.var_182083fc5337ebe9 ) )
    {
        self.rolled_scorestreak = 1;
        self.str_weapon_rarity = "ultra";
        self.str_weapon_rarity = function_c19ee905418ebc92( var_9ff2f93ccbf71b93 );
    }
    else if ( isdefined( self.var_63e8ca608d91f693 ) || isdefined( level.var_63e8ca608d91f693 ) || isdefined( level.var_799d08d7b7ba522e ) && arraycontains( level.var_799d08d7b7ba522e, self.var_182083fc5337ebe9 ) )
    {
        self.rolled_equipment = 1;
        self.str_weapon_rarity = "ultra";
        self.str_weapon_rarity = function_c19ee905418ebc92( var_9ff2f93ccbf71b93 );
    }
    else if ( isdefined( self.var_aef038a20b4915b3 ) || isdefined( level.var_aef038a20b4915b3 ) || isdefined( level.var_c5111f0d24e5789a ) && arraycontains( level.var_c5111f0d24e5789a, self.var_182083fc5337ebe9 ) )
    {
        self.rolled_wonder = 1;
        self.str_weapon_rarity = "ultra";
        self.str_weapon_rarity = function_c19ee905418ebc92( var_9ff2f93ccbf71b93 );
    }
    else if ( isdefined( self.var_1d277c93fff5ec4d ) || isdefined( level.var_1d277c93fff5ec4d ) || isdefined( level.var_7b6a48d1d8229d18 ) && arraycontains( level.var_7b6a48d1d8229d18, self.var_182083fc5337ebe9 ) )
    {
        var_3aa7e1c5fceaf569 = 1;
        self.var_5875ea9ebe2e7c9d = 1;
    }
    else if ( isdefined( self.var_3c704de0975a27cf ) || isdefined( level.var_3c704de0975a27cf ) || level.var_d46bd3e7f2f3e08e.size && arraycontains( level.var_d46bd3e7f2f3e08e, self.var_182083fc5337ebe9 ) )
    {
        var_66cc1f7599eef34b = 1;
        self.var_c472ba9c1811f8cf = 1;
        self.str_weapon_rarity = "ultra_red";
        self.str_weapon_rarity = function_c19ee905418ebc92( var_9ff2f93ccbf71b93 );
    }
    else
    {
        var_4c21ae42ea6db361 = 1;
    }
    
    n_legendary_check = var_b13421f35066d980 - n_legendary_pct;
    n_epic_check = n_legendary_check - n_epic_pct;
    n_rare_check = n_epic_check - n_rare_pct;
    n_uncommon_check = n_rare_check - n_uncommon_pct;
    
    if ( var_3aa7e1c5fceaf569 )
    {
        if ( self.var_182083fc5337ebe9 == %"itemspawnentry:zm_t10_item_aether_tool" )
        {
            if ( level.gametypebundle.var_b12d13411c09d7a5 )
            {
                self.str_weapon_rarity = "";
            }
            else
            {
                n_roll_aether_tool = randomfloat( var_ab234575f400af66 );
                
                if ( utility::issharedfuncdefined( #"relics", #"hash_459bf078b969217d" ) )
                {
                    self.str_weapon_rarity = [[ utility::getsharedfunc( #"relics", #"hash_459bf078b969217d" ) ]]( n_roll_aether_tool, var_ab234575f400af66, n_legendary_pct, n_epic_pct, n_rare_pct, n_uncommon_pct );
                }
                else if ( n_roll_aether_tool >= n_legendary_check )
                {
                    self.str_weapon_rarity = "orange";
                }
                else if ( n_roll_aether_tool >= n_epic_check )
                {
                    self.str_weapon_rarity = "purple";
                }
                else if ( n_roll_aether_tool >= n_rare_check )
                {
                    self.str_weapon_rarity = "blue";
                }
                else
                {
                    self.str_weapon_rarity = "green";
                }
                
                if ( isdefined( str_override_rarity ) )
                {
                    self.str_weapon_rarity = str_override_rarity;
                }
                
                switch ( self.str_weapon_rarity )
                {
                    case #"hash_8d39eb0f19bf9df3":
                        self.var_182083fc5337ebe9 = %"hash_7a0163ba7eb3481";
                        break;
                    case #"hash_35bb3bd014c77f4b":
                        self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_4" );
                        break;
                    case #"hash_598a30e44f53045f":
                        self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_3" );
                        break;
                    case #"hash_778bb52ecd08072d":
                        self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_2" );
                        break;
                }
                
                self.rolled_aether_tool = 1;
            }
        }
        
        return;
    }
    
    if ( var_4c21ae42ea6db361 )
    {
        if ( level.gametypebundle.var_b12d13411c09d7a5 )
        {
            self.str_weapon_rarity = "";
            return;
        }
        
        if ( n_roll >= n_legendary_check )
        {
            self.str_weapon_rarity = "orange";
        }
        else if ( n_roll >= n_epic_check )
        {
            self.str_weapon_rarity = "purple";
        }
        else if ( n_roll >= n_rare_check )
        {
            self.str_weapon_rarity = "blue";
        }
        else
        {
            self.str_weapon_rarity = "green";
        }
        
        if ( isdefined( str_override_rarity ) )
        {
            self.str_weapon_rarity = str_override_rarity;
        }
        
        switch ( self.str_weapon_rarity )
        {
            case #"hash_35bb3bd014c77f4b":
                self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_orange" );
                break;
            case #"hash_598a30e44f53045f":
                self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_purple" );
                break;
            case #"hash_778bb52ecd08072d":
                self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_blue" );
                break;
            default:
                self.var_182083fc5337ebe9 = hashcat( self.var_182083fc5337ebe9, "_green" );
                break;
        }
    }
}

// Namespace magicbox
// Params 1
// Checksum 0xd5d5f08c, Offset: 0x6e3b
// Size: 0x133, Type: bool
function function_c19ee905418ebc92( var_9ff2f93ccbf71b93 )
{
    if ( isdefined( var_9ff2f93ccbf71b93.raritydef ) )
    {
        var_e4f13b03e6e60b7c = getscriptbundle( var_9ff2f93ccbf71b93.raritydef );
        
        if ( isdefined( var_e4f13b03e6e60b7c.magicboxrarity ) )
        {
            str_weapon_rarity = var_e4f13b03e6e60b7c.magicboxrarity;
        }
    }
    else if ( isdefined( var_9ff2f93ccbf71b93.rarity ) )
    {
        switch ( var_9ff2f93ccbf71b93.rarity )
        {
            case 0:
            default:
                str_weapon_rarity = "none";
                break;
            case 1:
                str_weapon_rarity = "uncommon";
                break;
            case 2:
                str_weapon_rarity = "rare";
                break;
            case 3:
                str_weapon_rarity = "epic";
                break;
            case 4:
                str_weapon_rarity = "legendary";
                break;
            case 5:
                str_weapon_rarity = "ultra_red";
                break;
            case 6:
                str_weapon_rarity = "ultra";
                break;
        }
    }
    
    return str_weapon_rarity ?? self.str_weapon_rarity;
}

// Namespace magicbox
// Params 3
// Checksum 0x97a049f4, Offset: 0x6f77
// Size: 0xc0
function get_override_itemspawnlist( player, str_override_rarity, var_4b076b5c2a1741db )
{
    if ( isplayer( player ) && isdefined( level.var_cb8cece2b97f9dc ) )
    {
        foreach ( func in level.var_cb8cece2b97f9dc )
        {
            str_override_list = [[ func ]]( player, str_override_rarity, var_4b076b5c2a1741db );
            
            if ( isdefined( str_override_list ) )
            {
                return str_override_list;
            }
        }
    }
}

// Namespace magicbox
// Params 1
// Checksum 0xfc06a17b, Offset: 0x7040
// Size: 0x3f
function function_1b154b89e87377fa( func_override_itemspawnlist )
{
    if ( !isdefined( level.var_cb8cece2b97f9dc ) )
    {
        level.var_cb8cece2b97f9dc = [];
    }
    
    level.var_cb8cece2b97f9dc = arraycombineunique( level.var_cb8cece2b97f9dc, [ func_override_itemspawnlist ] );
}

// Namespace magicbox
// Params 1
// Checksum 0x25a4e2f7, Offset: 0x7087
// Size: 0x3f
function function_cdf03392d756db87( func_override_rarity )
{
    if ( !isdefined( level.var_8338fda95b87916d ) )
    {
        level.var_8338fda95b87916d = [];
    }
    
    level.var_8338fda95b87916d = arraycombineunique( level.var_8338fda95b87916d, [ func_override_rarity ] );
}

// Namespace magicbox
// Params 2
// Checksum 0xe13391c1, Offset: 0x70ce
// Size: 0xb5
function get_override_rarity( player, str_notify )
{
    if ( isplayer( player ) && isdefined( level.var_8338fda95b87916d ) )
    {
        foreach ( func in level.var_8338fda95b87916d )
        {
            str_override_rarity = [[ func ]]( player, str_notify );
            
            if ( isdefined( str_override_rarity ) )
            {
                return str_override_rarity;
            }
        }
    }
}

// Namespace magicbox
// Params 1, eflags: 0x4
// Checksum 0x347df570, Offset: 0x718c
// Size: 0x1e7, Type: bool
function private function_a8d6931ced6667c5( var_9ff2f93ccbf71b93 )
{
    str_base_weapon = var_9ff2f93ccbf71b93.baseweapon;
    var_3df86f0b126863ab = arraycombineunique( self.primaryweapons, [ self.var_cc1262e66dbb1c79 ] );
    
    if ( isdefined( str_base_weapon ) && isdefined( var_3df86f0b126863ab ) )
    {
        var_3df86f0b126863ab = function_5713d46873b29625( var_3df86f0b126863ab );
        
        foreach ( weapon in var_3df86f0b126863ab )
        {
            if ( weapon.basename == str_base_weapon )
            {
                println( self.name + "<dev string:x931>" + str_base_weapon + "<dev string:x93f>" );
                return true;
            }
        }
    }
    
    str_killstreak_ref = var_9ff2f93ccbf71b93.ref;
    
    if ( isdefined( self.streakdata.streaks ) && isdefined( str_killstreak_ref ) )
    {
        foreach ( var_2fa9bf23dc9edaaa in self.streakdata.streaks )
        {
            if ( var_2fa9bf23dc9edaaa.streakname == str_killstreak_ref && var_2fa9bf23dc9edaaa.available > 0 )
            {
                println( self.name + "<dev string:x931>" + str_killstreak_ref + "<dev string:x93f>" );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace magicbox
// Params 0
// Checksum 0xec3507c1, Offset: 0x737c
// Size: 0xf1
function function_2b18f72d8724f38e()
{
    assert( isarray( level.var_3d89727cba6243b2 ) && level.var_3d89727cba6243b2.size, "<dev string:x954>" );
    range = randomfloat( 1 );
    range *= 100;
    var_18a7d675cf5e66d1 = 0;
    var_9834eb8d90575937 = "pistol";
    
    foreach ( var_94cb598dd1dd3995, var_a58b9f66285b1c55 in level.var_3d89727cba6243b2 )
    {
        if ( !isdefined( var_a58b9f66285b1c55 ) )
        {
            continue;
        }
        
        if ( range >= var_18a7d675cf5e66d1 && range < var_a58b9f66285b1c55 )
        {
            var_9834eb8d90575937 = var_94cb598dd1dd3995;
            break;
        }
        
        var_18a7d675cf5e66d1 = var_a58b9f66285b1c55;
    }
    
    return var_9834eb8d90575937;
}

// Namespace magicbox
// Params 1
// Checksum 0x62a52974, Offset: 0x7476
// Size: 0x6f
function function_b579011beb3effa( player )
{
    var_8321d1a1ff7070d7 = 5;
    
    if ( isplayer( player ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_fc6574ba8b7263fc" ) )
        {
            augment_time = player utility::callsharedfunc( #"zombie", #"hash_fc6574ba8b7263fc" );
            
            if ( augment_time > 0 )
            {
                var_8321d1a1ff7070d7 = augment_time;
            }
        }
    }
    
    return var_8321d1a1ff7070d7;
}

// Namespace magicbox
// Params 3
// Checksum 0xa541092f, Offset: 0x74ee
// Size: 0x2354
function do_weapon_roulette( str_override_rarity, var_b674a7b202792f5a, var_4b076b5c2a1741db = 0 )
{
    if ( !isdefined( self.mdl_magicbox ) )
    {
        cleanup_and_close_magicbox();
        return;
    }
    
    self.mdl_magicbox endon( #"death", #"abort_magicbox" );
    self.mdl_magicbox.interact setusableenabled( 0 );
    utility::ent_flag_set( "magicbox_weapon_roulette_active" );
    setup_magicbox_weapon_array( str_override_rarity, undefined, var_4b076b5c2a1741db );
    
    if ( !isdefined( self.var_182083fc5337ebe9 ) )
    {
        cleanup_and_close_magicbox();
        return;
    }
    
    if ( isarray( self.var_ea6ac752e9068235 ) )
    {
        foreach ( mdl_weapon_streaming in self.var_ea6ac752e9068235 )
        {
            mdl_weapon_streaming delete();
        }
    }
    
    self.var_ea6ac752e9068235 = [];
    
    if ( getdvarint( @"hash_15769349af1d0398", 0 ) )
    {
        foreach ( var_2e08e94c9cb1747c in self.a_weapon_roulette )
        {
            if ( getdvarint( @"hash_fc74f94143cf660f", 1 ) && isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ].weapon ) )
            {
                mdl_weapon_streaming = function_2535619d314c1099( level.weaponmetadata[ var_2e08e94c9cb1747c ].weapon, self.mdl_magicbox.origin - ( 0, 0, 30 ), self.mdl_magicbox.angles );
            }
            else
            {
                str_weapon_model = level.var_c94175b5e96b794c[ var_2e08e94c9cb1747c ];
                mdl_weapon_streaming = utility::spawn_model( str_weapon_model, self.mdl_magicbox.origin - ( 0, 0, 30 ), self.mdl_magicbox.angles );
            }
            
            self.var_ea6ac752e9068235[ self.var_ea6ac752e9068235.size ] = mdl_weapon_streaming;
            level.var_3c501ff44580327b[ level.var_3c501ff44580327b.size ] = mdl_weapon_streaming;
            mdl_weapon_streaming val::set( "magicbox", "hide", 2 );
            
            if ( self.var_ea6ac752e9068235.size >= getdvarint( @"hash_8759e9b15d47e22f", 7 ) || level.var_3c501ff44580327b.size >= 20 )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    var_8321d1a1ff7070d7 = function_b579011beb3effa( self.var_37f3a4cd8252c9f0 );
    var_b99279a1bddf9524 = should_move_magicbox( var_b674a7b202792f5a );
    rolledweapon = !self.rolled_scorestreak && !self.rolled_aether_tool && !self.var_5875ea9ebe2e7c9d && !self.rolled_equipment;
    
    if ( !var_b99279a1bddf9524 )
    {
        var_9ff2f93ccbf71b93 = getscriptbundle( self.var_182083fc5337ebe9 );
        baseweaponname = var_9ff2f93ccbf71b93.baseweapon;
        
        if ( !isdefined( var_9ff2f93ccbf71b93 ) )
        {
            assertmsg( "<dev string:x90d>" + getxhashsourcename( self.var_182083fc5337ebe9 ) + "<dev string:x913>" );
            cleanup_and_close_magicbox();
            return;
        }
        
        if ( rolledweapon )
        {
            var_6828becb300b1c44 = item_weapon::function_e3101668a21a4237( var_9ff2f93ccbf71b93 );
            weaponobj = weapon::buildweapon( baseweaponname, var_6828becb300b1c44.attachments );
            var_6fd7a3ca641e77b1 = weaponobj;
        }
    }
    
    var_de26986d7ecdd895 = gettime() + utility::function_4b74c15943231980( var_8321d1a1ff7070d7 );
    n_next_item_index = 0;
    var_a4b2e7cf8623bff = undefined;
    var_cc1a2354ace4eab3 = function_72f7be2f9191b13d( "magicboxWeaponStartOffset", self.script_parameters );
    var_be0848b45dd204d0 = function_72f7be2f9191b13d( "magicboxWeaponEndOffset", self.script_parameters );
    v_start_offset = ( getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_cc1a2354ace4eab3 ).x ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_cc1a2354ace4eab3 ).y ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_cc1a2354ace4eab3 ).z ?? 0 );
    axis = anglestoaxis( self.mdl_magicbox.angles );
    var_bdb63efefa0eb00c = axis[ "forward" ] * v_start_offset[ 0 ] + axis[ "right" ] * v_start_offset[ 1 ] + axis[ "up" ] * v_start_offset[ 2 ];
    v_start_offset = var_bdb63efefa0eb00c;
    v_end_offset = ( getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_be0848b45dd204d0 ).x ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_be0848b45dd204d0 ).y ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), var_be0848b45dd204d0 ).z ?? 0 );
    var_1dcb8b9255e58707 = axis[ "forward" ] * v_end_offset[ 0 ] + axis[ "right" ] * v_end_offset[ 1 ] + axis[ "up" ] * v_end_offset[ 2 ];
    v_end_offset = var_1dcb8b9255e58707;
    var_b84da611d185462 = self.mdl_magicbox.origin + v_end_offset;
    self.v_start_weapon_position = self.mdl_magicbox.origin + v_start_offset;
    self.var_b84da611d185462 = var_b84da611d185462;
    var_fcdf9753dee3cca1 = 1;
    
    if ( isweapon( var_6fd7a3ca641e77b1 ) && isplayer( self.var_37f3a4cd8252c9f0 ) )
    {
        var_6fd7a3ca641e77b1 = self.var_37f3a4cd8252c9f0 weapon_utility::function_82abd5dde633d1a3( var_6fd7a3ca641e77b1 );
    }
    
    if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
    {
        favoriteweapon = self.var_37f3a4cd8252c9f0 weaponmetadata::function_c68204eff69ed046( baseweaponname );
    }
    
    if ( isdefined( favoriteweapon ) )
    {
        var_6fd7a3ca641e77b1 = favoriteweapon;
    }
    
    if ( isdefined( self.var_aa671b7b1bcaf7e2 ) )
    {
        self.var_aa671b7b1bcaf7e2 delete();
    }
    
    if ( var_b99279a1bddf9524 )
    {
        self.str_weapon_model = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxjokermodel" );
        self.var_aa671b7b1bcaf7e2 = utility::spawn_model( self.str_weapon_model, var_b84da611d185462, combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) ) );
        thread function_3425cf4eea5c969d( self.var_aa671b7b1bcaf7e2, var_8321d1a1ff7070d7 + 1 );
    }
    else if ( rolledweapon && isdefined( var_6fd7a3ca641e77b1 ) )
    {
        self.var_aa671b7b1bcaf7e2 = function_2535619d314c1099( var_6fd7a3ca641e77b1, var_b84da611d185462, combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) ) );
        a_players = getplayersinradius( self.mdl_magicbox.origin, 700 );
        
        foreach ( player in a_players )
        {
            player loadweaponsforplayer( [ var_6fd7a3ca641e77b1 ], 1 );
        }
    }
    else if ( isdefined( var_9ff2f93ccbf71b93.worldmodel ) )
    {
        self.var_aa671b7b1bcaf7e2 = content_manager::spawn_script_model( self, var_9ff2f93ccbf71b93.worldmodel, undefined, undefined, var_b84da611d185462 );
        self.var_aa671b7b1bcaf7e2.angles = combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) );
        thread function_3425cf4eea5c969d( self.var_aa671b7b1bcaf7e2, var_8321d1a1ff7070d7 + 1 );
    }
    
    if ( isdefined( self.var_aa671b7b1bcaf7e2 ) )
    {
        if ( !getdvarint( @"hash_e05ca0e43b13123a", 0 ) )
        {
            self.var_aa671b7b1bcaf7e2 val::set( "magicbox", "hide", 2 );
        }
    }
    
    self.mdl_magicbox utility::function_7c10ea82c1e305b8( "base", "opening" );
    
    if ( self.var_b84da611d185462[ 2 ] > self.mdl_magicbox.origin[ 2 ] && self.var_b84da611d185462[ 2 ] - self.mdl_magicbox.origin[ 2 ] > 16 )
    {
        wait 0.4;
    }
    
    if ( self.b_is_moving && var_b674a7b202792f5a )
    {
        self notify( #"stop_moving" );
        self.b_is_moving = undefined;
        
        if ( isent( self.mdl_current_weapon ) )
        {
            self.mdl_current_weapon.angles = combineangles( self.mdl_current_weapon.angles, ( 0, 90, 0 ) );
        }
    }
    
    var_91ede7bc3f76b886 = get_magicbox_bundle().var_2628813231c4ee4a;
    var_d7ec9bd245ceb261 = get_magicbox_bundle().var_8ebeb5ca5c56fcf3;
    
    while ( true )
    {
        if ( gettime() >= var_de26986d7ecdd895 )
        {
            break;
        }
        
        self.var_2e08e94c9cb1747c = self.a_weapon_roulette[ n_next_item_index ];
        str_weapon_model = level.var_c94175b5e96b794c[ self.var_2e08e94c9cb1747c ];
        
        if ( !isdefined( var_a4b2e7cf8623bff ) )
        {
            var_a4b2e7cf8623bff = distance( self.v_start_weapon_position, self.var_b84da611d185462 ) / var_8321d1a1ff7070d7 * 0.2 + 0.2;
        }
        
        if ( getdvarint( @"hash_fc74f94143cf660f", 1 ) )
        {
            if ( isdefined( level.weaponmetadata[ self.var_2e08e94c9cb1747c ].weapon ) && !var_d7ec9bd245ceb261 )
            {
                preview_weapon = level.weaponmetadata[ self.var_2e08e94c9cb1747c ].weapon;
                
                if ( var_91ede7bc3f76b886 )
                {
                    str_rarity_outline = get_rarity_outline( randomintrange( 1, 5 ) );
                }
            }
            else
            {
                for ( retries = 0; retries < 5 ; retries++ )
                {
                    n_round = utility::callsharedfunc( #"game", #"roundNumberDifficulty", self.mdl_magicbox.origin ) ?? 1;
                    
                    foreach ( s_magicbox_scaling in level.s_magicbox_scaling.var_e706c54ff9d8cadc )
                    {
                        if ( n_round >= s_magicbox_scaling.minround && n_round <= s_magicbox_scaling.maxround )
                        {
                            var_1b7fa257606784cd = s_magicbox_scaling.supportchance ?? 0;
                            var_accb0970f3090a78 = s_magicbox_scaling.equipmentchance ?? 0;
                            var_886ee5372abc2bc2 = s_magicbox_scaling.ultrachance ?? 0;
                            n_uncommon_chance = s_magicbox_scaling.uncommonchance ?? 0;
                            n_rare_chance = s_magicbox_scaling.rarechance ?? 0;
                            n_epic_chance = s_magicbox_scaling.epicchance ?? 0;
                            n_legendary_chance = s_magicbox_scaling.legendarychance ?? 0;
                            break;
                        }
                    }
                    
                    if ( !isdefined( var_1b7fa257606784cd ) )
                    {
                        var_1b7fa257606784cd = 0;
                    }
                    
                    if ( !isdefined( var_accb0970f3090a78 ) )
                    {
                        var_accb0970f3090a78 = 0;
                    }
                    
                    if ( !isdefined( var_886ee5372abc2bc2 ) )
                    {
                        var_886ee5372abc2bc2 = 0;
                    }
                    
                    if ( !isdefined( n_uncommon_chance ) )
                    {
                        n_uncommon_chance = 0;
                    }
                    
                    if ( !isdefined( n_rare_chance ) )
                    {
                        n_rare_chance = 0;
                    }
                    
                    if ( !isdefined( n_epic_chance ) )
                    {
                        n_epic_chance = 0;
                    }
                    
                    if ( !isdefined( n_legendary_chance ) )
                    {
                        n_legendary_chance = 0;
                    }
                    
                    if ( isdefined( level.var_278a6b84a3269b8c ) && utility::percent_chance( var_1b7fa257606784cd ) )
                    {
                        var_534386bc6715e72f = level.var_278a6b84a3269b8c;
                        var_687ff8dfe2fe8fd2 = 0;
                    }
                    else if ( isdefined( level.var_b29a644f57572450 ) && utility::percent_chance( var_accb0970f3090a78 ) )
                    {
                        var_534386bc6715e72f = level.var_b29a644f57572450;
                        var_687ff8dfe2fe8fd2 = 0;
                    }
                    else if ( isdefined( level.var_8b6bf63f61fe01f9 ) && utility::percent_chance( var_886ee5372abc2bc2 ) && ( !level.var_641b7c91f663ea4f || level.var_104dd1bc9d142921 ) )
                    {
                        var_534386bc6715e72f = level.var_8b6bf63f61fe01f9;
                        
                        if ( level.var_20cf5eda0c956d52 )
                        {
                            var_534386bc6715e72f = level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist ?? "zm_t10_items_magicbox_weapon_wonder_list";
                        }
                        
                        var_687ff8dfe2fe8fd2 = 0;
                    }
                    else
                    {
                        var_534386bc6715e72f = level.var_54989577c4e434aa;
                        var_687ff8dfe2fe8fd2 = 1;
                    }
                    
                    var_dde9f7339b675f = common_item::items_selectfromlist( var_534386bc6715e72f, 1 );
                    
                    if ( self.var_14e66f219c904d50 != var_dde9f7339b675f[ 0 ] )
                    {
                        self.var_14e66f219c904d50 = var_dde9f7339b675f[ 0 ];
                        break;
                    }
                }
                
                if ( isdefined( self.var_14e66f219c904d50 ) )
                {
                    if ( level.gametypebundle.var_b12d13411c09d7a5 || !var_687ff8dfe2fe8fd2 )
                    {
                        var_a48d20e5c8ea9325 = "";
                    }
                    else if ( utility::percent_chance( n_legendary_chance ) )
                    {
                        var_a48d20e5c8ea9325 = "_orange";
                    }
                    else if ( utility::percent_chance( n_epic_chance ) )
                    {
                        var_a48d20e5c8ea9325 = "_purple";
                    }
                    else if ( utility::percent_chance( n_rare_chance ) )
                    {
                        var_a48d20e5c8ea9325 = "_blue";
                    }
                    else
                    {
                        var_a48d20e5c8ea9325 = "_green";
                    }
                    
                    str_item_preview = hashcat( self.var_14e66f219c904d50, var_a48d20e5c8ea9325 );
                    itembundle = getscriptbundle( str_item_preview );
                    
                    if ( !isdefined( itembundle ) )
                    {
                        itembundle = getscriptbundle( self.var_14e66f219c904d50 );
                        
                        if ( !isdefined( itembundle ) )
                        {
                            wait 0.2;
                            continue;
                        }
                    }
                    
                    if ( isdefined( itembundle.baseweapon ) )
                    {
                        preview_weapon = item_weapon::function_477bf1207c6672a5( itembundle );
                        var_8c073e2533917705 = 0;
                    }
                    else
                    {
                        preview_weapon = itembundle.worldmodel;
                        var_d38492f7a904ec67 = itembundle.scriptable;
                        var_8c073e2533917705 = 1;
                    }
                    
                    if ( var_91ede7bc3f76b886 )
                    {
                        str_rarity_outline = get_rarity_outline( itembundle.rarity );
                    }
                }
            }
            
            if ( isdefined( self.mdl_current_weapon.n_outline_id ) )
            {
                outline::outlinedisable( self.mdl_current_weapon.n_outline_id, self.mdl_current_weapon );
                self.mdl_current_weapon.n_outline_id = undefined;
            }
            
            var_e45619251daac78e = function_867f63c990ceb381( itembundle.ref );
            var_d1f47820ce3cbf47 = function_7f3e570ed34d0320( itembundle.ref );
            
            if ( isdefined( self.mdl_current_weapon ) )
            {
                v_origin = self.mdl_current_weapon.origin + var_d1f47820ce3cbf47;
                v_angles = combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) ) + var_e45619251daac78e;
                self.mdl_current_weapon delete();
            }
            else
            {
                v_origin = self.v_start_weapon_position + var_d1f47820ce3cbf47;
                v_angles = combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) ) + var_e45619251daac78e;
            }
            
            if ( !isdefined( preview_weapon ) )
            {
                preview_weapon = "none";
            }
            
            if ( var_8c073e2533917705 )
            {
                if ( isdefined( var_d38492f7a904ec67 ) )
                {
                    self.mdl_current_weapon = utility::spawn_model( "tag_origin", v_origin, v_angles );
                    self.preview_item_scriptable = spawnscriptable( var_d38492f7a904ec67, v_origin, v_angles );
                    self.preview_item_scriptable function_7653c765b6c7b815();
                    self.preview_item_scriptable utility::scriptable_setparententity( self.mdl_current_weapon );
                }
                else
                {
                    self.mdl_current_weapon = utility::spawn_model( preview_weapon, v_origin, v_angles );
                }
            }
            else
            {
                self.mdl_current_weapon = function_2535619d314c1099( preview_weapon, v_origin, v_angles );
            }
            
            if ( isdefined( str_rarity_outline ) )
            {
                self.mdl_current_weapon.n_outline_id = outline::outlineenableforall( self.mdl_current_weapon, str_rarity_outline, "level_script" );
            }
            
            vector_to_target = self.var_b84da611d185462 - v_origin;
            normal_vector = vectornormalize( vector_to_target );
            move_vector = var_a4b2e7cf8623bff * normal_vector;
            move_to_point = v_origin + move_vector;
            self.mdl_current_weapon moveto( move_to_point, 0.2 );
        }
        else if ( isdefined( self.mdl_current_weapon ) )
        {
            v_origin = self.mdl_current_weapon.origin;
            v_angles = self.mdl_current_weapon.angles;
            self.mdl_current_weapon setmodel( str_weapon_model );
        }
        else
        {
            v_origin = self.v_start_weapon_position;
            v_angles = combineangles( self.mdl_magicbox.angles, ( 0, 180, 0 ) );
            self.mdl_current_weapon = content_manager::spawn_script_model( self, str_weapon_model, undefined, undefined, v_origin );
            self.mdl_current_weapon.angles = v_angles;
            vector_to_target = self.var_b84da611d185462 - self.mdl_current_weapon.origin;
            normal_vector = vectornormalize( vector_to_target );
            move_vector = var_a4b2e7cf8623bff * normal_vector;
            move_to_point = self.mdl_current_weapon.origin + move_vector;
            self.mdl_current_weapon moveto( move_to_point, 0.2 );
        }
        
        n_next_item_index = ( n_next_item_index + 1 ) % self.a_weapon_roulette.size;
        wait 0.2;
        
        if ( isdefined( self.preview_item_scriptable ) )
        {
            self.preview_item_scriptable freescriptable();
        }
    }
    
    self.mdl_current_weapon notify( #"hash_b531fe0c6bb1cee1" );
    self.mdl_current_weapon.origin = self.var_b84da611d185462;
    
    foreach ( mdl_weapon_streaming in self.var_ea6ac752e9068235 )
    {
        mdl_weapon_streaming delete();
    }
    
    level.var_3c501ff44580327b = function_5713d46873b29625( level.var_3c501ff44580327b );
    self.var_ea6ac752e9068235 = undefined;
    
    if ( utility::flag( "powerup_fire_sale_active" ) && var_b99279a1bddf9524 )
    {
        var_b99279a1bddf9524 = 0;
        
        if ( !isdefined( baseweaponname ) )
        {
            var_9ff2f93ccbf71b93 = getscriptbundle( self.var_182083fc5337ebe9 );
            baseweaponname = var_9ff2f93ccbf71b93.baseweapon;
            var_6828becb300b1c44 = item_weapon::function_e3101668a21a4237( var_9ff2f93ccbf71b93 );
            
            if ( rolledweapon )
            {
                if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
                {
                    favoriteweapon = self.var_37f3a4cd8252c9f0 weaponmetadata::function_c68204eff69ed046( baseweaponname );
                }
                
                if ( isdefined( favoriteweapon ) )
                {
                    var_6fd7a3ca641e77b1 = favoriteweapon;
                }
                else
                {
                    var_6fd7a3ca641e77b1 = weapon::buildweapon( baseweaponname, var_6828becb300b1c44.attachments );
                }
            }
        }
    }
    
    level callback::callback( "magicbox_weapon_roulette_ended", { #magicbox:self } );
    
    if ( var_b99279a1bddf9524 )
    {
        self.str_weapon_model = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxjokermodel" );
        var_98bed63d542dcd0a = ( getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffset" ).x ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffset" ).y ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffset" ).z ?? 0 );
        axis = anglestoaxis( self.mdl_current_weapon.angles );
        var_d744f1c2566061e5 = axis[ "forward" ] * var_98bed63d542dcd0a[ 0 ] + axis[ "right" ] * var_98bed63d542dcd0a[ 1 ] + axis[ "up" ] * var_98bed63d542dcd0a[ 2 ];
        var_98bed63d542dcd0a = var_d744f1c2566061e5;
        var_e70fb826a625c90f = ( getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffsetAngles" ).x ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffsetAngles" ).y ?? 0, getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicboxJokerOffsetAngles" ).z ?? 0 );
        thread function_3425cf4eea5c969d( self.str_weapon_model );
        
        if ( getdvarint( @"hash_fc74f94143cf660f", 1 ) )
        {
            v_origin = self.mdl_current_weapon.origin + var_98bed63d542dcd0a;
            v_angles = self.mdl_current_weapon.angles;
            self.mdl_current_weapon delete();
            self.mdl_current_weapon = utility::spawn_model( self.str_weapon_model, v_origin, v_angles );
        }
        else
        {
            self.mdl_current_weapon setmodel( self.str_weapon_model );
        }
        
        level.peeks = self.mdl_current_weapon;
        params = spawnstruct();
        params.peeks = self.mdl_current_weapon;
        params.var_349a0723ed9ac19c = self;
        self.var_37f3a4cd8252c9f0 callback::callback( "mrp_appeared", params );
        self.mdl_current_weapon dontinterpolate();
        
        if ( self.var_dc41a51effa51e7f )
        {
            self.mdl_current_weapon.angles = combineangles( self.mdl_magicbox.angles, self.var_dc41a51effa51e7f );
        }
        else
        {
            self.mdl_current_weapon.angles = combineangles( self.mdl_current_weapon.angles, ( 0, -90, 0 ) + var_e70fb826a625c90f );
        }
        
        self.b_is_moving = 1;
        level.var_410b736ba41817c2 = 0;
        self.var_410b736ba41817c2 = 0;
        level.var_70c5979783790e1b = undefined;
        
        if ( isplayer( self.var_37f3a4cd8252c9f0 ) && getdvarint( @"hash_f11373f0685d1fa4", 1 ) )
        {
            refund_player();
        }
        
        function_2113ca9f2de90480( "moved" );
        utility::ent_flag_clear( "magicbox_weapon_roulette_active" );
        function_69dbb1d398532e24();
        return;
    }
    
    if ( rolledweapon )
    {
        if ( !isdefined( var_6fd7a3ca641e77b1 ) )
        {
            var_9ff2f93ccbf71b93 = getscriptbundle( self.var_182083fc5337ebe9 );
            baseweaponname = var_9ff2f93ccbf71b93.baseweapon;
            var_6828becb300b1c44 = item_weapon::function_e3101668a21a4237( var_9ff2f93ccbf71b93 );
            var_6fd7a3ca641e77b1 = weapon::buildweapon( baseweaponname, var_6828becb300b1c44.attachments );
            
            if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
            {
                favoriteweapon = self.var_37f3a4cd8252c9f0 weaponmetadata::function_c68204eff69ed046( baseweaponname );
            }
            
            if ( isdefined( favoriteweapon ) )
            {
                var_6fd7a3ca641e77b1 = favoriteweapon;
            }
        }
    }
    else
    {
        v_origin = self.mdl_current_weapon.origin;
        v_angles = self.mdl_current_weapon.angles;
        self.mdl_current_weapon delete();
        self.mdl_current_weapon = content_manager::spawn_script_model( self, var_9ff2f93ccbf71b93.worldmodel, undefined, undefined, v_origin );
        self.mdl_current_weapon.origin = v_origin;
        self.mdl_current_weapon.angles = v_angles;
        
        if ( self.var_1d277c93fff5ec4d )
        {
            self.str_weapon_rarity = function_c19ee905418ebc92( var_9ff2f93ccbf71b93 );
        }
    }
    
    if ( self.var_dc41a51effa51e7f )
    {
        self.mdl_current_weapon.angles = combineangles( self.mdl_magicbox.angles, self.var_dc41a51effa51e7f );
    }
    else if ( isdefined( var_9ff2f93ccbf71b93.ref ) )
    {
        angleoffset = function_867f63c990ceb381( var_9ff2f93ccbf71b93.ref );
        originoffset = function_7f3e570ed34d0320( var_9ff2f93ccbf71b93.ref );
        self.mdl_current_weapon.angles = combineangles( self.mdl_current_weapon.angles, angleoffset );
        self.mdl_current_weapon.origin += originoffset;
    }
    
    if ( self.var_37f3a4cd8252c9f0.var_d6157e607ef0ac64 )
    {
        self.var_37f3a4cd8252c9f0 utility::waittill_any_timeout( 5, "weapon_carousel_finished" );
    }
    
    if ( getdvarint( @"hash_6965cd369482e004", 1 ) )
    {
        v_origin = self.mdl_current_weapon.origin;
        v_angles = self.mdl_current_weapon.angles;
        self.mdl_current_weapon delete();
        self.mdl_current_weapon = utility::spawn_model( "tag_origin", v_origin, v_angles );
        spawnoptions = common_item::function_bc5ff2958b71a708( self.mdl_current_weapon.origin, self.mdl_current_weapon.angles );
        spawnoptions.var_f35b5b18b029c493 = 0;
        spawnoptions.weapon = var_6fd7a3ca641e77b1;
        
        if ( isweapon( spawnoptions.weapon ) && isplayer( self.var_37f3a4cd8252c9f0 ) )
        {
            spawnoptions.weapon = self.var_37f3a4cd8252c9f0 weapon_utility::function_82abd5dde633d1a3( spawnoptions.weapon );
        }
        
        if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
        {
            favoriteweapon = self.var_37f3a4cd8252c9f0 weaponmetadata::function_c68204eff69ed046( baseweaponname );
        }
        
        if ( isdefined( favoriteweapon ) )
        {
            spawnoptions.weapon = favoriteweapon;
        }
        
        if ( !getdvarint( @"hash_a5e93f4b8f0b42a1", 1 ) )
        {
            spawnoptions.weapon = undefined;
        }
        
        item = common_item::function_61c2c0251e742ffd( var_9ff2f93ccbf71b93, undefined, spawnoptions );
        
        if ( isplayer( self.var_37f3a4cd8252c9f0 ) && isweapon( item.weaponobj ) )
        {
            self.var_37f3a4cd8252c9f0 loadweaponsforplayer( [ item.weaponobj ], 1 );
        }
        
        if ( !isdefined( item ) )
        {
            assertmsg( "<dev string:x9a6>" + ( var_9ff2f93ccbf71b93.ref ?? "<dev string:x9b9>" ) + "<dev string:x9c3>" );
            cleanup_and_close_magicbox();
            return;
        }
        
        item.disable = 1;
        item.loot_source = "magicbox";
        item utility::scriptable_clearparententity();
        item utility::scriptable_setparententity( self.mdl_current_weapon );
        item utility::function_7c10ea82c1e305b8( item.type, #"mystery_box_interact" );
        self.mdl_current_weapon.item = item;
        item.disable = undefined;
    }
    else
    {
        self.mdl_current_weapon show();
    }
    
    self.mdl_current_weapon.var_349a0723ed9ac19c = self;
    self.mdl_current_weapon.var_9ff2f93ccbf71b93 = var_9ff2f93ccbf71b93;
    self.mdl_current_weapon.var_2e08e94c9cb1747c = var_9ff2f93ccbf71b93.baseweapon;
    
    if ( !isdefined( self.mdl_current_weapon.var_2e08e94c9cb1747c ) )
    {
        self.mdl_current_weapon.var_2e08e94c9cb1747c = var_9ff2f93ccbf71b93.fullweaponname ?? var_9ff2f93ccbf71b93.ref;
    }
    
    self.mdl_current_weapon.rolled_scorestreak = self.rolled_scorestreak;
    self.mdl_current_weapon.rolled_wonder = self.rolled_wonder;
    self.mdl_current_weapon.rolled_aether_tool = self.rolled_aether_tool;
    self.mdl_current_weapon.var_5875ea9ebe2e7c9d = self.var_5875ea9ebe2e7c9d;
    self.mdl_current_weapon.var_c472ba9c1811f8cf = self.var_c472ba9c1811f8cf;
    self.mdl_current_weapon.str_weapon_rarity = self.str_weapon_rarity ?? "none";
    logstring( "====Magic Box Rarity and Weapon: " + self.mdl_current_weapon.str_weapon_rarity + " " + self.mdl_current_weapon.var_2e08e94c9cb1747c + " for " + ( self.var_37f3a4cd8252c9f0.name ?? "<disconnected>" ) );
    
    if ( self.var_37f3a4cd8252c9f0.var_d6157e607ef0ac64 )
    {
        self.var_37f3a4cd8252c9f0 utility::waittill_any_timeout( 5, "weapon_carousel_finished" );
    }
    
    if ( getdvarint( @"hash_6965cd369482e004", 1 ) )
    {
        self.mdl_current_weapon.interact = interaction::register_scriptable_interact( self.mdl_current_weapon.item, &function_4494528bb919d011 );
        self.mdl_current_weapon.interact interaction::function_c20d98995f855f91();
        self.mdl_current_weapon.interact interaction::function_3d5329c553924b3();
        self.mdl_current_weapon notsolid();
    }
    else
    {
        str_weapon_name_loc = get_weapon_hint_string( self.mdl_current_weapon.var_2e08e94c9cb1747c, var_9ff2f93ccbf71b93 );
        str_rarity_hint = get_rarity_hint_string( self.mdl_current_weapon.str_weapon_rarity );
        self.mdl_current_weapon.str_weapon_model = var_9ff2f93ccbf71b93.worldmodel ?? "tag_origin";
        self.mdl_current_weapon setmodel( self.mdl_current_weapon.str_weapon_model );
        str_rarity_outline = get_rarity_outline( self.mdl_current_weapon.str_weapon_rarity );
        self.mdl_current_weapon.n_outline_id = outline::outlineenableforall( self.mdl_current_weapon, str_rarity_outline, "level_script" );
        self.mdl_current_weapon.interact = interaction::register_interact( self.mdl_current_weapon.origin, 64, &function_f289ba80c654e2e1, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
        self.mdl_current_weapon.interact interaction::set_interact_hint_callback( &function_cda75531450aac03 );
        self.mdl_current_weapon.interact interaction::function_3d5329c553924b3();
        self.mdl_current_weapon.interact setusefov( 80 );
        self.mdl_current_weapon notsolid();
    }
    
    self.mdl_current_weapon.cost = self.script_cost ?? 950;
    self.mdl_magicbox function_59fb358a01aea2b6( self.mdl_current_weapon.str_weapon_rarity );
    
    if ( isplayer( self.var_37f3a4cd8252c9f0 ) )
    {
        if ( self.var_37f3a4cd8252c9f0.var_d6157e607ef0ac64 )
        {
            self.var_37f3a4cd8252c9f0 utility::waittill_any_timeout( 5, "weapon_carousel_finished" );
        }
        
        if ( getdvarint( @"hash_6965cd369482e004", 1 ) )
        {
            foreach ( player in level.players )
            {
                self.mdl_current_weapon.interact disablescriptableplayeruse( player );
            }
            
            if ( self.var_37f3a4cd8252c9f0.var_432159241a2f9367 )
            {
                refund_player();
            }
            else if ( level.var_8a032a823f2ea506 )
            {
                foreach ( player in level.players )
                {
                    self.mdl_current_weapon.interact thread function_f640f9d8e34585c7( 0.2, player );
                }
            }
            else
            {
                self.mdl_current_weapon.interact thread function_f640f9d8e34585c7( 0.2, self.var_37f3a4cd8252c9f0 );
            }
        }
        else if ( level.var_8a032a823f2ea506 )
        {
            self.mdl_current_weapon.interact enableplayeruseforallplayers();
        }
        else
        {
            self.mdl_current_weapon.interact disableplayeruseforallplayers();
            self.mdl_current_weapon.interact enableplayeruse( self.var_37f3a4cd8252c9f0 );
        }
    }
    
    itemid = common_item::items_getlootidfromref( var_9ff2f93ccbf71b93.ref );
    params = spawnstruct();
    params.itembundle = var_9ff2f93ccbf71b93;
    params.lootid = itemid;
    params.cost = self.cost ?? 950;
    params.currency = level.magicbox_currency_type;
    params.var_4e0aa9a7c35d4dce = self.mdl_current_weapon.rolled_scorestreak;
    params.var_15823e486f78cb79 = self.mdl_current_weapon.var_c472ba9c1811f8cf;
    self.var_37f3a4cd8252c9f0 callback::callback( "magicbox_item_revealed", params );
    self.mdl_current_weapon.interact.mdl_current_weapon = self.mdl_current_weapon;
    str_return_type = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "returnType" );
    
    if ( str_return_type == "StartPosition" )
    {
        v_moveto_position = self.v_start_weapon_position;
    }
    else
    {
        v_moveto_position = self.mdl_current_weapon.origin;
    }
    
    self.mdl_current_weapon moveto( v_moveto_position, 12, 6 );
    self.mdl_current_weapon thread function_80fa7b4228afb948();
    str_notify = self.mdl_current_weapon.interact function_a2ee2e57e51b2596();
    
    if ( isdefined( self.var_aa671b7b1bcaf7e2 ) )
    {
        self.var_aa671b7b1bcaf7e2 utility::delaycall( 1, &delete );
    }
    
    result = [ "drop_magicbox_weapon":"dropped", "force_respin":"force_respin", "death":"picked_up", "picked_up_weapon":"picked_up", "timeout":"expired" ][ str_notify ] ?? "";
    function_2113ca9f2de90480( result, itemid, var_9ff2f93ccbf71b93.ref );
    cleanup_and_close_magicbox( str_notify );
}

// Namespace magicbox
// Params 2, eflags: 0x4
// Checksum 0xbf80227a, Offset: 0x984a
// Size: 0x4f
function private function_f640f9d8e34585c7( delay, var_4fa73f32f4513e1e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_4fa73f32f4513e1e endon( #"death_or_disconnect" );
    wait delay;
    
    if ( self && var_4fa73f32f4513e1e )
    {
        self enablescriptableplayeruse( var_4fa73f32f4513e1e );
    }
}

// Namespace magicbox
// Params 3, eflags: 0x4
// Checksum 0x7e32db5f, Offset: 0x98a1
// Size: 0x11a
function private function_2113ca9f2de90480( result, itemid, itemref )
{
    if ( !isplayer( self.var_37f3a4cd8252c9f0 ) )
    {
        return;
    }
    
    self.var_37f3a4cd8252c9f0 dlog_recordplayerevent( "dlog_event_magicbox_spin_done", [ "match_time_ms", gettime() ?? 0, "magicbox_x", self.mdl_magicbox.origin[ 0 ] ?? 0, "magicbox_y", self.mdl_magicbox.origin[ 1 ] ?? 0, "magicbox_z", self.mdl_magicbox.origin[ 2 ] ?? 0, "result", result ?? "", "item_id", itemid ?? 0, "item_ref", itemref ?? "" ] );
}

// Namespace magicbox
// Params 1
// Checksum 0x76ccb770, Offset: 0x99c3
// Size: 0x166
function cleanup_and_close_magicbox( str_notify )
{
    if ( isent( self.mdl_current_weapon.interact ) )
    {
        self.mdl_current_weapon.interact delete();
    }
    else if ( isdefined( self.mdl_current_weapon.interact ) && self.mdl_current_weapon.interact isscriptableinstance() )
    {
        self.mdl_current_weapon.interact notify( #"death" );
        self.mdl_current_weapon.interact freescriptable();
    }
    
    if ( isent( self.mdl_current_weapon ) )
    {
        self.mdl_current_weapon delete();
    }
    
    utility::ent_flag_clear( "magicbox_weapon_roulette_active" );
    
    if ( str_notify == "force_respin" )
    {
        if ( isdefined( self.mdl_magicbox ) )
        {
            self.mdl_magicbox setscriptablepartstate( "base", "closing" );
            self.mdl_magicbox.interact.var_349a0723ed9ac19c.var_4da360839b7baec4 = undefined;
        }
        
        str_override_rarity = get_override_rarity( self.var_37f3a4cd8252c9f0, str_notify );
        thread do_weapon_roulette( str_override_rarity, undefined, 1 );
        return;
    }
    
    self.mdl_magicbox function_433f50cee49f0757();
}

// Namespace magicbox
// Params 2, eflags: 0xc
// Checksum 0xb8761df, Offset: 0x9b31
// Size: 0x155
function private function_3425cf4eea5c969d( mdl_weapon_streaming, n_time = 5 )
{
    self notify( #"hash_cb65222dc09f023f" );
    self endon( #"hash_cb65222dc09f023f" );
    
    if ( !isdefined( mdl_weapon_streaming ) )
    {
        return;
    }
    
    if ( isent( mdl_weapon_streaming ) )
    {
        mdl_weapon_streaming val::set( "magicbox", "hide", 2 );
    }
    
    a_players = getplayersinradius( self.mdl_magicbox.origin, 700 );
    
    foreach ( player in a_players )
    {
        if ( isplayer( player ) )
        {
            if ( isent( mdl_weapon_streaming ) )
            {
                player utility::player_prestream_assets( "magicbox", "entity", mdl_weapon_streaming, 700, n_time );
                continue;
            }
            
            player utility::player_prestream_assets( "magicbox", "model", mdl_weapon_streaming, 700, n_time );
        }
    }
    
    utility::waittill_any_timeout( n_time, "magicbox_left", "magicbox_closed" );
    
    if ( isent( mdl_weapon_streaming ) )
    {
        mdl_weapon_streaming delete();
    }
}

// Namespace magicbox
// Params 2
// Checksum 0xb485dc4, Offset: 0x9c8e
// Size: 0x94
function get_weapon_hint_string( var_2e08e94c9cb1747c, item )
{
    str_weapon_name_loc = &"shared_hintstrings/default_weapon_wallbuy_name";
    
    if ( self.rolled_scorestreak && isdefined( item.titlestring ) )
    {
        str_weapon_name_loc = item.titlestring;
    }
    else if ( isdefined( item.descstring ) )
    {
        str_weapon_name_loc = item.descstring;
    }
    else
    {
        weapon = makeweapon( var_2e08e94c9cb1747c );
        str_weapon_name_loc = weapon.displayname;
    }
    
    return str_weapon_name_loc;
}

// Namespace magicbox
// Params 1
// Checksum 0x18c524f5, Offset: 0x9d2b
// Size: 0x30
function get_description_string( item )
{
    if ( isdefined( item.descstring ) )
    {
        return item.descstring;
    }
    
    return &"";
}

// Namespace magicbox
// Params 2
// Checksum 0xa597d6ab, Offset: 0x9d64
// Size: 0x1c8
function function_cda75531450aac03( usable, player )
{
    str_weapon_name_loc = usable.mdl_current_weapon get_weapon_hint_string( usable.mdl_current_weapon.var_2e08e94c9cb1747c, usable.mdl_current_weapon.var_9ff2f93ccbf71b93 );
    str_rarity_hint = usable.mdl_current_weapon get_rarity_hint_string( usable.mdl_current_weapon.str_weapon_rarity );
    
    if ( usable.mdl_current_weapon.rolled_scorestreak )
    {
        var_ed466fad37317edc = get_description_string( usable.mdl_current_weapon.var_9ff2f93ccbf71b93 );
        str_buttoncallout = &"SHARED_HINTSTRINGS/MAGICBOX_BUTTONCALLOUT_SCORESTREAK";
    }
    
    if ( equipment_mp::isequipmentlethal( usable.mdl_current_weapon.var_9ff2f93ccbf71b93.ref ) || equipment_mp::isequipmenttactical( usable.mdl_current_weapon.var_9ff2f93ccbf71b93.ref ) )
    {
        str_buttoncallout = &"SHARED_HINTSTRINGS/MAGICBOX_BUTTONCALLOUT_EQUIPMENT";
    }
    
    obj = { #icon:usable.mdl_current_weapon.var_9ff2f93ccbf71b93.icon, #description:var_ed466fad37317edc ?? str_rarity_hint, #title:str_weapon_name_loc, #buttoncallout:str_buttoncallout ?? &"SHARED_HINTSTRINGS/MAGICBOX_BUTTONCALLOUT_WEAPON", #params:[ str_weapon_name_loc ], #string:str_rarity_hint, #type:"HINT_BUTTON" };
    return obj;
}

// Namespace magicbox
// Params 2
// Checksum 0x5be97dc4, Offset: 0x9f35
// Size: 0xc7
function function_e034b4cbe8f5aed6( cost, var_349a0723ed9ac19c )
{
    if ( utility::flag( "powerup_fire_sale_active" ) && !utility::ent_flag( "powerup_fire_sale_active" ) )
    {
        cost = var_349a0723ed9ac19c.n_original_cost ?? 950;
    }
    
    if ( isdefined( self.perks[ "specialty_exfil_mystery_box_percent_reward" ] ) )
    {
        cost = int( cost * level.perkbundles[ "specialty_exfil_mystery_box_percent_reward" ].var_b3e0db53d1024142 );
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_f24224b472aa905" ) )
    {
        var_7389273e5a3ba72a = utility::callsharedfunc( #"zombie", #"hash_f24224b472aa905", var_349a0723ed9ac19c );
        cost = var_7389273e5a3ba72a ?? cost;
    }
    
    return cost;
}

// Namespace magicbox
// Params 1
// Checksum 0xe6ed1960, Offset: 0xa005
// Size: 0x1b1
function function_d6cb29bad3ee9a9( player )
{
    var_2967abb6e36c57ca = self;
    itembundle = var_2967abb6e36c57ca.mdl_current_weapon.var_9ff2f93ccbf71b93;
    var_349a0723ed9ac19c = var_2967abb6e36c57ca.mdl_current_weapon.var_349a0723ed9ac19c;
    var_2967abb6e36c57ca.var_f7d425332dfd14bc = function_535a73eae8edf8b7( player, var_2967abb6e36c57ca.mdl_current_weapon, var_349a0723ed9ac19c );
    var_2967abb6e36c57ca.var_f7d425332dfd14bc.var_90cdc5dbcd319e5d = 1;
    var_6a9e98623b59cbaf = common_item::function_61c2c0251e742ffd( itembundle, undefined, var_2967abb6e36c57ca.var_f7d425332dfd14bc );
    
    if ( isdefined( var_6a9e98623b59cbaf ) )
    {
        var_6a9e98623b59cbaf.var_328ae4e0cf700246 = 1;
        var_6a9e98623b59cbaf.itembundle = itembundle;
        var_6a9e98623b59cbaf.rolled_scorestreak = var_2967abb6e36c57ca.mdl_current_weapon.rolled_scorestreak;
        var_6a9e98623b59cbaf.var_c472ba9c1811f8cf = var_2967abb6e36c57ca.mdl_current_weapon.var_c472ba9c1811f8cf;
        var_6a9e98623b59cbaf.cost = var_2967abb6e36c57ca.mdl_current_weapon.cost;
        var_6a9e98623b59cbaf.var_349a0723ed9ac19c = var_349a0723ed9ac19c;
        var_6a9e98623b59cbaf thread common_item::items_scriptable_waitandcleanup( 30 );
        var_6a9e98623b59cbaf.interact = interaction::register_scriptable_interact( var_6a9e98623b59cbaf, &function_4494528bb919d011 );
        params = { #itembundlename:var_349a0723ed9ac19c.var_182083fc5337ebe9, #var_6a9e98623b59cbaf:var_6a9e98623b59cbaf };
        level callback::callback( #"player_item_drop", params );
        var_2967abb6e36c57ca notify( #"drop_magicbox_weapon" );
    }
    
    return var_6a9e98623b59cbaf;
}

// Namespace magicbox
// Params 1
// Checksum 0xcf2938b8, Offset: 0xa1bf
// Size: 0x2f5
function function_4494528bb919d011( player )
{
    itembundle = self.itembundle ?? self.mdl_current_weapon.var_9ff2f93ccbf71b93;
    
    if ( itembundle.subtype == "aethertool" )
    {
        if ( player isswitchingweapon() )
        {
            return;
        }
        
        currentrarity = player item_weapon::function_fb81bd2fe070faa6( player getcurrentweapon() );
        
        if ( currentrarity >= itembundle.rarity )
        {
            return;
        }
    }
    
    var_6691fe43150a092f = 0;
    
    if ( function_c2e50a32d8592f77( player, self.weaponobj ) )
    {
        if ( !isdefined( self.var_951c89546ec50477 ) )
        {
            self.var_951c89546ec50477 = 0;
        }
        
        self.var_951c89546ec50477++;
        self.var_951c89546ec50477 = int( clamp( self.var_951c89546ec50477, 0, level.var_eda995bb839c4aa ) );
        self.var_768b3618cd111c7e = 1;
        self.upgrade_source = #"magicbox";
        var_6691fe43150a092f = 1;
    }
    
    self.pickup_source = #"magicbox";
    params = spawnstruct();
    params.objweapon = self.weaponobj;
    params.itembundle = itembundle;
    params.lootid = common_item::items_getlootidfromref( self.itembundle.ref ?? self.mdl_current_weapon.var_9ff2f93ccbf71b93.ref );
    params.cost = self.cost ?? self.mdl_current_weapon.cost ?? 950;
    params.currency = level.magicbox_currency_type;
    params.var_4e0aa9a7c35d4dce = self.rolled_scorestreak ?? self.mdl_current_weapon.rolled_scorestreak;
    params.var_15823e486f78cb79 = self.var_c472ba9c1811f8cf ?? self.mdl_current_weapon.var_c472ba9c1811f8cf;
    params.var_6691fe43150a092f = var_6691fe43150a092f;
    params.var_328ae4e0cf700246 = self.var_328ae4e0cf700246;
    
    if ( isplayer( player ) )
    {
        favoriteweapon = player weaponmetadata::function_c68204eff69ed046( self.weaponobj.basename );
        
        if ( isdefined( favoriteweapon ) )
        {
            params.objweapon = favoriteweapon;
        }
        
        if ( player utility::callsharedfunc( #"gametype", #"hash_f9e2fd3c47c40374", self, params.lootid ) )
        {
            return;
        }
    }
    
    player callback::callback( "magicbox_purchase", params );
    self.var_f7d425332dfd14bc = function_535a73eae8edf8b7( player, self.mdl_current_weapon, self.var_349a0723ed9ac19c );
    self notify( #"picked_up_weapon" );
}

// Namespace magicbox
// Params 1
// Checksum 0x800f0f96, Offset: 0xa4bc
// Size: 0x34a
function function_f289ba80c654e2e1( player )
{
    mdl_current_weapon = self.mdl_current_weapon;
    
    if ( isplayer( player ) && isplayer( mdl_current_weapon.var_349a0723ed9ac19c.var_37f3a4cd8252c9f0 ) )
    {
        if ( !mdl_current_weapon.var_349a0723ed9ac19c.var_4da360839b7baec4 && player != mdl_current_weapon.var_349a0723ed9ac19c.var_37f3a4cd8252c9f0 )
        {
            return;
        }
    }
    
    if ( player.var_432159241a2f9367 )
    {
        return;
    }
    
    var_482e9999b75ed3d8 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    fakeitem = spawnstruct();
    var_9ff2f93ccbf71b93 = mdl_current_weapon.var_9ff2f93ccbf71b93;
    fakeitem.weaponobj = mdl_current_weapon.weaponobj;
    fakeitem.var_6828becb300b1c44 = mdl_current_weapon.var_6828becb300b1c44;
    
    if ( !mdl_current_weapon.rolled_scorestreak )
    {
        weaponobj = fakeitem.weaponobj;
        
        if ( !isdefined( weaponobj ) )
        {
            weaponobj = item_weapon::function_477bf1207c6672a5( var_9ff2f93ccbf71b93 );
        }
        
        clipammo = weaponclipsize( weaponobj );
        stockammo = utility::get_max_stock_ammo( weaponobj, var_482e9999b75ed3d8 );
        fakeitem.count = common_item::function_598dd39282efb544( clipammo );
        fakeitem.weaponstockammo = stockammo;
    }
    else
    {
        fakeitem.count = 1;
        fakeitem.var_9d84756796dfbd69 = 1;
    }
    
    var_4e68d5c61b67187f = function_535a73eae8edf8b7( player, mdl_current_weapon );
    
    if ( function_c2e50a32d8592f77( player, self.mdl_current_weapon ) )
    {
        if ( !isdefined( fakeitem.var_951c89546ec50477 ) )
        {
            fakeitem.var_951c89546ec50477 = 0;
        }
        
        fakeitem.var_951c89546ec50477++;
        fakeitem.var_951c89546ec50477 = int( clamp( fakeitem.var_951c89546ec50477, 0, level.var_eda995bb839c4aa ) );
        fakeitem.var_768b3618cd111c7e = 1;
        fakeitem.upgrade_source = #"magicbox";
    }
    
    fakeitem.loot_source = "magicbox";
    var_5d8cc93233d1451a = player common_item::function_3f39e7be347cf7e1( var_9ff2f93ccbf71b93, fakeitem, var_4e68d5c61b67187f );
    
    if ( isarray( var_5d8cc93233d1451a ) && isweapon( var_5d8cc93233d1451a[ 1 ] ) )
    {
        var_5d8cc93233d1451a = var_5d8cc93233d1451a[ 1 ];
    }
    
    params = spawnstruct();
    params.objweapon = var_5d8cc93233d1451a;
    params.itembundle = var_9ff2f93ccbf71b93;
    params.lootid = common_item::items_getlootidfromref( var_9ff2f93ccbf71b93.ref );
    params.cost = self.cost ?? 950;
    params.currency = level.magicbox_currency_type;
    params.var_4e0aa9a7c35d4dce = mdl_current_weapon.rolled_scorestreak;
    params.var_15823e486f78cb79 = mdl_current_weapon.var_c472ba9c1811f8cf;
    player callback::callback( "magicbox_purchase", params );
    mdl_current_weapon delete();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace magicbox
// Params 3
// Checksum 0x5100cc51, Offset: 0xa80e
// Size: 0x26a
function function_535a73eae8edf8b7( player, mdl_current_weapon, var_349a0723ed9ac19c )
{
    var_349a0723ed9ac19c = var_349a0723ed9ac19c ?? mdl_current_weapon.var_349a0723ed9ac19c;
    
    if ( isdefined( var_349a0723ed9ac19c.origin ) && isdefined( var_349a0723ed9ac19c.angles ) )
    {
        if ( !isdefined( var_349a0723ed9ac19c.dropped_item_count ) || var_349a0723ed9ac19c.dropped_item_count >= 12 )
        {
            var_349a0723ed9ac19c.dropped_item_count = 0;
        }
        
        if ( isent( var_349a0723ed9ac19c.mdl_magicbox ) && var_349a0723ed9ac19c.mdl_magicbox tagexists( "tag_hint" ) )
        {
            startorigin = var_349a0723ed9ac19c.mdl_magicbox gettagorigin( "tag_hint" );
        }
        else
        {
            startorigin = var_349a0723ed9ac19c.origin;
        }
        
        forwardangles = var_349a0723ed9ac19c.angles + ( 0, 90, 0 );
        forwarddirection = anglestoforward( forwardangles );
        endorigin = startorigin + forwarddirection * 120;
        trace_contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1 );
        trace_results = trace::ray_trace( startorigin, endorigin + forwarddirection * 18, [ mdl_current_weapon, var_349a0723ed9ac19c.mdl_magicbox ], trace_contents );
        var_afa21d84ba1b232b = trace_results[ "position" ] - forwarddirection * 18;
        
        if ( ispointonnavmesh( var_afa21d84ba1b232b ) )
        {
            endorigin = getclosestpointonnavmesh( var_afa21d84ba1b232b ) ?? var_afa21d84ba1b232b;
        }
        else
        {
            endorigin = getclosestpointonnavmesh( player.origin ) ?? player.origin;
        }
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) && !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", endorigin ) )
        {
            endorigin = player.origin;
        }
        
        var_4e68d5c61b67187f = common_item::function_b94327aa4c1b718b( endorigin, player );
        var_4e68d5c61b67187f.spawnpositionindex = var_349a0723ed9ac19c.dropped_item_count;
        var_4e68d5c61b67187f.var_44d5025c8cfbd48e = 12;
        var_4e68d5c61b67187f.var_2321e933cbdf46d8 = 20;
        var_4e68d5c61b67187f.var_34444f0dda11f0d5 = 20;
        var_349a0723ed9ac19c.dropped_item_count++;
    }
    
    return var_4e68d5c61b67187f;
}

// Namespace magicbox
// Params 0
// Checksum 0xb5065875, Offset: 0xaa81
// Size: 0x44
function function_f3335515689aea95()
{
    s_magicbox_bundle = get_magicbox_bundle();
    
    if ( isdefined( s_magicbox_bundle.var_71fedfc7f7d51eb4 ) )
    {
        return ( s_magicbox_bundle.var_71fedfc7f7d51eb4 + clamp( level.players.size, 1, 6 ) );
    }
    
    return 5;
}

// Namespace magicbox
// Params 0
// Checksum 0x917342f8, Offset: 0xaace
// Size: 0x31
function function_e3b0708d3db476e7()
{
    s_magicbox_bundle = get_magicbox_bundle();
    
    if ( isdefined( s_magicbox_bundle.var_4784294c9b87b201 ) )
    {
        return s_magicbox_bundle.var_4784294c9b87b201;
    }
    
    return 5;
}

// Namespace magicbox
// Params 1
// Checksum 0xe6c6e079, Offset: 0xab08
// Size: 0xf2
function function_80a5548590287002( var_410b736ba41817c2 )
{
    s_magicbox_bundle = get_magicbox_bundle();
    
    if ( isdefined( s_magicbox_bundle ) && isarray( s_magicbox_bundle.var_cfbdc7cea4fbeaf7 ) )
    {
        foreach ( var_d7cba32dce497f81 in s_magicbox_bundle.var_cfbdc7cea4fbeaf7 )
        {
            if ( var_410b736ba41817c2 >= var_d7cba32dce497f81.minuses && var_410b736ba41817c2 <= var_d7cba32dce497f81.maxuses )
            {
                return utility::percent_chance( var_d7cba32dce497f81.percentchance );
            }
        }
    }
    
    if ( var_410b736ba41817c2 <= function_e3b0708d3db476e7() )
    {
        return 0;
    }
    
    return utility::percent_chance( 40 );
}

// Namespace magicbox
// Params 1
// Checksum 0x598299ad, Offset: 0xac03
// Size: 0xd5
function function_867f63c990ceb381( itemname )
{
    var_95c09b8cca989a4 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "itemAngleStruct" );
    
    if ( isdefined( var_95c09b8cca989a4 ) )
    {
        foreach ( var_c5d69ecdd6138488 in var_95c09b8cca989a4 )
        {
            if ( itemname == var_c5d69ecdd6138488.itemname )
            {
                return ( var_c5d69ecdd6138488.pitch, var_c5d69ecdd6138488.yaw, var_c5d69ecdd6138488.roll );
            }
        }
    }
    
    return ( 0, 0, 0 );
}

// Namespace magicbox
// Params 1
// Checksum 0xe9c7de9e, Offset: 0xace1
// Size: 0xd5
function function_7f3e570ed34d0320( itemname )
{
    var_1bd2ff4a488fe727 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "itemOriginStruct" );
    
    if ( isdefined( var_1bd2ff4a488fe727 ) )
    {
        foreach ( var_c5d69ecdd6138488 in var_1bd2ff4a488fe727 )
        {
            if ( itemname == var_c5d69ecdd6138488.itemname )
            {
                return ( var_c5d69ecdd6138488.x, var_c5d69ecdd6138488.y, var_c5d69ecdd6138488.z );
            }
        }
    }
    
    return ( 0, 0, 0 );
}

// Namespace magicbox
// Params 0
// Checksum 0xf022cb0b, Offset: 0xadbf
// Size: 0x39
function function_867be05bade1bb6a()
{
    var_6356a5030ce91076 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "trackMagicBoxUsageGlobally" );
    
    if ( var_6356a5030ce91076 )
    {
        return level.var_410b736ba41817c2;
    }
    
    return self.var_410b736ba41817c2;
}

// Namespace magicbox
// Params 0
// Checksum 0x3a521bbd, Offset: 0xae00
// Size: 0x39
function function_2f2c153d347d51cd()
{
    var_6356a5030ce91076 = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "trackMagicBoxUsageGlobally" );
    
    if ( var_6356a5030ce91076 )
    {
        return level.var_1c98168ff9213851;
    }
    
    return self.var_1c98168ff9213851;
}

// Namespace magicbox
// Params 1
// Checksum 0xa06be75a, Offset: 0xae41
// Size: 0xd5
function should_move_magicbox( var_b674a7b202792f5a = 0 )
{
    if ( var_b674a7b202792f5a )
    {
        return 0;
    }
    
    if ( isdefined( level.var_c7164a558fe3d921 ) )
    {
        b_should_move = [[ level.var_c7164a558fe3d921 ]]();
        
        if ( isdefined( b_should_move ) )
        {
            return b_should_move;
        }
    }
    
    if ( level.var_5542fc8f8eafa0c0 )
    {
        /#
            iprintlnbold( "<dev string:x9f8>" );
        #/
        
        return 0;
    }
    
    if ( level.var_70c5979783790e1b )
    {
        return 1;
    }
    
    if ( utility::flag( "powerup_fire_sale_active" ) )
    {
        return 0;
    }
    
    var_1c98168ff9213851 = function_2f2c153d347d51cd();
    var_410b736ba41817c2 = function_867be05bade1bb6a();
    
    if ( !var_1c98168ff9213851 )
    {
        if ( var_410b736ba41817c2 >= function_f3335515689aea95() )
        {
            return 1;
        }
    }
    else if ( var_410b736ba41817c2 < function_e3b0708d3db476e7() )
    {
        return 0;
    }
    else
    {
        return function_80a5548590287002( var_410b736ba41817c2 );
    }
    
    return 0;
}

// Namespace magicbox
// Params 0
// Checksum 0x5866d736, Offset: 0xaf1f
// Size: 0x2c
function function_a2ee2e57e51b2596()
{
    str_notify = utility::waittill_any_timeout( 12, "picked_up_weapon", "force_respin", "drop_magicbox_weapon", "death" );
    return str_notify;
}

// Namespace magicbox
// Params 0
// Checksum 0x16fdbf6f, Offset: 0xaf54
// Size: 0x3f0
function function_80fa7b4228afb948()
{
    self endon( #"death" );
    wait 0.5;
    var_1b91cf930f8d9e93 = 2304;
    var_614dc16b090b7cf5 = self.var_349a0723ed9ac19c.var_37f3a4cd8252c9f0;
    
    while ( isplayer( var_614dc16b090b7cf5 ) && self.var_349a0723ed9ac19c.mdl_magicbox.interact.b_opened_magicbox )
    {
        if ( ( var_614dc16b090b7cf5 ismeleeing() || var_614dc16b090b7cf5.var_23c08b8d00196b63 ) && distance2dsquared( var_614dc16b090b7cf5.origin, self.origin ) < var_1b91cf930f8d9e93 )
        {
            if ( utility::within_fov( var_614dc16b090b7cf5.origin, var_614dc16b090b7cf5.angles, self.origin, cos( 70 ) ) )
            {
                if ( getdvarint( @"hash_9ad1473010eec536", 1 ) )
                {
                    if ( !var_614dc16b090b7cf5.var_432159241a2f9367 )
                    {
                        var_6a9e98623b59cbaf = self.item function_d6cb29bad3ee9a9( var_614dc16b090b7cf5 );
                        
                        if ( isdefined( var_6a9e98623b59cbaf ) )
                        {
                            self.var_349a0723ed9ac19c.var_4da360839b7baec4 = 1;
                            var_614dc16b090b7cf5 callback::callback( #"on_magicbox_melee_share", self.var_349a0723ed9ac19c );
                            
                            foreach ( player in level.players )
                            {
                                if ( !player.var_432159241a2f9367 )
                                {
                                    var_6a9e98623b59cbaf enablescriptableplayeruse( player );
                                }
                            }
                            
                            return;
                        }
                    }
                }
                else
                {
                    self.var_349a0723ed9ac19c.var_4da360839b7baec4 = 1;
                    var_614dc16b090b7cf5 callback::callback( #"on_magicbox_melee_share", self.var_349a0723ed9ac19c );
                    
                    if ( getdvarint( @"hash_6965cd369482e004", 1 ) )
                    {
                        foreach ( player in level.players )
                        {
                            if ( !player.var_432159241a2f9367 )
                            {
                                self.var_349a0723ed9ac19c.mdl_current_weapon.interact enablescriptableplayeruse( player );
                            }
                        }
                    }
                    else
                    {
                        self.var_349a0723ed9ac19c.mdl_current_weapon.interact enableplayeruseforallplayers();
                    }
                    
                    self.var_349a0723ed9ac19c.mdl_magicbox setscriptablepartstate( "audio_oneshots", "melee_share" );
                    
                    if ( !isdefined( level._effect[ "magic_box_shared_weapon_fx" ] ) )
                    {
                        var_b35a47faa676317e = getscriptbundlefieldvalue( get_magicbox_bundle_name(), "magicBoxSharedWeaponVFX" );
                        assert( isdefined( var_b35a47faa676317e ), "<dev string:xa14>" );
                        level._effect[ "magic_box_shared_weapon_fx" ] = loadfxasset( var_b35a47faa676317e );
                    }
                    
                    var_5312650444a46cf7 = "j_gun";
                    
                    if ( !self.var_349a0723ed9ac19c.mdl_current_weapon tagexists( var_5312650444a46cf7 ) )
                    {
                        if ( self.var_349a0723ed9ac19c.mdl_current_weapon tagexists( "tag_origin" ) )
                        {
                            var_5312650444a46cf7 = "tag_origin";
                        }
                        else if ( self.var_349a0723ed9ac19c.mdl_current_weapon tagexists( "tag_accessory" ) )
                        {
                            var_5312650444a46cf7 = "tag_accessory";
                        }
                    }
                    
                    playfxontag( utility::getfx( "magic_box_shared_weapon_fx" ), self.var_349a0723ed9ac19c.mdl_current_weapon, var_5312650444a46cf7 );
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace magicbox
// Params 1
// Checksum 0xf2854499, Offset: 0xb34c
// Size: 0xc
function on_round_end( params )
{
    
}

// Namespace magicbox
// Params 1
// Checksum 0x7a777123, Offset: 0xb360
// Size: 0x173
function function_59fb358a01aea2b6( var_aaf4abd69ed1ce9d = "none" )
{
    switch ( var_aaf4abd69ed1ce9d )
    {
        case #"hash_883ff07272b4f9c":
        case #"hash_540f19f4cb02adc3":
            self setscriptablepartstate( "base", "opened_uncommon" );
            break;
        case #"hash_209fa8900070d83d":
        case #"hash_778bb52ecd08072d":
            self setscriptablepartstate( "base", "opened_rare" );
            break;
        case #"hash_598a30e44f53045f":
        case #"hash_95068103fe897bc8":
            self setscriptablepartstate( "base", "opened_epic" );
            break;
        case #"hash_35bb3bd014c77f4b":
        case #"hash_d6c98e710a88aa4a":
            self setscriptablepartstate( "base", "opened_legendary" );
            break;
        case #"hash_d6a6f27ab9e38e15":
            self setscriptablepartstate( "base", "opened_ultra_red" );
            break;
        case #"hash_22aea56c1711fd5":
        case #"hash_2ac407c1cd5943a9":
        case #"hash_2bb18549e1e51286":
        case #"hash_8d39eb0f19bf9df3":
            self setscriptablepartstate( "base", "opened_ultra" );
            break;
        case #"hash_1393412d7401c646":
        case #"hash_6c4c3516ab5ce943":
        case #"hash_db653a4972b3c13b":
        case #"hash_f9bb0e989176d455":
            self setscriptablepartstate( "base", "opened_default" );
            break;
    }
}

// Namespace magicbox
// Params 2
// Checksum 0x500e7db3, Offset: 0xb4db
// Size: 0x231
function get_rarity_hint_string( var_aaf4abd69ed1ce9d = "none", b_melee_share = 0 )
{
    switch ( var_aaf4abd69ed1ce9d )
    {
        case #"hash_883ff07272b4f9c":
        case #"hash_540f19f4cb02adc3":
            if ( b_melee_share )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_uncommon_shared";
            }
            else if ( getdvarint( @"hash_9674adda08a0bcc0", 0 ) )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_uncommon";
            }
            else
            {
                return &"SHARED_HINTSTRINGS/MAGICBOX_GRAB_WEAPON_UNCOMMON_NOPARAM";
            }
            
            break;
        case #"hash_209fa8900070d83d":
        case #"hash_778bb52ecd08072d":
            if ( b_melee_share )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_rare_shared";
            }
            else if ( getdvarint( @"hash_9674adda08a0bcc0", 0 ) )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_rare";
            }
            else
            {
                return &"SHARED_HINTSTRINGS/MAGICBOX_GRAB_WEAPON_RARE_NOPARAM";
            }
            
            break;
        case #"hash_598a30e44f53045f":
        case #"hash_95068103fe897bc8":
            if ( b_melee_share )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_epic_shared";
            }
            else if ( getdvarint( @"hash_9674adda08a0bcc0", 0 ) )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_epic";
            }
            else
            {
                return &"SHARED_HINTSTRINGS/MAGICBOX_GRAB_WEAPON_EPIC_NOPARAM";
            }
            
            break;
        case #"hash_35bb3bd014c77f4b":
        case #"hash_d6c98e710a88aa4a":
            if ( b_melee_share )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_legendary_shared";
            }
            else if ( getdvarint( @"hash_9674adda08a0bcc0", 0 ) )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_legendary";
            }
            else
            {
                return &"SHARED_HINTSTRINGS/MAGICBOX_GRAB_WEAPON_LEGENDARY_NOPARAM";
            }
            
            break;
        case #"hash_22aea56c1711fd5":
        case #"hash_1393412d7401c646":
        case #"hash_2ac407c1cd5943a9":
        case #"hash_2bb18549e1e51286":
        case #"hash_6c4c3516ab5ce943":
        case #"hash_8d39eb0f19bf9df3":
        case #"hash_d6a6f27ab9e38e15":
        case #"hash_db653a4972b3c13b":
        case #"hash_f9bb0e989176d455":
            if ( b_melee_share )
            {
                return &"shared_hintstrings/magicbox_grab_weapon_shared";
            }
            else if ( getdvarint( @"hash_9674adda08a0bcc0", 0 ) )
            {
                return &"shared_hintstrings/magicbox_grab_weapon";
            }
            else
            {
                return &"SHARED_HINTSTRINGS/MAGICBOX_GRAB_WEAPON_NOPARAM";
            }
            
            break;
    }
    
    return 0;
}

// Namespace magicbox
// Params 1
// Checksum 0xf6502849, Offset: 0xb715
// Size: 0x178
function get_rarity_outline( rarity = "none" )
{
    switch ( rarity )
    {
        case 1:
        case #"hash_883ff07272b4f9c":
        case #"hash_540f19f4cb02adc3":
            return "outline_depth_green";
        case 2:
        case #"hash_209fa8900070d83d":
        case #"hash_778bb52ecd08072d":
            return "outline_depth_blue";
        case 3:
        case #"hash_598a30e44f53045f":
        case #"hash_95068103fe897bc8":
            return "outline_depth_purple";
        case 4:
        case #"hash_35bb3bd014c77f4b":
        case #"hash_d6c98e710a88aa4a":
            return "outline_depth_orange";
        case 5:
        case #"hash_d6a6f27ab9e38e15":
            return "outline_depth_red_ultra";
        case 6:
        case #"hash_22aea56c1711fd5":
        case #"hash_2ac407c1cd5943a9":
        case #"hash_2bb18549e1e51286":
        case #"hash_8d39eb0f19bf9df3":
            return "outline_depth_yellow";
        case 0:
        case #"hash_1393412d7401c646":
        case #"hash_6c4c3516ab5ce943":
        case #"hash_db653a4972b3c13b":
        case #"hash_f9bb0e989176d455":
        default:
            return "outline_depth_white";
    }
}

// Namespace magicbox
// Params 2
// Checksum 0x2b5dfc94, Offset: 0xb895
// Size: 0x32
function function_6f00dd035f2d8f9a( var_94d1ab5da995e573, var_c510aed3e86e3f65 )
{
    level.var_641b7c91f663ea4f = var_94d1ab5da995e573;
    level.var_104dd1bc9d142921 = var_c510aed3e86e3f65;
    function_8e43becf2ff168b5();
}

// Namespace magicbox
// Params 1
// Checksum 0x776ee6ac, Offset: 0xb8cf
// Size: 0x17
function function_2e49cd8681e36211( var_94d1ab5da995e573 )
{
    level.var_20cf5eda0c956d52 = var_94d1ab5da995e573;
}

// Namespace magicbox
// Params 2
// Checksum 0xf98d8601, Offset: 0xb8ee
// Size: 0xb8
function function_c2e50a32d8592f77( player, weaponobj )
{
    if ( isdefined( level.a_magicbox_should_upgrade_weapon ) && player function_4d0f84f9db991a70( weaponobj ) )
    {
        foreach ( func in level.a_magicbox_should_upgrade_weapon )
        {
            var_fa916ad9f60cfc8d = [[ func ]]( player );
            
            if ( isdefined( var_fa916ad9f60cfc8d ) )
            {
                return var_fa916ad9f60cfc8d;
            }
        }
    }
    
    return 0;
}

// Namespace magicbox
// Params 1
// Checksum 0x9c08977f, Offset: 0xb9af
// Size: 0x3f
function register_upgrade_weapon( func_upgrade_weapon )
{
    if ( !isdefined( level.a_magicbox_should_upgrade_weapon ) )
    {
        level.a_magicbox_should_upgrade_weapon = [];
    }
    
    level.a_magicbox_should_upgrade_weapon = arraycombineunique( level.a_magicbox_should_upgrade_weapon, [ func_upgrade_weapon ] );
}

// Namespace magicbox
// Params 1
// Checksum 0xeabb4d4e, Offset: 0xb9f6
// Size: 0x67, Type: bool
function function_4d0f84f9db991a70( weaponobj )
{
    if ( !( isdefined( weaponobj ) && isdefined( level.var_b6377f00348c4d99[ weaponobj.var_1616e6fbba9a722d ] ) ) )
    {
        return false;
    }
    
    n_weapon_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weaponobj );
    
    if ( n_weapon_level < level.var_eda995bb839c4aa )
    {
        return true;
    }
    
    return false;
}

// Namespace magicbox
// Params 1
// Checksum 0xdc288a08, Offset: 0xba66
// Size: 0x5d
function function_682f5d6d99881879( s_feature )
{
    mdl_magicbox = s_feature.mdl_magicbox;
    
    if ( s_feature.var_9870f882980ab31b )
    {
        s_feature.var_9870f882980ab31b = 0;
        mdl_magicbox.interact setusableenabled( 0 );
        s_feature.var_9e211bca8759c579 = 1;
    }
}

// Namespace magicbox
// Params 1
// Checksum 0x2df4494f, Offset: 0xbacb
// Size: 0x5c
function function_905cbfe12b2fdf2( s_feature )
{
    mdl_magicbox = s_feature.mdl_magicbox;
    
    if ( s_feature.var_9e211bca8759c579 )
    {
        s_feature.var_9870f882980ab31b = 1;
        mdl_magicbox.interact setusableenabled( 1 );
        s_feature.var_9e211bca8759c579 = undefined;
    }
}

/#

    // Namespace magicbox
    // Params 0, eflags: 0x4
    // Checksum 0x12e56eed, Offset: 0xbb2f
    // Size: 0x546, Type: dev
    function private function_6fe2408779419280()
    {
        var_344c87cda146b92c = ( 0, 0, 4 );
        n_text_size = 0.25;
        
        while ( true )
        {
            foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
            {
                if ( !isdefined( var_349a0723ed9ac19c.mdl_magicbox ) )
                {
                    continue;
                }
                
                if ( isdefined( var_349a0723ed9ac19c.var_93e4a0a8514ca47e ) && !isdefined( var_349a0723ed9ac19c.s_destination ) )
                {
                    var_349a0723ed9ac19c.s_destination = utility::getstruct( var_349a0723ed9ac19c.var_93e4a0a8514ca47e, "<dev string:xa5c>" );
                }
                
                var_d876b0c0fe4d6eba = "<dev string:xa67>";
                
                if ( var_349a0723ed9ac19c.mdl_magicbox.interact tagexists( "<dev string:xa72>" ) )
                {
                    v_position = var_349a0723ed9ac19c.mdl_magicbox.interact gettagorigin( "<dev string:xa72>" );
                    var_d876b0c0fe4d6eba = "<dev string:xa72>";
                }
                else
                {
                    v_position = var_349a0723ed9ac19c.mdl_magicbox.interact.origin;
                }
                
                if ( var_349a0723ed9ac19c.var_9870f882980ab31b )
                {
                    sphere( v_position, var_349a0723ed9ac19c.mdl_magicbox.interact.interact_use_range, ( 0, 1, 0 ) );
                    
                    if ( isdefined( var_349a0723ed9ac19c.s_destination ) )
                    {
                        line( v_position, var_349a0723ed9ac19c.s_destination.origin, ( 0, 1, 0 ) );
                    }
                }
                else
                {
                    sphere( v_position, var_349a0723ed9ac19c.mdl_magicbox.interact.interact_use_range, ( 1, 0, 0 ) );
                    
                    if ( isdefined( var_349a0723ed9ac19c.s_destination ) )
                    {
                        line( v_position, var_349a0723ed9ac19c.s_destination.origin, ( 1, 0, 0 ) );
                    }
                }
                
                if ( isdefined( var_349a0723ed9ac19c.mdl_current_weapon ) )
                {
                    sphere( var_349a0723ed9ac19c.mdl_current_weapon.origin, 5, ( 0, 0, 1 ) );
                    line( var_349a0723ed9ac19c.origin, var_349a0723ed9ac19c.mdl_current_weapon.origin, ( 0, 0, 1 ) );
                    
                    if ( isdefined( var_349a0723ed9ac19c.v_start_weapon_position ) && isdefined( var_349a0723ed9ac19c.var_b84da611d185462 ) )
                    {
                        sphere( var_349a0723ed9ac19c.v_start_weapon_position, 2, ( 0.5, 0.5, 1 ) );
                        line( var_349a0723ed9ac19c.v_start_weapon_position, var_349a0723ed9ac19c.var_b84da611d185462, ( 0.5, 0.5, 1 ) );
                        sphere( var_349a0723ed9ac19c.var_b84da611d185462, 2, ( 0.5, 0.5, 1 ) );
                    }
                }
                
                if ( isdefined( var_349a0723ed9ac19c.mdl_weapon_streaming ) )
                {
                    sphere( var_349a0723ed9ac19c.mdl_weapon_streaming.origin, 5, ( 1, 1, 0 ) );
                    print3d( var_349a0723ed9ac19c.mdl_weapon_streaming.origin, "<dev string:xa7b>", ( 1, 1, 0 ), 1, 0.1 );
                }
                
                print3d( v_position, "<dev string:xa8b>" + var_349a0723ed9ac19c.script_currency, ( 0, 1, 0 ), 1, n_text_size );
                print3d( v_position - var_344c87cda146b92c * 1, "<dev string:xa9b>" + ( var_349a0723ed9ac19c.var_9870f882980ab31b ? "<dev string:xaa7>" : "<dev string:xaab>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 2, "<dev string:xaae>" + var_349a0723ed9ac19c.var_93e4a0a8514ca47e, ( 0, 1, 0 ), 1, 0.25 );
                
                if ( var_349a0723ed9ac19c.mdl_magicbox.interact.var_c3520c71cf883b16 )
                {
                    var_b7fb3f7044fdbed2 = "<dev string:xac3>";
                    var_d876b0c0fe4d6eba = "<dev string:x3af>";
                }
                else
                {
                    var_b7fb3f7044fdbed2 = "<dev string:xacb>";
                    var_d876b0c0fe4d6eba = "<dev string:xad2>" + var_d876b0c0fe4d6eba + "<dev string:xad9>";
                }
                
                print3d( v_position - var_344c87cda146b92c * 3, "<dev string:xadb>" + var_b7fb3f7044fdbed2 + var_d876b0c0fe4d6eba, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 4, "<dev string:xaed>" + ( var_349a0723ed9ac19c.targetname ?? "<dev string:x3af>" ), ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 5, "<dev string:xafa>" + ( var_349a0723ed9ac19c.script_noteworthy ?? "<dev string:x3af>" ), ( 0, 1, 0 ), 1, 0.25 );
            }
            
            waitframe();
        }
    }

#/
