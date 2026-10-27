// scripts\mp\common\killstreaks\isotope_core.gsc  (hash_031daebb3d39a2b9.gscc) (size: 5531 Bytes / 0x159b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79698e49 (2036960841)
// size ...... 5531 (0x159b)
// includes .. 14  (offset: 0x14af)
// strings ... 8   (offset: 0x151f)
// dev strs .. 0   (offset: 0x159b)
// exports ... 20  (offset: 0xb63)
// cseg ...... 0x10b + 0xa58 (0xb63)
// imports ... 53  (offset: 0xe83)
// animtree1 . 0   (offset: 0x159b)
// animtree2 . 0   (offset: 0x159b)
#using script_239a365a92ee4476;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\omnvar_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\playerhealth;

#namespace isotope_core;

// Namespace isotope_core
// Params 0, eflags: 0x5
// Checksum 0xab247fbd, Offset: 0x129
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f841570d9e13218e", #"br_ftue", undefined, &init_ftue_tip );
}

// Namespace isotope_core
// Params 0, eflags: 0x5
// Checksum 0xea58e527, Offset: 0x152
// Size: 0x17
function private autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "isotope_core" ), &isotope_core_init );
}

// Namespace isotope_core
// Params 0
// Checksum 0x1b51adb4, Offset: 0x171
// Size: 0x1e
function isotope_core_init()
{
    killstreaks::registerkillstreak( "isotope_core", &triggered_isotope_core, &picked_isotope_core, undefined, &cleanup_isotope_core );
}

// Namespace isotope_core
// Params 0, eflags: 0x4
// Checksum 0x10a6a03b, Offset: 0x197
// Size: 0x9
function private init_ftue_tip()
{
    function_be994a18feba9f09();
}

// Namespace isotope_core
// Params 0, eflags: 0x4
// Checksum 0x8113b64b, Offset: 0x1a8
// Size: 0x31
function private function_be994a18feba9f09()
{
    if ( !ftue_progress::ftue_enabled() || level.var_70c897913601b59a )
    {
        return;
    }
    
    level.var_70c897913601b59a = 1;
    namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_6b23b52ed07cdff3 );
}

// Namespace isotope_core
// Params 0, eflags: 0x4
// Checksum 0x307ce814, Offset: 0x1e1
// Size: 0x15
function private function_6b23b52ed07cdff3()
{
    ftue_tip::function_d454ba9425f5164c( 61, "isotopeCoreElementPicked", &isotope_picked_up );
}

// Namespace isotope_core
// Params 1, eflags: 0x4
// Checksum 0x42263fa1, Offset: 0x1fe
// Size: 0x16
function private isotope_picked_up( params )
{
    return self.var_3893d0a858af45b5.size;
}

// Namespace isotope_core
// Params 1, eflags: 0x4
// Checksum 0x4130c037, Offset: 0x21d
// Size: 0x1b6
function private picked_isotope_core( streakitem )
{
    killstreakbundle = killstreak::function_85b2d8e857ab4898( "isotope_core" );
    isotope_core_damage_trigger = spawn( "trigger_radius", self.origin, 0, killstreakbundle.var_5e0edf8f55e59d89, killstreakbundle.var_adcd78cc310d1204 );
    isotope_core_damage_trigger enablelinkto();
    isotope_core_damage_trigger linkto( self );
    isotope_core_damage_trigger.owner = self;
    isotope_core_damage_trigger.var_fea4c6c4068ad251 = [];
    isotope_core_damage_trigger.var_fea4c6c4068ad251[ self getentitynumber() ] = self;
    isotope_core_damage_trigger.var_59c8d3531f7636c = utility::function_edc4cc03e9e60b3e( @"hash_ce93b6f4db3ac1d2", 0, killstreakbundle.var_59c8d3531f7636c );
    isotope_core_damage_trigger.var_10bd9d8a94645dcf = utility::function_48f723fdc612ec65( @"hash_b7501da15bd0e2cd", 0, killstreakbundle.var_10bd9d8a94645dcf );
    self.isotope_core_damage_trigger = isotope_core_damage_trigger;
    squad_players_data = [];
    
    for ( slot = 0; slot < 4 ; slot++ )
    {
        squad_players_data[ slot ] = 0;
    }
    
    self.var_3893d0a858af45b5 = squad_players_data;
    function_3952d9b1062c143( self, self, 1 );
    trigger::makeenterexittrigger( isotope_core_damage_trigger, &on_trigger_enter, &on_trigger_exit, undefined, undefined, &trigger_player_filter );
    isotope_core_damage_trigger thread function_258cb36661c2c31a();
    current_time = gettime();
    
    if ( self.var_be8c7939afc6489f && self.isotope_core_cooldown_end_time > current_time )
    {
        lower_message::setlowermessageomnvar( "isotope_core_cooldown", self.isotope_core_cooldown_end_time );
    }
    
    self.healthregendisabled = 1;
    self hudoutlineenableforclients( level.players, killstreakbundle.var_af57202b34530fb8 );
}

