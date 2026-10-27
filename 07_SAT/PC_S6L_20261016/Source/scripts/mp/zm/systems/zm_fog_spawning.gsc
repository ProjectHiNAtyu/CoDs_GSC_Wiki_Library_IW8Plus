// scripts\mp\zm\systems\zm_fog_spawning.gsc  (hash_79a970c12574b2f3.gscc) (size: 28311 Bytes / 0x6e97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcbd957fe (3420018686)
// size ...... 28311 (0x6e97)
// includes .. 16  (offset: 0x6717)
// strings ... 71  (offset: 0x6797)
// dev strs .. 37  (offset: 0x6cdb)
// exports ... 53  (offset: 0x4b97)
// cseg ...... 0x513 + 0x4684 (0x4b97)
// imports ... 151 (offset: 0x53df)
// animtree1 . 0   (offset: 0x6e97)
// animtree2 . 0   (offset: 0x6e97)
#using script_4bf223434bdc0646;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_fog_spawning;

// Namespace zm_fog_spawning
// Params 1
// Checksum 0x3a4ecb1f, Offset: 0x531
// Size: 0x921
function init_zm_fog_spawning( var_8593f17418a81b6e = "zmfogspawning:zm_sat_fog_spawning" )
{
    level.var_53da962cd3dd49de = 0;
    level.var_25223259f9cd6017 = [];
    level.var_acf75fdcd1a428ac = [];
    spawnbundle = getscriptbundle( var_8593f17418a81b6e );
    level._effect[ "fog_spawn_fx" ] = loadfxasset( spawnbundle.fogspawnvfx );
    level._effect[ "fog_despawn_fx" ] = loadfxasset( spawnbundle.var_decbb5a1f38e869c );
    level.var_33df283475cc8d48 = spawnstruct();
    level.var_33df283475cc8d48.var_30990782d6918dde = spawnbundle.var_30990782d6918dde;
    level.var_33df283475cc8d48.var_235a662f93690a4a = spawnbundle.var_235a662f93690a4a;
    level.var_33df283475cc8d48.var_6beb62354245fa65 = spawnbundle.var_6beb62354245fa65;
    level.var_33df283475cc8d48.var_698edd9f9c4b06e0 = spawnbundle.var_698edd9f9c4b06e0;
    level.var_33df283475cc8d48.var_72e041dd9f61226 = spawnbundle.var_72e041dd9f61226;
    level.var_33df283475cc8d48.var_45a1f0a3858b0b97 = spawnbundle.var_45a1f0a3858b0b97;
    level.var_33df283475cc8d48.var_4932f11f21af7d9d = spawnbundle.var_4932f11f21af7d9d;
    level.var_33df283475cc8d48.var_cdf6bd139cc24ebf = spawnbundle.var_cdf6bd139cc24ebf;
    level.var_33df283475cc8d48.var_3f7ee98d2ac9c3a = spawnbundle.var_3f7ee98d2ac9c3a;
    level.var_33df283475cc8d48.var_83dfa973ab4aa1fe = spawnbundle.var_83dfa973ab4aa1fe;
    level.var_33df283475cc8d48.var_9f65f11fc201b8c = spawnbundle.var_5c6661470c4c548;
    level.var_33df283475cc8d48.var_e853d7571353d571 = spawnbundle.var_e853d7571353d571;
    level.var_33df283475cc8d48.var_48b515638d796313 = spawnbundle.var_48b515638d796313;
    level.var_33df283475cc8d48.var_2a7d53f814e12f20 = spawnbundle.var_2a7d53f814e12f20;
    level.var_33df283475cc8d48.var_b005df13b5d398a4 = spawnbundle.var_b005df13b5d398a4;
    level.var_33df283475cc8d48.var_5d87b8b8740f8368 = spawnbundle.var_5d87b8b8740f8368;
    level.var_33df283475cc8d48.var_21bc351fb7205e47 = spawnbundle.var_21bc351fb7205e47;
    level.var_33df283475cc8d48.var_796d2c1d76f03505 = spawnbundle.var_796d2c1d76f03505;
    level.var_33df283475cc8d48.var_f25abb29586c06a = spawnbundle.var_f25abb29586c06a;
    level.var_33df283475cc8d48.var_f999d818b5fa817a = spawnbundle.var_f999d818b5fa817a;
    level.var_33df283475cc8d48.var_162abdccf32f7698 = spawnbundle.var_162abdccf32f7698;
    level.var_33df283475cc8d48.var_e05e39769954982c = spawnbundle.var_e05e39769954982c;
    level.var_33df283475cc8d48.var_1936cc5d9dc3839c = spawnbundle.var_1936cc5d9dc3839c;
    level.var_33df283475cc8d48.var_aa9fa0dcc1e215d0 = spawnbundle.var_aa9fa0dcc1e215d0;
    level.var_33df283475cc8d48.var_c4a4cb63f0e06883 = spawnbundle.var_7f83ce12bc7b982a;
    level.var_33df283475cc8d48.var_d447ee2d3c54c9e5 = spawnbundle.var_d447ee2d3c54c9e5;
    level.var_33df283475cc8d48.var_cf6cf5bdd6a71dfb = spawnbundle.var_cf6cf5bdd6a71dfb;
    level.var_33df283475cc8d48.var_a5b67cc6a93a77a9 = spawnbundle.var_a5b67cc6a93a77a9;
    level.var_33df283475cc8d48.var_595c92c8182be302 = spawnbundle.var_595c92c8182be302;
    level.var_33df283475cc8d48.var_323e6700f1834c22 = spawnbundle.var_323e6700f1834c22;
    level.var_33df283475cc8d48.var_2e398ea05f26111b = spawnbundle.var_2e398ea05f26111b;
    level.var_33df283475cc8d48.var_7a0635e5523849 = spawnbundle.var_7a0635e5523849;
    level.var_33df283475cc8d48.var_d20a3f6452bd8f81 = spawnbundle.var_d20a3f6452bd8f81;
    level.var_33df283475cc8d48.var_ecd14701a82a9a03 = spawnbundle.var_ecd14701a82a9a03;
    level.var_33df283475cc8d48.var_e6e33887b52dc081 = spawnbundle.var_e6e33887b52dc081;
    level.var_33df283475cc8d48.var_b9d299e1dfb17503 = spawnbundle.var_b9d299e1dfb17503;
    level.var_33df283475cc8d48.var_dd6b0e2f5b6161a2 = spawnbundle.var_2f472fdd17e61d19;
    level.var_33df283475cc8d48.var_3cbfcbec3f4cf70d = spawnbundle.var_3cbfcbec3f4cf70d;
    level.var_33df283475cc8d48.var_4dfb4f38cfa3eead = spawnbundle.var_4dfb4f38cfa3eead;
    level.var_33df283475cc8d48.var_1f2fb24794344a1f = spawnbundle.var_1f2fb24794344a1f;
    level.var_33df283475cc8d48.var_3a0dfb851dbbeb54 = spawnbundle.var_3a0dfb851dbbeb54;
    level.var_33df283475cc8d48.var_2cff15dffbbd9118 = spawnbundle.var_2cff15dffbbd9118;
    level.var_33df283475cc8d48.var_d2ba8948e0160fa5 = spawnbundle.var_d2ba8948e0160fa5;
    level.var_33df283475cc8d48.var_d3177cdb4be3e387 = spawnbundle.var_d3177cdb4be3e387;
    level.var_33df283475cc8d48.var_6cb1e1613b319897 = spawnbundle.var_6cb1e1613b319897;
    level.var_33df283475cc8d48.var_4fb25e4d01da49d5 = spawnbundle.var_4fb25e4d01da49d5;
    level.var_33df283475cc8d48.var_4a5ab6b588890457 = spawnbundle.var_4a5ab6b588890457;
    level.var_33df283475cc8d48.var_209fee8b3bf27195 = spawnbundle.var_209fee8b3bf27195;
    level.var_33df283475cc8d48.var_e83e76ec6a554cfc = spawnbundle.var_1ef5aff44c2753c3;
    level thread function_e91935fb2de623f5();
    level thread fog_zone_spawn();
    callback::add( "player_entered_fog", &on_player_enter_fog );
    callback::add( "player_exited_fog", &on_player_exit_fog );
    callback::add( #"on_ai_killed", &function_2ee77690444312b1 );
    zombie_utils::function_dfae6a5bd222c586( &function_c0265dfc63b0b561 );
    level.var_55bfa1e7fe225173 = [ #"zombie_kia_w_mod":1, #"zombie_kia_elite_brot":1, #"zombie_kia_special_brot":1, #"zombie_kia_elite_gas_grenade":1, #"zombie_kia_special_gas_grenade":1, #"zombie_kia_gas_grenade":1, #"distracted":1, #"stunned":1, #"brain_rotted":1, #"electrocuted":1, #"pull_assist":1, #"frozen":1, #"ignited":1, #"hash_c210f65559569cc1":1, #"zombie_kia_dflare":1, #"zombie_kia_ashroud":1, #"zombie_kia_emine":1, #"hash_f0e6167790bf8484":1, #"hash_875e6f1389657771":1, #"zombie_kia_frag":1, #"zombie_kia_semtex":1, #"zombie_kia_axe":1, #"hash_4bd88d4a64b1409b":1, #"zombie_kia_btrap":1, #"hash_e2eeeb5d74cb0ef4":1, #"zombie_kia_impact":1, #"zombie_kia_molotov":1, #"zombie_kia_hellstorm":1, #"hash_1a2be6fea41ada06":1, #"hash_85884d1ba7d36f68":1, #"hash_665bd53b8fd5ecfa":1, #"hash_c9550bd93397ffa4":1, #"zombie_kia_brot":1, #"hash_5540f25db56abdda":1, #"hash_284c529476c38fcd":1, #"hash_e927fd773a9f75f1":1, #"hash_7074f7ae3698f571":1, #"zombie_kia_toma":1, #"zombie_kia_hcannon":1, #"zombie_kia_mgl":1, #"hash_aa7a6a5863a14216":1, #"zombie_kia_dmachine":1, #"hash_6046fb452b6db200":1 ];
    utility::registersharedfunc( #"zombie", #"hash_54d8f73c6da037e3", &function_424f994826025326 );
    level utility::flag_set( "map_fog_spawning_init_finished" );
    
    /#
        level thread function_df9c7616075606ea();
        level thread init_zm_fog_devgui();
    #/
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0xa328506a, Offset: 0xe5a
// Size: 0x28, Type: bool
function function_424f994826025326( kia_event )
{
    if ( isdefined( level.var_55bfa1e7fe225173 ) )
    {
        return istrue( level.var_55bfa1e7fe225173[ kia_event ] );
    }
    
    return false;
}

/#

    // Namespace zm_fog_spawning
    // Params 0
    // Checksum 0x24245287, Offset: 0xe8b
    // Size: 0x2ec, Type: dev
    function function_df9c7616075606ea()
    {
        level endon( #"game_ended" );
        level.var_d27888beb5b5ba83 = 0;
        
        while ( true )
        {
            if ( level.var_d27888beb5b5ba83 )
            {
                var_c65de4153a28fa6e = 0;
                var_929295c75330f2ce = 0;
                var_624a869970c8a446 = 0;
                var_c58412f5c1b38dc0 = 0;
                
                foreach ( zombie in level.var_acf75fdcd1a428ac )
                {
                    if ( zombie.subclass == "<dev string:x24>" || zombie.subclass == "<dev string:x3e>" )
                    {
                        var_c58412f5c1b38dc0++;
                    }
                    
                    if ( zombie.aicategory == "<dev string:x58>" )
                    {
                        var_c65de4153a28fa6e++;
                    }
                    
                    if ( zombie.aicategory == "<dev string:x5e>" )
                    {
                        var_929295c75330f2ce++;
                    }
                    
                    if ( zombie.aicategory == "<dev string:x66>" )
                    {
                        var_624a869970c8a446++;
                    }
                }
                
                var_ff4482df43566395 = level.var_3df3c5390afc7828 ?? 0;
                var_d96b319a77e0ff11 = level.var_6ba3923a19e89944 ?? 0;
                var_6ccecf64c348823d = level.var_acf75fdcd1a428ac.size;
                var_d96b319a77e0ff11 -= var_6ccecf64c348823d;
                
                if ( level.var_53da962cd3dd49de )
                {
                    printtoscreen2d( 200, 560, "<dev string:x6d>", undefined, 4, 4 );
                }
                
                printtoscreen2d( 200, 600, "<dev string:x84>" + var_ff4482df43566395, undefined, 4, 4 );
                printtoscreen2d( 200, 640, "<dev string:x95>" + var_6ccecf64c348823d, undefined, 4, 4 );
                printtoscreen2d( 200, 680, "<dev string:xa8>" + var_d96b319a77e0ff11, undefined, 4, 4 );
                printtoscreen2d( 200, 720, "<dev string:xc5>" + var_c65de4153a28fa6e, undefined, 4, 4 );
                printtoscreen2d( 200, 760, "<dev string:xd9>" + var_929295c75330f2ce, undefined, 4, 4 );
                printtoscreen2d( 200, 800, "<dev string:xef>" + var_624a869970c8a446, undefined, 4, 4 );
                printtoscreen2d( 200, 840, "<dev string:x104>" + var_c58412f5c1b38dc0, undefined, 4, 4 );
                var_5061bf14af486a1c = int( level.var_316c9ae9b5a89a4a * level.var_33df283475cc8d48.var_e853d7571353d571 );
                
                if ( level.players[ 0 ] vehicle::is_in_vehicle() )
                {
                    var_5061bf14af486a1c = int( level.var_316c9ae9b5a89a4a * level.var_33df283475cc8d48.var_48b515638d796313 );
                }
                
                close_zombies = level.var_316c9ae9b5a89a4a - var_5061bf14af486a1c;
                printtoscreen2d( 200, 880, "<dev string:x11a>" + var_5061bf14af486a1c, undefined, 4, 4 );
                printtoscreen2d( 200, 920, "<dev string:x12c>" + close_zombies, undefined, 4, 4 );
            }
            
            waitframe();
        }
    }

#/

// Namespace zm_fog_spawning
// Params 4
// Checksum 0x8a73e849, Offset: 0x117f
// Size: 0x82
function register_fog_zone( fog_zone_name, var_e17a21c721d71c19, var_21cf3d7a62ee3c89, var_21cf3a7a62ee35f0 )
{
    level.var_25223259f9cd6017[ fog_zone_name ] = 1;
    level.var_6b18903c77120093[ fog_zone_name ] = var_e17a21c721d71c19;
    level.var_4a887a52ed954e2f[ fog_zone_name ] = {};
    level.var_4a887a52ed954e2f[ fog_zone_name ].var_dfb5dd9d49225714 = var_21cf3d7a62ee3c89;
    level.var_4a887a52ed954e2f[ fog_zone_name ].var_dfb5e09d49225dad = var_21cf3a7a62ee35f0;
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0x60fe8545, Offset: 0x1209
// Size: 0x2c
function private function_b8f0f21774b05f18()
{
    self endon( #"death" );
    wait randomfloatrange( 0.3, 0.6 );
    
    if ( isalive( self ) )
    {
        fade_out_zombie();
    }
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0x14c3eb2a, Offset: 0x123d
// Size: 0xb6
function private fade_out_zombie()
{
    self endon( #"death" );
    
    if ( self.var_bd3832dce50941ae )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "base", "base_off" );
    utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
    
    if ( self.aicategory == "elite" )
    {
        utility::function_7c10ea82c1e305b8( "fog", "despawn" );
        wait 0.8;
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "fog", "despawn" );
        wait 0.6;
    }
    
    waitframe();
    
    if ( isdefined( self ) )
    {
        val::reset( "fog_zombie_shield", "damageshield" );
        self.nocorpse = 1;
        self.death_source = "zm_fog";
        self kill();
    }
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0xa5f15c3d, Offset: 0x12fb
// Size: 0x52b
function function_e91935fb2de623f5()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_3df3c5390afc7828 ) )
    {
        level.var_3df3c5390afc7828 = 0;
    }
    
    if ( !isdefined( level.var_b0cf1ce913a489be ) )
    {
        level.var_b0cf1ce913a489be = 0;
    }
    
    if ( !isdefined( level.var_6ba3923a19e89944 ) )
    {
        level.var_6ba3923a19e89944 = 0;
    }
    
    level.var_44e7d83aa8cdd033 = 0;
    
    while ( true )
    {
        if ( level.var_acf75fdcd1a428ac.size > 0 )
        {
            foreach ( zombie in level.var_acf75fdcd1a428ac )
            {
                zombiezone = zombie zone_manager::get_current_zone();
                isfog = get_zone_is_fog( zombiezone );
                
                if ( !isfog )
                {
                    if ( isdefined( zombie.var_ce1bdae0ed51db3 ) )
                    {
                        var_ce63a658da4e367c = gettime() - zombie.var_ce1bdae0ed51db3;
                        
                        if ( var_ce63a658da4e367c >= level.var_33df283475cc8d48.var_83dfa973ab4aa1fe * 1000 )
                        {
                            if ( !zombie zombie_utils::function_bf1464d09f4e4b40() && zombie.var_698cf8d8d4a8cbb9 )
                            {
                                zombie thread function_b8f0f21774b05f18();
                            }
                        }
                    }
                    else
                    {
                        zombie.var_ce1bdae0ed51db3 = gettime();
                    }
                    
                    continue;
                }
                
                zombie.var_ce1bdae0ed51db3 = undefined;
            }
        }
        
        if ( isdefined( level.players ) && level.players.size > 0 )
        {
            var_6ba3923a19e89944 = 0;
            var_3df3c5390afc7828 = 0;
            var_b0cf1ce913a489be = 0;
            
            foreach ( player in level.players )
            {
                zone = player zone_manager::get_current_zone();
                isfog = get_zone_is_fog( zone );
                
                if ( isfog && !player.var_14db25ae7cde1c15 )
                {
                    var_3df3c5390afc7828++;
                    player.var_cc1677771f64fd22 = 1;
                    
                    if ( !isdefined( player.fog_zone ) )
                    {
                        player.fog_zone = zone;
                        player callback::callback( "player_entered_fog" );
                    }
                    
                    continue;
                }
                
                var_b0cf1ce913a489be++;
                player.var_cc1677771f64fd22 = 0;
                
                if ( isdefined( player.fog_zone ) )
                {
                    player.fog_zone = undefined;
                    player callback::callback( "player_exited_fog" );
                }
            }
            
            if ( var_3df3c5390afc7828 > 0 )
            {
                if ( level.var_44e7d83aa8cdd033 == 0 )
                {
                    level.var_44e7d83aa8cdd033 = gettime();
                }
            }
            else
            {
                level.var_44e7d83aa8cdd033 = 0;
            }
            
            level.var_3df3c5390afc7828 = var_3df3c5390afc7828;
            level.var_b0cf1ce913a489be = var_b0cf1ce913a489be;
            
            switch ( level.players.size )
            {
                case 1:
                    if ( var_3df3c5390afc7828 == 1 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_698edd9f9c4b06e0;
                    }
                    
                    break;
                case 2:
                    if ( var_3df3c5390afc7828 == 1 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_6beb62354245fa65;
                    }
                    else if ( var_3df3c5390afc7828 == 2 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_72e041dd9f61226;
                    }
                    
                    break;
                case 3:
                    if ( var_3df3c5390afc7828 == 1 || var_3df3c5390afc7828 == 2 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_6beb62354245fa65;
                    }
                    else if ( var_3df3c5390afc7828 == 3 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_72e041dd9f61226;
                    }
                    
                    break;
                case 4:
                    if ( var_3df3c5390afc7828 == 1 || var_3df3c5390afc7828 == 2 || var_3df3c5390afc7828 == 3 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_6beb62354245fa65;
                    }
                    else if ( var_3df3c5390afc7828 == 4 )
                    {
                        var_6ba3923a19e89944 = level.var_33df283475cc8d48.var_72e041dd9f61226;
                    }
                    
                    break;
            }
            
            if ( !isdefined( level.var_f3d1893594afe5bb ) && var_3df3c5390afc7828 == 0 )
            {
                level.var_f3d1893594afe5bb = gettime();
            }
            else if ( isdefined( level.var_f3d1893594afe5bb ) && var_3df3c5390afc7828 > 0 )
            {
                level.var_f3d1893594afe5bb = undefined;
            }
            
            if ( isdefined( level.var_f3d1893594afe5bb ) )
            {
                if ( gettime() - level.var_f3d1893594afe5bb >= 15000 )
                {
                    level.var_f3d1893594afe5bb = undefined;
                    cleanup_fog_zombies();
                }
            }
            
            level.var_6ba3923a19e89944 = var_6ba3923a19e89944;
            
            if ( level.var_3df3c5390afc7828 > 0 )
            {
                level.var_316c9ae9b5a89a4a = int( var_6ba3923a19e89944 / level.var_3df3c5390afc7828 );
            }
            else
            {
                level.var_316c9ae9b5a89a4a = var_6ba3923a19e89944;
            }
        }
        
        wait 0.3;
    }
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0xbdcefd52, Offset: 0x182e
// Size: 0x88
function private on_player_enter_fog( sparams )
{
    /#
        if ( level.var_d27888beb5b5ba83 )
        {
            iprintlnbold( "<dev string:x140>" );
        }
    #/
    
    if ( isplayer( self ) )
    {
        if ( self isvehicleactive() )
        {
            vehicle = player_utility::getvehicle();
            
            if ( isdefined( vehicle ) )
            {
                vehicle utility::function_7c10ea82c1e305b8( "fog_fx", "fog_fx_on" );
            }
        }
        
        utility::function_7c10ea82c1e305b8( "fog_fx", "fog_fx_on" );
        val::set( #"Fog", "round_spawning_ignore_player", 1 );
    }
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0xe3d664c5, Offset: 0x18be
// Size: 0x86
function private on_player_exit_fog( sparams )
{
    /#
        if ( level.var_d27888beb5b5ba83 )
        {
            iprintlnbold( "<dev string:x153>" );
        }
    #/
    
    if ( isplayer( self ) )
    {
        if ( self isvehicleactive() )
        {
            vehicle = player_utility::getvehicle();
            
            if ( isdefined( vehicle ) )
            {
                vehicle utility::function_7c10ea82c1e305b8( "fog_fx", "fog_fx_off" );
            }
        }
        
        utility::function_7c10ea82c1e305b8( "fog_fx", "fog_fx_off" );
        val::reset( #"Fog", "round_spawning_ignore_player" );
    }
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0x5b3b5bee, Offset: 0x194c
// Size: 0xce
function cleanup_fog_zombie( zombie )
{
    if ( isalive( zombie ) && !zombie.var_bd3832dce50941ae && !zombie zombie_utils::function_bf1464d09f4e4b40() )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_off" );
        zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        
        if ( self.aicategory == "elite" )
        {
            zombie utility::function_7c10ea82c1e305b8( "fog", "despawn" );
            wait 0.8;
        }
        else
        {
            zombie utility::function_7c10ea82c1e305b8( "fog", "despawn" );
            wait 0.6;
        }
        
        waitframe();
        
        if ( isdefined( zombie ) )
        {
            zombie val::reset( "fog_zombie_shield", "damageshield" );
            zombie.nocorpse = 1;
            zombie kill();
        }
    }
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x7353546e, Offset: 0x1a22
// Size: 0x144
function cleanup_fog_zombies()
{
    foreach ( zombie in level.var_acf75fdcd1a428ac )
    {
        if ( isalive( zombie ) && !zombie.var_bd3832dce50941ae && !zombie zombie_utils::function_bf1464d09f4e4b40() && zombie.var_698cf8d8d4a8cbb9 )
        {
            zombie utility::function_7c10ea82c1e305b8( "base", "base_off" );
            zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
            
            if ( self.aicategory == "elite" )
            {
                zombie utility::function_7c10ea82c1e305b8( "fog", "despawn" );
                wait 0.8;
            }
            else
            {
                zombie utility::function_7c10ea82c1e305b8( "fog", "despawn" );
                wait 0.6;
            }
            
            waitframe();
            
            if ( isdefined( zombie ) )
            {
                zombie val::reset( "fog_zombie_shield", "damageshield" );
                zombie.nocorpse = 1;
                zombie kill();
            }
        }
        
        waitframe();
    }
}

// Namespace zm_fog_spawning
// Params 11, eflags: 0x4
// Checksum 0x56e206d3, Offset: 0x1b6e
// Size: 0x25b
function private roll_spawn( totalchance, basechance, armoredchance, popcornchance, specialchance, elitechance, baselist, armoredlist, popcornlist, speciallist, elitelist )
{
    diceroll = randomfloat( totalchance );
    previoustotal = totalchance;
    
    if ( elitechance != 0 )
    {
        var_97ea797d8a467719 = totalchance - elitechance;
        previoustotal = var_97ea797d8a467719;
    }
    
    if ( specialchance != 0 )
    {
        var_13c0afec598aef39 = previoustotal - specialchance;
        previoustotal = var_13c0afec598aef39;
    }
    
    if ( basechance != 0 )
    {
        var_501f66c39b7abb73 = previoustotal - armoredchance;
        previoustotal = var_501f66c39b7abb73;
    }
    
    if ( armoredchance != 0 )
    {
        var_e0b85640d06419e0 = previoustotal - armoredchance;
        previoustotal = var_e0b85640d06419e0;
    }
    
    if ( popcornchance != 0 )
    {
        var_ccdf6252dbcbcc9b = previoustotal - popcornchance;
    }
    
    numelites = 0;
    
    foreach ( zombie in level.var_acf75fdcd1a428ac )
    {
        if ( zombie.aicategory == "elite" )
        {
            numelites++;
        }
    }
    
    maxelites = level.var_33df283475cc8d48.var_45a1f0a3858b0b97;
    
    if ( level.players.size > 1 )
    {
        maxelites = level.var_33df283475cc8d48.var_4932f11f21af7d9d;
    }
    
    if ( elitechance > 0 && diceroll >= var_97ea797d8a467719 && numelites < maxelites )
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( elitelist );
    }
    else if ( specialchance > 0 && diceroll >= var_13c0afec598aef39 )
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( speciallist );
    }
    else if ( armoredchance > 0 && diceroll >= var_e0b85640d06419e0 )
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( armoredlist );
    }
    else if ( popcornchance > 0 && diceroll >= var_ccdf6252dbcbcc9b )
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( popcornlist );
    }
    else
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( baselist );
    }
    
    return var_8200d28bbef302ba;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x2eb86861, Offset: 0x1dd2
// Size: 0x1dd
function function_bf2fec5729d1038a()
{
    basechance = level.var_33df283475cc8d48.var_5d87b8b8740f8368 ?? 0;
    armoredchance = level.var_33df283475cc8d48.var_796d2c1d76f03505 ?? 0;
    popcornchance = level.var_33df283475cc8d48.var_f999d818b5fa817a ?? 0;
    specialchance = level.var_33df283475cc8d48.var_e05e39769954982c ?? 0;
    elitechance = level.var_33df283475cc8d48.var_aa9fa0dcc1e215d0 ?? 0;
    elitedelay = level.var_33df283475cc8d48.var_c4a4cb63f0e06883 ?? 0;
    elitedelay *= 1000;
    
    if ( level.var_44e7d83aa8cdd033 != 0 && gettime() - level.var_44e7d83aa8cdd033 < elitedelay )
    {
        elitechance = 0;
    }
    else if ( level.var_44e7d83aa8cdd033 == 0 )
    {
        elitechance = 0;
    }
    
    totalchance = basechance + armoredchance + popcornchance + specialchance + elitechance;
    elitelist = level.var_33df283475cc8d48.var_1936cc5d9dc3839c;
    speciallist = level.var_33df283475cc8d48.var_162abdccf32f7698;
    popcornlist = level.var_33df283475cc8d48.var_f25abb29586c06a;
    armoredlist = level.var_33df283475cc8d48.var_21bc351fb7205e47;
    baselist = level.var_33df283475cc8d48.var_b005df13b5d398a4;
    var_8200d28bbef302ba = roll_spawn( totalchance, basechance, armoredchance, popcornchance, specialchance, elitechance, baselist, armoredlist, popcornlist, speciallist, elitelist ) ?? "zombie_base";
    return var_8200d28bbef302ba;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x21f609fb, Offset: 0x1fb8
// Size: 0x1dd
function function_46b70863669a5b85()
{
    basechance = level.var_33df283475cc8d48.var_a5b67cc6a93a77a9 ?? 0;
    armoredchance = level.var_33df283475cc8d48.var_323e6700f1834c22 ?? 0;
    popcornchance = level.var_33df283475cc8d48.var_7a0635e5523849 ?? 0;
    specialchance = level.var_33df283475cc8d48.var_ecd14701a82a9a03 ?? 0;
    elitechance = level.var_33df283475cc8d48.var_b9d299e1dfb17503 ?? 0;
    elitedelay = level.var_33df283475cc8d48.var_dd6b0e2f5b6161a2 ?? 0;
    elitedelay *= 1000;
    
    if ( level.var_44e7d83aa8cdd033 != 0 && gettime() - level.var_44e7d83aa8cdd033 < elitedelay )
    {
        elitechance = 0;
    }
    else if ( level.var_44e7d83aa8cdd033 == 0 )
    {
        elitechance = 0;
    }
    
    totalchance = basechance + armoredchance + popcornchance + specialchance + elitechance;
    elitelist = level.var_33df283475cc8d48.var_e6e33887b52dc081;
    speciallist = level.var_33df283475cc8d48.var_d20a3f6452bd8f81;
    popcornlist = level.var_33df283475cc8d48.var_2e398ea05f26111b;
    armoredlist = level.var_33df283475cc8d48.var_595c92c8182be302;
    baselist = level.var_33df283475cc8d48.var_cf6cf5bdd6a71dfb;
    var_8200d28bbef302ba = roll_spawn( totalchance, basechance, armoredchance, popcornchance, specialchance, elitechance, baselist, armoredlist, popcornlist, speciallist, elitelist ) ?? "zombie_base";
    return var_8200d28bbef302ba;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0xccedb1f1, Offset: 0x219e
// Size: 0x1dd
function function_441a0145f3811ac3()
{
    basechance = level.var_33df283475cc8d48.var_1f2fb24794344a1f ?? 0;
    armoredchance = level.var_33df283475cc8d48.var_2cff15dffbbd9118 ?? 0;
    popcornchance = level.var_33df283475cc8d48.var_d3177cdb4be3e387 ?? 0;
    specialchance = level.var_33df283475cc8d48.var_4fb25e4d01da49d5 ?? 0;
    elitechance = level.var_33df283475cc8d48.var_209fee8b3bf27195 ?? 0;
    elitedelay = level.var_33df283475cc8d48.var_e83e76ec6a554cfc ?? 0;
    elitedelay *= 1000;
    
    if ( level.var_44e7d83aa8cdd033 != 0 && gettime() - level.var_44e7d83aa8cdd033 < elitedelay )
    {
        elitechance = 0;
    }
    else if ( level.var_44e7d83aa8cdd033 == 0 )
    {
        elitechance = 0;
    }
    
    totalchance = basechance + armoredchance + popcornchance + specialchance + elitechance;
    elitelist = level.var_33df283475cc8d48.var_4a5ab6b588890457;
    speciallist = level.var_33df283475cc8d48.var_6cb1e1613b319897;
    popcornlist = level.var_33df283475cc8d48.var_d2ba8948e0160fa5;
    armoredlist = level.var_33df283475cc8d48.var_3a0dfb851dbbeb54;
    baselist = level.var_33df283475cc8d48.var_4dfb4f38cfa3eead;
    var_8200d28bbef302ba = roll_spawn( totalchance, basechance, armoredchance, popcornchance, specialchance, elitechance, baselist, armoredlist, popcornlist, speciallist, elitelist ) ?? "zombie_base";
    return var_8200d28bbef302ba;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x88f3205e, Offset: 0x2384
// Size: 0x1e0
function function_b98b14292e740c()
{
    level.var_acf75fdcd1a428ac = function_46f9072493651dc9( level.var_acf75fdcd1a428ac );
    fog_zombies = [];
    
    foreach ( zombie in level.var_acf75fdcd1a428ac )
    {
        if ( isalive( zombie ) && zombie.spawn_source == "zm_fog" )
        {
            fog_zombies[ fog_zombies.size ] = zombie;
        }
    }
    
    level.var_acf75fdcd1a428ac = fog_zombies;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        var_bc246b52a94a12d6 = [];
        
        foreach ( zombie in player.var_bc246b52a94a12d6 )
        {
            if ( isalive( zombie ) && zombie.spawn_source == "zm_fog" )
            {
                var_bc246b52a94a12d6[ var_bc246b52a94a12d6.size ] = zombie;
            }
        }
        
        player.var_bc246b52a94a12d6 = var_bc246b52a94a12d6;
    }
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x55b5b60e, Offset: 0x256c
// Size: 0x2c8
function function_103112daac298c03()
{
    var_35ae3a26de446ae7 = 0;
    var_b0918d3332e754a2 = "no_zone";
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        zone = player zone_manager::get_current_zone();
        
        if ( get_zone_is_fog( zone ) )
        {
            if ( var_b0918d3332e754a2 != "no_zone" )
            {
                if ( var_b0918d3332e754a2 == zone.zone_name )
                {
                    continue;
                }
                else
                {
                    var_35ae3a26de446ae7 = 1;
                    break;
                }
                
                continue;
            }
            
            var_b0918d3332e754a2 = zone.zone_name;
        }
    }
    
    if ( var_35ae3a26de446ae7 )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_bc246b52a94a12d6 ) && player.var_bc246b52a94a12d6.size > level.var_316c9ae9b5a89a4a )
            {
                var_8994ee6475ba1c6f = player.var_bc246b52a94a12d6.size - level.var_316c9ae9b5a89a4a;
                
                for ( i = 0; i < var_8994ee6475ba1c6f ; i++ )
                {
                    if ( isplayer( player ) && isalive( player ) )
                    {
                        forward = anglestoforward( player.angles );
                        forward = vectornormalize( forward );
                        
                        foreach ( zombie in player.var_bc246b52a94a12d6 )
                        {
                            if ( isalive( zombie ) && isplayer( player ) && isalive( player ) )
                            {
                                if ( zombie.var_18ea265b7a092c4c )
                                {
                                    continue;
                                }
                                
                                var_ea26dbe2ab7bb940 = zombie.origin - player.origin;
                                var_ea26dbe2ab7bb940 = vectornormalize( var_ea26dbe2ab7bb940 );
                                
                                if ( vectordot( forward, var_ea26dbe2ab7bb940 ) < 0 )
                                {
                                    cleanup_fog_zombie( zombie );
                                    waitframe();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x454e4a4b, Offset: 0x283c
// Size: 0x15, Type: bool
function function_4c21167a2720732()
{
    return isalive( self ) && !self.inlaststand;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0xab206043, Offset: 0x285a
// Size: 0x47b
function function_32cb2ae009c469c7()
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.var_b15266bb386cfb54 )
    {
        return;
    }
    
    zone = player zone_manager::get_current_zone();
    
    if ( !isdefined( player.var_d77908f9bff4a741 ) )
    {
        player.var_d77908f9bff4a741 = zone;
    }
    
    player.var_b15266bb386cfb54 = 1;
    player endon( #"hash_1e4c2bbe7bd9f8ad" );
    roundnumber = zm_utility::get_round_number() ?? 0;
    
    if ( !isdefined( player.var_bc246b52a94a12d6 ) )
    {
        player.var_bc246b52a94a12d6 = [];
    }
    
    if ( player.var_bc246b52a94a12d6.size == level.var_316c9ae9b5a89a4a )
    {
        function_427357c2880abc76( player );
    }
    
    if ( player.var_bc246b52a94a12d6.size < level.var_316c9ae9b5a89a4a )
    {
        spawn_division = get_spawn_division();
        var_246feda91b177e61 = 0;
        var_67b8f0b660bce6 = 0;
        var_3e54ac85fe38b4c3 = 0;
        
        for ( i = 0; i < level.var_316c9ae9b5a89a4a ; i++ )
        {
            if ( !isplayer( player ) || !player function_4c21167a2720732() )
            {
                break;
            }
            
            var_3573d08ca4a0010a = "zombie_base";
            
            if ( roundnumber <= level.var_33df283475cc8d48.var_cdf6bd139cc24ebf )
            {
                var_3573d08ca4a0010a = function_bf2fec5729d1038a();
            }
            else if ( roundnumber > level.var_33df283475cc8d48.var_cdf6bd139cc24ebf && roundnumber <= level.var_33df283475cc8d48.var_3f7ee98d2ac9c3a )
            {
                var_3573d08ca4a0010a = function_46b70863669a5b85();
            }
            else
            {
                var_3573d08ca4a0010a = function_441a0145f3811ac3();
            }
            
            b_spawned_elite = 0;
            
            if ( level.var_d85265655f6db38a[ var_3573d08ca4a0010a ] == "elite" )
            {
                b_spawned_elite = 1;
            }
            
            if ( var_246feda91b177e61 >= spawn_division.division )
            {
                var_246feda91b177e61 = 0;
                var_67b8f0b660bce6 = 0;
                var_3e54ac85fe38b4c3 = 0;
            }
            
            var_347edb120d1c2bca = "near";
            
            if ( function_8f5f58bdd9e44f42( zone, var_3573d08ca4a0010a ) && var_67b8f0b660bce6 < spawn_division.near )
            {
                var_347edb120d1c2bca = "near";
                zones = [ zone ];
            }
            else if ( var_3e54ac85fe38b4c3 < spawn_division.far )
            {
                var_347edb120d1c2bca = "far";
                zones = function_40be4efa9ac54eea( player, zone, var_3573d08ca4a0010a );
            }
            
            is_spawnable = 0;
            
            foreach ( spawn_zone in zones )
            {
                if ( function_8f5f58bdd9e44f42( spawn_zone, var_3573d08ca4a0010a ) )
                {
                    is_spawnable = 1;
                    break;
                }
            }
            
            if ( !is_spawnable )
            {
                continue;
            }
            
            if ( get_zone_is_fog( zone ) )
            {
                if ( b_spawned_elite || player.var_bc246b52a94a12d6.size < level.var_316c9ae9b5a89a4a )
                {
                    zombie = zm_utility::function_9f6754719bfeaeb1( [ "normal" ], &spawn_fog_zombie, { #roundnumber:roundnumber, #zones:zones, #var_3573d08ca4a0010a:var_3573d08ca4a0010a } );
                    
                    if ( isdefined( zombie ) && isdefined( player ) && player function_4c21167a2720732() )
                    {
                        if ( zombie callback::exists( "on_zombie_ai_killed", &function_8bfe7e8e57c53240 ) )
                        {
                            zombie function_8bfe7e8e57c53240( {} );
                            zombie callback::remove( "on_zombie_ai_killed", &function_8bfe7e8e57c53240 );
                        }
                        
                        player.var_bc246b52a94a12d6[ player.var_bc246b52a94a12d6.size ] = zombie;
                        zombie.fog_player_target = player;
                        zombie callback::add( "on_zombie_ai_killed", &function_8bfe7e8e57c53240 );
                        var_246feda91b177e61++;
                    }
                }
                
                if ( isdefined( zombie ) && var_347edb120d1c2bca == "near" )
                {
                    var_67b8f0b660bce6++;
                }
                
                if ( isdefined( zombie ) && var_347edb120d1c2bca == "far" )
                {
                    var_3e54ac85fe38b4c3++;
                }
                
                if ( isdefined( zombie ) && isdefined( player ) )
                {
                    playernum = player getentitynumber();
                    var_3d065c4e99e3d90f = "fog_player_" + playernum;
                    zombie zombie_utils::set_ai_target_priority( player, var_3d065c4e99e3d90f, 9990 + playernum );
                    zombie thread function_cf342fd130e0e669( player, var_3d065c4e99e3d90f );
                }
                
                wait function_2445b26f09be4e27();
            }
        }
    }
    
    if ( isplayer( player ) )
    {
        player.var_b15266bb386cfb54 = 0;
    }
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0xb86d8895, Offset: 0x2cdd
// Size: 0x5a
function private function_8bfe7e8e57c53240( params )
{
    player = self.fog_player_target;
    
    if ( isalive( player ) && arraycontains( player.var_bc246b52a94a12d6, self ) )
    {
        player.var_bc246b52a94a12d6 = arrayremove( player.var_bc246b52a94a12d6, self );
    }
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0x5bf1237a, Offset: 0x2d3f
// Size: 0x1b3
function private function_427357c2880abc76( param_player )
{
    cleaned_up = 0;
    var_9a65bf1063ad8b2c = 500;
    all_ai = function_b2a68488b81704f5( 0, zm_utility::get_zombie_team() );
    ai_i = all_ai.size - 1;
    
    while ( ai_i >= 0 )
    {
        ai = all_ai[ ai_i ];
        
        if ( !isalive( ai ) )
        {
        }
        else if ( ai.spawn_source != "zm_fog" )
        {
        }
        else
        {
            fog_player = ai.fog_player_target;
            
            if ( isplayer( fog_player ) && isalive( fog_player ) )
            {
                if ( param_player && fog_player != param_player )
                {
                    goto LOC_000001a6;
                }
                
                if ( isalive( fog_player ) && !arraycontains( fog_player.var_bc246b52a94a12d6, ai ) )
                {
                    goto LOC_000001a6;
                }
                
                if ( isalive( fog_player ) && fog_player math::point_in_fov( ai.origin ) )
                {
                    goto LOC_000001a6;
                }
                
                jumpiffalse(ai cansee( fog_player )) LOC_0000010d;
            }
            else if ( ai.aicategory != "normal" )
            {
            }
            else if ( getplayersinradius( ai.origin, var_9a65bf1063ad8b2c ).size > 0 )
            {
            }
            else if ( ai utility::ent_flag( "fog_zombie_targeting_locked_on" ) )
            {
            }
            else
            {
                cleaned_up = 1;
                
                if ( isplayer( fog_player ) && isalive( fog_player ) )
                {
                    fog_player.var_bc246b52a94a12d6 = arrayremove( fog_player.var_bc246b52a94a12d6, ai );
                }
                
                level.var_acf75fdcd1a428ac = arrayremove( level.var_acf75fdcd1a428ac, ai );
                ai thread fade_out_zombie();
            LOC_000001a6:
            }
        LOC_000001a6:
        }
        
    LOC_000001a6:
        ai_i -= 1;
    }
    
    return cleaned_up;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x1e2b5633, Offset: 0x2efb
// Size: 0x22e
function fog_zone_spawn()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_b98b14292e740c();
        
        if ( !level.var_53da962cd3dd49de )
        {
            roundnumber = zm_utility::get_round_number() ?? 0;
            
            if ( level.var_acf75fdcd1a428ac.size == level.var_6ba3923a19e89944 )
            {
                function_427357c2880abc76();
            }
            
            if ( level.var_acf75fdcd1a428ac.size < level.var_6ba3923a19e89944 )
            {
                var_bc8a2fe1213d8e31 = 0;
                
                foreach ( player in level.players )
                {
                    if ( !isplayer( player ) || !player function_4c21167a2720732() )
                    {
                        waitframe();
                        continue;
                    }
                    
                    if ( !player.var_cc1677771f64fd22 )
                    {
                        player notify( #"hash_1e4c2bbe7bd9f8ad" );
                        player.var_b15266bb386cfb54 = undefined;
                        player.var_d77908f9bff4a741 = undefined;
                        waitframe();
                        continue;
                    }
                    
                    if ( player.var_cc1677771f64fd22 )
                    {
                        player thread function_32cb2ae009c469c7();
                    }
                    
                    var_84074d4e754bd382 = player vehicle::is_in_vehicle() && player.vehicle == level.wonder_veh;
                    
                    if ( var_84074d4e754bd382 )
                    {
                        if ( !level.var_28a2a48af72e277d )
                        {
                            roundnumber = zm_utility::get_round_number() ?? 0;
                            level thread fog_spawn_force_vehicle_attack( player.vehicle, roundnumber );
                            level.var_28a2a48af72e277d = 1;
                        }
                        
                        var_bc8a2fe1213d8e31++;
                    }
                }
                
                if ( level.var_28a2a48af72e277d && var_bc8a2fe1213d8e31 == 0 )
                {
                    level.var_28a2a48af72e277d = undefined;
                    level notify( #"end_spawn_force_vehicle_attack" );
                }
            }
            else
            {
                level thread function_103112daac298c03();
                
                if ( level.var_28a2a48af72e277d && level.var_3df3c5390afc7828 <= 0 )
                {
                    level.var_28a2a48af72e277d = undefined;
                    level notify( #"end_spawn_force_vehicle_attack" );
                }
            }
        }
        
        wait 0.3;
    }
}

// Namespace zm_fog_spawning
// Params 2, eflags: 0x4
// Checksum 0xc3c2084e, Offset: 0x3131
// Size: 0x246
function private fog_spawn_force_vehicle_attack( playervehicle, roundnumber )
{
    level endon( #"game_ended" );
    level endon( #"end_spawn_force_vehicle_attack" );
    
    while ( true )
    {
        var_b3e55628fbfba287 = function_ae2e848c48d8fc8d( level.var_33df283475cc8d48.var_9f65f11fc201b8c, roundnumber );
        
        if ( !level.var_33df283475cc8d48.var_66103601e7d9ca7a )
        {
            if ( !isdefined( level.var_33df283475cc8d48.var_19266cede5f63172 ) )
            {
                level.var_33df283475cc8d48.var_19266cede5f63172 = gettime();
            }
            else if ( gettime() - level.var_33df283475cc8d48.var_19266cede5f63172 > var_b3e55628fbfba287.var_7a94e6da1a1ec881 )
            {
                level.var_33df283475cc8d48.var_19266cede5f63172 = undefined;
                level.var_33df283475cc8d48.var_66103601e7d9ca7a = 1;
                
                while ( playervehicle isboosting() || !playervehicle vehicle_isonground() )
                {
                    waitframe();
                }
                
                if ( !isalive( playervehicle ) )
                {
                    level.var_28a2a48af72e277d = undefined;
                    level notify( #"end_spawn_force_vehicle_attack" );
                }
                
                function_6322e0ba380a7483( var_b3e55628fbfba287.var_3ae32e57b9c00a6, playervehicle, roundnumber );
            }
            
            waitframe();
            continue;
        }
        
        if ( !level.var_33df283475cc8d48.var_9be917f761bb167f )
        {
            if ( !isdefined( level.var_33df283475cc8d48.var_f0724c96efc82dbe ) )
            {
                level.var_33df283475cc8d48.var_f0724c96efc82dbe = gettime();
            }
            else if ( gettime() - level.var_33df283475cc8d48.var_f0724c96efc82dbe > var_b3e55628fbfba287.var_4913ffedcd8b1509 )
            {
                level.var_33df283475cc8d48.var_f0724c96efc82dbe = undefined;
                level.var_33df283475cc8d48.var_9be917f761bb167f = 1;
            }
            
            waitframe();
            continue;
        }
        
        while ( playervehicle isboosting() || !playervehicle vehicle_isonground() )
        {
            waitframe();
        }
        
        if ( !isalive( playervehicle ) )
        {
            level.var_28a2a48af72e277d = undefined;
            level notify( #"end_spawn_force_vehicle_attack" );
        }
        
        function_6322e0ba380a7483( var_b3e55628fbfba287.var_3ae32e57b9c00a6, playervehicle, roundnumber );
        level.var_33df283475cc8d48.var_9be917f761bb167f = undefined;
        waitframe();
    }
}

// Namespace zm_fog_spawning
// Params 2, eflags: 0x4
// Checksum 0xd1c38336, Offset: 0x337f
// Size: 0x11c
function private function_ae2e848c48d8fc8d( var_9dbbc6e5419aca1b, round_num )
{
    if ( isdefined( var_9dbbc6e5419aca1b ) && var_9dbbc6e5419aca1b.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = var_9dbbc6e5419aca1b.size - 1; i >= 0 ; i-- )
        {
            if ( var_9dbbc6e5419aca1b[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:x163>" );
                return spawnstruct();
            }
            
            if ( round_num >= var_9dbbc6e5419aca1b[ i ].startround )
            {
                var_c423ecf51786bbdd = spawnstruct();
                var_c423ecf51786bbdd.var_3ae32e57b9c00a6 = var_9dbbc6e5419aca1b[ i ].var_3ae32e57b9c00a6;
                var_c423ecf51786bbdd.var_7a94e6da1a1ec881 = utility::function_4b74c15943231980( var_9dbbc6e5419aca1b[ i ].var_3e5fa730ed9971b5 );
                var_c423ecf51786bbdd.var_4913ffedcd8b1509 = utility::function_4b74c15943231980( var_9dbbc6e5419aca1b[ i ].var_c42eea222163598d );
                return var_c423ecf51786bbdd;
            }
            
            var_78a63f139cf07707 = var_9dbbc6e5419aca1b[ i ].startround;
        }
    }
    
    assert( "<dev string:x1d8>" + round_num + "<dev string:x239>" );
    return spawnstruct();
}

// Namespace zm_fog_spawning
// Params 3, eflags: 0x4
// Checksum 0x488d473e, Offset: 0x34a4
// Size: 0xa9
function private function_6322e0ba380a7483( var_3ae32e57b9c00a6, targetvehicle, roundnumber )
{
    level endon( #"game_ended" );
    level endon( #"end_spawn_force_vehicle_attack" );
    
    for ( i = 0; i < var_3ae32e57b9c00a6 ; i++ )
    {
        var_77b5dd39ae4361ae = zombie_vehicle_attack::function_cf284e8470c97328( targetvehicle );
        
        if ( isdefined( var_77b5dd39ae4361ae ) )
        {
            var_50e48382a36fbea8 = zm_utility::function_2453a16ad4a092f8( 1 );
            
            if ( var_50e48382a36fbea8 > 0 )
            {
                zm_utility::function_922d522db5f1ceda( var_50e48382a36fbea8, [ "normal" ] );
            }
            else
            {
                function_715c033160dcfe19( roundnumber, targetvehicle, var_77b5dd39ae4361ae );
            }
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_fog_spawning
// Params 3, eflags: 0x4
// Checksum 0x32cc0411, Offset: 0x3555
// Size: 0x78
function private function_715c033160dcfe19( roundnumber, targetvehicle, var_77b5dd39ae4361ae )
{
    zombie_shade = agent_manager::spawn_agent( "zombie_shade", var_77b5dd39ae4361ae.origin, var_77b5dd39ae4361ae.angles );
    
    if ( isdefined( zombie_shade ) )
    {
        zombie_shade.disable_spawn_vfx = 1;
        zombie_shade function_9a995013fac442fb( targetvehicle, var_77b5dd39ae4361ae.var_309a32167a388a30, roundnumber );
    }
    
    return zombie_shade;
}

// Namespace zm_fog_spawning
// Params 3, eflags: 0x4
// Checksum 0x3797fdc3, Offset: 0x35d6
// Size: 0xe0
function private function_9a995013fac442fb( targetvehicle, var_309a32167a388a30, roundnumber )
{
    self endon( #"death" );
    zombie_vehicle_attack::function_b2f3f65e87ad25af( targetvehicle, var_309a32167a388a30, 1 );
    var_425432f596361c14 = utility::function_e2baa5896d5756cc( [ "force_vehicle_attack_succeed", "force_vehicle_attack_failed" ] );
    
    if ( var_425432f596361c14 == "force_vehicle_attack_succeed" )
    {
        var_ddcd528f17b47db9 = spawnscriptable( "scriptable_zombie_shade_teleport_portal", self.origin, self.angles );
        var_ddcd528f17b47db9 thread function_7a58e041f6990a57();
        function_d0ea7a60d10fde40( roundnumber );
        self.var_18ea265b7a092c4c = 1;
        thread function_df6302808f4c272b();
        return;
    }
    
    self.nocorpse = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_66504c8a8a5ed6dd = 1;
    self hide();
    self kill();
    return;
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0x49f17a9e, Offset: 0x36be
// Size: 0x38
function private function_7a58e041f6990a57()
{
    self endon( #"death" );
    var_f69727fd3a663df2 = 2;
    self setscriptablepartstate( "portal", "portal" );
    wait var_f69727fd3a663df2;
    self freescriptable();
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0x61c7e29f, Offset: 0x36fe
// Size: 0xc8
function private function_df6302808f4c272b()
{
    self endon( #"death" );
    var_e1c036608aaeb7f3 = 8;
    var_4a550cc473ddd684 = utility::waittill_any_in_array_or_timeout( [ "vehicle_attack_latch_linkto_start", "vehicle_attack_collided_with_vehicle" ], var_e1c036608aaeb7f3 );
    
    switch ( var_4a550cc473ddd684 )
    {
        case #"hash_4410c491ffca20ec":
            self waittill( #"vehicle_attack_end" );
            self.var_18ea265b7a092c4c = undefined;
            break;
        case #"hash_200e496ae186e1ff":
            var_e44a449c8986e1be = 10;
            utility::waittill_any_timeout( var_e44a449c8986e1be, "knockdown_end", "cannonball_end" );
            self.var_18ea265b7a092c4c = undefined;
            break;
        default:
            self.var_18ea265b7a092c4c = undefined;
            break;
    }
}

// Namespace zm_fog_spawning
// Params 2, eflags: 0x4
// Checksum 0xb2f6f141, Offset: 0x37ce
// Size: 0x140
function private function_cf342fd130e0e669( player, var_3d065c4e99e3d90f )
{
    self endon( #"death" );
    utility::ent_flag_set( "fog_zombie_targeting_locked_on" );
    var_8c1253a786425eda = 0;
    var_8cc436327b06e5e0 = 0;
    
    while ( isalive( player ) && !var_8c1253a786425eda && !var_8cc436327b06e5e0 )
    {
        distance = distance2dsquared( self.origin, player.origin );
        
        if ( distance < 65536 )
        {
            var_8c1253a786425eda = 1;
        }
        
        nearby_players = getplayersinradius( self.origin, 512 );
        
        if ( nearby_players.size > 0 )
        {
            foreach ( player in nearby_players )
            {
                if ( player.vehicle )
                {
                    var_8cc436327b06e5e0 = 1;
                    break;
                }
            }
        }
        
        wait 1;
    }
    
    utility::ent_flag_clear( "fog_zombie_targeting_locked_on" );
    zombie_utils::set_ai_target_priority( undefined, var_3d065c4e99e3d90f, 0 );
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0xa66b7e3e, Offset: 0x3916
// Size: 0x11f
function private get_spawn_division()
{
    spawn_division = {};
    spawn_division.division = 4;
    spawn_division.near = 2;
    spawn_division.far = 2;
    roundnumber = zm_utility::get_round_number() ?? 0;
    
    if ( roundnumber <= level.var_33df283475cc8d48.var_cdf6bd139cc24ebf )
    {
        spawn_division.division = 4;
        spawn_division.near = 2;
        spawn_division.far = 2;
    }
    else if ( roundnumber > level.var_33df283475cc8d48.var_cdf6bd139cc24ebf && roundnumber <= level.var_33df283475cc8d48.var_3f7ee98d2ac9c3a )
    {
        spawn_division.division = 3;
        spawn_division.near = 2;
        spawn_division.far = 1;
    }
    else
    {
        spawn_division.division = 3;
        spawn_division.near = 1;
        spawn_division.far = 2;
    }
    
    return spawn_division;
}

// Namespace zm_fog_spawning
// Params 0, eflags: 0x4
// Checksum 0xe2ac34a7, Offset: 0x3a3e
// Size: 0x1ef
function private function_2445b26f09be4e27()
{
    delay = 1.3;
    roundnumber = zm_utility::get_round_number() ?? 0;
    
    if ( roundnumber <= level.var_33df283475cc8d48.var_cdf6bd139cc24ebf )
    {
        if ( isdefined( level.players ) )
        {
            switch ( level.players.size )
            {
                case 1:
                    delay = 1.3;
                case 2:
                    delay = 1.2;
                case 3:
                    delay = 1.1;
                case 4:
                    delay = 1;
                default:
                    delay = 1;
                    break;
            }
        }
    }
    else if ( roundnumber > level.var_33df283475cc8d48.var_cdf6bd139cc24ebf && roundnumber <= level.var_33df283475cc8d48.var_3f7ee98d2ac9c3a )
    {
        if ( isdefined( level.players ) )
        {
            switch ( level.players.size )
            {
                case 1:
                    delay = 1.1;
                case 2:
                    delay = 1.1;
                case 3:
                    delay = 0.9;
                case 4:
                    delay = 0.8;
                default:
                    delay = 0.8;
                    break;
            }
        }
    }
    else if ( isdefined( level.players ) )
    {
        switch ( level.players.size )
        {
            case 1:
                delay = 0.9;
            case 2:
                delay = 0.9;
            case 3:
                delay = 0.7;
            case 4:
                delay = 0.7;
            default:
                delay = 0.7;
                break;
        }
    }
    
    return delay;
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0x3e9e11f, Offset: 0x3c36
// Size: 0xa9
function private function_643e46b85e211959( roundnumber )
{
    if ( roundnumber <= level.var_33df283475cc8d48.var_cdf6bd139cc24ebf )
    {
        return ( level.var_33df283475cc8d48.var_2a7d53f814e12f20 ?? 5 );
    }
    
    if ( roundnumber > level.var_33df283475cc8d48.var_cdf6bd139cc24ebf && roundnumber <= level.var_33df283475cc8d48.var_3f7ee98d2ac9c3a )
    {
        return ( level.var_33df283475cc8d48.var_d447ee2d3c54c9e5 ?? 5 );
    }
    
    return level.var_33df283475cc8d48.var_3cbfcbec3f4cf70d ?? 5;
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0x97742678, Offset: 0x3ce7
// Size: 0x33, Type: bool
function get_zone_is_fog( zone )
{
    if ( !zone.is_enabled )
    {
        return false;
    }
    
    return istrue( level.var_25223259f9cd6017[ zone.zone_name ] );
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0xc2cef47e, Offset: 0x3d23
// Size: 0x40, Type: bool
function private function_ef4f01ab7c2806e0( zombie )
{
    if ( isdefined( zombie ) && ( zombie.aicategory == "special" || zombie.aicategory == "elite" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0xc23d418a, Offset: 0x3d6c
// Size: 0xce
function spawn_fog_zombie( params )
{
    var_395649a1ecde9e39 = zone_spawner::function_20c574a6ba7cc5c6( params.zones[ 0 ].script_zone_name, params.var_3573d08ca4a0010a );
    spawn_loc = get_spawn_loc_from_array( var_395649a1ecde9e39 );
    
    if ( !isdefined( spawn_loc ) )
    {
        return;
    }
    
    /#
    #/
    
    spawn_pos = spawn_loc.origin;
    
    if ( !isdefined( spawn_loc.script_animation ) )
    {
        spawn_pos = getgroundposition( spawn_loc.origin, 32 );
    }
    
    zombie = agent_manager::spawn_agent( params.var_3573d08ca4a0010a, spawn_pos );
    
    if ( isdefined( zombie ) )
    {
        zombie function_d0ea7a60d10fde40( params.roundnumber );
    }
    
    return zombie;
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0x42bf0b9f, Offset: 0x3e43
// Size: 0x308
function private function_d0ea7a60d10fde40( roundnumber )
{
    utility::function_7c10ea82c1e305b8( "simple_dissolve", "hide_immediately" );
    utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_in" );
    utility::function_7c10ea82c1e305b8( "base", "base_off" );
    utility::function_7c10ea82c1e305b8( "fog", "on" );
    self.var_a13bed1ac47e1b2c = 1;
    self.var_66504c8a8a5ed6dd = 1;
    self.spawn_source = "zm_fog";
    self.var_e797f68de73ece4e = "_fog";
    var_19fc2c76bdfe8af9 = function_643e46b85e211959( roundnumber );
    zombie_utils::set_zombie_round_difficulty( roundnumber + var_19fc2c76bdfe8af9 );
    val::set( "fog_zombie", "allow_dismember", 0 );
    self.var_e6f66612af155250 = "none";
    self.no_powerups = 1;
    self.ignore_enemy_count = 1;
    self.b_ignore_cleanup = 1;
    self.var_698cf8d8d4a8cbb9 = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.nodamagenumbers = 1;
    val::set( "fog_zombie_ai_type", "show_healthbar", 0 );
    self.var_4ffaa2be1f30674d = "fog_despawn_fx";
    level.var_acf75fdcd1a428ac[ level.var_acf75fdcd1a428ac.size ] = self;
    
    if ( function_ef4f01ab7c2806e0( self ) )
    {
        supersprintchance = level.var_33df283475cc8d48.var_30990782d6918dde ?? 0.85;
        supersprintchance *= 100;
        
        if ( utility::percent_chance( supersprintchance ) )
        {
            zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "super_sprint" == "super_sprint" || "super_sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "super_sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "super_sprint" == "sprint" ? "run" : "super_sprint", "fog_spawn", 7 );
            return;
        }
        
        zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "fog_spawn", 7 );
    }
}

// Namespace zm_fog_spawning
// Params 1, eflags: 0x4
// Checksum 0x91b5bd9, Offset: 0x4153
// Size: 0x62
function private get_spawn_loc_from_array( var_395649a1ecde9e39 )
{
    sorted_spawn_locs = arraysort( var_395649a1ecde9e39, undefined, &function_676b44ea8d2b4ac2, 1 );
    top_x_num = min( 3, sorted_spawn_locs.size );
    valid_spawn_locs = utility::array_slice( sorted_spawn_locs, 0, top_x_num );
    chosen_spawn_loc = utility::array_random( valid_spawn_locs );
    return chosen_spawn_loc;
}

// Namespace zm_fog_spawning
// Params 3, eflags: 0x4
// Checksum 0x52d6c63a, Offset: 0x41be
// Size: 0x3d, Type: bool
function private function_676b44ea8d2b4ac2( spawn_loc_a, spawn_loc_b, key )
{
    return getinfluencedistanceatposition( spawn_loc_a.origin ) > getinfluencedistanceatposition( spawn_loc_b.origin );
}

// Namespace zm_fog_spawning
// Params 2, eflags: 0x4
// Checksum 0x12a4fa6c, Offset: 0x4204
// Size: 0xec, Type: bool
function private function_8f5f58bdd9e44f42( zone, aisubclass )
{
    if ( !zone.is_enabled )
    {
        return false;
    }
    
    recommended_aitype = function_b3988325430ce242( aisubclass );
    zone_spawn_locs = level.var_1d03be60f0a95b1c[ zone.script_zone_name ];
    
    if ( isdefined( zone_spawn_locs ) )
    {
        foreach ( zone_spawn in zone_spawn_locs )
        {
            if ( isdefined( zone_spawn.ai_subclasses ) && arraycontains( zone_spawn.ai_subclasses, aisubclass ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_fog_spawning
// Params 3, eflags: 0x4
// Checksum 0x311329ad, Offset: 0x42f9
// Size: 0x18d
function private function_40be4efa9ac54eea( player, var_77898ab40e53d0ae, aitype )
{
    if ( !isdefined( var_77898ab40e53d0ae ) )
    {
        return [];
    }
    
    zones = [];
    
    if ( level.var_6b18903c77120093[ var_77898ab40e53d0ae.script_zone_name ] )
    {
        zone = zone_manager::get_zone_struct( level.var_6b18903c77120093[ var_77898ab40e53d0ae.script_zone_name ] );
        zones[ 0 ] = zone;
    }
    else if ( isdefined( player.var_d77908f9bff4a741.zone_name ) && level.var_4a887a52ed954e2f[ var_77898ab40e53d0ae.script_zone_name ] )
    {
        if ( level.var_4a887a52ed954e2f[ var_77898ab40e53d0ae.script_zone_name ].var_dfb5dd9d49225714 == player.var_d77908f9bff4a741.zone_name )
        {
            zone = zone_manager::get_zone_struct( level.var_4a887a52ed954e2f[ var_77898ab40e53d0ae.script_zone_name ].var_dfb5e09d49225dad );
            zones[ 0 ] = zone;
        }
        else if ( level.var_4a887a52ed954e2f[ var_77898ab40e53d0ae.script_zone_name ].var_dfb5e09d49225dad == player.var_d77908f9bff4a741.zone_name )
        {
            zone = zone_manager::get_zone_struct( level.var_4a887a52ed954e2f[ var_77898ab40e53d0ae.script_zone_name ].var_dfb5dd9d49225714 );
            zones[ 0 ] = zone;
        }
        else
        {
            zones[ 0 ] = var_77898ab40e53d0ae;
        }
    }
    else
    {
        zones[ 0 ] = var_77898ab40e53d0ae;
    }
    
    return zones;
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0x7e787265, Offset: 0x448f
// Size: 0xdf
function function_f2d209a487ecb966()
{
    self endon( #"death" );
    
    if ( !self.var_bd3832dce50941ae )
    {
        self.var_bd3832dce50941ae = 1;
        callback::callback( "fog_zombie_killed_by_player" );
        self.var_eb92c31552620100 = 1;
        val::set( "fog_zombie_shield", "damageshield", 1 );
        self function_e8726d980fa12944();
        utility::function_7c10ea82c1e305b8( "base", "base_off" );
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        utility::function_7c10ea82c1e305b8( "fog", "despawn" );
        thread function_a92715d9ef8eeb80();
        effect_slow::slow( "fog", 0.01, 100 );
        wait 2;
        self.nocorpse = 1;
        self.death_source = "zm_fog";
        waitframe();
        
        if ( isalive( self ) )
        {
            val::reset( "fog_zombie_shield", "damageshield" );
            self kill();
        }
    }
}

// Namespace zm_fog_spawning
// Params 0
// Checksum 0xce084372, Offset: 0x4576
// Size: 0xb2
function function_a92715d9ef8eeb80()
{
    self endon( #"death" );
    var_1dadec86cf0cbb73 = utility::ent_flag( "cryofreeze_active" ) || status_effects::has_status_effect_type( "frost_blast" ) || status_effects::has_status_effect_type( "frost_blast_frozen" );
    b_burn = status_effects::has_status_effect_type( "burn" );
    
    if ( var_1dadec86cf0cbb73 )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "frozen", "frozen_off" );
        utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_shatter" );
    }
    
    if ( b_burn )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace zm_fog_spawning
// Params 2
// Checksum 0xd09e55a8, Offset: 0x4630
// Size: 0x7b
function function_1e8899d39d482165( var_1dadec86cf0cbb73, b_burn )
{
    self endon( #"death" );
    
    if ( var_1dadec86cf0cbb73 )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "frozen", "frozen_off" );
        utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_shatter" );
    }
    
    if ( b_burn )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
        utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
    }
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0x63c06c00, Offset: 0x46b3
// Size: 0x83
function function_c0265dfc63b0b561( params )
{
    damage = params.idamage;
    
    if ( self.var_698cf8d8d4a8cbb9 )
    {
        if ( damage >= self.health && ( params.smeansofdeath == "MOD_RIFLE_BULLET" || params.smeansofdeath == "MOD_PISTOL_BULLET" ) )
        {
            if ( self.aicategory != "elite" )
            {
                function_f2d209a487ecb966();
            }
        }
    }
    
    return damage;
}

// Namespace zm_fog_spawning
// Params 1
// Checksum 0xfa50ccfc, Offset: 0x473f
// Size: 0x18b
function function_2ee77690444312b1( params )
{
    if ( self.var_698cf8d8d4a8cbb9 && !self.var_bd3832dce50941ae )
    {
        var_b827ee4c8811b820 = params.smeansofdeath == "MOD_RIFLE_BULLET" || params.smeansofdeath == "MOD_PISTOL_BULLET";
        var_db5ca57fdb9ad1bb = params.smeansofdeath == "MOD_CRUSH";
        var_1e4ad27b99e0c182 = self.aicategory == "elite";
        var_1dadec86cf0cbb73 = utility::ent_flag( "cryofreeze_active" ) || status_effects::has_status_effect_type( "frost_blast" ) || status_effects::has_status_effect_type( "frost_blast_frozen" ) || utility::ent_flag( "frost_killed" ) || self.var_e797f68de73ece4e == "_cfreeze" || self.var_bb4d607514eb37ce == "_cfreeze";
        b_burn = utility::ent_flag( "burned" ) || utility::ent_flag( "napalm_burned" ) || status_effects::has_status_effect_type( "burn" ) || self.var_e797f68de73ece4e == "_nburst" || self.var_bb4d607514eb37ce == "_nburst";
        var_24ed309d808c077a = self getcorpseentity();
        waitframe();
        
        if ( var_24ed309d808c077a )
        {
            var_24ed309d808c077a utility::function_7c10ea82c1e305b8( "fog", "off" );
            var_24ed309d808c077a thread function_1e8899d39d482165( var_1dadec86cf0cbb73, b_burn );
            var_24ed309d808c077a thread function_6f62f26ad68bc39c( var_1e4ad27b99e0c182, var_db5ca57fdb9ad1bb );
        }
    }
}

// Namespace zm_fog_spawning
// Params 2
// Checksum 0x1d9175bc, Offset: 0x48d2
// Size: 0xf9
function function_6f62f26ad68bc39c( belite, var_d81403d4f823d197 )
{
    self notify( #"hash_4d255f9dd7e2ad29" );
    self endon( #"hash_4d255f9dd7e2ad29" );
    self endon( #"corpse_deleted" );
    
    if ( belite )
    {
        callback::callback( "fog_zombie_killed_by_player" );
        wait 0.5;
    }
    else if ( var_d81403d4f823d197 )
    {
        random_wait = randomfloatrange( 1.25, 1.5 );
        wait random_wait;
    }
    else
    {
        random_wait = randomfloatrange( 0.35, 0.75 );
        wait random_wait;
    }
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "base", "base_off" );
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        
        if ( belite )
        {
            utility::function_7c10ea82c1e305b8( "fog", "despawn" );
            wait 0.8;
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "fog", "despawn" );
            wait 0.6;
        }
        
        if ( isdefined( self ) )
        {
            wait 0.25;
            self hide();
        }
    }
}

/#

    // Namespace zm_fog_spawning
    // Params 1
    // Checksum 0xa5ed2e61, Offset: 0x49d3
    // Size: 0x68, Type: dev
    function function_1fe3ea3a00460033( aisubclass )
    {
        spawn_pos = level.players[ 0 ].origin;
        roundnumber = zm_utility::get_round_number() ?? 1;
        zombie = agent_manager::spawn_agent( aisubclass, spawn_pos );
        
        if ( isdefined( zombie ) )
        {
            zombie function_d0ea7a60d10fde40( roundnumber );
        }
    }

    // Namespace zm_fog_spawning
    // Params 1
    // Checksum 0xa87ffc13, Offset: 0x4a43
    // Size: 0x63, Type: dev
    function debug_spawn_fog_zombie( params )
    {
        zombietype = params[ 0 ];
        
        if ( zombietype == "<dev string:x259>" )
        {
            function_1fe3ea3a00460033( "<dev string:x25e>" );
        }
        
        if ( zombietype == "<dev string:x26a>" )
        {
            function_1fe3ea3a00460033( "<dev string:x270>" );
        }
        
        if ( zombietype == "<dev string:x27d>" )
        {
            function_1fe3ea3a00460033( "<dev string:x283>" );
        }
    }

    // Namespace zm_fog_spawning
    // Params 0
    // Checksum 0x4724787c, Offset: 0x4aae
    // Size: 0x87, Type: dev
    function init_zm_fog_devgui()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x293>" );
        devgui::add_devgui_func( "<dev string:x2a4>", "<dev string:x2b8>", &function_4285a31a1f86d61b );
        devgui::add_devgui_func( "<dev string:x2cc>", "<dev string:x2eb>", &function_a7e26ca28dc082d0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x30a>", "<dev string:x320>", &debug_spawn_fog_zombie );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33c>", "<dev string:x353>", &debug_spawn_fog_zombie );
        devgui::function_cd4e263c1f3018ae( "<dev string:x370>", "<dev string:x387>", &debug_spawn_fog_zombie );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_fog_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x1ffd1fb0, Offset: 0x4b3d
    // Size: 0x29, Type: dev
    function private function_a7e26ca28dc082d0()
    {
        if ( level.var_d27888beb5b5ba83 )
        {
            level.var_d27888beb5b5ba83 = 0;
            return;
        }
        
        level.var_d27888beb5b5ba83 = 1;
    }

    // Namespace zm_fog_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x5451b8c4, Offset: 0x4b6e
    // Size: 0x29, Type: dev
    function private function_4285a31a1f86d61b()
    {
        if ( level.var_53da962cd3dd49de )
        {
            level.var_53da962cd3dd49de = 0;
            return;
        }
        
        level.var_53da962cd3dd49de = 1;
    }

#/
