// script_7b4d6e13aa956aac  (hash_7b4d6e13aa956aac.gscc) (size: 5259 Bytes / 0x148b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87363d91 (2268478865)
// size ...... 5259 (0x148b)
// includes .. 6   (offset: 0x11bf)
// strings ... 31  (offset: 0x11ef)
// dev strs .. 1   (offset: 0x147f)
// exports ... 14  (offset: 0xb13)
// cseg ...... 0x2b1 + 0x862 (0xb13)
// imports ... 35  (offset: 0xd43)
// animtree1 . 0   (offset: 0x148b)
// animtree2 . 0   (offset: 0x148b)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_triton_hibernation;

/#

    // Namespace zombie_triton_hibernation
    // Params 0
    // Checksum 0x196ebeef, Offset: 0x2cf
    // Size: 0x1a, Type: dev
    function function_55532305c3a5adc4()
    {
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"do_triton_hibernation", &function_b686f0d241124e7d );
    }

#/

// Namespace zombie_triton_hibernation
// Params 0
// Checksum 0xd12890a6, Offset: 0x2f1
// Size: 0x7b
function hibernation_start()
{
    self.var_fa202e3c1b788e39 = 1;
    val::set( "triton_hibernation", "ignoreall", 1 );
    val::set( "triton_hibernation", "collide_with_ai_allies", 0 );
    val::set( "triton_hibernation", "script_pushable_by_ai", 0 );
    val::set( "triton_hibernation", "script_pushable", 0 );
    val::set( "triton_hibernation", "ignore_ai_collision", 0 );
    asm::function_7256f5ba459c840b( "hibernation_in" );
    thread function_51fc4725441d847a();
}

// Namespace zombie_triton_hibernation
// Params 0
// Checksum 0x65c12630, Offset: 0x374
// Size: 0x1e
function hibernation_end()
{
    asm::asm_fireevent( self.asmname, "end_triton_hibernation" );
    thread function_ef3523217261826d();
}

// Namespace zombie_triton_hibernation
// Params 0
// Checksum 0xa490d7d1, Offset: 0x39a
// Size: 0xf
function function_2745916b4fe4d67d()
{
    self function_786bb6aa1b76c7ee( "in_hibernation_phase", 1 );
}

