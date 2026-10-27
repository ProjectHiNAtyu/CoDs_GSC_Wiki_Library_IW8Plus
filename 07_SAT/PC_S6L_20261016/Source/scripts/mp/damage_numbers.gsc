// scripts\mp\damage_numbers.gsc  (hash_0d8c202a343c56c2.gscc) (size: 5005 Bytes / 0x138d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1178c27e (293126782)
// size ...... 5005 (0x138d)
// includes .. 3   (offset: 0x1265)
// strings ... 19  (offset: 0x127d)
// dev strs .. 3   (offset: 0x1369)
// exports ... 11  (offset: 0xd41)
// cseg ...... 0x17a + 0xbc7 (0xd41)
// imports ... 28  (offset: 0xef9)
// animtree1 . 0   (offset: 0x138d)
// animtree2 . 0   (offset: 0x138d)
#using scripts\common\vehicle;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;

#namespace damage_numbers;

// Namespace damage_numbers
// Params 0
// Checksum 0x2c8a9307, Offset: 0x198
// Size: 0x7b
function is_enabled()
{
    if ( getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) )
    {
        return 1;
    }
    
    if ( getdvarint( @"hash_16165c16dcda7cd8", 0 ) )
    {
        return 0;
    }
    
    if ( level.gametypebundle.var_fbd61fbcd04b8a3 )
    {
        return 0;
    }
    
    if ( level.gametypebundle.var_a2244cac5674c4ca )
    {
        return 1;
    }
    
    return istrue( level.gamemodebundle.var_a208c7b1897b6aa5 );
}

// Namespace damage_numbers
// Params 0
// Checksum 0x48118e09, Offset: 0x21b
// Size: 0x35, Type: bool
function function_c50b200b96c4c3a1()
{
    return isdefined( level.gamemodebundle ) && level.gamemodebundle.var_aaa2d3870f3368c7 || getdvarint( @"hash_130735a65b7ffaba", 0 );
}

// Namespace damage_numbers
// Params 0
// Checksum 0x9b61c7f6, Offset: 0x259
// Size: 0x35, Type: bool
function function_32fd7475ab012d6f()
{
    return isdefined( level.gamemodebundle ) && level.gamemodebundle.var_7970a7af9d1bfb3d || getdvarint( @"hash_6ae9c8f99eb1e41e", 0 );
}

// Namespace damage_numbers
// Params 0, eflags: 0x4
// Checksum 0xcba9ee62, Offset: 0x297
// Size: 0x13, Type: bool
function private function_8f9fd1a77ad48a0()
{
    return getdvarint( @"hash_abe7539d92be9616", 0 ) == 1;
}

// Namespace damage_numbers
// Params 7, eflags: 0x4
// Checksum 0x98051e8c, Offset: 0x2b3
// Size: 0x163
function private send_to_player( player, var_60e9c38b7ce34199, var_a709140543061007, idamage, vpoint, ielement, itype )
{
    if ( isdefined( player ) && isdefined( var_60e9c38b7ce34199 ) && isdefined( var_a709140543061007 ) && isdefined( idamage ) && isdefined( vpoint ) && isdefined( ielement ) && isdefined( itype ) )
    {
        idamage = int( clamp( idamage, -1000000, 1000000 ) );
        dmg_num_x = clamp( vpoint[ 0 ], -100000, 100000 );
        dmg_num_y = clamp( vpoint[ 1 ], -100000, 100000 );
        dmg_num_z = clamp( vpoint[ 2 ], -100000, 100000 );
        player setclientomnvar( "ui_dmg_num_amount", idamage );
        player setclientomnvar( "ui_dmg_num_x", int( dmg_num_x ) );
        player setclientomnvar( "ui_dmg_num_y", int( dmg_num_y ) );
        player setclientomnvar( "ui_dmg_num_z", int( dmg_num_z ) );
        player setclientomnvar( "ui_dmg_num_element", ielement );
        player setclientomnvar( "ui_dmg_num_state", var_a709140543061007 );
        player setclientomnvar( "ui_dmg_num_type", itype );
        player setclientomnvar( "ui_dmg_num_notify", gettime() );
        player setclientomnvar( "ui_dmg_num_target", var_60e9c38b7ce34199 );
    }
}

