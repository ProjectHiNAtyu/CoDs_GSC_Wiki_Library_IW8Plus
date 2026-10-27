// script_1cd231b6fedc5a84  (hash_1cd231b6fedc5a84.gscc) (size: 3656 Bytes / 0xe48 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea7b7222 (3933958690)
// size ...... 3656 (0xe48)
// includes .. 3   (offset: 0xdb4)
// strings ... 9   (offset: 0xdcc)
// dev strs .. 0   (offset: 0xe48)
// exports ... 17  (offset: 0x80c)
// cseg ...... 0xcf + 0x73d (0x80c)
// imports ... 27  (offset: 0xab4)
// animtree1 . 0   (offset: 0xe48)
// animtree2 . 0   (offset: 0xe48)
#using scripts\anim\utility_common;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace cover;

// Namespace cover
// Params 0
// Checksum 0xd73c3dc4, Offset: 0xed
// Size: 0x15
function getcoverstate()
{
    return self._blackboard.coverstate;
}

// Namespace cover
// Params 1
// Checksum 0x74bc15e3, Offset: 0x10b
// Size: 0x31
function shouldlookforinitialcover( taskid )
{
    if ( isdefined( self.fnshouldlookforcover ) )
    {
        return self [[ self.fnshouldlookforcover ]]( taskid );
    }
    
    return anim.failure;
}

// Namespace cover
// Params 1
// Checksum 0x7fe05cb3, Offset: 0x145
// Size: 0x31
function lookforinitialcover( taskid )
{
    if ( isdefined( self.fnlookforcover ) )
    {
        return self [[ self.fnlookforcover ]]( taskid );
    }
    
    return anim.failure;
}

