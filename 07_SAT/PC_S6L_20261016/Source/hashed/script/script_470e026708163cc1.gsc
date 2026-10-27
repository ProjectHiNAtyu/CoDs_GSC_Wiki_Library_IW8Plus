// script_470e026708163cc1  (hash_470e026708163cc1.gscc) (size: 4847 Bytes / 0x12ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1cdcbc1 (3788360641)
// size ...... 4847 (0x12ef)
// includes .. 5   (offset: 0x124b)
// strings ... 1   (offset: 0x1273)
// dev strs .. 9   (offset: 0x1283)
// exports ... 10  (offset: 0xc17)
// cseg ...... 0x68 + 0xbaf (0xc17)
// imports ... 41  (offset: 0xda7)
// animtree1 . 0   (offset: 0x12ef)
// animtree2 . 0   (offset: 0x12ef)
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;

#namespace namespace_4ac629b285195f94;

// Namespace namespace_4ac629b285195f94
// Params 0, eflags: 0x4
// Checksum 0x9d802d41, Offset: 0x86
// Size: 0x61
function private function_34508268ba15bd61()
{
    var_f3e1631308b945cb = [];
    var_2c047315f43f8575 = common_inventory_groups::function_896ed3217a875f7d()[ 0 ];
    var_4375d83555c8dd6f = common_inventory_groups::function_c27ac785b5373b73()[ 0 ];
    function_672844bdc4a12897( var_f3e1631308b945cb, var_2c047315f43f8575, 2 );
    function_672844bdc4a12897( var_f3e1631308b945cb, var_4375d83555c8dd6f, 1 );
    level.var_e953ca10fcae0350.var_f3e1631308b945cb = var_f3e1631308b945cb;
}

