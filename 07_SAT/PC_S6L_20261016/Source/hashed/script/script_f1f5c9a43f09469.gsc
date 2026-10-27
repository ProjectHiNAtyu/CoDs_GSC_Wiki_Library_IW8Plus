// script_f1f5c9a43f09469  (hash_0f1f5c9a43f09469.gscc) (size: 1467 Bytes / 0x5bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5b833ac6 (1535326918)
// size ...... 1467 (0x5bb)
// includes .. 2   (offset: 0x58b)
// strings ... 2   (offset: 0x59b)
// dev strs .. 0   (offset: 0x5bb)
// exports ... 8   (offset: 0x35f)
// cseg ...... 0x6d + 0x2f2 (0x35f)
// imports ... 8   (offset: 0x49f)
// animtree1 . 0   (offset: 0x5bb)
// animtree2 . 0   (offset: 0x5bb)
#using scripts\asm\asm;
#using scripts\common\ai;

#namespace libra_mech_asm;

// Namespace libra_mech_asm
// Params 3
// Checksum 0x1baaec0b, Offset: 0x8b
// Size: 0x54
function function_69a31b41760ca357( asmname, statename, params )
{
    if ( self.var_3931e86a9ecb52f6 )
    {
        return;
    }
    
    self.var_3931e86a9ecb52f6 = 1;
    self.animname = self.animsetname;
    asm::function_d82cb83c9c260d49( 1 );
}

// Namespace libra_mech_asm
// Params 4
// Checksum 0xb7ce76e3, Offset: 0xe7
// Size: 0xa3, Type: bool
function shouldturnaround( asmname, statename, tostatename, params )
{
    path = self getpath( 1 );
    
    if ( isdefined( path ) && path.size > 1 && !ai::is_doing_traversal( self ) )
    {
        forward = anglestoforward( self.angles );
        
        if ( vectordot2( forward, path[ 0 ] - self.origin ) < 0 && vectordot2( forward, path[ 1 ] - self.origin ) < 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace libra_mech_asm
// Params 4
// Checksum 0x7766154, Offset: 0x193
// Size: 0x49, Type: bool
function function_c65472fa0768168c( asmname, statename, tostatename, params )
{
    return ( self.var_3cc8731d810f2b1a || self.var_be370ee8d86e6772 ) && !ai::is_doing_traversal( self );
}

// Namespace libra_mech_asm
// Params 3
// Checksum 0x31680752, Offset: 0x1e5
// Size: 0x4e
function function_ed06c8130cf7890a( asmname, statename, params )
{
    if ( self.var_3cc8731d810f2b1a )
    {
        alias = "center";
    }
    else
    {
        alias = "default";
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace libra_mech_asm
// Params 3
// Checksum 0xb6aafdf3, Offset: 0x23c
// Size: 0x72
function jumpteleport( asmname, statename, params )
{
    if ( !isdefined( self.var_21cbe54bf8835bf7 ) )
    {
        self.var_21cbe54bf8835bf7 = self.angles;
    }
    
    self dontinterpolate();
    self forceteleport( self.var_aa3cf41f66a0769 + ( 0, 0, 3000 ), self.var_21cbe54bf8835bf7 );
    self.var_21cbe54bf8835bf7 = undefined;
}

// Namespace libra_mech_asm
// Params 3
// Checksum 0xd6a55082, Offset: 0x2b6
// Size: 0x62
function function_94080bc01c488693( asmname, statename, params )
{
    if ( self.var_3cc8731d810f2b1a )
    {
        alias = "center";
    }
    else
    {
        alias = "default";
    }
    
    self.var_3cc8731d810f2b1a = undefined;
    self.var_be370ee8d86e6772 = undefined;
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace libra_mech_asm
// Params 3
// Checksum 0x64f1eda9, Offset: 0x321
// Size: 0x3e
function function_96a8ebc7db69ed4( asmname, statename, params )
{
    self.var_3cc8731d810f2b1a = undefined;
    self.var_be370ee8d86e6772 = undefined;
    self notify( #"hash_75719fa2fd6584eb" );
}

