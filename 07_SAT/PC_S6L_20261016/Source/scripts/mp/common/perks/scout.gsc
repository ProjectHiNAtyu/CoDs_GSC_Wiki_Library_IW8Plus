// scripts\mp\common\perks\scout.gsc  (hash_69016d83314df06c.gscc) (size: 1769 Bytes / 0x6e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x151f0638 (354354744)
// size ...... 1769 (0x6e9)
// includes .. 3   (offset: 0x66d)
// strings ... 7   (offset: 0x685)
// dev strs .. 0   (offset: 0x6e9)
// exports ... 5   (offset: 0x465)
// cseg ...... 0xbf + 0x3a6 (0x465)
// imports ... 11  (offset: 0x52d)
// animtree1 . 0   (offset: 0x6e9)
// animtree2 . 0   (offset: 0x6e9)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace scout;

// Namespace scout
// Params 0, eflags: 0x1
// Checksum 0x7dc33983, Offset: 0xdd
// Size: 0x2f
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_85564e6cae7d634b );
    level.var_956b47ce4fb68cc0 = getdvarint( @"hash_3ca77329c50732d7", 0 );
}

// Namespace scout
// Params 1
// Checksum 0x867f3764, Offset: 0x114
// Size: 0x7a
function function_85564e6cae7d634b( params )
{
    bundle = level.perkbundles[ "specialty_scout" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_scout" );
    }
    
    if ( isdefined( params.var_5109b530c69d18a1 ) )
    {
        level [[ params.var_5109b530c69d18a1 ]]( "specialty_scout", &scoutonkillbuff );
    }
}

// Namespace scout
// Params 1
// Checksum 0x6945fc28, Offset: 0x196
// Size: 0x1f4
function scoutonkillbuff( params )
{
    smeansofdeath = params.smeansofdeath ?? "";
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        return;
    }
    
    if ( self.var_4a067337b84d8676 )
    {
        self.var_dfb4efc4c9e3d3ec = 1;
    }
    else
    {
        self.var_4a067337b84d8676 = 1;
        
        if ( level.var_956b47ce4fb68cc0 )
        {
            player::function_e4f77222086e66b( 1 );
        }
        else
        {
            self.forceghost[ #"scout_perk" ] = 1;
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perk" ][ #"giveperk" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( "specialty_ghost" );
            }
            
            player::function_99816a37e4f0c00a( 1, #"hash_9b93b77fabea1ba1" );
        }
        
        self function_e5ab5088cc09b666( 1 );
    }
    
    bundle = level.perkbundles[ "specialty_scout" ];
    buffduration = bundle.var_e472c78f440d7681 ?? 5;
    self.var_da591267109e7023 = gettime() + buffduration * 1000;
    thread function_9b50188e8f3ce2b5( buffduration );
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        foreach ( perkbuff in bundle.var_ee1c92198ad66b2f )
        {
            self [[ var_2c124e2ccc1e8842 ]]( bundle, perkbuff.var_fbd59bd982c1fe7c );
        }
    }
}

// Namespace scout
// Params 1, eflags: 0xc
// Checksum 0x5a44ae1d, Offset: 0x392
// Size: 0xd3
function private function_9b50188e8f3ce2b5( buffduration )
{
    self notify( #"hash_c6f2d68629c4067c" );
    self endon( #"hash_c6f2d68629c4067c" );
    
    if ( buffduration )
    {
        self endon( #"disconnect" );
        utility::waittill_any_timeout( buffduration, "death" );
    }
    
    self.var_4a067337b84d8676 = undefined;
    self.var_dfb4efc4c9e3d3ec = undefined;
    
    if ( level.var_956b47ce4fb68cc0 )
    {
        player::function_e4f77222086e66b( 0 );
    }
    else
    {
        self.forceghost[ #"scout_perk" ] = undefined;
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perk" ][ #"removeperk" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( "specialty_ghost" );
        }
        
        player::function_99816a37e4f0c00a( 0, #"hash_9b93b77fabea1ba1" );
    }
    
    self function_e5ab5088cc09b666( 0 );
}

