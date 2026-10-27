// script_72071ff04fb01b23  (hash_72071ff04fb01b23.gscc) (size: 6305 Bytes / 0x18a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8aa7ebe (3098181310)
// size ...... 6305 (0x18a1)
// includes .. 6   (offset: 0x1785)
// strings ... 14  (offset: 0x17b5)
// dev strs .. 0   (offset: 0x18a1)
// exports ... 15  (offset: 0xe85)
// cseg ...... 0x17e + 0xd07 (0xe85)
// imports ... 51  (offset: 0x10dd)
// animtree1 . 0   (offset: 0x18a1)
// animtree2 . 0   (offset: 0x18a1)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\perk;
#using scripts\mp\weapons;

#namespace speed_cola_augments;

// Namespace speed_cola_augments
// Params 0, eflags: 0x5
// Checksum 0xd4f8241a, Offset: 0x19c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"speed_cola_augments", undefined, &function_f606ef4b3f9d1a49, undefined );
}

// Namespace speed_cola_augments
// Params 0
// Checksum 0xefb81d81, Offset: 0x1bd
// Size: 0x82
function function_f606ef4b3f9d1a49()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level thread function_824c1553435bc546();
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"reload_start", &speed_cola_reload );
    callback::add( #"reload", &function_1e8c882f8a032a34 );
    utility::registersharedfunc( #"zombie", #"hash_fc6574ba8b7263fc", &function_aefd315770e1f56d );
}

// Namespace speed_cola_augments
// Params 0
// Checksum 0x1f7cf57d, Offset: 0x247
// Size: 0x3
function function_824c1553435bc546()
{
    waitframe();
}

// Namespace speed_cola_augments
// Params 1
// Checksum 0x95ff1d79, Offset: 0x252
// Size: 0x10a
function function_288f120db5b6defb( params )
{
    if ( isdefined( params ) && params.var_ffc1674def575bfa == "specialty_speedcola" )
    {
        if ( function_b99aa77884bbe01e( #"speedcola_faster_field_upgrade" ) && utility::issharedfuncdefined( #"zombie", #"hash_fb5407d9c2bf5a3c" ) )
        {
            utility::callsharedfunc( #"zombie", #"hash_fb5407d9c2bf5a3c", #"speedcola_faster_field_upgrade", 1 );
        }
        
        if ( function_b99aa77884bbe01e( #"hash_6efb497e5fa473b4" ) )
        {
            perk::giveperk( "specialty_fastermelee" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_faster_equipment" ) )
        {
            perk::giveperk( "specialty_fastoffhand" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_faster_switch" ) )
        {
            perk::giveperk( "specialty_quickswap" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_classic_formula" ) )
        {
            perk::giveperk( "specialty_zombies_fastreload_augment" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_phantom_reload" ) )
        {
            thread function_7c65e01d1a67aca0();
        }
    }
}

// Namespace speed_cola_augments
// Params 1
// Checksum 0xd19c1b2c, Offset: 0x364
// Size: 0x15e
function function_9e09844df6bf44c7( params )
{
    if ( isdefined( params ) && params.var_ffc1674def575bfa == "specialty_speedcola" )
    {
        if ( function_b99aa77884bbe01e( #"speedcola_faster_field_upgrade" ) && utility::issharedfuncdefined( #"zombie", #"hash_fb5407d9c2bf5a3c" ) )
        {
            utility::callsharedfunc( #"zombie", #"hash_fb5407d9c2bf5a3c", #"speedcola_faster_field_upgrade", 0 );
        }
        
        if ( function_b99aa77884bbe01e( #"hash_6efb497e5fa473b4" ) && isdefined( self.perks[ "specialty_fastermelee" ] ) )
        {
            perk::removeperk( "specialty_fastermelee" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_faster_equipment" ) && isdefined( self.perks[ "specialty_fastoffhand" ] ) )
        {
            perk::removeperk( "specialty_fastoffhand" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_faster_switch" ) && isdefined( self.perks[ "specialty_quickswap" ] ) )
        {
            perk::removeperk( "specialty_quickswap" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_classic_formula" ) && isdefined( self.perks[ "specialty_zombies_fastreload_augment" ] ) )
        {
            perk::removeperk( "specialty_zombies_fastreload_augment" );
        }
        
        if ( function_b99aa77884bbe01e( #"speedcola_phantom_reload" ) )
        {
            self notify( #"hash_b2cead66f5db30bc" );
        }
    }
}

// Namespace speed_cola_augments
// Params 0
// Checksum 0x27340b30, Offset: 0x4ca
// Size: 0x81
function function_7c65e01d1a67aca0()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b2cead66f5db30bc" );
    reloadtime = level.zombie_augments[ #"speedcola_phantom_reload" ].var_6dd8f1ed5ab593d9 ?? 5;
    reloadpercent = level.zombie_augments[ #"speedcola_phantom_reload" ].var_d67ec85b1b003bd1 ?? 0.25;
    childthread function_b9fc48cc6db17de6( reloadtime, reloadpercent );
}

// Namespace speed_cola_augments
// Params 3
// Checksum 0xf126e1e0, Offset: 0x553
// Size: 0x81
function function_b9fc48cc6db17de6( reloadtime, reloadpercent, var_f264159b81f1629a )
{
    reloadtime *= 1000;
    lasttimefired = gettime();
    
    while ( true )
    {
        if ( self attackbuttonpressed() )
        {
            lasttimefired = gettime();
        }
        
        if ( self isdualwielding() && self adsbuttonpressed() )
        {
            lasttimefired = gettime();
        }
        
        if ( gettime() - lasttimefired > reloadtime )
        {
            lasttimefired = gettime();
            function_c5426f3a36bbfd25( reloadpercent, var_f264159b81f1629a );
        }
        
        waitframe();
    }
}

// Namespace speed_cola_augments
// Params 2
// Checksum 0x2230f8ce, Offset: 0x5dc
// Size: 0x11b
function function_c5426f3a36bbfd25( reloadpercent, var_f264159b81f1629a )
{
    weapons = self getweaponslist( "primary" );
    
    foreach ( weapon in weapons )
    {
        function_da858510ecd707de( weapon, reloadpercent );
        
        if ( var_f264159b81f1629a && weapon.hasalternate )
        {
            alt_weapon = weapon getaltweapon();
            
            if ( isdefined( alt_weapon ) && alt_weapon != weapon )
            {
                var_c0a84c871f4165a7 = isdefined( weapon.underbarrel ) && getattachmentbasetype( weapon, weapon.underbarrel ) == "selectfire";
                
                if ( !var_c0a84c871f4165a7 )
                {
                    function_da858510ecd707de( alt_weapon, reloadpercent );
                }
            }
        }
    }
    
    callback::callback( "phantom_augment_reload_completed" );
}

// Namespace speed_cola_augments
// Params 2, eflags: 0x4
// Checksum 0x6a76ba9d, Offset: 0x6ff
// Size: 0x2e2
function private function_da858510ecd707de( weapon, reloadpercent )
{
    n_stock_max = weaponmaxammo( weapon );
    var_b11feea92c35d08e = weaponclipsize( weapon );
    var_83e55048826dcd05 = self getweaponammoclip( weapon );
    n_stock_current = self getweaponammostock( weapon );
    n_clip_current_max = var_b11feea92c35d08e - var_83e55048826dcd05;
    n_clip_current_left = 0;
    var_2a587142370a296d = 0;
    is_cliponly = function_fbb6adbc1a89658a( weapon );
    is_beltfed = issubstr( weapon.magazine, "beltfed" );
    var_4b84689143748612 = weapon.reloaddisabled;
    
    if ( is_beltfed || is_cliponly || var_4b84689143748612 )
    {
        return;
    }
    
    if ( weapon.isdualwield )
    {
        n_clip_current_left = self getweaponammoclip( weapon, "left" );
        var_9cc2ddc87f2b8ff8 = var_b11feea92c35d08e - n_clip_current_left;
    }
    
    if ( !weapon.ismelee && !weapon::iskillstreakweapon( weapon ) && !weapon::iswonderweapon( weapon ) && n_stock_max > 0 && var_b11feea92c35d08e > 0 && n_stock_current > 0 && ( n_clip_current_max > 0 || var_9cc2ddc87f2b8ff8 > 0 ) )
    {
        if ( n_clip_current_max > 0 )
        {
            var_2a587142370a296d = int( var_b11feea92c35d08e * reloadpercent );
            var_2a587142370a296d = int( max( 1, var_2a587142370a296d ) );
            var_2a587142370a296d = int( clamp( var_2a587142370a296d, 0, n_stock_current ) );
            var_2a587142370a296d = int( clamp( var_2a587142370a296d, 0, n_clip_current_max ) );
        }
        
        if ( var_2a587142370a296d > 0 && n_stock_current >= var_2a587142370a296d && n_clip_current_max > 0 )
        {
            var_83e55048826dcd05 += var_2a587142370a296d;
            var_83e55048826dcd05 = int( clamp( var_83e55048826dcd05, 0, var_b11feea92c35d08e ) );
            
            if ( weapon.isdualwield )
            {
                self setweaponammoclip( weapon, var_83e55048826dcd05, "right" );
            }
            else
            {
                self setweaponammoclip( weapon, var_83e55048826dcd05 );
            }
            
            n_stock_current -= var_2a587142370a296d;
            n_stock_current = int( clamp( n_stock_current, 0, n_stock_max ) );
            self setweaponammostock( weapon, n_stock_current );
            
            if ( self.currentweapon == weapon )
            {
                self playlocalsound( #"hash_46be05cdfd26f72f" );
            }
        }
        
        if ( weapon.isdualwield && var_9cc2ddc87f2b8ff8 > 0 )
        {
            n_stock_current = self getweaponammostock( weapon );
            var_2a587142370a296d = 0;
            var_2a587142370a296d = int( var_b11feea92c35d08e * reloadpercent );
            var_2a587142370a296d = int( max( 1, var_2a587142370a296d ) );
            var_2a587142370a296d = int( clamp( var_2a587142370a296d, 0, n_stock_current ) );
            var_2a587142370a296d = int( clamp( var_2a587142370a296d, 0, var_b11feea92c35d08e - n_clip_current_left ) );
            
            if ( var_2a587142370a296d > 0 && n_stock_current >= var_2a587142370a296d )
            {
                n_clip_current_left += var_2a587142370a296d;
                n_clip_current_left = int( clamp( n_clip_current_left, 0, var_b11feea92c35d08e ) );
                self setweaponammoclip( weapon, n_clip_current_left, "left" );
                n_stock_current -= var_2a587142370a296d;
                n_stock_current = int( clamp( n_stock_current, 0, n_stock_max ) );
                self setweaponammostock( weapon, n_stock_current );
                
                if ( self.currentweapon == weapon )
                {
                    self playlocalsound( #"hash_46be05cdfd26f72f" );
                }
            }
        }
    }
}

// Namespace speed_cola_augments
// Params 1
// Checksum 0x19ca0c90, Offset: 0x9e9
// Size: 0x26
function function_b99aa77884bbe01e( augmentname )
{
    return utility::callsharedfunc( #"zombie", #"player_has_augment", augmentname );
}

// Namespace speed_cola_augments
// Params 0
// Checksum 0xb3ac7128, Offset: 0xa18
// Size: 0x5b, Type: bool
function function_aefd315770e1f56d()
{
    if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_speedcola" ) )
    {
        if ( function_b99aa77884bbe01e( #"speedcola_faster_magicbox" ) )
        {
            return ( level.zombie_augments[ #"speedcola_faster_magicbox" ].var_bde7a60ea80c1509 ?? 2.5 );
        }
    }
    
    return false;
}

// Namespace speed_cola_augments
// Params 1, eflags: 0x4
// Checksum 0x4e58b212, Offset: 0xa7c
// Size: 0x10a
function private function_1e8c882f8a032a34( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_speedcola", #"speedcola_stock_reload" ) )
    {
        percent_chance = level.zombie_augments[ #"speedcola_stock_reload" ].var_fba3fc255cbdb457 ?? 0.05;
        percent_chance *= 100;
        var_430536335bcd8f37 = self.currentweapon.reloadtype;
        
        if ( utility::percent_chance( percent_chance ) )
        {
            if ( self.var_8fa219f0881979bb > 0 )
            {
                current_weapon = self getcurrentweapon();
                var_5d0c831b13e279b6 = self getweaponammostock( current_weapon );
                var_48a8f7224c85ab09 = ( var_430536335bcd8f37 == 1 ? self.var_c81bca6e0b28262b : self.var_8fa219f0881979bb ) + var_5d0c831b13e279b6;
                self setweaponammostock( current_weapon, var_48a8f7224c85ab09 );
                self.var_8fa219f0881979bb = undefined;
                self.var_c81bca6e0b28262b = undefined;
            }
        }
    }
}

// Namespace speed_cola_augments
// Params 1, eflags: 0x4
// Checksum 0xd792991d, Offset: 0xb8e
// Size: 0x1a5
function private speed_cola_reload( sparams )
{
    current_weapon = self getcurrentweapon();
    var_8d3454d1b5219ce = self getweaponammoclip( current_weapon );
    var_5d0c831b13e279b6 = self getweaponammostock( current_weapon );
    max_clip_ammo = weaponclipsize( current_weapon );
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_speedcola", #"speedcola_sprint_reload" ) )
    {
        cooldown = level.zombie_augments[ #"speedcola_sprint_reload" ].var_ee136d1d2c744233 ?? 2;
        cooldown *= 1000;
        
        if ( !isdefined( self.var_43d7d76f7f46b696 ) )
        {
            self.var_43d7d76f7f46b696 = gettime();
        }
        else if ( gettime() - self.var_43d7d76f7f46b696 < cooldown )
        {
            return;
        }
        
        threshold_clip = int( max_clip_ammo * ( level.zombie_augments[ #"speedcola_sprint_reload" ].var_ee136d1d2c744233 ?? 0.5 ) );
        var_96a5c0bba5d8043a = 0;
        b_zero = 0;
        
        if ( var_8d3454d1b5219ce > threshold_clip )
        {
            var_96a5c0bba5d8043a = 1;
        }
        
        if ( var_8d3454d1b5219ce == 0 )
        {
            b_zero = 1;
        }
        
        self.var_43d7d76f7f46b696 = gettime();
        thread function_441fa81aae1a1bc2( b_zero, var_96a5c0bba5d8043a );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_speedcola", #"speedcola_stock_reload" ) )
    {
        var_eef48e40c12aee37 = max_clip_ammo - var_8d3454d1b5219ce;
        self.var_8fa219f0881979bb = var_eef48e40c12aee37;
        self.var_c81bca6e0b28262b = 1;
    }
}

// Namespace speed_cola_augments
// Params 2, eflags: 0xc
// Checksum 0xd3c20ed4, Offset: 0xd3b
// Size: 0x14a
function private function_441fa81aae1a1bc2( bzero, var_23dea841cc76aae4 )
{
    self notify( #"hash_47e1257e02667f7b" );
    self endon( #"hash_47e1257e02667f7b" );
    self endon( #"disconnect" );
    duration = level.zombie_augments[ #"speedcola_sprint_reload" ].var_1a8162620afb7b00 ?? 2;
    
    if ( var_23dea841cc76aae4 )
    {
        speed_boost = level.zombie_augments[ #"speedcola_sprint_reload" ].var_b8227b1c11658ada ?? 0.05;
        weapons::addextramovespeed( "speed_cola_reload_speed_boost", speed_boost );
    }
    else if ( bzero )
    {
        speed_boost = level.zombie_augments[ #"speedcola_sprint_reload" ].var_c8f8991bb51ebcad ?? 0.1;
        weapons::addextramovespeed( "speed_cola_reload_speed_boost", speed_boost );
    }
    else
    {
        speed_boost = level.zombie_augments[ #"speedcola_sprint_reload" ].var_c10e3756fe064f5e ?? 0.075;
        weapons::addextramovespeed( "speed_cola_reload_speed_boost", speed_boost );
    }
    
    weapons::updatemovespeedscale();
    self playlocalsound( #"hash_75136e8ed4ddce9c" );
    wait duration;
    weapons::removeextramovespeed( "speed_cola_reload_speed_boost" );
    weapons::updatemovespeedscale();
}

