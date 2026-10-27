// scripts\mp\common\equipment\grappling_hook.gsc  (hash_1347bee40d8c5ee9.gscc) (size: 7198 Bytes / 0x1c1e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa1f9b22 (2854198050)
// size ...... 7198 (0x1c1e)
// includes .. 6   (offset: 0x18e6)
// strings ... 12  (offset: 0x1916)
// dev strs .. 46  (offset: 0x19ce)
// exports ... 26  (offset: 0xd52)
// cseg ...... 0x147 + 0xc0b (0xd52)
// imports ... 64  (offset: 0x1162)
// animtree1 . 0   (offset: 0x1c1e)
// animtree2 . 0   (offset: 0x1c1e)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\player\grapple;
#using scripts\mp\weapons;

#namespace grappling_hook;

// Namespace grappling_hook
// Params 0, eflags: 0x5
// Checksum 0x28c2e2ae, Offset: 0x165
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"grappling_hook", undefined, undefined, &post_main );
}

// Namespace grappling_hook
// Params 2
// Checksum 0x5949fa99, Offset: 0x186
// Size: 0x71
function function_51f847aef825ec26( player, var_38f466878a864e6c = 0 )
{
    player enableoffhandweapons();
    var_42a54b8aa93d2410 = isdefined( equipment_mp::function_c90a9aa89b223dd7( "equip_super_grappling_hook" ) );
    
    if ( !var_42a54b8aa93d2410 || var_38f466878a864e6c )
    {
        player equipment_mp::giveequipment( "equip_grappling_hook", "secondary" );
        return;
    }
    
    player equipment_mp::giveequipment( "equip_super_grappling_hook", "secondary" );
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xac558a47, Offset: 0x1ff
// Size: 0xa
function private post_main()
{
    level thread init();
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xbf6e5b17, Offset: 0x211
// Size: 0x5b
function private init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "equipment_initialized" );
    function_4d9edfb729a16450();
    initdvars();
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #var_e7d8089975495767:1, #equipref:"equip_grappling_hook" } );
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x8b2c73b7, Offset: 0x274
// Size: 0x6f
function private initdvars()
{
    namespace_999f317f0f814479::initdvars();
    setdvarifuninitialized( @"give_grappling_hook", 0 );
    setdvarifuninitialized( @"hash_8d156bc52d0f088d", 0 );
    
    /#
        setdvarifuninitialized( @"grapple_cheat", 0 );
        setdvarifuninitialized( @"hash_96a8c0d3ea934dad", 0 );
        setdvarifuninitialized( @"hash_2cce55fbf8cd7329", -1 );
        setdvarifuninitialized( @"hash_f4591caca6bccf4a", -1 );
    #/
    
    thread function_a84d545359bbfe6a();
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x66daa60b, Offset: 0x2eb
// Size: 0x80
function private function_4d9edfb729a16450()
{
    weapons::registerusedcallback( "grappling_hook", &ongrenadeused );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook", "onFired", &function_a92bfec42428dd70 );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook", "onGive", &function_7a5b1311066d3641 );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook", "onTake", &function_df33581394706eaf );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook", "onDestroyedByTrophy", &function_7188af2d1400239a );
    weapons::function_2cd25260a11d5e40( #"grappling_hook", &onpullback );
}

// Namespace grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x857e781a, Offset: 0x373
// Size: 0xc
function private ongrenadeused( grenade )
{
    
}

// Namespace grappling_hook
// Params 4
// Checksum 0x18dc223a, Offset: 0x387
// Size: 0x83
function function_7a5b1311066d3641( equipmentref, equipmentslot, variantid, attachments )
{
    function_4357d25251e6a973( equipmentref, equipmentslot );
    namespace_999f317f0f814479::function_a0d6ef86f55e7cfd( self );
    thread monitorcleanup( equipmentref );
    suitbundle = function_6c01510e681b2a28( self.suit );
    
    if ( suitbundle.var_e7bed54fa32a7253 && !getdvarint( @"hash_371bc8480233f85a", 0 ) )
    {
        thread function_6b078206f618be9();
    }
}

// Namespace grappling_hook
// Params 2, eflags: 0x4
// Checksum 0xc0bbb70a, Offset: 0x412
// Size: 0x9d
function private function_4357d25251e6a973( equipmentref, equipmentslot )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( equipmentref );
    
    if ( bundle.issuper )
    {
        return;
    }
    
    if ( equipmentslot != "secondary" )
    {
        return;
    }
    
    if ( !bundle.var_ff969a74ed1aaeba || level.var_83d8ad2846573fbf )
    {
        return;
    }
    
    if ( self.pers[ "rechargeEquipment" ][ equipmentslot ].ref == equipmentref )
    {
        return;
    }
    
    equipment_mp::function_8d73970836673a75( bundle.var_af22ec8b7c14505e, 0.5, equipmentref );
}