// Namespace isotope_core
// Params 0, eflags: 0x4
// Checksum 0x4516e8fc, Offset: 0x3db
// Size: 0x126
function private disable_radiation()
{
    self.healthregendisabled = 0;
    var_fea4c6c4068ad251 = self.isotope_core_damage_trigger ? self.isotope_core_damage_trigger.var_fea4c6c4068ad251 : undefined;
    
    if ( isdefined( var_fea4c6c4068ad251 ) )
    {
        foreach ( player in var_fea4c6c4068ad251 )
        {
            if ( isplayer( player ) && player.team == self.isotope_core_damage_trigger.owner.team )
            {
                function_3952d9b1062c143( player, self.isotope_core_damage_trigger.owner, 0 );
            }
        }
    }
    
    if ( self.isotope_core_damage_trigger )
    {
        self.isotope_core_damage_trigger.var_fea4c6c4068ad251 = undefined;
    }
    
    self notify( #"hash_a8a63b1dbe712394" );
}

// Namespace isotope_core
// Params 2, eflags: 0x4
// Checksum 0x137c446d, Offset: 0x509
// Size: 0x86
function private on_trigger_enter( ent, isotope_core_damage_trigger )
{
    player = self;
    player_entitynum = player getentitynumber();
    isotope_core_damage_trigger.var_fea4c6c4068ad251[ player_entitynum ] = player;
    
    if ( isplayer( player ) && player.team == isotope_core_damage_trigger.owner.team )
    {
        function_3952d9b1062c143( player, isotope_core_damage_trigger.owner, 1 );
    }
}

// Namespace isotope_core
// Params 2, eflags: 0x4
// Checksum 0x8b224705, Offset: 0x597
// Size: 0x83
function private on_trigger_exit( ent, isotope_core_damage_trigger )
{
    player = self;
    player_entitynum = player getentitynumber();
    isotope_core_damage_trigger.var_fea4c6c4068ad251[ player_entitynum ] = undefined;
    
    if ( isplayer( player ) && player.team == isotope_core_damage_trigger.owner.team )
    {
        function_3952d9b1062c143( player, isotope_core_damage_trigger.owner, 0 );
    }
}

// Namespace isotope_core
// Params 2, eflags: 0x4
// Checksum 0xfdacfb14, Offset: 0x622
// Size: 0x3a, Type: bool
function private trigger_player_filter( ent, isotope_core_damage_trigger )
{
    return !( ent vehicle::is_vehicle() || isplayer( ent ) ) || ent == isotope_core_damage_trigger.owner;
}

// Namespace isotope_core
// Params 3, eflags: 0x4
// Checksum 0xcfb172ce, Offset: 0x665
// Size: 0x19b
function private function_3952d9b1062c143( player, owner, value )
{
    assert( isplayer( player ) );
    assert( owner );
    value_max = 1;
    assert( value >= 0 && value <= value_max );
    slot = int( player.sessionuimemberindex ) & 3;
    team_info = owner.var_3893d0a858af45b5;
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
            team_info = owner.var_3893d0a858af45b5;
            assert( isdefined( team_info ) );
            
            if ( isdefined( team_info[ slot ] ) )
            {
                var_a88f34d38839a510 = int( team_info[ slot ] ) & bit_max;
            }
            
            teammate omnvar_utility::function_85d5f88af471ac4b( "ui_br_player_in_isotope_range", var_c1b0af8862ae5d74 + 0, 1, var_a88f34d38839a510 );
        }
    }
}

