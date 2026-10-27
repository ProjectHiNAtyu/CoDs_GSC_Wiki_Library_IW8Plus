// scripts\common\ai\aitypes\zombie_viper\zombie_viper_shield.gsc  (hash_61f9761e9c332cde.gscc) (size: 2434 Bytes / 0x982 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4a9a02a (3299450922)
// size ...... 2434 (0x982)
// includes .. 5   (offset: 0x872)
// strings ... 11  (offset: 0x89a)
// dev strs .. 4   (offset: 0x942)
// exports ... 7   (offset: 0x53e)
// cseg ...... 0xf9 + 0x445 (0x53e)
// imports ... 18  (offset: 0x656)
// animtree1 . 0   (offset: 0x982)
// animtree2 . 0   (offset: 0x982)
#using script_338ec3ea121b70eb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug_utility;

#namespace zombie_viper_shield;

// Namespace zombie_viper_shield
// Params 0
// Checksum 0xa2742160, Offset: 0x117
// Size: 0xed
function init()
{
    if ( !self.var_d6894f01a36b4ff3.var_a8c018f581370760.size )
    {
        return;
    }
    
    foreach ( shield_data in self.var_d6894f01a36b4ff3.var_a8c018f581370760 )
    {
        if ( shield_data.healthpct > 0 && shield_data.reducedamage > 0 )
        {
            zombie_utils::register_health_state_callback( shield_data.healthpct, &activate_tesla_coil_shield );
        }
    }
    
    /#
        self.var_c6a8d665ee275d61 = 1;
        self.var_142a22f5e3e307a6 = 1;
        thread debug_tesla_coil();
    #/
}

// Namespace zombie_viper_shield
// Params 2, eflags: 0x4
// Checksum 0x1b66ef1a, Offset: 0x20c
// Size: 0x91
function private activate_tesla_coil_shield( healthpct, params )
{
    if ( metabone::get_metabone_state_name( "tesla_coil_left" ) == "destroyed" && metabone::get_metabone_state_name( "tesla_coil_right" ) == "destroyed" )
    {
        return;
    }
    
    if ( self.tesla_coil_shield_enabled )
    {
        return;
    }
    
    self.tesla_coil_shield_enabled = 1;
    utility::function_32b24db3127bff40( "tesla_coil_shield", "on" );
    zombie_utils::function_584d912c70295d81( healthpct, [ "j_attachment_2_le", "j_attachment_2_ri" ] );
    metabone::set_metabone_active( "head_bot", 0 );
}

// Namespace zombie_viper_shield
// Params 1
// Checksum 0xe5bd84ee, Offset: 0x2a5
// Size: 0x69
function deactivate_tesla_coil_shield( destroyed )
{
    if ( self.tesla_coil_shield_enabled )
    {
        self.tesla_coil_shield_enabled = 0;
        zombie_utils::function_6467c6da3b68c7e5();
        utility::function_32b24db3127bff40( "tesla_coil_shield", destroyed ? "destroyed" : "off" );
        
        if ( metabone::get_metabone_state_name( "helmet" ) == "destroyed" )
        {
            metabone::set_metabone_active( "head_bot", 1 );
        }
    }
}

// Namespace zombie_viper_shield
// Params 1
// Checksum 0x433c0dd1, Offset: 0x316
// Size: 0x68
function function_db73948dc02ab553( part_name )
{
    assert( part_name == "<dev string:x24>" || part_name == "<dev string:x34>" );
    
    /#
        if ( part_name == "<dev string:x24>" )
        {
            self.var_c6a8d665ee275d61 = 0;
        }
        else if ( part_name == "<dev string:x34>" )
        {
            self.var_142a22f5e3e307a6 = 0;
        }
    #/
    
    deactivate_tesla_coil_shield( 1 );
    zombie_viper_asm::cause_special_pain();
}

// Namespace zombie_viper_shield
// Params 1
// Checksum 0xb989710e, Offset: 0x386
// Size: 0xd4
function function_6628f4ddea2e4b67( params )
{
    assert( params.metabone_name == "<dev string:x24>" || params.metabone_name == "<dev string:x34>" );
    
    if ( self getscriptablehaspart( params.metabone_name ) && self getscriptablepartstate( params.metabone_name ) == "on" )
    {
        max_health = metabone::get_metabone_maxhealth( params.metabone_name, "on" );
        
        if ( params.health <= max_health * 0.5 )
        {
            utility::function_32b24db3127bff40( params.metabone_name, "damaged" );
            
            if ( self.tesla_coil_shield_enabled )
            {
                utility::function_32b24db3127bff40( "tesla_coil_shield", "damaged" );
            }
        }
    }
}

/#

    // Namespace zombie_viper_shield
    // Params 0, eflags: 0x4
    // Checksum 0xd398ffbb, Offset: 0x462
    // Size: 0xdc, Type: dev
    function private debug_tesla_coil()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"ejected" );
        
        while ( self.var_c6a8d665ee275d61 || self.var_142a22f5e3e307a6 )
        {
            if ( getdvarint( @"hash_47a477661a4e8bcc", 0 ) != 1 )
            {
                waitframe();
                continue;
            }
            
            if ( self.var_c6a8d665ee275d61 )
            {
                pos = self gettagorigin( "<dev string:x45>" );
                level thread debug_utility::drawsphere( pos, 5, level.framedurationseconds, ( 0, 1, 0 ) );
            }
            
            if ( self.var_142a22f5e3e307a6 )
            {
                pos = self gettagorigin( "<dev string:x57>" );
                level thread debug_utility::drawsphere( pos, 5, level.framedurationseconds, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
