// scripts\mp\zm\systems\zm_vault.gsc  (hash_557198d0f2a9749b.gscc) (size: 18474 Bytes / 0x482a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44348cd3 (1144294611)
// size ...... 18474 (0x482a)
// includes .. 14  (offset: 0x439e)
// strings ... 52  (offset: 0x440e)
// dev strs .. 8   (offset: 0x47c2)
// exports ... 49  (offset: 0x2cc6)
// cseg ...... 0x409 + 0x28bd (0x2cc6)
// imports ... 124 (offset: 0x346e)
// animtree1 . 0   (offset: 0x482a)
// animtree2 . 0   (offset: 0x482a)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_lootkey;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_vault;

// Namespace zm_vault
// Params 0
// Checksum 0xf8a363ac, Offset: 0x427
// Size: 0x165
function init()
{
    level._effect[ "bank_vault_blast" ] = loadfxasset( "vfx_t10_levels_zm_quartz_clearing_blast" );
    level callback::add( "on_exfil_start", &function_a7e970e310be4e24 );
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !isdefined( level.var_824f43160e0b8bf6 ) )
    {
        level.var_824f43160e0b8bf6 = [ "player_in_vault" ];
    }
    
    function_5a4ef4d1a9499b6c();
    function_762cf6dcc1c2116();
    
    if ( !isdefined( level.zm_vault_info ) )
    {
        level.zm_vault_info = spawnstruct();
    }
    
    level callback::add( "on_round_start", &on_round_start );
    
    /#
        init_bank_vault_debug();
    #/
    
    level callback::add( "on_agent_spawned", &function_c5bb4457f9b74f92 );
    level callback::add( "zone_changed", &on_zone_changed );
    
    if ( !threatbiasgroupexists( "zm_vault_threat_player" ) )
    {
        createthreatbiasgroup( "zm_vault_threat_player" );
    }
    
    if ( !threatbiasgroupexists( "zm_vault_threat" ) )
    {
        createthreatbiasgroup( "zm_vault_threat" );
    }
    
    if ( !threatbiasgroupexists( "player_team" ) )
    {
        createthreatbiasgroup( "player_team" );
    }
    
    if ( !threatbiasgroupexists( "zm_vault_threat_inside_zombie" ) )
    {
        createthreatbiasgroup( "zm_vault_threat_inside_zombie" );
    }
    
    setignoremegroup( "zm_vault_threat_player", "zm_vault_threat" );
    level callback::add( #"player_spawned", &on_player_spawned );
    zm_quest::function_3c363613c60958f5( "player_in_vault" );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"drop_lootkey", &function_29726a35a05d6028 );
    #/
}

