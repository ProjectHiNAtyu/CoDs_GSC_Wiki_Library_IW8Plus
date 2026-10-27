// scripts\mp\gametypes\frune_collectible.gsc  (hash_5a50f29bc1372ef3.gscc) (size: 1673 Bytes / 0x689 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a825d4d (2055363917)
// size ...... 1673 (0x689)
// includes .. 1   (offset: 0x611)
// strings ... 5   (offset: 0x619)
// dev strs .. 3   (offset: 0x665)
// exports ... 6   (offset: 0x3e9)
// cseg ...... 0xa4 + 0x345 (0x3e9)
// imports ... 11  (offset: 0x4d9)
// animtree1 . 0   (offset: 0x689)
// animtree2 . 0   (offset: 0x689)
#using scripts\mp\gametypes\obj_killdrop;

#namespace frune_collectible;

// Namespace frune_collectible
// Params 0
// Checksum 0x53b6a5b4, Offset: 0xc2
// Size: 0x60
function init()
{
    if ( !game[ #"frune_tuning" ].var_7deb2b87c100328c )
    {
        return;
    }
    
    killdropinfo = killdrop::function_cf89378d072ff892( %"hash_2c3395a7186d715" );
    killdropinfo.var_d1e5ba2547561fb5 = &function_d1e5ba2547561fb5;
    game[ #"frune_tuning" ].killdropinfo = killdropinfo;
}

// Namespace frune_collectible
// Params 0
// Checksum 0x90ac6c78, Offset: 0x12a
// Size: 0x16d
function function_cbc2bc1bb506cbcd()
{
    modeinfo = game[ #"frune_tuning" ];
    var_f20290286bc433ac = 39;
    var_1b4795c9fa57ec8d = int( self getplayerdata( "mp", "collectedCoinsBitmask" ) );
    
    for ( zoneindex = 1; zoneindex <= 9 ; zoneindex++ )
    {
        var_f82305073049db68 = 1;
        
        while ( true )
        {
            spawnname = "fr2_coin_spawn_" + zoneindex + "_" + var_f82305073049db68;
            spawndata = level.struct_class_names[ "script_noteworthy" ][ spawnname ];
            
            if ( !spawndata )
            {
                break;
            }
            
            coinbit = 1 << var_f20290286bc433ac;
            hascollected = ( var_1b4795c9fa57ec8d & coinbit ) != 0;
            
            if ( !hascollected )
            {
                coindrop = killdrop::function_f2801b21f06fa312( self, 0, spawndata[ 0 ].origin, 1, modeinfo.killdropinfo );
                coindrop.var_f485e9dd096f9100 = var_f20290286bc433ac;
                coindrop.visual.angles = spawndata[ 0 ].angles ?? ( 0, 0, 0 );
            }
            
            var_f20290286bc433ac++;
            var_f82305073049db68++;
            
            if ( var_f20290286bc433ac >= 64 )
            {
                return;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_ce50b9128d9ce5ec", 0 ) )
        {
            level thread function_dc2c8e21c67985c2();
        }
    #/
}

// Namespace frune_collectible
// Params 1, eflags: 0x4
// Checksum 0x38f8a9d8, Offset: 0x29f
// Size: 0x4c
function private function_d1e5ba2547561fb5( dropent )
{
    var_1b4795c9fa57ec8d = self getplayerdata( "mp", "collectedCoinsBitmask" );
    var_1b4795c9fa57ec8d = function_e74edf669e1ddceb( var_1b4795c9fa57ec8d, dropent.var_f485e9dd096f9100 );
    self setplayerdata( "mp", "collectedCoinsBitmask", var_1b4795c9fa57ec8d );
}

/#

    // Namespace frune_collectible
    // Params 0, eflags: 0xc
    // Checksum 0x92b11feb, Offset: 0x2f3
    // Size: 0xb1, Type: dev
    function private function_dc2c8e21c67985c2()
    {
        self notify( #"hash_d382bae7f3223002" );
        self endon( #"hash_d382bae7f3223002" );
        level endon( #"game_ended" );
        
        for ( zoneindex = 1; zoneindex <= 9 ; zoneindex++ )
        {
            for ( var_f82305073049db68 = 1; true ; var_f82305073049db68++ )
            {
                spawnname = "<dev string:x24>" + zoneindex + "<dev string:x34>" + var_f82305073049db68;
                spawndata = level.struct_class_names[ "<dev string:x36>" ][ spawnname ];
                
                if ( !spawndata )
                {
                    break;
                }
                
                level thread function_ea7ea923238f2bd7( spawndata[ 0 ].origin );
            }
        }
    }

    // Namespace frune_collectible
    // Params 1, eflags: 0x4
    // Checksum 0x465cae5c, Offset: 0x3ac
    // Size: 0x3d, Type: dev
    function private function_ea7ea923238f2bd7( origin )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            sphere( origin, 16, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
