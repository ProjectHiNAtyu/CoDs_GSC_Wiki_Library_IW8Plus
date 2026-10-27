// script_6148f48a602d9ec2  (hash_6148f48a602d9ec2.gscc) (size: 4099 Bytes / 0x1003 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x559f63ad (1436509101)
// size ...... 4099 (0x1003)
// includes .. 6   (offset: 0xf1f)
// strings ... 10  (offset: 0xf4f)
// dev strs .. 2   (offset: 0xfeb)
// exports ... 14  (offset: 0x8c7)
// cseg ...... 0x133 + 0x794 (0x8c7)
// imports ... 35  (offset: 0xaf7)
// animtree1 . 0   (offset: 0x1003)
// animtree2 . 0   (offset: 0x1003)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace namespace_1538088e27c877a6;

// Namespace namespace_1538088e27c877a6
// Params 0, eflags: 0x5
// Checksum 0x8feca724, Offset: 0x151
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_627937302bfec48a", undefined, &function_8a787e0cfdebd4a, undefined );
}

// Namespace namespace_1538088e27c877a6
// Params 0
// Checksum 0x26e6bb43, Offset: 0x172
// Size: 0xa
function function_8a787e0cfdebd4a()
{
    level thread function_1226e8d06f6b817f();
}

// Namespace namespace_1538088e27c877a6
// Params 0
// Checksum 0xf34f285, Offset: 0x184
// Size: 0x1c
function function_1226e8d06f6b817f()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_a9ca76ba59ad45f0", &function_fd9f7ad97be38537, &function_c1c3f3c2bd19ce52 );
}