// Namespace damage_numbers
// Params 15
// Checksum 0xc0a6b8a2, Offset: 0x41e
// Size: 0x565
function display( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmune, selement, biscritical, var_4f9d5587bf9a2b1e, var_cd5368faab079fc8 = undefined, var_453f10fe0cab5896 = 0, einflictor = undefined, stype = undefined )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    if ( etargethit.nodamagenumbers )
    {
        return;
    }
    
    if ( isdefined( sweapon ) )
    {
        hash_weapon_name = sweapon.var_1616e6fbba9a722d;
    }
    
    hidedamagenumber = 0;
    var_659e594a9dc208fd = 0;
    
    if ( isdefined( hash_weapon_name ) && isdefined( level.weaponmetadata ) )
    {
        weaponmetadata = level.weaponmetadata[ hash_weapon_name ];
        
        if ( isdefined( weaponmetadata ) )
        {
            hidedamagenumber = weaponmetadata.hidedamagenumber;
            var_659e594a9dc208fd = weaponmetadata.var_34958430b3642cb9;
            
            if ( weaponmetadata.var_aea604e17ece5fb2 && idamage < weaponmetadata.var_aea604e17ece5fb2 )
            {
                hidedamagenumber = 1;
            }
        }
    }
    
    if ( hidedamagenumber )
    {
        return;
    }
    
    isvehiclecrushdamage = einflictor && einflictor vehicle::is_vehicle() && smeansofdeath == "MOD_CRUSH";
    var_6d86e6026563c48e = etargethit.type == "zombie" && etargethit.aicategory && ( etargethit.aicategory == "special" || etargethit.aicategory == "elite" || etargethit.aicategory == "boss" );
    
    if ( isvehiclecrushdamage && !var_6d86e6026563c48e )
    {
        return;
    }
    
    if ( isdefined( sweapon ) )
    {
        weapongroup = weapon::getweapongroup( sweapon );
    }
    
    var_a709140543061007 = 1;
    
    if ( isdefined( var_cd5368faab079fc8 ) )
    {
        var_a709140543061007 = var_cd5368faab079fc8;
    }
    else if ( isimmune )
    {
        var_a709140543061007 = 4;
    }
    else if ( var_4f9d5587bf9a2b1e )
    {
        var_a709140543061007 = 3;
    }
    else
    {
        gunbutt = isdefined( sweapon ) && !sweapon.ismelee && smeansofdeath === "MOD_MELEE";
        
        if ( isdefined( selement ) && !gunbutt && isarray( etargethit.elementalweakness ) && etargethit.elementalweakness[ selement ] )
        {
            var_453f10fe0cab5896 = level.var_de79f65048631206[ selement ];
        }
        
        if ( biscritical && weapongroup != "weapon_projectile" )
        {
            var_a709140543061007 = 2;
        }
    }
    
    if ( !vpoint && shitloc == "none" && smeansofdeath != "MOD_MELEE" )
    {
        usedoffset = etargethit.var_b196c5e6da89bfe8 ?? ( 0, 0, 12 );
        
        if ( isent( etargethit ) && isalive( etargethit ) )
        {
            usedtag = etargethit.var_d62ad5bfd64ba592 ?? "j_head";
            var_6139077a41be7a43 = etargethit gettagorigin( usedtag, 1 );
            vpoint = ( var_6139077a41be7a43 ?? etargethit.origin ) + usedoffset;
        }
        else
        {
            if ( !etargethit )
            {
                return;
            }
            
            if ( !etargethit.origin )
            {
                assertmsg( "<dev string:x24>" + etargethit.classname + "<dev string:x5d>" + etargethit.model );
                return;
            }
            
            vpoint = etargethit.origin + usedoffset;
        }
    }
    
    if ( shitloc == "torso_upper" && var_659e594a9dc208fd )
    {
        if ( isent( etargethit ) && isalive( etargethit ) )
        {
            if ( etargethit.var_6232d6ee94f13e0f )
            {
                usedtag = "j_head";
                var_6139077a41be7a43 = etargethit gettagorigin( usedtag );
                
                if ( var_6139077a41be7a43 )
                {
                    vpoint = var_6139077a41be7a43;
                }
            }
        }
    }
    
    damagetype = damage::function_6bebdb697b69b555( stype );
    var_60e9c38b7ce34199 = function_8f9fd1a77ad48a0() ? etargethit getentitynumber() : -1;
    
    if ( level.gamemodebundle.var_a3dab2af5ce465c3 )
    {
        damagetime = gettime();
        
        if ( !isdefined( eattacker.var_6cbefd23c1b3a72d ) )
        {
            eattacker.var_6cbefd23c1b3a72d = [];
        }
        
        dmgstruct = spawnstruct();
        dmgstruct.var_a709140543061007 = var_a709140543061007;
        dmgstruct.idamage = idamage;
        dmgstruct.vpoint = vpoint;
        dmgstruct.var_453f10fe0cab5896 = var_453f10fe0cab5896;
        dmgstruct.damagetime = damagetime;
        dmgstruct.sweapon = sweapon;
        dmgstruct.itype = damagetype;
        dmgstruct.var_60e9c38b7ce34199 = var_60e9c38b7ce34199;
        dmgstruct.isvehiclecrushdamage = isvehiclecrushdamage;
        eattacker.var_6cbefd23c1b3a72d[ eattacker.var_6cbefd23c1b3a72d.size ] = dmgstruct;
        assert( eattacker.var_6cbefd23c1b3a72d.size < 1000, "<dev string:x65>" );
        
        if ( !eattacker.var_9d75436b168f4f54 )
        {
            eattacker thread show_queue();
        }
        
        return;
    }
    
    thread display_internal( eattacker, var_60e9c38b7ce34199, var_a709140543061007, idamage, vpoint, var_453f10fe0cab5896, damagetype );
}

