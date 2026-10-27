// script_6dad8bf6f8fe7a9a  (hash_6dad8bf6f8fe7a9a.gscc) (size: 1846 Bytes / 0x736 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4183596 (3289920918)
// size ...... 1846 (0x736)
// includes .. 2   (offset: 0x726)
// strings ... 0   (offset: 0x736)
// dev strs .. 0   (offset: 0x736)
// exports ... 8   (offset: 0x462)
// cseg ...... 0x58 + 0x40a (0x462)
// imports ... 13  (offset: 0x5a2)
// animtree1 . 0   (offset: 0x736)
// animtree2 . 0   (offset: 0x736)
#using script_6802bb17a0c535f3;
#using scripts\common\callbacks;

#namespace medals;

// Namespace medals
// Params 0, eflags: 0x1
// Checksum 0x758e7ec4, Offset: 0x76
// Size: 0x25
function autoexec register_init()
{
    aar_tracking::function_e32d863f90d794a1( #"medals", &init_medal_tracking );
    level.var_705cfa989075904f = &function_392096d2b50a12d0;
}

// Namespace medals
// Params 1, eflags: 0x4
// Checksum 0xafffd0f5, Offset: 0xa3
// Size: 0x4c
function private init_medal_tracking( aar_tracking_ref )
{
    if ( level.aartracking.trackmedals )
    {
        callback::add( #"medal_earned", &track_medal );
        callback::add( #"player_connect", &on_player_connect );
    }
}

// Namespace medals
// Params 2, eflags: 0x4
// Checksum 0x5d82bb92, Offset: 0xf7
// Size: 0x5b
function private function_392096d2b50a12d0( ref, splashbundle )
{
    if ( !level.aartracking.trackmedals )
    {
        level.var_705cfa989075904f = undefined;
        return;
    }
    
    if ( !isdefined( level.var_61098ea01390d8f4 ) )
    {
        level.var_61098ea01390d8f4 = [];
    }
    
    level.var_61098ea01390d8f4[ ref ] = splashbundle;
}

// Namespace medals
// Params 1, eflags: 0x4
// Checksum 0x7cb38909, Offset: 0x15a
// Size: 0x13
function private on_player_connect( params )
{
    function_81fb7aaf48f3b593();
}

// Namespace medals
// Params 0, eflags: 0x4
// Checksum 0x9d9658d0, Offset: 0x175
// Size: 0x7a
function private function_81fb7aaf48f3b593()
{
    if ( getdvarint( @"hash_10d3948a554a7839", 0 ) )
    {
        return;
    }
    
    if ( self.pers[ #"hash_11255497043fc174" ] )
    {
        return;
    }
    
    self.pers[ #"hash_11255497043fc174" ] = 1;
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medalcount", 0 );
    thread function_51011926b305318f( var_6f9b00680ed002d8 );
}

// Namespace medals
// Params 1, eflags: 0x4
// Checksum 0x34048332, Offset: 0x1f7
// Size: 0xbe
function private function_51011926b305318f( var_6f9b00680ed002d8 )
{
    self endon( #"disconnect" );
    var_4b93648b95dd83b0 = getdvarint( @"hash_2611841fb194ec3e", 16 );
    
    if ( var_4b93648b95dd83b0 <= 0 )
    {
        var_4b93648b95dd83b0 = 16;
    }
    
    for ( medalindex = 0; medalindex < 512 ; medalindex++ )
    {
        if ( medalindex % var_4b93648b95dd83b0 == 0 && medalindex >= var_4b93648b95dd83b0 )
        {
            waitframe();
        }
        
        self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medals", medalindex, #"medalref", %"" );
        self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medals", medalindex, #"count", 0 );
    }
}

// Namespace medals
// Params 1, eflags: 0x4
// Checksum 0xb0a5af94, Offset: 0x2bd
// Size: 0x1a5
function private track_medal( params )
{
    medalref = params.ref;
    splashbundle = level.var_61098ea01390d8f4[ medalref ];
    
    if ( !isdefined( splashbundle ) )
    {
        return;
    }
    
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    aarmedalinfo = self.pers[ #"aarmedalinfo" ];
    
    if ( !isdefined( aarmedalinfo ) )
    {
        aarmedalinfo = {};
        self.pers[ #"aarmedalinfo" ] = aarmedalinfo;
    }
    
    if ( !isdefined( aarmedalinfo.var_246109ef9290fdca ) )
    {
        aarmedalinfo.var_246109ef9290fdca = [];
    }
    
    medalindex = aarmedalinfo.var_246109ef9290fdca[ medalref ];
    
    if ( !isdefined( medalindex ) )
    {
        medalindex = self getplayerdata( var_6f9b00680ed002d8, #"aardata", #"medalcount" );
        
        if ( medalindex >= 512 )
        {
            return;
        }
        
        aarmedalinfo.var_246109ef9290fdca[ medalref ] = medalindex;
        self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medalcount", medalindex + 1 );
    }
    
    medalcount = self getplayerdata( var_6f9b00680ed002d8, #"aardata", #"medals", medalindex, #"count" );
    
    if ( medalcount == 0 )
    {
        self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medals", medalindex, #"medalref", splashbundle );
    }
    
    self setplayerdata( var_6f9b00680ed002d8, #"aardata", #"medals", medalindex, #"count", medalcount + 1 );
}

