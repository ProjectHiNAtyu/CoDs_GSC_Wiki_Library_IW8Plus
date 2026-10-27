// scripts\mp\cranked.gsc  (hash_6ca75ce7fe1aac52.gscc) (size: 15380 Bytes / 0x3c14 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb39c22a (3946431018)
// size ...... 15380 (0x3c14)
// includes .. 17  (offset: 0x39ec)
// strings ... 26  (offset: 0x3a74)
// dev strs .. 1   (offset: 0x3c08)
// exports ... 40  (offset: 0x2718)
// cseg ...... 0x2aa + 0x246e (0x2718)
// imports ... 96  (offset: 0x2d58)
// animtree1 . 0   (offset: 0x3c14)
// animtree2 . 0   (offset: 0x3c14)
#using script_19aec99df234f03a;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\rank;
#using scripts\mp\weapons;

#namespace cranked;

// Namespace cranked
// Params 0, eflags: 0x1
// Checksum 0x8146cee1, Offset: 0x2c8
// Size: 0x69f
function autoexec init()
{
    if ( getdvarint( @"scr_cranked_killswitch", 0 ) )
    {
        return;
    }
    
    level.crankedbombtimer = getmatchrulesdata( "commonOption", "crankedBombTimer" );
    
    if ( !isdefined( level.crankedbombtimer ) || level.crankedbombtimer == 0 )
    {
        return;
    }
    
    assert( !level.gametypebundle.var_cf50e7dd871bfe66, "<dev string:x24>" );
    callback::add( #"hash_b08f691cf30f9def", &function_a057996ced2da9dc );
    callback::add( #"hash_69215f7cb166ba95", &function_cb9c31a1d7904cb1 );
    callback::add( #"hash_71281d183072c5e8", &function_79e186b7fe2f2cbb );
    
    if ( !isdefined( level.gametypebundle.var_30bf23b4752cc4d4 ) )
    {
        level.gametypebundle.var_30bf23b4752cc4d4 = 0;
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"hash_af5376dd4fc03b8f", &function_5fa79ac7f14502f9 );
    callback::add( #"hash_dcaaf3c8d874eeab", &function_9252e295d60087d9 );
    callback::add( #"hash_b58aae7268714e80", &function_194b1e588a436f52 );
    callback::add( #"hash_22ee4439898d01bd", &function_578be58f794f2ab3 );
    callback::add( #"hash_90e8659b0b441f02", &function_17a3b62014d552d3 );
    callback::add( #"hash_f1f1c4c5d121b7df", &function_faaf4cf5bfee74a6 );
    callback::add( #"player_death", &onkilled );
    
    if ( level.gametypebundle.var_9ec34a51b01735a5 )
    {
        if ( !isdefined( level.gametypebundle.var_dd5874ef33b5421a ) )
        {
            level.gametypebundle.var_dd5874ef33b5421a = 1;
        }
    }
    else
    {
        level.gametypebundle.var_dd5874ef33b5421a = 1;
    }
    
    if ( level.gametypebundle.var_1a770d7bb00956e0 )
    {
        callback::add( #"hash_d4bbb4278ed1fcab", &oncrankedhit );
        
        if ( !isdefined( level.gametypebundle.var_1771bb45f0bd76e8 ) )
        {
            level.gametypebundle.var_1771bb45f0bd76e8 = 1;
        }
    }
    
    if ( !isdefined( level.gametypebundle.var_d00f74bcb0dadcfe ) )
    {
        level.gametypebundle.var_d00f74bcb0dadcfe = 1;
    }
    
    if ( !isdefined( level.gametypebundle.var_558c1c715a4d662e ) )
    {
        level.gametypebundle.var_558c1c715a4d662e = 10;
    }
    
    if ( !isdefined( level.gametypebundle.var_bba4da52eaf1ff50 ) )
    {
        level.gametypebundle.var_bba4da52eaf1ff50 = 0.5;
    }
    
    if ( !isdefined( level.gametypebundle.var_45cb4433e870ec92 ) )
    {
        level.gametypebundle.var_45cb4433e870ec92 = 0.25;
    }
    
    if ( !isdefined( level.gametypebundle.var_44f713a56ca0cb5e ) )
    {
        level.gametypebundle.var_44f713a56ca0cb5e = 1;
    }
    
    if ( !isdefined( level.gametypebundle.var_f411bb185a8c306b ) )
    {
        level.gametypebundle.var_f411bb185a8c306b = 1;
    }
    
    level.var_2d8ab98961edff5f = &function_f411bb185a8c306b;
    level.var_1fccdf402d0756ac = &function_27ca86a815e4eac2;
    level.var_199ea879c219d932 = &function_be59f8be978b1927;
    level.var_5e3de022ab7dace1 = &function_9a5488bc8764d44a;
    level.var_1d4d11b58cd611a0 = &function_3c0aca944fee8270;
    level.var_feb5ffcd580afd63 = &function_e13ec1fd6063c957;
    
    if ( !isdefined( level.gametypebundle.var_4321fee7b00fc2b2 ) )
    {
        level.gametypebundle.var_4321fee7b00fc2b2 = 1;
    }
    
    if ( !isdefined( level.gametypebundle.explosionweapon ) )
    {
        level.gametypebundle.explosionweapon = "bomb_site_mp";
    }
    
    if ( !isdefined( level.gametypebundle.var_aa2a8acf4f3ed0a2 ) )
    {
        level.gametypebundle.var_aa2a8acf4f3ed0a2 = 256;
    }
    
    if ( !isdefined( level.gametypebundle.var_ecb9fa2e45aa84e1 ) )
    {
        level.gametypebundle.var_ecb9fa2e45aa84e1 = 100;
    }
    
    if ( !isdefined( level.gametypebundle.var_636fa5eb40a7e697 ) )
    {
        level.gametypebundle.var_636fa5eb40a7e697 = 200;
    }
    
    level._effect[ "cranked_explode" ] = loadfxasset( level.gametypebundle.var_37b7aac298508655 ?? "vfx_iw9_dmz_bombsite_explo" );
    level._effect[ "cranked_explode_large" ] = loadfxasset( level.gametypebundle.var_9bc784c24c62e85c ?? "vfx_iw9_dmz_bombsite_explo" );
    
    if ( !isdefined( level.gametypebundle.var_e9a7bf23cb792848 ) )
    {
        level.gametypebundle.var_e9a7bf23cb792848 = #"hash_eedbcf1ca60c33fd";
    }
    
    if ( !isdefined( level.gametypebundle.var_489a98e70917989f ) )
    {
        level.gametypebundle.var_489a98e70917989f = #"hash_74d2441607e170c1";
    }
    
    if ( !isdefined( level.gametypebundle.var_3aba4bf28fb62ab0 ) )
    {
        level.gametypebundle.var_3aba4bf28fb62ab0 = #"hash_8cb228ac8940d2a0";
    }
    
    if ( !isdefined( level.gametypebundle.var_9b6530663e633c4d ) )
    {
        level.gametypebundle.var_9b6530663e633c4d = #"hash_843f33818debe2c6";
    }
    
    if ( !isdefined( level.gametypebundle.var_8642bddb29508922 ) )
    {
        level.gametypebundle.var_8642bddb29508922 = #"hash_d61f0ffe6b1d6d80";
    }
    
    if ( !isdefined( level.gametypebundle.var_a17dfa285cbf713b ) )
    {
        level.gametypebundle.var_a17dfa285cbf713b = #"hash_cfc761fb5bffa621";
    }
    
    if ( !isdefined( level.gametypebundle.var_9963446f87ac7a8c ) )
    {
        level.gametypebundle.var_9963446f87ac7a8c = #"hash_d705f30699bf2927";
    }
    
    if ( !isdefined( level.gametypebundle.var_42fdfe797cc9876b ) )
    {
        level.gametypebundle.var_42fdfe797cc9876b = #"hash_81e87b292d17fbbe";
    }
    
    if ( !isdefined( level.gametypebundle.var_42007dd78b37a4c2 ) )
    {
        level.gametypebundle.var_42007dd78b37a4c2 = #"hash_c0b7a4cf6745e820";
    }
}

// Namespace cranked
// Params 1
// Checksum 0x45278e0b, Offset: 0x96f
// Size: 0x9f
function onplayerspawned( params )
{
    player = params.player;
    player setclientomnvar( "ui_cranked_meter_is_shown", 1 );
    
    if ( getdvarint( @"hash_6189590078585c7b", level.gametypebundle.var_30bf23b4752cc4d4 ) )
    {
        flags::gameflagwait( "prematch_done" );
        player makeplayercranked( "begin_cranked" );
        player thread rank::scoreeventpopup( #"begin_cranked" );
        player setcrankedplayerbombtimer( #"full" );
        player setclientomnvar( "ui_cranked_player_killed", 0 );
    }
}

// Namespace cranked
// Params 2
// Checksum 0x62d082f3, Offset: 0xa16
// Size: 0x15a
function makeplayercranked( event, skipawardtier = 0 )
{
    if ( !isdefined( self.cranked_end_time ) )
    {
        self.cranked_end_time = gettime();
    }
    
    dialog::leaderdialogonplayer( event );
    setcrankedplayerbombtimer( #"full" );
    self.cranked = 1;
    self.supportcranked = 1;
    self.var_1f80328e1de218de = 0;
    
    if ( level.gametypebundle.awardtiers.size > 0 && !skipawardtier )
    {
        namespace_69e3a436b5d8370e::function_65899efd82f98479( level.gametypebundle.awardtiers[ self.var_1f80328e1de218de ] );
        self.var_1f80328e1de218de++;
        function_ca98091105bf7c78();
        return;
    }
    
    if ( skipawardtier )
    {
        return;
    }
    
    perk::giveperk( "specialty_fastreload" );
    perk::giveperk( "specialty_quickdraw" );
    perk::giveperk( "specialty_fastoffhand" );
    perk::giveperk( "specialty_fastsprintrecovery" );
    perk::giveperk( "specialty_marathon" );
    perk::giveperk( "specialty_quickswap" );
    perk::giveperk( "specialty_stalker" );
    perk::giveperk( "specialty_sprintfire" );
    self.movespeedscaler = 1.2;
    common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
    weapons::updatemovespeedscale();
}

// Namespace cranked
// Params 0, eflags: 0x4
// Checksum 0xff4b372d, Offset: 0xb78
// Size: 0xc0
function private function_ca98091105bf7c78()
{
    if ( level.gametypebundle.var_ba35dcfee2ccd5c && level.gametypebundle.awardtiers && self.var_1f80328e1de218de < level.gametypebundle.awardtiers.size )
    {
        gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_ba35dcfee2ccd5c );
    }
    
    if ( level.gametypebundle.var_5e1205749cda756 && self.var_1f80328e1de218de == level.gametypebundle.awardtiers.size - 1 )
    {
        dialog::leaderdialogonplayer( level.gametypebundle.var_5e1205749cda756 );
    }
}

// Namespace cranked
// Params 4
// Checksum 0x395c908d, Offset: 0xc40
// Size: 0x1cc
function oncranked( victim, attacker, lifeid, skipawardtier = 0 )
{
    if ( isdefined( victim ) )
    {
        victim thread cleanupcrankedplayertimer();
        victim.var_1f80328e1de218de = 0;
    }
    
    if ( player::isreallyalive( attacker ) )
    {
        attacker function_df2bbcdc1c079446( skipawardtier );
    }
    
    if ( isdefined( victim ) && isdefined( victim.attackers ) && !isdefined( level.assists_disabled ) && level.gametypebundle.var_d00f74bcb0dadcfe )
    {
        foreach ( player in victim.attackers )
        {
            if ( !isdefined( damage::_validateattacker( player ) ) )
            {
                continue;
            }
            
            if ( player == attacker )
            {
                continue;
            }
            
            if ( victim == player )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
            {
                player function_df2bbcdc1c079446();
                continue;
            }
            
            if ( !player.cranked )
            {
                continue;
            }
            
            player thread oncrankedassist( "assist_cranked" );
            player thread rank::scoreeventpopup( #"assist_cranked" );
            player thread rank::scoreeventpopup( #"time_added" );
            
            if ( !game_utility::function_d3f8957534dc62af() )
            {
                player gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_9b6530663e633c4d );
            }
        }
    }
}

// Namespace cranked
// Params 1
// Checksum 0x24f8b37a, Offset: 0xe14
// Size: 0xab
function function_df2bbcdc1c079446( skipawardtier = 0 )
{
    if ( self.cranked )
    {
        thread rank::scoreeventpopup( #"time_added" );
        thread oncrankedkill( #"kill_cranked", skipawardtier );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_3aba4bf28fb62ab0 );
        }
        
        return;
    }
    
    makeplayercranked( "begin_cranked", skipawardtier );
    thread rank::scoreeventpopup( #"begin_cranked" );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_8642bddb29508922 );
    }
}

// Namespace cranked
// Params 0
// Checksum 0xa5ea4b06, Offset: 0xec7
// Size: 0x99
function cleanupcrankedplayertimer()
{
    self setclientomnvar( "ui_cranked_timer_is_shown", 0 );
    self setclientomnvar( o"ui_cranked_bomb_timer_end_milliseconds", 0 );
    self setclientomnvar( o"ui_cranked_bomb_timer", 0 );
    self setclientomnvar( o"ui_cranked_timer_time", 0 );
    function_9b08ed4abb4742a7();
    namespace_69e3a436b5d8370e::function_66186e21ab56457c();
    self.cranked = undefined;
    self.cranked_end_time = undefined;
    self.supportcranked = undefined;
    self.var_809ce60fdffd0fab = 0;
    self.harpactive = 0;
    self.skipuavupdate = undefined;
    self.var_1f80328e1de218de = undefined;
    thread waitthenstopcrankedbombtimer();
}

// Namespace cranked
// Params 0
// Checksum 0x58e894f5, Offset: 0xf68
// Size: 0xf
function waitthenstopcrankedbombtimer()
{
    waitframe();
    self notify( #"stop_cranked" );
}

// Namespace cranked
// Params 0, eflags: 0x4
// Checksum 0x7bdfc2de, Offset: 0xf7f
// Size: 0x115
function private function_9b08ed4abb4742a7()
{
    if ( !isdefined( self.var_1f80328e1de218de ) )
    {
        return;
    }
    
    if ( !level.gametypebundle.awardtiers.size )
    {
        perk::removeperk( "specialty_fastreload" );
        perk::removeperk( "specialty_quickdraw" );
        perk::removeperk( "specialty_fastoffhand" );
        perk::removeperk( "specialty_fastsprintrecovery" );
        perk::removeperk( "specialty_marathon" );
        perk::removeperk( "specialty_quickswap" );
        perk::removeperk( "specialty_stalker" );
        perk::removeperk( "specialty_sprintfire" );
        self.movespeedscaler = 1;
        common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
        weapons::updatemovespeedscale();
        return;
    }
    
    while ( self.var_1f80328e1de218de >= 0 )
    {
        if ( level.gametypebundle.awardtiers[ self.var_1f80328e1de218de ] )
        {
            namespace_69e3a436b5d8370e::removeawardtier( level.gametypebundle.awardtiers[ self.var_1f80328e1de218de ], 1 );
        }
        
        self.var_1f80328e1de218de--;
    }
}

// Namespace cranked
// Params 0
// Checksum 0xf3b70ab5, Offset: 0x109c
// Size: 0x106
function function_d026d9c4e1c4902e()
{
    if ( !self.cranked )
    {
        makeplayercranked( "begin_cranked" );
        thread rank::scoreeventpopup( #"begin_cranked" );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_8642bddb29508922 );
        }
    }
    else
    {
        thread rank::scoreeventpopup( #"time_added" );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_3aba4bf28fb62ab0 );
        }
    }
    
    if ( isdefined( level.gametypebundle.awardtiers ) )
    {
        while ( self.var_1f80328e1de218de < level.gametypebundle.awardtiers.size )
        {
            namespace_69e3a436b5d8370e::function_65899efd82f98479( level.gametypebundle.awardtiers[ self.var_1f80328e1de218de ] );
            self.var_1f80328e1de218de++;
        }
        
        function_ca98091105bf7c78();
    }
    
    setcrankedplayerbombtimer( #"full" );
}

// Namespace cranked
// Params 2
// Checksum 0xee1a1757, Offset: 0x11aa
// Size: 0xcb
function oncrankedkill( event, skipawardtier = 0 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !skipawardtier && level.gametypebundle.awardtiers && self.var_1f80328e1de218de < level.gametypebundle.awardtiers.size )
    {
        namespace_69e3a436b5d8370e::function_65899efd82f98479( level.gametypebundle.awardtiers[ self.var_1f80328e1de218de ] );
        self.var_1f80328e1de218de++;
        function_ca98091105bf7c78();
    }
    
    while ( !isdefined( self.pers ) )
    {
        waitframe();
    }
    
    setcrankedplayerbombtimer( #"kill" );
}

// Namespace cranked
// Params 1
// Checksum 0x226c91f9, Offset: 0x127d
// Size: 0x34
function oncrankedassist( event )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    setcrankedplayerbombtimer( #"assist" );
}

// Namespace cranked
// Params 1
// Checksum 0xe3b4234c, Offset: 0x12b9
// Size: 0x42
function oncrankedhit( data )
{
    if ( data.attacker == data.victim )
    {
        return;
    }
    
    data.attacker setcrankedplayerbombtimer( #"hit" );
}

// Namespace cranked
// Params 1
// Checksum 0xa028cd1, Offset: 0x1303
// Size: 0x104
function onkilled( params )
{
    params.victim cleanupcrankedplayertimer();
    params.victim setclientomnvar( "ui_cranked_player_killed", 1 );
    
    if ( isplayer( params.attacker ) && params.victim player_utility::isenemy( params.attacker ) )
    {
        skipawardtier = params.iskillstreakweapon && !weapon::function_1344ad15d2d7bd21( params.objweapon );
        params.attacker oncranked( params.victim, params.attacker, params.lifeid, skipawardtier );
    }
    
    if ( level.gametypebundle.var_99db82bbfef223a0 )
    {
        params.victim gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_99db82bbfef223a0 );
    }
}

// Namespace cranked
// Params 1
// Checksum 0xfa62b9a3, Offset: 0x140f
// Size: 0x12a
function function_bec0ab46f7db679( initialtime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_4adc9704fc30244e" );
    self endon( #"stop_cranked" );
    self setclientomnvar( "ui_cranked_timer_is_shown", 1 );
    self setclientomnvar( "ui_cranked_timer_out_of_time", 0 );
    self setclientomnvar( o"ui_cranked_timer_time", initialtime );
    self setclientomnvar( "ui_cranked_timer_time_max", int( level.gametypebundle.crankedtimelimit ?? 30 ) * 1000 );
    nextsecond = gettime();
    
    while ( initialtime > 0 )
    {
        if ( self.var_809ce60fdffd0fab )
        {
            self waittill( #"cranked_unpaused" );
            nextsecond = gettime();
        }
        
        nextsecond += 100;
        wait ( nextsecond - gettime() ) * 0.001;
        
        if ( !player::isreallyalive( self ) )
        {
            break;
        }
        
        resulttime = int( max( initialtime - 100, 0 ) );
        self setclientomnvar( o"ui_cranked_timer_time", resulttime );
        initialtime -= 100;
    }
    
    self setclientomnvar( "ui_cranked_timer_out_of_time", 1 );
}

// Namespace cranked
// Params 1
// Checksum 0x4d6b75e1, Offset: 0x1541
// Size: 0x322
function setcrankedplayerbombtimer( type )
{
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    waittime = level.crankedbombtimer;
    var_10f9d7e9651d3e9b = ( self.cranked_end_time - gettime() ) * 0.001;
    
    if ( type == #"full" )
    {
        waittime = level.crankedbombtimer;
    }
    else if ( type == #"hit" )
    {
        waittime = int( min( var_10f9d7e9651d3e9b + level.gametypebundle.var_1771bb45f0bd76e8, level.crankedbombtimer ) );
    }
    else if ( type == #"assist" )
    {
        if ( level.gametypebundle.var_9ec34a51b01735a5 )
        {
            waittime = int( min( var_10f9d7e9651d3e9b + level.crankedbombtimer * level.gametypebundle.var_bba4da52eaf1ff50 * level.gametypebundle.var_dd5874ef33b5421a, level.crankedbombtimer ) );
        }
        else
        {
            waittime = int( min( var_10f9d7e9651d3e9b + level.crankedbombtimer * level.gametypebundle.var_bba4da52eaf1ff50, level.crankedbombtimer ) );
        }
    }
    else if ( type == #"friendly_tag" )
    {
        waittime = int( min( var_10f9d7e9651d3e9b + level.crankedbombtimer * level.gametypebundle.var_45cb4433e870ec92, level.crankedbombtimer ) );
    }
    else if ( level.gametypebundle.var_9ec34a51b01735a5 )
    {
        if ( self.cranked && self.cranked_end_time )
        {
            waittime = int( min( var_10f9d7e9651d3e9b + level.crankedbombtimer * level.gametypebundle.var_dd5874ef33b5421a, level.crankedbombtimer ) );
        }
        else
        {
            waittime = int( waittime * level.gametypebundle.var_dd5874ef33b5421a );
        }
    }
    else if ( level.gametypebundle.var_8c1555a38733ae78 && type == #"kill" )
    {
        waittime = int( min( var_10f9d7e9651d3e9b + level.gametypebundle.var_8c1555a38733ae78, level.crankedbombtimer ) );
    }
    else
    {
        waittime = level.crankedbombtimer;
    }
    
    endtime = waittime * 1000 + gettime();
    self setclientomnvar( o"ui_cranked_bomb_timer_end_milliseconds", endtime );
    self.cranked_end_time = endtime;
    self notify( #"hash_4adc9704fc30244e" );
    thread watchcrankedplayerhostmigration();
    thread watchcrankedbombtimer( waittime );
    thread watchcrankedendgame();
    thread function_bec0ab46f7db679( waittime * 1000 );
    
    if ( isdefined( level.gametypebundle.var_1cdd2bbc4d1d974c ) && self.harpactive )
    {
        if ( !isdefined( self.skipuavupdate ) )
        {
            thread namespace_69e3a436b5d8370e::function_e794e8af7dca7970();
        }
        
        thread namespace_69e3a436b5d8370e::function_d7ebd1a661a4248f( level.gametypebundle.var_1cdd2bbc4d1d974c );
    }
}

// Namespace cranked
// Params 1
// Checksum 0xe5193120, Offset: 0x186b
// Size: 0xa9
function function_5fa79ac7f14502f9( params )
{
    player = params.enterplayer;
    
    if ( !isdefined( params.zone.contestedtime ) )
    {
        player.var_809ce60fdffd0fab = 1;
    }
    
    if ( player.cranked )
    {
        player setcrankedplayerbombtimer( #"assist" );
    }
    else
    {
        player makeplayercranked( "begin_cranked" );
        player thread rank::scoreeventpopup( #"begin_cranked" );
        player setcrankedplayerbombtimer( #"full" );
    }
    
    player thread function_ee01e7e7f4c36838();
}

// Namespace cranked
// Params 1
// Checksum 0x99d0b2c9, Offset: 0x191c
// Size: 0x48
function function_9252e295d60087d9( params )
{
    if ( isdefined( params.exitplayer ) )
    {
        params.exitplayer.var_809ce60fdffd0fab = 0;
        params.exitplayer notify( #"cranked_unpaused" );
    }
}

// Namespace cranked
// Params 0
// Checksum 0x2a4b87c3, Offset: 0x196c
// Size: 0x55
function function_ee01e7e7f4c36838()
{
    self notify( #"hash_699107deed0ebfb6" );
    self endon( #"hash_699107deed0ebfb6" );
    self endon( #"hash_a35808f532d8b26c" );
    level waittill( #"zone_moved" );
    
    if ( self.var_809ce60fdffd0fab )
    {
        self.var_809ce60fdffd0fab = 0;
        self notify( #"cranked_unpaused" );
    }
}

// Namespace cranked
// Params 1
// Checksum 0x7ab9f163, Offset: 0x19c9
// Size: 0x121
function function_194b1e588a436f52( data )
{
    zone = data.zone;
    
    foreach ( team in level.teamnamelist )
    {
        if ( zone.touchlist[ team ].size )
        {
            touchlist = zone.touchlist[ team ];
            players_touching = getarraykeys( touchlist );
            
            for ( index = 0; index < players_touching.size ; index++ )
            {
                player = touchlist[ players_touching[ index ] ].player;
                
                if ( isplayer( player ) )
                {
                    player.var_809ce60fdffd0fab = 0;
                    player notify( #"cranked_unpaused" );
                }
            }
        }
    }
}

// Namespace cranked
// Params 1
// Checksum 0xf049257e, Offset: 0x1af2
// Size: 0x11a
function function_578be58f794f2ab3( data )
{
    zone = data.zone;
    
    foreach ( team in level.teamnamelist )
    {
        if ( zone.touchlist[ team ].size )
        {
            touchlist = zone.touchlist[ team ];
            players_touching = getarraykeys( touchlist );
            
            for ( index = 0; index < players_touching.size ; index++ )
            {
                player = touchlist[ players_touching[ index ] ].player;
                
                if ( isplayer( player ) )
                {
                    function_5fa79ac7f14502f9( { #enterplayer:player } );
                }
            }
        }
    }
}

// Namespace cranked
// Params 0
// Checksum 0x2250999f, Offset: 0x1c14
// Size: 0x2a
function function_3c0aca944fee8270()
{
    if ( self.cranked )
    {
        setcrankedplayerbombtimer( #"kill" );
        return;
    }
    
    oncranked( undefined, self );
}

// Namespace cranked
// Params 0
// Checksum 0x32d5c52a, Offset: 0x1c46
// Size: 0x12
function function_e13ec1fd6063c957()
{
    setcrankedplayerbombtimer( #"kill" );
}

// Namespace cranked
// Params 2
// Checksum 0x6f021516, Offset: 0x1c60
// Size: 0x12d
function function_9a5488bc8764d44a( pickupplayer, dogtag )
{
    attackers = dogtag.attackers ?? [ dogtag.attacker ];
    attackerpickup = arraycontains( attackers, pickupplayer );
    
    if ( !pickupplayer.cranked || level.gametypebundle.var_902ffecd6fe1a5b1 && !attackerpickup )
    {
        pickupplayer oncranked( undefined, pickupplayer );
    }
    else
    {
        pickupplayer setcrankedplayerbombtimer( #"kill" );
    }
    
    foreach ( attacker in attackers )
    {
        if ( pickupplayer != attacker && attacker.cranked )
        {
            attacker setcrankedplayerbombtimer( #"kill" );
        }
    }
}

// Namespace cranked
// Params 0
// Checksum 0x5b4b8b12, Offset: 0x1d95
// Size: 0x42
function function_be59f8be978b1927()
{
    if ( !self.cranked || level.gametypebundle.var_902ffecd6fe1a5b1 )
    {
        oncranked( undefined, self );
        return;
    }
    
    setcrankedplayerbombtimer( #"friendly_tag" );
}

// Namespace cranked
// Params 2
// Checksum 0x70bbb9f0, Offset: 0x1ddf
// Size: 0x56
function function_27ca86a815e4eac2( score, victim )
{
    if ( score != 0 )
    {
        score += level.gametypebundle.var_f411bb185a8c306b;
        thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", score ) );
    }
    
    oncranked( victim, self );
    return score;
}

// Namespace cranked
// Params 1
// Checksum 0xd0c5dc78, Offset: 0x1e3e
// Size: 0x35
function function_a057996ced2da9dc( data )
{
    data.victim cleanupcrankedplayertimer();
    data.victim setclientomnvar( "ui_cranked_player_killed", 1 );
}

// Namespace cranked
// Params 1
// Checksum 0x82a7bbfc, Offset: 0x1e7b
// Size: 0x35
function function_cb9c31a1d7904cb1( data )
{
    data.victim cleanupcrankedplayertimer();
    data.victim setclientomnvar( "ui_cranked_player_killed", 1 );
}

// Namespace cranked
// Params 1
// Checksum 0x79bd52b3, Offset: 0x1eb8
// Size: 0x34
function function_79e186b7fe2f2cbb( data )
{
    data.attacker oncranked( data.victim, data.attacker );
}

// Namespace cranked
// Params 4
// Checksum 0x89fe38a8, Offset: 0x1ef4
// Size: 0xac
function function_f411bb185a8c306b( score, victim, var_11e7af11ea100dd0, lifeid )
{
    if ( !level.gametypebundle.var_44f713a56ca0cb5e )
    {
        return score;
    }
    
    if ( game_utility_mp::matchmakinggame() && isdefined( self.cranked ) )
    {
        if ( !var_11e7af11ea100dd0 && score != 0 )
        {
            if ( self.var_208c55191cf6f7ab )
            {
                score *= 2;
            }
            else
            {
                score += level.gametypebundle.var_f411bb185a8c306b;
            }
            
            thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", score ) );
        }
    }
    
    return score;
}

// Namespace cranked
// Params 1
// Checksum 0xf74df8c6, Offset: 0x1fa9
// Size: 0xa5
function function_17a3b62014d552d3( params )
{
    player = params.player;
    player setclientomnvar( "ui_cranked_bomb_planted", 0 );
    player.var_809ce60fdffd0fab = 1;
    
    if ( !player.cranked )
    {
        player makeplayercranked( "begin_cranked" );
        player thread rank::scoreeventpopup( #"begin_cranked" );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            player gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_8642bddb29508922 );
        }
    }
    
    player setcrankedplayerbombtimer( #"full" );
}

// Namespace cranked
// Params 1
// Checksum 0x98be9643, Offset: 0x2056
// Size: 0x6e
function function_faaf4cf5bfee74a6( params )
{
    player = params.player;
    success = params.success;
    player.var_809ce60fdffd0fab = 0;
    player notify( #"cranked_unpaused" );
    
    if ( success )
    {
        player setclientomnvar( "ui_cranked_bomb_planted", 1 );
        player thread function_d026d9c4e1c4902e();
    }
}

// Namespace cranked
// Params 0
// Checksum 0x73df6440, Offset: 0x20cc
// Size: 0x9a
function watchcrankedplayerhostmigration()
{
    self notify( #"hash_9ff5b491e86d7f08" );
    self endon( #"hash_9ff5b491e86d7f08" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_cranked" );
    level waittill( #"host_migration_begin" );
    timepassed = hostmigration::waittillhostmigrationdone();
    
    if ( timepassed > 0 )
    {
        self setclientomnvar( o"ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + timepassed );
        return;
    }
    
    self setclientomnvar( o"ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time );
}

// Namespace cranked
// Params 0
// Checksum 0x54d30c90, Offset: 0x216e
// Size: 0x90
function watchcrankedendgame()
{
    self notify( #"hash_dabbb54022a4b6b8" );
    self endon( #"hash_dabbb54022a4b6b8" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_cranked" );
    
    while ( true )
    {
        if ( game_utility_mp::getgamestate( self ) == "postgame" || level.gameended )
        {
            self setclientomnvar( o"ui_cranked_bomb_timer_end_milliseconds", 0 );
            self setclientomnvar( o"ui_cranked_bomb_timer", 0 );
            self setclientomnvar( o"ui_cranked_timer_time", 0 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace cranked
// Params 1
// Checksum 0xd08db877, Offset: 0x2206
// Size: 0x1bc
function watchcrankedbombtimer( waittime )
{
    self notify( #"hash_3b820b2a39af4142" );
    self endon( #"hash_3b820b2a39af4142" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"stop_cranked" );
    thread crankedprogressuiupdater( waittime );
    countdown_time = level.gametypebundle.var_558c1c715a4d662e;
    var_88bd4304f6a5ead2 = waittime - countdown_time - 1;
    
    if ( var_88bd4304f6a5ead2 > 0 )
    {
        if ( self.var_809ce60fdffd0fab )
        {
            self waittill( #"cranked_unpaused" );
        }
        
        hostmigration::waitlongdurationwithgameendtimeupdate( var_88bd4304f6a5ead2 );
        hostmigration::waitlongdurationwithgameendtimeupdate( 1 );
        gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_42007dd78b37a4c2 );
    }
    
    while ( countdown_time > 0 )
    {
        if ( countdown_time == 1 )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_42fdfe797cc9876b );
        }
        else if ( countdown_time <= roundint( level.gametypebundle.var_558c1c715a4d662e / 2 ) )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_9963446f87ac7a8c );
        }
        else if ( countdown_time < level.gametypebundle.var_558c1c715a4d662e )
        {
            gameplay_sound_fx::playlocalsoundfx( level.gametypebundle.var_a17dfa285cbf713b );
        }
        
        hostmigration::waitlongdurationwithgameendtimeupdate( 1 );
        
        if ( !self.var_809ce60fdffd0fab )
        {
            countdown_time--;
        }
    }
    
    if ( level.gametypebundle.var_9ef2f50f1140a377 )
    {
        thread utility::delaythread( 0.25, &function_d50893991068c8bc );
        return;
    }
    
    function_d50893991068c8bc();
}

// Namespace cranked
// Params 0
// Checksum 0x167b6f31, Offset: 0x23ca
// Size: 0x205
function function_d50893991068c8bc()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"stop_cranked" );
    
    if ( player::isreallyalive( self ) && level.gametypebundle.var_4321fee7b00fc2b2 )
    {
        explorg = self.origin + ( 0, 0, 32 );
        var_3c6b2aec7934304 = self.largeexplosion ? level.gametypebundle.var_489a98e70917989f : level.gametypebundle.var_e9a7bf23cb792848;
        explosionfx = self.largeexplosion ? "cranked_explode_large" : "cranked_explode";
        gameplay_sound_fx::function_28103d3430792dce( explorg, var_3c6b2aec7934304 );
        playfx( level._effect[ explosionfx ], explorg );
        radius = self.largeexplosion ? level.gametypebundle.var_80b52e2c71aa4070 : level.gametypebundle.var_aa2a8acf4f3ed0a2;
        mindamage = self.largeexplosion ? level.gametypebundle.var_dc74ea9e00559dd3 : level.gametypebundle.var_ecb9fa2e45aa84e1;
        maxdamage = self.largeexplosion ? level.gametypebundle.var_7ee365d26fdde155 : level.gametypebundle.var_636fa5eb40a7e697;
        damage::_suicide();
        self radiusdamage( explorg, radius, maxdamage, mindamage, self, "MOD_EXPLOSIVE", level.gametypebundle.explosionweapon );
        
        if ( player::isreallyalive() )
        {
            self dodamage( self.maxhealth, explorg, self, undefined, "MOD_EXPLOSIVE", level.gametypebundle.explosionweapon );
        }
    }
}

// Namespace cranked
// Params 1
// Checksum 0xe9210177, Offset: 0x25d7
// Size: 0xbb
function crankedprogressuiupdater( waittime )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_e419b0489eb02f53" );
    self endon( #"hash_e419b0489eb02f53" );
    level endon( #"game_ended" );
    currenttimelimitdelay = 0;
    
    if ( waittime != level.crankedbombtimer )
    {
        currenttimelimitdelay = level.crankedbombtimer - waittime;
    }
    
    while ( isalive( self ) )
    {
        currenttimelimitdelay += level.framedurationseconds;
        progress = clamp( 1 - currenttimelimitdelay / level.crankedbombtimer, 0, 1 );
        self setclientomnvar( o"ui_cranked_bomb_timer", progress );
        waitframe();
    }
}

// Namespace cranked
// Params 0
// Checksum 0x83ef1abd, Offset: 0x269a
// Size: 0x43
function function_f3b7334ff88e938a()
{
    level endon( #"game_ended" );
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    if ( self.cranked )
    {
        setcrankedplayerbombtimer( #"kill" );
        return;
    }
    
    oncranked( undefined, self );
}

/#

    // Namespace cranked
    // Params 0
    // Checksum 0x63b1e7d3, Offset: 0x26e5
    // Size: 0x33, Type: dev
    function setcrankeddvarfordev()
    {
        if ( !isdefined( level.crankedbombtimer ) )
        {
            level.crankedbombtimer = 30;
        }
        
        setdevdvarifuninitialized( @"scr_cranked_bomb_timer", level.crankedbombtimer );
    }

#/
