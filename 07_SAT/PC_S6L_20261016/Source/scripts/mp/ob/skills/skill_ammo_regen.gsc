// scripts\mp\ob\skills\skill_ammo_regen.gsc  (hash_34d2062ed463a295.gscc) (size: 3725 Bytes / 0xe8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cfb6866 (1828415590)
// size ...... 3725 (0xe8d)
// includes .. 4   (offset: 0xe09)
// strings ... 8   (offset: 0xe29)
// dev strs .. 0   (offset: 0xe8d)
// exports ... 11  (offset: 0x7ad)
// cseg ...... 0xa5 + 0x708 (0x7ad)
// imports ... 38  (offset: 0x965)
// animtree1 . 0   (offset: 0xe8d)
// animtree2 . 0   (offset: 0xe8d)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace skill_ammo_regen;

// Namespace skill_ammo_regen
// Params 0, eflags: 0x1
// Checksum 0xdf1e0837, Offset: 0xc3
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"ammo_regen", &init );
}

// Namespace skill_ammo_regen
// Params 0, eflags: 0x4
// Checksum 0x7e067b8e, Offset: 0xe2
// Size: 0x72
function private init()
{
    utility::registersharedfunc( #"ammo_regen", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"ammo_regen", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"ammo_regen", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_22cac0feee63cea0 );
}

// Namespace skill_ammo_regen
// Params 1, eflags: 0x4
// Checksum 0xc905b00a, Offset: 0x15c
// Size: 0x35
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_d854d8558ea2da8d )
    {
        skill_bundle.var_4279d87b668cbe09 = skill_bundle.var_d854d8558ea2da8d * 1000;
    }
}

// Namespace skill_ammo_regen
// Params 1, eflags: 0x4
// Checksum 0x3756f944, Offset: 0x199
// Size: 0x5d, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_8b7d3bfb2d798cb2 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_4279d87b668cbe09 && skill_bundle.var_dbf3a595107b74ce )
    {
        thread function_49180ecbce080aac( skill_bundle.var_4279d87b668cbe09, skill_bundle.var_dbf3a595107b74ce );
    }
    
    return true;
}

// Namespace skill_ammo_regen
// Params 1, eflags: 0x4
// Checksum 0x173f291c, Offset: 0x1ff
// Size: 0x22
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_4043aef654969064" );
    self.var_8b7d3bfb2d798cb2 = undefined;
}

// Namespace skill_ammo_regen
// Params 2
// Checksum 0x9986c66c, Offset: 0x229
// Size: 0x39
function function_49180ecbce080aac( reloadtime, reloadpercent )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_4043aef654969064" );
    childthread function_9f00535d7f711279( reloadtime, reloadpercent, 1 );
}

// Namespace skill_ammo_regen
// Params 1
// Checksum 0x63c3a1a0, Offset: 0x26a
// Size: 0xc1
function function_22cac0feee63cea0( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    bundle = player.var_8b7d3bfb2d798cb2.bundle;
    
    if ( bundle.var_7c79879c99b973e7 )
    {
        if ( self.aicategory && ( self.aicategory == "elite" || self.aicategory == "hvt" || self.aicategory == "boss" ) )
        {
            while ( player attackbuttonpressed() )
            {
                waitframe();
            }
            
            player function_2d4149a5d775f40c( bundle.var_7c79879c99b973e7 );
        }
    }
}

// Namespace skill_ammo_regen
// Params 3
// Checksum 0xf5af7261, Offset: 0x333
// Size: 0x79
function function_9f00535d7f711279( reloadtime, reloadpercent, var_f264159b81f1629a )
{
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
            function_2d4149a5d775f40c( reloadpercent, var_f264159b81f1629a );
        }
        
        waitframe();
    }
}

// Namespace skill_ammo_regen
// Params 2
// Checksum 0x3ef77d59, Offset: 0x3b4
// Size: 0x10f
function function_2d4149a5d775f40c( reloadpercent, var_f264159b81f1629a )
{
    weapons = self getweaponslist( "primary" );
    
    foreach ( weapon in weapons )
    {
        function_13da73642598e825( weapon, reloadpercent );
        
        if ( var_f264159b81f1629a && weapon.hasalternate )
        {
            alt_weapon = weapon getaltweapon();
            
            if ( isdefined( alt_weapon ) && alt_weapon != weapon )
            {
                var_c0a84c871f4165a7 = isdefined( weapon.underbarrel ) && getattachmentbasetype( weapon, weapon.underbarrel ) == "selectfire";
                
                if ( !var_c0a84c871f4165a7 )
                {
                    function_13da73642598e825( alt_weapon, reloadpercent );
                }
            }
        }
    }
}

// Namespace skill_ammo_regen
// Params 2, eflags: 0x4
// Checksum 0x963ea764, Offset: 0x4cb
// Size: 0x2e2
function private function_13da73642598e825( weapon, reloadpercent )
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

