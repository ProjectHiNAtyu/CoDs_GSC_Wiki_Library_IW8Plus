// scripts\common\ai\aitypes\zombie_abom\zombie_abom_swallow.gsc  (hash_794430f1d1bae664.gscc) (size: 4445 Bytes / 0x115d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x495f1b2a (1230969642)
// size ...... 4445 (0x115d)
// includes .. 8   (offset: 0xfb1)
// strings ... 13  (offset: 0xff1)
// dev strs .. 16  (offset: 0x1099)
// exports ... 12  (offset: 0x9a5)
// cseg ...... 0x134 + 0x871 (0x9a5)
// imports ... 36  (offset: 0xb85)
// animtree1 . 0   (offset: 0x115d)
// animtree2 . 0   (offset: 0x115d)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_heads;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_abom_swallow;

// Namespace zombie_abom_swallow
// Params 0
// Checksum 0x84cdc2c2, Offset: 0x152
// Size: 0x22
function init_zombie_abom_swallow_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_37d0d0d3b8650155 );
}

// Namespace zombie_abom_swallow
// Params 0
// Checksum 0x65b8c03e, Offset: 0x17c
// Size: 0xf8
function init_zombie_abom_swallow()
{
    zombie_utils::function_dfae6a5bd222c586( &function_4e4f25f9b90a7832 );
    self.var_13d235d8235bf4a = 0;
    self.var_c57b3d8b8e1f44b = [];
    
    if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_83c64df61af95f2 ) )
    {
        foreach ( weaponstruct in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_83c64df61af95f2 )
        {
            if ( isdefined( weaponstruct.xhash ) )
            {
                self.var_c57b3d8b8e1f44b[ weaponstruct.xhash ] = 1;
            }
        }
    }
    
    /#
        init_abom_swallow_devgui();
    #/
}

// Namespace zombie_abom_swallow
// Params 0
// Checksum 0x5c2024a4, Offset: 0x27c
// Size: 0x41, Type: bool
function zombie_abom_swallow_on_cooldown()
{
    if ( isdefined( self.var_13d235d8235bf4a ) )
    {
        var_c108f606b27d68d6 = gettime() - self.var_13d235d8235bf4a;
        var_66f7fb8ee370dcc3 = 5000;
        
        if ( var_c108f606b27d68d6 < var_66f7fb8ee370dcc3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0xc41fed06, Offset: 0x2c6
// Size: 0x15
function private function_37d0d0d3b8650155( dmg_struct )
{
    function_fe82e2e00d6da28a( dmg_struct );
}

// Namespace zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0xdb3f4140, Offset: 0x2e3
// Size: 0x154
function private function_fe82e2e00d6da28a( dmg_struct )
{
    meansofdeath = dmg_struct.smeansofdeath;
    
    if ( meansofdeath != "MOD_IMPACT" )
    {
        return;
    }
    
    weapon_obj = dmg_struct.sweapon;
    
    if ( !isdefined( weapon_obj ) || weapon_obj.classname != "grenade" )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x24>" );
        #/
        
        return;
    }
    
    var_7068c97ad157148 = getweaponrootstring( weapon_obj );
    
    if ( isdefined( var_7068c97ad157148 ) && !self.var_c57b3d8b8e1f44b[ getxhash( var_7068c97ad157148 ) ] )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x32>" );
        #/
        
        return;
    }
    
    var_850a457725b15e0f = dmg_struct.metabonename;
    
    if ( !isdefined( var_850a457725b15e0f ) )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x4c>" );
        #/
        
        return;
    }
    
    var_e8b483d049d7276b = zombie_abom_metabones::function_316f556358b6282b( var_850a457725b15e0f );
    
    if ( !isdefined( var_e8b483d049d7276b ) )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x5c>" + var_850a457725b15e0f );
        #/
        
        return;
    }
    
    var_d5fe158ae1ee58f6 = zombie_abom_heads::get_abom_head_state( self, var_e8b483d049d7276b );
    
    if ( var_d5fe158ae1ee58f6 != 2 )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x74>" + var_d5fe158ae1ee58f6 );
        #/
        
        return;
    }
    
    if ( zombie_abom_swallow_on_cooldown() )
    {
        /#
            function_e7d8e46c68033155( "<dev string:x8e>" );
        #/
        
        return;
    }
    
    abom_swallow( dmg_struct, var_e8b483d049d7276b );
}