// Namespace zm_vault
// Params 1
// Checksum 0x944c9a23, Offset: 0x594
// Size: 0x93
function function_a7e970e310be4e24( params )
{
    foreach ( player in level.players )
    {
        if ( player.var_1946560132e8d336 )
        {
            player function_7068aeca4797661f();
        }
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0xdfb4ebe9, Offset: 0x62f
// Size: 0x2e
function on_player_spawned( params )
{
    if ( !threatbiasgroupexists( "player_team" ) )
    {
        createthreatbiasgroup( "player_team" );
    }
    
    self setthreatbiasgroup( "player_team" );
}

// Namespace zm_vault
// Params 1
// Checksum 0xf5c4894d, Offset: 0x665
// Size: 0x17
function function_c5bb4457f9b74f92( params )
{
    self setthreatbiasgroup( "zm_vault_threat" );
}

// Namespace zm_vault
// Params 1
// Checksum 0xa82cf58c, Offset: 0x684
// Size: 0x18
function on_round_start( var_8582cc5f29b6732c )
{
    level notify( #"round_started" );
}

// Namespace zm_vault
// Params 1
// Checksum 0x1fb79808, Offset: 0x6a4
// Size: 0x66
function function_f341aad33e35ec73( var_336b0ef16bb04f6d )
{
    if ( !isdefined( level.var_824f43160e0b8bf6 ) )
    {
        level.var_824f43160e0b8bf6 = [ "player_in_vault" ];
    }
    
    if ( isarray( var_336b0ef16bb04f6d ) )
    {
        level.var_824f43160e0b8bf6 = arraycombine( var_336b0ef16bb04f6d );
        return;
    }
    
    if ( isstring( var_336b0ef16bb04f6d ) )
    {
        level.var_824f43160e0b8bf6[ level.var_824f43160e0b8bf6.size ] = var_336b0ef16bb04f6d;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0x40183337, Offset: 0x712
// Size: 0x1d
function register_ray_gun_code( array_code )
{
    if ( isdefined( array_code ) )
    {
        level.var_da2ec466f927a897 = array_code;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0x432a71b5, Offset: 0x737
// Size: 0x9d
function function_ac2aa369965d5755( custom_init_func )
{
    var_410648b6cf8839a4 = utility::getstructarray( "vault_safe_deposit_door", "script_noteworthy" );
    
    foreach ( deposit in var_410648b6cf8839a4 )
    {
        deposit.custom_init_func = custom_init_func;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0xc81ccf88, Offset: 0x7dc
// Size: 0x9d
function function_6125d99a46e4daf7( var_59c94ba8facd11a9 )
{
    var_410648b6cf8839a4 = utility::getstructarray( "vault_safe_deposit_door", "script_noteworthy" );
    
    foreach ( deposit in var_410648b6cf8839a4 )
    {
        deposit.var_59c94ba8facd11a9 = var_59c94ba8facd11a9;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0xc27f4fbe, Offset: 0x881
// Size: 0x9d
function function_17f9216cd447597b( var_f1f038800a8b989d )
{
    var_410648b6cf8839a4 = utility::getstructarray( "vault_safe_deposit_door", "script_noteworthy" );
    
    foreach ( deposit in var_410648b6cf8839a4 )
    {
        deposit.var_f1f038800a8b989d = var_f1f038800a8b989d;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0x4b7ef01a, Offset: 0x926
// Size: 0x9d
function function_91e85a45ddbdbf50( var_35fc490cc2adf4ae )
{
    var_410648b6cf8839a4 = utility::getstructarray( "vault_safe_deposit_door", "script_noteworthy" );
    
    foreach ( deposit in var_410648b6cf8839a4 )
    {
        deposit.var_35fc490cc2adf4ae = var_35fc490cc2adf4ae;
    }
}

// Namespace zm_vault
// Params 4
// Checksum 0x6ffba4fc, Offset: 0x9cb
// Size: 0xe7
function function_562d3465eae380a3( org_or_ent, use_callback, var_b2107da793be51f7, radius_type )
{
    var_45b620bc30783968 = undefined;
    
    if ( isvector( org_or_ent ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent );
    }
    else if ( isvector( org_or_ent.origin ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent.origin );
    }
    
    if ( !isdefined( var_45b620bc30783968 ) )
    {
        print( "<dev string:x24>" );
        return;
    }
    
    var_45b620bc30783968.radius_type = radius_type ? radius_type : "small";
    var_45b620bc30783968 utility::function_7c10ea82c1e305b8( "base", var_45b620bc30783968.radius_type );
    
    if ( isfunction( var_b2107da793be51f7 ) )
    {
        var_45b620bc30783968 interaction::set_interact_hint_callback( var_b2107da793be51f7 );
    }
    
    if ( isfunction( use_callback ) )
    {
        var_45b620bc30783968 = interaction::register_scriptable_interact( var_45b620bc30783968, use_callback );
    }
    
    return var_45b620bc30783968;
}

// Namespace zm_vault
// Params 0
// Checksum 0xd9cf62de, Offset: 0xabb
// Size: 0x2ae
function function_5a4ef4d1a9499b6c()
{
    var_410648b6cf8839a4 = utility::getstructarray( "vault_safe_deposit_door", "script_noteworthy" );
    
    foreach ( mdl in var_410648b6cf8839a4 )
    {
        mdl.sbl = spawnscriptable( mdl.script_string, mdl.origin, mdl.angles );
        
        if ( isdefined( mdl.custom_init_func ) )
        {
            mdl [[ mdl.custom_init_func ]]();
        }
        else
        {
            mdl.sbl setscriptablepartstate( "base", "outline" );
        }
        
        a_s_child_structs = utility::getstructarray( mdl.target, "targetname" );
        
        foreach ( struct in a_s_child_structs )
        {
            if ( struct.script_noteworthy == "vault_safe_deposit_interact" )
            {
                mdl.interact = function_562d3465eae380a3( struct.origin, &function_d60cb6d491afd823, &function_a1cff74ef82859fa );
                mdl.interact.sfx_agent = spawnscriptable( "zm_t10_bank_vault_deposit_box", mdl.origin, mdl.angles );
                mdl.interact.parent_struct = struct;
                mdl.interact.var_8ec231e91dc8538b = int( struct.script_label );
                continue;
            }
            
            if ( struct.script_noteworthy == "vault_cache_pos" )
            {
                mdl.s_vault_cache_pos = struct;
                continue;
            }
            
            mdl.s_rotate_destination = struct;
        }
        
        mdl.var_ef9348b51a228817 = 1;
        mdl.b_is_opened = 0;
        mdl.v_original_angles = mdl.angles;
        mdl.interact.my_model = mdl;
    }
    
    level thread function_33df21ce92b9a76a();
}

// Namespace zm_vault
// Params 0
// Checksum 0xe7501e5e, Offset: 0xd71
// Size: 0xf3
function function_33df21ce92b9a76a()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        b_set_flag = 0;
        
        foreach ( player in level.players )
        {
            if ( player.var_1946560132e8d336 )
            {
                b_set_flag = 1;
                break;
            }
        }
        
        if ( b_set_flag && !utility::flag( "player_in_vault" ) )
        {
            level utility::flag_set( "player_in_vault" );
        }
        else if ( !b_set_flag && utility::flag( "player_in_vault" ) )
        {
            level utility::flag_clear( "player_in_vault" );
        }
        
        wait 0.5;
    }
}

// Namespace zm_vault
// Params 0
// Checksum 0xc1aa7c6c, Offset: 0xe6c
// Size: 0xda
function function_762cf6dcc1c2116()
{
    level.var_f875996907e43075 = utility::getstruct( "sq_bank_vault_sml_door_in", "script_noteworthy" );
    level.var_f875996907e43075.interact = interaction::register_interact( level.var_f875996907e43075.origin, 64, &function_a9a86c9c6b20fe63 );
    level.var_f875996907e43075.interact interaction::set_interact_hint_callback( &function_234b6e9ca093f33a );
    level.var_a19642e4383dc3e8 = utility::getstruct( "sq_bank_vault_sml_door_out", "script_noteworthy" );
    level.var_a19642e4383dc3e8.interact = interaction::register_interact( level.var_a19642e4383dc3e8.origin, 32, &function_a9a86c9c6b20fe63 );
    level.var_a19642e4383dc3e8.interact interaction::set_interact_hint_callback( &function_234b6e9ca093f33a );
}

// Namespace zm_vault
// Params 2
// Checksum 0x89d80d5d, Offset: 0xf4e
// Size: 0x269
function function_234b6e9ca093f33a( interact, player )
{
    if ( isplayer( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1, level.var_824f43160e0b8bf6 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player zm_quest::function_9b18c35fba5c3d31() )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_f08775337dde635e )
    {
        if ( level.mapname == "zm_t10_quartz" || level.mapname == "zm_t10_topaz" )
        {
            return { #var_26bbd300351fde34:0, #string:&"ZM_T10_QUARTZ/SQ_QUARTZ_ARMORY_IN_CD", #type:"HINT_NOBUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_t10_garnet/sq_bank_vault_in_cd", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    if ( player.var_1946560132e8d336 )
    {
        if ( level.mapname == "zm_t10_quartz" || level.mapname == "zm_t10_topaz" )
        {
            return { #var_26bbd300351fde34:0, #string:&"ZM_T10_QUARTZ/SQ_BANK_VAULT_LEAVE_ARMORY", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_t10_garnet/sq_bank_vault_leave_vault", #type:"HINT_BUTTON" };
        }
        
        return;
    }
    
    if ( level.mapname == "zm_t10_quartz" || level.mapname == "zm_t10_topaz" )
    {
        return { #var_26bbd300351fde34:0, #string:&"ZM_T10_QUARTZ/SQ_BANK_VAULT_ENTER_ARMORY", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_t10_garnet/sq_bank_vault_enter_vault", #type:"HINT_BUTTON" };
}

// Namespace zm_vault
// Params 1
// Checksum 0x58978461, Offset: 0x11bf
// Size: 0x30
function function_a9a86c9c6b20fe63( player )
{
    if ( player.var_f08775337dde635e )
    {
        return;
    }
    
    if ( player zm_quest::function_9b18c35fba5c3d31() )
    {
        return;
    }
    
    player thread function_16c4704d7e6691f9();
}

// Namespace zm_vault
// Params 0
// Checksum 0x98090417, Offset: 0x11f7
// Size: 0x13a
function function_16c4704d7e6691f9()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !zm_quest::function_f98968f17772726c( 1, level.var_824f43160e0b8bf6 ) )
    {
        return;
    }
    
    if ( self.var_1946560132e8d336 )
    {
        function_7068aeca4797661f();
        return;
    }
    
    val::set( "zm_vault_unlock", "killstreaks", 0 );
    val::set( "zm_vault_unlock", "supers", 0 );
    val::set( "zm_vault_unlock", "ignore_afk", 1 );
    self.var_1946560132e8d336 = 1;
    self setclientomnvar( "ui_zm_is_in_vault", 1 );
    callback::add( #"player_death", &function_dda7366724a715d6 );
    self.var_a8fe9b95bacfd1df = self getthreatbiasgroup();
    self setthreatbiasgroup( "zm_vault_threat_player" );
    level thread zm_fasttravel::function_cbb08198e7c84adf( level.var_f875996907e43075, self, undefined, 0 );
    self playsoundtoplayer( #"hash_e3dd103edf3456d9", self );
    self waittill( #"fasttravel_over" );
    
    if ( isdefined( level.zm_vault_info.var_f9181733f04ba2a6 ) )
    {
        level thread [[ level.zm_vault_info.var_f9181733f04ba2a6 ]]( self );
    }
    
    zm_quest::disable_specific_player_bgb( 1 );
    thread function_e8774d9820c8f940();
    thread function_a14d393963c271cc();
}

// Namespace zm_vault
// Params 0
// Checksum 0x25a2a3d8, Offset: 0x1339
// Size: 0xca
function function_7068aeca4797661f()
{
    self.var_1946560132e8d336 = 0;
    self setclientomnvar( "ui_zm_is_in_vault", 0 );
    self notify( #"hash_856281cfe4852869" );
    self setthreatbiasgroup( "player_team" );
    level thread zm_fasttravel::function_cbb08198e7c84adf( level.var_a19642e4383dc3e8, self, undefined, 0 );
    self playsoundtoplayer( #"hash_f8bcc0873a0f0539", self );
    self waittill( #"fasttravel_over" );
    
    if ( isdefined( level.zm_vault_info.var_9e2da6c350db19e6 ) )
    {
        level thread [[ level.zm_vault_info.var_9e2da6c350db19e6 ]]( self );
    }
    
    val::reset_all( "zm_vault_unlock" );
    zm_quest::disable_specific_player_bgb( 0 );
    thread function_9a6f5b759a6ecb82();
    blast_nearby_enemies( 0, 0, 1 );
    callback::remove( #"player_death", &function_dda7366724a715d6 );
}

// Namespace zm_vault
// Params 1
// Checksum 0xcdee9ea7, Offset: 0x140b
// Size: 0xc
function function_dda7366724a715d6( params )
{
    
}

// Namespace zm_vault
// Params 0
// Checksum 0xa435f308, Offset: 0x141f
// Size: 0x123
function function_e8774d9820c8f940()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_8f257ac5b2dfd3ba" );
    thread function_64a58cd635805010( 1, "vault_last_ten_secs" );
    wait 35;
    self notify( #"vault_last_ten_secs" );
    thread function_64a58cd635805010( 0, "vault_cut_countdown" );
    wait 10;
    self notify( #"vault_cut_countdown" );
    self notify( #"hash_856281cfe4852869" );
    self.var_f08775337dde635e = 1;
    zm_quest::disable_specific_player_bgb( 0 );
    self.var_1946560132e8d336 = 0;
    self setclientomnvar( "ui_zm_is_in_vault", 0 );
    level thread zm_fasttravel::function_cbb08198e7c84adf( level.var_a19642e4383dc3e8, self, undefined, 0 );
    self waittill( #"fasttravel_over" );
    self setthreatbiasgroup( "player_team" );
    
    if ( isdefined( level.zm_vault_info.var_9e2da6c350db19e6 ) )
    {
        level thread [[ level.zm_vault_info.var_9e2da6c350db19e6 ]]( self );
    }
    
    val::reset_all( "zm_vault_unlock" );
    blast_nearby_enemies( 1, 1, 0 );
    callback::remove( #"player_death", &function_dda7366724a715d6 );
    thread function_9a6f5b759a6ecb82();
}

// Namespace zm_vault
// Params 2
// Checksum 0x4f340ee8, Offset: 0x154a
// Size: 0x7e
function function_64a58cd635805010( var_6f1a82b73d7d6094, str_end_msg )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( isdefined( str_end_msg ) )
    {
        self endon( str_end_msg );
    }
    
    while ( self.var_1946560132e8d336 )
    {
        if ( var_6f1a82b73d7d6094 )
        {
            self playsoundtoplayer( #"hash_9a83ce5da0e5e56d", self );
        }
        else
        {
            self playsoundtoplayer( #"hash_fc4cc1352a8de4af", self );
        }
        
        wait 1;
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0xcc69eafd, Offset: 0x15d0
// Size: 0x13a
function function_a14d393963c271cc( var_a4a4200b07b39ed0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.zm_vault_info.a_vault_zone ) )
    {
        return;
    }
    
    while ( self.var_1946560132e8d336 )
    {
        self waittill( #"zone_changed", zone_name );
        
        if ( self.var_1946560132e8d336 && !arraycontains( level.zm_vault_info.a_vault_zone, zone_name ) )
        {
            self notify( #"hash_d76e25604e3325c2" );
            self.var_1946560132e8d336 = 0;
            self setclientomnvar( "ui_zm_is_in_vault", 0 );
            
            if ( threatbiasgroupexists( "player_team" ) )
            {
                self setthreatbiasgroup( "player_team" );
            }
            
            if ( isdefined( level.zm_vault_info.var_9e2da6c350db19e6 ) )
            {
                level thread [[ level.zm_vault_info.var_9e2da6c350db19e6 ]]( self );
            }
            
            val::reset_all( "zm_vault_unlock" );
            
            if ( isdefined( var_a4a4200b07b39ed0 ) )
            {
                val::reset_all( var_a4a4200b07b39ed0 );
            }
            
            thread function_9a6f5b759a6ecb82();
            callback::remove( #"player_death", &function_dda7366724a715d6 );
        }
    }
}

// Namespace zm_vault
// Params 0
// Checksum 0x31ea6534, Offset: 0x1712
// Size: 0x47
function function_d2fc93a923951674()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_8f257ac5b2dfd3ba" );
    
    while ( true )
    {
        self waittill( #"equipment_given" );
    }
}

// Namespace zm_vault
// Params 0
// Checksum 0x7d423b6b, Offset: 0x1761
// Size: 0x60
function function_9a6f5b759a6ecb82()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_1ac2df4b3ea940a5" );
    self notify( #"hash_8f257ac5b2dfd3ba" );
    self.var_f08775337dde635e = 1;
    level waittill( #"round_started" );
    self.var_f08775337dde635e = 0;
    self notify( #"hash_1ac2df4b3ea940a5" );
}

// Namespace zm_vault
// Params 3
// Checksum 0xa6107f7c, Offset: 0x17c9
// Size: 0x8d
function blast_nearby_enemies( var_8473f30fa3f8a348 = 1, var_79aebce64a2c1ae4 = 1, b_forceannihilate = 0 )
{
    level endon( #"game_ended" );
    self playsoundevent( %"sndevent_vault_clear_blast" );
    playfxontag( level._effect[ "bank_vault_blast" ], self, "tag_origin" );
    wait 0.5;
    zm_quest::function_835556fe63cd2edd( self.origin, 1000, 0, 1, var_8473f30fa3f8a348, var_79aebce64a2c1ae4, b_forceannihilate );
}

// Namespace zm_vault
// Params 1
// Checksum 0x41b9ccf3, Offset: 0x185e
// Size: 0x12f
function function_d60cb6d491afd823( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( self.my_model.b_is_opened == 0 )
    {
        if ( player function_a478625651e7cd86() )
        {
            self.my_model.b_is_opened = 1;
            player.var_d00ff91a47ca160b = 1;
            player function_c4ac5ad310655c9f( self );
            
            switch ( player.n_loot_key_level )
            {
                case 1:
                    self.sfx_agent setscriptablepartstate( "base", "sfx_use_key_sml" );
                    break;
                case 2:
                    self.sfx_agent setscriptablepartstate( "base", "sfx_use_key_med" );
                    break;
                case 3:
                    self.sfx_agent setscriptablepartstate( "base", "sfx_use_key_lrg" );
                    break;
                case 4:
                    self.sfx_agent setscriptablepartstate( "base", "sfx_use_key_gld" );
                    break;
            }
            
            player thread function_8c01a44060609902( self );
        }
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0xf5c138a5, Offset: 0x1995
// Size: 0xcd
function function_c4ac5ad310655c9f( interact )
{
    if ( self.n_loot_key_level != 4 )
    {
        return;
    }
    
    if ( !isdefined( self.var_74bd92dbc461b998 ) )
    {
        self.var_74bd92dbc461b998 = [];
    }
    
    if ( !isdefined( level.var_da2ec466f927a897 ) )
    {
        return;
    }
    
    self.var_74bd92dbc461b998[ self.var_74bd92dbc461b998.size ] = interact.var_8ec231e91dc8538b;
    
    if ( self.var_74bd92dbc461b998[ self.var_74bd92dbc461b998.size - 1 ] == level.var_da2ec466f927a897[ self.var_74bd92dbc461b998.size - 1 ] )
    {
        if ( self.var_74bd92dbc461b998.size == level.var_da2ec466f927a897.size )
        {
            self.var_2ba2ce5249618194 = 1;
            self.var_74bd92dbc461b998 = [];
        }
        
        return;
    }
    
    self.var_74bd92dbc461b998 = [];
}

// Namespace zm_vault
// Params 1
// Checksum 0xbc59a19, Offset: 0x1a6a
// Size: 0x148
function move_player_backward( interact )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_2366cab6df93ac3b = utility::spawn_model( "tag_origin", self.origin, self.angles );
    var_3265d1dcc32a45b3 = utility::getstructarray( interact.target, "targetname" );
    
    foreach ( loc in var_3265d1dcc32a45b3 )
    {
        if ( loc.script_noteworthy == "back_loc" )
        {
            s_move_des = loc;
            break;
        }
    }
    
    self playerlinkto( var_2366cab6df93ac3b );
    var_2366cab6df93ac3b rotateto( s_move_des.angles, 0.1 );
    wait 0.1;
    var_2366cab6df93ac3b moveto( s_move_des.origin, 0.1 );
    var_2366cab6df93ac3b waittill( #"movedone" );
    var_2366cab6df93ac3b delete();
}

// Namespace zm_vault
// Params 1
// Checksum 0x5b8f7aeb, Offset: 0x1bba
// Size: 0x19c
function function_8c01a44060609902( interact )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    interact.my_model thread function_ab43a3c963061e5f( self );
    sparams = spawnstruct();
    
    if ( isdefined( self.n_loot_key_level ) && self.n_loot_key_level != 0 )
    {
        sparams.var_41f8529e24f6fb4b = self.n_loot_key_level;
    }
    
    sparams.owner = self;
    callback::callback( "lootkey_used", sparams );
    callback::callback( "remove_lootkey" );
    wait 0.5;
    
    if ( isdefined( interact.my_model.var_59c94ba8facd11a9 ) )
    {
        interact.my_model [[ interact.my_model.var_59c94ba8facd11a9 ]]();
    }
    else
    {
        interact.my_model.sbl setscriptablepartstate( "anim", "open" );
    }
    
    if ( isdefined( interact.my_model.var_35fc490cc2adf4ae ) )
    {
        self [[ interact.my_model.var_35fc490cc2adf4ae ]]( interact );
    }
    else
    {
        str_drop_list = item_lootkey::get_lootkey_reward_list( self.n_loot_key_level );
        
        if ( !isdefined( str_drop_list ) )
        {
            return;
        }
        
        function_bf900b34390eff55( str_drop_list, interact.my_model.s_vault_cache_pos.origin );
        self.n_loot_key_level = 0;
    }
    
    self.var_d00ff91a47ca160b = 0;
}

// Namespace zm_vault
// Params 2
// Checksum 0xd98bd57c, Offset: 0x1d5e
// Size: 0x185
function function_a1cff74ef82859fa( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.my_model.b_is_opened == 1 || !player.var_1946560132e8d336 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( player ) && player.n_loot_key_level > 0 )
    {
        if ( level.mapname == "zm_t10_quartz" || level.mapname == "zm_t10_topaz" )
        {
            return { #string:&"ZM_T10_QUARTZ/ARMORY_OPEN_SAFE", #type:"HINT_NOICON" };
        }
        
        return { #string:&"ZM_T10_GARNET/SQ_BANK_VAULT_OPEN_SAFE", #type:"HINT_NOICON" };
    }
    
    if ( level.mapname == "zm_t10_quartz" || level.mapname == "zm_t10_topaz" )
    {
        return { #string:&"ZM_T10_QUARTZ/ARMORY_NO_KEY", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"ZM_T10_GARNET/SQ_BANK_VAULT_NO_KEY", #type:"HINT_NOBUTTON" };
}

// Namespace zm_vault
// Params 0
// Checksum 0x5204abee, Offset: 0x1eeb
// Size: 0x23, Type: bool
function function_a478625651e7cd86()
{
    if ( !isdefined( self.n_loot_key_level ) || self.n_loot_key_level == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_vault
// Params 1
// Checksum 0xdd668f7d, Offset: 0x1f17
// Size: 0x105
function function_ab43a3c963061e5f( opener )
{
    level endon( #"game_ended" );
    opener endon( #"death_or_disconnect" );
    
    if ( isdefined( self.var_f1f038800a8b989d ) )
    {
        self thread [[ self.var_f1f038800a8b989d ]]( opener );
        return;
    }
    
    self.sbl setscriptablepartstate( "base", "no_outline" );
    self.interact utility::function_7c10ea82c1e305b8( "base", "off" );
    opener waittill( #"hash_856281cfe4852869" );
    level waittill( #"on_round_start" );
    n_move_time = 0.2;
    self.sbl setscriptablepartstate( "anim", "close" );
    wait n_move_time;
    self.b_is_opened = 0;
    self.sbl setscriptablepartstate( "base", "outline" );
    self.interact utility::function_7c10ea82c1e305b8( "base", self.interact.radius_type );
}

// Namespace zm_vault
// Params 3
// Checksum 0xeba2f06c, Offset: 0x2024
// Size: 0x116
function createclientfontstring( text, font, fontscale )
{
    fontelem = newclienthudelem( self );
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.color = ( 1, 1, 1 );
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem settext( text );
    return fontelem;
}

// Namespace zm_vault
// Params 3
// Checksum 0xab49fdcb, Offset: 0x2143
// Size: 0x2b
function function_bf900b34390eff55( listbundlename, origin, forced_reward )
{
    function_5b1a2380e7241363( origin, listbundlename, self, forced_reward );
}

// Namespace zm_vault
// Params 7
// Checksum 0x9f21963, Offset: 0x2176
// Size: 0x4ad
function function_5b1a2380e7241363( position, var_e9564cd22ae43276, player, forced_item, var_770007a8047d20ab, var_981d8974bc1eefc6, b_auto_open = 0 )
{
    reward_level = item_lootkey::get_lootkey_reward_level( var_e9564cd22ae43276 );
    item_count = round( 4 / reward_level ) + 1;
    item_count = clamp( item_count, 1, 4 );
    item_count = int( item_count );
    inventory_group = %"hash_22a1c93ef87752f3";
    var_aaf013937e69a716 = function_c11af7a197679429( var_e9564cd22ae43276, item_count );
    weapon_bundle_replacement = undefined;
    
    if ( isdefined( forced_item ) )
    {
        if ( common_item::function_3cba34a99d02cd9( forced_item ) == "weapon" )
        {
            inventory_group = %"hash_360b62fa9b31d0d9";
            weapon_bundle_replacement = forced_item;
        }
        else
        {
            var_aaf013937e69a716[ var_aaf013937e69a716.size ] = forced_item;
        }
    }
    
    if ( isdefined( var_770007a8047d20ab ) )
    {
        if ( common_item::function_498ad287e390e8bc( var_770007a8047d20ab ) )
        {
            var_720797fdf44c7ef1 = var_770007a8047d20ab;
        }
        else
        {
            var_4cabd7415c39d332 = var_770007a8047d20ab;
        }
    }
    
    if ( function_f58c446d53f972b2( var_e9564cd22ae43276 ) && forced_item != %"itemspawnentry:zm_t10_item_weapon_pi_raygun" && var_720797fdf44c7ef1 != "weapon" && var_4cabd7415c39d332 != %"itemspawnentry:zm_t10_item_weapon_pi_raygun" )
    {
        inventory_group = %"hash_360b62fa9b31d0d9";
        weapon_bundle_replacement = %"itemspawnentry:zm_t10_item_weapon_pi_raygun";
    }
    else if ( function_d8612a5c4d34f5cb( var_e9564cd22ae43276 ) && !arraycontains( [ %"itemspawnentry:zm_t10_item_aether_tool", %"itemspawnentry:zm_t10_item_aether_tool_2", %"itemspawnentry:zm_t10_item_aether_tool_3", %"itemspawnentry:zm_t10_item_aether_tool_4" ], forced_item ) && !arraycontains( [ %"itemspawnentry:zm_t10_item_aether_tool", %"itemspawnentry:zm_t10_item_aether_tool_2", %"itemspawnentry:zm_t10_item_aether_tool_3", %"itemspawnentry:zm_t10_item_aether_tool_4" ], var_4cabd7415c39d332 ) )
    {
        inventory_group = %"hash_22a1c93ef87752f3";
        var_b364816233e8a012 = int( clamp( reward_level, 0, 3 ) );
        weapon_bundle_replacement = [ %"itemspawnentry:zm_t10_item_aether_tool", %"itemspawnentry:zm_t10_item_aether_tool_2", %"itemspawnentry:zm_t10_item_aether_tool_3", %"itemspawnentry:zm_t10_item_aether_tool_4" ][ var_b364816233e8a012 ];
    }
    else if ( var_720797fdf44c7ef1 == "weapon" )
    {
        inventory_group = %"hash_22a1c93ef87752f3";
        weapon_bundle_replacement = function_5e1cfbda20e418b7( var_e9564cd22ae43276 );
    }
    
    b_weapon_limit = 0;
    num_item_names = var_aaf013937e69a716.size;
    
    for ( i = 0; i < num_item_names ; i++ )
    {
        item_name = var_aaf013937e69a716[ i ];
        
        if ( common_item::function_3cba34a99d02cd9( item_name ) != "weapon" )
        {
            if ( !isdefined( var_720797fdf44c7ef1 ) && !isdefined( var_4cabd7415c39d332 ) )
            {
                continue;
            }
            else if ( isdefined( var_720797fdf44c7ef1 ) && common_item::function_3cba34a99d02cd9( item_name ) != var_720797fdf44c7ef1 )
            {
                continue;
            }
            else if ( isdefined( var_4cabd7415c39d332 ) && item_name != var_4cabd7415c39d332 )
            {
                continue;
            }
        }
        
        if ( !isdefined( weapon_bundle_replacement ) && !b_weapon_limit )
        {
            inventory_group = %"hash_360b62fa9b31d0d9";
            b_weapon_limit = 1;
            continue;
        }
        
        var_aaf013937e69a716[ i ] = undefined;
    }
    
    var_aaf013937e69a716 = function_5713d46873b29625( var_aaf013937e69a716 );
    
    if ( isdefined( weapon_bundle_replacement ) )
    {
        if ( var_aaf013937e69a716.size == item_count )
        {
            var_aaf013937e69a716[ 0 ] = undefined;
            var_aaf013937e69a716 = function_5713d46873b29625( var_aaf013937e69a716 );
        }
        
        var_aaf013937e69a716[ var_aaf013937e69a716.size ] = weapon_bundle_replacement;
    }
    
    interact = common_cache::function_74364c32a1e82886( inventory_group, position, 50, &function_d910678a10dc30db );
    interact sethintonobstruction( "show" );
    
    for ( i = 0; i < var_aaf013937e69a716.size ; i++ )
    {
        item_name = var_aaf013937e69a716[ i ];
        
        if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
        {
            scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
            weaponname = scriptbundlestruct.baseweapon;
            rarity = scriptbundlestruct.rarity;
            favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
            
            if ( isdefined( favoriteweapon ) )
            {
                var_aaf013937e69a716[ i ] = undefined;
                item_bundle_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                weapondata.rarity = rarity;
                weapondata.weaponobj = favoriteweapon;
                common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_bundle_name, undefined, undefined, undefined, weapondata );
            }
        }
    }
    
    common_cache::function_6e9defb713a31012( interact.cache, player, var_aaf013937e69a716, 1 );
    
    if ( b_auto_open )
    {
        interact thread common_cache::function_4cf6a3c4374a7ae3( player );
    }
    
    thread function_2af08d422c9ec7ad( interact );
    thread function_596935caf8abb6cd( interact, player );
    return interact;
}

// Namespace zm_vault
// Params 1
// Checksum 0x55278541, Offset: 0x262c
// Size: 0x1b0
function function_5e1cfbda20e418b7( var_e9564cd22ae43276 )
{
    s_bundle = getscriptbundle( var_e9564cd22ae43276 );
    
    if ( isarray( s_bundle.itemlistentries ) )
    {
        foreach ( var_8fe1c40c3cabe229 in s_bundle.itemlistentries )
        {
            if ( !isdefined( var_8fe1c40c3cabe229.itemspawnlist ) )
            {
                continue;
            }
            
            var_e9564cd22ae43276 = hashcat( %"itemspawnlist:", var_8fe1c40c3cabe229.itemspawnlist );
            var_aaf013937e69a716 = function_c11af7a197679429( var_e9564cd22ae43276, 1 );
            
            if ( common_item::function_3cba34a99d02cd9( var_aaf013937e69a716[ 0 ] ) != "weapon" )
            {
                return var_aaf013937e69a716[ 0 ];
            }
        }
    }
    
    if ( !isdefined( s_bundle.itementries ) )
    {
        s_bundle.itementries = [];
    }
    
    foreach ( s_itemspawnentry in s_bundle.itementries )
    {
        if ( !isdefined( s_itemspawnentry ) )
        {
            continue;
        }
        
        if ( common_item::function_3cba34a99d02cd9( s_itemspawnentry.itemspawnentry ) != "weapon" )
        {
            return s_itemspawnentry.itemspawnentry;
        }
    }
}

// Namespace zm_vault
// Params 2
// Checksum 0xcb193a7e, Offset: 0x27e5
// Size: 0x40
function function_d910678a10dc30db( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/open_cache", #type:"HINT_BUTTON" };
}

// Namespace zm_vault
// Params 1, eflags: 0x4
// Checksum 0x993eb911, Offset: 0x282e
// Size: 0x47
function private function_2af08d422c9ec7ad( interact )
{
    level endon( #"game_ended" );
    level endon( #"round_started" );
    interact.cache waittill( #"death" );
    
    if ( interact )
    {
        interact delete();
    }
}

// Namespace zm_vault
// Params 2, eflags: 0x4
// Checksum 0xbe0f4fce, Offset: 0x287d
// Size: 0x6b
function private function_596935caf8abb6cd( interact, player )
{
    level endon( #"game_ended" );
    interact endon( #"death" );
    interact.cache endon( #"death" );
    player endon( #"death_or_disconnect" );
    player waittill( #"hash_856281cfe4852869" );
    
    if ( interact )
    {
        interact delete();
    }
}

// Namespace zm_vault
// Params 1
// Checksum 0x299cbbc2, Offset: 0x28f0
// Size: 0xc6
function function_f58c446d53f972b2( var_f99d6834181a056a )
{
    if ( self.var_2ba2ce5249618194 )
    {
        n_drop_chance = 65;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb2f05feb9a16 )
    {
        n_drop_chance = 0.5;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb1f05feb97e3 )
    {
        n_drop_chance = 1;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb0f05feb95b0 )
    {
        n_drop_chance = 3;
    }
    else
    {
        n_drop_chance = 5;
    }
    
    if ( self.var_2ba2ce5249618194 )
    {
        self.var_2ba2ce5249618194 = 0;
    }
    
    if ( getdvarint( @"hash_8a0b982dd4c566e5", 0 ) )
    {
        n_drop_chance = 100;
    }
    
    return utility::percent_chance( n_drop_chance );
}

// Namespace zm_vault
// Params 1
// Checksum 0xdb944f49, Offset: 0x29bf
// Size: 0xc6
function function_d8612a5c4d34f5cb( var_f99d6834181a056a )
{
    if ( self.var_f82c92e83b6d6c7b )
    {
        n_drop_chance = 65;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb2f05feb9a16 )
    {
        n_drop_chance = 0.5;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb1f05feb97e3 )
    {
        n_drop_chance = 1;
    }
    else if ( var_f99d6834181a056a == level.lootkeybundle.var_43bfb0f05feb95b0 )
    {
        n_drop_chance = 3;
    }
    else
    {
        n_drop_chance = 5;
    }
    
    if ( self.var_f82c92e83b6d6c7b )
    {
        self.var_f82c92e83b6d6c7b = 0;
    }
    
    if ( getdvarint( @"hash_11a556f3624bcaf0", 0 ) )
    {
        n_drop_chance = 100;
    }
    
    return utility::percent_chance( n_drop_chance );
}

// Namespace zm_vault
// Params 1
// Checksum 0x5b206ca7, Offset: 0x2a8e
// Size: 0x55
function on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) && isdefined( params.zone_struct.zone_name ) )
    {
        self notify( #"zone_changed", params.zone_struct.zone_name );
    }
}

/#

    // Namespace zm_vault
    // Params 0
    // Checksum 0xf1d8947, Offset: 0x2aeb
    // Size: 0x5a, Type: dev
    function init_bank_vault_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4b>" );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x5a>", &randomly_drop_key );
        devgui::add_devgui_func( "<dev string:x6c>", "<dev string:x7c>", &function_3440ca154bb86e19 );
        devgui::add_devgui_func( "<dev string:x8c>", "<dev string:x9e>", &function_dd5b00dc43f747e7 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_vault
    // Params 0
    // Checksum 0xbffc1afb, Offset: 0x2b4d
    // Size: 0x64, Type: dev
    function function_dd5b00dc43f747e7()
    {
        var_de871460bc51277b = level.players[ 0 ].origin;
        cache = common_cache::spawncache( %"hash_2d934d0d59034987", var_de871460bc51277b, ( 0, 0, 0 ) );
        common_cache::function_a136b84fc5c0dfab( cache, %"hash_444f827398b51b1b", 8, 1 );
    }

    // Namespace zm_vault
    // Params 0
    // Checksum 0xefb1dc3a, Offset: 0x2bb9
    // Size: 0x32, Type: dev
    function randomly_drop_key()
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
        common_item::function_38cde6a6acb68ea6( "<dev string:xb6>", 1, spawnoptions );
    }

    // Namespace zm_vault
    // Params 0
    // Checksum 0x1faf6f21, Offset: 0x2bf3
    // Size: 0x8f, Type: dev
    function function_3440ca154bb86e19()
    {
        foreach ( player in level.players )
        {
            player notify( #"hash_1ac2df4b3ea940a5" );
            player.var_f08775337dde635e = 0;
        }
    }

    // Namespace zm_vault
    // Params 1
    // Checksum 0xcd02d5e2, Offset: 0x2c8a
    // Size: 0x3c, Type: dev
    function function_29726a35a05d6028( params )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
        common_item::function_38cde6a6acb68ea6( "<dev string:xb6>", 1, spawnoptions );
    }

#/
