// script_3d250c1a364843aa  (hash_3d250c1a364843aa.gscc) (size: 4801 Bytes / 0x12c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bda7cd6 (1004174550)
// size ...... 4801 (0x12c1)
// includes .. 6   (offset: 0x118d)
// strings ... 17  (offset: 0x11bd)
// dev strs .. 2   (offset: 0x12a9)
// exports ... 13  (offset: 0x9dd)
// cseg ...... 0x18b + 0x852 (0x9dd)
// imports ... 48  (offset: 0xbe5)
// animtree1 . 0   (offset: 0x12c1)
// animtree2 . 0   (offset: 0x12c1)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\playerhealth;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace namespace_8a6b6b859e6fcad;

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0x9f2c0e11, Offset: 0x1a9
// Size: 0xe9
function init()
{
    level utility::flag_wait( "scriptables_ready" );
    level.var_dcdf2aa7cb419ad4 = getentarray( "teleport_back_trigger", #targetname );
    teleport_back_pos = utility::getstruct( "teleport_back_pos", "targetname" );
    level.var_1552925d1fc3e4aa = utility::getstructarray( teleport_back_pos.target, "targetname" );
    assert( isdefined( level.var_dcdf2aa7cb419ad4 ) && level.var_dcdf2aa7cb419ad4.size != 0, "<dev string:x24>" );
    assert( isdefined( level.var_1552925d1fc3e4aa ) && level.var_1552925d1fc3e4aa.size != 0, "<dev string:x53>" );
    function_9cebbcdad9237b7d();
    level callback::add( #"player_connect", &on_player_connect );
    level._effect[ "teleport_splash_3p" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
}

// Namespace namespace_8a6b6b859e6fcad
// Params 1
// Checksum 0x6707fe9a, Offset: 0x29a
// Size: 0x1a
function on_player_connect( params )
{
    thread function_4cfdad6809bf200d();
    thread function_da39b2e320704c34();
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0x16acd8af, Offset: 0x2bc
// Size: 0x39c
function function_4cfdad6809bf200d()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self isnoclip() || self isufo() || self.sessionstate == "spectator" || self.var_b591aaffe204ef9b )
        {
            waitframe();
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"bgb", #"hash_e47d9b7a1bc28040" ) && !utility::callsharedfunc( #"bgb", #"hash_e47d9b7a1bc28040" ) )
        {
            waitframe();
            continue;
        }
        
        foreach ( check_volume in level.var_dcdf2aa7cb419ad4 )
        {
            if ( self istouching( check_volume ) )
            {
                if ( self.var_b8f7685b92948edf && isarray( self.var_b8f7685b92948edf ) && self.var_b8f7685b92948edf.size > 0 )
                {
                    foreach ( var_b2908b55947c7307 in self.var_b8f7685b92948edf )
                    {
                        if ( !isfunction( var_b2908b55947c7307 ) )
                        {
                            continue;
                        }
                        
                        self [[ var_b2908b55947c7307 ]]( check_volume );
                    }
                }
                
                if ( isdefined( self.var_5b28480c7d2cbeff ) )
                {
                    function_530dd8c997a5c843();
                    var_2ce3dc2482e72cc9 = utility::getstructarray( self.var_5b28480c7d2cbeff.target, "targetname" );
                    teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
                    self setadditionalstreamposuntilcleared( teleport_pos.origin );
                    callback::callback( #"hash_1a475dbe27e5bdde", { #teleport_pos:teleport_pos, #volume:check_volume } );
                    zm_utility::teleport_player( teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 0, 0.25, 0, 0.25 );
                    damage_dealt = function_c8b5c790334752c6();
                    self clearadditionalstreampos();
                    callback::callback( #"hash_6391eced0d5aa525", { #damage_dealt:damage_dealt, #teleport_pos:teleport_pos, #volume:check_volume } );
                }
                else
                {
                    function_530dd8c997a5c843();
                    var_2ce3dc2482e72cc9 = utility::getstructarray( level.var_1552925d1fc3e4aa.target, "targetname" );
                    teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
                    self setadditionalstreamposuntilcleared( teleport_pos.origin );
                    callback::callback( #"hash_1a475dbe27e5bdde", { #teleport_pos:teleport_pos, #volume:check_volume } );
                    zm_utility::teleport_player( teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 0, 0.25, 0, 0.25 );
                    damage_dealt = function_c8b5c790334752c6();
                    self clearadditionalstreampos();
                    callback::callback( #"hash_6391eced0d5aa525", { #damage_dealt:damage_dealt, #teleport_pos:teleport_pos, #volume:check_volume } );
                }
                
                thread function_4073c42f3bfa3cde();
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xfb9a4a7, Offset: 0x660
// Size: 0x46
function function_9626e363f2363aad()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_917b12e90f695a53" );
    self endon( #"hash_917b12e90f695a53" );
    wait 3;
    val::reset( "warp_back", "ignoreme" );
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xbe370bcb, Offset: 0x6ae
// Size: 0x64
function function_da39b2e320704c34()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( ispointonnavmesh( self.origin, self ) )
        {
            [ self.var_5b28480c7d2cbeff ] = sortbydistance( level.var_1552925d1fc3e4aa, self.origin );
        }
        
        wait 1;
    }
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xe15e0d40, Offset: 0x71a
// Size: 0x1c
function function_4073c42f3bfa3cde()
{
    if ( isdefined( level.var_c89ffb0ce61b7bf4 ) )
    {
        [[ level.var_c89ffb0ce61b7bf4 ]]( self );
    }
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xb02c9cf3, Offset: 0x73e
// Size: 0xe5
function function_a7464203b6956dd7()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waitframe();
    self setscriptablepartstate( "oob_teleport_sfx", "in", 0 );
    playfx( level._effect[ "teleport_splash_3p" ], self.origin );
    
    if ( level.var_82a2ecb4e88e12b )
    {
        utility::function_7c10ea82c1e305b8( "timetravel_fx", "timetravel" );
        
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        self modifybasefov( getdvarfloat( @"cg_targetbasefov", 65 ) * 1.5, 0.125 );
        wait 0.125;
        utility::function_32b24db3127bff40( "timetravel_fx", "off" );
        
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        self modifybasefov( getdvarfloat( @"cg_targetbasefov", 65 ), 0.25 );
    }
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xca0ae7a1, Offset: 0x82b
// Size: 0x6d
function function_530dd8c997a5c843()
{
    self setscriptablepartstate( "oob_teleport_sfx", "out", 0 );
    
    if ( level.var_82a2ecb4e88e12b )
    {
        if ( self function_41360f0bcfc012aa() || self function_1984b449042336ef() )
        {
            self function_5c764e554642cf04();
        }
        
        self modifybasefov( getdvarfloat( @"cg_targetbasefov", 65 ) * 0.7, 0.125 );
        utility::function_7c10ea82c1e305b8( "timetravel_fx", "warm_up" );
        wait 0.25;
    }
}

// Namespace namespace_8a6b6b859e6fcad
// Params 1
// Checksum 0xddffafd, Offset: 0x8a0
// Size: 0x63
function function_c8b5c790334752c6( deal_damage = 1 )
{
    thread function_a7464203b6956dd7();
    level thread zm_quest::function_835556fe63cd2edd( self.origin, 256, level.var_e04fc4037b04adbd );
    damage_dealt = 0;
    
    if ( deal_damage )
    {
        damage_dealt = function_3c2be87f2b55e5c4();
        
        if ( damage_dealt == 0 )
        {
            thread function_7e309777fa560cd3();
        }
    }
    
    return damage_dealt;
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0xe669ae93, Offset: 0x90c
// Size: 0x6b
function function_3c2be87f2b55e5c4()
{
    damage = self.health / 2;
    damage = clamp( damage, 1, self.maxhealth );
    
    if ( damage > 1 )
    {
        if ( !isdefined( level.var_a43ba61f9fd6349f ) )
        {
            function_9cebbcdad9237b7d();
        }
        
        self dodamage( damage, self.origin, level.var_a43ba61f9fd6349f );
    }
    else
    {
        return 0;
    }
    
    return damage;
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0
// Checksum 0x74fc17da, Offset: 0x980
// Size: 0x1c
function function_7e309777fa560cd3()
{
    self endon( #"death" );
    wait 4;
    waitframe();
    playerhealth::forcehealthregen( self, 1 );
}

// Namespace namespace_8a6b6b859e6fcad
// Params 0, eflags: 0x4
// Checksum 0xc3e56995, Offset: 0x9a4
// Size: 0x39
function private function_9cebbcdad9237b7d()
{
    level.var_a43ba61f9fd6349f = utility::spawn_tag_origin( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_a43ba61f9fd6349f show();
}

