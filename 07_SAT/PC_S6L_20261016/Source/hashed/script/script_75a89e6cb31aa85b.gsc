// script_75a89e6cb31aa85b  (hash_75a89e6cb31aa85b.gscc) (size: 4523 Bytes / 0x11ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x944beabf (2488003263)
// size ...... 4523 (0x11ab)
// includes .. 2   (offset: 0x1147)
// strings ... 4   (offset: 0x1157)
// dev strs .. 2   (offset: 0x1193)
// exports ... 20  (offset: 0xa6f)
// cseg ...... 0x95 + 0x9da (0xa6f)
// imports ... 32  (offset: 0xd8f)
// animtree1 . 0   (offset: 0x11ab)
// animtree2 . 0   (offset: 0x11ab)
#using scripts\common\utility;
#using scripts\mp\equipment;

#namespace namespace_6a6b17b75cc2959d;

// Namespace namespace_6a6b17b75cc2959d
// Params 0, eflags: 0x1
// Checksum 0x48a70202, Offset: 0xb3
// Size: 0x6e
function autoexec init()
{
    if ( getdvarint( @"hash_4b63d2a9e202f9e7", 0 ) )
    {
        return;
    }
    
    utility::registersharedfunc( #"equipment_interaction", #"source_interact", &function_22fd2be0c9dea984 );
    utility::registersharedfunc( #"equipment_interaction", #"on_hit", &onhit );
    utility::registersharedfunc( #"equipment_interaction", #"ignore_damage", &function_9da5db4cafd64dce );
}

// Namespace namespace_6a6b17b75cc2959d
// Params 4, eflags: 0x4
// Checksum 0x81c2c380, Offset: 0x129
// Size: 0x7e
function private function_9da5db4cafd64dce( hitent, attacker, inflictor, objweapon )
{
    sourceref = equipment_mp::function_fdc4a655fbde0dec( objweapon.basename );
    
    if ( sourceref )
    {
        interactdata = function_9602dc329a8bad7a( hitent.bundle, sourceref );
        return ( interactdata && interactdata.var_64af015c841e7db2 != "None" );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 4, eflags: 0x4
// Checksum 0x6a494596, Offset: 0x1af
// Size: 0x4b
function private onhit( hitent, attacker, inflictor, objweapon )
{
    sourceref = getequipmentref( inflictor );
    
    if ( sourceref )
    {
        function_22fd2be0c9dea984( sourceref, hitent, inflictor );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 3, eflags: 0x4
// Checksum 0xdd5510dd, Offset: 0x202
// Size: 0x63
function private function_22fd2be0c9dea984( sourceref, hitent, sourceent )
{
    if ( !sourceref || !hitent )
    {
        return;
    }
    
    bundle = getbundle( hitent );
    
    if ( bundle )
    {
        interactdata = function_9602dc329a8bad7a( bundle, sourceref );
        thread function_2472940316de03c1( hitent, sourceent, interactdata );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 4, eflags: 0x4
// Checksum 0xe045db5a, Offset: 0x26d
// Size: 0x157
function private function_2472940316de03c1( hitent, sourceent, interactdata, equipref )
{
    if ( !hitent || !interactdata || hitent == sourceent )
    {
        return;
    }
    
    hitent endon( #"death" );
    level endon( #"game_ended" );
    data = { #interactdata:interactdata, #equipref:equipref, #objweapon:sourceent.weapon_object, #attacker:sourceent.owner, #inflictor:sourceent, #eattacker:sourceent.owner, #einflictor:sourceent };
    
    switch ( interactdata.var_64af015c841e7db2 )
    {
        case #"hash_8b334e5d348bcaa3":
            hitent rundisable( data );
            break;
        case #"hash_1c08764f8e45c0f8":
            hitent runslow( data );
            break;
        case #"hash_6cf35387c33a46b7":
            hitent interactdestroy( data );
            break;
        default:
            println( "<dev string:x24>" + interactdata.var_64af015c841e7db2 + "<dev string:x53>" );
            break;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0x45dfcf08, Offset: 0x3cc
// Size: 0x4f
function private rundisable( data )
{
    self notify( #"hash_998ac0c7db61b52e" );
    self endon( #"hash_998ac0c7db61b52e" );
    waitduration = function_5c73159fe980aced( data, 1 );
    interactdisable( data );
    wait waitduration;
    interactenable( data );
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0xf3a141c3, Offset: 0x423
// Size: 0x55
function private interactdestroy( data )
{
    self notify( #"hash_a1a45bb676cdb9b4" );
    self endon( #"hash_a1a45bb676cdb9b4" );
    
    if ( sharedfunccalled( data, #"interactdestroy" ) )
    {
        return;
    }
    
    if ( self.enableoverride )
    {
        self [[ self.enableoverride ]]( data );
        return;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0x64fb7fe4, Offset: 0x480
// Size: 0x7e
function private interactdisable( data )
{
    self notify( #"hash_41c0298509d860db" );
    self endon( #"hash_41c0298509d860db" );
    
    if ( sharedfunccalled( data, #"interactdisable" ) )
    {
        return;
    }
    
    if ( self.disableoverride )
    {
        self [[ self.disableoverride ]]( data );
        return;
    }
    
    self.isjammed = 1;
    
    if ( self getscriptablehaspart( "jammed" ) )
    {
        self setscriptablepartstate( "jammed", "on", 0 );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0x64fa9c94, Offset: 0x506
// Size: 0x7d
function private interactenable( data )
{
    self notify( #"hash_ba3574b0abae6393" );
    self endon( #"hash_ba3574b0abae6393" );
    
    if ( sharedfunccalled( data, #"interactenable" ) )
    {
        return;
    }
    
    if ( self.enableoverride )
    {
        self [[ self.enableoverride ]]( data );
        return;
    }
    
    self.isjammed = undefined;
    
    if ( self getscriptablehaspart( "jammed" ) )
    {
        self setscriptablepartstate( "jammed", "off", 0 );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0xe0db42db, Offset: 0x58b
// Size: 0x4f
function private runslow( data )
{
    self notify( #"hash_65d50ada2dc3c513" );
    self endon( #"hash_65d50ada2dc3c513" );
    waitduration = function_5c73159fe980aced( data, 1 );
    function_472642920bc83675( data );
    wait waitduration;
    function_a529cd7665f20441( data );
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0xb9c42da6, Offset: 0x5e2
// Size: 0x55
function private function_472642920bc83675( data )
{
    self notify( #"hash_5f31951939d1754b" );
    self endon( #"hash_5f31951939d1754b" );
    
    if ( sharedfunccalled( data, #"hash_4dc9e6a6a37c45b8" ) )
    {
        return;
    }
    
    if ( self.var_379f7c1956fc87d7 )
    {
        self [[ self.var_379f7c1956fc87d7 ]]( data );
        return;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0xc
// Checksum 0x98b1c6da, Offset: 0x63f
// Size: 0x55
function private function_a529cd7665f20441( data )
{
    self notify( #"hash_a594720706e6dabd" );
    self endon( #"hash_a594720706e6dabd" );
    
    if ( sharedfunccalled( data, #"hash_e67962dfd5c63cde" ) )
    {
        return;
    }
    
    if ( self.var_6b8e3628a9b8d99f )
    {
        self [[ self.var_6b8e3628a9b8d99f ]]( data );
        return;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 2, eflags: 0x4
// Checksum 0x3feafc2e, Offset: 0x69c
// Size: 0x52
function private sharedfunccalled( data, funcname )
{
    equipref = getequipmentref( self );
    
    if ( equipref && utility::issharedfuncdefined( getxhash( equipref ), funcname ) )
    {
        utility::callsharedfunc( getxhash( equipref ), funcname, data );
        return 1;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0x4
// Checksum 0x5aec8995, Offset: 0x6f6
// Size: 0x5a
function private getequipmentref( ent )
{
    if ( ent.equipmentref )
    {
        return ent.equipmentref;
    }
    
    if ( ent.weapon_object.basename )
    {
        return equipment_mp::function_fdc4a655fbde0dec( ent.weapon_object.basename );
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0x4
// Checksum 0xea2e7b90, Offset: 0x758
// Size: 0x7e
function private getbundle( ent )
{
    equipref = getequipmentref( ent );
    
    if ( level.equipment.table[ equipref ].bundle )
    {
        return level.equipment.table[ equipref ].bundle;
    }
    
    if ( ent.bundle )
    {
        return ent.bundle;
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 2, eflags: 0x4
// Checksum 0x3747bc09, Offset: 0x7de
// Size: 0xba
function private function_9602dc329a8bad7a( bundle, type )
{
    if ( !bundle || !bundle.equipmentinteractions )
    {
        return;
    }
    
    foreach ( data in bundle.equipmentinteractions )
    {
        if ( tolower( data.interactsource ) == tolower( type ) )
        {
            return data;
        }
    }
}

// Namespace namespace_6a6b17b75cc2959d
// Params 3, eflags: 0x4
// Checksum 0xca35da65, Offset: 0x8a0
// Size: 0x87
function private function_2a4ca99dcc58244f( type, timestamp, duration )
{
    if ( !self )
    {
        return;
    }
    
    if ( !isdefined( self.var_596a068ffd7d414c ) )
    {
        self.var_596a068ffd7d414c = [];
    }
    
    if ( !isdefined( self.var_596a068ffd7d414c[ type ] ) )
    {
        self.var_596a068ffd7d414c[ type ] = {};
    }
    
    self.var_596a068ffd7d414c[ type ].timestamp = timestamp;
    self.var_596a068ffd7d414c[ type ].duration = duration;
}

// Namespace namespace_6a6b17b75cc2959d
// Params 1, eflags: 0x4
// Checksum 0x723fc646, Offset: 0x92f
// Size: 0x65
function private function_fd77e39bd52a470b( type )
{
    if ( !self )
    {
        return;
    }
    
    if ( !isdefined( self.var_596a068ffd7d414c ) )
    {
        self.var_596a068ffd7d414c = [];
    }
    
    if ( !isdefined( self.var_596a068ffd7d414c[ type ] ) )
    {
        self.var_596a068ffd7d414c[ type ] = { #duration:0, #timestamp:0 };
    }
    
    return self.var_596a068ffd7d414c[ type ];
}

// Namespace namespace_6a6b17b75cc2959d
// Params 2, eflags: 0x4
// Checksum 0x39419bf6, Offset: 0x99d
// Size: 0xd1
function private function_5c73159fe980aced( data, var_d012d1aa615293e8 )
{
    timestamp = gettime();
    duration = data.interactdata.var_a1a37ae70d23e3fe;
    storeddata = function_fd77e39bd52a470b( data.interactdata.var_64af015c841e7db2 );
    var_4d3dc7679d380479 = storeddata.timestamp + storeddata.duration * 1000;
    remainingtime = ( var_4d3dc7679d380479 - timestamp ) / 1000;
    
    if ( remainingtime > duration )
    {
        duration = remainingtime;
    }
    
    if ( var_d012d1aa615293e8 )
    {
        function_2a4ca99dcc58244f( data.interactdata.var_64af015c841e7db2, timestamp, duration );
    }
    
    return duration;
}

