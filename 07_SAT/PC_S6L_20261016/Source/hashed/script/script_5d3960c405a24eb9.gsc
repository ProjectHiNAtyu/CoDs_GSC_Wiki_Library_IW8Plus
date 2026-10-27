// script_5d3960c405a24eb9  (hash_5d3960c405a24eb9.gscc) (size: 7768 Bytes / 0x1e58 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6cfcb51 (4140813137)
// size ...... 7768 (0x1e58)
// includes .. 7   (offset: 0x1c34)
// strings ... 14  (offset: 0x1c6c)
// dev strs .. 11  (offset: 0x1dd4)
// exports ... 30  (offset: 0x11ac)
// cseg ...... 0x105 + 0x10a7 (0x11ac)
// imports ... 49  (offset: 0x165c)
// animtree1 . 0   (offset: 0x1e58)
// animtree2 . 0   (offset: 0x1e58)
#using script_640b69521097c6a5;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;

#namespace zombie_weyward_metabones;

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x1
// Checksum 0xebeb1309, Offset: 0x123
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_weyward";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

/#

    // Namespace zombie_weyward_metabones
    // Params 0
    // Checksum 0x818da11a, Offset: 0x14c
    // Size: 0xc, Type: dev
    function function_420e30d2247d2ef4()
    {
        function_4984df10f0449e9a();
    }

#/

