// script_5bdaa01dd1405ccb  (hash_5bdaa01dd1405ccb.gscc) (size: 925 Bytes / 0x39d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd041b9ed (3493968365)
// size ...... 925 (0x39d)
// includes .. 3   (offset: 0x365)
// strings ... 1   (offset: 0x37d)
// dev strs .. 0   (offset: 0x39d)
// exports ... 5   (offset: 0x1bd)
// cseg ...... 0x72 + 0x14b (0x1bd)
// imports ... 8   (offset: 0x285)
// animtree1 . 0   (offset: 0x39d)
// animtree2 . 0   (offset: 0x39d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\perks\perks;

#namespace specialty_emp_immunity;

// Namespace specialty_emp_immunity
// Params 0, eflags: 0x1
// Checksum 0x227ee211, Offset: 0x90
// Size: 0x23
function autoexec preinit()
{
    level.var_60698a0462b4bdcc = 1;
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_emp_immunity
// Params 1
// Checksum 0xf65646d5, Offset: 0xbb
// Size: 0x54
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_emp_immunity", &setspecialty, undefined, [] );
    }
    
    utility::registersharedfunc( getxhash( "specialty_emp_immunity" ), #"activate", &activateperk );
}

// Namespace specialty_emp_immunity
// Params 0
// Checksum 0xb3011d6b, Offset: 0x117
// Size: 0x3b
function setspecialty()
{
    if ( !isdefined( self.var_773b81cf576594e5 ) )
    {
        self.var_773b81cf576594e5 = [];
    }
    
    self.var_773b81cf576594e5[ "specialty_emp_immunity" ] = self.var_9842326056fd7207.ref;
}

// Namespace specialty_emp_immunity
// Params 0
// Checksum 0x1eb3a490, Offset: 0x15a
// Size: 0x63
function activateperk()
{
    if ( self.var_773b81cf576594e5[ "specialty_emp_immunity" ] )
    {
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
        {
            perks::function_142df1226093bce0( self.var_773b81cf576594e5[ "specialty_emp_immunity" ] );
            return;
        }
        
        perks::activateperk( self.var_773b81cf576594e5[ "specialty_emp_immunity" ] );
    }
}

