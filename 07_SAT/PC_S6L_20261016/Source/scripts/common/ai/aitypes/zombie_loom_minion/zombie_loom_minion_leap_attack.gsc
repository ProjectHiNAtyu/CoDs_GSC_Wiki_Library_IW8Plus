// scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_leap_attack.gsc  (hash_10b2574ee87e16b0.gscc) (size: 2019 Bytes / 0x7e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf24d0bdb (4065135579)
// size ...... 2019 (0x7e3)
// includes .. 3   (offset: 0x74f)
// strings ... 9   (offset: 0x767)
// dev strs .. 0   (offset: 0x7e3)
// exports ... 9   (offset: 0x3cb)
// cseg ...... 0xeb + 0x2e0 (0x3cb)
// imports ... 18  (offset: 0x533)
// animtree1 . 0   (offset: 0x7e3)
// animtree2 . 0   (offset: 0x7e3)
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_loom_minion_leap_attack;

// Namespace zombie_loom_minion_leap_attack
// Params 0
// Checksum 0xb76d302d, Offset: 0x109
// Size: 0x89
function function_1f3fb977dca576aa()
{
    namespace_f0563419ebc8af00::init_zombie_leap_attack_global();
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_abb30dd52666fa44 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_893bd0412b7bf147 );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_cc0afc8608802523 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_leap_hit", &function_cc0afc8608802523 );
}

// Namespace zombie_loom_minion_leap_attack
// Params 0
// Checksum 0x6e73b9af, Offset: 0x19a
// Size: 0x50
function init_zombie_loom_minion_leap_attack()
{
    self.leap_attack_state = "leap_attack_in";
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = 1;
    }
    
    self function_786bb6aa1b76c7ee( "leap_max_target_count", self.var_577dec43cf1caedf );
    namespace_f0563419ebc8af00::init_zombie_leap_attack();
    thread function_ac8b654690a4ef25();
    thread function_7bb3fd556ad2d73c();
}

// Namespace zombie_loom_minion_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xd84f2be4, Offset: 0x1f2
// Size: 0x98
function private function_ac8b654690a4ef25()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_start" );
        
        if ( isplayer( self.enemy ) )
        {
            self.var_43acac8796301e81 = self.enemy;
            self.var_43acac8796301e81 function_a58e1bd7ca9f6222( "leap_attack" );
            callback::callback( #"hash_bff79b6f9fd68943", { #target:self.var_43acac8796301e81 } );
        }
        
        self.var_542134bab16723fb = self.var_a13bed1ac47e1b2c;
        self.var_a13bed1ac47e1b2c = 1;
    }
}

// Namespace zombie_loom_minion_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xf87237d6, Offset: 0x292
// Size: 0x6c
function private function_7bb3fd556ad2d73c()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_end" );
        
        if ( isalive( self.var_43acac8796301e81 ) )
        {
            self.var_43acac8796301e81 function_31d0b50675d9d6e( "leap_attack" );
            self.var_43acac8796301e81 = undefined;
        }
        
        self.var_a13bed1ac47e1b2c = self.var_542134bab16723fb;
        self.var_542134bab16723fb = undefined;
    }
}

// Namespace zombie_loom_minion_leap_attack
// Params 1, eflags: 0x4
// Checksum 0x1eb49ed1, Offset: 0x306
// Size: 0x2c
function private function_abb30dd52666fa44( params )
{
    if ( isdefined( self.var_43acac8796301e81 ) )
    {
        self.var_43acac8796301e81 function_31d0b50675d9d6e( "leap_attack" );
    }
}

// Namespace zombie_loom_minion_leap_attack
// Params 1, eflags: 0x4
// Checksum 0x43df2ab7, Offset: 0x33a
// Size: 0x14
function private function_893bd0412b7bf147( params )
{
    namespace_f0563419ebc8af00::set_leap_attack_cooldown( 0 );
}

// Namespace zombie_loom_minion_leap_attack
// Params 1, eflags: 0x4
// Checksum 0x532694dd, Offset: 0x356
// Size: 0x32
function private function_cc0afc8608802523( params )
{
    if ( isdefined( params.var_2d2aab21299551f8 ) || isdefined( params.var_c146e72268eb8492 ) )
    {
        thread function_c97277d9dc4a067d();
    }
}

// Namespace zombie_loom_minion_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xfd9645, Offset: 0x390
// Size: 0x3b
function private function_c97277d9dc4a067d()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "bite", "bite" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "bite", "off" );
    }
}

