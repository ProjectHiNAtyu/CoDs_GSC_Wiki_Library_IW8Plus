// scripts\mp\ob\systems\ob_armor.gsc  (hash_648849bfc50f87f8.gscc) (size: 4525 Bytes / 0x11ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x208532f3 (545600243)
// size ...... 4525 (0x11ad)
// includes .. 4   (offset: 0x10cd)
// strings ... 7   (offset: 0x10ed)
// dev strs .. 9   (offset: 0x1141)
// exports ... 13  (offset: 0xab1)
// cseg ...... 0xc9 + 0x9e8 (0xab1)
// imports ... 34  (offset: 0xcb9)
// animtree1 . 0   (offset: 0x11ad)
// animtree2 . 0   (offset: 0x11ad)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace ob_armor;

// Namespace ob_armor
// Params 0
// Checksum 0x187ae3d9, Offset: 0xe7
// Size: 0xb2
function function_2d66dd9e5865a2ac()
{
    level.var_6f8b7a2e996178a8 = &armor_damage_absorbed;
    level.var_21038aca0aba3c4a = &function_a3b392801472f91b;
    utility::registersharedfunc( #"ob_armor", #"hash_75b5b42c6344be70", &function_fdbe2cad6d8bb7e7 );
    utility::registersharedfunc( #"ob_armor", #"set_golden_armor", &set_golden_armor );
    
    if ( isdefined( level.gamemodebundle.armormetadata ) )
    {
        level.var_1e9e024bcfca2274 = getscriptbundle( level.gamemodebundle.armormetadata );
    }
    
    level callback::add( #"player_spawned", &ob_armor_onplayerspawn );
    
    /#
        level thread setup_armor_devgui();
    #/
}

// Namespace ob_armor
// Params 1
// Checksum 0x188528a8, Offset: 0x1a1
// Size: 0x69
function ob_armor_onplayerspawn( params )
{
    if ( self.activeskills && isdefined( self.activeskills[ #"armor_upgrade" ] ) )
    {
        return;
    }
    
    var_cd17cbf06d9d82db = 1;
    
    if ( level.var_1e9e024bcfca2274 )
    {
        var_cd17cbf06d9d82db = level.var_1e9e024bcfca2274.var_794dfc5af7dde3a0;
    }
    
    function_fdbe2cad6d8bb7e7( var_cd17cbf06d9d82db );
}

// Namespace ob_armor
// Params 0
// Checksum 0x214d8806, Offset: 0x212
// Size: 0x1b
function set_golden_armor()
{
    self.var_a1faa64d8c07872e = 1;
    thread function_f43fdb9de37faade();
    armor::setarmoromnvars();
}

// Namespace ob_armor
// Params 0
// Checksum 0xbc9faa33, Offset: 0x235
// Size: 0x13
function take_golden_armor()
{
    self.var_a1faa64d8c07872e = undefined;
    armor::setarmoromnvars();
}

// Namespace ob_armor
// Params 0
// Checksum 0x9b5b3fc4, Offset: 0x250
// Size: 0xbf
function function_f43fdb9de37faade()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_9450940fefbe79c8 = 0;
    
    while ( self.var_a1faa64d8c07872e )
    {
        if ( self.var_9450940fefbe79c8 > 0 )
        {
            self.var_9450940fefbe79c8--;
        }
        
        if ( self.var_9450940fefbe79c8 <= 0 )
        {
            self.var_9450940fefbe79c8 = 4;
            
            if ( self.armorhealth < self.maxarmorhealth )
            {
                var_12454f0b928bc1d6 = armor::getarmorhealth();
                var_12454f0b928bc1d6 += int( self.maxarmorhealth / 3 );
                armor::setarmorhealth( var_12454f0b928bc1d6 );
                self playsoundevent( %"sndevent_golden_armor_restore" );
            }
        }
        
        wait 1;
    }
}

// Namespace ob_armor
// Params 1
// Checksum 0x67122d92, Offset: 0x317
// Size: 0x1f2
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    self.platecarrierlevel = platecarrierlevel;
    self setclientomnvar( "ui_armor_current_level", clampint( platecarrierlevel, 0, 4 ) );
    
    switch ( platecarrierlevel )
    {
        case 0:
            self.maxarmorhealth = 0;
            armor::setarmorhealth( 0 );
            break;
        case 1:
            var_219886ad4a381968 = getdvarint( @"hash_c0deae0adc8136f9", level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 50 );
            self.maxarmorhealth = var_219886ad4a381968;
            armor::setarmorhealth( var_219886ad4a381968 );
            break;
        case 2:
            var_554023bac16105cf = getdvarint( @"hash_37c039735cba1f8", level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 100 );
            self.maxarmorhealth = var_554023bac16105cf;
            armor::setarmorhealth( var_554023bac16105cf );
            break;
        case 3:
            var_3dc0c4e27d22d986 = getdvarint( @"hash_8b3740e182a1c6af", level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 150 );
            self.maxarmorhealth = var_3dc0c4e27d22d986;
            armor::setarmorhealth( var_3dc0c4e27d22d986 );
            break;
        case 4:
            var_ebc1310bae8b1d5d = getdvarint( @"hash_ce16f951c75a8546", level.var_1e9e024bcfca2274.var_d3a037973d3c7eff ?? 200 );
            self.maxarmorhealth = var_ebc1310bae8b1d5d;
            armor::setarmorhealth( var_ebc1310bae8b1d5d );
            break;
        case 5:
            var_9ae765580ae40194 = getdvarint( @"hash_c06e198383551f05", level.var_1e9e024bcfca2274.var_e09a37658082c508 ?? 250 );
            self.maxarmorhealth = var_9ae765580ae40194;
            armor::setarmorhealth( var_9ae765580ae40194 );
            break;
    }
}

// Namespace ob_armor
// Params 4
// Checksum 0xab5ce5ae, Offset: 0x511
// Size: 0x2a2
function armor_damage_absorbed( damage, eattacker, einflictor, smeansofdeath )
{
    self.var_9450940fefbe79c8 = 4;
    
    if ( level.var_1e9e024bcfca2274 )
    {
        var_75f25266eb889f8e = 1;
        
        if ( self.platecarrierlevel )
        {
            switch ( self.platecarrierlevel )
            {
                case 1:
                    var_75f25266eb889f8e = getdvarfloat( @"hash_198f1abc65fbb598", level.var_1e9e024bcfca2274.var_6e36edafe33fcbbd ?? 1 );
                    break;
                case 2:
                    var_75f25266eb889f8e = getdvarfloat( @"hash_cc828d4fa704b049", level.var_1e9e024bcfca2274.var_e1ccf0a99db550c ?? 1 );
                    break;
                case 3:
                    var_75f25266eb889f8e = getdvarfloat( @"hash_f89e56b9910206b2", level.var_1e9e024bcfca2274.var_28630d21f2687b7b ?? 1 );
                    break;
                case 4:
                    var_75f25266eb889f8e = getdvarfloat( @"hash_6a7b29c553065b8b", level.var_1e9e024bcfca2274.var_265b6d9b6af9f4a2 ?? 1 );
                    break;
                case 5:
                    var_75f25266eb889f8e = getdvarfloat( @"hash_a27b1b35952b86dc", level.var_1e9e024bcfca2274.var_a61e2a6ddc443239 ?? 1 );
                    break;
            }
        }
        
        if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_juggernog" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"juggernog_thicker_plates" ) )
        {
            var_28f3ffdd7296051a = level.zombie_augments[ #"juggernog_thicker_plates" ].var_fcd4c396ce615ccc ?? 0;
            var_75f25266eb889f8e += var_28f3ffdd7296051a;
        }
        
        if ( isdefined( eattacker.var_bd1805e45701eeb1 ) )
        {
            var_75f25266eb889f8e *= eattacker.var_bd1805e45701eeb1;
        }
        
        absorbed_damage = damage * var_75f25266eb889f8e;
        
        if ( isdefined( self.var_bba1e16138d312c8 ) )
        {
            absorbed_damage = self [[ self.var_bba1e16138d312c8 ]]( damage, eattacker, smeansofdeath, absorbed_damage );
        }
        
        if ( self.armorhealth && !self.var_f79429dae9c2e77 )
        {
            return min( self.armorhealth, absorbed_damage );
        }
        
        return absorbed_damage;
    }
    
    if ( isplayer( self ) )
    {
        return damage;
    }
    
    if ( isdefined( self.armorhealth ) )
    {
        return min( self.armorhealth, damage );
    }
}

// Namespace ob_armor
// Params 3
// Checksum 0xb7100ec8, Offset: 0x7bb
// Size: 0x108
function function_a3b392801472f91b( damage, eattacker, smeansofdeath )
{
    if ( self.var_a1faa64d8c07872e && isdefined( smeansofdeath ) )
    {
        if ( smeansofdeath == "MOD_EXPLOSIVE" )
        {
            damage *= 0.5;
        }
        else if ( smeansofdeath == "MOD_FIRE" )
        {
            damage *= 0.5;
        }
        else if ( smeansofdeath == "MOD_RADIATION" )
        {
            damage *= 0.5;
        }
    }
    
    aitype = "none";
    
    if ( isdefined( eattacker ) && isdefined( eattacker.type ) )
    {
        aitype = eattacker.type;
    }
    
    if ( aitype == "zombie" )
    {
        damage *= 0.5;
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.var_a48163c16d11e1b1 ) )
    {
        damage = self [[ eattacker.var_a48163c16d11e1b1 ]]( damage, eattacker, smeansofdeath );
    }
    
    if ( isdefined( self.var_a48163c16d11e1b1 ) )
    {
        damage = self [[ self.var_a48163c16d11e1b1 ]]( damage, eattacker, smeansofdeath );
    }
    
    return damage;
}

/#

    // Namespace ob_armor
    // Params 0
    // Checksum 0x6d6122c8, Offset: 0x8cc
    // Size: 0x73, Type: dev
    function setup_armor_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x3d>", &function_80d9b1fe8cb25921, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d>", "<dev string:x5c>", &function_80d9b1fe8cb25921, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6c>", "<dev string:x7b>", &function_80d9b1fe8cb25921, 0 );
        devgui::add_devgui_func( "<dev string:x8b>", "<dev string:x9d>", &set_golden_armor_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_armor
    // Params 0
    // Checksum 0x68f220d0, Offset: 0x947
    // Size: 0x7e, Type: dev
    function set_golden_armor_debug()
    {
        foreach ( player in level.players )
        {
            player set_golden_armor();
        }
    }

    // Namespace ob_armor
    // Params 1
    // Checksum 0x21478c2c, Offset: 0x9cd
    // Size: 0x9a, Type: dev
    function function_80d9b1fe8cb25921( params )
    {
        armor_level = int( params[ 0 ] );
        
        foreach ( player in level.players )
        {
            player debug_ob_armor( armor_level );
        }
    }

    // Namespace ob_armor
    // Params 1
    // Checksum 0x1a2b0f07, Offset: 0xa6f
    // Size: 0x42, Type: dev
    function debug_ob_armor( platecarrierlevel )
    {
        self.platecarrierlevel = platecarrierlevel;
        self.maxarmorhealth = platecarrierlevel * level.var_1bfbe247e8d32b1b;
        armor::setarmorhealth( platecarrierlevel * level.var_1bfbe247e8d32b1b );
    }

#/