// Namespace namespace_4ac629b285195f94
// Params 3, eflags: 0x4
// Checksum 0x3c8ab26a, Offset: 0xef
// Size: 0xe2
function private function_672844bdc4a12897( var_f3e1631308b945cb, inventorygroupbundle, inventorygroupid )
{
    for ( i = 0; i < inventorygroupbundle.buttonrows.size ; i++ )
    {
        for ( j = 0; j < inventorygroupbundle.buttonrows[ i ].buttoncolumns.size ; j++ )
        {
            var_54cea1576182a681 = getscriptbundle( inventorygroupbundle.buttonrows[ i ].buttoncolumns[ j ].buttondef );
            
            if ( var_54cea1576182a681.var_fb3973fed48150fd )
            {
                var_f3e1631308b945cb[ var_54cea1576182a681.var_fb3973fed48150fd ] = { #groupid:inventorygroupid, #column:j, #row:i };
            }
        }
    }
}

// Namespace namespace_4ac629b285195f94
// Params 2
// Checksum 0x60dbb3e6, Offset: 0x1d9
// Size: 0x341
function function_6ed0777d84d35de2( notification, pingdata )
{
    if ( !level.var_e953ca10fcae0350.var_f3e1631308b945cb )
    {
        function_34508268ba15bd61();
    }
    
    if ( !isdefined( self.var_a1f0c0ad7a52ca29 ) )
    {
        self.var_a1f0c0ad7a52ca29 = [];
    }
    
    time = gettime();
    
    if ( self.var_a1f0c0ad7a52ca29[ pingdata ] && time - self.var_a1f0c0ad7a52ca29[ pingdata ] < 1000 )
    {
        /#
            function_cca2c2aaf5ee93f8( "<dev string:x24>" + pingdata );
        #/
        
        return;
    }
    
    self.var_a1f0c0ad7a52ca29[ pingdata ] = time;
    
    if ( self.var_a1f0c0ad7a52ca29.size > 50 )
    {
        self.var_a1f0c0ad7a52ca29 = [];
        self.var_a1f0c0ad7a52ca29[ pingdata ] = time;
        assertmsg( "<dev string:x5c>" );
    }
    
    var_8d38a8fab7d59bd1 = calloutmarkerping::function_b4611f55ab7cb258( pingdata );
    lootid = var_8d38a8fab7d59bd1.lootid;
    lootidtype = loot::function_52cf8374c44a4ff5( lootid );
    
    /#
        function_cca2c2aaf5ee93f8( "<dev string:x99>" + lootid + "<dev string:xa9>" + lootidtype );
    #/
    
    if ( lootidtype == #"calloutmarkerpingitem" )
    {
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        var_518e177c013651bf = level.var_e953ca10fcae0350.var_f3e1631308b945cb[ hashcat( %"calloutmarkerpingitem:", ref ) ];
    }
    else
    {
        bundle = common_item::function_b202b16941992cca( lootid );
        typestring = common_item::function_16e8c106491eeaca( bundle );
        var_518e177c013651bf = function_221f160b9ad99a97( bundle, typestring == #"ammo" );
    }
    
    if ( !var_518e177c013651bf )
    {
        return;
    }
    
    funcs = common_inventory_groups::function_987405ff5ee23e99( var_518e177c013651bf.groupid );
    [ inventorygroup ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    var_7984dc94e63993c1 = 0;
    
    if ( lootidtype == #"calloutmarkerpingitem" )
    {
        var_7984dc94e63993c1 = common_inventory_groups::function_1cc3abea66bf8801( inventorygroup, var_518e177c013651bf.row, var_518e177c013651bf.column );
    }
    
    slotindex = common_inventory_groups::function_7539b7a73a2ba0b2( inventorygroup, var_518e177c013651bf.row, var_518e177c013651bf.column );
    aliveteammembers = teams::getteamdata( self.team, "alivePlayers" );
    
    foreach ( player in aliveteammembers )
    {
        if ( !isbot( player ) )
        {
            continue;
        }
        
        item = player common_inventory_groups::function_b340fb55e3a33389( var_518e177c013651bf.groupid, slotindex );
        
        if ( item )
        {
            player thread function_401e8fd47607f730( self, var_518e177c013651bf.row, var_518e177c013651bf.column, var_518e177c013651bf.groupid, slotindex, var_7984dc94e63993c1 );
        }
    }
}

// Namespace namespace_4ac629b285195f94
// Params 6, eflags: 0xc
// Checksum 0xaf9364d4, Offset: 0x522
// Size: 0x150
function private function_401e8fd47607f730( player, row, column, groupid, slotindex, var_7984dc94e63993c1 )
{
    self notify( #"hash_9fa6ad3b7466442a" );
    self endon( #"hash_9fa6ad3b7466442a" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    player endon( #"death_or_disconnect" );
    waittime = 0;
    
    while ( waittime < level.var_d4909c0acc55763c.var_cd50d147e77bcf3a && distancesquared( self.origin, player.origin ) > 4000000 )
    {
        wait 1;
        waittime += 1;
    }
    
    if ( waittime >= level.var_d4909c0acc55763c.var_cd50d147e77bcf3a )
    {
        return;
    }
    
    item = common_inventory_groups::function_b340fb55e3a33389( groupid, slotindex );
    
    if ( !item )
    {
        return;
    }
    
    dropall = var_7984dc94e63993c1;
    common_inventory_groups::function_d1ad55b9507ab500( row, column, groupid, undefined, undefined, 0, dropall, undefined );
    
    /#
        function_cca2c2aaf5ee93f8( "<dev string:xb2>" + groupid + "<dev string:xce>" + row + "<dev string:xd6>" + column + "<dev string:xd9>" );
    #/
    
    thread function_de5b4ed8eb6d8e8c( item, var_7984dc94e63993c1 );
}

// Namespace namespace_4ac629b285195f94
// Params 2, eflags: 0x4
// Checksum 0x380d44d0, Offset: 0x67a
// Size: 0x298
function private function_221f160b9ad99a97( itembundle, isammo )
{
    if ( !level.inventorygroups )
    {
        return;
    }
    
    itembundlename = common_item::function_e044c3e813daec3a( itembundle );
    
    foreach ( groupid, funcs in level.inventorygroups )
    {
        if ( !funcs.getfunc || !funcs.var_65a6f7922d118cdd || !common_inventory_groups::function_bdd40ff62071d8a0( groupid ) )
        {
            continue;
        }
        
        [ groupbundle ] = self [[ funcs.var_65a6f7922d118cdd ]]();
        
        if ( !groupbundle.buttonrows )
        {
            continue;
        }
        
        for ( i = 0; i < groupbundle.buttonrows.size ; i++ )
        {
            row = groupbundle.buttonrows[ i ];
            
            for ( j = 0; j < row.buttoncolumns.size ; j++ )
            {
                if ( isammo )
                {
                    buttondefinition = common_inventory_groups::function_62e8f7d021e6a61e( groupbundle, i, j );
                    
                    if ( buttondefinition.alloweditems.size == 0 )
                    {
                        continue;
                    }
                    
                    foreach ( alloweditem in buttondefinition.alloweditems )
                    {
                        if ( alloweditem.itemspawnentry == itembundlename )
                        {
                            return { #groupid:groupid, #column:j, #row:i };
                        }
                    }
                    
                    continue;
                }
                
                item = self [[ funcs.getfunc ]]( i, j, 0, 0 );
                
                if ( item.type == itembundle.scriptable )
                {
                    return { #groupid:groupid, #column:j, #row:i };
                }
            }
        }
    }
}

// Namespace namespace_4ac629b285195f94
// Params 2, eflags: 0x4
// Checksum 0x589f3434, Offset: 0x91a
// Size: 0x1c7
function private function_de5b4ed8eb6d8e8c( item, var_7984dc94e63993c1 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    assert( item, "<dev string:xdb>" );
    scriptables = getentitylessscriptablearray( undefined, undefined, self.origin, 200 );
    
    foreach ( scriptable in scriptables )
    {
        if ( !scriptable.var_856a1dbbb3cb703a[ self.clientid ] || scriptable.pingedplayers[ self.clientid ] )
        {
            continue;
        }
        
        var_abf1ad4a2574e27 = scriptable.weaponobj == item.weaponobj;
        istypematch = getxhashasset( scriptable.type ) == item.type;
        var_8a51758bebe995b7 = scriptable.additionaldata.scriptable == item.type;
        var_6b62c8977e68fce6 = var_7984dc94e63993c1 && common_item::function_9621774ab5ce6f82( getxhashasset( scriptable.type ) ) == #"currency";
        
        if ( var_abf1ad4a2574e27 || istypematch || var_8a51758bebe995b7 || var_6b62c8977e68fce6 )
        {
            function_41d6d1410aaed76d( scriptable );
            function_1ba11faaf229be32( scriptable );
            break;
        }
    }
}

// Namespace namespace_4ac629b285195f94
// Params 1, eflags: 0x4
// Checksum 0xf36d8bf4, Offset: 0xae9
// Size: 0x4c
function private function_41d6d1410aaed76d( scriptable )
{
    calloutmarkerping::function_920a63c06abdefe8( scriptable getscriptableindex() );
    
    if ( !isdefined( scriptable.pingedplayers ) )
    {
        scriptable.pingedplayers = [];
    }
    
    scriptable.pingedplayers[ self.clientid ] = 1;
}

// Namespace namespace_4ac629b285195f94
// Params 1, eflags: 0x4
// Checksum 0xeea73498, Offset: 0xb3d
// Size: 0xa8
function private function_1ba11faaf229be32( scriptable )
{
    aliveteammembers = teams::getteamdata( self.team, "alivePlayers" );
    
    foreach ( player in aliveteammembers )
    {
        if ( !isbot( player ) )
        {
            continue;
        }
        
        player function_411f848e28406810( scriptable );
    }
}

/#

    // Namespace namespace_4ac629b285195f94
    // Params 1, eflags: 0x4
    // Checksum 0x213a9d8f, Offset: 0xbed
    // Size: 0x2a, Type: dev
    function private function_cca2c2aaf5ee93f8( msg )
    {
        if ( getdvarint( @"hash_293e4a465f6fa5ea", 0 ) == 1 )
        {
            iprintln( msg );
        }
    }

#/
