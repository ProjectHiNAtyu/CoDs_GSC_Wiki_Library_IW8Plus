// scripts\asm\cap\interactions\cap_use_armor_plate_solo.gsc  (hash_1857592f79a8c5ba.gscc) (size: 1741 Bytes / 0x6cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf21022bd (4061143741)
// size ...... 1741 (0x6cd)
// includes .. 3   (offset: 0x651)
// strings ... 8   (offset: 0x669)
// dev strs .. 0   (offset: 0x6cd)
// exports ... 8   (offset: 0x37d)
// cseg ...... 0xba + 0x2c3 (0x37d)
// imports ... 14  (offset: 0x4bd)
// animtree1 . 0   (offset: 0x6cd)
// animtree2 . 0   (offset: 0x6cd)
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\utility;

#namespace cap_use_armor_plate_solo;

// Namespace cap_use_armor_plate_solo
// Params 3
// Checksum 0x2f562ce4, Offset: 0xd8
// Size: 0x47
function function_dc4deb370b43479a( asmname, statename, params )
{
    armoranim = asm_cap::cap_lookupanimfromalias( statename, self.armorplateinstance.animname );
    return armoranim;
}

// Namespace cap_use_armor_plate_solo
// Params 3
// Checksum 0xf5202914, Offset: 0x128
// Size: 0x55
function function_936e13c95e00bf94( asmname, statename, params )
{
    /#
        utility::issharedfuncdefined( #"ai", #"onusedarmorplate", 1 );
    #/
    
    utility::callsharedfunc( #"ai", #"onusedarmorplate" );
}

// Namespace cap_use_armor_plate_solo
// Params 3
// Checksum 0x825cc246, Offset: 0x185
// Size: 0x79, Type: bool
function function_5f5df041945f32bd( asmname, statename, params )
{
    if ( !self.armorplateinstance )
    {
        return true;
    }
    
    if ( self.health < self.armorplateinstance.var_6005996933d0a1cb - 75 )
    {
        return true;
    }
    
    covernode = asm_bb::bb_getcovernode();
    
    if ( covernode )
    {
        if ( self iscoverinvalidagainstenemy( covernode ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cap_use_armor_plate_solo
// Params 3
// Checksum 0xf546961f, Offset: 0x207
// Size: 0x35
function function_9116eb052e7d35a9( asmname, statename, params )
{
    self.armorplate_lastusetime = gettime();
    self.armorplateinstance = undefined;
}

// Namespace cap_use_armor_plate_solo
// Params 1, eflags: 0x4
// Checksum 0xaecc2554, Offset: 0x244
// Size: 0x3c
function private isrighthand( note )
{
    res = 1;
    hand = getsubstr( note, 7 );
    
    if ( hand == "left" )
    {
        res = 0;
    }
    
    return res;
}

// Namespace cap_use_armor_plate_solo
// Params 2, eflags: 0x4
// Checksum 0x3786256f, Offset: 0x289
// Size: 0x91
function private notehandler_armorplate( note, statename )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    scriptablepart = "armor_plate";
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isrighthand( note ) )
        {
            self setscriptablepartstate( scriptablepart, "active_right" );
        }
        else
        {
            self setscriptablepartstate( scriptablepart, "active_left" );
        }
        
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
}

// Namespace cap_use_armor_plate_solo
// Params 2
// Checksum 0x8f5ec30e, Offset: 0x322
// Size: 0x5b
function armorplatenotehandler( note, params )
{
    scriptablepart = "armor_plate";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        statename = self asmgetcurrentstate( self.asmname );
        notehandler_armorplate( note, statename );
    }
}

