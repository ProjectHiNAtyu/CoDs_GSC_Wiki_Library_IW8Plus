// script_25f84025e38b6b00  (hash_25f84025e38b6b00.gscc) (size: 3470 Bytes / 0xd8e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46328067 (1177714791)
// size ...... 3470 (0xd8e)
// includes .. 5   (offset: 0xcde)
// strings ... 7   (offset: 0xd06)
// dev strs .. 0   (offset: 0xd8e)
// exports ... 7   (offset: 0x93e)
// cseg ...... 0xfc + 0x842 (0x93e)
// imports ... 21  (offset: 0xa56)
// animtree1 . 0   (offset: 0xd8e)
// animtree2 . 0   (offset: 0xd8e)
#using script_16ea1b94f0f381b3;
#using script_5adc0ee463b8a974;
#using scripts\common\callbacks;
#using scripts\mp\equipment;
#using scripts\mp\flags;

#namespace specialty_recharge_equipment;

// Namespace specialty_recharge_equipment
// Params 0, eflags: 0x1
// Checksum 0x6e9695c7, Offset: 0x11a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_3684e778e70b61e0 );
}

// Namespace specialty_recharge_equipment
// Params 1
// Checksum 0x6d9e313, Offset: 0x13a
// Size: 0x5a
function function_3684e778e70b61e0( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_recharge_equipment", &setrechargeequipment, &unsetrechargeequipment, [] );
    }
    
    level.var_da3017a94abb375a = [ "secondary":"ui_tactical_recharge_progress", "primary":"ui_lethal_recharge_progress" ];
}

