// script_2e61bcf54eaedd23  (hash_2e61bcf54eaedd23.gscc) (size: 5215 Bytes / 0x145f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19348964 (422873444)
// size ...... 5215 (0x145f)
// includes .. 1   (offset: 0x12e7)
// strings ... 20  (offset: 0x12ef)
// dev strs .. 0   (offset: 0x1423)
// exports ... 15  (offset: 0xb3b)
// cseg ...... 0x1c1 + 0x97a (0xb3b)
// imports ... 47  (offset: 0xd93)
// animtree1 . 1   (offset: 0x1423)
// animtree2 . 3   (offset: 0x142f)
#using scripts\common\anim;

#namespace ai_parachute_util;

#using_animtree( "script_model" );

// Namespace ai_parachute_util
// Params 0
// Checksum 0x9b20acd5, Offset: 0x1df
// Size: 0x85
function init_parachute_functions()
{
    level.var_e2531c6b0833956d = &function_3bf3890f4bfe722b;
    level.var_23472e00aeec245f = &function_ca6907e8a64a5381;
    precachemodel( "misc_wm_br_parachute" );
    level.scr_anim[ "parachute" ][ "sdr_com_parachute_prepare_for_landing" ] = %sdr_com_parachute_prepare_for_landing;
    level.scr_anim[ "parachute" ][ "sdr_com_parachute_idle" ] = %sdr_com_parachute_idle;
    level.scr_anim[ "parachute" ][ "sdr_com_parachute_pullcord" ] = %sdr_com_parachute_pullcord;
}

