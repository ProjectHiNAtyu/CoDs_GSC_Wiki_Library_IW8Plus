// scripts\mp\zm\systems\relics\zm_relics.gsc  (hash_657e27b4628aaf50.gscc) (size: 14569 Bytes / 0x38e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6728f979 (1730738553)
// size ...... 14569 (0x38e9)
// includes .. 9   (offset: 0x349d)
// strings ... 67  (offset: 0x34e5)
// dev strs .. 9   (offset: 0x3871)
// exports ... 26  (offset: 0x2601)
// cseg ...... 0x8a3 + 0x1d5e (0x2601)
// imports ... 79  (offset: 0x2a11)
// animtree1 . 0   (offset: 0x38e9)
// animtree2 . 0   (offset: 0x38e9)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_relics;

// Namespace zm_relics
// Params 0, eflags: 0x5
// Checksum 0x54f0c2f4, Offset: 0x8c1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relics", undefined, undefined, &init_zm_relics );
}

// Namespace zm_relics
// Params 0
// Checksum 0x8ad9fa10, Offset: 0x8e2
// Size: 0x3a8
function init_zm_relics()
{
    if ( !getdvarint( @"hash_70ef86ad43e08120", 0 ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    logstring( "[R_MOD] ZM Relics System Enabled!" );
    utility::registersharedfunc( #"relics", #"hash_9264c89cf44e24ee", &function_9ee232e9e55c3939 );
    utility::registersharedfunc( #"relics", #"register_relic_functions", &register_relic_functions );
    utility::registersharedfunc( #"relics", #"hash_d2312c9999217d41", &function_f6ef95770f20fc2c );
    utility::registersharedfunc( #"relics", #"hash_a7c8a84866311024", &function_90442c590e60cb05 );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_spawned", &on_player_spawned );
    var_69d09d96b8f22349 = getscriptbundle( level.gamemodebundle.var_b7994ac1763d1e11 );
    var_6c0307fcd5dfac8b = getscriptbundle( var_69d09d96b8f22349.var_bba668e07957b2cf );
    var_1f75d76fc6408a26 = getscriptbundle( var_69d09d96b8f22349.var_57b3b809f2f1702c );
    var_101696f8e2a7ac3c = getscriptbundle( var_69d09d96b8f22349.var_b1f3974b871b7c6 );
    var_d77677713182251d = getscriptbundle( level.gamemodebundle.reliclist );
    level.zm_relic_tier_bundles[ "easy" ] = var_6c0307fcd5dfac8b;
    level.zm_relic_tier_bundles[ "medium" ] = var_1f75d76fc6408a26;
    level.zm_relic_tier_bundles[ "hard" ] = var_101696f8e2a7ac3c;
    level.zm_relics = [];
    level.zm_relic_modifiers = [];
    level.var_88970ec02bececd1 = [];
    level.active_relics = [];
    level.var_acf4b75304823180 = 0;
    level.zm_relic_tier = 0;
    
    foreach ( tier in var_69d09d96b8f22349.tiers )
    {
        tierinfo = getscriptbundle( tier.relictier );
        
        foreach ( var_2153e39e051f5b91 in tierinfo.relics )
        {
            if ( isdefined( var_2153e39e051f5b91.relicdata ) )
            {
                relic_bundle = getscriptbundle( var_2153e39e051f5b91.relicdata );
                relic_bundle.tier = tierinfo.tierlevel;
                relic_bundle.tierpower = tierinfo.pointvalue;
                level.zm_relics[ var_2153e39e051f5b91.relicdata ] = relic_bundle;
            }
        }
    }
    
    for ( i = 0; i < var_d77677713182251d.relics.size ; i++ )
    {
        var_2153e39e051f5b91 = var_d77677713182251d.relics[ i ];
        
        if ( isdefined( var_2153e39e051f5b91.relicdata ) )
        {
            level.var_88970ec02bececd1[ var_2153e39e051f5b91.relicdata ] = i;
        }
    }
    
    level notify( #"hash_38487d69ab8cc844" );
    
    /#
        level thread setup_relics_devgui();
    #/
}

// Namespace zm_relics
// Params 0
// Checksum 0xb6463ad9, Offset: 0xc92
// Size: 0x1e6
function activate_relics()
{
    var_acf4b75304823180 = 0;
    var_c81319ca84fb4a02 = 0;
    
    for ( i = 0; i < 30 ; i++ )
    {
        relic_name = level.active_relics[ i ];
        dvar_name = hashcat( @"hash_9cf051c5ca1a59b", i );
        relic_override = getdvar( dvar_name );
        
        if ( relic_override )
        {
            relic_name = getxhashasset( relic_override );
            level.active_relics[ i ] = relic_name;
        }
        
        if ( relic_name && level.zm_relics[ relic_name ] )
        {
            if ( !function_9ee232e9e55c3939( level.zm_relics[ relic_name ].modifiertype ) )
            {
                tierpower = level.zm_relics[ relic_name ].tierpower;
                
                if ( tierpower )
                {
                    var_acf4b75304823180 += tierpower;
                }
                
                function_a679fb14a3fcb594( level.zm_relics[ relic_name ] );
                level thread utility::callsharedfunc( level.zm_relics[ relic_name ].modifiertype, #"hash_3802c55cdf341a6b" );
                logstring( "[R_MOD] Relic Activated " + relic_name + " , " + level.zm_relics[ relic_name ].lootid );
                var_b802dd8528f0ab63 = level.var_88970ec02bececd1[ relic_name ];
                
                if ( var_b802dd8528f0ab63 >= 0 && var_b802dd8528f0ab63 < 30 )
                {
                    var_c81319ca84fb4a02 |= 1 << var_b802dd8528f0ab63;
                }
            }
        }
    }
    
    if ( level.var_d73c5ded92f4f4bd && var_acf4b75304823180 < 9 )
    {
        var_acf4b75304823180 = max( var_acf4b75304823180, 9 );
    }
    
    if ( hasomnvar( o"ui_zm_active_relics_list" ) )
    {
        setomnvar( o"ui_zm_active_relics_list", var_c81319ca84fb4a02 );
    }
    
    level.var_acf4b75304823180 = var_acf4b75304823180;
    level function_600d3110fc691635( var_acf4b75304823180 );
    level callback::callback( #"relics_activated" );
}

// Namespace zm_relics
// Params 0
// Checksum 0xa961222c, Offset: 0xe80
// Size: 0x10f
function function_8603fa8bc8d11175()
{
    for ( i = 0; i < 30 ; i++ )
    {
        relic_name = level.active_relics[ i ];
        dvar_name = hashcat( @"hash_9cf051c5ca1a59b", i );
        relic_override = getdvar( dvar_name );
        
        if ( relic_override )
        {
            relic_name = getxhashasset( relic_override );
        }
        
        if ( relic_name && level.zm_relics[ relic_name ] )
        {
            if ( function_9ee232e9e55c3939( level.zm_relics[ relic_name ].modifiertype ) && !level.zm_relics[ relic_name ].var_a618fca68a25392d )
            {
                function_7231125c7dc64d83( level.zm_relics[ relic_name ] );
                level thread utility::callsharedfunc( level.zm_relics[ relic_name ].modifiertype, #"hash_eb4ac69bf458f466" );
            }
        }
    }
    
    level notify( #"relics_deactivated" );
    level callback::callback( #"relics_deactivated" );
}

// Namespace zm_relics
// Params 1, eflags: 0x4
// Checksum 0x5b1e379e, Offset: 0xf97
// Size: 0x18b
function private function_600d3110fc691635( var_7bd746a6e6cb6f16 )
{
    dvartier = getdvarint( @"force_zm_relic_tier", 0 );
    var_6f7271c66f5b7c10 = 0;
    
    if ( dvartier > 0 )
    {
        switch ( dvartier )
        {
            case 1:
                var_7bd746a6e6cb6f16 = 3;
                break;
            case 2:
                var_7bd746a6e6cb6f16 = 6;
                break;
            case 3:
                var_7bd746a6e6cb6f16 = 9;
                break;
        }
    }
    
    level.zm_relic_tier = 0;
    
    if ( !isdefined( var_7bd746a6e6cb6f16 ) )
    {
        return;
    }
    
    if ( var_7bd746a6e6cb6f16 >= 3 )
    {
        level.zm_relic_tier = 1;
    }
    
    if ( var_7bd746a6e6cb6f16 >= 6 )
    {
        level.zm_relic_tier = 2;
        level.var_48e2b36291b57f44 = 5;
        var_6f7271c66f5b7c10 = 1;
        utility::registersharedfunc( #"relics", #"hash_459bf078b969217d", &function_f09353885602ac5e );
    }
    else
    {
        level.var_48e2b36291b57f44 = 4;
        var_6f7271c66f5b7c10 = 0;
        utility::clearsharedfunc( #"relics", #"hash_459bf078b969217d" );
    }
    
    if ( var_7bd746a6e6cb6f16 >= 9 )
    {
        level.zm_relic_tier = 3;
        level.var_eda995bb839c4aa = 4;
    }
    else
    {
        level.var_eda995bb839c4aa = 3;
    }
    
    logstring( "[R_MOD] Relic Tier " + level.zm_relic_tier + " set" );
    setomnvar( "ui_show_weapon_upgrade_tier_5", var_6f7271c66f5b7c10 );
    
    if ( hasomnvar( "ui_zm_relic_tier" ) )
    {
        setomnvarforallclients( "ui_zm_relic_tier", level.zm_relic_tier ?? 0 );
    }
    
    level notify( #"relic_level_set" );
}

// Namespace zm_relics
// Params 1
// Checksum 0xa1f1edbc, Offset: 0x112a
// Size: 0xe0
function function_3c4c699ae2f0f4c0( var_fc41eca063b9cd54 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_acf4b75304823180 = 0;
    
    for ( i = 0; i < 30 ; i++ )
    {
        relicname = self getplayerdata( level.loadoutdata, "relicRefs", i );
        
        if ( relicname != %"" )
        {
            tierpower = level.zm_relics[ relicname ].tierpower;
            
            if ( tierpower )
            {
                var_acf4b75304823180 += tierpower;
                
                if ( var_fc41eca063b9cd54 )
                {
                    logstring( "[R_MOD] Player: " + self.name + " has relic equipped in loadouts to calculate tier power: " + relicname + " , " + level.zm_relics[ relicname ].lootid );
                }
            }
        }
    }
    
    return function_d9c278a74fb2ce12( var_acf4b75304823180 ) ?? 0;
}

// Namespace zm_relics
// Params 1
// Checksum 0x9b53aa23, Offset: 0x1213
// Size: 0x2e
function function_d9c278a74fb2ce12( var_7bd746a6e6cb6f16 )
{
    if ( var_7bd746a6e6cb6f16 >= 9 )
    {
        return 3;
    }
    
    if ( var_7bd746a6e6cb6f16 >= 6 )
    {
        return 2;
    }
    
    if ( var_7bd746a6e6cb6f16 >= 3 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_relics
// Params 1
// Checksum 0x42ae288, Offset: 0x124a
// Size: 0x19, Type: bool
function function_9ee232e9e55c3939( var_ce0eb494afc89c78 )
{
    return isdefined( level.zm_relic_modifiers[ var_ce0eb494afc89c78 ] );
}

// Namespace zm_relics
// Params 1
// Checksum 0x2c9338bf, Offset: 0x126c
// Size: 0x32
function function_a679fb14a3fcb594( relic_bundle )
{
    if ( relic_bundle.modifiertype )
    {
        level.zm_relic_modifiers[ relic_bundle.modifiertype ] = relic_bundle;
    }
}

// Namespace zm_relics
// Params 1
// Checksum 0xae503ca8, Offset: 0x12a6
// Size: 0x21
function function_7231125c7dc64d83( relic_bundle )
{
    level.zm_relic_modifiers[ relic_bundle.modifiertype ] = undefined;
}

// Namespace zm_relics
// Params 1
// Checksum 0x15451b27, Offset: 0x12cf
// Size: 0x7a
function function_d0c08a0a6af33ba3( tier )
{
    difficulty = "";
    
    switch ( tier )
    {
        case 1:
            difficulty = "easy";
            break;
        case 2:
            difficulty = "medium";
            break;
        case 3:
            difficulty = "hard";
            break;
        default:
            break;
    }
    
    return difficulty;
}

// Namespace zm_relics
// Params 3
// Checksum 0xf0b9fb38, Offset: 0x1352
// Size: 0x46
function register_relic_functions( modifier_hash, var_101741bd5f07d40a, var_336e572560f614f7 )
{
    utility::registersharedfunc( modifier_hash, #"hash_3802c55cdf341a6b", var_101741bd5f07d40a );
    utility::registersharedfunc( modifier_hash, #"hash_eb4ac69bf458f466", var_336e572560f614f7 );
}

// Namespace zm_relics
// Params 1
// Checksum 0x9145766b, Offset: 0x13a0
// Size: 0x17d
function function_f6ef95770f20fc2c( relic_bundle )
{
    if ( !isdefined( relic_bundle ) )
    {
        return;
    }
    
    if ( function_9ee232e9e55c3939( relic_bundle.modifiertype ) )
    {
        return;
    }
    
    function_a679fb14a3fcb594( relic_bundle );
    level thread utility::callsharedfunc( relic_bundle.modifiertype, #"hash_3802c55cdf341a6b" );
    relic_name = loot::function_f54ecb89dfab8e8c( relic_bundle.lootid );
    relic_hash = getxhashasset( "relic:" + relic_name );
    level.var_c81319ca84fb4a02 = level.var_c81319ca84fb4a02 ?? 0;
    logstring( "[R_MOD] Relic Activated " + relic_hash + " , " + level.zm_relics[ relic_hash ].lootid );
    var_b802dd8528f0ab63 = level.var_88970ec02bececd1[ relic_hash ];
    
    if ( var_b802dd8528f0ab63 >= 0 && var_b802dd8528f0ab63 < 30 )
    {
        level.var_c81319ca84fb4a02 |= 1 << var_b802dd8528f0ab63;
    }
    
    if ( hasomnvar( o"ui_zm_active_relics_list" ) )
    {
        setomnvar( o"ui_zm_active_relics_list", level.var_c81319ca84fb4a02 );
    }
    
    level.var_acf4b75304823180 += level.zm_relics[ relic_hash ].tierpower;
    level function_600d3110fc691635( level.var_acf4b75304823180 );
    level.active_relics = arraycombineunique( level.active_relics, [ relic_hash ] );
}

// Namespace zm_relics
// Params 1
// Checksum 0x11a4cafc, Offset: 0x1525
// Size: 0xbc
function function_90442c590e60cb05( relic_bundle )
{
    if ( !isdefined( relic_bundle ) )
    {
        return;
    }
    
    if ( !function_9ee232e9e55c3939( relic_bundle.modifiertype ) )
    {
        return;
    }
    
    relic_name = loot::function_f54ecb89dfab8e8c( relic_bundle.lootid );
    relic_hash = getxhashasset( "relic:" + relic_name );
    level.var_acf4b75304823180 -= level.zm_relics[ relic_hash ].tierpower;
    level function_600d3110fc691635( level.var_acf4b75304823180 );
    function_7231125c7dc64d83( relic_bundle );
    level thread utility::callsharedfunc( relic_bundle.modifiertype, #"hash_eb4ac69bf458f466" );
}

// Namespace zm_relics
// Params 1, eflags: 0x4
// Checksum 0xe07a7f3b, Offset: 0x15e9
// Size: 0x10a
function private on_player_connect( params )
{
    if ( level.onlinegame )
    {
        if ( !self isfireteamleader() )
        {
            return;
        }
    }
    
    if ( level.gametypebundle.var_30aa49931c90db80 )
    {
        logstring( "[R_MOD] This gametype has disabled relic loadouts, skipping relic host acceptance for players" );
        return;
    }
    
    var_4c0546fc111ae20a = getdvarint( @"hash_d6ebec1494a1d3e", 10000 );
    
    if ( !level.var_19895bd1ee8d1355 )
    {
        logstring( "[R_MOD] Relics host acceptance started at: " + gettime() + "ms , with cutoff after: " + var_4c0546fc111ae20a + "ms" );
        level thread function_b75d41b9fd1f6418( self );
        level.var_19895bd1ee8d1355 = gettime();
    }
    
    var_850a8c8ee4021744 = abs( gettime() - level.var_19895bd1ee8d1355 ) <= var_4c0546fc111ae20a;
    
    if ( var_850a8c8ee4021744 )
    {
        if ( !isdefined( level.var_3b75e07ce6ab919f ) )
        {
            level.var_3b75e07ce6ab919f = [];
        }
        
        level.var_3b75e07ce6ab919f[ level.var_3b75e07ce6ab919f.size ] = self;
        logstring( "[R_MOD] Player: " + self.name + " has been accepted as a possible host" );
    }
}

// Namespace zm_relics
// Params 0, eflags: 0x4
// Checksum 0x95d74451, Offset: 0x16fb
// Size: 0x1e8
function private function_f71b1f42ab93ba49()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !level.var_1e5fece4732c78aa )
    {
        logstring( "[R_MOD] Activating relics from chosen Host Player: " + self.name );
        level.active_relics = [];
        level.var_1e5fece4732c78aa = 1;
        
        for ( i = 0; i < 30 ; i++ )
        {
            if ( isplayer( self ) )
            {
                relicname = self getplayerdata( level.loadoutdata, "relicRefs", i );
                
                if ( relicname != %"" )
                {
                    level.active_relics[ i ] = relicname;
                    logstring( "[R_MOD] Host Player: " + self.name + " has relic equipped in loadouts to activate: " + relicname + " , " + level.zm_relics[ relicname ].lootid );
                }
            }
        }
        
        if ( zm_save::function_fcccc3d2a616b1c7() && isplayer( self ) )
        {
            level.active_relics = zm_save::get_active_relics();
            logstring( "[R_MOD] " + self.name + " has relics from a save file, overriding relics equipped...!" );
            
            foreach ( var_2153e39e051f5b91 in level.active_relics )
            {
                if ( isplayer( self ) )
                {
                    logstring( "[R_MOD] " + self.name + " has relic loaded from save: " + var_2153e39e051f5b91 + " , " + level.zm_relics[ var_2153e39e051f5b91 ].lootid );
                }
            }
        }
        
        level notify( #"hash_9ba9308ab275e18b" );
        activate_relics();
        
        if ( isplayer( self ) )
        {
            function_a4cda1b0408df7aa();
        }
    }
}

// Namespace zm_relics
// Params 1, eflags: 0xc
// Checksum 0xdea35381, Offset: 0x18eb
// Size: 0x161
function private function_b75d41b9fd1f6418( var_9ad0e0906274fad3 )
{
    self notify( #"hash_ac3e5e0728146f9" );
    self endon( #"hash_ac3e5e0728146f9" );
    level endon( #"game_ended" );
    
    if ( !level.onlinegame )
    {
        logstring( "[R_MOD] Activating relics for local game" );
        var_9ad0e0906274fad3 thread function_f71b1f42ab93ba49();
        return;
    }
    
    maxplayers = getdvarint( @"party_maxplayers", 0 );
    
    if ( maxplayers == 1 )
    {
        logstring( "[R_MOD] Activating relics for solo game" );
        
        if ( isplayer( var_9ad0e0906274fad3 ) )
        {
            var_9ad0e0906274fad3 thread function_f71b1f42ab93ba49();
        }
        
        return;
    }
    else if ( function_7a3d4348b3110c54() )
    {
        logstring( "[R_MOD] Activating relics for private/single party game" );
        
        if ( isplayer( var_9ad0e0906274fad3 ) )
        {
            var_9ad0e0906274fad3 thread function_f71b1f42ab93ba49();
        }
        
        return;
    }
    
    var_38fa0507e009ceaf = getdvarint( @"hash_d6ebec1494a1d3e", 10000 );
    var_fc840c72213e7bb5 = utility::function_6f5d2e1f1ff70482( var_38fa0507e009ceaf );
    logstring( "[R_MOD] Waiting for hosts to connect for public match..." );
    wait var_fc840c72213e7bb5;
    chosenhost = function_67dedd4dfe00a4ef( level.var_3b75e07ce6ab919f );
    
    if ( !isdefined( chosenhost ) )
    {
        logstring( "[R MOD] FAILED to find a host to activate zm_rb_r_mod relics system! Using random player!" );
        backup_players = arraycopy( level.players );
        backup_players = function_5713d46873b29625( backup_players );
        chosenhost = utility::array_random( backup_players );
    }
    
    if ( chosenhost )
    {
        chosenhost thread function_f71b1f42ab93ba49();
    }
    
    function_60456126ca4fb69f( level.var_3b75e07ce6ab919f );
}

// Namespace zm_relics
// Params 1, eflags: 0x4
// Checksum 0x3d960a33, Offset: 0x1a54
// Size: 0x546
function private function_67dedd4dfe00a4ef( var_12029aec2725403f )
{
    if ( !isarray( var_12029aec2725403f ) )
    {
        return;
    }
    
    var_12029aec2725403f = function_5713d46873b29625( var_12029aec2725403f );
    
    if ( !var_12029aec2725403f.size > 0 )
    {
        return;
    }
    
    chosenhost = utility::array_random( var_12029aec2725403f );
    logstring( "[R_MOD] {P0} " + chosenhost.name + " has been randomly chosen as base host to compare!" );
    baseparty = chosenhost getfireteammembers() ?? [];
    baseparty[ baseparty.size ] = chosenhost;
    var_40fc44ea1d7f9aa0 = [];
    var_6d993ca541dd6d8d = [];
    var_258684e3d67a36fe = chosenhost function_3c4c699ae2f0f4c0();
    largest_party_size = baseparty.size;
    
    foreach ( possible_host in var_12029aec2725403f )
    {
        if ( !isplayer( possible_host ) )
        {
            continue;
        }
        
        if ( possible_host != chosenhost )
        {
            possible_party = possible_host getfireteammembers() ?? [];
            possible_party = arraycombineunique( possible_party, [ possible_host ] );
            baseparty = chosenhost getfireteammembers() ?? [];
            baseparty = arraycombineunique( baseparty, [ chosenhost ] );
            
            if ( possible_party.size > baseparty.size )
            {
                logstring( "[R_MOD] {P1} " + possible_host.name + " has party size of " + possible_party.size + " which is greater than prev host, " + chosenhost.name + " with party size of " + baseparty.size );
                chosenhost = possible_host;
                largest_party_size = possible_party.size;
            }
        }
    }
    
    logstring( "[R_MOD] {P1} " + "Largest party size found! - " + largest_party_size );
    
    foreach ( possible_host in var_12029aec2725403f )
    {
        if ( !isplayer( possible_host ) )
        {
            continue;
        }
        
        possible_party = possible_host getfireteammembers() ?? [];
        possible_party = arraycombineunique( possible_party, [ possible_host ] );
        
        if ( possible_party.size == largest_party_size )
        {
            if ( !arraycontains( var_40fc44ea1d7f9aa0, possible_host ) )
            {
                var_40fc44ea1d7f9aa0[ var_40fc44ea1d7f9aa0.size ] = possible_host;
                logstring( "[R_MOD] {P1} " + possible_host.name + " has largest party size of " + possible_party.size + " which is the largest found: " + largest_party_size );
            }
        }
    }
    
    logstring( "[R_MOD] {P1} " + "There are " + var_40fc44ea1d7f9aa0.size + " parties with the same largest size! " );
    
    if ( var_40fc44ea1d7f9aa0.size == 1 )
    {
        logstring( "[R_MOD] {P1} " + chosenhost.name + " has largest party size of all possible hosts! ==> Priority 1 relic selection success! <==" );
        return chosenhost;
    }
    
    logstring( "[R_MOD] {P1} " + "No host found based on largest party size! " + var_40fc44ea1d7f9aa0.size + " parties found with same size of: " + largest_party_size + " ! Starting Priority 2!" );
    
    foreach ( possible_host in var_40fc44ea1d7f9aa0 )
    {
        if ( !isplayer( possible_host ) )
        {
            continue;
        }
        
        var_bc83466056acd50a = chosenhost function_3c4c699ae2f0f4c0();
        var_64ccea756f58f514 = possible_host function_3c4c699ae2f0f4c0();
        
        if ( possible_host != chosenhost )
        {
            if ( var_64ccea756f58f514 > var_bc83466056acd50a )
            {
                logstring( "[R_MOD] {P2} " + possible_host.name + " has a higher tier power of: " + var_64ccea756f58f514 + " than " + chosenhost.name + " who has a tier of: " + var_bc83466056acd50a );
                chosenhost = possible_host;
                var_258684e3d67a36fe = var_64ccea756f58f514;
            }
        }
    }
    
    logstring( "[R_MOD] {P2} " + "Highest tier power found! - " + var_258684e3d67a36fe );
    
    foreach ( possible_host in var_40fc44ea1d7f9aa0 )
    {
        if ( !isplayer( possible_host ) )
        {
            continue;
        }
        
        var_64ccea756f58f514 = possible_host function_3c4c699ae2f0f4c0();
        
        if ( var_64ccea756f58f514 == var_258684e3d67a36fe )
        {
            if ( !arraycontains( var_6d993ca541dd6d8d, possible_host ) )
            {
                var_6d993ca541dd6d8d[ var_6d993ca541dd6d8d.size ] = possible_host;
                logstring( "[R_MOD] {P2} " + possible_host.name + " has tier power of " + var_64ccea756f58f514 + " which is the same as the highest of: " + var_258684e3d67a36fe );
            }
        }
    }
    
    logstring( "[R_MOD] {P2} " + "There are " + var_6d993ca541dd6d8d.size + " parties with the same highest tier! " );
    
    if ( var_6d993ca541dd6d8d.size == 1 )
    {
        logstring( "[R_MOD] {P2} " + chosenhost.name + " has highest tier power of all possible hosts! ==> Priority 2 relic selection success! <==" );
        return chosenhost;
    }
    
    logstring( "[R_MOD] {P2} " + "No host found based on higher tier power! " + var_6d993ca541dd6d8d.size + " parties found with tier power of: " + var_258684e3d67a36fe + " ! Selecting random host!" );
    var_6d993ca541dd6d8d = function_5713d46873b29625( var_6d993ca541dd6d8d );
    var_12029aec2725403f = function_5713d46873b29625( var_12029aec2725403f );
    chosenhost = utility::array_random( var_6d993ca541dd6d8d ) ?? utility::array_random( var_12029aec2725403f );
    logstring( "[R_MOD] {P3} " + chosenhost.name + " has been randomly chosen!" );
    return chosenhost;
}

// Namespace zm_relics
// Params 1, eflags: 0x4
// Checksum 0x82d71dca, Offset: 0x1fa3
// Size: 0x171
function private on_player_spawned( params )
{
    if ( !level.var_2d25ada27bbb5f35 )
    {
        if ( !self.var_56f927e6d4e82547 )
        {
            wait 1;
            
            if ( !isplayer( self ) || !isalive( self ) )
            {
                return;
            }
            
            self.var_56f927e6d4e82547 = 1;
            rarity_increase = 0;
            
            if ( level.zm_relic_tier >= 1 )
            {
                points::function_40dc4b206b63ac2e( 5000 );
            }
            
            if ( level.zm_relic_tier >= 2 )
            {
                rarity_increase = 2;
            }
            
            if ( level.zm_relic_tier >= 3 )
            {
                rarity_increase = 3;
                currency::set_currency_amount( #"salvage", 500, "relic_tier" );
            }
            
            if ( rarity_increase > 0 )
            {
                weapons = self getweaponslist( "primary" );
                
                foreach ( weapon in weapons )
                {
                    if ( weapon && item_weapon::function_fb81bd2fe070faa6( weapon ) < rarity_increase )
                    {
                        item_weapon::function_40e1cbd0e1f47d1a( weapon, rarity_increase, 1 );
                    }
                }
            }
        }
    }
    
    if ( hasomnvar( "ui_zm_relic_tier" ) )
    {
        setomnvarforallclients( "ui_zm_relic_tier", level.zm_relic_tier ?? 0 );
    }
}

// Namespace zm_relics
// Params 6
// Checksum 0x9fa073a2, Offset: 0x211c
// Size: 0xde
function function_f09353885602ac5e( n_roll_aether_tool, var_ab234575f400af66, n_legendary_pct, n_epic_pct, n_rare_pct, n_uncommon_pct )
{
    ultra_percent = 0.5;
    var_f47990d83c7467ca = var_ab234575f400af66 * ( 100 - ultra_percent ) / 100;
    n_legendary_check = var_f47990d83c7467ca - var_ab234575f400af66 * n_legendary_pct / 100;
    n_epic_check = n_legendary_check - var_ab234575f400af66 * n_epic_pct / 100;
    n_rare_check = n_epic_check - var_ab234575f400af66 * n_rare_pct / 100;
    
    if ( n_roll_aether_tool >= var_f47990d83c7467ca )
    {
        return "gold";
    }
    
    if ( n_roll_aether_tool >= n_legendary_check )
    {
        return "orange";
    }
    
    if ( n_roll_aether_tool >= n_epic_check )
    {
        return "purple";
    }
    
    if ( n_roll_aether_tool >= n_rare_check )
    {
        return "blue";
    }
    
    return "green";
}

// Namespace zm_relics
// Params 1
// Checksum 0xaa0656be, Offset: 0x2202
// Size: 0x17f
function function_60456126ca4fb69f( var_33305eede20aa83f )
{
    if ( !level.onlinegame )
    {
        return;
    }
    
    if ( var_33305eede20aa83f.size > 0 )
    {
        foreach ( leader in var_33305eede20aa83f )
        {
            if ( !isplayer( leader ) )
            {
                continue;
            }
            
            var_949456defa2e66ba = leader getfireteammembers();
            relic_tier = leader function_3c4c699ae2f0f4c0( 1 );
            var_949456defa2e66ba[ var_949456defa2e66ba.size ] = leader;
            
            if ( var_949456defa2e66ba.size > 0 )
            {
                foreach ( member in var_949456defa2e66ba )
                {
                    if ( !isplayer( member ) )
                    {
                        continue;
                    }
                    
                    params = { #party_leader:leader, #relic_tier:relic_tier, #player:member };
                    member callback::callback( #"hash_15f7f10acc723bdf", params );
                }
            }
        }
    }
}

// Namespace zm_relics
// Params 0
// Checksum 0xd1769fb7, Offset: 0x2389
// Size: 0x50
function function_a4cda1b0408df7aa()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    relic_tier = function_3c4c699ae2f0f4c0();
    params = { #relic_tier:relic_tier, #player:self };
    callback::callback( #"hash_e0046e014f9385eb", params );
}

/#

    // Namespace zm_relics
    // Params 0
    // Checksum 0xab95742d, Offset: 0x23e1
    // Size: 0xdf, Type: dev
    function setup_relics_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        
        foreach ( relic_key, relic_value in level.zm_relics )
        {
            var_ead6cad3657a6923 = getxhashsourcename( relic_key );
            var_ead6cad3657a6923 = removesubstr( var_ead6cad3657a6923, "<dev string:x2e>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x35>" + var_ead6cad3657a6923, "<dev string:x43>" + var_ead6cad3657a6923, &function_53e25d941a2a2971, 0 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x51>" + var_ead6cad3657a6923, "<dev string:x60>" + var_ead6cad3657a6923, &function_50851ccb1838e482, 0 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_relics
    // Params 1
    // Checksum 0x9422253a, Offset: 0x24c8
    // Size: 0xa3, Type: dev
    function function_53e25d941a2a2971( params )
    {
        iprintlnbold( "<dev string:x6f>" + params[ 0 ] + "<dev string:x7f>" );
        relic_hash = getxhashasset( "<dev string:x2e>" + params[ 0 ] );
        function_a679fb14a3fcb594( level.zm_relics[ relic_hash ] );
        level thread utility::callsharedfunc( level.zm_relics[ relic_hash ].modifiertype, #"hash_3802c55cdf341a6b" );
        level.active_relics[ level.active_relics.size ] = relic_hash;
        level.active_relics = arrayremoveduplicates( level.active_relics );
    }

    // Namespace zm_relics
    // Params 1
    // Checksum 0xd01541de, Offset: 0x2573
    // Size: 0x8e, Type: dev
    function function_50851ccb1838e482( params )
    {
        iprintlnbold( "<dev string:x81>" + params[ 0 ] + "<dev string:x7f>" );
        relic_hash = getxhashasset( "<dev string:x2e>" + params[ 0 ] );
        function_a679fb14a3fcb594( level.zm_relics[ relic_hash ] );
        level thread utility::callsharedfunc( level.zm_relics[ relic_hash ].modifiertype, #"hash_eb4ac69bf458f466" );
        level.active_relics = arrayremove( level.active_relics, relic_hash );
    }

#/
