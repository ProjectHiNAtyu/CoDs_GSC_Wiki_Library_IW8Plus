// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_slorpy_quest.gsc  (hash_7eaa818d92881072.gscc) (size: 24808 Bytes / 0x60e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93415394 (2470531988)
// size ...... 24808 (0x60e8)
// includes .. 14  (offset: 0x5614)
// strings ... 112 (offset: 0x5684)
// dev strs .. 76  (offset: 0x5d08)
// exports ... 39  (offset: 0x4024)
// cseg ...... 0xb07 + 0x351d (0x4024)
// imports ... 115 (offset: 0x463c)
// animtree1 . 0   (offset: 0x60e8)
// animtree2 . 0   (offset: 0x60e8)
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_firefly_slorpy_quest;

// Namespace zm_sat_firefly_slorpy_quest
// Params 0, eflags: 0x5
// Checksum 0xbb6b929e, Offset: 0xb25
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_slorpy_ee", undefined, undefined, &post_main );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0
// Checksum 0x247c311f, Offset: 0xb46
// Size: 0x51
function post_main()
{
    level utility::flag_wait( "zm_sat_firefly_script_slorpy_quest_cs_completed" );
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        logstring( "[ZM Firefly Slorpy EE DEBUG] : Return - not enable in survival mode " );
        return;
    }
    
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        level setup_all_ingredients( 0 );
        logstring( "[ZM Firefly Slorpy EE DEBUG] : not enable_firefly_ee " );
        return;
    }
    
    level thread setup_slorpy_quest();
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0, eflags: 0x4
// Checksum 0x10551904, Offset: 0xb9f
// Size: 0x293
function private setup_slorpy_quest()
{
    level endon( #"game_ended" );
    
    /#
        level thread init_debug();
    #/
    
    level._effect[ "soda_spawn_faucet" ] = loadfxasset( "vfx_sat_levels_zm_firefly_ee_soda_spawn_faucet" );
    level utility::flag_wait( "begin_round_logic" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_2081cc64ead887db" ) == 1 )
    {
        level.players[ 0 ].var_9cbdd70caf571160 = 0;
        level.players[ 0 ].var_17569d43ee1098e7 = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.slorpy_ingredients ) )
        {
            player.slorpy_ingredients = [];
        }
        
        if ( !isdefined( player.var_17569d43ee1098e7 ) )
        {
            player.var_17569d43ee1098e7 = 1;
        }
        
        if ( !isdefined( player.var_9cbdd70caf571160 ) )
        {
            player.var_9cbdd70caf571160 = 1;
        }
        
        if ( !isdefined( player.var_94aa0893ed1e7d7b ) )
        {
            player.var_94aa0893ed1e7d7b = [];
        }
    }
    
    var_d5d3d603929c817a = utility::getstructarray( "sq_slorpy_cup_loc", "targetname" );
    level.var_74f8d403aa817cfe = arraysort( var_d5d3d603929c817a, undefined, &function_3ac8f69a6ccd0c83 );
    soda_fountain = getent( "slorpy_soda_fountain", "script_noteworthy" );
    level.soda_fountain = [];
    level.soda_fountain[ "tag_juice_1" ] = soda_fountain gettagorigin( "tag_juice_1" );
    level.soda_fountain[ "tag_juice_2" ] = soda_fountain gettagorigin( "tag_juice_2" );
    level.soda_fountain[ "tag_juice_3" ] = soda_fountain gettagorigin( "tag_juice_3" );
    level.soda_fountain[ "tag_juice_4" ] = soda_fountain gettagorigin( "tag_juice_4" );
    level.var_d9baa2f7feaa2ec = spawn( "script_model", soda_fountain.origin, 0 );
    soda_fountain delete();
    level thread setup_slorpy_machine();
    level setup_all_ingredients();
    level callback::add( #"player_spawned", &on_player_hotjoin );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    scriptable::scriptable_adddamagedcallback( &function_89761752e30bf577 );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2, eflags: 0x4
// Checksum 0xe621a31, Offset: 0xe3a
// Size: 0x3b, Type: bool
function private function_3ac8f69a6ccd0c83( a_cup, b_cup )
{
    if ( int( a_cup.script_parameters ) < int( b_cup.script_parameters ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1, eflags: 0x4
// Checksum 0x158129cc, Offset: 0xe7e
// Size: 0x148
function private on_player_hotjoin( params )
{
    player = self;
    setup_all_ingredients();
    logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_player_hotjoin] - Player: " + player.name + " setup_all_ingredients " );
    
    foreach ( s_cup_loc in level.var_74f8d403aa817cfe )
    {
        if ( s_cup_loc.cup && s_cup_loc.cup.owningplayer )
        {
            continue;
        }
        
        cup = spawn_soda_cup( player, s_cup_loc );
        
        if ( s_cup_loc.interact )
        {
            s_cup_loc.interact.cup = cup;
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_player_hotjoin] - Player: " + player.name + " allocated interaction " );
        }
        
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_player_hotjoin] - Player: " + player.name + " spawn_soda_cup " );
        break;
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0x1de44596, Offset: 0xfce
// Size: 0x10b
function on_player_disconnect( params )
{
    logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_player_disconnect] - Player: " + self.name + " disconnected " );
    
    foreach ( s_cup_loc in level.var_74f8d403aa817cfe )
    {
        if ( s_cup_loc.cup && s_cup_loc.cup.owningplayer == self )
        {
            s_cup_loc.cup freescriptable();
            s_cup_loc.cup = undefined;
            s_cup_loc.interact.canuse = 0;
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_player_disconnect] - Player: " + self.name + " removed cup " );
        }
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 11
// Checksum 0x25126bc7, Offset: 0x10e1
// Size: 0x17a
function function_89761752e30bf577( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_firefly_slorpy_cup" )
    {
        return;
    }
    
    if ( instance.var_12b8037df7d89857 || !instance.full )
    {
        return;
    }
    
    if ( isplayer( eattacker ) && eattacker == instance.owningplayer )
    {
        if ( smeansofdeath == "MOD_MELEE" )
        {
            foreach ( player in level.players )
            {
                instance.interact thread function_3e0b22996f87d303( player, instance.perk, eattacker );
            }
        }
        
        waitframe();
        
        if ( instance )
        {
            instance freescriptable();
        }
        
        level.slorpy_cups = arrayremove( level.slorpy_cups, instance );
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1, eflags: 0x4
// Checksum 0x6612bc62, Offset: 0x1263
// Size: 0x7aa
function private setup_all_ingredients( var_7cc8750aa7cac27b = 1 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player.slorpy_spawned_ingredient )
        {
            player.slorpy_spawned_ingredient = [];
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_ingredient] - Player: " + player.name + " slorpy_spawned_ingredient" );
            
            if ( !isdefined( player.slorpy_ingredients ) )
            {
                player.slorpy_ingredients = [];
            }
            
            if ( !isdefined( player.var_17569d43ee1098e7 ) )
            {
                player.var_17569d43ee1098e7 = 1;
            }
            
            if ( !isdefined( player.var_9cbdd70caf571160 ) )
            {
                player.var_9cbdd70caf571160 = 1;
            }
            
            if ( !isdefined( player.var_94aa0893ed1e7d7b ) )
            {
                player.var_94aa0893ed1e7d7b = [];
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_d6ba6d8405078caa" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "old_milk";
            }
            else
            {
                var_c6ece209ff5a563b = level spawn_ingredient( "sq_slorpy_old_milk_locs", "zm_sat_firefly_slorpy_old_milk", "old_milk", "uin_zm_common_pickup_item_bottle", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_bc15787442b9d885" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "eggs";
            }
            else
            {
                var_1318284425848970 = level spawn_ingredient( "sq_slorpy_eggs_locs", "zm_sat_firefly_slorpy_eggs", "eggs", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_e801c490a555b3f" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "weeds";
            }
            else
            {
                var_fd6789227790f6d4 = level spawn_ingredient( "sq_slorpy_weeds_locs", "zm_sat_firefly_slorpy_weeds", "weeds", "uin_zm_common_pickup_item", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_9bc74b575b74526f" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "sugar";
            }
            else
            {
                var_6d1aeb93efe14296 = level spawn_ingredient( "sq_slorpy_sugar_locs", "zm_sat_firefly_slorpy_sugar", "sugar", "uin_zm_common_pickup_item", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_318ac2365f7ee7d4" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "peppers";
            }
            else
            {
                var_9731082529f7c62b = level spawn_ingredient( "sq_slorpy_peppers_locs", "zm_sat_firefly_slorpy_peppers", "peppers", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_5ce662de54b75c95" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "berries";
            }
            else
            {
                var_a850a3e9910b7ab2 = level spawn_ingredient( "sq_slorpy_berries_locs", "zm_sat_firefly_slorpy_berries", "berries", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_acd0737e2d8b4938" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "gas";
            }
            else
            {
                var_2c6ee95c56c1231b = level spawn_ingredient( "sq_slorpy_gas_locs", "zm_sat_firefly_slorpy_gas", "gas", "uin_zm_common_pickup_item_bottle", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_17a60a55e79f085f" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "lemons";
            }
            else
            {
                var_686a0f04059d0c6e = level spawn_ingredient( "sq_slorpy_lemons_locs", "zm_sat_firefly_slorpy_lemons", "lemons", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_c7ace54ff4cb1976" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "beans";
            }
            else
            {
                var_7958aa9e2856bb6d = level spawn_ingredient( "sq_slorpy_beans_locs", "zm_sat_firefly_slorpy_beans", "beans", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_24dcb96d13c50b05" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "fish";
            }
            else
            {
                var_53aedef5d3c037f4 = level spawn_ingredient( "sq_slorpy_fish_locs", "zm_sat_firefly_slorpy_fish", "fish", "uin_zm_common_pickup_item_important", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_fab1d40db870ea52" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "stim";
            }
            else
            {
                var_e9690b3e7b98010b = level spawn_ingredient( "sq_slorpy_stim_locs", "zm_sat_firefly_slorpy_stim", "stim", "uin_zm_common_pickup_item", var_7cc8750aa7cac27b );
            }
            
            if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_b0fd48b1078f21b9" ) == 1 )
            {
                player.slorpy_ingredients[ player.slorpy_ingredients.size ] = "toliet_cleaner";
            }
            else
            {
                var_87d4a55283da29b4 = level spawn_ingredient( "sq_slorpy_toliet_cleaner_locs", "zm_sat_firefly_slorpy_toliet_cleaner", "toliet_cleaner", "uin_zm_common_pickup_item", var_7cc8750aa7cac27b );
            }
            
            if ( getdvarint( @"hash_2e4d13950c7083bd", 0 ) )
            {
                /#
                    if ( var_c6ece209ff5a563b )
                    {
                        var_c6ece209ff5a563b thread drawsphere( ( 1, 0, 0 ), "<dev string:x24>" );
                    }
                    
                    if ( var_1318284425848970 )
                    {
                        var_1318284425848970 thread drawsphere( ( 1, 0, 0 ), "<dev string:x2d>" );
                    }
                    
                    if ( var_fd6789227790f6d4 )
                    {
                        var_fd6789227790f6d4 thread drawsphere( ( 1, 0, 0 ), "<dev string:x32>" );
                    }
                    
                    if ( var_6d1aeb93efe14296 )
                    {
                        var_6d1aeb93efe14296 thread drawsphere( ( 0, 1, 0 ), "<dev string:x38>" );
                    }
                    
                    if ( var_9731082529f7c62b )
                    {
                        var_9731082529f7c62b thread drawsphere( ( 0, 1, 0 ), "<dev string:x43>" );
                    }
                    
                    if ( var_a850a3e9910b7ab2 )
                    {
                        var_a850a3e9910b7ab2 thread drawsphere( ( 0, 1, 0 ), "<dev string:x4b>" );
                    }
                    
                    if ( var_2c6ee95c56c1231b )
                    {
                        var_2c6ee95c56c1231b thread drawsphere( ( 1, 1, 0 ), "<dev string:x53>" );
                    }
                    
                    if ( var_686a0f04059d0c6e )
                    {
                        var_686a0f04059d0c6e thread drawsphere( ( 1, 1, 0 ), "<dev string:x57>" );
                    }
                    
                    if ( var_7958aa9e2856bb6d )
                    {
                        var_7958aa9e2856bb6d thread drawsphere( ( 1, 1, 0 ), "<dev string:x5e>" );
                    }
                    
                    if ( var_53aedef5d3c037f4 )
                    {
                        var_53aedef5d3c037f4 thread drawsphere( ( 0, 0, 1 ), "<dev string:x64>" );
                    }
                    
                    if ( var_e9690b3e7b98010b )
                    {
                        var_e9690b3e7b98010b thread drawsphere( ( 0, 0, 1 ), "<dev string:x69>" );
                    }
                    
                    if ( var_87d4a55283da29b4 )
                    {
                        var_87d4a55283da29b4 thread drawsphere( ( 0, 0, 1 ), "<dev string:x6e>" );
                    }
                #/
            }
        }
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 5, eflags: 0x4
// Checksum 0xfb50580d, Offset: 0x1a15
// Size: 0x403
function private spawn_ingredient( struct, mdl, ingredient_name, sound, var_7cc8750aa7cac27b = 1 )
{
    profilestart();
    s_item_spawn = utility::getstruct( struct, "targetname" );
    sa_item_spawn = utility::getstructarray( s_item_spawn.target, "targetname" );
    s_item_spawn_loc = utility::array_random( sa_item_spawn );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.slorpy_spawned_ingredient[ ingredient_name ] )
        {
            continue;
        }
        
        team_select_payload = [ #"teamselect", player getentitynumber() ];
        item = spawnscriptable( mdl, s_item_spawn_loc.origin, s_item_spawn_loc.angles, undefined, team_select_payload );
        item.var_7a65426f252841e7 = 1;
        item.owningplayer = player;
        player.slorpy_spawned_ingredient[ ingredient_name ] = 1;
        
        if ( !var_7cc8750aa7cac27b )
        {
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_ingredient] - Player: " + player.name + " only spawned " + ingredient_name );
            profilestop();
            return s_item_spawn_loc;
        }
        
        if ( !s_item_spawn_loc.interact )
        {
            s_item_spawn_loc.interact = zm_quest::function_91f9590e98d57ff6( s_item_spawn_loc.origin + ( 0, 0, 10 ), &on_slorpy_item_interact, &function_6c1096c0e5b4fc96, "small" );
            s_item_spawn_loc.interact.flag = s_item_spawn.script_parameters;
            s_item_spawn_loc.interact.trace = s_item_spawn.script_noteworthy;
            s_item_spawn_loc.interact.sound = sound;
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_ingredient] - Player: " + player.name + " spawned " + ingredient_name + " interaction" );
        }
        
        if ( !isdefined( s_item_spawn_loc.interact.a_ents ) )
        {
            s_item_spawn_loc.interact.a_ents = [];
        }
        
        if ( s_item_spawn_loc.interact.a_ents.size > 0 )
        {
            temp_array = [];
            
            foreach ( ent in s_item_spawn_loc.interact.a_ents )
            {
                if ( ent && !ent.owningplayer )
                {
                    ent freescriptable();
                    continue;
                }
                
                temp_array[ temp_array.size ] = ent;
            }
            
            s_item_spawn_loc.interact.a_ents = temp_array;
        }
        
        s_item_spawn_loc.interact.a_ents[ s_item_spawn_loc.interact.a_ents.size ] = item;
        s_item_spawn_loc.interact.ingredient = ingredient_name;
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_ingredient] - Player: " + player.name + " spawned " + ingredient_name );
    }
    
    logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_ingredient] - " + ingredient_name + " spawned complete " );
    profilestop();
    return s_item_spawn_loc;
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0x53346259, Offset: 0x1e22
// Size: 0x189
function on_slorpy_item_interact( player )
{
    foreach ( ent in self.a_ents )
    {
        if ( ent.owningplayer == player )
        {
            if ( !player.slorpy_ingredients || !self.ingredient )
            {
                continue;
            }
            
            if ( arraycontains( player.slorpy_ingredients, self.ingredient ) )
            {
                logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_item_interact] - " + player.name + " already have ingredient" );
                return;
            }
            
            if ( !isdefined( player.slorpy_ingredients ) )
            {
                player.slorpy_ingredients = [];
            }
            
            player.slorpy_ingredients[ player.slorpy_ingredients.size ] = self.ingredient;
            
            if ( ent )
            {
                ent freescriptable();
            }
            
            playsoundatpos( self.origin, self.sound );
            function_5f08e08d719515d0( self.ingredient );
            
            /#
                iprintlnbold( "<dev string:x7d>" + self.ingredient );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_item_interact] - " + player.name + " pickup ingredient" );
            return;
        }
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2
// Checksum 0x89c77ac3, Offset: 0x1fb3
// Size: 0x59
function function_6c1096c0e5b4fc96( interact, player )
{
    /#
        sphere( interact.origin, 10, ( 1, 0, 0 ), 0 );
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2
// Checksum 0x6f2c05b9, Offset: 0x2015
// Size: 0x96
function cup_interact_hint( interact, player )
{
    /#
        ignoregroup = level.players;
        trace = trace::ray_trace( player geteye(), interact.origin, ignoregroup );
        
        if ( trace )
        {
            sphere( interact.origin, 10, ( 1, 0, 0 ), 0 );
        }
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0
// Checksum 0xa36dfa5b, Offset: 0x20b4
// Size: 0x210
function setup_slorpy_machine()
{
    level.var_c554dbd8ca767043 = [ "old_milk", "eggs", "weeds" ];
    level.var_cc2ba027017f2102 = [ "sugar", "peppers", "berries" ];
    level.var_d65e6c7c80a4cab2 = [ "gas", "lemons", "beans" ];
    level.var_ee8b894e73278eee = [ "fish", "stim", "toliet_cleaner" ];
    level.slorpy_cups = [];
    level.var_a74d38187a8b4e43 = [];
    level.var_b36e782c2a966ee0 = [];
    
    foreach ( s_cup_loc in level.var_74f8d403aa817cfe )
    {
        interact = zm_quest::function_91f9590e98d57ff6( s_cup_loc.origin, &on_slorpy_cup_interact, &cup_interact_hint, "small" );
        s_cup_loc.interact = interact;
        level.var_b36e782c2a966ee0[ level.var_b36e782c2a966ee0.size ] = interact;
    }
    
    cup_index = 0;
    
    foreach ( player in level.players )
    {
        s_cup_loc = level.var_74f8d403aa817cfe[ cup_index ];
        cup = spawn_soda_cup( player, s_cup_loc );
        cup_index++;
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 3
// Checksum 0x71cb3bc, Offset: 0x22cc
// Size: 0x123
function spawn_soda_cup( player, spawn_loc, var_7a65426f252841e7 = 1 )
{
    team_select_payload = [ #"teamselect", player getentitynumber() ];
    item = spawnscriptable( %"zm_sat_firefly_slorpy_cup", spawn_loc.origin, spawn_loc.angles, undefined, team_select_payload );
    item.var_7a65426f252841e7 = var_7a65426f252841e7;
    
    if ( var_7a65426f252841e7 )
    {
        item.owningplayer = player;
    }
    else
    {
        item.owningplayer = undefined;
    }
    
    level.slorpy_cups[ level.slorpy_cups.size ] = item;
    spawn_loc.cup = item;
    interact = spawn_loc.interact;
    
    if ( interact )
    {
        interact.cup = item;
        item.interact = interact;
    }
    
    logstring( "[ZM Firefly Slorpy EE DEBUG] : [spawn_soda_cup] - " + player.name + " spawn cup" );
    return item;
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0x9bcbeb55, Offset: 0x23f8
// Size: 0x585
function on_slorpy_cup_interact( player )
{
    ignoregroup = level.players;
    trace = trace::ray_trace( player geteye(), self.origin, ignoregroup );
    
    if ( !trace )
    {
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " trace failed" );
        return;
    }
    
    cup = self.cup;
    
    if ( !cup )
    {
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " cup undefined" );
        return;
    }
    
    if ( cup.perk && cup.var_12b8037df7d89857 )
    {
        if ( cup.perk == "bad" )
        {
            thread function_d5e94cab3996607c( player );
        }
        else
        {
            thread use_slorpy_cup( player, cup.perk );
        }
        
        /#
            iprintlnbold( "<dev string:x86>" );
        #/
        
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " can drink public soda" );
        return;
    }
    
    if ( cup.owningplayer != player )
    {
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " is not the cup owningPlayer" );
        return;
    }
    
    if ( !isdefined( player.slorpy_ingredients ) || !isdefined( player.var_17569d43ee1098e7 ) || player.var_17569d43ee1098e7 == 0 || player.slorpy_ingredients.size <= 2 )
    {
        /#
            iprintlnbold( "<dev string:xa4>" );
        #/
        
        playsoundatpos( self.origin, #"hash_1d0b4a49b3e98301" );
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " don't have slorpy_ingredients or can not use slorpy" );
        return;
    }
    
    if ( arraycompare( arraysort( player.slorpy_ingredients, undefined, undefined, 0, undefined, 1 ), arraysort( level.var_c554dbd8ca767043, undefined, undefined, 0, undefined, 1 ) ) && player.slorpy_ingredients.size == level.var_c554dbd8ca767043.size )
    {
        if ( player.var_9cbdd70caf571160 )
        {
            thread function_bcc2cc41e01b22fb( player, "specialty_juggernog" );
            
            /#
                iprintlnbold( "<dev string:xdf>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " make jugg" );
        }
        else
        {
            thread use_slorpy_cup( player, "specialty_juggernog" );
            
            /#
                iprintlnbold( "<dev string:xea>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " gained jugg" );
        }
        
        return;
    }
    
    if ( arraycompare( arraysort( player.slorpy_ingredients, undefined, undefined, 0, undefined, 1 ), arraysort( level.var_cc2ba027017f2102, undefined, undefined, 0, undefined, 1 ) ) && player.slorpy_ingredients.size == level.var_cc2ba027017f2102.size )
    {
        if ( player.var_9cbdd70caf571160 )
        {
            thread function_bcc2cc41e01b22fb( player, "specialty_speedcola" );
            
            /#
                iprintlnbold( "<dev string:xf7>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " make speed" );
        }
        else
        {
            thread use_slorpy_cup( player, "specialty_speedcola" );
            
            /#
                iprintlnbold( "<dev string:x103>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " gained speed" );
        }
        
        return;
    }
    
    if ( arraycompare( arraysort( player.slorpy_ingredients, undefined, undefined, 0, undefined, 1 ), arraysort( level.var_d65e6c7c80a4cab2, undefined, undefined, 0, undefined, 1 ) ) && player.slorpy_ingredients.size == level.var_d65e6c7c80a4cab2.size )
    {
        if ( player.var_9cbdd70caf571160 )
        {
            thread function_bcc2cc41e01b22fb( player, "specialty_staminup" );
            
            /#
                iprintlnbold( "<dev string:x111>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " make stam" );
        }
        else
        {
            thread use_slorpy_cup( player, "specialty_staminup" );
            
            /#
                iprintlnbold( "<dev string:x11c>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " gained stam" );
        }
        
        return;
    }
    
    if ( arraycompare( arraysort( player.slorpy_ingredients, undefined, undefined, 0, undefined, 1 ), arraysort( level.var_ee8b894e73278eee, undefined, undefined, 0, undefined, 1 ) ) && player.slorpy_ingredients.size == level.var_ee8b894e73278eee.size )
    {
        if ( player.var_9cbdd70caf571160 )
        {
            thread function_bcc2cc41e01b22fb( player, "specialty_quickrevive" );
            
            /#
                iprintlnbold( "<dev string:x129>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " make revive" );
        }
        else
        {
            thread use_slorpy_cup( player, "specialty_quickrevive" );
            
            /#
                iprintlnbold( "<dev string:x136>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " gained revive" );
        }
        
        return;
    }
    
    if ( player.slorpy_ingredients.size > 0 )
    {
        if ( player.var_9cbdd70caf571160 )
        {
            thread function_bcc2cc41e01b22fb( player, "bad" );
            
            /#
                iprintlnbold( "<dev string:x145>" );
            #/
            
            logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " make bad" );
            return;
        }
        
        thread function_d5e94cab3996607c( player );
        
        /#
            iprintlnbold( "<dev string:x14f>" );
        #/
        
        logstring( "[ZM Firefly Slorpy EE DEBUG] : [on_slorpy_cup_interact] - " + player.name + " gained bad" );
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2
// Checksum 0x79153890, Offset: 0x2985
// Size: 0x20a
function function_bcc2cc41e01b22fb( player, perk )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player.var_9cbdd70caf571160 = 0;
    function_cc9bb30834eeb97b( perk );
    index = 1;
    
    foreach ( cup in level.slorpy_cups )
    {
        if ( cup && cup.owningplayer == player )
        {
            cup endon( #"death" );
            str = "tag_juice_" + index;
            
            if ( player )
            {
                player playfx( utility::getfx( "soda_spawn_faucet" ), level.soda_fountain[ str ] );
                sound = perk == "bad" ? #"hash_eb7769594d817244" : #"hash_924d3f8ba59a230c";
                level.var_d9baa2f7feaa2ec playsoundtoplayer( sound, player );
            }
            
            wait 0.5;
            
            if ( !cup )
            {
                continue;
            }
            
            team_select_payload = [ #"teamselect", player getentitynumber() ];
            cup.fx = spawnscriptable( %"zm_sat_firefly_slorpy_cup_fx", cup.origin, cup.angles, undefined, team_select_payload );
            remain = 1.4;
            
            if ( remain > 0 )
            {
                wait remain;
            }
            
            cup setscriptablepartstate( "model", perk );
            cup.perk = perk;
            cup.full = 1;
            self.canuse = 1;
            break;
        }
        
        index++;
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 3
// Checksum 0x2a4ebfa8, Offset: 0x2b97
// Size: 0x1bd
function function_3e0b22996f87d303( player, perk, owner )
{
    cup = undefined;
    fx = undefined;
    
    if ( self.cup.fx )
    {
        fx = self.cup.fx;
    }
    
    foreach ( s_cup_loc in level.var_74f8d403aa817cfe )
    {
        if ( s_cup_loc.cup == self.cup )
        {
            cup = spawn_soda_cup( player, s_cup_loc, 0 );
            cup.var_12b8037df7d89857 = 1;
            cup.perk = perk;
            cup.interact = self;
            cup.owningplayer = owner;
            cup.fx = fx;
            self.cup = cup;
            s_cup_loc.cup = cup;
            level.var_a74d38187a8b4e43[ level.var_a74d38187a8b4e43.size ] = cup;
            break;
        }
    }
    
    if ( cup && perk )
    {
        cup setscriptablepartstate( "model", perk );
        cup setscriptablepartstate( "vfx", "public" );
    }
    
    if ( cup.fx )
    {
        cup.fx setscriptablepartstate( "fx", "public" );
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2
// Checksum 0x5cba113e, Offset: 0x2d5c
// Size: 0x238
function use_slorpy_cup( player, perk )
{
    if ( !self.canuse || !self.canuse )
    {
        return;
    }
    
    cup = self.cup;
    
    if ( cup )
    {
        if ( !player zombie_perks::has_perk( perk ) )
        {
            if ( cup.var_12b8037df7d89857 )
            {
                foreach ( public_cup in level.var_a74d38187a8b4e43 )
                {
                    if ( public_cup.owningplayer && public_cup.owningplayer == cup.owningplayer )
                    {
                        level.var_a74d38187a8b4e43 = arrayremove( level.var_a74d38187a8b4e43, public_cup );
                        public_cup delete_cup();
                    }
                }
            }
            else if ( cup.owningplayer == player )
            {
                player.var_17569d43ee1098e7 = 0;
                function_ba775aaf83443ae();
                level.slorpy_cups = arrayremove( level.slorpy_cups, cup );
                cup delete_cup();
                params = spawnstruct();
                params.timestamp = gettime();
                params.questname = #"zm_sat_firefly_slorpy_quest";
                params.var_be82617e5e8087bd = [ player ];
                params.event = #"zm_sq_quest_complete";
                params.perk = perk;
                level callback::callback( #"hash_6c71d319dc089c27", params );
                level callback::callback( "zm_sq_quest_complete", params );
            }
            
            self.canuse = 0;
            function_b9da91a957cb65a6( player, perk );
        }
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x15b>" + perk );
    #/
    
    logstring( "[ZM Firefly Slorpy EE DEBUG] : [use_slorpy_cup] - " + player.name + " Already has " + perk );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0xc677487d, Offset: 0x2f9c
// Size: 0x69
function function_d5e94cab3996607c( player )
{
    player endon( #"death_or_disconnect" );
    player.var_17569d43ee1098e7 = 0;
    self.cup delete_cup();
    player utility::function_72b6372d2d8c997( "sat_zm_vm_slorpy_ges", 1 );
    gesture_length = player getgestureanimlength( "sat_ges_zm_food_cup_soda_drink" );
    wait gesture_length;
    player function_cae8a5573a895241();
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0, eflags: 0x4
// Checksum 0x7d1ccad8, Offset: 0x300d
// Size: 0x3b
function private delete_cup()
{
    cup = self;
    
    if ( !cup )
    {
        return;
    }
    
    if ( cup.fx )
    {
        cup.fx freescriptable();
    }
    
    cup freescriptable();
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 2, eflags: 0x4
// Checksum 0xb843c028, Offset: 0x3050
// Size: 0xa6
function private function_b9da91a957cb65a6( player, perk )
{
    player endon( #"death_or_disconnect" );
    player utility::function_72b6372d2d8c997( "sat_zm_vm_slorpy_ges", 1 );
    gesture_length = player getgestureanimlength( "sat_ges_zm_food_cup_soda_drink" );
    wait gesture_length;
    player zombie_perks::give_perk( perk, undefined, 0 );
    player.var_94aa0893ed1e7d7b = arraycombineunique( player.var_94aa0893ed1e7d7b, [ perk ] );
    var_485ee1acddf9abdd = 3;
    player zm_vo::say_battlechatter( #"hash_b8474195b0e466b6", undefined, #"hash_751d4557b710b142", undefined, undefined, 1 );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0
// Checksum 0x622b86f8, Offset: 0x30fe
// Size: 0x99
function function_cae8a5573a895241()
{
    if ( !self || !isalive( self ) )
    {
        return;
    }
    
    damage_amount = self.health * 0.5;
    self dodamage( damage_amount, self.origin, self, self, "MOD_UNKNOWN" );
    thread function_64f9ae47470f33db();
    self playrumbleonentity( "heavy_1s" );
    
    if ( zm_vo::is_hero_operator() )
    {
        player_banter::play_banter_vo( #"hash_ac85134ed37e2034", [ self ], undefined, 1 );
        return;
    }
    
    battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_negative", 1.5, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0
// Checksum 0xd2e2bd4a, Offset: 0x319f
// Size: 0x3d
function function_64f9ae47470f33db()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "slorpy_vfx", "on" );
    wait 5;
    self setscriptablepartstate( "slorpy_vfx", "off" );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0x188c6499, Offset: 0x31e4
// Size: 0x236
function function_5f08e08d719515d0( str_ingredient )
{
    if ( level.players.size > 1 )
    {
        return;
    }
    
    if ( !isdefined( str_ingredient ) )
    {
        return;
    }
    
    switch ( str_ingredient )
    {
        case #"hash_f5d49b7b5fd24294":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_d6ba6d8405078caa", 1 );
            break;
        case #"hash_4f9bb803d974884f":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_bc15787442b9d885", 1 );
            break;
        case #"hash_6fff72ec017932a9":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_e801c490a555b3f", 1 );
            break;
        case #"hash_45ed448efa03b365":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_9bc74b575b74526f", 1 );
            break;
        case #"hash_1d80c80a7676d49e":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_318ac2365f7ee7d4", 1 );
            break;
        case #"hash_fb36696c0708bf42":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_acd0737e2d8b4938", 1 );
            break;
        case #"hash_85d6273f501206f9":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_17a60a55e79f085f", 1 );
            break;
        case #"hash_b0231e724c1f7b5c":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_c7ace54ff4cb1976", 1 );
            break;
        case #"hash_ceb3b9150f04bcc3":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_24dcb96d13c50b05", 1 );
            break;
        case #"hash_23cdc38a2fa78bb4":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_fab1d40db870ea52", 1 );
            break;
        case #"hash_7d811fafcac35abb":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_b0fd48b1078f21b9", 1 );
            break;
        case #"hash_fa59c003de19c947":
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_5ce662de54b75c95", 1 );
            break;
        default:
            break;
    }
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 1
// Checksum 0x2d1a7410, Offset: 0x3422
// Size: 0x9b
function function_cc9bb30834eeb97b( perk )
{
    if ( level.players.size > 1 )
    {
        return;
    }
    
    perk_value = 0;
    
    if ( perk == "specialty_juggernog" )
    {
        perk_value = 1;
    }
    else if ( perk == "specialty_speedcola" )
    {
        perk_value = 2;
    }
    else if ( perk == "specialty_staminup" )
    {
        perk_value = 3;
    }
    else if ( perk == "specialty_quickrevive" )
    {
        perk_value = 4;
    }
    else if ( perk == "bad" )
    {
        perk_value = 0;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_f4d8ddb17ce12781", perk_value );
}

// Namespace zm_sat_firefly_slorpy_quest
// Params 0
// Checksum 0x6556a626, Offset: 0x34c5
// Size: 0x2e
function function_ba775aaf83443ae()
{
    if ( level.players.size > 1 )
    {
        return;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_2081cc64ead887db", 1 );
}

/#

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0
    // Checksum 0xd3257742, Offset: 0x34fb
    // Size: 0x29a, Type: dev
    function init_debug()
    {
        waitframe();
        root = "<dev string:x168>";
        devgui::function_9082edeb5db93280( root + "<dev string:x17c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x187>", "<dev string:x19d>" + 0, &function_c027de0aadf31c03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1af>", "<dev string:x19d>" + 1, &function_c027de0aadf31c03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1c5>", "<dev string:x19d>" + 2, &function_c027de0aadf31c03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1db>", "<dev string:x19d>" + 3, &function_c027de0aadf31c03 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x1f1>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f7>", "<dev string:x20c>" + "<dev string:x21d>", &function_1dd5dd1c24e45036 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x231>", "<dev string:x20c>" + "<dev string:x24c>", &function_1dd5dd1c24e45036 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x260>", "<dev string:x20c>" + "<dev string:x275>", &function_1dd5dd1c24e45036 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x288>", "<dev string:x20c>" + "<dev string:x2a5>", &function_1dd5dd1c24e45036 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x2bb>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2c2>", "<dev string:x2d8>" + "<dev string:x21d>", &function_d9c8446437072884 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2ea>", "<dev string:x2d8>" + "<dev string:x24c>", &function_d9c8446437072884 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x306>", "<dev string:x2d8>" + "<dev string:x275>", &function_d9c8446437072884 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x31c>", "<dev string:x2d8>" + "<dev string:x2a5>", &function_d9c8446437072884 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33a>", "<dev string:x2d8>" + "<dev string:x34f>", &function_d9c8446437072884 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x353>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x35b>", "<dev string:x36d>" + 1, &function_19941ff8edbcef25 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37b>", "<dev string:x36d>" + 2, &function_19941ff8edbcef25 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x38d>", "<dev string:x36d>" + 3, &function_19941ff8edbcef25 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x39f>", "<dev string:x36d>" + 4, &function_19941ff8edbcef25 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x3b1>" );
        devgui::add_devgui_func( "<dev string:x3b6>", "<dev string:x3bf>", &function_7232d41451a1cc82 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root );
        devgui::add_devgui_func( "<dev string:x3d3>", "<dev string:x3e5>", &function_4f90b6bca8a3ca25 );
        devgui::add_devgui_func( "<dev string:x3f7>", "<dev string:x40a>", &function_8c50c54eb583a051 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0
    // Checksum 0xedb38faa, Offset: 0x379d
    // Size: 0x27, Type: dev
    function function_4f90b6bca8a3ca25()
    {
        player = level.players[ 0 ];
        player.slorpy_ingredients = undefined;
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 1
    // Checksum 0x9da8569f, Offset: 0x37cc
    // Size: 0x50, Type: dev
    function function_19941ff8edbcef25( params )
    {
        index = int( params[ 0 ] );
        str = "<dev string:x41d>" + index;
        playfx( utility::getfx( "<dev string:x428>" ), level.soda_fountain[ str ] );
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 1
    // Checksum 0x5460bde6, Offset: 0x3824
    // Size: 0x86, Type: dev
    function function_c027de0aadf31c03( params )
    {
        index = int( params[ 0 ] );
        player = level.players[ 0 ];
        s_cup_loc = level.var_74f8d403aa817cfe[ index ];
        interact = s_cup_loc.interact;
        
        if ( !s_cup_loc.cup )
        {
            s_cup_loc.cup = spawn_soda_cup( player, s_cup_loc );
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 1, eflags: 0x4
    // Checksum 0x8b08eda5, Offset: 0x38b2
    // Size: 0x105, Type: dev
    function private function_1dd5dd1c24e45036( params )
    {
        str_perk = params[ 0 ];
        player = level.players[ 0 ];
        player.var_17569d43ee1098e7 = 1;
        player.var_9cbdd70caf571160 = 1;
        player function_3b9f48f184a3c0da( str_perk );
        
        foreach ( s_cup_loc in level.var_74f8d403aa817cfe )
        {
            if ( s_cup_loc.cup && s_cup_loc.cup.owningplayer )
            {
                s_cup_loc.interact on_slorpy_cup_interact( player );
                break;
            }
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 1, eflags: 0x4
    // Checksum 0x5edfbbfc, Offset: 0x39bf
    // Size: 0xdf, Type: dev
    function private function_3b9f48f184a3c0da( str_perk )
    {
        player = self;
        
        switch ( str_perk )
        {
            case #"hash_4485ea5afc8ef4ec":
                player.slorpy_ingredients = level.var_c554dbd8ca767043;
                break;
            case #"hash_5b88c6956390309e":
                player.slorpy_ingredients = level.var_cc2ba027017f2102;
                break;
            case #"hash_8ce81fd37af3e66b":
                player.slorpy_ingredients = level.var_d65e6c7c80a4cab2;
                break;
            case #"hash_47874f94af82bbae":
                player.slorpy_ingredients = level.var_ee8b894e73278eee;
                break;
        }
        
        if ( player.slorpy_ingredients )
        {
            player.slorpy_ingredients = arrayrandomize( player.slorpy_ingredients );
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 1, eflags: 0x4
    // Checksum 0x129cd55c, Offset: 0x3aa6
    // Size: 0x8a, Type: dev
    function private function_d9c8446437072884( params )
    {
        str_perk = params[ 0 ];
        player = level.players[ 0 ];
        player.var_17569d43ee1098e7 = 1;
        player.var_9cbdd70caf571160 = 1;
        
        if ( player zombie_perks::has_perk( str_perk ) )
        {
            iprintlnbold( "<dev string:x15b>" + str_perk );
            return;
        }
        
        if ( str_perk == "<dev string:x34f>" )
        {
            player function_cae8a5573a895241();
            return;
        }
        
        function_b9da91a957cb65a6( player, str_perk );
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 2
    // Checksum 0x61f50df0, Offset: 0x3b38
    // Size: 0x7d, Type: dev
    function drawsphere( color, text )
    {
        if ( !isdefined( text ) )
        {
            text = undefined;
        }
        
        self notify( #"hash_7c471c335f31f49e" );
        self endon( #"hash_7c471c335f31f49e" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 10, color, 0 );
            print3d( self.origin, text, color );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0, eflags: 0xc
    // Checksum 0xc7f9cbb7, Offset: 0x3bbd
    // Size: 0x257, Type: dev
    function private function_7232d41451a1cc82()
    {
        self notify( #"hash_d14aed4bc530a81" );
        self endon( #"hash_d14aed4bc530a81" );
        level endon( #"game_ended" );
        bot = spawn_a_bot();
        
        if ( !bot )
        {
            return;
        }
        
        bot endon( #"death_or_disconnect" );
        bot childthread function_5211fd23236d3eb8();
        bot.var_65a8b55c5c68fc4 = "<dev string:x43a>";
        pos = ( -11987, 3386, 500 );
        pos_linker = spawn( "<dev string:x440>", pos, 0 );
        bot playerlinkto( pos_linker );
        bot setorigin( pos );
        bot setplayerangles( ( 12.8, 125, 0 ) );
        wait 2;
        free_cup_loc = undefined;
        
        foreach ( cup_loc in level.var_74f8d403aa817cfe )
        {
            if ( cup_loc.cup && cup_loc.cup.owningplayer != bot )
            {
                continue;
            }
            
            free_cup_loc = cup_loc;
        }
        
        if ( !free_cup_loc )
        {
            bot.var_65a8b55c5c68fc4 = "<dev string:x44d>";
            return;
        }
        
        if ( !free_cup_loc.cup )
        {
            free_cup_loc.cup = spawn_soda_cup( bot, free_cup_loc );
            bot.var_65a8b55c5c68fc4 = "<dev string:x454>";
        }
        
        wait 2;
        bot.var_65a8b55c5c68fc4 = "<dev string:x45e>";
        bot function_3b9f48f184a3c0da( "<dev string:x21d>" );
        wait 2;
        bot.var_65a8b55c5c68fc4 = "<dev string:x479>";
        free_cup_loc.interact on_slorpy_cup_interact( bot );
        
        while ( !free_cup_loc.interact.canuse )
        {
            waitframe();
            continue;
        }
        
        bot.var_65a8b55c5c68fc4 = "<dev string:x47e>";
        wait 2;
        bot.var_65a8b55c5c68fc4 = "<dev string:x48c>";
        free_cup_loc.interact on_slorpy_cup_interact( bot );
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0, eflags: 0xc
    // Checksum 0x1d45a446, Offset: 0x3e1c
    // Size: 0x9c, Type: dev
    function private function_5211fd23236d3eb8()
    {
        self notify( #"hash_1964d93e7c1dd323" );
        self endon( #"hash_1964d93e7c1dd323" );
        level endon( #"game_ended" );
        bot = self;
        bot endon( #"death_or_disconnect" );
        color = ( 0, 1, 0 );
        
        while ( true )
        {
            if ( bot.var_65a8b55c5c68fc4 )
            {
                print3d( bot.origin + ( 0, 0, 10 ), bot.var_65a8b55c5c68fc4, color );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0, eflags: 0x4
    // Checksum 0xa76c1470, Offset: 0x3ec0
    // Size: 0x102, Type: dev
    function private spawn_a_bot()
    {
        level endon( #"game_ended" );
        var_e7a717b43846a16 = level.players.size;
        
        if ( var_e7a717b43846a16 >= 4 )
        {
            iprintlnbold( "<dev string:x492>" );
            return;
        }
        
        bots::spawn_bots( 1, "<dev string:x4bd>" );
        
        while ( true )
        {
            waitframe();
            new_bot = undefined;
            
            foreach ( index, p in level.players )
            {
                if ( index == 0 )
                {
                    continue;
                }
                
                if ( p.is_using )
                {
                    continue;
                }
                
                p.is_using = 1;
                new_bot = p;
                break;
            }
            
            if ( new_bot )
            {
                return new_bot;
            }
        }
    }

    // Namespace zm_sat_firefly_slorpy_quest
    // Params 0, eflags: 0x4
    // Checksum 0x9b797963, Offset: 0x3fca
    // Size: 0x5a, Type: dev
    function private function_8c50c54eb583a051()
    {
        me = level.players[ 0 ];
        pos = ( -11987, 3386, 546 );
        angle = ( 12.8, 125, 0 );
        me setorigin( pos );
        me setplayerangles( angle );
    }

#/