// Namespace ai_parachute_util
// Params 1, eflags: 0x4
// Checksum 0xb383d321, Offset: 0x26c
// Size: 0x2c
function private function_3bf3890f4bfe722b( animname )
{
    self.animname = "parachute";
    self useanimtree( #animtree );
    thread animation::anim_single_solo( self, animname );
}

// Namespace ai_parachute_util
// Params 3, eflags: 0x4
// Checksum 0xce6d6670, Offset: 0x2a0
// Size: 0x27
function private function_ca6907e8a64a5381( pos, angles, bsetorigin )
{
    self forceteleport( pos, angles );
}

// Namespace ai_parachute_util
// Params 6
// Checksum 0x1ab89413, Offset: 0x2cf
// Size: 0x79
function function_eaef79ee8709ab89( start_pos, end_pos, open_height, land_variance, skydive_time, glide_time )
{
    self endon( #"death" );
    thread function_e65532a3176043cc();
    function_96a308e0581a81bf( start_pos, end_pos, open_height, land_variance );
    agentparachuteskydive( skydive_time );
    function_62a28f0faa953821();
    function_13cf34635bc71cfb( glide_time );
    function_606733fdabab90db();
}

// Namespace ai_parachute_util
// Params 4
// Checksum 0xc6dce853, Offset: 0x350
// Size: 0x18e
function function_96a308e0581a81bf( start_pos, end_pos, open_height, land_variance )
{
    self allowedstances( "stand" );
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.scripted_mode = 1;
    self.playing_skit = 1;
    self.do_immediate_ragdoll = 1;
    self setcanusecover( 0 );
    landvariance = land_variance ?? 50;
    opendist = open_height ?? 1000;
    self asmsetstate( self.asmname, "parachute_freefall" );
    self._blackboard.parachutestate = "freefall";
    self [[ level.var_23472e00aeec245f ]]( start_pos, self.angles, 1 );
    
    if ( landvariance == 0 )
    {
        self.landing_spot = end_pos;
    }
    else
    {
        startorigin = end_pos + ( randomfloatrange( landvariance * -1, landvariance ), randomfloatrange( landvariance * -1, landvariance ), 0 );
        self.landing_spot = getclosestpointonnavmesh( getgroundposition( startorigin, 64, 15000, 15000 ) );
    }
    
    dest = self.landing_spot;
    dir = dest - self.origin;
    dir = vectornormalize( dir );
    opendist += randomfloatrange( -200, 200 );
    self.skydive_dest = self.landing_spot - dir * opendist;
}

// Namespace ai_parachute_util
// Params 1
// Checksum 0x87dfabf9, Offset: 0x4e6
// Size: 0x175
function agentparachuteskydive( skydive_time )
{
    self endon( #"death" );
    dest = self.landing_spot;
    dir = dest - self.origin;
    yaw = vectortoyaw( dir );
    self [[ level.var_23472e00aeec245f ]]( self.origin, ( self.angles[ 0 ], yaw, self.angles[ 2 ] ), 0 );
    self.anchor = spawn( "script_origin", self.origin );
    self.anchor.targetname = "agentParachuteSkydive";
    self.anchor.angles = ( 0, self.angles[ 1 ], 0 );
    self linkto( self.anchor );
    rotatetime = 2;
    dist = distance( self.origin, self.skydive_dest );
    movetime = dist / 1000;
    self.anchor rotateto( ( 0, yaw, 0 ), rotatetime );
    self.anchor moveto( self.skydive_dest, movetime );
    waittime = movetime;
    waittime -= 2;
    waittime = clamp( waittime, 0, movetime );
    wait waittime;
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0x93068783, Offset: 0x663
// Size: 0x138
function function_62a28f0faa953821()
{
    if ( level.var_5e4d3c587acb273d )
    {
        self attach( "misc_wm_br_parachute", "j_spine4", 1 );
        self.parachute_model = "misc_wm_br_parachute";
        self.parachute_attach_tag = "j_spine4";
        thread function_42cb66bf380ff4eb( self );
    }
    else
    {
        chute = spawn( "script_model", self gettagorigin( "j_spine4" ) );
        chute.angles = self gettagangles( "j_spine4" );
        chute setmodel( "misc_wm_br_parachute" );
        chute linkto( self, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.chute = chute;
        self.chute thread function_42cb66bf380ff4eb( self );
        self.chute [[ level.var_e2531c6b0833956d ]]( "sdr_com_parachute_pullcord" );
    }
    
    self._blackboard.parachutestate = "parachuting";
    self asmsetstate( self.asmname, "parachute_deploy" );
    self endon( #"death" );
    wait 1.7;
    self asmfireevent( self.asmname, "finish" );
}

// Namespace ai_parachute_util
// Params 1
// Checksum 0xb5a1a8c2, Offset: 0x7a3
// Size: 0x101
function function_13cf34635bc71cfb( glide_time )
{
    self endon( #"death" );
    move_time = glide_time ?? 5;
    move_time += randomfloatrange( -1, 1 );
    decel_time = int( min( 3, move_time * 0.5 ) );
    self.anchor moveto( self.landing_spot, move_time, 0, decel_time );
    wait move_time - 1.5;
    self notify( #"hash_837c415c31f841e0" );
    self._blackboard.parachutestate = "landing";
    
    if ( self.chute )
    {
        self.chute [[ level.var_e2531c6b0833956d ]]( "sdr_com_parachute_prepare_for_landing" );
    }
    
    thread function_cce1b39663661595();
    
    if ( self.chute )
    {
        wait 3;
        self.chute delete();
    }
    else
    {
        wait 2;
        function_627158859ffddc38();
    }
    
    self notify( #"parachute_detached" );
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0x335c58c8, Offset: 0x8ac
// Size: 0x13
function function_cce1b39663661595()
{
    wait 0.5;
    self stoploopsound( "exgm_parachute_falling_npc" );
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0xc71421ed, Offset: 0x8c7
// Size: 0x2e
function function_78b1b0ee78a7970a()
{
    self endon( #"death" );
    wait 1.5;
    self.chute [[ level.var_e2531c6b0833956d ]]( "sdr_com_parachute_idle" );
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0x8d6f6a64, Offset: 0x8fd
// Size: 0xfc
function function_606733fdabab90db()
{
    self endon( #"death" );
    self.anchor.origin = self.landing_spot;
    self motionwarpcancel();
    self unlink();
    self [[ level.var_23472e00aeec245f ]]( self.origin, ( 0, self.anchor.angles[ 1 ], 0 ), 0 );
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    self allowedstances( "prone", "stand", "crouch" );
    self.playing_skit = undefined;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.scripted_mode = 0;
    self.combatmode = "cover";
    self.script_combatmode = "cover";
    self setcanusecover( 1 );
    self notify( #"delete_chute" );
    wait 1;
    self.do_immediate_ragdoll = undefined;
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0x5a2935a5, Offset: 0xa01
// Size: 0x36
function function_e65532a3176043cc()
{
    self endon( #"parachute_detached" );
    self waittill( #"death" );
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
}

// Namespace ai_parachute_util
// Params 0
// Checksum 0xd1bf76ca, Offset: 0xa3f
// Size: 0x47
function function_627158859ffddc38()
{
    if ( self.parachute_model && self.parachute_attach_tag )
    {
        self detach( self.parachute_model, self.parachute_attach_tag );
        self.parachute_model = undefined;
        self.parachute_attach_tag = undefined;
    }
}

// Namespace ai_parachute_util
// Params 1
// Checksum 0xfadb597, Offset: 0xa8e
// Size: 0xad
function function_42cb66bf380ff4eb( ai )
{
    ai endon( #"parachute_detached" );
    ai waittill( #"death" );
    
    if ( level.var_5e4d3c587acb273d )
    {
        ai function_627158859ffddc38();
        chute = spawn( "script_model", ai.origin );
        chute.angles = ai.angles;
        chute setmodel( "misc_wm_br_parachute" );
    }
    else
    {
        self unlink();
        chute = self;
    }
    
    chute endon( #"death" );
    chute movez( 100, 2 );
    wait 2;
    chute delete();
}