// Namespace cover
// Params 3
// Checksum 0xbb2d33ac, Offset: 0x17f
// Size: 0xe4, Type: bool
function lookforbettercover_internal( var_1dd9f8a845b22289, var_68cc492d00578740, coverselector )
{
    if ( self.arriving )
    {
        return false;
    }
    
    if ( !isdefined( var_68cc492d00578740 ) )
    {
        var_68cc492d00578740 = 0;
    }
    
    if ( self.doingambush )
    {
        node = self ambushgetnextambushnode();
    }
    else
    {
        if ( !isdefined( coverselector ) && utility_common::usingmg() )
        {
            coverselector = %"cover_lmg";
        }
        
        node = self findbestcovernode( coverselector, var_68cc492d00578740 );
    }
    
    if ( isdefined( node ) )
    {
        if ( node != self.node || isdefined( var_1dd9f8a845b22289 ) && node != var_1dd9f8a845b22289 )
        {
            if ( self usecovernodeifpossible( node ) )
            {
                if ( self.doingambush )
                {
                    if ( self ambushcheckpath( node ) )
                    {
                        return true;
                    }
                    else
                    {
                        self clearpath();
                        self.keepclaimednodeifvalid = 0;
                        self.keepclaimednode = 0;
                        return false;
                    }
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace cover
// Params 1
// Checksum 0xdae26014, Offset: 0x26c
// Size: 0x35
function update( task )
{
    covernode = self.covernode;
    assert( isdefined( covernode ) );
    return anim.success;
}

// Namespace cover
// Params 1
// Checksum 0x53795c5b, Offset: 0x2aa
// Size: 0x15
function isdoingambush( task )
{
    return self.doingambush;
}

// Namespace cover
// Params 1
// Checksum 0x24c3dce8, Offset: 0x2c8
// Size: 0x20
function updatehide( task )
{
    self setcoverstate( "hide" );
    return anim.success;
}

/#

    // Namespace cover
    // Params 0
    // Checksum 0xfed53064, Offset: 0x2f1
    // Size: 0x51, Type: dev
    function function_60f81d8f2d4bd28a()
    {
        var_b48b549f217464d5 = getdvarint( @"hash_cc4c9095ab9f206f", 0 );
        debugentindex = getdvarint( @"ai_debugentindex" );
        return var_b48b549f217464d5 == 1 && ( debugentindex == -1 || debugentindex == self getentitynumber() );
    }

    // Namespace cover
    // Params 1
    // Checksum 0x2d73a012, Offset: 0x34a
    // Size: 0x23, Type: dev
    function function_6ce3a35eee868d7( reason )
    {
        if ( function_60f81d8f2d4bd28a() )
        {
            self.var_6ce3a35eee868d7 = reason;
        }
    }

#/

// Namespace cover
// Params 2
// Checksum 0x554387b4, Offset: 0x375
// Size: 0x50
function shouldreload( task, params )
{
    assert( isdefined( params ) );
    
    if ( self.bulletsinclip > weaponclipsize( self.weapon ) * params )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace cover
// Params 1
// Checksum 0x6407085a, Offset: 0x3ce
// Size: 0xc
function terminatehide( task )
{
    
}

// Namespace cover
// Params 1
// Checksum 0x33ad6238, Offset: 0x3e2
// Size: 0x14c
function shouldchangestanceforfun( task )
{
    if ( !isdefined( self.enemy ) )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.rambochance ) && self.currentpose == "stand" )
    {
        return anim.failure;
    }
    
    if ( self.node.type != "Cover Right" && self.node.type != "Cover Left" )
    {
        return anim.failure;
    }
    
    if ( utility::isnodecover3d( self.node ) )
    {
        return anim.failure;
    }
    
    if ( self.currentpose == "stand" && !self.node doesnodeallowstance( "crouch" ) )
    {
        return anim.failure;
    }
    
    if ( self.currentpose == "crouch" && !self.node doesnodeallowstance( "stand" ) )
    {
        return anim.failure;
    }
    
    if ( !isdefined( self.coverchangestanceforfuntime ) )
    {
        setcoverchangestanceforfuntime();
    }
    
    if ( gettime() < self.coverchangestanceforfuntime )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace cover
// Params 0
// Checksum 0x64e3e7af, Offset: 0x537
// Size: 0x1a
function setcoverchangestanceforfuntime()
{
    self.coverchangestanceforfuntime = gettime() + randomintrange( 5000, 20000 );
}

// Namespace cover
// Params 1
// Checksum 0xa36d29f6, Offset: 0x559
// Size: 0xba, Type: bool
function hasroomtofullexposecorner( node )
{
    var_11acc36b8220813d = 36;
    checkpos = node.origin;
    
    if ( utility::isnodecoverright( node ) )
    {
        checkpos += anglestoright( node.angles ) * var_11acc36b8220813d;
    }
    else
    {
        checkpos += anglestoleft( node.angles ) * var_11acc36b8220813d;
    }
    
    if ( !self maymovecheckfriendlyfire( checkpos ) )
    {
        return false;
    }
    
    if ( !ispointonnavmesh( checkpos, self, 1 ) )
    {
        return false;
    }
    
    if ( !trace::capsule_trace_passed( node.origin, checkpos, 15, 36, ( 0, 0, 0 ), self, trace::create_character_contents() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace cover
// Params 1
// Checksum 0x5bb42773, Offset: 0x61c
// Size: 0x6e
function updatealwayscoverexposed( taskid )
{
    if ( self.balwayscoverexposed )
    {
        if ( self.health < self.maxhealth * 0.75 )
        {
            self.balwayscoverexposed = 0;
        }
        else if ( self._blackboard.scriptableparts.size >= 2 )
        {
            self.balwayscoverexposed = 0;
        }
    }
    
    return anim.success;
}

// Namespace cover
// Params 1
// Checksum 0x917a52b0, Offset: 0x693
// Size: 0x178
function updatecovercroucharrivaltype( taskid )
{
    if ( !isdefined( self.node ) || self.node.type != "Cover Crouch" )
    {
        self._blackboard.croucharrivaltype = undefined;
        self._blackboard.croucharrivalnode = undefined;
        return anim.success;
    }
    
    if ( !isdefined( self._blackboard.croucharrivaltype ) || self._blackboard.croucharrivalnode != self.node )
    {
        pathdisttogoal = self pathdisttogoal();
        
        if ( pathdisttogoal > 0 && pathdisttogoal < 512 )
        {
            covertype = getdvar( @"hash_f72dde9792b94cc9" );
            
            if ( isdefined( self.node.covercrouchtype ) )
            {
                covertype = self.node.covercrouchtype;
                
                if ( covertype != "Cover Right Crouch" && covertype != "Cover Left Crouch" && covertype != "Cover Crouch" )
                {
                    covertype = undefined;
                }
            }
            else if ( covertype == "" )
            {
                covertype = undefined;
            }
            
            self._blackboard.croucharrivalnode = self.node;
            self._blackboard.croucharrivaltype = covertype;
        }
    }
    
    return anim.success;
}

