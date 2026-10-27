// script_1d27f1bd42c9ce34  (hash_1d27f1bd42c9ce34.gscc) (size: 4564 Bytes / 0x11d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb86e181e (3094222878)
// size ...... 4564 (0x11d4)
// includes .. 9   (offset: 0x10f8)
// strings ... 10  (offset: 0x1140)
// dev strs .. 2   (offset: 0x11bc)
// exports ... 15  (offset: 0x97c)
// cseg ...... 0x11b + 0x861 (0x97c)
// imports ... 45  (offset: 0xbd4)
// animtree1 . 0   (offset: 0x11d4)
// animtree2 . 0   (offset: 0x11d4)
#using script_16ea1b94f0f381b3;
#using script_bdb08507b3b7b94;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\zm\zm_utility;

#namespace zm_zombie_uranus;

// Namespace zm_zombie_uranus
// Params 2
// Checksum 0x3251e0b0, Offset: 0x139
// Size: 0xf0
function precache( classname, aitypescriptbundle )
{
    callback::add( #"uranus_callback_init", &function_35186947bda7ecc6 );
    level callback::add( "on_zombie_uranus_spawned", &function_8e78a1d3adea1f9 );
    utility::registersharedfunc( #"zombie_uranus", #"hash_f14721ab0299a7f7", &spawn_uranus );
    utility::registersharedfunc( #"zombie_uranus", #"hash_60b929ba0ef8ba4e", &change_lighting );
    utility::registersharedfunc( #"zombie_uranus", #"hash_918c6230c5839b4d", &toxic_cough );
    utility::registersharedfunc( #"zombie_uranus", #"hash_7f15bcf85cab1554", &stop_cough );
    utility::registersharedfunc( #"zombie_uranus", #"hash_97a8f5361cf37a44", &toxic_blur );
    utility::registersharedfunc( #"zombie_uranus", #"hash_42c16ac0465085db", &function_6c099fa409b7cc96 );
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0xf6220a61, Offset: 0x231
// Size: 0x1d
function function_35186947bda7ecc6( params )
{
    callback::add( "on_first_ai_init", &function_36ce05ba4258918d );
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0x1a7f093a, Offset: 0x256
// Size: 0x24
function function_36ce05ba4258918d( params )
{
    callback::remove( "on_first_ai_init", &function_36ce05ba4258918d );
    zombie_boss_healthbar::function_f50a10314e72caa1();
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0xc13fabda, Offset: 0x282
// Size: 0x127
function function_8e78a1d3adea1f9( params )
{
    self.disable_brain_rot = 1;
    self.b_cleanup_no_respawn = 1;
    self.var_15598d8e493afe88 = 1;
    self.var_825b17c932865df = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.b_disable_annihilate = 1;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.var_bfa7ca2a8740bf7b = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.ignore_enemy_count = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.var_5a9c952260ab1cf = 1;
    self.no_powerups = 1;
    self.allowfriendlyfire = 1;
    self.var_1f6335e27ced5dca = 1;
    val::set( #"zombie_uranus", "damage", 0 );
    val::set( #"zombie_uranus", "ignore_cleanup", 1 );
    utility::ent_flag_set( "zm_mod_health_regen_disable" );
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    callback::add( #"on_ai_killed", &function_4c3c58b0ad321dd0 );
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0x1689e90a, Offset: 0x3b1
// Size: 0x85
function function_4c3c58b0ad321dd0( params )
{
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zm_zombie_uranus
// Params 2
// Checksum 0xe9db131, Offset: 0x43e
// Size: 0x77
function spawn_uranus( pos, angles )
{
    type = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( "zombie_uranus" )[ 0 ];
    
    if ( !type )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x38>" );
        return;
    }
    
    newai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( type, pos, angles, zm_utility::get_zombie_team() );
    newai zombie_uranus::set_angles( angles );
    newai thread function_e92b4dea7af4c455();
    return newai;
}

// Namespace zm_zombie_uranus
// Params 0, eflags: 0x4
// Checksum 0xc7aa32c9, Offset: 0x4be
// Size: 0x44
function private function_e92b4dea7af4c455()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"hash_d0c471d8de66097", phase );
        zombie_uranus::set_phase( phase );
    }
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0x6548b665, Offset: 0x50a
// Size: 0x184
function change_lighting( lighting )
{
    bank_num = lighting.var_756ca0d63c9bc9df ?? 1;
    
    /#
        bank_override = getdvarint( @"hash_75dda2418901c635" );
        
        if ( bank_override > 0 )
        {
            bank_num = bank_override;
        }
    #/
    
    if ( bank_num > 0 )
    {
        function_ad915db840c90fb3( 1023, bank_num, 2, undefined, undefined );
    }
    
    level.uranuslighting = lighting;
    
    if ( lighting.visionname && lighting.visionname != "" )
    {
        foreach ( player in level.players )
        {
            player function_8d2c97ac7b75ae7f( lighting.visionname );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player function_56c4b97143bf409();
    }
}

// Namespace zm_zombie_uranus
// Params 1
// Checksum 0xb0bdb1f1, Offset: 0x696
// Size: 0x44
function function_8d2c97ac7b75ae7f( visionset )
{
    if ( !isdefined( self.uranus_visions ) )
    {
        self.uranus_visions = [];
    }
    
    vision_utility::function_89d3efe42060754c( visionset, 2 );
    self.uranus_visions[ self.uranus_visions.size ] = visionset;
}

// Namespace zm_zombie_uranus
// Params 0
// Checksum 0x215fc96, Offset: 0x6e2
// Size: 0x93
function function_56c4b97143bf409()
{
    if ( !self.uranus_visions )
    {
        return;
    }
    
    foreach ( vision in self.uranus_visions )
    {
        vision_utility::function_6cb9d8e0202ee81( vision );
    }
    
    self.uranus_visions = [];
}

// Namespace zm_zombie_uranus
// Params 1, eflags: 0xc
// Checksum 0xf9cfb64c, Offset: 0x77d
// Size: 0x10c
function private toxic_cough( var_1e2895c484c9125a )
{
    self notify( #"hash_8075779a7a82af41" );
    self endon( #"hash_8075779a7a82af41" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_8ffe3b46be74b0c2" );
    gestures = [ "iw9_ges_gas_cough_long", "iw9_ges_gas_cough" ];
    nullweapon = nullweapon();
    
    if ( isalive( self ) && !self.inlaststand && self getcurrentweapon() != nullweapon )
    {
        self playgestureviewmodel( gestures[ 0 ] );
    }
    
    while ( isalive( self ) && !self.inlaststand )
    {
        gesture = randomint( 100 ) > 60 ? gestures[ 0 ] : gestures[ 1 ];
        
        if ( self getcurrentweapon() != nullweapon )
        {
            self playgestureviewmodel( gesture );
        }
        
        self playlocalsound( "gas_player_cough" );
        duration = randomintrange( 5, 8 );
        wait duration;
    }
}

// Namespace zm_zombie_uranus
// Params 0, eflags: 0x4
// Checksum 0xf93c2de2, Offset: 0x891
// Size: 0xe
function private stop_cough()
{
    self notify( #"hash_8ffe3b46be74b0c2" );
}

// Namespace zm_zombie_uranus
// Params 1, eflags: 0xc
// Checksum 0x8bab87e4, Offset: 0x8a7
// Size: 0xbf
function private toxic_blur( var_1e2895c484c9125a )
{
    self notify( #"hash_de4eb637fefbca78" );
    self endon( #"hash_de4eb637fefbca78" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e778f6e29f2c7f39" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    blur_duration = 1;
    shockasset = getxhashasset( settings.toxicshock );
    shellshock_utility_cpmp::_shellshock( shockasset, #"stun", blur_duration, 0, 100 );
    
    while ( true )
    {
        shellshock_utility_cpmp::_shellshock( shockasset, #"gas", blur_duration, 0 );
        wait 0.5;
    }
}

// Namespace zm_zombie_uranus
// Params 0, eflags: 0x4
// Checksum 0xe29f2726, Offset: 0x96e
// Size: 0xe
function private function_6c099fa409b7cc96()
{
    self notify( #"hash_e778f6e29f2c7f39" );
}