// Namespace zombie_triton_hibernation
// Params 0
// Checksum 0x3fcfa06d, Offset: 0x3b1
// Size: 0xe
function function_a158e8b272958836()
{
    self function_786bb6aa1b76c7ee( "in_hibernation_phase", 0 );
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0x3546beb4, Offset: 0x3c7
// Size: 0x94
function private function_51fc4725441d847a()
{
    self endon( #"death" );
    hibernation_start_timeout = getdvarfloat( @"triton_hibernation_start_timeout", 4 );
    
    if ( hibernation_start_timeout > 0 )
    {
        utility::waittill_any_timeout( hibernation_start_timeout, "triton_hibernation_impact" );
    }
    else
    {
        self waittill( #"triton_hibernation_impact" );
    }
    
    utility::function_32b24db3127bff40( "hibernation_blast", "on" );
    var_6f70eb4b838ef81c = 55;
    utility::function_7c10ea82c1e305b8( "hibernation", "hard_lava" );
    function_af467bccca92a304();
    function_6668bf61dee47924();
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0x25290649, Offset: 0x463
// Size: 0x12b
function private function_af467bccca92a304()
{
    utility::function_32b24db3127bff40( "base", "hibernation" );
    
    if ( metabone::get_metabone_state_name( "armored_chest" ) == "destroyed" || metabone::get_metabone_state_name( "armored_chest" ) == "weakspot" )
    {
        utility::function_32b24db3127bff40( "armored_chest", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_shoulder_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_shoulder_left", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_shoulder_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_shoulder_right", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_gauntlet_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_gauntlet_left", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_gauntlet_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_gauntlet_right", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_leg_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_leg_left", "hibernation_destroyed_in" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_leg_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_leg_right", "hibernation_destroyed_in" );
    }
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0xc58194f9, Offset: 0x596
// Size: 0x162
function private function_6668bf61dee47924()
{
    self.var_96aeab02b8f57848 = [];
    var_f5b36fc50a58a5bf = getarraykeys( self.armorents );
    
    foreach ( var_1b23e8e2cb45ba36 in var_f5b36fc50a58a5bf )
    {
        var_96aeab02b8f57848 = spawnstruct();
        var_96aeab02b8f57848.tagname = self.armorents[ var_1b23e8e2cb45ba36 ].tagname;
        var_96aeab02b8f57848.metabonename = var_1b23e8e2cb45ba36;
        var_dc5aaea635094b9c = self.armorents[ var_1b23e8e2cb45ba36 ] getscriptablepartstate( "armor" );
        
        switch ( var_dc5aaea635094b9c )
        {
            case #"hash_a13dca2f9f010825":
                var_96aeab02b8f57848.var_90942f5fd23756ad = "armored";
                break;
            case #"hash_f2b431c975ba652c":
                var_96aeab02b8f57848.var_90942f5fd23756ad = "destroyed";
                break;
        }
        
        self.var_96aeab02b8f57848[ self.var_96aeab02b8f57848.size ] = var_96aeab02b8f57848;
        self.armorents[ var_1b23e8e2cb45ba36 ] delete();
    }
    
    self.armorents = undefined;
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0x4ca54cfa, Offset: 0x700
// Size: 0x61
function private function_ef3523217261826d()
{
    self endon( #"death" );
    self waittill( #"triton_hibernation_breaking" );
    utility::function_32b24db3127bff40( "hibernation_blast", "off" );
    self.var_fa202e3c1b788e39 = 0;
    val::reset_all( "triton_hibernation" );
    utility::function_7c10ea82c1e305b8( "hibernation", "off" );
    function_e55a54d932890b98();
    function_fe0848d5171d596d();
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0xf0713799, Offset: 0x769
// Size: 0x1ad
function private function_e55a54d932890b98()
{
    var_35e27aaa3934f43c = [];
    
    /#
        var_865421e311a1b382 = getdvarint( @"hash_76ca568d9a385772", 0 );
    #/
    
    if ( isdefined( self.var_96aeab02b8f57848 ) )
    {
        foreach ( var_23bd31c3a335ef2b in self.var_96aeab02b8f57848 )
        {
            tagorigin = self gettagorigin( var_23bd31c3a335ef2b.tagname );
            var_a118202a384529bb = utility::spawn_model( "c_t10_triton_armor_piece_ping", tagorigin, self.angles );
            var_a118202a384529bb linkto( self, var_23bd31c3a335ef2b.tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            var_a118202a384529bb.tagname = var_23bd31c3a335ef2b.tagname;
            var_a118202a384529bb enableaimassist();
            
            if ( var_23bd31c3a335ef2b.var_90942f5fd23756ad == "armored" )
            {
                var_a118202a384529bb setscriptablepartstate( "armor", "armored" );
            }
            else if ( var_23bd31c3a335ef2b.var_90942f5fd23756ad == "destroyed" )
            {
                var_a118202a384529bb setscriptablepartstate( "armor", "destroyed" );
            }
            
            var_35e27aaa3934f43c[ var_23bd31c3a335ef2b.metabonename ] = var_a118202a384529bb;
            
            /#
                if ( var_865421e311a1b382 )
                {
                    thread function_543e4811689c99e6( var_a118202a384529bb );
                }
            #/
        }
        
        self.armorents = var_35e27aaa3934f43c;
        self.var_96aeab02b8f57848 = undefined;
    }
}

// Namespace zombie_triton_hibernation
// Params 0, eflags: 0x4
// Checksum 0xf67dd422, Offset: 0x91e
// Size: 0x14f
function private function_fe0848d5171d596d()
{
    utility::function_32b24db3127bff40( "base", "base_on" );
    utility::function_32b24db3127bff40( "hibernation_blast", "off" );
    
    if ( metabone::get_metabone_state_name( "armored_chest" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_chest", "hibernation_destroyed_out" );
    }
    else if ( metabone::get_metabone_state_name( "armored_chest" ) == "weakspot" )
    {
        utility::function_32b24db3127bff40( "armored_chest", "weakspot" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_shoulder_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_shoulder_left", "hibernation_destroyed_out" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_shoulder_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_shoulder_right", "hibernation_destroyed_out" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_gauntlet_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_gauntlet_left", "hibernation_destroyed_out" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_gauntlet_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_gauntlet_right", "hibernation_destroyed_out" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_leg_left" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_leg_left", "hibernation_destroyed_out" );
    }
    
    if ( metabone::get_metabone_state_name( "armored_leg_right" ) == "destroyed" )
    {
        utility::function_32b24db3127bff40( "armored_leg_right", "hibernation_destroyed_out" );
    }
}

/#

    // Namespace zombie_triton_hibernation
    // Params 1
    // Checksum 0xf57eca8, Offset: 0xa75
    // Size: 0x60, Type: dev
    function function_b686f0d241124e7d( params )
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isdefined( triton ) )
        {
            triton hibernation_start();
            wait 10;
            
            if ( isalive( triton ) )
            {
                triton hibernation_end();
            }
        }
    }

    // Namespace zombie_triton_hibernation
    // Params 1, eflags: 0x4
    // Checksum 0x43b4d7b9, Offset: 0xadd
    // Size: 0x36, Type: dev
    function private function_543e4811689c99e6( armorent )
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( armorent.origin, 5 );
            waitframe();
        }
    }

#/
