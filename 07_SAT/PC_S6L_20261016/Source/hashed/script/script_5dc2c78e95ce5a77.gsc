// script_5dc2c78e95ce5a77  (hash_5dc2c78e95ce5a77.gscc) (size: 2513 Bytes / 0x9d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72b837e6 (1924675558)
// size ...... 2513 (0x9d1)
// includes .. 5   (offset: 0x90d)
// strings ... 7   (offset: 0x935)
// dev strs .. 5   (offset: 0x995)
// exports ... 10  (offset: 0x4f9)
// cseg ...... 0xcf + 0x42a (0x4f9)
// imports ... 22  (offset: 0x689)
// animtree1 . 0   (offset: 0x9d1)
// animtree2 . 0   (offset: 0x9d1)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_7bf9c7d90634c36f;

// Namespace namespace_7bf9c7d90634c36f
// Params 0
// Checksum 0x5d074ed0, Offset: 0xed
// Size: 0x2c
function function_bb5e0c5b7f749444()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_4caf5b9134c00a31 );
    
    /#
        function_2b11bbf24f99b96f();
    #/
}

// Namespace namespace_7bf9c7d90634c36f
// Params 0
// Checksum 0x99d01bf, Offset: 0x121
// Size: 0x194
function function_6e0aee664486fa7a()
{
    callisto_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    assert( isdefined( callisto_settings ) );
    self.charge_cooldown = int( utility::function_4b74c15943231980( callisto_settings.chargecooldown ) );
    self.charge_cooldown_hit_vehicle = int( utility::function_4b74c15943231980( callisto_settings.var_ce5152584869f893 ) );
    self.charge_start_min_distance = callisto_settings.var_aa48412a31040491;
    self.charge_start_max_distance = callisto_settings.var_ec207d4b070f393b;
    self.var_6f4ac70819d6c334 = callisto_settings.var_12e5ca6397d16425;
    self.charge_damage_radius = callisto_settings.chargedamageradius;
    self.var_ad41def0c5c03519 = callisto_settings.var_f0bd662816abea04;
    self.var_52693a700154ae1a = callisto_settings.var_437dbe96d5a276cb;
    self.var_bd3d3ade9537726 = callisto_settings.chargeplayerdamage;
    self.var_b234910aee44c0ed = callisto_settings.chargevehicledamage;
    self.var_58622d7471072785 = callisto_settings.var_6c900283dcc6e98c;
    self.var_8d3ea37f47898ea = callisto_settings.var_2c07fe59335d3bc8;
    self.var_b8e3c022a4ef5887 = callisto_settings.var_7bdb05a82c39928e / 100;
    self function_786bb6aa1b76c7ee( "charge_cooldown", self.charge_cooldown );
    self function_786bb6aa1b76c7ee( "charge_max_dist", self.charge_start_max_distance );
    self function_786bb6aa1b76c7ee( "charge_min_dist", self.charge_start_min_distance );
    thread charge_start_listener();
    thread charge_end_listener();
}

// Namespace namespace_7bf9c7d90634c36f
// Params 1, eflags: 0x4
// Checksum 0x1624245d, Offset: 0x2bd
// Size: 0x98
function private function_4caf5b9134c00a31( params )
{
    if ( self getaiblackboarddynamic( "in_charge" ) && isdefined( self.charge_start_health ) && isdefined( self.health ) && isdefined( self.maxhealth ) )
    {
        damage_dealt = self.charge_start_health - self.health;
        var_d648d1dbc51f0b0f = self.maxhealth * self.var_b8e3c022a4ef5887;
        
        if ( damage_dealt + params.idamage >= var_d648d1dbc51f0b0f )
        {
            stop_charge();
        }
    }
}

// Namespace namespace_7bf9c7d90634c36f
// Params 0, eflags: 0x4
// Checksum 0x5f39c977, Offset: 0x35d
// Size: 0x4d
function private charge_start_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"charge_start" );
        
        if ( isalive( self.enemy ) )
        {
            start_charge( self.enemy );
            continue;
        }
        
        stop_charge();
    }
}

// Namespace namespace_7bf9c7d90634c36f
// Params 0, eflags: 0x4
// Checksum 0xce8adfe2, Offset: 0x3b2
// Size: 0x2a
function private charge_end_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"charge_end" );
        stop_charge();
    }
}

// Namespace namespace_7bf9c7d90634c36f
// Params 1, eflags: 0x4
// Checksum 0x4e5bada2, Offset: 0x3e4
// Size: 0x4e
function private start_charge( target )
{
    self.charge_target = target;
    self.charge_start_loc = self.origin;
    self.charge_start_health = self.health;
    val::set( "charge", "push_player", 1 );
}

// Namespace namespace_7bf9c7d90634c36f
// Params 0
// Checksum 0x8f9ea42, Offset: 0x43a
// Size: 0x3d
function stop_charge()
{
    self.charge_target = undefined;
    self.charge_start_loc = undefined;
    self.charge_start_health = undefined;
    val::reset( "charge", "push_player" );
    self function_786bb6aa1b76c7ee( "in_charge", 0 );
}

/#

    // Namespace namespace_7bf9c7d90634c36f
    // Params 0
    // Checksum 0x6683c904, Offset: 0x47f
    // Size: 0x2e, Type: dev
    function function_2b11bbf24f99b96f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x54>", &function_4e0e59c71cceff6a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_7bf9c7d90634c36f
    // Params 0, eflags: 0x4
    // Checksum 0x93bc4043, Offset: 0x4b5
    // Size: 0x44, Type: dev
    function private function_4e0e59c71cceff6a()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x73>" );
        
        if ( isdefined( callisto ) )
        {
            self function_786bb6aa1b76c7ee( "<dev string:x83>", 0 );
        }
    }

#/
