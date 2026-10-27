// script_4e61bde7b7486819  (hash_4e61bde7b7486819.gscc) (size: 1328 Bytes / 0x530 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9621e277 (2518803063)
// size ...... 1328 (0x530)
// includes .. 3   (offset: 0x4c4)
// strings ... 6   (offset: 0x4dc)
// dev strs .. 0   (offset: 0x530)
// exports ... 6   (offset: 0x2ec)
// cseg ...... 0xdd + 0x20f (0x2ec)
// imports ... 8   (offset: 0x3dc)
// animtree1 . 0   (offset: 0x530)
// animtree2 . 0   (offset: 0x530)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace specialty_reactive_armor;

// Namespace specialty_reactive_armor
// Params 0, eflags: 0x1
// Checksum 0x4142420c, Offset: 0xfb
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_reactive_armor
// Params 1
// Checksum 0xb6bc634b, Offset: 0x11b
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reactive_armor", &function_f24c08d254d02594, &function_3d3edcd90f2c9b9f, [] );
    }
}

// Namespace specialty_reactive_armor
// Params 0
// Checksum 0x62ed627e, Offset: 0x15d
// Size: 0x52
function function_f24c08d254d02594()
{
    armor = self.armorhealth ?? 0;
    maxarmor = self.maxarmorhealth ?? 150;
    self setclientomnvar( "ui_perk_reactive_armor_state", armor == maxarmor ? 0 : 1 );
    thread function_36839b0834cde89();
}

// Namespace specialty_reactive_armor
// Params 0
// Checksum 0x437de21b, Offset: 0x1b7
// Size: 0x1b
function function_3d3edcd90f2c9b9f()
{
    self notify( #"reactive_armor_perk_unset" );
    self setclientomnvar( "ui_perk_reactive_armor_state", -1 );
}

// Namespace specialty_reactive_armor
// Params 0
// Checksum 0xa6a9774b, Offset: 0x1da
// Size: 0x112
function function_36839b0834cde89()
{
    self endon( #"disconnect" );
    self endon( #"reactive_armor_perk_unset" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        notifytype = utility::waittill_any_return( "armor_regen_started", "armor_regen_complete", "damage", "damage_armor" );
        omnvarvalue = 0;
        
        if ( isdefined( notifytype ) )
        {
            switch ( notifytype )
            {
                case #"hash_346a583c12946f8":
                    omnvarvalue = 2;
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_reactive_armor" );
                    break;
                case #"hash_80b69a12d4ac5bd0":
                    omnvarvalue = 0;
                    break;
                case #"hash_1cc8a923a608c2a0":
                case #"hash_a7fb70c7609a558c":
                    var_24b912b48d3526b4 = self.var_ee47b71476db6956 ?? self.maxarmorhealth;
                    
                    if ( !( isdefined( self.armorhealth ) && isdefined( var_24b912b48d3526b4 ) ) || self.armorhealth >= var_24b912b48d3526b4 )
                    {
                        continue;
                    }
                    
                    omnvarvalue = 1;
                    break;
            }
        }
        
        self setclientomnvar( "ui_perk_reactive_armor_state", omnvarvalue );
    }
}

