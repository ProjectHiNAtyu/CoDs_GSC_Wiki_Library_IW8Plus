// scripts\mp\common\equipment\elite_ironclad_drive.gsc  (hash_0034ed69ba37148c.gscc) (size: 5929 Bytes / 0x1729 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x457d0830 (1165822000)
// size ...... 5929 (0x1729)
// includes .. 12  (offset: 0x1649)
// strings ... 9   (offset: 0x16a9)
// dev strs .. 0   (offset: 0x1729)
// exports ... 23  (offset: 0xc95)
// cseg ...... 0x131 + 0xb64 (0xc95)
// imports ... 52  (offset: 0x102d)
// animtree1 . 0   (offset: 0x1729)
// animtree2 . 0   (offset: 0x1729)
#using script_239a365a92ee4476;
#using scripts\common\omnvar_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\emp_debuff;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\supers;

#namespace elite_ironclad_drive;

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x5
// Checksum 0x3b0b477e, Offset: 0x14f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_825c7e89b047bb1b", #"br_ftue", undefined, &init_ftue_tip );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x1
// Checksum 0x6069356c, Offset: 0x178
// Size: 0x9
function autoexec main()
{
    super_elite_ironclad_drive_init();
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0xb6b81ff4, Offset: 0x189
// Size: 0x29
function private super_elite_ironclad_drive_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_elite_ironclad_drive", &function_4d37a7d534d9b34d, &function_a7e9c568fa476458, &super_elite_ironclad_drive_beginuse );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0xaedd026d, Offset: 0x1ba
// Size: 0x9
function private init_ftue_tip()
{
    function_be994a18feba9f09();
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x546a379c, Offset: 0x1cb
// Size: 0x31
function private function_be994a18feba9f09()
{
    if ( !ftue_progress::ftue_enabled() || level.var_70c897913601b59a )
    {
        return;
    }
    
    level.var_70c897913601b59a = 1;
    namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_30914848f9ac21c2 );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x38216, Offset: 0x204
// Size: 0x15
function private function_30914848f9ac21c2()
{
    ftue_tip::function_d454ba9425f5164c( 62, "hardDriveElementPicked", &hard_drive_picked_up );
}

// Namespace elite_ironclad_drive
// Params 1, eflags: 0x4
// Checksum 0xe1ba6a38, Offset: 0x221
// Size: 0x16
function private hard_drive_picked_up( params )
{
    return self.var_cc4af4ddc026ed91.size;
}

// Namespace elite_ironclad_drive
// Params 3, eflags: 0x4
// Checksum 0xd969ec15, Offset: 0x240
// Size: 0x65
function private activate_scramble( player, team, owner )
{
    if ( player.var_6d26b789ca9db0e0 )
    {
        return;
    }
    
    player.var_6d26b789ca9db0e0 = 1;
    player emp_debuff::play_emp_scramble( 1, 1 );
    
    if ( player.team == team )
    {
        function_7a11d50686705c12( player, owner, 1 );
    }
}

// Namespace elite_ironclad_drive
// Params 3, eflags: 0x4
// Checksum 0xced0f7a2, Offset: 0x2ad
// Size: 0x62
function private deactivate_scramble( player, team, owner )
{
    if ( !player.var_6d26b789ca9db0e0 )
    {
        return;
    }
    
    player.var_6d26b789ca9db0e0 = undefined;
    player emp_debuff::stop_emp_scramble( 1, 1 );
    
    if ( player.team == team )
    {
        function_7a11d50686705c12( player, owner, 0 );
    }
}

// Namespace elite_ironclad_drive
// Params 3, eflags: 0x4
// Checksum 0x838b821b, Offset: 0x317
// Size: 0x19b
function private function_7a11d50686705c12( player, owner, value )
{
    assert( isplayer( player ) );
    assert( owner );
    value_max = 1;
    assert( value >= 0 && value <= value_max );
    slot = int( player.sessionuimemberindex ) & 3;
    team_info = owner.var_cc4af4ddc026ed91;
    assert( isdefined( team_info ) );
    team_info[ slot ] = value;
    teammates = teams::getteamdata( owner.team, "players" );
    
    foreach ( teammate in teammates )
    {
        bit_max = 1;
        
        for ( slot = 0; slot < 4 ; slot++ )
        {
            var_c1b0af8862ae5d74 = slot * 1;
            var_a88f34d38839a510 = 0;
            team_info = owner.var_cc4af4ddc026ed91;
            assert( isdefined( team_info ) );
            
            if ( isdefined( team_info[ slot ] ) )
            {
                var_a88f34d38839a510 = int( team_info[ slot ] ) & bit_max;
            }
            
            teammate omnvar_utility::function_85d5f88af471ac4b( "ui_br_player_in_drive_range", var_c1b0af8862ae5d74 + 0, 1, var_a88f34d38839a510 );
        }
    }
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0xc523dfde, Offset: 0x4ba
// Size: 0x158
function private function_4d37a7d534d9b34d()
{
    if ( self.var_6d26b789ca9db0e0 )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_elite_ironclad_drive" );
    trigger_radius = bundle.var_6d42b47701830012 ?? 500;
    area_trigger = spawn( "trigger_radius", self.origin, 0, trigger_radius, trigger_radius );
    area_trigger enablelinkto();
    area_trigger linkto( self );
    area_trigger.ironclad_owner = self;
    area_trigger.var_ced5198c0145a9b9 = [];
    self.ironclad_area_trigger = area_trigger;
    squad_players_data = [];
    
    for ( slot = 0; slot < 4 ; slot++ )
    {
        squad_players_data[ slot ] = 0;
    }
    
    self.var_cc4af4ddc026ed91 = squad_players_data;
    function_7a11d50686705c12( self, self, 1 );
    
    if ( self.ironclad_cooldown_end_time && self.ironclad_cooldown_end_time > gettime() )
    {
        lower_message::setlowermessageomnvar( "elite_ironclad_drive_cooldown", self.ironclad_cooldown_end_time );
    }
    
    trigger::makeenterexittrigger( area_trigger, &function_c4f1d7a937d0fb01, &function_8d52c6bf91ba4bc1, undefined, undefined, &function_ce0558573f44572b );
    activate_scramble( self, area_trigger.ironclad_owner.team, area_trigger.ironclad_owner );
    thread function_7cf73c613c3d5a40();
    thread function_89ad8516942897e2();
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x61927920, Offset: 0x61a
// Size: 0xe4
function private function_a7e9c568fa476458()
{
    if ( self.ironclad_area_trigger )
    {
        team = self.team;
        
        foreach ( player in self.ironclad_area_trigger.var_ced5198c0145a9b9 )
        {
            if ( player )
            {
                deactivate_scramble( player, team, self );
            }
        }
        
        deactivate_scramble( self, team, self );
        self.ironclad_area_trigger delete();
        self.ironclad_area_trigger = undefined;
        self.var_cc4af4ddc026ed91 = undefined;
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
}

// Namespace elite_ironclad_drive
// Params 2, eflags: 0x4
// Checksum 0xbd19c92c, Offset: 0x706
// Size: 0x2e, Type: bool
function private function_ce0558573f44572b( entering_entity, area_trigger )
{
    return !isplayer( entering_entity ) || entering_entity == area_trigger.ironclad_owner;
}

// Namespace elite_ironclad_drive
// Params 2, eflags: 0x4
// Checksum 0x4853bc46, Offset: 0x73d
// Size: 0x5f
function private function_c4f1d7a937d0fb01( entering_entity, area_trigger )
{
    area_trigger.var_ced5198c0145a9b9[ self getentitynumber() ] = self;
    
    if ( !area_trigger.var_37d6f85cff7a5b71 )
    {
        activate_scramble( self, area_trigger.ironclad_owner.team, area_trigger.ironclad_owner );
    }
}

// Namespace elite_ironclad_drive
// Params 2, eflags: 0x4
// Checksum 0x2e756d07, Offset: 0x7a4
// Size: 0x4e
function private function_8d52c6bf91ba4bc1( exiting_entity, area_trigger )
{
    area_trigger.var_ced5198c0145a9b9[ self getentitynumber() ] = undefined;
    deactivate_scramble( self, area_trigger.ironclad_owner.team, area_trigger.ironclad_owner );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0xa0b36f26, Offset: 0x7fa
// Size: 0x19e
function private function_e46b3b7667ba1bb2()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_elite_ironclad_drive" );
    area_trigger = self.ironclad_area_trigger;
    team = self.team;
    
    if ( area_trigger )
    {
        area_trigger endon( #"death" );
        area_trigger.var_37d6f85cff7a5b71 = 1;
    }
    
    affected_players = area_trigger ? arraycopy( area_trigger.var_ced5198c0145a9b9, 0 ) : [];
    deactivate_scramble( self, team, self );
    
    foreach ( player in affected_players )
    {
        deactivate_scramble( player, team, self );
    }
    
    wait bundle.var_86e0ccfaa34d22aa ?? 10;
    
    if ( area_trigger )
    {
        area_trigger.var_37d6f85cff7a5b71 = undefined;
        
        foreach ( player in area_trigger.var_ced5198c0145a9b9 )
        {
            activate_scramble( player, team, self );
        }
    }
    
    activate_scramble( self, team, self );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x83dad97, Offset: 0x9a0
// Size: 0x4f
function private function_e022565480a1b16b()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    weap_obj = makeweapon( "saw_ges_plyr_hard_drive" );
    self giveandfireoffhand( weap_obj );
    wait 1.5;
    
    if ( self hasweapon( weap_obj ) )
    {
        self takeweapon( weap_obj );
    }
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x8d2bbc3, Offset: 0x9f7
// Size: 0x2f, Type: bool
function private super_elite_ironclad_drive_beginuse()
{
    self endon( #"death_or_disconnect" );
    
    if ( function_da4a80bfccf522c0() )
    {
        return false;
    }
    
    childthread function_e022565480a1b16b();
    childthread function_e46b3b7667ba1bb2();
    thread function_55c1440782830009();
    return false;
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0x4
// Checksum 0x872c4b77, Offset: 0xa2f
// Size: 0x34
function private function_da4a80bfccf522c0()
{
    if ( !self.ironclad_area_trigger )
    {
        return #"no_trigger";
    }
    
    if ( gettime() < self.ironclad_cooldown_end_time )
    {
        return #"hash_c0c48b7315723b10";
    }
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0xc
// Checksum 0x8ff13048, Offset: 0xa6c
// Size: 0x5d
function private function_7cf73c613c3d5a40()
{
    self notify( #"hash_48a955e633f41c51" );
    self endon( #"hash_48a955e633f41c51" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"death" );
        
        if ( !player::isinlaststand( self ) )
        {
            self.ironclad_cooldown_end_time = undefined;
            return;
        }
    }
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0xc
// Checksum 0x835fbb42, Offset: 0xad1
// Size: 0xa1
function private function_55c1440782830009()
{
    self notify( #"hash_95bef6a953ab3869" );
    self endon( #"hash_95bef6a953ab3869" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_elite_ironclad_drive" );
    self.ironclad_cooldown_end_time = gettime() + int( bundle.var_4e6c01f722a3527a * 1000 );
    lower_message::setlowermessageomnvar( "elite_ironclad_drive_cooldown", self.ironclad_cooldown_end_time );
    wait bundle.var_4e6c01f722a3527a;
    self.ironclad_cooldown_end_time = undefined;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace elite_ironclad_drive
// Params 0, eflags: 0xc
// Checksum 0x18b2dec0, Offset: 0xb7a
// Size: 0x11b
function private function_89ad8516942897e2()
{
    self notify( #"hash_fa10dfd22c95582e" );
    self endon( #"hash_fa10dfd22c95582e" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( self.ironclad_area_trigger )
    {
        if ( self.var_6d26b789ca9db0e0 )
        {
            if ( !self.empscramblelevels[ 1 ] )
            {
                emp_debuff::play_emp_scramble( 1, 1 );
            }
        }
        
        foreach ( player in self.ironclad_area_trigger.var_ced5198c0145a9b9 )
        {
            if ( player && player.var_6d26b789ca9db0e0 )
            {
                if ( !player.empscramblelevels[ 1 ] )
                {
                    player emp_debuff::play_emp_scramble( 1, 1 );
                }
            }
        }
        
        wait 0.1;
    }
}

