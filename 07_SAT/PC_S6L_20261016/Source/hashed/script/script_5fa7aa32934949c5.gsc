// script_5fa7aa32934949c5  (hash_5fa7aa32934949c5.gscc) (size: 2030 Bytes / 0x7ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7aa2a10 (3886688784)
// size ...... 2030 (0x7ee)
// includes .. 3   (offset: 0x7a6)
// strings ... 4   (offset: 0x7be)
// dev strs .. 0   (offset: 0x7ee)
// exports ... 8   (offset: 0x4ca)
// cseg ...... 0xce + 0x3fc (0x4ca)
// imports ... 14  (offset: 0x60a)
// animtree1 . 0   (offset: 0x7ee)
// animtree2 . 0   (offset: 0x7ee)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace specialty_armor_regen;

// Namespace specialty_armor_regen
// Params 0, eflags: 0x1
// Checksum 0x36b98628, Offset: 0xec
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_armor_regen
// Params 1
// Checksum 0xff8e82ab, Offset: 0x10c
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_armor_regen", &function_8de50785457213ba, &function_eec932d6a477d4af, [] );
    }
}

// Namespace specialty_armor_regen
// Params 0
// Checksum 0x875946a6, Offset: 0x14e
// Size: 0x55
function function_8de50785457213ba()
{
    bundle = self.var_9842326056fd7207;
    thread function_7fd14fe74b7ef105( bundle.armorregendelay, bundle.armorregenrate, bundle.var_84574b96eb657842, bundle.var_855998db3002fca8, bundle.var_45b7c6d0545de9cd );
}

// Namespace specialty_armor_regen
// Params 0
// Checksum 0x2e9004ea, Offset: 0x1ab
// Size: 0x18
function function_eec932d6a477d4af()
{
    self notify( #"armor_regen_end" );
    self.var_ee47b71476db6956 = undefined;
}

// Namespace specialty_armor_regen
// Params 5, eflags: 0x4
// Checksum 0x51fe5e6e, Offset: 0x1cb
// Size: 0xf7
function private function_7fd14fe74b7ef105( regendelay, regenrate, regenamount, captype, capvalue )
{
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    self endon( #"armor_regen_end" );
    
    if ( isdefined( self.armorhealth ) && isdefined( self.maxarmorhealth ) )
    {
        childthread function_7cc6ec1dd8529f82( regendelay, regenrate, regenamount, captype, capvalue );
    }
    
    while ( true )
    {
        utility::waittill_any( "damage", "damage_armor", "last_stand_finished" );
        
        if ( !( isdefined( self.armorhealth ) && isdefined( self.maxarmorhealth ) ) || self.inlaststand )
        {
            continue;
        }
        
        function_5ea6aa63c8f38ded( captype, capvalue );
        
        if ( self.armorhealth >= self.var_ee47b71476db6956 )
        {
            continue;
        }
        
        childthread function_7cc6ec1dd8529f82( regendelay, regenrate, regenamount, captype, capvalue );
        waitframe();
    }
}

// Namespace specialty_armor_regen
// Params 5, eflags: 0x4
// Checksum 0x6cf11b51, Offset: 0x2ca
// Size: 0x102
function private function_7cc6ec1dd8529f82( regendelay, regenrate, regenamount, captype, capvalue )
{
    self notify( #"armor_regen_begin" );
    self endon( #"armor_regen_begin" );
    self endon( #"armor_regen_complete" );
    
    if ( !isdefined( regendelay ) )
    {
        regendelay = getdvarfloat( @"scr_armor_regen_delay", 2.3 );
    }
    
    if ( !isdefined( regenrate ) )
    {
        regenrate = getdvarfloat( @"scr_armor_regen_rate", 0.175 );
    }
    
    if ( !isdefined( regenamount ) )
    {
        regenamount = getdvarint( @"scr_armor_regen_amount", 1 );
    }
    
    function_5ea6aa63c8f38ded( captype, capvalue );
    wait regendelay;
    self notify( #"armor_regen_started" );
    
    while ( true )
    {
        if ( self.armorhealth >= self.var_ee47b71476db6956 || self.inlaststand )
        {
            self notify( #"armor_regen_complete" );
        }
        
        armor::setarmorhealth( self.armorhealth + regenamount );
        wait regenrate;
    }
}

// Namespace specialty_armor_regen
// Params 2, eflags: 0x4
// Checksum 0x9d9a75e7, Offset: 0x3d4
// Size: 0xf6
function private function_5ea6aa63c8f38ded( captype, capvalue )
{
    if ( captype && isdefined( capvalue ) )
    {
        switch ( captype )
        {
            case #"hash_f764e81c86d1a274":
                cap = min( capvalue, self.maxarmorhealth );
                break;
            case #"hash_7c7c0cdffe207815":
                cap = min( capvalue / 100 * self.maxarmorhealth, self.maxarmorhealth );
                break;
            case #"hash_9662a5dbe1fadf4":
                if ( level.var_1bfbe247e8d32b1b && level.var_1bfbe247e8d32b1b >= 0 )
                {
                    cap = min( level.var_1bfbe247e8d32b1b * capvalue, self.maxarmorhealth );
                }
                
                break;
        }
    }
    
    self.var_ee47b71476db6956 = isdefined( cap ) ? int( clamp( cap, 0, self.maxarmorhealth ) ) : self.maxarmorhealth;
}

