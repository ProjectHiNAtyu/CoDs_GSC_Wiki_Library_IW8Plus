// scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_leap_attack.gsc  (hash_3205c5c0897fe540.gscc) (size: 1462 Bytes / 0x5b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeedd8039 (4007493689)
// size ...... 1462 (0x5b6)
// includes .. 2   (offset: 0x562)
// strings ... 5   (offset: 0x572)
// dev strs .. 0   (offset: 0x5b6)
// exports ... 7   (offset: 0x2b6)
// cseg ...... 0xb6 + 0x200 (0x2b6)
// imports ... 14  (offset: 0x3ce)
// animtree1 . 0   (offset: 0x5b6)
// animtree2 . 0   (offset: 0x5b6)
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\callbacks;

#namespace zombie_vermin_leap_attack;

// Namespace zombie_vermin_leap_attack
// Params 0
// Checksum 0xd88392c4, Offset: 0xd4
// Size: 0x49
function function_e048cfb0a8e71467()
{
    zombie_leap_attack::init_zombie_leap_attack_global();
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_b7dd02b2f0d6a2c1 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_a4944ca11f0ecb0e );
}

// Namespace zombie_vermin_leap_attack
// Params 0
// Checksum 0xc7c8c47b, Offset: 0x125
// Size: 0x50
function init_zombie_vermin_leap_attack()
{
    self.leap_attack_state = "leap_attack_in";
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = 1;
    }
    
    self function_786bb6aa1b76c7ee( "leap_max_target_count", self.var_577dec43cf1caedf );
    zombie_leap_attack::init_zombie_leap_attack();
    thread function_a20e9207db32b2be();
    thread function_c90fbb7c1378982b();
}

// Namespace zombie_vermin_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xd17ef97f, Offset: 0x17d
// Size: 0x75
function private function_a20e9207db32b2be()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_start" );
        
        if ( isplayer( self.enemy ) )
        {
            self.var_43acac8796301e81 = self.enemy;
            self.var_43acac8796301e81 function_a58e1bd7ca9f6222( "leap_attack" );
        }
        
        self.var_542134bab16723fb = self.var_a13bed1ac47e1b2c;
        self.var_a13bed1ac47e1b2c = 1;
    }
}

// Namespace zombie_vermin_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x48de5263, Offset: 0x1fa
// Size: 0x6c
function private function_c90fbb7c1378982b()
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

// Namespace zombie_vermin_leap_attack
// Params 1, eflags: 0x4
// Checksum 0xc3ebd88b, Offset: 0x26e
// Size: 0x2c
function private function_b7dd02b2f0d6a2c1( params )
{
    if ( isdefined( self.var_43acac8796301e81 ) )
    {
        self.var_43acac8796301e81 function_31d0b50675d9d6e( "leap_attack" );
    }
}

// Namespace zombie_vermin_leap_attack
// Params 1, eflags: 0x4
// Checksum 0x65ffef1d, Offset: 0x2a2
// Size: 0x14
function private function_a4944ca11f0ecb0e( params )
{
    zombie_leap_attack::set_leap_attack_cooldown( 0 );
}

