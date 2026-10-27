// scripts\mp\pickups_scriptable.gsc  (hash_3ceee332bf1eaf4b.gscc) (size: 3117 Bytes / 0xc2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e3bb303 (2386277123)
// size ...... 3117 (0xc2d)
// includes .. 4   (offset: 0xb65)
// strings ... 2   (offset: 0xb85)
// dev strs .. 12  (offset: 0xb9d)
// exports ... 11  (offset: 0x6f5)
// cseg ...... 0x7a + 0x67b (0x6f5)
// imports ... 22  (offset: 0x8ad)
// animtree1 . 0   (offset: 0xc2d)
// animtree2 . 0   (offset: 0xc2d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\loot\common_item;

#namespace pickups;

// Namespace pickups
// Params 0
// Checksum 0xd3cf154d, Offset: 0x98
// Size: 0x109
function initscriptablemanagement()
{
    leveldata = level.br_pickups;
    assert( isdefined( leveldata ), "<dev string:x24>" );
    assert( !isdefined( leveldata.scriptables ), "<dev string:x6a>" );
    leveldata.scriptables = [];
    leveldata.scriptablesstartid = 0;
    leveldata.scriptablescurid = 0;
    leveldata.scriptablesmax = getdvarint( @"scr_br_pickupscriptablesmax", 750 );
    leveldata.scriptablescleanupbatchsize = getdvarint( @"hash_1e71982a0a539739", 10 );
    assert( leveldata.scriptablescleanupbatchsize < leveldata.scriptablesmax, "<dev string:x9a>" );
    
    /#
        setdevdvarifuninitialized( @"scr_br_pickupscriptablesmax", leveldata.scriptablesmax );
        setdevdvarifuninitialized( @"hash_1e71982a0a539739", leveldata.scriptablescleanupbatchsize );
    #/
    
    utility::create_func_ref( "deregisterScriptable", &function_11fce5fab2ff7791 );
}

// Namespace pickups
// Params 1
// Checksum 0xeb235781, Offset: 0x1a9
// Size: 0xd3
function registerscriptableinstance( instance )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return;
    }
    
    assert( isdefined( level.br_pickups ), "<dev string:xdd>" );
    assert( isdefined( level.br_pickups.scriptables ), "<dev string:x125>" );
    assert( !isdefined( instance.brpickupscriptableid ), "<dev string:x168>" );
    id = level.br_pickups.scriptablescurid;
    instance.brpickupscriptableid = id;
    level.br_pickups.scriptables[ id ] = instance;
    level.br_pickups.scriptablescurid++;
}

// Namespace pickups
// Params 1
// Checksum 0x31668e17, Offset: 0x284
// Size: 0xa3
function deregisterscriptableinstance( instance )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return;
    }
    
    assert( isdefined( level.br_pickups ), "<dev string:x1ab>" );
    assert( isdefined( level.br_pickups.scriptables ), "<dev string:x1f5>" );
    assert( isdefined( instance.brpickupscriptableid ), "<dev string:x23a>" );
    level.br_pickups.scriptables[ instance.brpickupscriptableid ] = undefined;
    instance.brpickupscriptableid = undefined;
}

// Namespace pickups
// Params 0
// Checksum 0xaac70a3b, Offset: 0x32f
// Size: 0x14
function function_11fce5fab2ff7791()
{
    if ( function_81845e04b07bec32( self ) )
    {
        deregisterscriptableinstance( self );
    }
}

// Namespace pickups
// Params 0
// Checksum 0x99303006, Offset: 0x34b
// Size: 0x204
function clearspaceforscriptableinstance()
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return;
    }
    
    leveldata = level.br_pickups;
    assert( isdefined( leveldata ), "<dev string:x27b>" );
    assert( isdefined( leveldata.scriptables ), "<dev string:x2c8>" );
    assert( leveldata.scriptables.size <= leveldata.scriptablesmax, "<dev string:x310>" );
    
    if ( leveldata.scriptables.size < leveldata.scriptablesmax )
    {
        return;
    }
    
    function_791daada2c51180b();
    var_340d4c0f0ac2b2ab = 0;
    
    for ( i = leveldata.scriptablesstartid; i < leveldata.scriptablescurid ; i++ )
    {
        if ( var_340d4c0f0ac2b2ab == leveldata.scriptablescleanupbatchsize )
        {
            break;
        }
        
        instance = leveldata.scriptables[ i ];
        
        if ( isdefined( instance ) )
        {
            if ( instance.criticalitem )
            {
                continue;
            }
            
            foreach ( removecallback in level.br_pickups.var_fc7d03bac87458cf )
            {
                instance [[ removecallback ]]();
            }
            
            leveldata.scriptables[ i ] = undefined;
            
            if ( isdefined( instance.removecallback ) )
            {
                instance [[ instance.removecallback ]]();
            }
            else if ( isent( instance ) )
            {
                instance delete();
            }
            else
            {
                instance freescriptable();
            }
            
            var_340d4c0f0ac2b2ab++;
        }
        else
        {
            leveldata.scriptables[ i ] = undefined;
        }
        
        leveldata.scriptablesstartid++;
    }
}

// Namespace pickups
// Params 1
// Checksum 0x6e174358, Offset: 0x557
// Size: 0x1e, Type: bool
function function_81845e04b07bec32( instance )
{
    return isdefined( instance ) && isdefined( instance.brpickupscriptableid );
}

// Namespace pickups
// Params 1
// Checksum 0x54eb140e, Offset: 0x57e
// Size: 0x60
function deletescriptableinstance( var_630ecad347ee8c03 )
{
    if ( self.criticalitem && !var_630ecad347ee8c03 )
    {
        return;
    }
    
    if ( common_item::items_isenabled() )
    {
        common_item::function_869d7676e359a627( self );
        return;
    }
    
    if ( isdefined( self.brpickupscriptableid ) )
    {
        deregisterscriptableinstance( self );
    }
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    loothide( self );
}

// Namespace pickups
// Params 2
// Checksum 0x85cd6a96, Offset: 0x5e6
// Size: 0x1f
function deletescriptableinstanceaftertime( delaytime, var_630ecad347ee8c03 )
{
    thread deletescriptableinstanceaftertime_proc( delaytime, var_630ecad347ee8c03 );
}

// Namespace pickups
// Params 2
// Checksum 0xa9219d04, Offset: 0x60d
// Size: 0x32
function deletescriptableinstanceaftertime_proc( delaytime, var_630ecad347ee8c03 )
{
    self endon( #"death" );
    wait delaytime;
    
    if ( isdefined( self ) )
    {
        deletescriptableinstance( var_630ecad347ee8c03 );
    }
}

// Namespace pickups
// Params 2
// Checksum 0x6c1be367, Offset: 0x647
// Size: 0xae
function loothide( instance, part = instance.type )
{
    callback::callback( #"hash_a79b57f79ff15caa", { #part:part, #instance:instance } );
    instance calloutmarkerping::function_608710c894185549();
    
    if ( instance getscriptableisreserved() && !instance.keepinmap )
    {
        if ( isdefined( instance.brpickupscriptableid ) )
        {
            deregisterscriptableinstance( instance );
        }
        
        instance freescriptable();
        return;
    }
    
    if ( !instance.donthide )
    {
        instance setscriptablepartstate( part, "hidden" );
    }
}

