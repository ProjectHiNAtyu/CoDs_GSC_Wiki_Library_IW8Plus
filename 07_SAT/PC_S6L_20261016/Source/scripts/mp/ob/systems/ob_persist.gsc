// scripts\mp\ob\systems\ob_persist.gsc  (hash_3096e542be453453.gscc) (size: 47616 Bytes / 0xba00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3148cc93 (826854547)
// size ...... 47616 (0xba00)
// includes .. 24  (offset: 0xb2e4)
// strings ... 88  (offset: 0xb3a4)
// dev strs .. 9   (offset: 0xb988)
// exports ... 47  (offset: 0x8da0)
// cseg ...... 0xc6f + 0x8131 (0x8da0)
// imports ... 202 (offset: 0x94f8)
// animtree1 . 0   (offset: 0xba00)
// animtree2 . 0   (offset: 0xba00)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_power_tier;
#using scripts\mp\pack_a_punch;
#using scripts\mp\supers;

#namespace ob_persist;

// Namespace ob_persist
// Params 0, eflags: 0x5
// Checksum 0x4695f8dd, Offset: 0xc8d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_persist", undefined, &function_7d730f4c289e66fd, undefined );
}

// Namespace ob_persist
// Params 0, eflags: 0x4
// Checksum 0x15b01acd, Offset: 0xcae
// Size: 0x327
function private function_7d730f4c289e66fd()
{
    if ( !common_instance_inventory::isenabled() )
    {
        logstring( "Disabling ob_persist instance inventory is disabled." );
        return;
    }
    
    level.var_e11c97ded8b60eba = getdvarint( @"hash_d6cc88a3013fe316", getbuildversion() != "SHIP" );
    level.var_8f270e6f9451724d = [ #"hash_3156f1b68d342e3c", #"hash_3156f4b68d343355", #"hash_3156f3b68d3431a2", #"hash_3156eeb68d342923" ];
    level.var_4e5bcac59dca0bd = 1;
    callback::add( #"player_connect", &_ob_on_player_connect );
    
    if ( getdvarint( @"hash_c8ee6e2d22b6270", 1 ) )
    {
        callback::add( #"hash_b9fa08c48b5f7a5b", &function_1329d33c4e7a8912 );
        callback::add( #"hash_f46cdaf446ff2fe5", &function_2d0c5223b3e61e8 );
    }
    
    callback::add( #"hash_7e070a8c7f137ece", &_pre_finalize );
    utility::registersharedfunc( #"instanceInventory", #"onPlayerDisconnect", &_ob_on_player_disconnect );
    utility::registersharedfunc( #"instanceInventory", #"getActiveOperatorSkinLootID", &function_b17125f280a8f3d1 );
    utility::registersharedfunc( #"instanceInventory", #"getActiveOperatorExecutionLootID", &function_acdc7141afbfdb38 );
    utility::registersharedfunc( #"instanceInventory", #"hash_10edfd81317fb1b4", &function_fc059f9564198ef4 );
    utility::registersharedfunc( #"instanceInventory", #"hash_4cd131c09ba7529a", &function_7b83568781c9d7c );
    utility::registersharedfunc( #"instanceInventory", #"hash_b4203b4404eb0127", &function_6aad32a288c43f7d );
    utility::registersharedfunc( #"instanceInventory", #"hash_edd08039698295a5", &function_7c1c34bdf5d9dea3 );
    utility::registersharedfunc( #"instanceInventory", #"grantitems", &function_73b90e9083e45a14 );
    utility::registersharedfunc( #"instanceInventory", #"extractitems", &function_5be6152d5d718bdb );
    utility::registersharedfunc( #"instanceInventory", #"wipeitems", &function_ac2308074632d63 );
    utility::registersharedfunc( #"instanceInventory", #"hash_a66c90fafb6dab1f", &function_9976ed527c1f86a4 );
    utility::registersharedfunc( #"instanceInventory", #"hash_1ea36aea7859a35d", &function_8b0d7a7d235a9087 );
    utility::registersharedfunc( #"instanceInventory", #"hash_5e6dae73583ffa98", &function_d988a5f7acef86bd );
    utility::registersharedfunc( #"instanceInventory", #"ismaptomapinfil", &function_e0b2daa44b658ebf );
    utility::registersharedfunc( #"instanceInventory", #"hash_6198432a8749926e", &function_335d74c6a0b4e5fb );
    utility::registersharedfunc( #"instanceInventory", #"getweaponmetadata", &function_9ade660431d170a2 );
    utility::registersharedfunc( #"instanceInventory", #"hash_2ada83a8a20e59f7", &function_b6d4e42ec1e32e2f );
    utility::registersharedfunc( #"instanceInventory", #"hash_a7273367e0015a6e", &function_5a78aae61d8ed6a6 );
    utility::registersharedfunc( #"instanceInventory", #"hash_33b349611dba5601", &function_17c273f6d614a0fe );
    function_ac35b3e1f0375ddd();
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xf5c5a833, Offset: 0xfdd
// Size: 0x6e
function private _ob_on_player_connect( params )
{
    if ( !isplayer( self ) || isbot( self ) || !utility::callsharedfunc( #"instanceInventory", #"inventoryisvalid", self ) )
    {
        return;
    }
    
    settings = ob::get_ob_settings();
    
    if ( settings.var_2ce026c61f310f22 )
    {
        common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
    }
    
    function_b83ea39187862e0a( self );
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x3e3e7d9b, Offset: 0x1053
// Size: 0xc3e
function private function_b83ea39187862e0a( player )
{
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        kick( player, &"exe/playerkicked_no_bio_lab_ticket" );
        throw( "[OB_PERSIST] Operator instance was invalid for player [" + ( player.name ?? "" ) + "] when connecting." );
        return;
    }
    
    player.operatorlootid = operatorinstance.lootid;
    
    if ( !level.var_bb86f77304f193c4.var_c62180fe4306e249 )
    {
        return;
    }
    
    var_7f5fe591d7b6121f = maxint( 1, int( common_instance_inventory::function_9513862f69ec0498( 1, operatorinstance, 0 ) ?? 1 ) );
    logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with power level [" + var_7f5fe591d7b6121f + "]" );
    player.operatorprestige = 0;
    var_5c8d6d89f3d37f5e = var_7f5fe591d7b6121f;
    
    while ( var_5c8d6d89f3d37f5e >= 100 )
    {
        player.operatorprestige++;
        var_5c8d6d89f3d37f5e -= 100;
    }
    
    player utility::callsharedfunc( #"ob", #"hash_cc4e2bcf7e45b223" );
    var_d501198ca744e2ac = int( common_instance_inventory::function_9513862f69ec0498( 1, operatorinstance, 1 ) ?? 0 );
    player.var_d501198ca744e2ac = var_d501198ca744e2ac;
    
    if ( var_d501198ca744e2ac == 0 )
    {
        return;
    }
    
    if ( level.var_e11c97ded8b60eba )
    {
        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with the operator reset bitmask [" + var_d501198ca744e2ac + "]" );
    }
    
    if ( var_d501198ca744e2ac == 1 || var_d501198ca744e2ac == 2 || var_d501198ca744e2ac == 4 || var_d501198ca744e2ac == 64 )
    {
        if ( player.operatorprestige < 3 && var_5c8d6d89f3d37f5e != 61 || player.operatorprestige == 3 && var_5c8d6d89f3d37f5e != 77 )
        {
            logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with the operator skill track reset bitmask but their CR was not at max." );
            return;
        }
        
        player.var_6e6abd7fa4d7b630 = "NEW_TRACK";
    }
    
    if ( var_d501198ca744e2ac == 1023 )
    {
        var_d03d9ff62dcc67ca = 67;
        
        if ( player.operatorprestige == 1 )
        {
            var_d03d9ff62dcc67ca = 70;
        }
        else if ( player.operatorprestige == 2 )
        {
            var_d03d9ff62dcc67ca = 73;
        }
        else if ( player.operatorprestige >= 3 )
        {
            logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with the operator prestige bitmask but they are already at max prestige." );
            return;
        }
        
        var_8cc79e1d0a9b71d1 = 0;
        var_2eda80999c83186a = 0;
        var_9681363429ac8183 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_952f20a0293debc7" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_9681363429ac8183 ) )
        {
            var_ae71f5b7a842cc31 = 0;
            
            while ( var_ae71f5b7a842cc31 < 22 )
            {
                lootid = var_9681363429ac8183.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
                
                if ( isdefined( lootid ) && lootid != 0 )
                {
                    lootinfo = getlootiteminfofromid( lootid );
                    
                    if ( lootinfo.itemref )
                    {
                        skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skilllevel", #"hash_328ef7b7091f63ce" ] );
                        
                        if ( #"end_game" == skillbundle.skillcategory )
                        {
                            var_8cc79e1d0a9b71d1 += skillbundle.skilllevel + 1;
                        }
                        else if ( #"nightmare" == skillbundle.skillcategory )
                        {
                            var_2eda80999c83186a += skillbundle.skilllevel + 1;
                        }
                    }
                }
                
                var_ae71f5b7a842cc31 += 1;
            }
        }
        
        var_4188ba18e5d5b864 = var_5c8d6d89f3d37f5e + var_8cc79e1d0a9b71d1 + var_2eda80999c83186a;
        
        if ( var_4188ba18e5d5b864 != var_d03d9ff62dcc67ca )
        {
            logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with the operator prestige bitmask but their CR [" + var_4188ba18e5d5b864 + "] was not at the required [" + var_d03d9ff62dcc67ca + "] for their prestige." );
            return;
        }
        
        player.operatorprestige++;
        player utility::callsharedfunc( #"ob", #"hash_cc4e2bcf7e45b223" );
    }
    
    if ( !isdefined( player.tracksshown ) )
    {
        player.tracksshown = [];
    }
    
    if ( !isdefined( player.disabledtracks ) )
    {
        player.disabledtracks = [];
    }
    
    if ( var_d501198ca744e2ac & 1 )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_3156f1b68d342e3c" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            if ( var_d501198ca744e2ac == 1 )
            {
                player.tracksshown[ var_245dd45e827da361.lootid ] = 1;
                player.disabledtracks[ var_245dd45e827da361.lootid ] = 1;
            }
            
            player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        }
    }
    
    if ( var_d501198ca744e2ac & 2 )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_3156f4b68d343355" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            if ( var_d501198ca744e2ac == 2 )
            {
                player.tracksshown[ var_245dd45e827da361.lootid ] = 1;
                player.disabledtracks[ var_245dd45e827da361.lootid ] = 1;
            }
            
            player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        }
    }
    
    if ( var_d501198ca744e2ac & 4 )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_3156f3b68d3431a2" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            if ( var_d501198ca744e2ac == 4 )
            {
                player.tracksshown[ var_245dd45e827da361.lootid ] = 1;
                player.disabledtracks[ var_245dd45e827da361.lootid ] = 1;
            }
            
            player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        }
    }
    
    if ( var_d501198ca744e2ac & 64 )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_3156eeb68d342923" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            if ( var_d501198ca744e2ac == 64 )
            {
                player.tracksshown[ var_245dd45e827da361.lootid ] = 1;
                player.disabledtracks[ var_245dd45e827da361.lootid ] = 1;
            }
            
            player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        }
    }
    
    if ( var_d501198ca744e2ac & 32 )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_fc1160f8e3c9f8ef" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        }
    }
    
    if ( var_d501198ca744e2ac & 256 )
    {
        primaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( primaryweaponinstance ) && primaryweaponinstance.kind != 24 )
        {
            player function_1fe0234f56138fe1( primaryweaponinstance.instanceid );
        }
        
        secondaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"secondaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( secondaryweaponinstance ) && secondaryweaponinstance.kind != 24 )
        {
            player function_1fe0234f56138fe1( secondaryweaponinstance.instanceid );
        }
        
        var_dd4830c9142c8e9f = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_dd4830c9142c8e9f ) && var_dd4830c9142c8e9f.kind != 24 )
        {
            player function_1fe0234f56138fe1( var_dd4830c9142c8e9f.instanceid );
        }
        
        foreach ( kvp in operatorinstance.var_c11bbd62e8f23645 )
        {
            if ( kvp.key == 2 || kvp.key == 3 )
            {
                kvp.value = 0;
            }
        }
    }
    
    if ( var_d501198ca744e2ac & 128 )
    {
        keys = [ 3, 4, 5, 7 ];
        values = [ 0, 0, 0, 0 ];
        primaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( primaryweaponinstance ) )
        {
            common_instance_inventory::function_a568f4d2f7413a60( keys, values, primaryweaponinstance, 0 );
        }
        
        secondaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"secondaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( secondaryweaponinstance ) )
        {
            common_instance_inventory::function_a568f4d2f7413a60( keys, values, secondaryweaponinstance, 0 );
        }
        
        var_dd4830c9142c8e9f = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_dd4830c9142c8e9f ) )
        {
            common_instance_inventory::function_a568f4d2f7413a60( keys, values, var_dd4830c9142c8e9f, 0 );
        }
    }
    
    if ( var_d501198ca744e2ac & 512 )
    {
        foreach ( kvp in operatorinstance.var_c11bbd62e8f23645 )
        {
            if ( kvp.key == 7 || kvp.key == 8 )
            {
                kvp.value = 0;
            }
        }
    }
    
    var_196eb69a6df28a8 = [];
    
    if ( var_d501198ca744e2ac != 1023 )
    {
        var_f936a8928d3e6cfe = -1;
        var_931630c831724f52 = 10;
        
        foreach ( data in operatorinstance.metadata )
        {
            if ( data.key == 0 )
            {
                continue;
            }
            
            offset = var_196eb69a6df28a8.size;
            var_196eb69a6df28a8[ offset ] = [];
            var_196eb69a6df28a8[ offset ][ 0 ] = data.key;
            var_196eb69a6df28a8[ offset ][ 1 ] = int( data.value );
            
            if ( data.key == 10 )
            {
                var_f936a8928d3e6cfe = offset;
            }
            
            if ( data.key == var_931630c831724f52 )
            {
                var_931630c831724f52++;
            }
        }
        
        if ( player.var_6e6abd7fa4d7b630 == "NEW_TRACK" )
        {
            var_196eb69a6df28a8[ 0 ] = [ 1, var_5c8d6d89f3d37f5e - 16 + 100 * player.operatorprestige ];
            var_955e1c51daeb5942 = getarraykeys( player.disabledtracks )[ 0 ];
            
            if ( var_931630c831724f52 <= 13 )
            {
                var_196eb69a6df28a8[ var_196eb69a6df28a8.size ] = [ var_931630c831724f52, var_955e1c51daeb5942 ];
            }
            else
            {
                var_196eb69a6df28a8[ var_f936a8928d3e6cfe ][ 1 ] = var_955e1c51daeb5942;
            }
        }
    }
    else
    {
        var_196eb69a6df28a8[ 0 ] = [ 1, 1 + 100 * player.operatorprestige ];
    }
    
    var_6102a1e83f8b1567 = [];
    
    foreach ( data in operatorinstance.var_c11bbd62e8f23645 )
    {
        if ( data.key == 1 )
        {
            continue;
        }
        
        offset = var_6102a1e83f8b1567.size;
        var_6102a1e83f8b1567[ offset ] = [];
        var_6102a1e83f8b1567[ offset ][ 0 ] = data.key;
        var_6102a1e83f8b1567[ offset ][ 1 ] = int( data.value );
    }
    
    player function_1fe0234f56138fe1( operatorinstance.instanceid );
    player function_c178641b0ba5bf6f( operatorinstance.lootid, 22, operatorinstance.location, operatorinstance.sublocation, operatorinstance.var_a834790f492b07f8, var_196eb69a6df28a8, var_6102a1e83f8b1567 );
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xccd118bc, Offset: 0x1c99
// Size: 0xf8
function private _ob_on_player_disconnect( params )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( self.inventoryfinalized )
    {
        return;
    }
    
    if ( params.reason == getxhashhexname( %"exe/leaving" ) || params.reason == getxhashhexname( %"hash_7194ffe36169ca7" ) || params.reason == getxhashhexname( %"hash_5b309dc0bff1f44d" ) )
    {
        behavior = getdvarint( @"hash_cc6218d4acb2c1a8", 0 );
        logstring( "[OB_PERSIST] Finalized player with behavior " + behavior + " due to intentionally disconnecting. Disconnect reason: " + params.reason );
    }
    else
    {
        behavior = getdvarint( @"hash_74ce30640af86adf", 1 );
        logstring( "[OB_PERSIST] Finalized player with behavior " + behavior + " due to unintentionally disconnecting. Disconnect reason: " + params.reason );
    }
    
    finalize_player( self, behavior );
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xcf071b18, Offset: 0x1d99
// Size: 0x63
function private _pre_finalize( params )
{
    if ( isplayer( self ) && !params.var_39b6fb8e4ff7b6ee )
    {
        var_de385a6178156735 = getdvarint( @"hash_308563c9c75af8a3", level.var_858d230de58cc743.var_de385a6178156735 ?? 0 );
        
        if ( var_de385a6178156735 )
        {
            ob_power_tier::function_3a1a3b1e6169c47a( var_de385a6178156735, 0 );
        }
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xe10d813d, Offset: 0x1e04
// Size: 0xcd
function private function_1329d33c4e7a8912( params )
{
    if ( self.var_eddebed5872b3b52 )
    {
        respawnmetadata = [];
        
        foreach ( slot, metadata in self.var_eddebed5872b3b52 )
        {
            respawnmetadata[ slot ] = { #weapon:item_weapon::function_e7484276ad85f220( slot ), #metadata:metadata };
        }
        
        params.respawnitems.var_eddebed5872b3b52 = respawnmetadata;
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xdd8f5286, Offset: 0x1ed9
// Size: 0x190
function private function_2d0c5223b3e61e8( params )
{
    if ( self.respawnitems.var_eddebed5872b3b52 )
    {
        self.var_eddebed5872b3b52 = [];
        var_943eba53792c792c = item_weapon::function_e7484276ad85f220( #"primary_0" );
        var_943ebb53792c7b5f = item_weapon::function_e7484276ad85f220( #"primary_1" );
        var_f672b68c63f61a7c = item_weapon::function_e7484276ad85f220( #"tertiary_0" );
        
        foreach ( var_7352a1d1b73ff04 in self.respawnitems.var_eddebed5872b3b52 )
        {
            if ( issameweapon( var_943eba53792c792c, var_7352a1d1b73ff04.weapon ) )
            {
                self.var_eddebed5872b3b52[ #"primary_0" ] = var_7352a1d1b73ff04.metadata;
                continue;
            }
            
            if ( issameweapon( var_943ebb53792c7b5f, var_7352a1d1b73ff04.weapon ) )
            {
                self.var_eddebed5872b3b52[ #"primary_1" ] = var_7352a1d1b73ff04.metadata;
                continue;
            }
            
            if ( issameweapon( var_f672b68c63f61a7c, var_7352a1d1b73ff04.weapon ) )
            {
                self.var_eddebed5872b3b52[ #"tertiary_0" ] = var_7352a1d1b73ff04.metadata;
            }
        }
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x80e21aea, Offset: 0x2071
// Size: 0x9e
function private function_335d74c6a0b4e5fb( player, weaponobj )
{
    if ( issameweapon( player item_weapon::function_e7484276ad85f220( #"primary_0" ), weaponobj, 1 ) )
    {
        return #"primary_0";
    }
    
    if ( issameweapon( player item_weapon::function_e7484276ad85f220( #"primary_1" ), weaponobj, 1 ) )
    {
        return #"primary_1";
    }
    
    if ( issameweapon( player item_weapon::function_e7484276ad85f220( #"tertiary_0" ), weaponobj, 1 ) )
    {
        return #"tertiary_0";
    }
    
    assertmsg( "<dev string:x24>" );
    return;
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x262d4bef, Offset: 0x2117
// Size: 0x29
function private function_9ade660431d170a2( player, slot )
{
    if ( slot )
    {
        return player.var_eddebed5872b3b52[ slot ];
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x2c34b434, Offset: 0x2149
// Size: 0x28
function private function_b6d4e42ec1e32e2f( player, slot )
{
    if ( slot )
    {
        player.var_eddebed5872b3b52[ slot ] = undefined;
    }
}

// Namespace ob_persist
// Params 3, eflags: 0x4
// Checksum 0xdc077d5f, Offset: 0x2179
// Size: 0x33
function private function_5a78aae61d8ed6a6( player, slot, metadata )
{
    if ( slot )
    {
        player.var_eddebed5872b3b52[ slot ] = metadata;
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x669b9065, Offset: 0x21b4
// Size: 0x54
function private function_17c273f6d614a0fe( weaponobj, subcomponents )
{
    if ( weaponobj.conversionkit )
    {
        lootid = loot::getlootidfromref( weaponobj.conversionkit );
        
        if ( lootid && lootid != 0 )
        {
            subcomponents[ subcomponents.size ] = lootid;
        }
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0xe801af35, Offset: 0x2210
// Size: 0x5f
function private function_a47ac8130dbd1a91( player, var_ae71f5b7a842cc31 )
{
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        if ( isdefined( operatorinstance.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ] ) )
        {
            return operatorinstance.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
        }
    }
    
    return 0;
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x5f969f24, Offset: 0x2278
// Size: 0x15
function private function_b17125f280a8f3d1( player )
{
    return function_a47ac8130dbd1a91( player, 0 );
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x4b23a062, Offset: 0x2296
// Size: 0x16
function private function_acdc7141afbfdb38( player )
{
    return function_a47ac8130dbd1a91( player, 1 );
}

// Namespace ob_persist
// Params 4, eflags: 0x4
// Checksum 0xa4027d41, Offset: 0x22b5
// Size: 0x73a
function private function_fc059f9564198ef4( player, struct, class, var_4d5575c6f9ec8a5b )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    struct.loadoutarchetype = player class::cac_getcharacterarchetype();
    
    if ( player.var_c72cb0043263a756 )
    {
        return;
    }
    
    if ( level.var_bb86f77304f193c4.var_5099e8ac653eef01 )
    {
        weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
        
        if ( common_instance_inventory::function_69b794916cb34595( player, weaponinstance ) )
        {
            blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
            weaponstruct = player common_instance_inventory::function_4da778f38e8b3044( weaponinstance, blueprintindex );
            struct.loadoutprimary = weaponstruct.weaponref;
            
            for ( attachmentindex = 0; attachmentindex < weaponstruct.attachmentrefs.size ; attachmentindex++ )
            {
                struct.loadoutprimaryattachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
                struct.loadoutprimaryattachmentids[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
                tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
                
                if ( isdefined( tuningvalues ) )
                {
                    struct.var_57a15af46a205668[ struct.loadoutprimaryattachments[ attachmentindex ] ] = tuningvalues;
                }
            }
            
            struct.loadoutprimarycamo = weaponstruct.weaponcamo;
            struct.loadoutprimaryreticle = weaponstruct.weaponreticle;
            struct.loadoutprimarylootitemid = weaponstruct.lootitemid;
            struct.loadoutprimaryvariantid = weaponstruct.weaponvariant;
            struct.loadoutprimarycosmeticattachment = weaponstruct.weaponcosmetic;
            struct.var_bf06b7def8985709 = weaponstruct.var_c325d12dda0a389b;
            
            for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
            {
                struct.loadoutprimarystickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
            }
            
            struct.loadoutPrimaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
            
            if ( level.var_e11c97ded8b60eba )
            {
                attachments_string = isarray( weaponinstance.var_a834790f492b07f8 ) && weaponinstance.var_a834790f492b07f8.size ? "" + weaponinstance.var_a834790f492b07f8 : "[]";
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with primary weapon [" + weaponinstance.lootid + "] with attachments " + attachments_string );
            }
        }
        
        weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"secondaryweapon" );
        
        if ( common_instance_inventory::function_69b794916cb34595( player, weaponinstance ) )
        {
            blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
            weaponstruct = player common_instance_inventory::function_4da778f38e8b3044( weaponinstance, blueprintindex );
            struct.loadoutsecondary = weaponstruct.weaponref;
            
            for ( attachmentindex = 0; attachmentindex < weaponstruct.attachmentrefs.size ; attachmentindex++ )
            {
                struct.loadoutsecondaryattachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
                struct.loadoutsecondaryattachmentids[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
                tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
                
                if ( isdefined( tuningvalues ) )
                {
                    struct.var_f2b8977772330320[ struct.loadoutsecondaryattachments[ attachmentindex ] ] = tuningvalues;
                }
            }
            
            struct.loadoutsecondarycamo = weaponstruct.weaponcamo;
            struct.loadoutsecondaryreticle = weaponstruct.weaponreticle;
            struct.loadoutsecondarylootitemid = weaponstruct.lootitemid;
            struct.loadoutsecondaryvariantid = weaponstruct.weaponvariant;
            struct.loadoutsecondarycosmeticattachment = weaponstruct.weaponcosmetic;
            struct.var_8d1ed34c7709f241 = weaponstruct.var_c325d12dda0a389b;
            
            for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
            {
                struct.loadoutsecondarystickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
            }
            
            struct.loadoutSecondaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
            
            if ( level.var_e11c97ded8b60eba )
            {
                attachments_string = isarray( weaponinstance.var_a834790f492b07f8 ) && weaponinstance.var_a834790f492b07f8.size ? "" + weaponinstance.var_a834790f492b07f8 : "[]";
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with secondary weapon [" + weaponinstance.lootid + "] with attachments " + attachments_string );
            }
        }
        
        weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
        
        if ( common_instance_inventory::function_69b794916cb34595( player, weaponinstance ) )
        {
            blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
            weaponstruct = player common_instance_inventory::function_4da778f38e8b3044( weaponinstance, blueprintindex );
            struct.loadouttertiary = weaponstruct.weaponref;
            
            for ( attachmentindex = 0; attachmentindex < weaponstruct.attachmentrefs.size ; attachmentindex++ )
            {
                struct.loadoutTertiaryAttachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
                struct.loadoutTertiaryAttachmentIDs[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
                tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
                
                if ( isdefined( tuningvalues ) )
                {
                    struct.var_d3a06e057eb576c0[ struct.loadoutTertiaryAttachments[ attachmentindex ] ] = tuningvalues;
                }
            }
            
            struct.loadouttertiarycamo = weaponstruct.weaponcamo;
            struct.loadouttertiaryreticle = weaponstruct.weaponreticle;
            struct.loadoutTertiaryLootItemID = weaponstruct.lootitemid;
            struct.loadouttertiaryvariantid = weaponstruct.weaponvariant;
            struct.loadoutTertiaryCosmeticAttachment = weaponstruct.weaponcosmetic;
            struct.var_ea6fecf8edebaf61 = weaponstruct.var_c325d12dda0a389b;
            
            for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
            {
                struct.loadoutTertiaryStickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
            }
            
            struct.loadoutTertiaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
            
            if ( level.var_e11c97ded8b60eba )
            {
                attachments_string = isarray( weaponinstance.var_a834790f492b07f8 ) && weaponinstance.var_a834790f492b07f8.size ? "" + weaponinstance.var_a834790f492b07f8 : "[]";
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with tertiary weapon [" + weaponinstance.lootid + "] with attachments " + attachments_string );
            }
        }
    }
    
    function_7b83568781c9d7c( player, struct );
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0xd8d8ec01, Offset: 0x29f7
// Size: 0x54c
function private function_7b83568781c9d7c( player, struct )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( self.var_c72cb0043263a756 )
    {
        return;
    }
    
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        kick( player, &"exe/playerkicked_no_bio_lab_ticket" );
        throw( "[OB_PERSIST] Operator instance was invalid for player [" + ( player.name ?? "" ) + "] when granting nonweapon loadout items." );
        return;
    }
    
    var_dc309687ccc90244 = getlootiteminfofromid( operatorinstance.lootid );
    
    if ( isxhashasset( var_dc309687ccc90244.itemrefhash ) )
    {
        operatorbundle = getoperatorscriptbundle( var_dc309687ccc90244.itemrefhash, [ #"hash_3607e69b99e42aff" ] );
    }
    
    if ( level.var_bb86f77304f193c4.var_b9bc6cdf300d007a )
    {
        equipmentLootID = operatorinstance.var_a834790f492b07f8[ 5 ] ?? 0;
        
        if ( equipmentLootID == 0 )
        {
            equipmentLootID = int( common_instance_inventory::function_9513862f69ec0498( 4, operatorinstance, 1 ) ?? 0 );
        }
        
        lootinfo = getlootiteminfofromid( equipmentLootID );
        
        if ( lootinfo.itemref )
        {
            struct.loadoutequipmentprimary = lootinfo.itemref;
            struct.var_a1191d5606e653f0 = function_4d465a88a4c974d3( equipmentLootID ) ?? 0;
            
            if ( struct.var_a1191d5606e653f0 > 0 )
            {
                if ( !isdefined( player.var_8cf9648fae56099c ) )
                {
                    player.var_8cf9648fae56099c = [];
                }
                
                if ( !isdefined( player.var_92c60993d80d57b5 ) )
                {
                    player.var_92c60993d80d57b5 = [];
                }
                
                player.var_8cf9648fae56099c[ lootinfo.itemref ] = struct.var_a1191d5606e653f0;
                player.var_92c60993d80d57b5[ lootinfo.itemref ] = equipmentLootID;
            }
        }
        else
        {
            struct.loadoutequipmentprimary = class::table_getequipmentprimary( level.classtablename, 0 );
        }
    }
    
    if ( level.var_bb86f77304f193c4.var_1988bc82cbd9ac20 )
    {
        lootinfo = undefined;
        lootid = operatorinstance.var_a834790f492b07f8[ 6 ] ?? 0;
        
        if ( lootid == 0 )
        {
            lootid = int( common_instance_inventory::function_9513862f69ec0498( 5, operatorinstance, 1 ) ?? 0 );
        }
        
        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with major ability [" + ( lootid ?? 0 ) + "]" );
        
        if ( !getdvarint( hashcat( @"hash_fcd1366cdf74298e", lootid ), 0 ) )
        {
            lootinfo = getlootiteminfofromid( lootid );
        }
        
        if ( !lootinfo && isxhashasset( operatorbundle.abilityrefs.var_f60df0d59ad18b14 ) )
        {
            var_5480d76b2c3158f0 = getscriptbundlefieldvalue( operatorbundle.abilityrefs.var_f60df0d59ad18b14, #"lootid" );
            
            if ( !getdvarint( hashcat( @"hash_fcd1366cdf74298e", var_5480d76b2c3158f0 ), 0 ) )
            {
                lootinfo = getlootiteminfofromid( var_5480d76b2c3158f0 );
            }
        }
        
        if ( !lootinfo )
        {
            lootinfo = { #itemref:"super_war_machine" };
        }
        
        if ( isdefined( lootinfo.itemref ) )
        {
            overrideinfo = level.superglobals.refoverrides[ lootinfo.itemref ];
            
            if ( overrideinfo )
            {
                struct.loadoutfieldupgrade1 = overrideinfo.overrideref;
            }
            else
            {
                struct.loadoutfieldupgrade1 = lootinfo.itemref;
            }
        }
        
        lootinfo = undefined;
        lootid = operatorinstance.var_a834790f492b07f8[ 7 ] ?? 0;
        
        if ( lootid == 0 )
        {
            lootid = int( common_instance_inventory::function_9513862f69ec0498( 6, operatorinstance, 1 ) ?? 0 );
        }
        
        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with minor ability [" + ( lootid ?? 0 ) + "]" );
        
        if ( !getdvarint( hashcat( @"hash_fcd1366cdf74298e", lootid ), 0 ) )
        {
            lootinfo = getlootiteminfofromid( lootid );
        }
        
        if ( !lootinfo && isxhashasset( operatorbundle.abilityrefs.var_6141c20f6b9af588 ) )
        {
            var_16e48395663479b4 = getscriptbundlefieldvalue( operatorbundle.abilityrefs.var_6141c20f6b9af588, #"lootid" );
            
            if ( !getdvarint( hashcat( @"hash_fcd1366cdf74298e", var_16e48395663479b4 ), 0 ) )
            {
                lootinfo = getlootiteminfofromid( var_16e48395663479b4 );
            }
        }
        
        if ( !lootinfo )
        {
            lootinfo = { #itemref:"super_mega_jump" };
        }
        
        if ( isdefined( lootinfo.itemref ) )
        {
            overrideinfo = level.superglobals.refoverrides[ lootinfo.itemref ];
            
            if ( overrideinfo )
            {
                equipref = "equip_" + overrideinfo.overrideref;
            }
            else
            {
                equipref = "equip_" + lootinfo.itemref;
            }
            
            struct.loadoutequipmentsecondary = equipref;
            equipment_mp::registercallback( equipref, "onGive", &function_fdc89d8d394b18e6 );
        }
    }
}

// Namespace ob_persist
// Params 4, eflags: 0x4
// Checksum 0x703374af, Offset: 0x2f4b
// Size: 0x96
function private function_fdc89d8d394b18e6( ref, slot, variantid, attachments )
{
    tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( level.var_b7e70fa484e134dc && slot == "secondary" && tableinfo.bundle.issuper )
    {
        supers_mp::givesuper( tableinfo.bundle.superref, undefined, 1, undefined, undefined, #"tactical" );
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x3ee28180, Offset: 0x2fe9
// Size: 0x221
function private function_6aad32a288c43f7d( player )
{
    if ( !level.var_bb86f77304f193c4.var_5099e8ac653eef01 )
    {
        return;
    }
    
    if ( !isdefined( level.var_dcf14cc71588a322 ) )
    {
        level.var_dcf14cc71588a322 = 0;
    }
    
    if ( !isdefined( player.var_1fa81a0e31f08222 ) )
    {
        player.var_1fa81a0e31f08222 = level.var_dcf14cc71588a322;
        level.var_dcf14cc71588a322 += 1;
    }
    
    player.var_76bd798aa92a2eb0 = [];
    primaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( primaryweaponinstance ) && primaryweaponinstance.kind == 24 )
    {
        common_instance_inventory::function_a568f4d2f7413a60( [ 1 ], [ player.var_1fa81a0e31f08222 ], primaryweaponinstance, 0 );
        primaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
        player.var_76bd798aa92a2eb0[ #"primary_0" ] = primaryweaponinstance;
        player.var_eddebed5872b3b52[ #"primary_0" ] = { #insecure:common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.var_c11bbd62e8f23645 ), #secure:common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.metadata ) };
    }
    
    var_dd4830c9142c8e9f = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( var_dd4830c9142c8e9f ) && var_dd4830c9142c8e9f.kind == 24 )
    {
        common_instance_inventory::function_a568f4d2f7413a60( [ 1 ], [ player.var_1fa81a0e31f08222 ], var_dd4830c9142c8e9f, 0 );
        var_dd4830c9142c8e9f = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
        player.var_76bd798aa92a2eb0[ #"tertiary_0" ] = var_dd4830c9142c8e9f;
        player.var_eddebed5872b3b52[ #"tertiary_0" ] = { #insecure:common_instance_inventory::function_dba82bdee30f1799( var_dd4830c9142c8e9f.var_c11bbd62e8f23645 ), #secure:common_instance_inventory::function_dba82bdee30f1799( var_dd4830c9142c8e9f.metadata ) };
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xa26df909, Offset: 0x3212
// Size: 0x587
function private function_7c1c34bdf5d9dea3( player )
{
    if ( !level.var_bb86f77304f193c4.var_dce79dea79de81e7 )
    {
        return;
    }
    
    if ( !isdefined( player.var_76bd798aa92a2eb0 ) )
    {
        assertmsg( "<dev string:x62>" );
        return;
    }
    
    if ( player.var_76bd798aa92a2eb0[ #"primary_0" ] )
    {
        primaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"primaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( primaryweaponinstance ) )
        {
            var_85b1ae31949abce8 = common_instance_inventory::function_9513862f69ec0498( 1, player.var_76bd798aa92a2eb0[ #"primary_0" ], 0 );
            var_11d1e2ccd1d0520e = common_instance_inventory::function_9513862f69ec0498( 1, primaryweaponinstance, 0 );
            
            if ( var_85b1ae31949abce8 == var_11d1e2ccd1d0520e )
            {
                if ( level.var_e11c97ded8b60eba )
                {
                    logstring( "[OB_PERSIST] Remaking the primary weapon as a custom weapon since it was the loadout weapon." );
                }
                
                player function_1fe0234f56138fe1( primaryweaponinstance.instanceid );
                player common_instance_inventory::function_7467cfa870b97b5a( primaryweaponinstance.lootid, 24, primaryweaponinstance.location, primaryweaponinstance.sublocation, primaryweaponinstance.var_a834790f492b07f8 );
                var_39e25c243a9df71e = player function_41f811caf4053d98( primaryweaponinstance.location, primaryweaponinstance.sublocation );
                
                if ( primaryweaponinstance.metadata && common_instance_inventory::function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
                {
                    metadatacopy = common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.metadata );
                    player function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 0, metadatacopy );
                }
                
                if ( primaryweaponinstance.var_c11bbd62e8f23645 && common_instance_inventory::function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
                {
                    metadatacopy = common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.var_c11bbd62e8f23645 );
                    player function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 1, metadatacopy );
                }
            }
            else
            {
                secondaryweaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"secondaryweapon" );
                
                if ( common_instance_inventory::function_ae3907698ee6e6f1( secondaryweaponinstance ) )
                {
                    var_11d1e2ccd1d0520e = common_instance_inventory::function_9513862f69ec0498( 1, secondaryweaponinstance, 0 );
                    
                    if ( var_85b1ae31949abce8 == var_11d1e2ccd1d0520e )
                    {
                        if ( level.var_e11c97ded8b60eba )
                        {
                            logstring( "[OB_PERSIST] Swapping the primary and secondary weapons since the secondary weapon was the loadout weapon." );
                        }
                        
                        player function_1fe0234f56138fe1( primaryweaponinstance.instanceid );
                        player function_1fe0234f56138fe1( secondaryweaponinstance.instanceid );
                        player common_instance_inventory::function_7467cfa870b97b5a( secondaryweaponinstance.lootid, 24, primaryweaponinstance.location, primaryweaponinstance.sublocation, secondaryweaponinstance.var_a834790f492b07f8 );
                        var_cfad3d8749e8fcd5 = player function_41f811caf4053d98( primaryweaponinstance.location, primaryweaponinstance.sublocation );
                        
                        if ( secondaryweaponinstance.metadata && common_instance_inventory::function_ae3907698ee6e6f1( var_cfad3d8749e8fcd5 ) )
                        {
                            metadatacopy = common_instance_inventory::function_dba82bdee30f1799( secondaryweaponinstance.metadata );
                            player function_c0d5d134ef5e068( var_cfad3d8749e8fcd5.instanceid, 0, metadatacopy );
                        }
                        
                        if ( secondaryweaponinstance.var_c11bbd62e8f23645 && common_instance_inventory::function_ae3907698ee6e6f1( var_cfad3d8749e8fcd5 ) )
                        {
                            metadatacopy = common_instance_inventory::function_dba82bdee30f1799( secondaryweaponinstance.var_c11bbd62e8f23645 );
                            player function_c0d5d134ef5e068( var_cfad3d8749e8fcd5.instanceid, 1, metadatacopy );
                        }
                        
                        player common_instance_inventory::function_7467cfa870b97b5a( primaryweaponinstance.lootid, 11, secondaryweaponinstance.location, secondaryweaponinstance.sublocation, primaryweaponinstance.var_a834790f492b07f8 );
                        var_3ade2dff5617d061 = player function_41f811caf4053d98( secondaryweaponinstance.location, secondaryweaponinstance.sublocation );
                        
                        if ( primaryweaponinstance.metadata && common_instance_inventory::function_ae3907698ee6e6f1( var_3ade2dff5617d061 ) )
                        {
                            metadatacopy = common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.metadata );
                            player function_c0d5d134ef5e068( var_3ade2dff5617d061.instanceid, 0, metadatacopy );
                        }
                        
                        if ( primaryweaponinstance.var_c11bbd62e8f23645 && common_instance_inventory::function_ae3907698ee6e6f1( var_3ade2dff5617d061 ) )
                        {
                            metadatacopy = common_instance_inventory::function_dba82bdee30f1799( primaryweaponinstance.var_c11bbd62e8f23645 );
                            player function_c0d5d134ef5e068( var_3ade2dff5617d061.instanceid, 1, metadatacopy );
                        }
                    }
                }
            }
        }
    }
    
    if ( player.var_76bd798aa92a2eb0[ #"tertiary_0" ] )
    {
        var_dd4830c9142c8e9f = common_instance_inventory::function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_dd4830c9142c8e9f ) )
        {
            var_85b1ae31949abce8 = common_instance_inventory::function_9513862f69ec0498( 1, player.var_76bd798aa92a2eb0[ #"tertiary_0" ], 0 );
            var_11d1e2ccd1d0520e = common_instance_inventory::function_9513862f69ec0498( 1, var_dd4830c9142c8e9f, 0 );
            
            if ( var_85b1ae31949abce8 == var_11d1e2ccd1d0520e )
            {
                if ( level.var_e11c97ded8b60eba )
                {
                    logstring( "[OB_PERSIST] Remaking the tertiary weapon as a custom weapon since it was the loadout weapon." );
                }
                
                player function_1fe0234f56138fe1( var_dd4830c9142c8e9f.instanceid );
                player common_instance_inventory::function_7467cfa870b97b5a( var_dd4830c9142c8e9f.lootid, 24, var_dd4830c9142c8e9f.location, var_dd4830c9142c8e9f.sublocation, var_dd4830c9142c8e9f.var_a834790f492b07f8 );
                var_39e25c243a9df71e = player function_41f811caf4053d98( var_dd4830c9142c8e9f.location, var_dd4830c9142c8e9f.sublocation );
                
                if ( var_dd4830c9142c8e9f.metadata && common_instance_inventory::function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
                {
                    metadatacopy = common_instance_inventory::function_dba82bdee30f1799( var_dd4830c9142c8e9f.metadata );
                    player function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 0, metadatacopy );
                }
                
                if ( var_dd4830c9142c8e9f.var_c11bbd62e8f23645 && common_instance_inventory::function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
                {
                    metadatacopy = common_instance_inventory::function_dba82bdee30f1799( var_dd4830c9142c8e9f.var_c11bbd62e8f23645 );
                    player function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 1, metadatacopy );
                }
            }
        }
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x1eb2959a, Offset: 0x37a1
// Size: 0x30c
function private function_cbe484a956b4bf6f( player, operatorinstance )
{
    foreach ( var_f56623bd3361d482 in level.var_8f270e6f9451724d )
    {
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, var_f56623bd3361d482 );
        
        if ( !common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            continue;
        }
        
        foreach ( skilltrack in level.skilltracklist )
        {
            if ( var_245dd45e827da361.lootid == skilltrack.lootid )
            {
                if ( isdefined( player.activeskills ) )
                {
                    player.skilltracks[ skilltrack.lootid ] = skilltrack;
                    continue;
                }
                
                player.loadoutSkillTracks[ skilltrack.lootid ] = skilltrack;
            }
        }
        
        var_ae71f5b7a842cc31 = 0;
        
        while ( var_ae71f5b7a842cc31 < 22 )
        {
            lootid = var_245dd45e827da361.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
            
            if ( !isdefined( lootid ) || lootid == 0 )
            {
            }
            else
            {
                lootinfo = getlootiteminfofromid( lootid );
                
                if ( !isdefined( lootinfo ) || !isdefined( lootinfo.itemref ) )
                {
                }
                else
                {
                    if ( isdefined( player.activeskills ) )
                    {
                        skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skillref", #"skilllevel" ] );
                        
                        if ( isdefined( skillbundle ) )
                        {
                            player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                        }
                    }
                    else
                    {
                        if ( !isdefined( player.loadoutskills ) )
                        {
                            player.loadoutskills = [];
                        }
                        
                        player.loadoutskills[ player.loadoutskills.size ] = lootinfo.itemrefhash;
                    }
                    
                    if ( level.var_e11c97ded8b60eba )
                    {
                        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with skill [" + lootid + "]" );
                    }
                }
            }
            
            var_ae71f5b7a842cc31 += 1;
        }
        
        if ( int( common_instance_inventory::function_9513862f69ec0498( 2, var_245dd45e827da361 ) ?? 0 ) )
        {
            self.pers[ "mostRecentSkillTrackLootID" ] = var_245dd45e827da361.lootid;
        }
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x6082774c, Offset: 0x3ab5
// Size: 0x1be
function private function_92bd4d3ab324a52b( player, operatorinstance )
{
    if ( !level.var_858d230de58cc743.var_4e18ee5e7c3b2610 )
    {
        return;
    }
    
    var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_fc1160f8e3c9f8ef" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
    {
        return;
    }
    
    var_ae71f5b7a842cc31 = 0;
    
    while ( var_ae71f5b7a842cc31 < 22 )
    {
        lootid = var_245dd45e827da361.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
        }
        else
        {
            lootinfo = getlootiteminfofromid( lootid );
            
            if ( !isdefined( lootinfo ) || !isdefined( lootinfo.itemref ) )
            {
            }
            else
            {
                if ( isdefined( player.activeskills ) )
                {
                    skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skillref", #"skilllevel" ] );
                    
                    if ( isdefined( skillbundle ) )
                    {
                        player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                    }
                }
                else
                {
                    if ( !isdefined( player.loadoutskills ) )
                    {
                        player.loadoutskills = [];
                    }
                    
                    player.loadoutskills[ player.loadoutskills.size ] = lootinfo.itemrefhash;
                }
                
                if ( level.var_e11c97ded8b60eba )
                {
                    logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with skill [" + lootid + "]" );
                }
            }
        }
        
        var_ae71f5b7a842cc31 += 1;
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0xed9b7d7a, Offset: 0x3c7b
// Size: 0x4fd
function private function_c6ea33f95d1d0080( player, operatorinstance )
{
    if ( !level.var_858d230de58cc743.var_e59f229d9bf9be39 )
    {
        return;
    }
    
    var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_952f20a0293debc7" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
    {
        return;
    }
    
    var_5be2df24fe13e52c = 24;
    
    if ( ( player.var_d501198ca744e2ac & var_5be2df24fe13e52c ) == var_5be2df24fe13e52c )
    {
        player common_instance_inventory::function_295a263162af11ac( #"hash_952f20a0293debc7" );
        return;
    }
    
    var_789f0c376f5c90b3 = [];
    var_13ff645abbe6b34a = 0;
    var_358f2dce5ceb095 = 0;
    var_ae71f5b7a842cc31 = 0;
    
    while ( var_ae71f5b7a842cc31 < 22 )
    {
        lootid = var_245dd45e827da361.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
        }
        else
        {
            lootinfo = getlootiteminfofromid( lootid );
            
            if ( !isdefined( lootinfo ) || !isdefined( lootinfo.itemref ) )
            {
            }
            else
            {
                skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skillref", #"skilllevel", #"hash_cec10972b7814dd0", #"hash_328ef7b7091f63ce" ] );
                
                if ( !skillbundle )
                {
                }
                else
                {
                    var_32b157686e3fd7fb = level.skillbundles[ skillbundle.skillref ][ 0 ].lootid;
                    assert( var_32b157686e3fd7fb > 0 );
                    
                    if ( #"end_game" == skillbundle.skillcategory )
                    {
                        if ( player.var_d501198ca744e2ac & 8 )
                        {
                            var_789f0c376f5c90b3[ var_789f0c376f5c90b3.size ] = lootid;
                            goto LOC_00000324;
                        }
                        
                        var_13ff645abbe6b34a = 1;
                    }
                    else if ( #"nightmare" == skillbundle.skillcategory )
                    {
                        if ( player.var_d501198ca744e2ac & 16 )
                        {
                            var_789f0c376f5c90b3[ var_789f0c376f5c90b3.size ] = lootid;
                            goto LOC_00000324;
                        }
                        
                        var_358f2dce5ceb095 = 1;
                    }
                    else
                    {
                        assertmsg( "<dev string:xc4>" + getxhashsourcename( skillbundle.skillcategory ) + "<dev string:xf2>" );
                        goto LOC_00000324;
                    }
                    
                    if ( player.activeskills )
                    {
                        player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                    }
                    else
                    {
                        if ( !isdefined( player.loadoutskills ) )
                        {
                            player.loadoutskills = [];
                        }
                        
                        player.loadoutskills[ player.loadoutskills.size ] = lootinfo.itemrefhash;
                    }
                    
                    if ( level.var_e11c97ded8b60eba )
                    {
                        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with skill [" + lootid + "]" );
                    LOC_00000324:
                    }
                LOC_00000324:
                }
            LOC_00000324:
            }
        LOC_00000324:
        }
        
    LOC_00000324:
        var_ae71f5b7a842cc31 += 1;
    }
    
    if ( var_13ff645abbe6b34a )
    {
        skilltrack = getscriptbundle( level.var_858d230de58cc743.var_e59f229d9bf9be39 );
        skilltrack.ref = level.var_858d230de58cc743.var_e59f229d9bf9be39;
        skilltrack.isspecial = 1;
        
        if ( player.activeskills )
        {
            player.skilltracks[ skilltrack.lootid ] = skilltrack;
        }
        else
        {
            player.loadoutSkillTracks[ skilltrack.lootid ] = skilltrack;
        }
    }
    
    if ( var_358f2dce5ceb095 )
    {
        skilltrack = getscriptbundle( level.var_858d230de58cc743.var_bc74fbad7319c534 );
        skilltrack.ref = level.var_858d230de58cc743.var_bc74fbad7319c534;
        skilltrack.isspecial = 1;
        
        if ( player.activeskills )
        {
            player.skilltracks[ skilltrack.lootid ] = skilltrack;
        }
        else
        {
            player.loadoutSkillTracks[ skilltrack.lootid ] = skilltrack;
        }
    }
    
    if ( player.var_d501198ca744e2ac & var_5be2df24fe13e52c )
    {
        var_879b53f31b3e599a = [];
        
        foreach ( lootid in var_245dd45e827da361.var_a834790f492b07f8 )
        {
            if ( !arraycontains( var_789f0c376f5c90b3, lootid ) )
            {
                var_879b53f31b3e599a[ var_879b53f31b3e599a.size ] = lootid;
            }
        }
        
        player function_1fe0234f56138fe1( var_245dd45e827da361.instanceid );
        player function_c178641b0ba5bf6f( var_245dd45e827da361.lootid, 23, var_245dd45e827da361.location, var_245dd45e827da361.sublocation, var_879b53f31b3e599a, [], [] );
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0xf9d111b4, Offset: 0x4180
// Size: 0x30f
function private function_d88e3ef2b3f0da16( player, operatorinstance )
{
    var_fd72d806617d5cfe = int( common_instance_inventory::function_9513862f69ec0498( 7, operatorinstance, 1 ) ?? 0 );
    
    if ( isdefined( var_fd72d806617d5cfe ) && var_fd72d806617d5cfe != 0 )
    {
        lootinfo = getlootiteminfofromid( var_fd72d806617d5cfe );
        
        if ( lootinfo.itemrefhash )
        {
            skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skillref", #"skilllevel", #"hash_328ef7b7091f63ce" ] );
            
            if ( #"ability" == skillbundle.skillcategory )
            {
                if ( player.activeskills )
                {
                    player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                }
                else
                {
                    if ( !isdefined( player.loadoutskills ) )
                    {
                        player.loadoutskills = [];
                    }
                    
                    player.loadoutskills[ player.loadoutskills.size ] = lootinfo.itemrefhash;
                }
                
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with major ability upgrade [" + var_fd72d806617d5cfe + "]" );
            }
            else
            {
                assertmsg( "<dev string:x111>" + ( player.name ?? "<dev string:x127>" ) + "<dev string:x128>" + var_fd72d806617d5cfe + "<dev string:x142>" );
            }
        }
    }
    
    var_79eeedad8e36343a = int( common_instance_inventory::function_9513862f69ec0498( 8, operatorinstance, 1 ) ?? 0 );
    
    if ( isdefined( var_79eeedad8e36343a ) && var_79eeedad8e36343a != 0 )
    {
        lootinfo = getlootiteminfofromid( var_79eeedad8e36343a );
        
        if ( lootinfo.itemrefhash )
        {
            skillbundle = getscriptbundlefieldvalues( lootinfo.itemrefhash, [ #"skillref", #"skilllevel", #"hash_328ef7b7091f63ce" ] );
            
            if ( #"ability" == skillbundle.skillcategory )
            {
                if ( player.activeskills )
                {
                    player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                }
                else
                {
                    if ( !isdefined( player.loadoutskills ) )
                    {
                        player.loadoutskills = [];
                    }
                    
                    player.loadoutskills[ player.loadoutskills.size ] = lootinfo.itemrefhash;
                }
                
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with minor ability upgrade [" + var_79eeedad8e36343a + "]" );
                return;
            }
            
            assertmsg( "<dev string:x111>" + ( player.name ?? "<dev string:x127>" ) + "<dev string:x128>" + var_79eeedad8e36343a + "<dev string:x167>" );
        }
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x777de169, Offset: 0x4497
// Size: 0xc56
function private function_73b90e9083e45a14( player )
{
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        kick( player, &"exe/playerkicked_no_bio_lab_ticket" );
        throw( "[OB_PERSIST] Operator instance was invalid for player [" + ( player.name ?? "" ) + "] when granting items." );
        return;
    }
    
    if ( level.skillbundles && level.var_bb86f77304f193c4.var_f66beef5bbf4bf84 )
    {
        function_cbe484a956b4bf6f( player, operatorinstance );
        function_92bd4d3ab324a52b( player, operatorinstance );
        function_c6ea33f95d1d0080( player, operatorinstance );
        function_d88e3ef2b3f0da16( player, operatorinstance );
    }
    
    if ( level.var_bb86f77304f193c4.var_c62180fe4306e249 )
    {
        if ( player.var_d501198ca744e2ac )
        {
            powertier = player utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" );
            player ob_power_tier::function_49df213d9360b40a( powertier, 0 );
            skilltracks = player.activeskills ? player.skilltracks : player.loadoutSkillTracks;
            
            foreach ( skilltrack in skilltracks )
            {
                if ( !skilltrack.isspecial )
                {
                    player.tracksshown[ skilltrack.lootid ] = 1;
                }
            }
            
            if ( skilltracks.size && getdvarint( @"hash_5d414c4d908651b6", 1 ) )
            {
                player.var_22fd7981908e96c1 = [];
                
                for ( key = 10; key <= 13 ; key++ )
                {
                    var_6e8fa4f9bb061f5e = int( common_instance_inventory::function_9513862f69ec0498( key, operatorinstance, 0 ) ?? 0 );
                    
                    if ( var_6e8fa4f9bb061f5e != 0 && !skilltracks[ var_6e8fa4f9bb061f5e ] )
                    {
                        player.var_22fd7981908e96c1[ player.var_22fd7981908e96c1.size ] = var_6e8fa4f9bb061f5e;
                    }
                }
                
                validtracks = [];
                
                foreach ( track in level.skilltracklist )
                {
                    if ( !track.isspecial && !player.tracksshown[ track.lootid ] )
                    {
                        validtracks[ validtracks.size ] = track;
                    }
                }
                
                validtracks = arrayrandomize( validtracks );
                player.var_7abd0979037af008 = [];
                
                foreach ( track in validtracks )
                {
                    if ( !arraycontains( player.var_22fd7981908e96c1, track.lootid ) )
                    {
                        player.var_7abd0979037af008[ player.var_7abd0979037af008.size ] = track;
                    }
                }
                
                validtracks = arrayremove( validtracks, player.var_7abd0979037af008 );
                
                foreach ( track in validtracks )
                {
                    player.var_7abd0979037af008[ player.var_7abd0979037af008.size ] = track;
                }
            }
        }
        else
        {
            powertier = maxint( 1, int( common_instance_inventory::function_9513862f69ec0498( 1, operatorinstance, 0 ) ?? 1 ) );
            powertier %= 100;
            powertier_xp = int( common_instance_inventory::function_9513862f69ec0498( 2, operatorinstance, 0 ) ?? 0 );
            powertiernexttierxp = int( common_instance_inventory::function_9513862f69ec0498( 3, operatorinstance, 0 ) ?? 0 );
            player ob_power_tier::function_49df213d9360b40a( powertier, powertier_xp );
            var_d5fb8d4e61f2860d = int( common_instance_inventory::function_9513862f69ec0498( 4, operatorinstance, 0 ) ?? 0 );
            
            if ( var_d5fb8d4e61f2860d > 0 )
            {
                player.var_d5fb8d4e61f2860d = var_d5fb8d4e61f2860d;
            }
            
            skilltracks = player.skilltracks ?? player.loadoutSkillTracks;
            var_f367e40e57c6b1ab = int( common_instance_inventory::function_9513862f69ec0498( 5, operatorinstance, 0 ) ?? 0 );
            var_f367e30e57c6af78 = int( common_instance_inventory::function_9513862f69ec0498( 6, operatorinstance, 0 ) ?? 0 );
            
            if ( var_f367e40e57c6b1ab != 0 && var_f367e30e57c6af78 != 0 )
            {
                var_ba2c2ad890b378f3 = getlootiteminfofromid( var_f367e40e57c6b1ab );
                
                if ( var_ba2c2ad890b378f3.itemrefhash )
                {
                    var_7e6f0420e4cb6325 = getscriptbundlefieldvalues( var_ba2c2ad890b378f3.itemrefhash, [ #"skillref", #"skilllevel" ] );
                    
                    if ( var_7e6f0420e4cb6325.skillref )
                    {
                        player.selectableskills[ 0 ] = level.skillbundles[ var_7e6f0420e4cb6325.skillref ][ var_7e6f0420e4cb6325.skilllevel ];
                    }
                }
                
                var_7e75289d3053c9e0 = getlootiteminfofromid( var_f367e30e57c6af78 );
                
                if ( var_7e75289d3053c9e0.itemrefhash )
                {
                    var_655f312d31ff42aa = getscriptbundlefieldvalues( var_7e75289d3053c9e0.itemrefhash, [ #"skillref", #"skilllevel" ] );
                    
                    if ( var_655f312d31ff42aa.skillref )
                    {
                        player.selectableskills[ 1 ] = level.skillbundles[ var_655f312d31ff42aa.skillref ][ var_655f312d31ff42aa.skilllevel ];
                    }
                }
                
                var_c0cadf4c9811f6d5 = int( common_instance_inventory::function_9513862f69ec0498( 7, operatorinstance, 0 ) ?? 0 );
                var_c0cade4c9811f4a2 = int( common_instance_inventory::function_9513862f69ec0498( 8, operatorinstance, 0 ) ?? 0 );
                
                if ( var_c0cadf4c9811f6d5 != 0 && var_c0cade4c9811f4a2 != 0 )
                {
                    foreach ( track in level.skilltracklist )
                    {
                        if ( track.lootid == var_c0cadf4c9811f6d5 )
                        {
                            player.selectabletracks[ 0 ] = track;
                            continue;
                        }
                        
                        if ( track.lootid == var_c0cade4c9811f4a2 )
                        {
                            player.selectabletracks[ 1 ] = track;
                        }
                    }
                }
                
                var_9bdb21cb7f959482 = int( common_instance_inventory::function_9513862f69ec0498( 9, operatorinstance, 0 ) ?? 0 );
                
                switch ( var_9bdb21cb7f959482 )
                {
                    case 0:
                        player.var_4971bba44f275df = "NEW_TRACK";
                        break;
                    case 1:
                        player.var_4971bba44f275df = "SKILL";
                        break;
                    case 3:
                        player.var_4971bba44f275df = "CORE_UPGRADE";
                        break;
                }
                
                thread ob_power_tier::function_ef05c43368e714fa();
            }
            else
            {
                var_a3f9f12d730c3d24 = 0;
                
                foreach ( track in skilltracks )
                {
                    if ( !track.isspecial )
                    {
                        var_a3f9f12d730c3d24++;
                    }
                }
                
                foreach ( rule in level.var_4281aa3f0598bb1a[ "ABOVE" ] )
                {
                    if ( rule.skillchoice != "NEW_TRACK" )
                    {
                        continue;
                    }
                    
                    var_5f9ddbb27b1ddd36 = !isdefined( rule.requiredprestige ) || player.operatorprestige >= rule.requiredprestige;
                    
                    if ( !var_5f9ddbb27b1ddd36 )
                    {
                        continue;
                    }
                    
                    var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || var_a3f9f12d730c3d24 == rule.var_104780e73f6503de;
                    
                    if ( !var_8bcc1968343d1daa )
                    {
                        continue;
                    }
                    
                    if ( powertier > rule.var_357fcbfb5c1b355f )
                    {
                        player.var_6e6abd7fa4d7b630 = "NEW_TRACK";
                        break;
                    }
                }
            }
            
            for ( key = 10; key <= 13 ; key++ )
            {
                var_6e8fa4f9bb061f5e = int( common_instance_inventory::function_9513862f69ec0498( key, operatorinstance, 0 ) ?? 0 );
                
                if ( var_6e8fa4f9bb061f5e != 0 && !skilltracks[ var_6e8fa4f9bb061f5e ] )
                {
                    player.tracksshown[ var_6e8fa4f9bb061f5e ] = 1;
                }
            }
        }
        
        if ( level.var_e11c97ded8b60eba )
        {
            logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] entered the match with power tier info [" + powertier + "," + ( powertier_xp ?? 0 ) + "," + ( powertiernexttierxp ?? 0 ) + "]" );
        }
    }
    
    if ( level.var_bb86f77304f193c4.var_2d2d1c3f75c4f3d )
    {
        killstreaklootid = operatorinstance.var_a834790f492b07f8[ 2 ] ?? 0;
        selfrevivelootid = operatorinstance.var_a834790f492b07f8[ 3 ] ?? 0;
        
        foreach ( kvp in operatorinstance.var_c11bbd62e8f23645 )
        {
            if ( kvp.key == 2 )
            {
                if ( kvp.valuelow != 0 )
                {
                    killstreaklootid = kvp.valuelow;
                }
                
                continue;
            }
            
            if ( kvp.key == 3 )
            {
                if ( kvp.valuelow != 0 )
                {
                    selfrevivelootid = kvp.valuelow;
                }
            }
        }
        
        if ( killstreaklootid != 0 )
        {
            common_instance_inventory::grantinstance( player, killstreaklootid );
            
            if ( int( common_instance_inventory::function_9513862f69ec0498( 14, operatorinstance, 0 ) ?? 0 ) )
            {
                player.pers[ "killstreak_from_supply_drop" ] = 1;
            }
        }
        
        if ( selfrevivelootid != 0 )
        {
            common_instance_inventory::grantinstance( player, selfrevivelootid );
        }
        
        operatorinstance.var_a834790f492b07f8[ 2 ] = 0;
        operatorinstance.var_a834790f492b07f8[ 3 ] = 0;
        operatorinstance.var_a834790f492b07f8[ 4 ] = 0;
        operatorinstance.var_a834790f492b07f8[ 5 ] = 0;
    }
    
    var_196eb69a6df28a8 = common_instance_inventory::function_dba82bdee30f1799( operatorinstance.metadata );
    var_6102a1e83f8b1567 = common_instance_inventory::function_dba82bdee30f1799( operatorinstance.var_c11bbd62e8f23645 );
    player function_1fe0234f56138fe1( operatorinstance.instanceid );
    player function_c178641b0ba5bf6f( operatorinstance.lootid, 22, operatorinstance.location, operatorinstance.sublocation, operatorinstance.var_a834790f492b07f8, var_196eb69a6df28a8, var_6102a1e83f8b1567 );
    self.var_c72cb0043263a756 = 1;
    
    if ( !self.var_b7d546af89f1f5c0 )
    {
        function_1f308eed6ec0b();
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x89f9aa74, Offset: 0x50f5
// Size: 0xa43
function private function_5be6152d5d718bdb( player )
{
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        kick( player, &"exe/playerkicked_no_bio_lab_ticket" );
        throw( "[OB_PERSIST] Operator instance was invalid for player [" + ( player.name ?? "" ) + "] when extracting items." );
        return;
    }
    
    operatormetadata = { #values:[], #keys:[] };
    var_afbdb0773fa28641 = { #values:[], #keys:[] };
    
    if ( level.var_bb86f77304f193c4.var_dce79dea79de81e7 )
    {
        var_d21e1ce96d9279d3 = player common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"primary_0" } );
        
        if ( var_d21e1ce96d9279d3.name && 6 == getscriptbundlefieldvalue( var_d21e1ce96d9279d3.name, #"rarity" ) )
        {
            if ( level.var_e11c97ded8b60eba )
            {
                logstring( "[OB_PERSIST] Swapping the primary and secondary weapon slots to force the exotic weapon into the secondary slot." );
            }
            
            player.var_968d4e31d974605 = 1;
            player common_instance_inventory::function_1ce404f00d7b49f6( #"primary_0", #"secondaryweapon" );
            player common_instance_inventory::function_1ce404f00d7b49f6( #"primary_1", #"primaryweapon" );
        }
        else
        {
            player common_instance_inventory::function_1ce404f00d7b49f6( #"primary_0", #"primaryweapon" );
            player common_instance_inventory::function_1ce404f00d7b49f6( #"primary_1", #"secondaryweapon" );
        }
        
        player common_instance_inventory::function_1ce404f00d7b49f6( #"tertiary_0", #"tertiaryweapon" );
    }
    
    if ( level.var_bb86f77304f193c4.var_2948481129199154 )
    {
        equipmentLootID = loot::getlootidfromref( class::table_getequipmentprimary( level.classtablename, 0 ) ) ?? 0;
        var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "lethal" );
        
        if ( var_8fb8e1fb220cca48.name )
        {
            itembundle = getscriptbundlefieldvalues( var_8fb8e1fb220cca48.name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
            
            if ( itembundle.var_74fdf8cd1e01b989 || utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
            {
                equipmentLootID = self.var_92c60993d80d57b5[ itembundle.ref ] ?? common_item::items_getlootidfromref( itembundle.ref );
            }
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 4;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = equipmentLootID;
    }
    
    if ( level.var_bb86f77304f193c4.var_8fc0f845c6c24fab )
    {
        killstreaklootid = undefined;
        var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "killstreak" );
        
        if ( var_8fb8e1fb220cca48.name && var_8fb8e1fb220cca48.count > 0 )
        {
            itembundle = getscriptbundlefieldvalues( var_8fb8e1fb220cca48.name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
            
            if ( itembundle.var_74fdf8cd1e01b989 || utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
            {
                killstreaklootid = common_item::items_getlootidfromref( itembundle.ref );
            }
        }
        
        operatormetadata.keys[ operatormetadata.keys.size ] = 14;
        operatormetadata.values[ operatormetadata.values.size ] = killstreaklootid > 0 ? player.pers[ "killstreak_from_supply_drop" ] ?? 0 : 0;
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 2;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = killstreaklootid ?? 0;
        revivelootid = undefined;
        var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "revive" );
        
        if ( var_8fb8e1fb220cca48.name && var_8fb8e1fb220cca48.count > 0 )
        {
            itembundle = getscriptbundlefieldvalues( var_8fb8e1fb220cca48.name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
            
            if ( itembundle.var_74fdf8cd1e01b989 || utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
            {
                revivelootid = common_item::items_getlootidfromref( itembundle.ref );
            }
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 3;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = revivelootid ?? 0;
        operatorinstance.var_a834790f492b07f8[ 4 ] = 0;
    }
    
    if ( level.var_bb86f77304f193c4.var_eaf5ffe31deb0372 )
    {
        fieldupgrade1 = player perkpackage::perkpackage_getfirstfieldupgrade();
        overrideinfo = level.superglobals.refoverrides[ fieldupgrade1 ];
        
        if ( overrideinfo )
        {
            fieldupgrade1 = overrideinfo.baseref;
        }
        
        var_36eaf0e1207134b5 = getLootItemInfoFromRef( fieldupgrade1 );
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 5;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_36eaf0e1207134b5.itemid ?? 0;
        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] exited the match with major ability [" + ( var_36eaf0e1207134b5.itemid ?? 0 ) + "]" );
        var_96b825116401a9dd = player supers_mp::getcurrentsuper( #"tactical" );
        fieldupgrade2 = var_96b825116401a9dd.staticdata.ref;
        overrideinfo = level.superglobals.refoverrides[ fieldupgrade2 ];
        
        if ( overrideinfo )
        {
            fieldupgrade2 = overrideinfo.baseref;
        }
        
        var_38db082ee4fb2199 = getLootItemInfoFromRef( fieldupgrade2 );
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 6;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_38db082ee4fb2199.itemid ?? 0;
        logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] exited the match with minor ability [" + ( var_38db082ee4fb2199.itemid ?? 0 ) + "]" );
    }
    
    if ( level.skillbundles && level.var_bb86f77304f193c4.var_386f370256579af8 )
    {
        if ( player.activeskills.size || player.var_1f7050a4c29b6a13.size )
        {
            function_c08ad468170b8de4( player );
        }
        
        var_fd72d806617d5cfe = 0;
        var_61801b16956528b6 = player.var_171e758625364ee0[ "major_ability_upgrade" ];
        
        if ( var_61801b16956528b6 )
        {
            var_e0c66d9b26e1ced9 = player.var_bcde97a1f15e0648[ var_61801b16956528b6 ];
            
            if ( isdefined( var_e0c66d9b26e1ced9 ) )
            {
                var_fd72d806617d5cfe = level.skillbundles[ var_61801b16956528b6 ][ var_e0c66d9b26e1ced9 ].lootid ?? 0;
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] exited the match with major ability upgrade [" + var_fd72d806617d5cfe + "]" );
            }
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 7;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_fd72d806617d5cfe;
        var_79eeedad8e36343a = 0;
        var_728b9a9a7eb61d02 = player.var_171e758625364ee0[ "minor_ability_upgrade" ];
        
        if ( var_728b9a9a7eb61d02 )
        {
            var_d739a3ae6c68f61d = player.var_bcde97a1f15e0648[ var_728b9a9a7eb61d02 ];
            
            if ( isdefined( var_d739a3ae6c68f61d ) )
            {
                var_79eeedad8e36343a = level.skillbundles[ var_728b9a9a7eb61d02 ][ var_d739a3ae6c68f61d ].lootid ?? 0;
                logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] exited the match with minor ability upgrade [" + var_79eeedad8e36343a + "]" );
            }
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 8;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_79eeedad8e36343a;
    }
    
    if ( player.var_77fecdad95537975 && level.gametypebundle.var_5dd5f3ca4d3a1ea4 )
    {
        aeeventname = level.gametypebundle.var_5dd5f3ca4d3a1ea4;
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        unlockeventparams = [];
        unlockeventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
        unlockeventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = getscriptbundlefieldvalue( %"consumable:sat_ob_rescue_token", #"lootid" );
        player function_2e45314624fdfdb8( aeeventid, unlockeventparams );
    }
    
    player function_1fe0234f56138fe1( operatorinstance.instanceid );
    var_c9b995c8fa56cfff = common_instance_inventory::function_dba82bdee30f1799( operatorinstance.metadata );
    var_2b83d0c9c2235be4 = common_instance_inventory::function_dba82bdee30f1799( operatorinstance.var_c11bbd62e8f23645 );
    player function_c178641b0ba5bf6f( operatorinstance.lootid, 22, operatorinstance.location, operatorinstance.sublocation, operatorinstance.var_a834790f492b07f8, var_c9b995c8fa56cfff, var_2b83d0c9c2235be4 );
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    common_instance_inventory::function_a568f4d2f7413a60( operatormetadata.keys, operatormetadata.values, operatorinstance, 0 );
    common_instance_inventory::function_a568f4d2f7413a60( var_afbdb0773fa28641.keys, var_afbdb0773fa28641.values, operatorinstance, 1 );
}

// Namespace ob_persist
// Params 4, eflags: 0x4
// Checksum 0x8dc81457, Offset: 0x5b40
// Size: 0x2da, Type: bool
function private function_111104c3c9799a8c( player, slot, loadoutindex, weaponindex )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        weaponlootid = player getplayerdata( level.loadoutdata, "loadouts", loadoutindex, "weaponSetups", weaponindex, "weaponLootID" );
    }
    else
    {
        weaponlootid = player getplayerdata( level.loadoutdata, "squadMembers", "loadouts", loadoutindex, "weaponSetups", weaponindex, "lootItemID" );
    }
    
    if ( !( isdefined( weaponlootid ) && weaponlootid != 0 ) )
    {
        return false;
    }
    
    subcomponents = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() ) + 1;
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachmentlootid = player getplayerdata( level.loadoutdata, "loadouts", loadoutindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "attachmentBlueprintLootID" );
        
        if ( !( isdefined( attachmentlootid ) && attachmentlootid != 0 ) )
        {
            attachmentlootid = player getplayerdata( level.loadoutdata, "loadouts", loadoutindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "attachmentLootID" );
        }
        
        if ( isdefined( attachmentlootid ) && attachmentlootid != 0 )
        {
            subcomponents[ subcomponents.size ] = attachmentlootid;
        }
    }
    
    var_fcd2d823410c8677 = player class::cac_getweaponcamo( loadoutindex, weaponindex );
    
    if ( var_fcd2d823410c8677 )
    {
        camoLootID = loot::getlootidfromref( var_fcd2d823410c8677 );
        
        if ( isdefined( camoLootID ) && camoLootID != 0 )
        {
            subcomponents[ subcomponents.size ] = camoLootID;
        }
    }
    
    var_a9d84a3b78840c13 = player class::cac_getweaponreticle( loadoutindex, weaponindex );
    
    if ( var_a9d84a3b78840c13 )
    {
        reticleLootID = loot::getlootidfromref( var_a9d84a3b78840c13 );
        
        if ( isdefined( reticleLootID ) && reticleLootID != 0 )
        {
            subcomponents[ subcomponents.size ] = reticleLootID;
        }
    }
    
    var_78ec8d87c78fe062 = player class::cac_getweaponcosmeticattachment( loadoutindex, weaponindex );
    
    if ( var_78ec8d87c78fe062 )
    {
        cosmeticlootid = loot::getlootidfromref( var_78ec8d87c78fe062 );
        
        if ( isdefined( cosmeticlootid ) && cosmeticlootid != 0 )
        {
            subcomponents[ subcomponents.size ] = cosmeticlootid;
        }
    }
    
    var_ec96f3fca615049 = 0;
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        stickerref = player class::cac_getweaponsticker( loadoutindex, weaponindex, stickerindex );
        
        if ( stickerref )
        {
            stickerlootid = loot::getlootidfromref( stickerref );
            
            if ( isdefined( stickerlootid ) && stickerlootid != 0 )
            {
                subcomponents[ subcomponents.size ] = stickerlootid;
                var_ec96f3fca615049 |= 1 << stickerindex;
            }
        }
    }
    
    player common_instance_inventory::function_faae73a378ff8c45( weaponlootid, 24, slot, subcomponents );
    
    if ( var_ec96f3fca615049 > 0 )
    {
        instance = common_instance_inventory::function_4c1e57c205fb4b91( player, slot );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( instance ) )
        {
            common_instance_inventory::function_a568f4d2f7413a60( [ 13 ], [ var_ec96f3fca615049 ], instance, 1 );
        }
    }
    
    return true;
}

// Namespace ob_persist
// Params 3, eflags: 0x4
// Checksum 0x1b437c9, Offset: 0x5e23
// Size: 0x1de
function private function_4935baeff629a35e( player, var_137a6e1697781066, var_4ee1b405ad2502b7 = 0 )
{
    activeskills = ( player.activeskills.size ? player.activeskills : player.var_1f7050a4c29b6a13 ) ?? [];
    skills = [];
    metadata = [ [ 1, 0 ], [ 2, var_4ee1b405ad2502b7 ] ];
    
    foreach ( skill in var_137a6e1697781066.skills )
    {
        skilllevel = activeskills[ skill.skillref ];
        
        if ( !isdefined( skilllevel ) )
        {
            continue;
        }
        
        skillbundle = level.skillbundles[ skill.skillref ][ skilllevel ];
        
        if ( !isdefined( skillbundle ) || skillbundle.disabled )
        {
            continue;
        }
        
        skills[ skills.size ] = skillbundle.lootid;
        metadata[ 0 ][ 1 ] += skilllevel + 1;
        
        if ( level.var_e11c97ded8b60eba )
        {
            logstring( "[OB_PERSIST] Player [" + ( player.name ?? "" ) + "] exited the match with skill [" + skillbundle.lootid + "]" );
        }
    }
    
    return { #metadata:metadata, #skills:skills };
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x9f2c6cf2, Offset: 0x600a
// Size: 0x54e
function private function_c08ad468170b8de4( player )
{
    var_77fd1dd8fa4da096 = [];
    var_8970187c10d2f9da = [];
    
    foreach ( var_f56623bd3361d482 in level.var_8f270e6f9451724d )
    {
        var_325ae668ec76518b = undefined;
        var_245dd45e827da361 = common_instance_inventory::function_4c1e57c205fb4b91( player, var_f56623bd3361d482 );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( var_245dd45e827da361 ) )
        {
            var_325ae668ec76518b = getlootiteminfofromid( var_245dd45e827da361.lootid );
            
            if ( isdefined( var_325ae668ec76518b.itemrefhash ) )
            {
                var_245dd45e827da361.slot = var_f56623bd3361d482;
                var_77fd1dd8fa4da096[ var_325ae668ec76518b.itemrefhash ] = var_245dd45e827da361;
            }
        }
        
        slotavailable = 1;
        
        foreach ( var_137a6e1697781066 in player.skilltracks )
        {
            if ( var_137a6e1697781066.ref == var_325ae668ec76518b.itemrefhash )
            {
                slotavailable = 0;
                break;
            }
        }
        
        if ( slotavailable )
        {
            var_8970187c10d2f9da[ var_8970187c10d2f9da.size ] = var_f56623bd3361d482;
        }
        
        player common_instance_inventory::function_295a263162af11ac( var_f56623bd3361d482 );
    }
    
    var_f746072d5dd144ad = 0;
    
    foreach ( var_137a6e1697781066 in player.skilltracks )
    {
        if ( var_137a6e1697781066.isspecial )
        {
            continue;
        }
        
        var_be21ee552325310b = function_4935baeff629a35e( player, var_137a6e1697781066, self.pers[ "mostRecentSkillTrackLootID" ] == var_137a6e1697781066.lootid );
        var_245dd45e827da361 = var_77fd1dd8fa4da096[ var_137a6e1697781066.ref ];
        
        if ( var_245dd45e827da361 )
        {
            var_f9c6f25b7483dfe6 = var_245dd45e827da361.slot;
            tracklootid = var_245dd45e827da361.lootid;
        }
        else
        {
            var_f9c6f25b7483dfe6 = var_8970187c10d2f9da[ var_f746072d5dd144ad ];
            tracklootid = var_137a6e1697781066.lootid;
            var_f746072d5dd144ad++;
        }
        
        player common_instance_inventory::function_faae73a378ff8c45( tracklootid, 23, var_f9c6f25b7483dfe6, var_be21ee552325310b.skills, var_be21ee552325310b.metadata, [] );
    }
    
    if ( level.var_858d230de58cc743.var_4e18ee5e7c3b2610 )
    {
        var_b152e0b08c1bc62a = getscriptbundlefieldvalues( level.var_858d230de58cc743.var_4e18ee5e7c3b2610, [ #"lootid", #"skills" ] );
        var_f9a289c36dd5eba7 = function_4935baeff629a35e( player, var_b152e0b08c1bc62a );
        player common_instance_inventory::function_295a263162af11ac( #"hash_fc1160f8e3c9f8ef" );
        
        if ( var_f9a289c36dd5eba7.skills.size )
        {
            player common_instance_inventory::function_faae73a378ff8c45( var_b152e0b08c1bc62a.lootid, 23, #"hash_fc1160f8e3c9f8ef", var_f9a289c36dd5eba7.skills, var_f9a289c36dd5eba7.metadata, [] );
        }
    }
    
    if ( level.var_858d230de58cc743.var_e59f229d9bf9be39 )
    {
        var_490b9a4413aa0e50 = getscriptbundlefieldvalues( level.var_858d230de58cc743.var_e59f229d9bf9be39, [ #"lootid", #"skills" ] );
        var_f97e597cbe5f3855 = function_4935baeff629a35e( player, var_490b9a4413aa0e50 );
    }
    
    if ( level.var_858d230de58cc743.var_bc74fbad7319c534 )
    {
        var_a0d40cd0118d3f = getscriptbundlefieldvalues( level.var_858d230de58cc743.var_bc74fbad7319c534, [ #"lootid", #"skills" ] );
        var_8219eef638b2912 = function_4935baeff629a35e( player, var_a0d40cd0118d3f );
    }
    
    if ( var_f97e597cbe5f3855.skills.size || var_8219eef638b2912.skills.size )
    {
        lootid = var_490b9a4413aa0e50.lootid ?? var_a0d40cd0118d3f.lootid;
        trackinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"hash_952f20a0293debc7" );
        
        if ( common_instance_inventory::function_ae3907698ee6e6f1( trackinstance ) )
        {
            lootid = trackinstance.lootid;
            player common_instance_inventory::function_295a263162af11ac( #"hash_952f20a0293debc7" );
        }
        
        components = arraycombine( var_f97e597cbe5f3855.skills ?? [], var_8219eef638b2912.skills ?? [] );
        player common_instance_inventory::function_faae73a378ff8c45( lootid, 23, #"hash_952f20a0293debc7", components, var_f97e597cbe5f3855.metadata ?? [], [] );
        return;
    }
    
    player common_instance_inventory::function_295a263162af11ac( #"hash_952f20a0293debc7" );
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0xd56393a6, Offset: 0x6560
// Size: 0x6f4
function private function_d493ce381a212c78( player, var_d9dd0f607fb24c05 )
{
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        metadata = { #values:[], #keys:[] };
        metadata.keys[ metadata.keys.size ] = 1;
        metadata.values[ metadata.values.size ] = self.powertier + 100 * self.operatorprestige;
        metadata.keys[ metadata.keys.size ] = 2;
        metadata.values[ metadata.values.size ] = self.powertier_xp;
        metadata.keys[ metadata.keys.size ] = 3;
        metadata.values[ metadata.values.size ] = self.powertiernexttierxp;
        metadata.keys[ metadata.keys.size ] = 4;
        metadata.values[ metadata.values.size ] = self.var_d5fb8d4e61f2860d ?? 0;
        
        if ( isdefined( self.selectableskills[ 0 ] ) && isdefined( self.selectableskills[ 1 ] ) && ( ob_skill_select::ob_skill_select_is_active() || istrue( self.var_6c41ce781dd1b407 ) ) )
        {
            metadata.keys[ metadata.keys.size ] = 5;
            metadata.values[ metadata.values.size ] = self.selectableskills[ 0 ].lootid;
            metadata.keys[ metadata.keys.size ] = 6;
            metadata.values[ metadata.values.size ] = self.selectableskills[ 1 ].lootid;
            metadata.keys[ metadata.keys.size ] = 7;
            metadata.values[ metadata.values.size ] = self.selectabletracks[ 0 ].lootid ?? 0;
            metadata.keys[ metadata.keys.size ] = 8;
            metadata.values[ metadata.values.size ] = self.selectabletracks[ 1 ].lootid ?? 0;
            metadata.keys[ metadata.keys.size ] = 9;
            
            switch ( self.var_4971bba44f275df )
            {
                case #"hash_f89a366fb7e1d999":
                default:
                    metadata.values[ metadata.values.size ] = 0;
                    break;
                case #"hash_8f24445c1df2d876":
                    metadata.values[ metadata.values.size ] = 1;
                    break;
                case #"hash_3c6a2be723070e29":
                    metadata.values[ metadata.values.size ] = 3;
                    break;
            }
        }
        else
        {
            metadata.keys[ metadata.keys.size ] = 5;
            metadata.values[ metadata.values.size ] = 0;
            metadata.keys[ metadata.keys.size ] = 6;
            metadata.values[ metadata.values.size ] = 0;
            metadata.keys[ metadata.keys.size ] = 7;
            metadata.values[ metadata.values.size ] = 0;
            metadata.keys[ metadata.keys.size ] = 8;
            metadata.values[ metadata.values.size ] = 0;
            metadata.keys[ metadata.keys.size ] = 9;
            metadata.values[ metadata.values.size ] = 0;
        }
        
        if ( var_d9dd0f607fb24c05 )
        {
            for ( key = 10; key <= 13 ; key++ )
            {
                metadata.keys[ metadata.keys.size ] = key;
                metadata.values[ metadata.values.size ] = 0;
            }
        }
        else
        {
            var_4861b26475fd90fa = 10;
            
            foreach ( tracklootid, _ in self.tracksshown )
            {
                if ( isdefined( self.skilltracks[ tracklootid ] ) )
                {
                    continue;
                }
                
                metadata.keys[ metadata.keys.size ] = var_4861b26475fd90fa;
                metadata.values[ metadata.values.size ] = tracklootid;
                var_4861b26475fd90fa++;
                
                if ( var_4861b26475fd90fa > 13 )
                {
                    break;
                }
            }
            
            if ( var_4861b26475fd90fa <= 13 )
            {
                for ( i = 0; i < self.var_22fd7981908e96c1.size ; i++ )
                {
                    tracklootid = self.var_22fd7981908e96c1[ i ];
                    
                    if ( arraycontains( metadata.values, tracklootid ) )
                    {
                        continue;
                    }
                    
                    metadata.keys[ metadata.keys.size ] = var_4861b26475fd90fa;
                    metadata.values[ metadata.values.size ] = tracklootid;
                    var_4861b26475fd90fa++;
                    
                    if ( var_4861b26475fd90fa > 13 )
                    {
                        break;
                    }
                }
            }
        }
        
        if ( level.var_e11c97ded8b60eba )
        {
            logstring( "[OB_PERSIST] Player [" + ( self.name ?? "" ) + "] exited the match with power tier info [" + self.powertier + "," + self.powertier_xp + "," + self.powertiernexttierxp + "]." );
        }
        
        logstring( "[OB_PERSIST] Player [" + ( self.name ?? "" ) + "] exited the match with power level [" + metadata.values[ 0 ] + "]." );
        common_instance_inventory::function_a568f4d2f7413a60( metadata.keys, metadata.values, operatorinstance );
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x6fd155fa, Offset: 0x6c5c
// Size: 0x8cc
function private function_ac2308074632d63( player )
{
    shotsfired = player.pers[ "shotsFired" ] ?? 0;
    
    if ( !getdvarint( @"hash_4eb5fa9f80986692", 1 ) || shotsfired == 0 )
    {
        var_ada4fa53db68ba89 = getdvarint( @"hash_5c869b8df5b17357", 0 );
        
        if ( var_ada4fa53db68ba89 > 0 && gettime() <= utility::function_4b74c15943231980( var_ada4fa53db68ba89 ) )
        {
            logstring( "[OB_PERSIST] Avoiding wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due them not being in the game longer than the server's grace period." );
            return;
        }
        
        var_df4f188230bdb9bc = getdvarint( @"hash_2bd3044c9b6ef82b", 120 );
        
        if ( var_df4f188230bdb9bc > 0 && gettime() - player.pers[ "firstConnectTime" ] <= utility::function_4b74c15943231980( var_df4f188230bdb9bc ) )
        {
            logstring( "[OB_PERSIST] Avoiding wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due them not being in the game longer than their grace period." );
            return;
        }
        
        if ( !player.var_e7aa9a9a4adfd15b )
        {
            logstring( "[OB_PERSIST] Avoiding wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due them not having finished loading." );
            return;
        }
        
        if ( getdvarint( @"hash_94bdf86151dcb61f", 1 ) && !player utility::ent_flag( "ob_infil_boots_on_ground" ) )
        {
            logstring( "[OB_PERSIST] Avoiding wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due them not having landed from infil." );
            return;
        }
        
        logstring( "[OB_PERSIST] Wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due to failing all the protection checks." );
    }
    else
    {
        logstring( "[OB_PERSIST] Wiping the items of player [" + ( player.name ?? player getxuid() ) + "] due to them having fired shots." );
    }
    
    operatorinstance = common_instance_inventory::function_4c1e57c205fb4b91( player, #"operator" );
    
    if ( !common_instance_inventory::function_ae3907698ee6e6f1( operatorinstance ) )
    {
        kick( player, &"exe/playerkicked_no_bio_lab_ticket" );
        throw( "[OB_PERSIST] Operator instance was invalid for player [" + ( player.name ?? "" ) + "] when wiping items." );
        return;
    }
    
    var_afbdb0773fa28641 = { #values:[], #keys:[] };
    
    if ( level.var_bb86f77304f193c4.var_ce50af5cfefe7346 )
    {
        player common_instance_inventory::function_295a263162af11ac( #"primaryweapon" );
        
        if ( !function_111104c3c9799a8c( player, #"primaryweapon", 0, 0 ) )
        {
            var_57e7b7f5fa22f19c = class::table_getweapon( level.classtablename, 0, 0 );
            
            if ( var_57e7b7f5fa22f19c )
            {
                var_b75fbf76900db348 = loot::getlootidfromref( var_57e7b7f5fa22f19c );
                
                if ( isdefined( var_b75fbf76900db348 ) && var_b75fbf76900db348 != 0 )
                {
                    player common_instance_inventory::function_faae73a378ff8c45( var_b75fbf76900db348, 24, #"primaryweapon" );
                }
            }
        }
        
        player common_instance_inventory::function_295a263162af11ac( #"secondaryweapon" );
        player common_instance_inventory::function_295a263162af11ac( #"tertiaryweapon" );
        
        if ( !function_111104c3c9799a8c( player, #"tertiaryweapon", 0, 2 ) )
        {
            var_25d3819937dba4ba = class::table_getweapon( level.classtablename, 0, 2 );
            
            if ( var_25d3819937dba4ba )
            {
                var_3b9f8b79b2dc22a2 = loot::getlootidfromref( var_25d3819937dba4ba );
                
                if ( isdefined( var_3b9f8b79b2dc22a2 ) && var_3b9f8b79b2dc22a2 != 0 )
                {
                    player common_instance_inventory::function_faae73a378ff8c45( var_3b9f8b79b2dc22a2, 24, #"tertiaryweapon" );
                }
            }
        }
    }
    
    if ( level.var_bb86f77304f193c4.var_bec22ffe24179b34 )
    {
        player function_de37db595f70e0b1( #"primaryweapon" );
        player function_de37db595f70e0b1( #"secondaryweapon" );
        player function_de37db595f70e0b1( #"tertiaryweapon" );
    }
    
    if ( level.var_bb86f77304f193c4.var_eaf5ffe31deb0372 )
    {
        if ( class::function_4d362babbfd5b4b1() )
        {
            var_d2a08c4fa07f48f8 = player getplayerdata( level.loadoutdata, "loadouts", 0, "fieldUpgradeSetups", 0, "fieldUpgradeLootID" );
        }
        else
        {
            var_d2a08c4fa07f48f8 = player getplayerdata( level.loadoutdata, "squadMembers", "loadouts", 0, "fieldUpgradeSetups", 0, "fieldUpgradeLootID" );
        }
        
        if ( !( isdefined( var_d2a08c4fa07f48f8 ) && var_d2a08c4fa07f48f8 != 0 ) )
        {
            var_d2a08c4fa07f48f8 = loot::getlootidfromref( "super_war_machine_ob" );
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 5;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_d2a08c4fa07f48f8 ?? 0;
        
        if ( class::function_4d362babbfd5b4b1() )
        {
            var_a661473f14343f4d = player getplayerdata( level.loadoutdata, "loadouts", 0, "fieldUpgradeSetups", 1, "fieldUpgradeLootID" );
        }
        else
        {
            var_a661473f14343f4d = player getplayerdata( level.loadoutdata, "squadMembers", "loadouts", 0, "fieldUpgradeSetups", 1, "fieldUpgradeLootID" );
        }
        
        if ( !( isdefined( var_a661473f14343f4d ) && var_a661473f14343f4d != 0 ) )
        {
            var_a661473f14343f4d = loot::getlootidfromref( "super_mega_jump_ob" );
        }
        
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 6;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_a661473f14343f4d ?? 0;
    }
    
    if ( level.var_bb86f77304f193c4.var_6df1fac256d79b3d )
    {
        foreach ( var_f56623bd3361d482 in level.var_8f270e6f9451724d )
        {
            player common_instance_inventory::function_295a263162af11ac( var_f56623bd3361d482 );
        }
        
        player common_instance_inventory::function_295a263162af11ac( #"hash_952f20a0293debc7" );
        player common_instance_inventory::function_295a263162af11ac( #"hash_fc1160f8e3c9f8ef" );
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 7;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 8;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
    }
    else if ( level.skillbundles && level.var_bb86f77304f193c4.var_386f370256579af8 )
    {
        function_c08ad468170b8de4( player );
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 7;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 8;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
    }
    
    if ( level.var_bb86f77304f193c4.var_38135788795a460e )
    {
        operatormetadata = { #values:[], #keys:[] };
        
        for ( key = 1; key <= 14 ; key++ )
        {
            operatormetadata.keys[ operatormetadata.keys.size ] = key;
            operatormetadata.values[ operatormetadata.values.size ] = 0;
        }
        
        common_instance_inventory::function_a568f4d2f7413a60( operatormetadata.keys, operatormetadata.values, operatorinstance, 0 );
    }
    else if ( level.var_bb86f77304f193c4.var_100658e2681927bf )
    {
        function_d493ce381a212c78( player, 1 );
    }
    
    if ( level.var_bb86f77304f193c4.var_d674b2eddf5dafd5 )
    {
        var_b999f016b6d0b92 = loot::getlootidfromref( class::table_getequipmentprimary( level.classtablename, 0 ) );
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 4;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = var_b999f016b6d0b92 ?? 0;
    }
    
    if ( level.var_bb86f77304f193c4.var_40a55052ef3f4e22 )
    {
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 2;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
        var_afbdb0773fa28641.keys[ var_afbdb0773fa28641.keys.size ] = 3;
        var_afbdb0773fa28641.values[ var_afbdb0773fa28641.values.size ] = 0;
    }
    
    common_instance_inventory::function_a568f4d2f7413a60( var_afbdb0773fa28641.keys, var_afbdb0773fa28641.values, operatorinstance, 1 );
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xd6281605, Offset: 0x7530
// Size: 0xc
function private function_9976ed527c1f86a4( player )
{
    
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x991b883b, Offset: 0x7544
// Size: 0x305
function private function_e2fa12d2daa604fe( weaponslot, slotref )
{
    weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( self, slotref );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( weaponinstance ) )
    {
        paplevel = common_instance_inventory::function_9513862f69ec0498( 3, weaponinstance, 0 );
        rarity = common_instance_inventory::function_9513862f69ec0498( 4, weaponinstance, 0 );
        ammomodid = common_instance_inventory::function_9513862f69ec0498( 5, weaponinstance, 0 );
        lootid = int( common_instance_inventory::function_9513862f69ec0498( 6, weaponinstance, 0 ) ?? 0 );
        conversionkitlootid = int( common_instance_inventory::function_9513862f69ec0498( 7, weaponinstance, 0 ) ?? 0 );
        weapon = item_weapon::function_e7484276ad85f220( weaponslot );
        
        if ( isdefined( weapon ) )
        {
            if ( lootid == 0 || weapon.baseweaponlootid != lootid )
            {
                return;
            }
            
            if ( isdefined( rarity ) )
            {
                rarity = int( rarity );
                item_weapon::function_40e1cbd0e1f47d1a( weapon, rarity );
            }
            
            if ( isdefined( conversionkitlootid ) )
            {
                ref = undefined;
                
                if ( getdvarint( @"hash_eb316d5b23dc2faa", 1 ) )
                {
                    newlootid = level.var_a2e5cf132f0e1f1[ conversionkitlootid ];
                    
                    if ( newlootid )
                    {
                        ref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", newlootid ) ?? loot::function_f54ecb89dfab8e8c( newlootid );
                    }
                    
                    if ( !isdefined( ref ) )
                    {
                        ref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", conversionkitlootid ) ?? loot::function_f54ecb89dfab8e8c( conversionkitlootid );
                    }
                }
                else
                {
                    ref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", conversionkitlootid ) ?? loot::function_f54ecb89dfab8e8c( conversionkitlootid );
                }
                
                if ( isdefined( ref ) && !weapon hasattachment( ref ) )
                {
                    newweapon = weapon withattachment( ref );
                    clipammo = self getweaponammoclip( weapon );
                    stockammo = self getweaponammostock( weapon );
                    clipsizeold = weaponclipsize( weapon );
                    clipsizenew = weaponclipsize( newweapon );
                    
                    if ( clipammo == clipsizeold )
                    {
                        clipammo = clipsizenew;
                    }
                    
                    var_546a2a6e5ffaf81a = utility::get_max_stock_ammo( weapon, 0 );
                    var_606e326e67df2a95 = utility::get_max_stock_ammo( newweapon, 0 );
                    
                    if ( stockammo == var_546a2a6e5ffaf81a )
                    {
                        stockammo = var_606e326e67df2a95;
                    }
                    else if ( stockammo == clipsizeold * 2 )
                    {
                        stockammo = clipsizenew * 2;
                    }
                    
                    self takeweapon( weapon );
                    self giveweapon( newweapon );
                    weapon = newweapon;
                    item_weapon::function_f9f12ddfa1766b72();
                    
                    if ( weapon::function_6b74ecd475e99b4( weapon ) )
                    {
                        weapon::function_b4c9549dee5d0fc5( weapon );
                    }
                    
                    self setweaponammoclip( weapon, clipammo );
                    self setweaponammostock( weapon, stockammo );
                }
            }
            
            if ( isdefined( ammomodid ) )
            {
                ammomodid = int( ammomodid );
                
                if ( ammomodid > 0 )
                {
                    ammomod = ammo_mod::function_7fe70894ab337d3f( ammomodid );
                    
                    if ( ammomod )
                    {
                        ammo_mod::add_ammo_mod_to_weapon( weapon, ammomod );
                    }
                }
            }
            
            if ( isdefined( paplevel ) )
            {
                paplevel = int( paplevel );
                
                if ( paplevel > 0 )
                {
                    pack_a_punch::pap_weapon( weapon, paplevel - 1 );
                    waitframe();
                }
            }
        }
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x62a1e75, Offset: 0x7851
// Size: 0x109
function private function_553f9a9c369f9611( scratchinstance )
{
    if ( common_instance_inventory::function_ae3907698ee6e6f1( scratchinstance ) )
    {
        if ( isdefined( scratchinstance.var_a834790f492b07f8 ) )
        {
            foreach ( lootid in scratchinstance.var_a834790f492b07f8 )
            {
                if ( !isdefined( lootid ) || lootid == 0 )
                {
                    continue;
                }
                
                itembundle = common_item::function_b202b16941992cca( lootid );
                
                if ( !isdefined( itembundle ) )
                {
                    continue;
                }
                
                item = spawnstruct();
                item.type = itembundle.scriptable;
                item.count = common_item::function_598dd39282efb544( 1 );
                common_item::function_2b5e2ff57d5f392( item, 0 );
            }
        }
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x23fd8bc6, Offset: 0x7962
// Size: 0xc
function private function_468841abeb37fe14( scratchinstance )
{
    
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xd02c37a2, Offset: 0x7976
// Size: 0xb9
function private function_de37db595f70e0b1( slotref )
{
    weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( self, slotref );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( weaponinstance ) )
    {
        metadata = { #values:[], #keys:[] };
        
        for ( key = 3; key <= 7 ; key++ )
        {
            metadata.keys[ metadata.keys.size ] = key;
            metadata.values[ metadata.values.size ] = 0;
        }
        
        common_instance_inventory::function_a568f4d2f7413a60( metadata.keys, metadata.values, weaponinstance );
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x32be33d7, Offset: 0x7a37
// Size: 0x2b0
function private function_d988a5f7acef86bd( player )
{
    if ( level.var_bb86f77304f193c4.var_fe1b7d243babdaa1 )
    {
        if ( player.var_968d4e31d974605 )
        {
            player function_2f759b1669f91bef( #"primary_0", #"secondaryweapon" );
            player function_2f759b1669f91bef( #"primary_1", #"primaryweapon" );
        }
        else
        {
            player function_2f759b1669f91bef( #"primary_0", #"primaryweapon" );
            player function_2f759b1669f91bef( #"primary_1", #"secondaryweapon" );
        }
        
        player function_2f759b1669f91bef( #"tertiary_0", #"tertiaryweapon" );
    }
    
    if ( level.var_bb86f77304f193c4.var_100658e2681927bf )
    {
        function_d493ce381a212c78( player );
    }
    
    if ( namespace_3a2a361a08f89b78::function_391b310b880fab80( player ) )
    {
        player common_instance_inventory::function_37fdf19667fcb5f6();
        var_2f493ccccbf55051 = player zombie_perks::get_active_perks_str_array();
        var_ea9842ddeabc2e07 = undefined;
        components = [];
        
        if ( var_2f493ccccbf55051.size > 0 )
        {
            var_ea9842ddeabc2e07 = common_item::items_getlootidfromref( var_2f493ccccbf55051[ 0 ] );
            
            if ( isdefined( var_ea9842ddeabc2e07 ) )
            {
                foreach ( perk in var_2f493ccccbf55051 )
                {
                    lootid = common_item::items_getlootidfromref( perk );
                    
                    if ( isdefined( lootid ) )
                    {
                        components[ components.size ] = lootid;
                    }
                }
            }
        }
        
        if ( isdefined( var_ea9842ddeabc2e07 ) )
        {
            player common_instance_inventory::function_faae73a378ff8c45( var_ea9842ddeabc2e07, 13, #"scratchprimary", components );
        }
        
        if ( common_instance_inventory::function_28e60cf07393549d( #"Wallet" ) )
        {
            var_8fb8e1fb220cca48 = player common_item::function_c4c43ebb7aa636dc( "currency" );
            
            if ( isdefined( var_8fb8e1fb220cca48 ) )
            {
                var_6ff6ee592ba056ba = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
                
                if ( isdefined( var_6ff6ee592ba056ba ) )
                {
                    components = [];
                    player common_instance_inventory::function_faae73a378ff8c45( var_6ff6ee592ba056ba, 16, #"Wallet", components );
                    var_667bc8a361e00e52 = common_instance_inventory::function_4c1e57c205fb4b91( self, #"Wallet" );
                    
                    if ( common_instance_inventory::function_ae3907698ee6e6f1( var_667bc8a361e00e52 ) )
                    {
                        player function_c17a2151cfca6224( var_667bc8a361e00e52.instanceid, var_8fb8e1fb220cca48.count );
                    }
                }
            }
        }
        
        return;
    }
    
    player function_18578c8762db6786( 0 );
    
    if ( common_instance_inventory::function_28e60cf07393549d( #"Wallet" ) )
    {
        player common_instance_inventory::function_295a263162af11ac( #"Wallet" );
    }
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x6f538a7a, Offset: 0x7cef
// Size: 0xe4
function private function_1e74b31eae3c6994( player, weaponobj )
{
    newweaponobj = undefined;
    var_1573a9bd3c71b0e0 = undefined;
    
    foreach ( attachment in weaponobj.attachments )
    {
        if ( "conversionkit" == getattachmentslot( weaponobj, attachment ) )
        {
            newweaponobj = weaponobj withoutattachment( attachment );
            var_1573a9bd3c71b0e0 = loot::getlootidfromref( attachment );
            break;
        }
    }
    
    if ( isdefined( newweaponobj ) && var_1573a9bd3c71b0e0 != 0 )
    {
        player takeweapon( weaponobj );
        player giveweapon( newweaponobj );
        return var_1573a9bd3c71b0e0;
    }
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0x70961e23, Offset: 0x7ddc
// Size: 0x3e2
function private function_8b0d7a7d235a9087( player )
{
    if ( !level.var_bb86f77304f193c4.var_fe1b7d243babdaa1 )
    {
        return;
    }
    
    player.var_773876ee6a382571 = spawnstruct();
    player.var_773876ee6a382571.var_c3603c2ad5648942 = [];
    player.var_773876ee6a382571.var_69b66cab507e0f60 = [];
    player.var_773876ee6a382571.var_7efb5ad4ce85c699 = [];
    player.var_773876ee6a382571.var_42c50c2d25669586 = [];
    primaryweaponobj = player item_weapon::function_e7484276ad85f220( #"primary_0" );
    
    if ( isdefined( primaryweaponobj ) )
    {
        player.var_773876ee6a382571.var_69b66cab507e0f60[ #"primary_0" ] = player pack_a_punch::get_pap_level( primaryweaponobj );
        player.var_773876ee6a382571.var_c3603c2ad5648942[ #"primary_0" ] = player item_weapon::function_fb81bd2fe070faa6( primaryweaponobj );
        ammomod = player ammo_mod::get_ammo_mod_name( primaryweaponobj );
        id = ammo_mod::function_a0eaff256065cb6d( ammomod );
        player.var_773876ee6a382571.var_7efb5ad4ce85c699[ #"primary_0" ] = id;
        player pack_a_punch::unpap_weapon( primaryweaponobj );
        var_82df53b2e0caa4a2 = function_1e74b31eae3c6994( player, primaryweaponobj );
        player.var_773876ee6a382571.var_42c50c2d25669586[ #"primary_0" ] = var_82df53b2e0caa4a2;
    }
    
    secondaryweaponobj = player item_weapon::function_e7484276ad85f220( #"primary_1" );
    
    if ( isdefined( secondaryweaponobj ) )
    {
        player.var_773876ee6a382571.var_69b66cab507e0f60[ #"primary_1" ] = player pack_a_punch::get_pap_level( secondaryweaponobj );
        player.var_773876ee6a382571.var_c3603c2ad5648942[ #"primary_1" ] = player item_weapon::function_fb81bd2fe070faa6( secondaryweaponobj );
        ammomod = player ammo_mod::get_ammo_mod_name( secondaryweaponobj );
        id = ammo_mod::function_a0eaff256065cb6d( ammomod );
        player.var_773876ee6a382571.var_7efb5ad4ce85c699[ #"primary_1" ] = id;
        player pack_a_punch::unpap_weapon( secondaryweaponobj );
        var_82df53b2e0caa4a2 = function_1e74b31eae3c6994( player, secondaryweaponobj );
        player.var_773876ee6a382571.var_42c50c2d25669586[ #"primary_1" ] = var_82df53b2e0caa4a2;
    }
    
    var_cc1262e66dbb1c79 = player item_weapon::function_e7484276ad85f220( #"tertiary_0" );
    
    if ( isdefined( var_cc1262e66dbb1c79 ) )
    {
        player.var_773876ee6a382571.var_69b66cab507e0f60[ #"tertiary_0" ] = player pack_a_punch::get_pap_level( var_cc1262e66dbb1c79 );
        player.var_773876ee6a382571.var_c3603c2ad5648942[ #"tertiary_0" ] = player item_weapon::function_fb81bd2fe070faa6( var_cc1262e66dbb1c79 );
        ammomod = player ammo_mod::get_ammo_mod_name( var_cc1262e66dbb1c79 );
        id = ammo_mod::function_a0eaff256065cb6d( ammomod );
        player.var_773876ee6a382571.var_7efb5ad4ce85c699[ #"tertiary_0" ] = id;
        player pack_a_punch::unpap_weapon( var_cc1262e66dbb1c79 );
        var_82df53b2e0caa4a2 = function_1e74b31eae3c6994( player, var_cc1262e66dbb1c79 );
        player.var_773876ee6a382571.var_42c50c2d25669586[ #"tertiary_0" ] = var_82df53b2e0caa4a2;
    }
    
    var_3291c491d20456c1 = namespace_3a2a361a08f89b78::function_391b310b880fab80( player );
    
    if ( !var_3291c491d20456c1 )
    {
        backpackindex = 0;
        
        while ( backpackindex < common_inventory::function_9cd65c8312048802() )
        {
            lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
            
            if ( !isdefined( lootid ) || lootid == 0 )
            {
            }
            else
            {
                itembundle = common_item::function_b202b16941992cca( lootid );
                
                if ( !isdefined( itembundle ) )
                {
                }
                else if ( common_item::function_16e8c106491eeaca( itembundle ) == "schematic" )
                {
                    common_inventory::inventory_setbackpackitematindex( backpackindex, 0, 0 );
                }
            }
            
            backpackindex += 1;
        }
    }
}

// Namespace ob_persist
// Params 0, eflags: 0x4
// Checksum 0xc7d84bba, Offset: 0x81c6
// Size: 0x2e, Type: bool
function private function_e0b2daa44b658ebf()
{
    if ( getdvarint( @"hash_9a1a15edbe15ed6c", 0 ) )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"hash_f1d9adca8cbf293c", 0 ) )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace ob_persist
// Params 2, eflags: 0x4
// Checksum 0x973535e3, Offset: 0x81fd
// Size: 0x234
function private function_2f759b1669f91bef( weaponslot, slotref )
{
    metadata = spawnstruct();
    metadata.keys = [];
    metadata.values = [];
    
    for ( key = 3; key <= 7 ; key++ )
    {
        metadata.keys[ metadata.keys.size ] = key;
        metadata.values[ metadata.values.size ] = 0;
    }
    
    weapon = item_weapon::function_e7484276ad85f220( weaponslot );
    
    if ( isdefined( weapon ) )
    {
        if ( isdefined( self.var_773876ee6a382571.var_69b66cab507e0f60[ weaponslot ] ) )
        {
            metadata.values[ 0 ] = self.var_773876ee6a382571.var_69b66cab507e0f60[ weaponslot ];
        }
        
        if ( isdefined( self.var_773876ee6a382571.var_c3603c2ad5648942[ weaponslot ] ) )
        {
            metadata.values[ 1 ] = self.var_773876ee6a382571.var_c3603c2ad5648942[ weaponslot ];
        }
        
        if ( isdefined( self.var_773876ee6a382571.var_7efb5ad4ce85c699[ weaponslot ] ) )
        {
            metadata.values[ 2 ] = self.var_773876ee6a382571.var_7efb5ad4ce85c699[ weaponslot ];
        }
        
        if ( isdefined( weapon.baseweaponlootid ) && weapon.baseweaponlootid != 0 )
        {
            metadata.values[ 3 ] = weapon.baseweaponlootid;
        }
        
        if ( isdefined( self.var_773876ee6a382571.var_42c50c2d25669586[ weaponslot ] ) && self.var_773876ee6a382571.var_42c50c2d25669586[ weaponslot ] != 0 )
        {
            metadata.values[ 4 ] = self.var_773876ee6a382571.var_42c50c2d25669586[ weaponslot ];
        }
    }
    
    weaponinstance = common_instance_inventory::function_4c1e57c205fb4b91( self, slotref );
    
    if ( common_instance_inventory::function_ae3907698ee6e6f1( weaponinstance ) )
    {
        common_instance_inventory::function_a568f4d2f7413a60( metadata.keys, metadata.values, weaponinstance );
    }
}

// Namespace ob_persist
// Params 0, eflags: 0x4
// Checksum 0x2d4fc8e3, Offset: 0x8439
// Size: 0x357
function private function_1f308eed6ec0b()
{
    if ( !self.var_c72cb0043263a756 )
    {
        return;
    }
    
    if ( level.var_bb86f77304f193c4.var_4d75a5ef844d8a95 )
    {
        function_e2fa12d2daa604fe( #"primary_0", #"primaryweapon" );
        function_e2fa12d2daa604fe( #"primary_1", #"secondaryweapon" );
        function_e2fa12d2daa604fe( #"tertiary_0", #"tertiaryweapon" );
    }
    
    if ( utility::callsharedfunc( #"instanceInventory", #"ismaptomapinfil" ) )
    {
        scratchinstance = common_instance_inventory::function_4c1e57c205fb4b91( self, #"scratchprimary" );
        function_553f9a9c369f9611( scratchinstance );
        var_4df64016b6febbd7 = common_instance_inventory::function_4c1e57c205fb4b91( self, #"scratchsecondary" );
        function_468841abeb37fe14( var_4df64016b6febbd7 );
        
        if ( common_instance_inventory::function_28e60cf07393549d( #"Wallet" ) )
        {
            var_667bc8a361e00e52 = common_instance_inventory::function_4c1e57c205fb4b91( self, #"Wallet" );
            
            if ( common_instance_inventory::function_ae3907698ee6e6f1( var_667bc8a361e00e52 ) )
            {
                if ( isdefined( var_667bc8a361e00e52.quantity ) )
                {
                    currency = int( var_667bc8a361e00e52.quantity );
                    assert( currency >= 0 );
                    currency::add_currency_amount( #"essence", currency );
                }
            }
        }
        
        if ( utility::issharedfuncdefined( #"player", #"hash_45a211ad5df3fd3" ) )
        {
            superinfo = self [[ utility::getsharedfunc( #"player", #"hash_45a211ad5df3fd3" ) ]]();
        }
        
        if ( isdefined( superinfo ) && level.allowsupers )
        {
            if ( utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) && utility::issharedfuncdefined( #"supers", #"hash_79c2eee2c78b598" ) )
            {
                self [[ utility::getsharedfunc( #"supers", #"hash_79c2eee2c78b598" ) ]]( self [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]() );
            }
        }
        
        platecount = armor::function_22290101992e4874();
        platemax = armor::function_db9ebf086f67fe92();
        var_1fd4f9927be13502 = platemax - platecount;
        armor::function_164c824617d7e8d7( var_1fd4f9927be13502 );
        var_b646f233b0231b5e = common_item::function_c4c43ebb7aa636dc( "lethal" );
        
        if ( isdefined( var_b646f233b0231b5e ) )
        {
            var_bf21ecb0cd792378 = getscriptbundlefieldvalue( var_b646f233b0231b5e.name, #"ref" );
            
            if ( isdefined( var_bf21ecb0cd792378 ) )
            {
                var_7cbc22bb9e612dea = equipment_mp::getequipmentmaxammo( var_bf21ecb0cd792378 );
                
                if ( var_b646f233b0231b5e.count < var_7cbc22bb9e612dea )
                {
                    equipment_mp::setequipmentammo( var_bf21ecb0cd792378, var_7cbc22bb9e612dea );
                }
            }
        }
        
        var_da1af88dca1a8afd = common_item::function_c4c43ebb7aa636dc( "lethal" );
        
        if ( isdefined( var_da1af88dca1a8afd ) )
        {
            var_220cce57fb037979 = getscriptbundlefieldvalue( var_da1af88dca1a8afd.name, #"ref" );
            
            if ( isdefined( var_220cce57fb037979 ) )
            {
                var_7cbc22bb9e612dea = equipment_mp::getequipmentmaxammo( var_220cce57fb037979 );
                
                if ( var_da1af88dca1a8afd.count < var_7cbc22bb9e612dea )
                {
                    equipment_mp::setequipmentammo( var_220cce57fb037979, var_7cbc22bb9e612dea );
                }
            }
        }
    }
    
    function_18578c8762db6786( 1 );
    
    if ( common_instance_inventory::function_28e60cf07393549d( #"Wallet" ) )
    {
        common_instance_inventory::function_295a263162af11ac( #"Wallet" );
    }
    
    self.var_b7d546af89f1f5c0 = 1;
}

// Namespace ob_persist
// Params 1, eflags: 0x4
// Checksum 0xc48f97be, Offset: 0x8798
// Size: 0x3e
function private function_18578c8762db6786( wipeprimary )
{
    assert( isplayer( self ) );
    
    if ( wipeprimary )
    {
        common_instance_inventory::function_295a263162af11ac( #"scratchprimary" );
    }
    
    common_instance_inventory::function_295a263162af11ac( #"scratchsecondary" );
}

// Namespace ob_persist
// Params 2
// Checksum 0x49d3805a, Offset: 0x87de
// Size: 0xc6
function finalize_player( player, behavior )
{
    if ( behavior == 0 )
    {
        player common_instance_inventory::function_b1b5b47fe399f1e7( 0 );
        player common_instance_inventory::function_8fd84f733b81e456();
        return;
    }
    
    if ( behavior == 1 )
    {
        player.inventoryfinalized = 1;
        return;
    }
    
    if ( behavior == 2 )
    {
        if ( !isalive( player ) && player class::respawnitems_hasrespawnitems() )
        {
            player class::loadout_updateplayer( player.globalstruct, player.classstruct, player.curclass );
            player function_2d0c5223b3e61e8( {} );
        }
        
        player common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
        player common_instance_inventory::function_8fd84f733b81e456();
        return;
    }
    
    if ( behavior == 3 )
    {
        player common_instance_inventory::function_b1b5b47fe399f1e7( 0 );
    }
}

// Namespace ob_persist
// Params 0, eflags: 0x4
// Checksum 0xfcab7e04, Offset: 0x88ac
// Size: 0x4f4
function private function_ac35b3e1f0375ddd()
{
    level.var_a2e5cf132f0e1f1 = [];
    level.var_a2e5cf132f0e1f1[ 131439 ] = 136224;
    level.var_a2e5cf132f0e1f1[ 131420 ] = 136224;
    level.var_a2e5cf132f0e1f1[ 131440 ] = 136224;
    level.var_a2e5cf132f0e1f1[ 134496 ] = 136224;
    level.var_a2e5cf132f0e1f1[ 104797 ] = 136224;
    level.var_a2e5cf132f0e1f1[ 131417 ] = 134502;
    level.var_a2e5cf132f0e1f1[ 131425 ] = 134502;
    level.var_a2e5cf132f0e1f1[ 107323 ] = 136217;
    level.var_a2e5cf132f0e1f1[ 99706 ] = 136217;
    level.var_a2e5cf132f0e1f1[ 131399 ] = 136217;
    level.var_a2e5cf132f0e1f1[ 107335 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 131415 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 131378 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 131414 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 131418 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 102962 ] = 134492;
    level.var_a2e5cf132f0e1f1[ 131448 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 131374 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 134504 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 102961 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 131449 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 107334 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 131380 ] = 136227;
    level.var_a2e5cf132f0e1f1[ 131403 ] = 136220;
    level.var_a2e5cf132f0e1f1[ 104790 ] = 136220;
    level.var_a2e5cf132f0e1f1[ 129695 ] = 136218;
    level.var_a2e5cf132f0e1f1[ 131379 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131402 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131405 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131411 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 110122 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131446 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131394 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 131401 ] = 134494;
    level.var_a2e5cf132f0e1f1[ 110121 ] = 136215;
    level.var_a2e5cf132f0e1f1[ 131433 ] = 136215;
    level.var_a2e5cf132f0e1f1[ 132934 ] = 13622;
    level.var_a2e5cf132f0e1f1[ 132928 ] = 13622;
    level.var_a2e5cf132f0e1f1[ 130825 ] = 136222;
    level.var_a2e5cf132f0e1f1[ 131428 ] = 136226;
    level.var_a2e5cf132f0e1f1[ 131456 ] = 136226;
    level.var_a2e5cf132f0e1f1[ 131467 ] = 136226;
    level.var_a2e5cf132f0e1f1[ 102959 ] = 136226;
    level.var_a2e5cf132f0e1f1[ 131377 ] = 136226;
    level.var_a2e5cf132f0e1f1[ 131426 ] = 136223;
    level.var_a2e5cf132f0e1f1[ 131406 ] = 136221;
    level.var_a2e5cf132f0e1f1[ 129397 ] = 136221;
    level.var_a2e5cf132f0e1f1[ 131432 ] = 136216;
    level.var_a2e5cf132f0e1f1[ 129400 ] = 136216;
    level.var_a2e5cf132f0e1f1[ 107332 ] = 136216;
    level.var_a2e5cf132f0e1f1[ 131389 ] = 136214;
    level.var_a2e5cf132f0e1f1[ 129395 ] = 136214;
    level.var_a2e5cf132f0e1f1[ 130816 ] = 136228;
    level.var_a2e5cf132f0e1f1[ 132937 ] = 136219;
    level.var_a2e5cf132f0e1f1[ 132936 ] = 136219;
    level.var_a2e5cf132f0e1f1[ 131382 ] = 134501;
    level.var_a2e5cf132f0e1f1[ 131429 ] = 134501;
    level.var_a2e5cf132f0e1f1[ 131408 ] = 134501;
    level.var_a2e5cf132f0e1f1[ 107665 ] = 134501;
    level.var_a2e5cf132f0e1f1[ 131732 ] = 140509;
}