// Namespace specialty_recharge_equipment
// Params 0
// Checksum 0xef87f2e0, Offset: 0x19c
// Size: 0x204
function setrechargeequipment()
{
    bundle = self.var_9842326056fd7207;
    self.var_c06cf1623ae724a1 = bundle.var_646afa4cf4b10c27 ?? 0;
    
    if ( !isdefined( self.var_a9612a64bc77e7b8 ) )
    {
        self.var_a9612a64bc77e7b8 = [ "secondary":bundle.var_68519be84af60f28 ?? 25, "primary":bundle.var_e8920d9a063ece14 ?? 25 ];
    }
    
    self.var_1669c8a5000552b2 = [];
    function_2d4f86ad22f7f0ff( "primary" );
    function_2d4f86ad22f7f0ff( "secondary" );
    
    if ( isdefined( bundle.var_bcf57c0388ddf308 ) )
    {
        self.var_4966ac91e830beb3 = [];
        
        foreach ( entry in bundle.var_bcf57c0388ddf308 )
        {
            self.var_4966ac91e830beb3[ self.var_4966ac91e830beb3.size ] = entry.ref;
        }
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    thread function_ee584be788fa1a0d( "primary" );
    thread function_ee584be788fa1a0d( "secondary" );
    var_62d0c6995bb99aa8 = bundle.var_3035c888d8eb5f0e ?? 1;
    var_a057a273b9196da3 = bundle.var_c6f0f71446fe3b09 ?? 1;
    
    if ( var_62d0c6995bb99aa8 > 1 && isdefined( self.var_1669c8a5000552b2[ "primary" ] ) )
    {
        self.var_1669c8a5000552b2[ "primary" ].var_1c4417344bcab061 = var_62d0c6995bb99aa8;
    }
    
    if ( var_a057a273b9196da3 > 1 && isdefined( self.var_1669c8a5000552b2[ "secondary" ] ) )
    {
        self.var_1669c8a5000552b2[ "secondary" ].var_1c4417344bcab061 = var_a057a273b9196da3;
    }
}

// Namespace specialty_recharge_equipment
// Params 1
// Checksum 0x53573170, Offset: 0x3a8
// Size: 0x47
function function_2d4f86ad22f7f0ff( slot )
{
    self.var_1669c8a5000552b2[ slot ] = { #hasincremented:0, #recharged:1, #progress:1, #rechargestart:gettime() };
}

// Namespace specialty_recharge_equipment
// Params 0
// Checksum 0x86312ab6, Offset: 0x3f7
// Size: 0x4e
function unsetrechargeequipment()
{
    self.var_a9612a64bc77e7b8 = undefined;
    self.var_1669c8a5000552b2 = undefined;
    self setclientomnvar( level.var_da3017a94abb375a[ "primary" ], 0 );
    self setclientomnvar( level.var_da3017a94abb375a[ "secondary" ], 0 );
    self notify( #"hash_7d10939ae27fe05d" );
}

// Namespace specialty_recharge_equipment
// Params 1
// Checksum 0x7c62eb8d, Offset: 0x44d
// Size: 0x4f1
function function_ee584be788fa1a0d( slot )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_7d10939ae27fe05d" );
    
    while ( isdefined( self.var_a9612a64bc77e7b8 ) )
    {
        equipment = equipment_mp::getcurrentequipment( slot );
        
        if ( !isdefined( equipment ) || isdefined( self.var_4966ac91e830beb3 ) && arraycontains( self.var_4966ac91e830beb3, equipment ) )
        {
            wait 0.5;
            continue;
        }
        
        equipbundle = equipment_mp::function_c90a9aa89b223dd7( equipment );
        
        if ( isdefined( equipbundle ) && isdefined( equipbundle.var_16f36ee7235858b7 ) && equipbundle.var_16f36ee7235858b7 || gunfight_loadouts::function_2c1d142864561f9a( equipment ) )
        {
            wait 0.5;
            continue;
        }
        
        ammo = equipment_mp::getequipmentammo( equipment );
        ammomax = equipment_mp::getequipmentmaxammo( equipment );
        startammo = equipment_mp::getequipmentstartammo( equipment );
        
        if ( ammo >= ammomax )
        {
            self.var_1669c8a5000552b2[ slot ].recharged = 1;
            
            if ( self.var_c06cf1623ae724a1 )
            {
                self.var_1669c8a5000552b2[ slot ].progress = 0;
                self setclientomnvar( level.var_da3017a94abb375a[ slot ], self.var_1669c8a5000552b2[ slot ].progress );
            }
            
            wait 0.5;
            continue;
        }
        
        if ( self.var_1669c8a5000552b2[ slot ].recharged && ammo < ammomax )
        {
            self.var_1669c8a5000552b2[ slot ].rechargestart = gettime();
        }
        
        self.var_1669c8a5000552b2[ slot ].recharged = 0;
        
        while ( !self.var_1669c8a5000552b2[ slot ].recharged )
        {
            var_5a6445a7ac8618ea = equipment_mp::getcurrentequipment( slot );
            
            if ( isdefined( self.var_4966ac91e830beb3 ) && arraycontains( self.var_4966ac91e830beb3, var_5a6445a7ac8618ea ) )
            {
                self.var_1669c8a5000552b2[ slot ].paused = 1;
                self setclientomnvar( level.var_da3017a94abb375a[ slot ], 0 );
                break;
            }
            else
            {
                self.var_1669c8a5000552b2[ slot ].paused = 0;
            }
            
            if ( !self.var_1669c8a5000552b2[ slot ].paused )
            {
                rechargetime = gettime() - self.var_1669c8a5000552b2[ slot ].rechargestart;
                var_daefa8aa7dba1af2 = isdefined( self.var_1669c8a5000552b2[ slot ].var_1c4417344bcab061 ) && ammo == startammo && !self.var_1669c8a5000552b2[ slot ].hasincremented;
                
                if ( var_daefa8aa7dba1af2 )
                {
                    rechargetime *= self.var_1669c8a5000552b2[ slot ].var_1c4417344bcab061;
                }
                
                timepercent = rechargetime / self.var_a9612a64bc77e7b8[ slot ] * 1000;
                self.var_1669c8a5000552b2[ slot ].progress = min( timepercent, 1 );
                self setclientomnvar( level.var_da3017a94abb375a[ slot ], self.var_1669c8a5000552b2[ slot ].progress );
                self setpowerprogress( slot, self.var_1669c8a5000552b2[ slot ].progress );
                
                if ( self.var_1669c8a5000552b2[ slot ].progress >= 1 )
                {
                    if ( isdefined( self.perks[ "specialty_quartermaster" ] ) )
                    {
                        namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_quartermaster" );
                    }
                    
                    equipment_mp::incrementequipmentslotammo( slot, 1 );
                    self.var_1669c8a5000552b2[ slot ].rechargestart = gettime();
                    ammo = equipment_mp::getequipmentammo( equipment );
                    self.var_1669c8a5000552b2[ slot ].recharged = ammo >= ammomax;
                    self.var_1669c8a5000552b2[ slot ].hasincremented = 1;
                }
                else
                {
                    current_ammo = equipment_mp::getequipmentammo( equipment );
                    max_ammo = equipment_mp::getequipmentmaxammo( equipment );
                    
                    if ( current_ammo >= max_ammo )
                    {
                        if ( isdefined( self.var_1669c8a5000552b2[ slot ] ) )
                        {
                            self.var_1669c8a5000552b2[ slot ].recharged = 1;
                            
                            if ( self.var_c06cf1623ae724a1 )
                            {
                                self.var_1669c8a5000552b2[ slot ].progress = 0;
                                self setclientomnvar( level.var_da3017a94abb375a[ slot ], self.var_1669c8a5000552b2[ slot ].progress );
                            }
                        }
                    }
                }
            }
            
            if ( !self.var_1669c8a5000552b2[ slot ].recharged )
            {
                waitframe();
            }
        }
    }
}