// Namespace isotope_core
// Params 0, eflags: 0x4
// Checksum 0x8394071d, Offset: 0x808
// Size: 0x11d
function private function_258cb36661c2c31a()
{
    self endon( #"hash_a8a63b1dbe712394" );
    self endon( #"death_or_disconnect" );
    killstreakbundle = killstreak::function_85b2d8e857ab4898( "isotope_core" );
    
    while ( true )
    {
        foreach ( player in self.var_fea4c6c4068ad251 )
        {
            if ( isplayer( player ) )
            {
                player dodamage( killstreakbundle.var_b7823eabb62b132, player.origin, player, player );
                player playsoundtoplayer( killstreakbundle.var_f35fe654b3a51dde, player );
                continue;
            }
            
            if ( self.var_59c8d3531f7636c )
            {
                player dodamage( self.var_10bd9d8a94645dcf, player.origin, player, player );
            }
        }
        
        wait killstreakbundle.var_53fed58a7e08adaa;
    }
}

// Namespace isotope_core
// Params 0
// Checksum 0x681e6221, Offset: 0x92d
// Size: 0x4f
function function_a30381907703515c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    weapobj = makeweapon( "saw_ges_plyr_nuclear_core" );
    self giveandfireoffhand( weapobj );
    wait 1.5;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace isotope_core
// Params 1, eflags: 0x4
// Checksum 0x7722468c, Offset: 0x984
// Size: 0x99
function private triggered_isotope_core( streakinfo )
{
    if ( !self.var_be8c7939afc6489f )
    {
        killstreakbundle = killstreak::function_85b2d8e857ab4898( "isotope_core" );
        thread radiation_protection( killstreakbundle.var_7098bc803a31cd4 );
        thread isotope_core_cooldown( killstreakbundle.var_baa744d32c928cec );
        thread function_a30381907703515c();
        
        if ( self.health > 0 && self.health < self.maxhealth )
        {
            playerhealth::forcehealthregen( self );
        }
        
        self notify( #"streak_activated", "isotope_core" );
    }
}

// Namespace isotope_core
// Params 1, eflags: 0x4
// Checksum 0x9d529e6c, Offset: 0xa25
// Size: 0x60
function private radiation_protection( protection_time )
{
    self endon( #"hash_ff8c9339ccdfd96e" );
    self endon( #"death_or_disconnect" );
    self.isotope_core_damage_trigger notify( #"hash_a8a63b1dbe712394" );
    self.healthregendisabled = 0;
    wait protection_time;
    self.isotope_core_damage_trigger thread function_258cb36661c2c31a();
    self.healthregendisabled = 1;
}

// Namespace isotope_core
// Params 1, eflags: 0x4
// Checksum 0x6623c527, Offset: 0xa8d
// Size: 0x73
function private isotope_core_cooldown( use_cooldown )
{
    self endon( #"disconnect" );
    self.var_be8c7939afc6489f = 1;
    self.isotope_core_cooldown_end_time = int( gettime() + use_cooldown * 1000 );
    lower_message::setlowermessageomnvar( "isotope_core_cooldown", self.isotope_core_cooldown_end_time );
    wait use_cooldown;
    self.var_be8c7939afc6489f = undefined;
    self.isotope_core_cooldown_end_time = undefined;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace isotope_core
// Params 3, eflags: 0x4
// Checksum 0xba5782f, Offset: 0xb08
// Size: 0x5b
function private cleanup_isotope_core( streakitem, streakinfo, calledfrom )
{
    self notify( #"hash_ff8c9339ccdfd96e" );
    self hudoutlinedisable();
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    disable_radiation();
    self.isotope_core_damage_trigger delete();
    self.var_3893d0a858af45b5 = undefined;
}