// Namespace damage_numbers
// Params 7
// Checksum 0x74a782c5, Offset: 0x98b
// Size: 0x55
function display_direct( player, var_a709140543061007, idamage, vpoint, ielement, itype, var_bbc055a93d3b130b )
{
    display_internal( player, -1, var_a709140543061007, idamage, vpoint, ielement, itype, var_bbc055a93d3b130b );
}

// Namespace damage_numbers
// Params 8, eflags: 0x4
// Checksum 0xa865fb57, Offset: 0x9e8
// Size: 0xf0
function private display_internal( player, var_60e9c38b7ce34199, var_a709140543061007, idamage, vpoint, ielement, itype, var_bbc055a93d3b130b )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !var_bbc055a93d3b130b )
    {
        player endon( #"hash_d4ca18e348001d56" );
    }
    
    if ( !isdefined( player.var_313f179273456000 ) )
    {
        player.var_313f179273456000 = 0;
    }
    
    if ( !isdefined( ielement ) )
    {
        ielement = 0;
    }
    
    if ( !isdefined( itype ) )
    {
        itype = 0;
    }
    
    player.var_313f179273456000++;
    wait 0.05 * player.var_313f179273456000;
    send_to_player( player, var_60e9c38b7ce34199, var_a709140543061007, idamage, vpoint, ielement, itype );
    player.var_313f179273456000 = maxint( 0, player.var_313f179273456000 - 1 );
}

// Namespace damage_numbers
// Params 0, eflags: 0xc
// Checksum 0xd8afff23, Offset: 0xae0
// Size: 0x5f
function private show_queue()
{
    self notify( #"hash_69ab8c7895809d7f" );
    self endon( #"hash_69ab8c7895809d7f" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_9d75436b168f4f54 = 1;
    
    while ( isplayer( self ) )
    {
        if ( self.var_6cbefd23c1b3a72d.size > 0 )
        {
            process_queue();
        }
        
        waitframe();
    }
}

// Namespace damage_numbers
// Params 0, eflags: 0x4
// Checksum 0x6545c2c6, Offset: 0xb47
// Size: 0x1fa
function private process_queue()
{
    damagenumbers = [];
    var_93fb854f6313ad2c = undefined;
    currenttime = gettime();
    var_54cf849136979081 = [];
    
    for ( damage_i = self.var_6cbefd23c1b3a72d.size - 1; damage_i >= 0 ; damage_i-- )
    {
        var_817ec4f1dd2382fa = self.var_6cbefd23c1b3a72d[ damage_i ];
        time = currenttime - var_817ec4f1dd2382fa.damagetime;
        
        if ( time >= 1000 )
        {
            continue;
        }
        
        if ( !isdefined( var_817ec4f1dd2382fa.isprimaryweapon ) )
        {
            var_817ec4f1dd2382fa.isprimaryweapon = isdefined( var_817ec4f1dd2382fa.sweapon ) && weapon::isprimaryweapon( var_817ec4f1dd2382fa.sweapon );
        }
        
        if ( var_817ec4f1dd2382fa.isprimaryweapon || ( var_817ec4f1dd2382fa.isvehiclecrushdamage ?? 0 ) > 0 )
        {
            if ( isdefined( var_93fb854f6313ad2c ) )
            {
                damagenumbers[ damagenumbers.size ] = var_817ec4f1dd2382fa;
            }
            
            if ( !isdefined( var_93fb854f6313ad2c ) )
            {
                var_93fb854f6313ad2c = var_817ec4f1dd2382fa;
            }
            
            continue;
        }
        
        var_54cf849136979081[ var_54cf849136979081.size ] = var_817ec4f1dd2382fa;
    }
    
    foreach ( var_817ec4f1dd2382fa in var_54cf849136979081 )
    {
        if ( isdefined( var_93fb854f6313ad2c ) )
        {
            damagenumbers[ damagenumbers.size ] = var_817ec4f1dd2382fa;
        }
        
        if ( !isdefined( var_93fb854f6313ad2c ) )
        {
            var_93fb854f6313ad2c = var_817ec4f1dd2382fa;
        }
    }
    
    self.var_6cbefd23c1b3a72d = damagenumbers;
    
    if ( isdefined( var_93fb854f6313ad2c ) )
    {
        if ( !isdefined( var_93fb854f6313ad2c.var_453f10fe0cab5896 ) )
        {
            var_93fb854f6313ad2c.var_453f10fe0cab5896 = 0;
        }
        
        send_to_player( self, var_93fb854f6313ad2c.var_60e9c38b7ce34199, var_93fb854f6313ad2c.var_a709140543061007, var_93fb854f6313ad2c.idamage, var_93fb854f6313ad2c.vpoint, var_93fb854f6313ad2c.var_453f10fe0cab5896, var_93fb854f6313ad2c.itype );
    }
}

