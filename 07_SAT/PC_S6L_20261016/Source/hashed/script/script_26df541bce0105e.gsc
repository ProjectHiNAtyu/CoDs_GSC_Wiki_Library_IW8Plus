// script_26df541bce0105e  (hash_026df541bce0105e.gscc) (size: 4967 Bytes / 0x1367 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa01a0535 (2686059829)
// size ...... 4967 (0x1367)
// includes .. 6   (offset: 0x118f)
// strings ... 31  (offset: 0x11bf)
// dev strs .. 1   (offset: 0x135b)
// exports ... 13  (offset: 0xaf7)
// cseg ...... 0x2b9 + 0x83e (0xaf7)
// imports ... 39  (offset: 0xcff)
// animtree1 . 0   (offset: 0x1367)
// animtree2 . 0   (offset: 0x1367)
#using script_16ea1b94f0f381b3;
#using script_2de83d6261680959;
#using script_69318f8d1ba7f072;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\utility;

#namespace zombie_diana_hibernation;

/#

    // Namespace zombie_diana_hibernation
    // Params 0
    // Checksum 0xe9f634dc, Offset: 0x2d7
    // Size: 0x1a, Type: dev
    function function_a1a5fc025f5d7813()
    {
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_84027bc8c372020c", &function_b686f0d241124e7d );
    }

#/

// Namespace zombie_diana_hibernation
// Params 0
// Checksum 0xd69fc1d9, Offset: 0x2f9
// Size: 0x9
function hibernation_start()
{
    thread hibernation_start_listener();
}

// Namespace zombie_diana_hibernation
// Params 0
// Checksum 0x63f7403a, Offset: 0x30a
// Size: 0x121
function hibernation_end()
{
    var_6db6db8384ea061b = utility::array_random( getarraykeys( self.vantagepoints ) );
    self.vantagepoint = var_6db6db8384ea061b;
    var_ed290e9f43580cf8 = self.vantagepoints[ var_6db6db8384ea061b ];
    entrystartpoint = anglestoforward( var_ed290e9f43580cf8.angles ) * -2000;
    entrystartpoint = var_ed290e9f43580cf8.origin + entrystartpoint + ( 0, 0, -2000 );
    self forceteleport( entrystartpoint, var_ed290e9f43580cf8.angles, 40000 );
    function_1e56472b6212eed1( var_ed290e9f43580cf8 );
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "intro_finish", "intro_finish", entrystartpoint, var_ed290e9f43580cf8.angles, "returning_to_arena" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    
    if ( self.bossfightphase == 2 )
    {
        zombie_diana_metabones::function_c6fe3062616ddd88( 2, 1 );
    }
    else if ( self.bossfightphase >= 3 )
    {
        zombie_diana_metabones::function_c6fe3062616ddd88( 1, 1 );
    }
    
    self.var_382b3e1f72536e3c = undefined;
    thread zombie_diana::function_9cc2b48802345520();
    thread function_ef3523217261826d();
}

// Namespace zombie_diana_hibernation
// Params 0
// Checksum 0x60407080, Offset: 0x433
// Size: 0xf
function function_2745916b4fe4d67d()
{
    self function_786bb6aa1b76c7ee( "in_hibernation_phase", 1 );
}

// Namespace zombie_diana_hibernation
// Params 0
// Checksum 0xfb1f073c, Offset: 0x44a
// Size: 0xe
function function_a158e8b272958836()
{
    self function_786bb6aa1b76c7ee( "in_hibernation_phase", 0 );
}