// Namespace grappling_hook
// Params 2
// Checksum 0x3cf8e79b, Offset: 0x4b7
// Size: 0x43
function function_df33581394706eaf( equipmentref, equipmentslot )
{
    self notify( #"grappling_hook_taken" );
    
    if ( getdvarint( @"hash_a67140b00fbc002f", 1 ) )
    {
        namespace_999f317f0f814479::function_a94e14b573700765( self );
    }
    
    namespace_999f317f0f814479::forcecleanup( self );
}

// Namespace grappling_hook
// Params 3
// Checksum 0x19a07814, Offset: 0x502
// Size: 0x58
function function_a92bfec42428dd70( ref, slot, objweapon )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( ref );
    
    if ( !bundle.issuper )
    {
        namespace_999f317f0f814479::function_17da84fdf0008ba6( self, &onmiss, &function_44acf016f264110c, &function_f5003f9cde4967d5 );
    }
}

// Namespace grappling_hook
// Params 0
// Checksum 0x60d6a5f5, Offset: 0x562
// Size: 0x35
function function_7188af2d1400239a()
{
    trophytarget = self;
    
    if ( isdefined( trophytarget.owner ) )
    {
        trophytarget.owner cancelgrapple();
    }
    
    trophytarget delete();
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xad02f8d7, Offset: 0x59f
// Size: 0x22
function private onmiss()
{
    ref = equipment_mp::getcurrentequipment( "secondary" );
    equipment_mp::incrementequipmentammo( ref );
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x609b7796, Offset: 0x5c9
// Size: 0xe
function private function_44acf016f264110c()
{
    callback::callback( "on_grapple_pulling_start" );
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xee25003b, Offset: 0x5df
// Size: 0xe
function private function_f5003f9cde4967d5()
{
    callback::callback( "on_grapple_pulling_end" );
}

// Namespace grappling_hook
// Params 0, eflags: 0xc
// Checksum 0x5430964f, Offset: 0x5f5
// Size: 0xc6
function private function_6b078206f618be9()
{
    self notify( #"hash_848cf758ab1f4a7b" );
    self endon( #"hash_848cf758ab1f4a7b" );
    self endon( #"disconnect" );
    self endon( #"grappling_hook_taken" );
    self endon( #"grapple_cleanup" );
    
    while ( true )
    {
        self waittill( #"grapple_retrieve", retrieved_entity, retrieved_scriptable, hit_position, retrieving_speed );
        params = { #speed:retrieving_speed, #position:hit_position, #scriptable:retrieved_scriptable, #entity:retrieved_entity };
        callback::callback( #"hash_db23ebf23acc8885", params );
    }
}

// Namespace grappling_hook
// Params 1, eflags: 0x4
// Checksum 0xe415acd7, Offset: 0x6c3
// Size: 0x78
function private monitorcleanup( equipmentref )
{
    self endon( #"grappling_hook_taken" );
    
    while ( true )
    {
        if ( !isplayer( self ) )
        {
            return;
        }
        
        equipment = equipment_mp::getcurrentequipment( "secondary" );
        stillequipped = equipment == equipmentref;
        
        if ( !stillequipped || !isplayer( self ) || !isalive( self ) )
        {
            namespace_999f317f0f814479::forcecleanup( self );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xd7336723, Offset: 0x743
// Size: 0x120
function private function_a84d545359bbfe6a()
{
    level endon( #"game_ended" );
    
    /#
        childthread grapple_cheat();
        childthread function_e9fc16eeb3f30499();
        childthread function_de44f37e4cae3af6();
        childthread function_9a8016c63ca5b33d();
    #/
    
    while ( true )
    {
        giveany = getdvarint( @"give_grappling_hook", 0 );
        giveequip = getdvarint( @"hash_8d156bc52d0f088d", 0 );
        
        if ( giveany || giveequip )
        {
            while ( !isplayer( level.players[ 0 ] ) )
            {
                waitframe();
            }
            
            foreach ( player in level.players )
            {
                function_51f847aef825ec26( player, giveequip );
            }
            
            setdvar( @"give_grappling_hook", 0 );
            setdvar( @"hash_8d156bc52d0f088d", 0 );
        }
        
        waitframe();
    }
}

// Namespace grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x25cbb6ca, Offset: 0x86b
// Size: 0x3d
function private onpullback( params )
{
    var_627fb43f841ec021 = utility::callsharedfunc( #"map", #"hash_b4fafa9d5f310a7e", self );
    
    if ( var_627fb43f841ec021 )
    {
        weapons::denyusage();
    }
}

/#

    // Namespace grappling_hook
    // Params 2, eflags: 0x4
    // Checksum 0x1d2cc8ed, Offset: 0x8b0
    // Size: 0x22, Type: dev
    function private function_161d80db408ba7c4( delay, str )
    {
        wait delay;
        iprintln( str );
    }

    // Namespace grappling_hook
    // Params 3, eflags: 0x4
    // Checksum 0x6ad4c54c, Offset: 0x8da
    // Size: 0xd4, Type: dev
    function private function_aaef5a9455c183da( commandlist, value, printcommand )
    {
        printdelay = 0;
        
        foreach ( cmd in commandlist )
        {
            _cmd = cmd + "<dev string:x24>" + value + "<dev string:x26>";
            adddebugcommand( _cmd );
            
            if ( printcommand )
            {
                thread function_161d80db408ba7c4( printdelay, _cmd );
                printdelay += 0.4;
            }
        }
    }

    // Namespace grappling_hook
    // Params 0, eflags: 0x4
    // Checksum 0x309c4ebc, Offset: 0x9b6
    // Size: 0x9e, Type: dev
    function private grapple_cheat()
    {
        while ( true )
        {
            var_d136f8938704395d = getdvarint( @"grapple_cheat", 0 );
            
            if ( var_d136f8938704395d )
            {
                setdvar( @"grapple_cheat", 0 );
                function_aaef5a9455c183da( [ "<dev string:x28>", "<dev string:x2c>" ], "<dev string:x35>", 1 );
                function_aaef5a9455c183da( [ "<dev string:x36>", "<dev string:x4e>" ], "<dev string:x65>", 1 );
                
                if ( var_d136f8938704395d < 2 )
                {
                    function_aaef5a9455c183da( [ "<dev string:x67>" ], "<dev string:x65>", 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace grappling_hook
    // Params 0, eflags: 0x4
    // Checksum 0x91d44722, Offset: 0xa5c
    // Size: 0x79, Type: dev
    function private function_9a8016c63ca5b33d()
    {
        prevvalue = -1;
        
        while ( true )
        {
            newvalue = getdvarfloat( @"hash_f4591caca6bccf4a", -1 );
            
            if ( prevvalue != newvalue && newvalue > 0 )
            {
                function_aaef5a9455c183da( [ "<dev string:x79>" ], "<dev string:x65>", 1 );
                function_aaef5a9455c183da( [ "<dev string:xb0>" ], string( newvalue ), 1 );
            }
            
            prevvalue = newvalue;
            waitframe();
        }
    }

    // Namespace grappling_hook
    // Params 0, eflags: 0x4
    // Checksum 0xc07f977c, Offset: 0xadd
    // Size: 0xb1, Type: dev
    function private function_de44f37e4cae3af6()
    {
        prevvalue = -1;
        
        while ( true )
        {
            newvalue = getdvarfloat( @"hash_2cce55fbf8cd7329", -1 );
            
            if ( prevvalue == newvalue )
            {
                waitframe();
                continue;
            }
            
            if ( newvalue < 0 )
            {
                function_aaef5a9455c183da( [ "<dev string:xe6>", "<dev string:x10c>" ], "<dev string:x12a>", 0 );
            }
            else
            {
                function_aaef5a9455c183da( [ "<dev string:xe6>", "<dev string:x10c>" ], "<dev string:x65>", 1 );
                function_aaef5a9455c183da( [ "<dev string:x12c>", "<dev string:x14e>" ], string( newvalue ), 1 );
            }
            
            prevvalue = newvalue;
            waitframe();
        }
    }

    // Namespace grappling_hook
    // Params 0, eflags: 0x4
    // Checksum 0x5b5a28f6, Offset: 0xb96
    // Size: 0x1bc, Type: dev
    function private function_e9fc16eeb3f30499()
    {
        while ( true )
        {
            while ( !isplayer( level.players[ 0 ] ) )
            {
                waitframe();
            }
            
            while ( !getdvarint( @"hash_96a8c0d3ea934dad", 0 ) )
            {
                waitframe();
            }
            
            enable_dvars = [ "<dev string:x67>", "<dev string:x170>", "<dev string:x19d>", "<dev string:x1c6>", "<dev string:x1f6>" ];
            disable_dvars = [ "<dev string:x222>", "<dev string:x24e>", "<dev string:x27d>", "<dev string:x2ac>", "<dev string:x2db>", "<dev string:x30d>", "<dev string:x336>", "<dev string:x368>", "<dev string:x394>", "<dev string:x3c6>", "<dev string:x3f0>", "<dev string:x41d>", "<dev string:x447>", "<dev string:x47a>", "<dev string:x4a9>", "<dev string:x4d7>", "<dev string:x508>", "<dev string:x534>", "<dev string:x562>", "<dev string:x58e>", "<dev string:x5be>", "<dev string:x5e8>", "<dev string:x616>", "<dev string:x646>" ];
            function_aaef5a9455c183da( enable_dvars, "<dev string:x65>", 1 );
            function_aaef5a9455c183da( disable_dvars, "<dev string:x12a>", 0 );
            function_aaef5a9455c183da( [ "<dev string:x67d>" ], "<dev string:x69d>", 1 );
            
            while ( getdvarint( @"hash_96a8c0d3ea934dad", 0 ) )
            {
                waitframe();
            }
            
            function_aaef5a9455c183da( [ "<dev string:x67d>" ], "<dev string:x12a>", 1 );
            waitframe();
        }
    }

#/