// Namespace zombie_weyward_metabones
// Params 0
// Checksum 0x6d74086b, Offset: 0x160
// Size: 0x107
function init_zombie_weyward_metabones()
{
    self.var_eec80a0a9fa2bef8 = [ "stinger", "head", "left", "right" ];
    self.var_12fc5301e1f11d2a = [];
    self.var_12fc5301e1f11d2a[ "stinger" ] = "destroyed";
    self.var_12fc5301e1f11d2a[ "head" ] = "armored";
    self.var_12fc5301e1f11d2a[ "left" ] = "armored";
    self.var_12fc5301e1f11d2a[ "right" ] = "armored";
    self.metabones_enabled = 1;
    self.var_f7621c9f0e486f18 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9c7b0f91f07c2ac9 ?? 3;
    self.var_fefc4616d4cd2b95 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8d4056e8b61614b ?? 0.05;
    thread init_scriptable();
    thread function_3452864698cb778a();
    thread function_615b9549d81eec2d();
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x4
// Checksum 0x28b5d7da, Offset: 0x26f
// Size: 0x2ee
function private function_3452864698cb778a()
{
    self endon( #"death" );
    self waittill( #"zombie_asm_init_finished" );
    metabone_ping_model = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5773644b7fca465e;
    var_542ee8522b070ac6 = [];
    metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
    
    foreach ( metabone in metabones_def.metabones )
    {
        if ( isdefined( metabone.tags ) )
        {
            foreach ( tag in metabone.tags )
            {
                if ( var_542ee8522b070ac6[ metabone.name ] )
                {
                    assertmsg( "<dev string:x24>" + metabone.name + "<dev string:x51>" + tag.tagname );
                    continue;
                }
                
                ping_ent = utility::spawn_model( metabone_ping_model, self gettagorigin( tag.tagname ), self.angles );
                ping_ent.tagname = tag.tagname;
                ping_ent.owner = self;
                ping_ent linkto( self, tag.tagname );
                ping_ent enableaimassist();
                ping_ent callback::add( #"on_ping", &function_e4676d351689b93e );
                var_542ee8522b070ac6[ metabone.name ] = ping_ent;
            }
        }
    }
    
    self.metabone_ping_ents = var_542ee8522b070ac6;
    thread function_dbbd0bddc5e79e74( var_542ee8522b070ac6 );
    
    foreach ( weakspot_tag, weakspot_state in self.var_12fc5301e1f11d2a )
    {
        ping_ent = self.metabone_ping_ents[ weakspot_tag ];
        
        if ( isdefined( ping_ent ) )
        {
            part_name = ping_ent getscriptablehaspart( weakspot_tag ) ? weakspot_tag : "icon";
            ping_ent utility::function_7c10ea82c1e305b8( part_name, weakspot_state );
        }
    }
}

// Namespace zombie_weyward_metabones
// Params 1, eflags: 0x4
// Checksum 0x5ba2f7de, Offset: 0x565
// Size: 0x34
function private function_e4676d351689b93e( params )
{
    thread calloutmarkerping::function_3c501da3379eca0a( params.player, params.pingindex, undefined, [ "metabone_destroyed" ] );
}

// Namespace zombie_weyward_metabones
// Params 1, eflags: 0x4
// Checksum 0x800ab143, Offset: 0x5a1
// Size: 0x8f
function private function_dbbd0bddc5e79e74( metabone_ping_ents )
{
    self waittill( #"death" );
    
    foreach ( ent in metabone_ping_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x4
// Checksum 0xc96d7973, Offset: 0x638
// Size: 0x42
function private init_scriptable()
{
    self endon( #"death" );
    waitframe();
    utility::function_7c10ea82c1e305b8( "head", "armored" );
    utility::function_7c10ea82c1e305b8( "left", "armored" );
    utility::function_7c10ea82c1e305b8( "right", "armored" );
}

// Namespace zombie_weyward_metabones
// Params 0
// Checksum 0xcb7384de, Offset: 0x682
// Size: 0xe0
function function_82487bddb09162ca()
{
    foreach ( metabone_name in self.var_eec80a0a9fa2bef8 )
    {
        if ( self.var_12fc5301e1f11d2a[ metabone_name ] == "armored" )
        {
            self.var_12fc5301e1f11d2a[ metabone_name ] = "destroyed";
            metabone::set_metabone_state( metabone_name, "destroyed" );
            metabone::set_metabone_active( metabone_name, 0 );
            utility::function_7c10ea82c1e305b8( metabone_name, "destroyed" );
            
            if ( isdefined( self.metabone_ping_ents[ metabone_name ] ) )
            {
                self.metabone_ping_ents[ metabone_name ] delete();
            }
        }
    }
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x7a3c9b30, Offset: 0x76a
// Size: 0x1e, Type: bool
function is_metabone_armored( metabone_name )
{
    return self.var_12fc5301e1f11d2a[ metabone_name ] == "armored";
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x7a3c9b30, Offset: 0x791
// Size: 0x1e, Type: bool
function is_metabone_exposed( metabone_name )
{
    return self.var_12fc5301e1f11d2a[ metabone_name ] == "exposed";
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0xf7482d16, Offset: 0x7b8
// Size: 0x1e, Type: bool
function is_metabone_destroyed_state( metabone_name )
{
    return self.var_12fc5301e1f11d2a[ metabone_name ] == "destroyed";
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x6f31590d, Offset: 0x7df
// Size: 0x18
function get_metabone_state( metabone_name )
{
    return self.var_12fc5301e1f11d2a[ metabone_name ];
}

// Namespace zombie_weyward_metabones
// Params 0
// Checksum 0x3c64752, Offset: 0x800
// Size: 0x16
function function_995b6dfb3ab95f0c()
{
    if ( self.shadow_soul_shield_active )
    {
        return;
    }
    
    thread function_854ad0a6027aeb6c();
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0xc
// Checksum 0x70dd6f40, Offset: 0x81e
// Size: 0x118
function private function_854ad0a6027aeb6c()
{
    self notify( #"hash_f6b1f73aa49022aa" );
    self endon( #"hash_f6b1f73aa49022aa" );
    self endon( #"death" );
    exposed_time = getdvarfloat( @"hash_aaf29af6014053ac", self.var_f7621c9f0e486f18 );
    var_82549296868b9c93 = self.metabone_ping_ents[ "stinger" ];
    self.var_12fc5301e1f11d2a[ "stinger" ] = "exposed";
    metabone::set_metabone_active( "stinger", 1 );
    utility::function_7c10ea82c1e305b8( "stinger", "exposed" );
    
    if ( isdefined( var_82549296868b9c93 ) )
    {
        var_82549296868b9c93 utility::function_7c10ea82c1e305b8( "icon", "exposed" );
        var_82549296868b9c93 enableaimassist();
    }
    
    wait exposed_time;
    self.var_12fc5301e1f11d2a[ "stinger" ] = "destroyed";
    metabone::set_metabone_active( "stinger", 0 );
    utility::function_7c10ea82c1e305b8( "stinger", "destroyed" );
    
    if ( isdefined( var_82549296868b9c93 ) )
    {
        var_82549296868b9c93 notify( #"metabone_destroyed" );
        var_82549296868b9c93 utility::function_7c10ea82c1e305b8( "icon", "destroyed" );
        var_82549296868b9c93 disableaimassist();
    }
}

// Namespace zombie_weyward_metabones
// Params 2
// Checksum 0xd105ceab, Offset: 0x93e
// Size: 0x6b
function expose_metabone( weyward, metabone_name )
{
    if ( weyward.var_12fc5301e1f11d2a[ metabone_name ] != "armored" )
    {
        return;
    }
    
    weyward.var_12fc5301e1f11d2a[ metabone_name ] = "exposed";
    weyward metabone::set_metabone_state( metabone_name, "exposed" );
    weyward metabone::set_metabone_active( metabone_name, 1 );
    weyward utility::function_7c10ea82c1e305b8( metabone_name, "exposed" );
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0xf127d34f, Offset: 0x9b1
// Size: 0x17
function get_all_metabones( weyward )
{
    return weyward.var_eec80a0a9fa2bef8;
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0xfc5d490e, Offset: 0x9d1
// Size: 0xa9
function get_armored_metabones( weyward )
{
    armored = [];
    
    foreach ( bone in weyward.var_eec80a0a9fa2bef8 )
    {
        if ( weyward.var_12fc5301e1f11d2a[ bone ] == "armored" )
        {
            armored[ armored.size ] = bone;
        }
    }
    
    return armored;
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x1eefa09e, Offset: 0xa83
// Size: 0xa9
function get_exposed_metabones( weyward )
{
    exposed = [];
    
    foreach ( bone in weyward.var_eec80a0a9fa2bef8 )
    {
        if ( weyward.var_12fc5301e1f11d2a[ bone ] == "exposed" )
        {
            exposed[ exposed.size ] = bone;
        }
    }
    
    return exposed;
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x84213481, Offset: 0xb35
// Size: 0xa9
function get_alive_metabones( weyward )
{
    alive = [];
    
    foreach ( bone in weyward.var_eec80a0a9fa2bef8 )
    {
        if ( weyward.var_12fc5301e1f11d2a[ bone ] != "destroyed" )
        {
            alive[ alive.size ] = bone;
        }
    }
    
    return alive;
}

// Namespace zombie_weyward_metabones
// Params 1
// Checksum 0x60458779, Offset: 0xbe7
// Size: 0xbc
function function_d59c74543d02814f( enabled )
{
    foreach ( bone in self.var_eec80a0a9fa2bef8 )
    {
        if ( self.var_12fc5301e1f11d2a[ bone ] != "destroyed" )
        {
            if ( enabled )
            {
                utility::function_7c10ea82c1e305b8( bone, self.var_12fc5301e1f11d2a[ bone ] );
                continue;
            }
            
            utility::function_7c10ea82c1e305b8( bone, "off" );
        }
    }
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x4
// Checksum 0xc096307c, Offset: 0xcab
// Size: 0x59
function private function_615b9549d81eec2d()
{
    self endon( #"death" );
    prev_shield_active = 0;
    
    while ( true )
    {
        shield_active = self.shadow_soul_shield_active;
        
        if ( shield_active != prev_shield_active )
        {
            prev_shield_active = shield_active;
            
            if ( shield_active )
            {
                function_95bdfacb85d7166c( 0 );
            }
            else
            {
                restore_metabones_active_state();
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_metabones
// Params 1, eflags: 0x4
// Checksum 0xbeefa182, Offset: 0xd0c
// Size: 0x86
function private function_95bdfacb85d7166c( active )
{
    foreach ( bone in self.var_eec80a0a9fa2bef8 )
    {
        metabone::set_metabone_active( bone, active );
    }
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x4
// Checksum 0xb64ace39, Offset: 0xd9a
// Size: 0xb0
function private restore_metabones_active_state()
{
    foreach ( bone in self.var_eec80a0a9fa2bef8 )
    {
        state = self.var_12fc5301e1f11d2a[ bone ];
        var_6ce00bee3e5f9c02 = state == "exposed" || state == "armored";
        metabone::set_metabone_active( bone, var_6ce00bee3e5f9c02 );
    }
}

// Namespace zombie_weyward_metabones
// Params 1, eflags: 0x4
// Checksum 0x3e7082c1, Offset: 0xe52
// Size: 0x16f
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    is_weyward_bone = arraycontains( self.var_eec80a0a9fa2bef8, metabone_name );
    
    if ( !is_weyward_bone )
    {
        return;
    }
    
    current_state = self.var_12fc5301e1f11d2a[ metabone_name ];
    
    if ( current_state == "armored" )
    {
        var_79f7d8e8159eba95 = "destroyed";
        self.var_12fc5301e1f11d2a[ metabone_name ] = var_79f7d8e8159eba95;
        metabone::set_metabone_state( metabone_name, var_79f7d8e8159eba95 );
        zombie_weyward_asm::function_69ff524cca32dbff( self, params.vpoint );
        thread function_d9d884ad7268f0ba( params );
        utility::function_7c10ea82c1e305b8( metabone_name, var_79f7d8e8159eba95 );
        
        if ( isdefined( self.metabone_ping_ents[ metabone_name ] ) )
        {
            self.metabone_ping_ents[ metabone_name ] delete();
        }
        
        self notify( #"weyward_armor_break", metabone_name );
        return;
    }
    
    if ( current_state == "exposed" )
    {
        self.var_12fc5301e1f11d2a[ metabone_name ] = "destroyed";
        utility::function_7c10ea82c1e305b8( metabone_name, "destroyed" );
        zombie_weyward_asm::function_69ff524cca32dbff( self, params.vpoint );
        self notify( #"metabone_destroyed", metabone_name );
        
        if ( isdefined( self.metabone_ping_ents[ metabone_name ] ) )
        {
            self.metabone_ping_ents[ metabone_name ] delete();
        }
        
        /#
            if ( function_20aeac1edd046d10() )
            {
                println( "<dev string:x54>" + metabone_name + "<dev string:x6a>" );
            }
        #/
    }
}

// Namespace zombie_weyward_metabones
// Params 1, eflags: 0x4
// Checksum 0xaed0162d, Offset: 0xfc9
// Size: 0xf9
function private function_d9d884ad7268f0ba( params )
{
    self endon( #"death" );
    waitframe();
    armor_break_damage = int( self.maxhealth * self.var_fefc4616d4cd2b95 );
    
    if ( armor_break_damage <= 0 )
    {
        return;
    }
    
    var_28755b2381cf7597 = int( self.var_aebba24aed9f1efd[ self.shadow_soul_phase ] * self.maxhealth );
    
    if ( var_28755b2381cf7597 != 0 && self.health > var_28755b2381cf7597 && self.health - armor_break_damage < var_28755b2381cf7597 )
    {
        armor_break_damage = self.health - var_28755b2381cf7597 + 1;
    }
    
    self.var_7037157e68c4992b = armor_break_damage;
    self dodamage( armor_break_damage, self.origin, params.eattacker ?? self, params.einflictor ?? self, "MOD_UNKNOWN", "<explicitweaponnone>", "none", undefined, 536936448 );
}

// Namespace zombie_weyward_metabones
// Params 0, eflags: 0x4
// Checksum 0xf4c356a, Offset: 0x10ca
// Size: 0x12, Type: bool
function private function_20aeac1edd046d10()
{
    return getdvarint( @"hash_2a528638a38df040", 0 ) > 0;
}

/#

    // Namespace zombie_weyward_metabones
    // Params 0, eflags: 0x4
    // Checksum 0x94255f75, Offset: 0x10e5
    // Size: 0x46, Type: dev
    function private function_4984df10f0449e9a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x75>" );
        devgui::add_devgui_func( "<dev string:x98>", "<dev string:xa8>", &function_3a4b57ae26f996a5, 1 );
        devgui::add_devgui_func( "<dev string:xc0>", "<dev string:xdb>", &function_e591c5d4787d69f3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_metabones
    // Params 1, eflags: 0x4
    // Checksum 0xe51c61bf, Offset: 0x1133
    // Size: 0x24, Type: dev
    function private function_3a4b57ae26f996a5( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xf6>", @"hash_2a528638a38df040" );
    }

    // Namespace zombie_weyward_metabones
    // Params 1, eflags: 0x4
    // Checksum 0x78fad014, Offset: 0x115f
    // Size: 0x4d, Type: dev
    function private function_e591c5d4787d69f3( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x10e>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        weyward function_995b6dfb3ab95f0c();
    }

#/
