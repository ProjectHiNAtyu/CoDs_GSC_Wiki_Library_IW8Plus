// scripts\mp\gametypes\frun_collectible.gsc  (hash_28ac88a4fe1fac7c.gscc) (size: 1174 Bytes / 0x496 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9fdcc7a5 (2682046373)
// size ...... 1174 (0x496)
// includes .. 2   (offset: 0x43a)
// strings ... 5   (offset: 0x44a)
// dev strs .. 0   (offset: 0x496)
// exports ... 4   (offset: 0x2b2)
// cseg ...... 0xa0 + 0x212 (0x2b2)
// imports ... 8   (offset: 0x352)
// animtree1 . 0   (offset: 0x496)
// animtree2 . 0   (offset: 0x496)
#using scripts\mp\gametypes\frun_free_run;
#using scripts\mp\gametypes\obj_killdrop;

#namespace frun_collectible;

// Namespace frun_collectible
// Params 0
// Checksum 0x4c055853, Offset: 0xbe
// Size: 0x4c
function init()
{
    killdropinfo = killdrop::function_cf89378d072ff892( %"hash_3d65b47ddbfb172a" );
    killdropinfo.var_d1e5ba2547561fb5 = &function_d1e5ba2547561fb5;
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.killdropinfo = killdropinfo;
}

// Namespace frun_collectible
// Params 0
// Checksum 0xe4de49f2, Offset: 0x112
// Size: 0x14c
function function_cbc2bc1bb506cbcd()
{
    var_f20290286bc433ac = 19;
    var_1b4795c9fa57ec8d = int( self getplayerdata( "mp", "collectedCoinsBitmask" ) );
    
    for ( zoneindex = 1; zoneindex <= 9 ; zoneindex++ )
    {
        var_f82305073049db68 = 1;
        
        while ( true )
        {
            spawnname = "coin_spawn_" + zoneindex + "_" + var_f82305073049db68;
            spawndata = level.struct_class_names[ "script_noteworthy" ][ spawnname ];
            
            if ( !spawndata )
            {
                break;
            }
            
            coinbit = 1 << var_f20290286bc433ac;
            hascollected = ( var_1b4795c9fa57ec8d & coinbit ) != 0;
            
            if ( !hascollected )
            {
                modeinfo = frun_free_run::function_97dc8f6dff0a9255();
                coindrop = killdrop::function_f2801b21f06fa312( self, 0, spawndata[ 0 ].origin, 1, modeinfo.killdropinfo );
                coindrop.var_f485e9dd096f9100 = var_f20290286bc433ac;
                coindrop.visual.angles = spawndata[ 0 ].angles ?? ( 0, 0, 0 );
            }
            
            var_f20290286bc433ac++;
            var_f82305073049db68++;
            
            if ( var_f20290286bc433ac >= 38 )
            {
                return;
            }
        }
    }
}

// Namespace frun_collectible
// Params 1, eflags: 0x4
// Checksum 0x85a8ca76, Offset: 0x266
// Size: 0x4c
function private function_d1e5ba2547561fb5( dropent )
{
    var_1b4795c9fa57ec8d = self getplayerdata( "mp", "collectedCoinsBitmask" );
    var_1b4795c9fa57ec8d = function_e74edf669e1ddceb( var_1b4795c9fa57ec8d, dropent.var_f485e9dd096f9100 );
    self setplayerdata( "mp", "collectedCoinsBitmask", var_1b4795c9fa57ec8d );
}