// Namespace zombie_abom_swallow
// Params 2, eflags: 0x4
// Checksum 0x26d720d5, Offset: 0x43f
// Size: 0x192
function private abom_swallow( dmg_struct, var_e8b483d049d7276b )
{
    grenade = dmg_struct.einflictor;
    
    if ( !isdefined( grenade ) )
    {
        /#
            function_e7d8e46c68033155( "<dev string:xad>" );
        #/
        
        return;
    }
    
    assert( isdefined( var_e8b483d049d7276b ) );
    self.var_13d235d8235bf4a = gettime();
    abom_swallow_state = "swallow_in";
    
    if ( isdefined( grenade.equipmentref ) )
    {
        if ( grenade.equipmentref == "equip_monkey_bomb" )
        {
            self setscriptablepartstate( "audio_monkeybomb_swallow", "on" );
        }
    }
    
    asm::asm_setstate( abom_swallow_state );
    tag = "j_" + level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ];
    grenade linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    grenade utility::ent_flag_set( "abom_swallowed" );
    grenade.swallowed_head_index = var_e8b483d049d7276b;
    grenade notify( #"missile_stuck" );
    grenade notify( #"swallowed" );
    self.var_b662c3ab73c360ee = spawnstruct();
    self.var_b662c3ab73c360ee.var_e8b483d049d7276b = var_e8b483d049d7276b;
    self.var_b662c3ab73c360ee.eattacker = dmg_struct.eattacker;
    self.var_b662c3ab73c360ee.time = gettime();
    wait 2;
    
    if ( isdefined( self ) && isdefined( grenade ) )
    {
        grenade notify( #"detonateexplosive", self );
    }
}

// Namespace zombie_abom_swallow
// Params 1, eflags: 0x4
// Checksum 0xf4c87e2f, Offset: 0x5d9
// Size: 0x2f2
function private function_4e4f25f9b90a7832( dmg_struct )
{
    if ( self.var_3a2ecc8b658f9fdc )
    {
        return -1;
    }
    
    metabone_name = undefined;
    
    if ( isdefined( dmg_struct.einflictor ) )
    {
        if ( !isdefined( dmg_struct.einflictor.swallowed_head_index ) || !dmg_struct.einflictor utility::ent_flag( "abom_swallowed" ) )
        {
            return -1;
        }
        
        /#
            function_e7d8e46c68033155( "<dev string:xcf>" );
        #/
        
        metabone_name = level.var_93e6be4b24339ce4[ dmg_struct.einflictor.swallowed_head_index ];
    }
    else
    {
        if ( !isdefined( self.var_b662c3ab73c360ee ) )
        {
            return -1;
        }
        
        var_c108f606b27d68d6 = gettime() - self.var_b662c3ab73c360ee.time;
        
        if ( var_c108f606b27d68d6 > 3500 )
        {
            /#
                function_e7d8e46c68033155( "<dev string:xf5>" + var_c108f606b27d68d6 );
            #/
            
            self.var_b662c3ab73c360ee = undefined;
            return -1;
        }
        
        if ( self.var_b662c3ab73c360ee.eattacker != dmg_struct.eattacker || dmg_struct.sweapon.classname != "grenade" || dmg_struct.smeansofdeath != "MOD_GRENADE_SPLASH" && dmg_struct.smeansofdeath != "MOD_EXPLOSIVE" )
        {
            /#
                if ( self.var_b662c3ab73c360ee.eattacker != dmg_struct.eattacker )
                {
                    function_e7d8e46c68033155( "<dev string:x10b>" );
                }
                else
                {
                    function_e7d8e46c68033155( "<dev string:x136>" + dmg_struct.sweapon.classname + "<dev string:x154>" + dmg_struct.smeansofdeath );
                }
            #/
            
            return -1;
        }
        
        metabone_name = level.var_93e6be4b24339ce4[ self.var_b662c3ab73c360ee.var_e8b483d049d7276b ];
    }
    
    self.var_b662c3ab73c360ee = undefined;
    
    if ( !isdefined( metabone_name ) )
    {
        return -1;
    }
    
    var_5f482f9809a77dce = dmg_struct.idamage * self.swallowdamagemultiplier;
    head_health = metabone::get_metabone_health( metabone_name, "open" );
    
    if ( head_health <= 0 )
    {
        return -1;
    }
    
    new_damage = max( var_5f482f9809a77dce, dmg_struct.idamage );
    new_damage = min( new_damage, head_health );
    dmg_struct.var_ff33243f5be1fe3b = max( dmg_struct.var_ff33243f5be1fe3b, 1 );
    dmg_struct.biscritical = 1;
    metabone::damage_metabone_state( metabone_name, new_damage, "open", dmg_struct.eattacker, dmg_struct.einflictor );
    params = spawnstruct();
    params.incomingdamage = new_damage;
    callback::callback( "abomination_swallow_grenade" );
    dmg_struct.var_64c8bb12f016e6ac = 1;
    return new_damage;
}

/#

    // Namespace zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0xbecd6fd9, Offset: 0x8d4
    // Size: 0x2e, Type: dev
    function private init_abom_swallow_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x15b>" );
        devgui::add_devgui_func( "<dev string:x178>", "<dev string:x186>", &toggle_debug_swallow );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0x899decdc, Offset: 0x90a
    // Size: 0x1a, Type: dev
    function private toggle_debug_swallow()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x186>", @"abom_debug_swallow" );
    }

    // Namespace zombie_abom_swallow
    // Params 0, eflags: 0x4
    // Checksum 0x850bb040, Offset: 0x92c
    // Size: 0x16, Type: dev
    function private function_b1df43ba4b95bced()
    {
        return getdvarint( @"abom_debug_swallow", 0 ) > 0;
    }

    // Namespace zombie_abom_swallow
    // Params 2, eflags: 0x4
    // Checksum 0xd2d40d7f, Offset: 0x94a
    // Size: 0x5b, Type: dev
    function private function_e7d8e46c68033155( text, pos )
    {
        if ( function_b1df43ba4b95bced() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x199>" + text, ( 1, 0, 0 ) );
        }
    }

#/
