// scripts\mp\loot\common_collectible.gsc  (hash_1031dc1b93e12c43.gscc) (size: 2402 Bytes / 0x962 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe93d300f (3913101327)
// size ...... 2402 (0x962)
// includes .. 4   (offset: 0x8fe)
// strings ... 5   (offset: 0x91e)
// dev strs .. 0   (offset: 0x962)
// exports ... 5   (offset: 0x66a)
// cseg ...... 0x99 + 0x5d1 (0x66a)
// imports ... 16  (offset: 0x732)
// animtree1 . 0   (offset: 0x962)
// animtree2 . 0   (offset: 0x962)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace common_collectible;

// Namespace common_collectible
// Params 0, eflags: 0x5
// Checksum 0x6379b762, Offset: 0xb7
// Size: 0x2a2
function private autoexec init()
{
    if ( !isenabled() || !level.gamemodebundle.collectibleitems )
    {
        return;
    }
    
    collectiblenodes = utility::getstructarray( "dmz_collectable", "targetname" );
    
    if ( !collectiblenodes || !collectiblenodes.size )
    {
        return;
    }
    
    utility::flag_wait( "items_database_init" );
    defaultcollectible = undefined;
    var_4d60369c227dcd1e = [];
    
    foreach ( var_1abb3089b5d16517 in level.gamemodebundle.collectibleitems )
    {
        itembundle = getscriptbundle( var_1abb3089b5d16517.itembundle );
        
        if ( !itembundle.collectiblescriptnoteworthy || itembundle.collectiblescriptnoteworthy == "" )
        {
            defaultcollectible = itembundle;
            continue;
        }
        
        var_4d60369c227dcd1e[ itembundle.collectiblescriptnoteworthy ] = itembundle;
    }
    
    level.collectibleitems = [];
    
    foreach ( node in collectiblenodes )
    {
        var_d5bee7fc56d756a2 = defaultcollectible;
        
        if ( node.script_noteworthy && node.script_noteworthy != "" )
        {
            scriptnoteworthyid = strtok( node.script_noteworthy, "_" );
            ref = scriptnoteworthyid[ 0 ];
            var_d5bee7fc56d756a2 = var_4d60369c227dcd1e[ ref ] ?? defaultcollectible;
        }
        
        spawnoptions = common_item::function_bc5ff2958b71a708( node.origin, node.angles );
        item = common_item::function_61c2c0251e742ffd( var_d5bee7fc56d756a2, 1, spawnoptions );
        item.critical = 1;
        item.collectibleid = int( scriptnoteworthyid[ 1 ] ) - 1;
        level.collectibleitems[ item.collectibleid ] = item;
    }
    
    callback::add( #"player_connect", &onplayerconnect );
}

// Namespace common_collectible
// Params 0
// Checksum 0x28a8cd50, Offset: 0x361
// Size: 0x36
function isenabled()
{
    isenabled = level.gamemodebundle.var_53c6c5ff22849ac2 && getdvarint( @"hash_20a83f8c0e8a3eca", 1 );
    return isenabled;
}

// Namespace common_collectible
// Params 2
// Checksum 0x2633b56f, Offset: 0x3a0
// Size: 0x1ca, Type: bool
function obtaincollectible( itembundle, item )
{
    /#
        if ( getdvarint( @"hash_e5c06f61c163000a", 0 ) && !isdefined( item.collectibleid ) )
        {
            item.collectibleid = 0;
        }
    #/
    
    if ( !isdefined( item.collectibleid ) || item.collectibleid >= 32 || item.collectibleid < 0 )
    {
        return false;
    }
    
    if ( !isdefined( self.collectibles ) )
    {
        self.collectibles = [];
    }
    
    if ( !isdefined( self.collectibles[ itembundle.ref ] ) )
    {
        self.collectibles[ itembundle.ref ] = 0;
    }
    
    self.collectibles[ itembundle.ref ] |= 1 << item.collectibleid;
    
    if ( level.gamemodebundle.var_443649868588d3bc && level.gamemodebundle.var_443649868588d3bc != "" )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, level.gamemodebundle.var_443649868588d3bc, self.collectibles[ itembundle.ref ] );
    }
    
    scriptable::function_982b533206bc78a5( item, self );
    
    if ( !isdefined( self.var_25c19e1c8214cc90 ) )
    {
        self.var_25c19e1c8214cc90 = 0;
    }
    
    self.var_25c19e1c8214cc90++;
    
    if ( !isdefined( self.var_1297579f40122829 ) )
    {
        self.var_1297579f40122829 = 0;
    }
    
    self.var_1297579f40122829 += itembundle.collectiblexp ?? 100;
    return true;
}

// Namespace common_collectible
// Params 1, eflags: 0x4
// Checksum 0x1c464549, Offset: 0x573
// Size: 0xf7
function private onplayerconnect( params )
{
    if ( !level.gamemodebundle.var_443649868588d3bc || !level.collectibleitems || !level.collectibleitems.size )
    {
        return;
    }
    
    currentvalue = self getplayerdata( level.var_6f9b00680ed002d8, level.gamemodebundle.var_443649868588d3bc );
    
    foreach ( scriptable in level.collectibleitems )
    {
        if ( currentvalue & scriptable.collectibleid )
        {
            scriptable::function_982b533206bc78a5( scriptable, self );
        }
    }
}

