// scripts\common\ai\aitypes\zombie_orion\zombie_orion_metabones.gsc  (hash_192eb9007329c051.gscc) (size: 2125 Bytes / 0x84d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad6f1b7b (2909739899)
// size ...... 2125 (0x84d)
// includes .. 3   (offset: 0x735)
// strings ... 12  (offset: 0x74d)
// dev strs .. 0   (offset: 0x84d)
// exports ... 5   (offset: 0x4b5)
// cseg ...... 0x117 + 0x39e (0x4b5)
// imports ... 13  (offset: 0x57d)
// animtree1 . 0   (offset: 0x84d)
// animtree2 . 0   (offset: 0x84d)
#using script_15dcfcf56850a061;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_orion_metabones;

// Namespace zombie_orion_metabones
// Params 0, eflags: 0x1
// Checksum 0x2b0cf7a7, Offset: 0x135
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_orion";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_orion_metabones
// Params 0
// Checksum 0x20bea529, Offset: 0x15e
// Size: 0x1ce
function init()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4c49eacd60232b1f > randomfloat( 1 ) )
    {
        utility::function_7c10ea82c1e305b8( "head_armor", "on" );
        utility::function_7c10ea82c1e305b8( "base", "base_on_mask" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "base", "base_on" );
        metabone::set_metabone_state( "head_armor", "destroyed" );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6a79a5581788da0e > randomfloat( 1 ) )
    {
        metabone::set_metabone_active( "chest_armor", 1 );
        utility::function_7c10ea82c1e305b8( "chest_armor", "on" );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9395ee9aa9dc7f2e > randomfloat( 1 ) )
    {
        metabone::set_metabone_active( "left_shoulder_armor", 1 );
        utility::function_7c10ea82c1e305b8( "left_shoulder_armor", "on" );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_933e84897b705b37 > randomfloat( 1 ) )
    {
        metabone::set_metabone_active( "right_shoulder_armor", 1 );
        utility::function_7c10ea82c1e305b8( "right_shoulder_armor", "on" );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_46c977678cd08ca4 > randomfloat( 1 ) )
    {
        metabone::set_metabone_active( "left_forearm_armor", 1 );
        utility::function_7c10ea82c1e305b8( "left_forearm_armor", "on" );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b5422ec54f5f53f > randomfloat( 1 ) )
    {
        metabone::set_metabone_active( "right_forearm_armor", 1 );
        utility::function_7c10ea82c1e305b8( "right_forearm_armor", "on" );
    }
}

// Namespace zombie_orion_metabones
// Params 1
// Checksum 0xf238dad0, Offset: 0x334
// Size: 0x105
function destroy_armor( b_on_death )
{
    armor_pieces = [ "head_armor", "chest_armor", "left_shoulder_armor", "right_shoulder_armor", "left_forearm_armor", "right_forearm_armor" ];
    
    foreach ( armor_piece in armor_pieces )
    {
        if ( self getscriptablehaspart( armor_piece ) && self getscriptableparthasstate( armor_piece, "destroyed" ) && self getscriptablepartstate( armor_piece ) == "on" )
        {
            self setscriptablepartstate( armor_piece, "destroyed" );
            
            if ( b_on_death )
            {
                self.var_ee4496185273b139[ armor_piece ] = "destroyed";
            }
        }
    }
}

// Namespace zombie_orion_metabones
// Params 1, eflags: 0x4
// Checksum 0x185b17e1, Offset: 0x441
// Size: 0x74
function private on_metabone_destroyed( params )
{
    metabone::set_metabone_state( params.metabone_name, "destroyed" );
    utility::function_32b24db3127bff40( params.metabone_name, "destroyed" );
    
    if ( params.metabone_name == "head_armor" )
    {
        metabone::set_metabone_active( "head_armor", 1 );
        utility::function_7c10ea82c1e305b8( "base", "base_on" );
    }
    
    zombie_orion_asm::cause_special_pain();
}