// Namespace zombie_diana_hibernation
// Params 0, eflags: 0x4
// Checksum 0xb9df17e1, Offset: 0x460
// Size: 0x1c0
function private hibernation_start_listener()
{
    self endon( #"death", #"diana_death_igc_transition" );
    
    if ( self getaiblackboarddynamic( "in_idle_waiting_for_action" ) )
    {
        self notify( #"hibernation_start" );
    }
    
    if ( self getaiblackboarddynamic( "in_necrotic_projectile" ) || self getaiblackboarddynamic( "in_move" ) || self getaiblackboarddynamic( "in_summon_agni_zombies" ) || self getaiblackboarddynamic( "in_necrotic_beam" ) || self getaiblackboarddynamic( "in_necrotic_fan" ) || self getaiblackboarddynamic( "in_winged_tornado_attack" ) || self getaiblackboarddynamic( "in_armor_break" ) )
    {
        utility::waittill_any_in_array_or_timeout( [ "diana_move_end", "necrotic_projectile_end", "summon_agnis_end", "necrotic_beam_anim_end", "necrotic_fan_end", "winged_tornado_attack_end", "armor_break_end" ], 25 );
        
        if ( self.inflyover )
        {
            utility::waittill_notify_or_timeout( "move_fly_over_complete", 5.5 );
        }
    }
    
    self.var_fbd2b9707b5bd16f = 1;
    self function_786bb6aa1b76c7ee( "in_hibernation_phase", 1 );
    utility::waittill_notify_or_timeout( "idle_loop_end", 2 );
    self.var_382b3e1f72536e3c = 1;
    self.var_50718c08923dcdbb = 0;
    thread zombie_diana::function_9cc2b48802345520();
    
    if ( !isdefined( self.var_80521f0adf3a76b9 ) || utility::time_has_passed( self.var_80521f0adf3a76b9, 12 ) )
    {
        asm::function_7256f5ba459c840b( "special_pain_in" );
        utility::waittill_notify_or_timeout( "special_pain_end", 5 );
    }
    
    asm::function_7256f5ba459c840b( "phase_intro_in" );
    utility::waittill_notify_or_timeout( "phase_intro_end", 6 );
    utility::function_32b24db3127bff40( "base", "hibernation_start" );
    function_6668bf61dee47924();
    self notify( #"hibernation_start_complete" );
}

// Namespace zombie_diana_hibernation
// Params 0, eflags: 0x4
// Checksum 0x1a05eff2, Offset: 0x628
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

// Namespace zombie_diana_hibernation
// Params 0, eflags: 0x4
// Checksum 0xea1b2c9b, Offset: 0x792
// Size: 0x30
function private function_ef3523217261826d()
{
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "intro_finished", 4.5 );
    function_e55a54d932890b98();
    self.var_fbd2b9707b5bd16f = undefined;
}

// Namespace zombie_diana_hibernation
// Params 0, eflags: 0x4
// Checksum 0x70654583, Offset: 0x7ca
// Size: 0x1c5
function private function_e55a54d932890b98()
{
    var_35e27aaa3934f43c = [];
    
    /#
        var_865421e311a1b382 = getdvarint( @"hash_fa5ceebc80902f57", 0 );
    #/
    
    if ( isdefined( self.var_96aeab02b8f57848 ) )
    {
        foreach ( var_23bd31c3a335ef2b in self.var_96aeab02b8f57848 )
        {
            tagorigin = self gettagorigin( var_23bd31c3a335ef2b.tagname );
            var_a118202a384529bb = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_35d4d2204f8cf1c4, tagorigin, self.angles );
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

// Namespace zombie_diana_hibernation
// Params 1, eflags: 0x4
// Checksum 0x28699659, Offset: 0x997
// Size: 0xba
function private function_1e56472b6212eed1( var_ed290e9f43580cf8 )
{
    traversalattributes = {};
    traversalattributes.startpos = self.origin;
    traversalattributes.endpos = var_ed290e9f43580cf8.origin;
    traversalattributes.angles = var_ed290e9f43580cf8.angles;
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

/#

    // Namespace zombie_diana_hibernation
    // Params 1
    // Checksum 0x503d7df9, Offset: 0xa59
    // Size: 0x60, Type: dev
    function function_b686f0d241124e7d( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isdefined( diana ) )
        {
            diana hibernation_start();
            wait 10;
            
            if ( isalive( diana ) )
            {
                diana hibernation_end();
            }
        }
    }

    // Namespace zombie_diana_hibernation
    // Params 1, eflags: 0x4
    // Checksum 0x876470e8, Offset: 0xac1
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
