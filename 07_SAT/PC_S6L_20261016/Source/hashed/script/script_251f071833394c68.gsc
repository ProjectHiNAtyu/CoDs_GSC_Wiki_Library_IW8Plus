// script_251f071833394c68  (hash_251f071833394c68.gscc) (size: 1759 Bytes / 0x6df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e103dc6 (2114993606)
// size ...... 1759 (0x6df)
// includes .. 1   (offset: 0x653)
// strings ... 11  (offset: 0x65b)
// dev strs .. 0   (offset: 0x6df)
// exports ... 6   (offset: 0x47f)
// cseg ...... 0x116 + 0x369 (0x47f)
// imports ... 8   (offset: 0x56f)
// animtree1 . 0   (offset: 0x6df)
// animtree2 . 0   (offset: 0x6df)
#using scripts\common\utility;

#namespace namespace_a2c34b6f27e5d4c0;

// Namespace namespace_a2c34b6f27e5d4c0
// Params 0, eflags: 0x1
// Checksum 0x48c9f910, Offset: 0x134
// Size: 0x32
function autoexec function_2ef3aea04ea8b661()
{
    if ( !isdefined( level.var_4cc1197dd650913a ) )
    {
        level.var_4cc1197dd650913a = [];
    }
    
    level.var_4cc1197dd650913a[ level.var_4cc1197dd650913a.size ] = &function_a37e9d415e584466;
}

// Namespace namespace_a2c34b6f27e5d4c0
// Params 0
// Checksum 0xfd7dd330, Offset: 0x16e
// Size: 0xcb
function function_a37e9d415e584466()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( self.model != "body_opforce_juggernaut_basebody" )
    {
        return;
    }
    
    if ( isdefined( level.var_ff3f2f5b40e913e ) )
    {
        [[ level.var_ff3f2f5b40e913e ]]( self );
    }
    
    function_3d43db1b4ec4ec95( "left_arm", 100, [ "left_arm_upper", "left_arm_lower", "left_hand" ] );
    function_3d43db1b4ec4ec95( "right_arm", 100, [ "right_arm_upper", "right_arm_lower", "right_hand" ] );
    
    if ( !isdefined( self.var_85111bb9ad8b0dba ) )
    {
        self.var_85111bb9ad8b0dba = [];
    }
    
    self.var_85111bb9ad8b0dba[ self.var_85111bb9ad8b0dba.size ] = &function_6fa1aea24290f3de;
}

// Namespace namespace_a2c34b6f27e5d4c0
// Params 13, eflags: 0x4
// Checksum 0x2b14c0d7, Offset: 0x241
// Size: 0x8a
function private function_6fa1aea24290f3de( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname )
{
    function_fc4a7aeb5190a46f( self.damagelocation, idamage );
}

// Namespace namespace_a2c34b6f27e5d4c0
// Params 3, eflags: 0x4
// Checksum 0x42ab1919, Offset: 0x2d3
// Size: 0xf8
function private function_3d43db1b4ec4ec95( name, health, parts )
{
    data = spawnstruct();
    data.health = health;
    data.var_dbf6a757b9c79abd = 0;
    
    if ( !isdefined( self.damagedata ) )
    {
        self.damagedata = [];
    }
    
    self.damagedata[ name ] = data;
    
    if ( !isdefined( self.var_31f42eb699b146dd ) )
    {
        self.var_31f42eb699b146dd = [];
    }
    
    foreach ( part in parts )
    {
        self.var_31f42eb699b146dd[ part ] = name;
    }
}

// Namespace namespace_a2c34b6f27e5d4c0
// Params 2, eflags: 0x4
// Checksum 0x23b0c438, Offset: 0x3d3
// Size: 0xac
function private function_fc4a7aeb5190a46f( location, dmg )
{
    if ( !isdefined( self.var_31f42eb699b146dd[ location ] ) )
    {
        return;
    }
    
    name = self.var_31f42eb699b146dd[ location ];
    data = self.damagedata[ name ];
    data.health -= dmg;
    
    if ( data.health <= 0 && !data.var_dbf6a757b9c79abd )
    {
        self setscriptablepartstate( name, "dmg", 1 );
        data.var_dbf6a757b9c79abd = 1;
    }
}

