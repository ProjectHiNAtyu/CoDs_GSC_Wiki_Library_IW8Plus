// scripts\mp\zm\systems\items\zm_item_armor.gsc  (hash_1bd0e23811fecd83.gscc) (size: 3649 Bytes / 0xe41 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b4b85a6 (1263240614)
// size ...... 3649 (0xe41)
// includes .. 7   (offset: 0xd59)
// strings ... 7   (offset: 0xd91)
// dev strs .. 3   (offset: 0xe1d)
// exports ... 8   (offset: 0x83d)
// cseg ...... 0x112 + 0x72b (0x83d)
// imports ... 32  (offset: 0x97d)
// animtree1 . 0   (offset: 0xe41)
// animtree2 . 0   (offset: 0xe41)
#using script_72d1ece3cbd0884a;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\challenges;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_armor;

#namespace zm_item_armor;

// Namespace zm_item_armor
// Params 0
// Checksum 0xcb2dcea, Offset: 0x130
// Size: 0x114
function init_item_armor()
{
    common_item::function_4b30c091d3b04a25( "armor" );
    common_item::function_84174b793b5fe9a7( "armor", #"use", &pickup_armor_plate );
    common_item::function_84174b793b5fe9a7( "armor", #"canautouse", &function_3aec8160a52506ca );
    common_item::function_84174b793b5fe9a7( "armor", #"hash_9e49dfaa7c147654", &function_3aec8160a52506ca );
    common_item::function_4b30c091d3b04a25( "health" );
    common_item::function_84174b793b5fe9a7( "health", #"use", &pickup_armor_plate );
    common_item::function_84174b793b5fe9a7( "health", #"canautouse", &function_3aec8160a52506ca );
    common_item::function_84174b793b5fe9a7( "health", #"hash_9e49dfaa7c147654", &function_3aec8160a52506ca );
    common_item::function_4b30c091d3b04a25( "plate_carrier" );
    common_item::function_84174b793b5fe9a7( "plate_carrier", #"use", &pickup_armor_vest );
    common_item::function_84174b793b5fe9a7( "plate_carrier", #"canautouse", &function_b9fa0b82b60375c4 );
    
    if ( getdvarint( @"hash_1a0aac3eab65ce39", 1 ) )
    {
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "armor" );
    }
}

// Namespace zm_item_armor
// Params 4
// Checksum 0x49fbb4a6, Offset: 0x24c
// Size: 0x3c, Type: bool
function pickup_armor_plate( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    armor::function_164c824617d7e8d7( 1 );
    return false;
}

// Namespace zm_item_armor
// Params 0, eflags: 0x4
// Checksum 0x51aebf68, Offset: 0x291
// Size: 0x104
function private can_replate()
{
    var_29f0796005cbd34b = armor::function_3988e68b87d5acc0() ?? 1;
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 125;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 300;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 669;
    var_76c67b4b8a9ef4da = 0;
    
    switch ( var_29f0796005cbd34b )
    {
        case 1:
            var_76c67b4b8a9ef4da = self.armorhealth == 0;
            break;
        case 2:
            var_e2560e7a98540207 = var_554023bac16105cf / 2;
            var_76c67b4b8a9ef4da = self.armorhealth <= var_e2560e7a98540207;
            break;
        case 3:
            var_e2560e7a98540207 = var_3dc0c4e27d22d986 / 3;
            var_76c67b4b8a9ef4da = self.armorhealth <= var_e2560e7a98540207;
            break;
    }
    
    return var_76c67b4b8a9ef4da;
}

// Namespace zm_item_armor
// Params 4
// Checksum 0xbf6ba5b3, Offset: 0x39e
// Size: 0x175
function function_3aec8160a52506ca( itembundle, item, auto_pickup, var_a0f59cb55797bb59 )
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    platecount = armor::function_22290101992e4874();
    
    if ( namespace_74c85f0ddf2d285f::function_426ebbae6d35dba6( 1 ) && platecount < armor::function_db9ebf086f67fe92() )
    {
        return 1;
    }
    
    if ( !auto_pickup )
    {
        if ( !namespace_74c85f0ddf2d285f::function_426ebbae6d35dba6( 1 ) )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
        }
        else if ( !( platecount < armor::function_db9ebf086f67fe92() ) )
        {
            /#
                iprintlnbold( "<dev string:x3a>" );
            #/
            
            if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_vulture_aid", #"vulture_aid_replate" ) )
            {
                var_93c50448f46cbfd1 = can_replate();
                
                if ( !self.var_ae30f86752261e5f && itembundle.ref == "equip_armorplate" && var_93c50448f46cbfd1 )
                {
                    use_armor_plate_on_ground( itembundle );
                    return 1;
                }
            }
        }
    }
    else if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_vulture_aid", #"vulture_aid_replate" ) )
    {
        var_93c50448f46cbfd1 = can_replate();
        
        if ( !self.var_ae30f86752261e5f && itembundle.ref == "equip_armorplate" && var_93c50448f46cbfd1 )
        {
            use_armor_plate_on_ground( itembundle );
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_item_armor
// Params 1
// Checksum 0x77bddeac, Offset: 0x51b
// Size: 0x185
function use_armor_plate_on_ground( itembundle )
{
    newarmorhealth = 0;
    
    if ( isdefined( level.var_6b5a5711823ede8c ) )
    {
        newarmorhealth = self [[ level.var_6b5a5711823ede8c ]]();
    }
    else
    {
        var_3b4517e2840c4873 = max( 1, armor::function_cb22658f54166b6b() );
        newarmorhealth = int( self.armorhealth + var_3b4517e2840c4873 );
    }
    
    if ( isdefined( self.pers[ "telemetry" ] ) && isdefined( self.pers[ "telemetry" ].armor_equipped ) )
    {
        self.pers[ "telemetry" ].armor_equipped++;
    }
    
    armor::setarmorhealth( newarmorhealth );
    currentcount = armor::function_22290101992e4874();
    newcount = maxint( 0, currentcount - 1 );
    armor::function_b359444c252374fc( newcount );
    challenges::function_4cfe18f48cc7a55c( self, undefined, level.armorref ?? "equip_armorplate" );
    
    if ( isdefined( self.armorapplied ) )
    {
        self.armorapplied += 1;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_fb0cbf750a27a0bc" ) )
    {
        utility::callsharedfunc( #"game", #"hash_fb0cbf750a27a0bc" );
    }
    
    callback::callback( #"hash_42a07c459e05796d" );
    
    if ( armor::getarmorhealth() == self.maxarmorhealth )
    {
        level notify( "equiped_full_armor_" + self.team, self );
    }
}

// Namespace zm_item_armor
// Params 4
// Checksum 0x139a71bd, Offset: 0x6a8
// Size: 0xba, Type: bool
function pickup_armor_vest( itembundle, item, autouse, var_981c264073bf1154 )
{
    armorlv = 1;
    
    switch ( itembundle.scriptable )
    {
        case #"hash_ec36834d7a645e41":
            armorlv = 1;
            break;
        case #"hash_ec36804d7a645988":
            armorlv = 2;
            break;
        case #"hash_ec36814d7a645b1b":
            armorlv = 3;
            break;
    }
    
    if ( isdefined( self.platecarrierlevel ) )
    {
        if ( armorlv > self.platecarrierlevel )
        {
            namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( armorlv );
        }
        else
        {
            namespace_74c85f0ddf2d285f::repair_armor( self.maxarmorhealth );
        }
    }
    
    return false;
}

// Namespace zm_item_armor
// Params 4
// Checksum 0x30a93651, Offset: 0x76b
// Size: 0xd2
function function_b9fa0b82b60375c4( itembundle, item, auto_pickup, var_a0f59cb55797bb59 )
{
    armorlv = 1;
    
    switch ( itembundle.scriptable )
    {
        case #"hash_ec36834d7a645e41":
            armorlv = 1;
            break;
        case #"hash_ec36804d7a645988":
            armorlv = 2;
            break;
        case #"hash_ec36814d7a645b1b":
            armorlv = 3;
            break;
    }
    
    if ( isdefined( self.platecarrierlevel ) )
    {
        if ( armorlv > self.platecarrierlevel )
        {
            return 1;
        }
        
        namespace_74c85f0ddf2d285f::repair_armor( self.maxarmorhealth );
        
        if ( !namespace_74c85f0ddf2d285f::has_full_armor() )
        {
            return 1;
        }
        
        /#
            iprintlnbold( "<dev string:x55>" );
        #/
        
        return 0;
    }
}