// Namespace namespace_1538088e27c877a6
// Params 0
// Checksum 0x2e3f01c6, Offset: 0x1a8
// Size: 0x128
function function_fd9f7ad97be38537()
{
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_relic_challenge_objective_updated", &function_3f9a443247354954 );
    callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    common_item::function_5734400f32ca9803( "armor", &function_59dcbcf15bc70812 );
    level.var_9f033af857d26bea = level.bgb[ "armor_gettin" ].var_866744e27c70eb1c;
    level.bgb[ "armor_gettin" ].var_866744e27c70eb1c = &function_b045395aa92f278a;
    setomnvar( "ui_show_armor_plates_crafting_bench", 0 );
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player thread function_fadc18c2d96d5073();
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_1538088e27c877a6
// Params 0
// Checksum 0xde476a90, Offset: 0x2d8
// Size: 0x117
function function_c1c3f3c2bd19ce52()
{
    level notify( #"hash_1b0b13cfdc18040a" );
    callback::remove( "on_relic_challenge_objective_updated", &function_3f9a443247354954 );
    callback::remove( #"player_spawned", &on_player_spawned );
    callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    common_item::function_134b9624f3886a06( "armor", &function_59dcbcf15bc70812 );
    level.bgb[ "armor_gettin" ].var_866744e27c70eb1c = level.var_9f033af857d26bea;
    setomnvar( "ui_show_armor_plates_crafting_bench", 1 );
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player thread function_e8cd1b831889eec6();
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x58>" );
    #/
}

// Namespace namespace_1538088e27c877a6
// Params 1, eflags: 0xc
// Checksum 0x769ae4fb, Offset: 0x3f7
// Size: 0x3d
function private on_player_spawned( params )
{
    self notify( #"hash_380df535fa8d52e3" );
    self endon( #"hash_380df535fa8d52e3" );
    self endon( #"death_or_disconnect" );
    wait 0.5;
    thread function_fadc18c2d96d5073();
}

// Namespace namespace_1538088e27c877a6
// Params 0, eflags: 0xc
// Checksum 0xace66477, Offset: 0x43c
// Size: 0x157
function private function_fadc18c2d96d5073()
{
    self notify( #"hash_e0b09e19d85a2ab1" );
    self endon( #"hash_e0b09e19d85a2ab1" );
    level endon( #"hash_1b0b13cfdc18040a" );
    level endon( #"game_ended" );
    player_id = self getentitynumber();
    level.var_d1aa1d2e51a969bb[ player_id ] = {};
    level.var_d1aa1d2e51a969bb[ player_id ].armor = self.platecarrierlevel;
    level.var_d1aa1d2e51a969bb[ player_id ].has_gold_armor = self.var_a1faa64d8c07872e;
    self.maxarmorhealth = 0;
    armor::setarmorhealth( 0 );
    self setclientomnvar( "ui_armor_current_level", 0 );
    self setclientomnvar( "ui_show_armor_global", 0 );
    self.var_cdbf0145adf184dc = 1;
    utility::callsharedfunc( #"zombie", #"take_golden_armor" );
    
    while ( level.active_relic_challenge )
    {
        if ( isalive( self ) && !self.inlaststand )
        {
            if ( self.health >= self.maxhealth - 50 )
            {
                self.health = self.maxhealth - 50;
                damageendon = level.var_a7ab4a7d847b718a ?? #"damage";
                self notify( damageendon );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_1538088e27c877a6
// Params 0, eflags: 0x4
// Checksum 0x1913e120, Offset: 0x59b
// Size: 0x3, Type: bool
function private function_b045395aa92f278a()
{
    return false;
}

// Namespace namespace_1538088e27c877a6
// Params 1
// Checksum 0xe465331f, Offset: 0x5a7
// Size: 0x4a
function function_59dcbcf15bc70812( params )
{
    if ( level.active_relic_challenge && params.itembundle.subtype == "armor" )
    {
        waittillframeend();
        common_item::function_869d7676e359a627( params.item );
    }
}

// Namespace namespace_1538088e27c877a6
// Params 0
// Checksum 0x3c9bb53f, Offset: 0x5f9
// Size: 0x8b
function function_e8cd1b831889eec6()
{
    player_id = self getentitynumber();
    function_fdbe2cad6d8bb7e7( level.var_d1aa1d2e51a969bb[ player_id ].armor );
    self.var_a1faa64d8c07872e = level.var_d1aa1d2e51a969bb[ player_id ].has_gold_armor;
    self.var_cdbf0145adf184dc = undefined;
    self setclientomnvar( "ui_show_armor_global", 1 );
    
    if ( self.var_a1faa64d8c07872e )
    {
        utility::callsharedfunc( #"zombie", #"set_golden_armor" );
    }
}

// Namespace namespace_1538088e27c877a6
// Params 1
// Checksum 0x5f150141, Offset: 0x68c
// Size: 0xf0
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 50;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 100;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 150;
    platecarrierlevel = minint( 3, platecarrierlevel );
    self.platecarrierlevel = platecarrierlevel;
    
    if ( platecarrierlevel == 1 )
    {
        self.maxarmorhealth = var_219886ad4a381968;
        armor::setarmorhealth( var_219886ad4a381968 );
    }
    else if ( platecarrierlevel == 2 )
    {
        self.maxarmorhealth = var_554023bac16105cf;
        armor::setarmorhealth( var_554023bac16105cf );
    }
    else if ( platecarrierlevel == 3 )
    {
        self.maxarmorhealth = var_3dc0c4e27d22d986;
        armor::setarmorhealth( var_3dc0c4e27d22d986 );
    }
    
    self setclientomnvar( "ui_armor_current_level", platecarrierlevel );
}

// Namespace namespace_1538088e27c877a6
// Params 1
// Checksum 0x5fd951b5, Offset: 0x784
// Size: 0xbe
function function_3f9a443247354954( params )
{
    if ( level.timetravel && level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 && !level.active_relic_challenge.var_31c1cd6a7fdda018 )
    {
        if ( !isdefined( level.active_relic_challenge.var_31c1cd6a7fdda018 ) )
        {
            level.active_relic_challenge.var_31c1cd6a7fdda018 = 0;
        }
        
        level.active_relic_challenge.var_31c1cd6a7fdda018++;
        
        if ( utility::issharedfuncdefined( #"sat_timetravel", #"timetravel" ) )
        {
            level utility::callsharedfunc( #"sat_timetravel", #"timetravel" );
        }
    }
}

// Namespace namespace_1538088e27c877a6
// Params 1
// Checksum 0x891a83b3, Offset: 0x84a
// Size: 0x7d
function on_zombie_ai_spawned( params )
{
    wait 1;
    
    if ( self && isalive( self ) && isdefined( self.subclass ) && issubstr( self.subclass, "zombie_base" ) && utility::cointoss() )
    {
        speed = "run";
        utility::callsharedfunc( #"zombie_utils", #"setmovespeed", speed, "relic_challenge", 9 );
    }
}

