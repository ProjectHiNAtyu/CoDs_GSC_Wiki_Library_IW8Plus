// script_3a5f079804604bc4  (hash_3a5f079804604bc4.gscc) (size: 3665 Bytes / 0xe51 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e61aef8 (1583460088)
// size ...... 3665 (0xe51)
// includes .. 8   (offset: 0xd95)
// strings ... 9   (offset: 0xdd5)
// dev strs .. 0   (offset: 0xe51)
// exports ... 8   (offset: 0x9a5)
// cseg ...... 0xff + 0x8a6 (0x9a5)
// imports ... 24  (offset: 0xae5)
// animtree1 . 0   (offset: 0xe51)
// animtree2 . 0   (offset: 0xe51)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\pickups_scriptable;

#namespace br_teamrevive;

// Namespace br_teamrevive
// Params 17
// Checksum 0xe8cb7ef7, Offset: 0x11d
// Size: 0x34e
function function_68530aaf19ab95f3( player, contents, containertype, deadplayerindex, weaponslotcontents, weaponslotobj, weaponslotclip, var_655fababc6344d9f, var_d80f548b9b26d1fb, hasweaponcase, loadoutcontents, var_38135a805694e23b, var_9185433e2ad9ec33, var_ba26f716717f0caf, var_280e5815dca53303, var_d770d062d2277817, var_ee5ceae7ad99228 )
{
    corpse = spawnscriptable( "cyber_revive_pillage", player.origin + ( 0, 0, 30 ) );
    corpse utility::scriptable_setparententity( player, ( 0, 0, 30 ) );
    pickups::registerscriptableinstance( corpse );
    corpse.contents = contents;
    corpse.containertype = containertype;
    corpse.deadplayerindex = deadplayerindex;
    corpse.owner = player;
    corpse.weaponslotcontents = weaponslotcontents;
    corpse.weaponslotobj = weaponslotobj;
    corpse.weaponslotclip = weaponslotclip;
    corpse.var_d80f548b9b26d1fb = var_d80f548b9b26d1fb;
    corpse.metadata = var_ba26f716717f0caf;
    corpse.var_655fababc6344d9f = var_655fababc6344d9f;
    corpse.var_ee5ceae7ad99228 = var_ee5ceae7ad99228;
    corpse.backpacksize = player common_inventory::function_9cd65c8312048802();
    corpse.loadoutcontents = loadoutcontents;
    
    if ( isdefined( var_38135a805694e23b ) && isdefined( var_9185433e2ad9ec33 ) )
    {
        corpse.var_64df982caf48609c = var_38135a805694e23b;
        corpse.var_9185433e2ad9ec33 = var_9185433e2ad9ec33;
        corpse.loadoutmetadata = var_280e5815dca53303;
        corpse.var_d770d062d2277817 = var_d770d062d2277817;
    }
    
    if ( level.var_a629e0989043efd8 )
    {
        corpse.criticalitem = 1;
    }
    
    foreach ( item in corpse.contents )
    {
        utility::callsharedfunc( item[ "lootID" ], #"hash_9f56ee5ad640666b", corpse, player );
    }
    
    foreach ( teammember in teams::getteamdata( player.team, "players" ) )
    {
        corpse disablescriptableplayeruse( teammember );
    }
    
    player.var_a883ec236391a6bf = corpse;
    player.var_a883ec236391a6bf.hidefromteam = 1;
    level thread function_c54bb62e5b6ed9c2( player, player.attached_bag, corpse );
}

// Namespace br_teamrevive
// Params 3, eflags: 0x4
// Checksum 0x572f8036, Offset: 0x473
// Size: 0x1f7
function private function_c54bb62e5b6ed9c2( deadplayer, model, corpse )
{
    deadplayer endon( #"spawned" );
    corpse endon( #"death" );
    
    if ( level.teamrevivetimeout > 0 )
    {
        deadplayer utility::waittill_any( "disconnect", "trigger_removed" );
        
        if ( isdefined( deadplayer ) && !deadplayer.isdisconnecting && deadplayer.timelefttospawnaction > 0 )
        {
            return;
        }
    }
    else
    {
        deadplayer waittill( #"disconnect" );
    }
    
    if ( !isdefined( corpse ) )
    {
        return;
    }
    
    neworigin = utility::drop_to_ground( corpse.origin ) + ( 0, 0, 2 );
    scriptablename = common_inventory::function_c54ad5b34ff0a17a( model ?? "parts_backpack_inventory_small" );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( neworigin, corpse.angles );
    spawnedbackpack = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, 1, spawnoptions );
    function_a718c52149646435( corpse, spawnedbackpack );
    
    if ( isdefined( corpse.opener ) )
    {
        spawnedbackpack setscriptablepartstate( "body", "partially_opening_unusable" );
        
        if ( isdefined( corpse.opener.var_75f60e367c30d7ac ) && isdefined( corpse.opener.origin ) )
        {
            corpse.opener.var_75f60e367c30d7ac = corpse.opener.origin;
        }
        
        loot_mp::openlootablecontainer( corpse.opener, spawnedbackpack );
    }
    else
    {
        spawnedbackpack setscriptablepartstate( "body", "closed_usable" );
    }
    
    pickups::loothide( corpse, "body" );
    
    if ( function_9258a83f711ba45c( deadplayer ) )
    {
        [[ utility::getsharedfunc( #"pleaforhelp", #"hash_b4143a46270d3ce5" ) ]]( deadplayer );
    }
}

// Namespace br_teamrevive
// Params 1, eflags: 0x4
// Checksum 0xaac1886c, Offset: 0x672
// Size: 0x3b, Type: bool
function private function_9258a83f711ba45c( player )
{
    return br_gametypes::isfeatureenabled( #"pleaforhelp" ) && [[ utility::getsharedfunc( #"pleaforhelp", #"hash_6bdb63dc7be5ea5f" ) ]]( player );
}

// Namespace br_teamrevive
// Params 2, eflags: 0x4
// Checksum 0x7deb12fc, Offset: 0x6b6
// Size: 0x25f
function private function_a718c52149646435( corpse, backpack )
{
    backpack.contents = corpse.contents;
    backpack.containertype = corpse.containertype;
    backpack.deadplayerindex = corpse.deadplayerindex;
    backpack.owner = corpse.player;
    backpack.weaponslotcontents = corpse.weaponslotcontents;
    backpack.weaponslotobj = corpse.weaponslotobj;
    backpack.weaponslotclip = corpse.weaponslotclip;
    backpack.var_cfb3dd2c26cb2d78 = corpse.var_cfb3dd2c26cb2d78;
    backpack.var_d80f548b9b26d1fb = corpse.var_d80f548b9b26d1fb;
    backpack.metadata = corpse.var_ba26f716717f0caf;
    backpack.var_655fababc6344d9f = corpse.var_655fababc6344d9f;
    backpack.backpacksize = corpse.backpacksize;
    backpack.loadoutcontents = corpse.loadoutcontents;
    
    if ( isdefined( corpse.var_64df982caf48609c ) && isdefined( corpse.var_9185433e2ad9ec33 ) )
    {
        backpack.var_64df982caf48609c = corpse.var_64df982caf48609c;
        backpack.var_9185433e2ad9ec33 = corpse.var_9185433e2ad9ec33;
        backpack.loadoutmetadata = corpse.loadoutmetadata;
        backpack.var_d770d062d2277817 = corpse.var_d770d062d2277817;
    }
    
    if ( level.var_a629e0989043efd8 )
    {
        backpack.criticalitem = 1;
    }
    
    foreach ( item in backpack.contents )
    {
        utility::callsharedfunc( item[ "lootID" ], #"hash_9f56ee5ad640666b", backpack );
    }
}

// Namespace br_teamrevive
// Params 1
// Checksum 0xd8ab839a, Offset: 0x91d
// Size: 0x24, Type: bool
function function_a6b67e78e636b7d4( corpse )
{
    return isdefined( corpse ) && corpse.type == "cyber_revive_pillage";
}

// Namespace br_teamrevive
// Params 1
// Checksum 0x261c03a0, Offset: 0x94a
// Size: 0x14
function function_b62c1443b3c06bd6( params )
{
    br_utility::unmarkplayeraseliminated( self );
}

// Namespace br_teamrevive
// Params 0
// Checksum 0x29470d83, Offset: 0x966
// Size: 0x3e, Type: bool
function function_22a3e3e6a751194b()
{
    var_c213b9b1e9133646 = isdefined( level.pleaforhelp ) && !level.pleaforhelp.var_9be8313ce4a418cc;
    return !( var_c213b9b1e9133646 && function_9258a83f711ba45c( self ) );
}

