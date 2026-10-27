// script_5cecb9996007959  (hash_05cecb9996007959.gscc) (size: 2986 Bytes / 0xbaa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40d3c3d8 (1087620056)
// size ...... 2986 (0xbaa)
// includes .. 3   (offset: 0xabe)
// strings ... 14  (offset: 0xad6)
// dev strs .. 3   (offset: 0xb86)
// exports ... 8   (offset: 0x68a)
// cseg ...... 0x1e1 + 0x4a9 (0x68a)
// imports ... 27  (offset: 0x7ca)
// animtree1 . 0   (offset: 0xbaa)
// animtree2 . 0   (offset: 0xbaa)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\cap;

#namespace use_armor_plate_solo;

// Namespace use_armor_plate_solo
// Params 1
// Checksum 0x99ad3982, Offset: 0x1ff
// Size: 0x80
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_902f9e79d5e57c83":
            return &oneventreceived;
        case #"hash_1637227a26307eb5":
            return &setstationary;
        case #"hash_6279e013ab5c4fdd":
            return &usearmorplate;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace use_armor_plate_solo
// Params 1
// Checksum 0xc98f661d, Offset: 0x287
// Size: 0x1ba
function onuserinit( interactionid )
{
    self.armorplateinstance = spawnstruct();
    self.armorplateinstance.id = interactionid;
    self.armorplateinstance.stance = asm_bb::bb_getrequestedstance();
    self.armorplateinstance.coverstate = asm_bb::bb_getrequestedcoverstate();
    self.armorplateinstance.animname = "default";
    self.armorplateinstance.var_6005996933d0a1cb = self.health;
    
    if ( self.armorplateinstance.coverstate == "exposed" )
    {
        self.armorplateinstance.animname = "exposed_" + self.armorplateinstance.stance;
        return;
    }
    
    covernode = asm_bb::bb_getcovernode();
    
    if ( isdefined( covernode ) )
    {
        covertype = covernode.type;
        
        switch ( covertype )
        {
            case #"hash_cd3ffe799551db82":
                animname = "cover_right_" + self.armorplateinstance.stance;
                break;
            case #"hash_e1d8e1adebed5a61":
                animname = "cover_left_" + self.armorplateinstance.stance;
                break;
            case #"hash_c3b74422dec48736":
                animname = "cover_crouch";
                break;
            case #"hash_78b110033ccb68b0":
                animname = "cover_stand";
                break;
        }
        
        self.armorplateinstance.animname = animname;
    }
}

// Namespace use_armor_plate_solo
// Params 1
// Checksum 0x5ac5d52f, Offset: 0x449
// Size: 0xa0
function onuserterminate( interactionid )
{
    self clearbtgoal( 1 );
    self notify( #"hash_d88e44832873b6d8" );
    
    /#
        if ( isagent( self ) )
        {
            assert( self isscriptable(), "<dev string:x42>" + self.agent_type + "<dev string:x4f>" );
        }
    #/
    
    scriptablepart = "armor_plate";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
    
    if ( isalive( self ) && self.asmname == "cap_use_armor_plate_solo" )
    {
        cap::cap_exit();
    }
}

// Namespace use_armor_plate_solo
// Params 3
// Checksum 0x7b296929, Offset: 0x4f1
// Size: 0x6f, Type: bool
function oneventreceived( receiver, info, origin )
{
    if ( info == "focused_on" )
    {
        distsq = distancesquared( receiver.origin, origin );
        breakoutdist = 640;
        
        if ( distsq < breakoutdist * breakoutdist )
        {
            self notify( #"hash_d88e44832873b6d8" );
            return true;
        }
        
        return true;
    }
    
    return false;
}

// Namespace use_armor_plate_solo
// Params 2
// Checksum 0x96144a0d, Offset: 0x569
// Size: 0x28
function setstationary( statename, params )
{
    self setbtgoalstationary( 1 );
    self setbtgoalradius( 1, params[ 0 ] );
}

// Namespace use_armor_plate_solo
// Params 2
// Checksum 0x9180eaf1, Offset: 0x599
// Size: 0x85
function usearmorplate( statename, params )
{
    self endon( #"death" );
    self endon( #"hash_d88e44832873b6d8" );
    capname = "cap_use_armor_plate_solo";
    
    if ( self.asmname != capname )
    {
        cap::cap_start( capname, "caps/interactions/cap_use_armor_plate_solo" );
    }
    
    tempdialogue( "Using Armor Plate!" );
    self waittill( #"cap_exit_completed" );
    asm::asm_fireephemeralevent( "use_armor_plate", "end" );
}

// Namespace use_armor_plate_solo
// Params 1
// Checksum 0x5bf96132, Offset: 0x626
// Size: 0x64
function tempdialogue( var_4f6c17e0baa01798 )
{
    debug = getdvarint( @"hash_3e267ec6e066e2b", 0 );
    
    if ( debug )
    {
        /#
            print3d( self.origin + ( 0, 0, 80 ), var_4f6c17e0baa01798, ( 1, 1, 1 ), 1, 0.8, 1, 1 );
        #/
    }
}

