// script_b51812471b3a7d1  (hash_0b51812471b3a7d1.gscc) (size: 925 Bytes / 0x39d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe47b5486 (3833287814)
// size ...... 925 (0x39d)
// includes .. 2   (offset: 0x36d)
// strings ... 1   (offset: 0x37d)
// dev strs .. 0   (offset: 0x39d)
// exports ... 5   (offset: 0x1dd)
// cseg ...... 0x79 + 0x164 (0x1dd)
// imports ... 7   (offset: 0x2a5)
// animtree1 . 0   (offset: 0x39d)
// animtree2 . 0   (offset: 0x39d)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace specialty_one_shot_protection;

// Namespace specialty_one_shot_protection
// Params 0, eflags: 0x1
// Checksum 0xdef26288, Offset: 0x97
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_a9880b06c12488e );
}

// Namespace specialty_one_shot_protection
// Params 1
// Checksum 0xd6143cf8, Offset: 0xb7
// Size: 0x54
function function_a9880b06c12488e( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_one_shot_protection", &setspecialty, undefined, [] );
    }
    
    utility::registersharedfunc( getxhash( "specialty_one_shot_protection" ), #"activate", &activateperk );
}

// Namespace specialty_one_shot_protection
// Params 0
// Checksum 0x82eb6a51, Offset: 0x113
// Size: 0x3b
function setspecialty()
{
    if ( !isdefined( self.var_773b81cf576594e5 ) )
    {
        self.var_773b81cf576594e5 = [];
    }
    
    self.var_773b81cf576594e5[ "specialty_one_shot_protection" ] = self.var_9842326056fd7207.ref;
}

// Namespace specialty_one_shot_protection
// Params 0
// Checksum 0x6657798d, Offset: 0x156
// Size: 0x87
function activateperk()
{
    if ( self.var_773b81cf576594e5[ "specialty_one_shot_protection" ] )
    {
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
        {
            utility::callsharedfunc( #"perk", #"notifyperkbuffactive", self.var_773b81cf576594e5[ "specialty_one_shot_protection" ] );
            return;
        }
        
        utility::callsharedfunc( #"perk", #"activatePerk", self.var_773b81cf576594e5[ "specialty_one_shot_protection" ] );
    }
}

