// scripts\mp\execution.gsc  (hash_757f5e68bf3869d6.gscc) (size: 10160 Bytes / 0x27b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10c6a09a (281452698)
// size ...... 10160 (0x27b0)
// includes .. 5   (offset: 0x24dc)
// strings ... 30  (offset: 0x2504)
// dev strs .. 15  (offset: 0x26f0)
// exports ... 29  (offset: 0x1724)
// cseg ...... 0x44b + 0x12d9 (0x1724)
// imports ... 74  (offset: 0x1bac)
// animtree1 . 0   (offset: 0x27b0)
// animtree2 . 0   (offset: 0x27b0)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\operator;

#namespace execution;

// Namespace execution
// Params 0
// Checksum 0x469a8445, Offset: 0x469
// Size: 0x53, Type: bool
function function_bd166e6835c721ac()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( isbot( self ) && getdvarint( @"hash_eb038ca43332e718", 0 ) == 0 )
    {
        return false;
    }
    
    if ( game_utility::function_6131f69cfe56ed90() && getdvarint( @"hash_e170c3b7844c2efa", 0 ) == 0 )
    {
        return false;
    }
    
    if ( istestclient( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace execution
// Params 2
// Checksum 0x77385cd3, Offset: 0x4c5
// Size: 0x182
function _giveexecution( ref, isfirstperson )
{
    if ( !function_bd166e6835c721ac() )
    {
        return;
    }
    
    if ( getdvarint( @"scr_loadout_validate_banned_items", 0 ) && loot::isitembannedbyref( ref ) )
    {
        ref = operator::function_db4f41253b282a4f( self.operatorcustomization.operatorref );
    }
    
    if ( function_4b1ae19a1c251bb8() )
    {
        var_63f1729d301557ab = tolower( getdvar( @"hash_88ba4ca6e5ff9d5a", "" ) );
        
        if ( isdefined( level.execution.table[ var_63f1729d301557ab ] ) )
        {
            ref = var_63f1729d301557ab;
        }
    }
    
    _clearexecution( istrue( isfirstperson ) );
    propweapon = execution_getpropweaponbyref( ref );
    
    if ( ref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western" )
    {
        propweapon = level.execution.table[ ref ].propweapon2;
    }
    
    execution = execution_getexecutionbyref( ref );
    assert( isdefined( execution ), "<dev string:x24>" + ref );
    
    if ( !isdefined( execution ) )
    {
        return;
    }
    
    if ( isdefined( propweapon ) )
    {
        self giveweapon( propweapon );
        self giveexecution( execution, propweapon, istrue( isfirstperson ) );
    }
    else
    {
        self giveexecution( execution, undefined, istrue( isfirstperson ) );
    }
    
    if ( function_fc73d92eb94859e4( ref ) )
    {
        function_548c36db0493a04b();
    }
    
    self.executionref = ref;
    thread execution_monitor();
}

// Namespace execution
// Params 1
// Checksum 0xa63047a4, Offset: 0x64f
// Size: 0x89
function function_dd3185c009bb4693( ref )
{
    if ( !getcodegate( #"executions_freefall" ) )
    {
        return;
    }
    
    if ( !function_bd166e6835c721ac() )
    {
        return;
    }
    
    execution = execution_getexecutionbyref( ref );
    
    if ( !isdefined( execution ) )
    {
        return;
    }
    
    self clearexecution( 0, 1 );
    propweapon = execution_getpropweaponbyref( ref );
    
    if ( isdefined( propweapon ) )
    {
        self giveweapon( propweapon );
        self giveexecution( execution, propweapon, 0, 1 );
        return;
    }
    
    self giveexecution( execution, undefined, 0, 1 );
}

// Namespace execution
// Params 1
// Checksum 0xfb19f78, Offset: 0x6e0
// Size: 0x96
function _clearexecution( isfirstperson )
{
    if ( isdefined( self.executionref ) )
    {
        self clearexecution( istrue( isfirstperson ) );
        propweapon = execution_getpropweaponbyref( self.executionref );
        
        if ( self.executionref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western" )
        {
            propweapon = "iw9_execution_spear_wings";
        }
        
        if ( isdefined( propweapon ) && self hasweapon( propweapon ) )
        {
            self takeweapon( propweapon );
        }
        
        self.executionref = undefined;
    }
}

// Namespace execution
// Params 0
// Checksum 0xe5441ca9, Offset: 0x77e
// Size: 0xc, Type: bool
function hasexecution()
{
    return isdefined( self.executionref );
}

// Namespace execution
// Params 0
// Checksum 0x19e5e61c, Offset: 0x793
// Size: 0x189
function execution_monitor()
{
    self notify( #"hash_62ede58842ce865b" );
    self endon( #"hash_62ede58842ce865b" );
    
    if ( !self.executionref )
    {
        assertmsg( "<dev string:x41>" );
    }
    
    while ( true )
    {
        self waittill( #"execution_begin", victiment );
        
        if ( isdefined( victiment ) && ( isplayer( victiment ) || isagent( victiment ) ) )
        {
            victiment notify( #"execution_begin_victim" );
        }
        
        if ( !self.executionref )
        {
            assertmsg( "<dev string:xa1>" );
            continue;
        }
        
        var_b99fe4cce1a18e33 = self function_eac092bc49b2be4d();
        
        if ( utility::issharedfuncdefined( #"execution", hashcat( #"hash_4d1bbe3897b62769", self.executionref ) ) )
        {
            thread [[ utility::getsharedfunc( #"execution", hashcat( #"hash_4d1bbe3897b62769", self.executionref ) ) ]]( self, victiment, var_b99fe4cce1a18e33 );
        }
        
        if ( !var_b99fe4cce1a18e33 && isdefined( self.suit ) )
        {
            thread function_6e5a4f416887179c( victiment );
            aliasstring = "mus_" + self.suit + "_" + self.executionref;
            
            if ( soundexists( aliasstring ) )
            {
                self playlocalsound( aliasstring );
                victiment playlocalsound( aliasstring );
            }
        }
        
        if ( isdefined( victiment ) )
        {
            if ( victiment.basearchetype == "zombie_base" )
            {
                victiment setentitysoundcontext( "gender", "zombie" );
            }
        }
        
        wait 2;
    }
}

// Namespace execution
// Params 1
// Checksum 0x9b48d06d, Offset: 0x924
// Size: 0x74d
function function_6e5a4f416887179c( victiment )
{
    self endon( #"death_or_disconnect" );
    self endon( #"execution_stopped" );
    victiment endon( #"disconnect" );
    vicstance = victiment getstance();
    
    switch ( self.executionref )
    {
        case #"hash_272e44a6335fe57":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce06", self );
                        break;
                    }
                    else
                    {
                        wait 2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce05", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_982264d83dbf6f8d":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce06", self );
                        break;
                    }
                    else
                    {
                        wait 2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce05", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_a12a71571e6da63":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce11", self );
                        break;
                    }
                    else
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce10", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_84b68933c178cd09":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce11", self );
                        break;
                    }
                    else
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce10", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_108f7f3680e4cb4a":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 0.2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce02", self );
                        break;
                    }
                    else
                    {
                        wait 2.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce01", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_35045a42d684bc52":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 0.2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce02", self );
                        break;
                    }
                    else
                    {
                        wait 2.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce01", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_279ef6d5b4d7862a":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce14", self );
                        break;
                    }
                    else
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce13", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_17f631e350a58072":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce14", self );
                        break;
                    }
                    else
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce13", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_8d44865c9e264f78":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.3;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce09", self );
                        break;
                    }
                    else
                    {
                        wait 2.8;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce08", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_f4ad44ebf245e754":
            switch ( vicstance )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( victiment.inlaststand )
                    {
                        wait 1.3;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce09", self );
                        break;
                    }
                    else
                    {
                        wait 2.8;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce08", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
}

// Namespace execution
// Params 1
// Checksum 0x463bcfc2, Offset: 0x1079
// Size: 0x15, Type: bool
function validate( executionref )
{
    return isdefined( execution_getexecutionbyref( executionref ) );
}

// Namespace execution
// Params 0
// Checksum 0xee501259, Offset: 0x1097
// Size: 0xd9
function execution_init()
{
    assert( !isdefined( level.execution ), "<dev string:xfe>" );
    level.execution = spawnstruct();
    level.enableexecutionattackfunc = &enableexecutionattackwrapper;
    level.disableexecutionattackfunc = &disableexecutionattackwrapper;
    level.enableexecutionvictimfunc = &enableexecutionvictimwrapper;
    level.disableexecutionvictimfunc = &disableexecutionvictimwrapper;
    level.var_b25384e76c9c75c8 = &function_c868132e8ec37368;
    level.var_a12d26bb8ce6fde1 = &function_9988583b72e33c15;
    execution_loadtable();
    
    if ( utility::issharedfuncdefined( #"execution", #"init" ) )
    {
        [[ utility::getsharedfunc( #"execution", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"execution", #"validate", &validate );
    function_8c58105ebe991e34();
}

// Namespace execution
// Params 0
// Checksum 0xa69fbdf4, Offset: 0x1178
// Size: 0x8
function enableexecutionattackwrapper()
{
    self enableexecutionattack();
}

// Namespace execution
// Params 0
// Checksum 0xd406a81b, Offset: 0x1188
// Size: 0x8
function disableexecutionattackwrapper()
{
    self disableexecutionattack();
}

// Namespace execution
// Params 0
// Checksum 0xaa5bcb8b, Offset: 0x1198
// Size: 0x8
function enableexecutionvictimwrapper()
{
    self enableexecutionvictim();
}

// Namespace execution
// Params 0
// Checksum 0xd8c2de64, Offset: 0x11a8
// Size: 0x8
function disableexecutionvictimwrapper()
{
    self disableexecutionvictim();
}

// Namespace execution
// Params 0
// Checksum 0x35020732, Offset: 0x11b8
// Size: 0x261
function execution_loadtable()
{
    level.execution.table = [];
    
    /#
        var_3b1e38a36a1711fc = [];
    #/
    
    foreach ( executionref in operator::getexecutionrefs() )
    {
        struct = spawnstruct();
        struct.ref = executionref;
        id = operator::getexecutionid( executionref );
        assert( isdefined( id ), "<dev string:x128>" + executionref + "<dev string:x13e>" );
        struct.id = int( id );
        execution = operator::getexecutiondata( executionref );
        assert( execution, "<dev string:x128>" + executionref + "<dev string:x14b>" );
        
        if ( execution != "none" )
        {
            struct.execution = execution;
        }
        
        propweapon = operator::getexecutionweapon( executionref );
        assert( propweapon, "<dev string:x128>" + executionref + "<dev string:x15f>" );
        
        if ( propweapon != "none" )
        {
            struct.propweapon = makeweapon( propweapon );
            
            if ( execution == "execution_062" )
            {
                struct.propweapon2 = "iw9_execution_spear_wings";
            }
            
            if ( isnullweapon( struct.propweapon ) )
            {
                /#
                    var_3b1e38a36a1711fc[ executionref ] = propweapon;
                #/
                
                continue;
            }
        }
        
        level.execution.table[ executionref ] = struct;
    }
    
    /#
        if ( var_3b1e38a36a1711fc.size )
        {
            foreach ( ref, prop in var_3b1e38a36a1711fc )
            {
                println( "<dev string:x128>" + ref + "<dev string:x175>" + prop + "<dev string:x198>" );
            }
            
            assert( 0, "<dev string:x1de>" );
        }
    #/
}

// Namespace execution
// Params 1
// Checksum 0xcf352c09, Offset: 0x1421
// Size: 0x57
function execution_getexecutionbyref( ref )
{
    assert( isdefined( level.execution ), "<dev string:x23f>" );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.execution;
    }
}

// Namespace execution
// Params 1
// Checksum 0x1a99b769, Offset: 0x1481
// Size: 0x57
function execution_getpropweaponbyref( ref )
{
    assert( isdefined( level.execution ), "<dev string:x279>" );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.propweapon;
    }
}

// Namespace execution
// Params 1
// Checksum 0x1b995b32, Offset: 0x14e1
// Size: 0x17
function execution_getrefbyplayer( player )
{
    return player.executionref;
}

// Namespace execution
// Params 1
// Checksum 0xde96becc, Offset: 0x1501
// Size: 0x3f, Type: bool
function execution_getidbyref( ref )
{
    execution = execution_getexecutionbyref( ref );
    execution_id = function_43b5ed5a14a56573( #"execution", execution );
    return execution_id ?? 0;
}

// Namespace execution
// Params 1
// Checksum 0x25d5bc15, Offset: 0x1549
// Size: 0x51, Type: bool
function function_fc73d92eb94859e4( ref )
{
    assert( isdefined( level.execution ), "<dev string:x2b4>" );
    struct = level.execution.table[ ref ];
    return istrue( struct.petenabled );
}

// Namespace execution
// Params 0
// Checksum 0xbedaeb37, Offset: 0x15a3
// Size: 0x15
function function_548c36db0493a04b()
{
    val::set( "pet_execution", "hide_operator_backpack", 1 );
}

// Namespace execution
// Params 1
// Checksum 0x699ae3e2, Offset: 0x15c0
// Size: 0x30
function function_883b362fffe1de4f( params )
{
    val::set( "ladderExecution", "execution_attack", 0 );
    val::set( "ladderExecution", "execution_victim", 0 );
}

// Namespace execution
// Params 1
// Checksum 0xca3e0545, Offset: 0x15f8
// Size: 0x18
function function_b003bfce85514f07( params )
{
    val::reset_all( "ladderExecution" );
}

// Namespace execution
// Params 1
// Checksum 0x5876cab3, Offset: 0x1618
// Size: 0x2b
function playerspawned( params )
{
    val::reset_all( "ladderExecution" );
    
    if ( self.var_fcf137529bcd2d49 )
    {
        function_b3f47f15e5b37586();
    }
}

// Namespace execution
// Params 1
// Checksum 0xfabe234f, Offset: 0x164b
// Size: 0x38
function function_74d200e78e2d431f( params )
{
    if ( !utility::isusingremote() )
    {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield( 2.5, 60, 20, 20 );
        self.var_fcf137529bcd2d49 = 1;
    }
}

// Namespace execution
// Params 0, eflags: 0x4
// Checksum 0xcf2e0f6f, Offset: 0x168b
// Size: 0x8
function private function_b3f47f15e5b37586()
{
    self disablephysicaldepthoffieldscripting();
}

// Namespace execution
// Params 1
// Checksum 0xfe587e0e, Offset: 0x169b
// Size: 0x29
function function_e164d947deb2d497( params )
{
    if ( !utility::isusingremote() )
    {
        if ( self.var_fcf137529bcd2d49 )
        {
            function_b3f47f15e5b37586();
        }
    }
}

// Namespace execution
// Params 0
// Checksum 0xc5bf2426, Offset: 0x16cc
// Size: 0x10, Type: bool
function is_in_takedown()
{
    return self isinexecutionvictim() || self isinexecutionattack();
}

// Namespace execution
// Params 0, eflags: 0x4
// Checksum 0x2d8f46ff, Offset: 0x16e5
// Size: 0x3f
function private function_8c58105ebe991e34()
{
    if ( isdefined( level.gametypebundle.specialexecution ) )
    {
        assert( validate( level.gametypebundle.specialexecution ), "<dev string:x2e7>" );
    }
}

