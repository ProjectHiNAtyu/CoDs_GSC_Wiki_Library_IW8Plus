// script_5a788fc61d88b059  (hash_5a788fc61d88b059.gscc) (size: 2978 Bytes / 0xba2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41de73b (69068603)
// size ...... 2978 (0xba2)
// includes .. 1   (offset: 0xb5e)
// strings ... 2   (offset: 0xb66)
// dev strs .. 3   (offset: 0xb7e)
// exports ... 8   (offset: 0x7e2)
// cseg ...... 0xa3 + 0x73f (0x7e2)
// imports ... 19  (offset: 0x922)
// animtree1 . 0   (offset: 0xba2)
// animtree2 . 0   (offset: 0xba2)
#using scripts\common\utility;

#namespace namespace_cba8b6292920afd4;

// Namespace namespace_cba8b6292920afd4
// Params 0, eflags: 0x1
// Checksum 0xee370262, Offset: 0xc1
// Size: 0x20
function autoexec init()
{
    utility::registersharedfunc( #"ai", #"hash_e8f19689cf2b203d", &function_162065915ad5ed1c );
}

// Namespace namespace_cba8b6292920afd4
// Params 0
// Checksum 0x4904a127, Offset: 0xe9
// Size: 0x30
function function_162065915ad5ed1c()
{
    assert( self.aisettings.var_e6a1cc03c16cabd0, "<dev string:x24>" );
    thread function_b9ef33fad1ba988b();
    thread function_e5cd1b5c59a0935();
}

// Namespace namespace_cba8b6292920afd4
// Params 0
// Checksum 0x3dc68355, Offset: 0x121
// Size: 0x4c
function function_77c11d262a9fc9aa()
{
    if ( !isdefined( self._blackboard.var_607ff3a73d2aecee ) )
    {
        self._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
    }
    
    return self._blackboard.var_607ff3a73d2aecee;
}

// Namespace namespace_cba8b6292920afd4
// Params 0, eflags: 0x4
// Checksum 0xa79bc59d, Offset: 0x176
// Size: 0xe8
function private function_b9ef33fad1ba988b()
{
    self endon( #"death" );
    
    if ( !isdefined( self._blackboard.var_607ff3a73d2aecee ) )
    {
        waitframe();
    }
    
    self._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
    
    while ( true )
    {
        while ( true )
        {
            if ( isalive( self ) && isalive( self.enemy ) )
            {
                currentenemy = self.enemy;
                currentenemy thread function_328c5490e01b83d8( self );
                break;
            }
            
            waitframe();
        }
        
        utility::waittill_any( "movement_prediction_target_switched", "stop_current_movement_prediction" );
        
        if ( isalive( currentenemy ) )
        {
            currentenemy notify( #"hash_19446d07d18141ca" );
            currentenemy function_406ffdec3b3dd30();
            currentenemy = undefined;
        }
        
        self._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
    }
}

// Namespace namespace_cba8b6292920afd4
// Params 0, eflags: 0x4
// Checksum 0xd03f5ab1, Offset: 0x266
// Size: 0x79
function private function_e5cd1b5c59a0935()
{
    self endon( #"death" );
    previousenemy = undefined;
    
    while ( true )
    {
        if ( !isdefined( previousenemy ) && isalive( self.enemy ) )
        {
            previousenemy = self.enemy;
        }
        
        if ( isdefined( previousenemy ) && isdefined( self.enemy ) && previousenemy != self.enemy )
        {
            self notify( #"movement_prediction_target_switched" );
            previousenemy = undefined;
        }
        
        waitframe();
    }
}

// Namespace namespace_cba8b6292920afd4
// Params 1, eflags: 0x4
// Checksum 0x5eef43a6, Offset: 0x2e7
// Size: 0x4dd
function private function_328c5490e01b83d8( var_42b75ec99b9628cc )
{
    var_42b75ec99b9628cc endon( #"death" );
    self endon( #"hash_19446d07d18141ca" );
    self endon( #"disconnect" );
    
    /#
        debugprediction = getdvarint( @"hash_f90ace673a710be7", 0 );
    #/
    
    if ( !isdefined( self.var_2d4b2e1e70bb7c83 ) )
    {
        self.var_2d4b2e1e70bb7c83 = [];
    }
    
    if ( !isdefined( self.var_8501617338422679 ) )
    {
        self.var_8501617338422679 = 0;
    }
    
    if ( !isdefined( var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee ) )
    {
        var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
    }
    
    var_2e57865ec4cd3da7 = getdvarfloat( @"hash_8cbda764b27b7d68", var_42b75ec99b9628cc.var_2e57865ec4cd3da7 );
    var_348f333165b2482a = getdvarint( @"hash_436136cbcdf70d63", var_42b75ec99b9628cc.var_348f333165b2482a );
    var_dfe55fb5c801fc9 = getdvarfloat( @"hash_6a2b619b4fc22119", var_42b75ec99b9628cc.var_dfe55fb5c801fc9 );
    var_aee78bc2c79fdfe0 = getdvarfloat( @"hash_fdc6c3a78dba3f6c", var_42b75ec99b9628cc.var_aee78bc2c79fdfe0 );
    var_3348588bc463f01d = getdvarfloat( @"hash_4eebe5275f3a634", var_42b75ec99b9628cc.var_3348588bc463f01d );
    
    while ( isdefined( self ) )
    {
        if ( !self.var_c5841ca9d8c4dcf1 )
        {
            self.var_8501617338422679 = 0;
            var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
            wait var_2e57865ec4cd3da7;
            continue;
        }
        
        if ( self.var_8501617338422679 <= 0 )
        {
            self.var_2d4b2e1e70bb7c83[ 0 ] = { #origin:self.origin, #time:gettime() };
            self.var_8501617338422679++;
            
            /#
                if ( debugprediction )
                {
                    print3d( self.var_2d4b2e1e70bb7c83[ 0 ].origin + ( 0, 0, 100 ), "<dev string:x92>", ( 1, 1, 0 ), 1, 1, 500, 1 );
                    sphere( self.var_2d4b2e1e70bb7c83[ 0 ].origin, 5, ( 1, 1, 0 ), 0, 500 );
                }
            #/
            
            wait var_2e57865ec4cd3da7;
            continue;
        }
        
        lastsample = self.var_2d4b2e1e70bb7c83[ self.var_8501617338422679 - 1 ];
        var_d58adf4a5250f51d = gettime() - lastsample.time;
        
        if ( var_d58adf4a5250f51d > utility::function_4b74c15943231980( var_3348588bc463f01d ) )
        {
            self.var_8501617338422679 = 0;
            var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
            wait var_2e57865ec4cd3da7;
            continue;
        }
        
        var_df3e78a8540bd81a = self.origin - lastsample.origin;
        var_ca952a80723037b0 = length( var_df3e78a8540bd81a );
        
        if ( var_ca952a80723037b0 < var_dfe55fb5c801fc9 )
        {
            wait var_2e57865ec4cd3da7;
            continue;
        }
        
        if ( var_ca952a80723037b0 > var_aee78bc2c79fdfe0 )
        {
            self.var_8501617338422679 = 0;
            var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee = ( 0, 0, 0 );
            wait var_2e57865ec4cd3da7;
            continue;
        }
        
        newsample = { #origin:self.origin, #time:gettime() };
        self.var_2d4b2e1e70bb7c83[ self.var_8501617338422679 ] = newsample;
        self.var_8501617338422679++;
        
        /#
            if ( debugprediction )
            {
                sphere( newsample.origin, 5, ( 0, 0, 1 ), 0, 500 );
            }
        #/
        
        if ( self.var_8501617338422679 >= var_348f333165b2482a )
        {
            self.var_8501617338422679 = 0;
            var_42b75ec99b9628cc._blackboard.var_607ff3a73d2aecee = vectornormalize( self.var_2d4b2e1e70bb7c83[ var_348f333165b2482a - 1 ].origin - self.var_2d4b2e1e70bb7c83[ 0 ].origin );
            
            /#
                if ( debugprediction )
                {
                    print3d( self.var_2d4b2e1e70bb7c83[ var_348f333165b2482a - 1 ].origin + ( 0, 0, 100 ), "<dev string:x9f>", ( 0, 1, 0 ), 1, 1, 500, 1 );
                    utility::draw_arrow( self.var_2d4b2e1e70bb7c83[ 0 ].origin, self.var_2d4b2e1e70bb7c83[ var_348f333165b2482a - 1 ].origin, ( 0, 1, 0 ), 1, 0, 500 );
                }
            #/
        }
        
        wait var_2e57865ec4cd3da7;
        continue;
    }
}

// Namespace namespace_cba8b6292920afd4
// Params 0, eflags: 0x4
// Checksum 0x593425e2, Offset: 0x7cc
// Size: 0x16
function private function_406ffdec3b3dd30()
{
    self.var_2d4b2e1e70bb7c83 = undefined;
    self.var_8501617338422679 = undefined;
}

