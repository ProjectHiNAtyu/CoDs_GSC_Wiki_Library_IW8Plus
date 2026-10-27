// scripts\mp\common\supers\honeypot.gsc  (hash_6398269fb7757177.gscc) (size: 4515 Bytes / 0x11a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a4011f3 (2587890163)
// size ...... 4515 (0x11a3)
// includes .. 10  (offset: 0x10d3)
// strings ... 10  (offset: 0x1123)
// dev strs .. 0   (offset: 0x11a3)
// exports ... 12  (offset: 0x8cf)
// cseg ...... 0x11b + 0x7b4 (0x8cf)
// imports ... 53  (offset: 0xaaf)
// animtree1 . 0   (offset: 0x11a3)
// animtree2 . 0   (offset: 0x11a3)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;

#namespace honeypot;

// Namespace honeypot
// Params 0
// Checksum 0x5f184e96, Offset: 0x139
// Size: 0x62, Type: bool
function honeypotbeginuse()
{
    hud_message::showerrormessage( %"t10_splashes/honeypot_activated" );
    thread function_438c7d57533a5ac7();
    function_7430e2193f64e1e3();
    callback::add( #"player_disconnect", &onplayerdisconnect );
    battlechatter_mp::function_f3ffc3fa6aa3a992();
    self sethoneypotactive( 1 );
    self.var_7cc8a103782afa4c = 0;
    function_2fc19bc354eea0bf();
    self.var_ff8191a6766785f6 = 1;
    return true;
}

// Namespace honeypot
// Params 0
// Checksum 0xa91e0823, Offset: 0x1a4
// Size: 0x9d
function function_2fc19bc354eea0bf()
{
    audioplayer = spawn( "script_model", self.origin );
    audioplayer setmodel( supers_mp::getcurrentsuper().staticdata.bundle.honeypot_audio_player_xmodel );
    audioplayer setotherent( self );
    audioplayer linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    audioplayer setscriptablepartstate( #"hash_f5c739735d99506c", #"on", 0 );
    thread function_6274387a1a09c5ad( audioplayer );
}

// Namespace honeypot
// Params 1
// Checksum 0xeede2c3b, Offset: 0x249
// Size: 0x20
function function_6274387a1a09c5ad( audioplayer )
{
    self waittill( #"hash_8de8a2e421bc94c1" );
    audioplayer delete();
}

// Namespace honeypot
// Params 1
// Checksum 0xc6e2e69, Offset: 0x271
// Size: 0x96, Type: bool
function function_9e58ff472f719f2c( attacker )
{
    callback::remove( #"player_disconnect", &onplayerdisconnect );
    
    if ( isdefined( attacker ) && attacker != self )
    {
        attacker thread points::doscoreevent( #"super_honeypot_killed" );
    }
    
    function_3fcfdc930c3d1aa7();
    
    if ( self.ishvt )
    {
        outline::_hudoutlineviewmodelenable( "outlinefill_friendly_hvt", 0 );
    }
    
    self sethoneypotactive( 0 );
    self.var_7cc8a103782afa4c = undefined;
    self notify( #"hash_8de8a2e421bc94c1" );
    self.var_ff8191a6766785f6 = undefined;
    self.var_37986f991e47f03 = gettime();
    return false;
}

// Namespace honeypot
// Params 1
// Checksum 0xa90e7b13, Offset: 0x310
// Size: 0x1f
function onplayerdisconnect( params )
{
    self notify( #"hash_8de8a2e421bc94c1" );
    function_3fcfdc930c3d1aa7();
}

// Namespace honeypot
// Params 0, eflags: 0x4
// Checksum 0xb082c603, Offset: 0x337
// Size: 0x67
function private function_438c7d57533a5ac7()
{
    self endon( #"death" );
    honeypotinfo = supers_mp::getcurrentsuper();
    honeypotweapon = honeypotinfo.staticdata.objweapon;
    wait honeypotinfo.staticdata.usetime;
    thread points::doscoreevent( #"super_honeypot_survive", honeypotweapon );
}

// Namespace honeypot
// Params 1
// Checksum 0xd67137f2, Offset: 0x3a6
// Size: 0x10f
function function_894a81aaf80f7b0b( victim )
{
    attacker = self;
    superinfo = attacker supers_mp::getcurrentsuper();
    honeypotweapon = superinfo.staticdata.objweapon;
    attacker points::function_aa3f27bc29d005fc( #"super_honeypot_kill", honeypotweapon );
    attacker.var_bf16e02ff43a6a37 = 1;
    attacker thread gamelogic_mp::threadedsetweaponstatbyname( honeypotweapon, 1, "debuff_kills" );
    attacker telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, attacker, superinfo.usestarttime, honeypotweapon );
    victim thread gamelogic_mp::threadedsetweaponstatbyname( honeypotweapon, 1, "killed_while_debuffed_by", undefined, attacker );
    attacker.var_7cc8a103782afa4c += 1;
    
    if ( attacker.var_7cc8a103782afa4c == 3 )
    {
        attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"honeypot_triple", honeypotweapon );
        attacker thread battlechatter_mp::trysaylocalsound( self, #"bc_combat_killfirm_signal_lure", 0.75 );
        attacker.var_f35bae2c4488483b = 1;
    }
}

// Namespace honeypot
// Params 0, eflags: 0x4
// Checksum 0xeed02879, Offset: 0x4bd
// Size: 0x2be
function private function_7430e2193f64e1e3()
{
    self.var_bae627af17551c5c = objidpoolmanager::requestobjectiveid( 1 );
    objid = self.var_bae627af17551c5c;
    objidpoolmanager::function_e4d6a71507372662( objid, 0 );
    honeypotinfo = supers_mp::getcurrentsuper();
    bundle = honeypotinfo.staticdata.bundle;
    minimapicon = bundle.minimapicon ?? "hud_icon_death_spawn";
    objidpoolmanager::objective_add_objective( objid, "invisible", self.origin, minimapicon );
    objective_setminimapiconsize( objid, "icon_regular" );
    objective_setplayintro( objid, 0 );
    objective_setrotateonminimap( objid, 1 );
    objective_setbackground( objid, 1 );
    objective_state( objid, "active" );
    objective_setpings( objid, 1 );
    objective_settint( objid, 255, 100, 100 );
    
    if ( level.teambased )
    {
        foreach ( player in level.players )
        {
            if ( player.team != self.team )
            {
                objective_addclienttomask( objid, player );
            }
        }
        
        objective_setownerteam( objid, self.team );
    }
    else
    {
        foreach ( player in level.players )
        {
            objective_addclienttomask( objid, player );
        }
        
        objective_setownerclient( objid, self );
    }
    
    var_84f33108a5a7c55b = istrue( bundle.var_7cd7c5240d25d7e6 );
    
    if ( var_84f33108a5a7c55b )
    {
        objective_addclienttomask( objid, self );
    }
    else
    {
        objective_removeclientfrommask( objid, self );
    }
    
    objective_showtoplayersinmask( objid );
    self.var_241e30c3cb7bc138 = objidpoolmanager::requestobjectiveid( 1 );
    objid = self.var_241e30c3cb7bc138;
    objidpoolmanager::function_e4d6a71507372662( objid, 0 );
    objective_icon( objid, minimapicon );
    objective_setminimapiconsize( objid, "icon_regular" );
    objective_setplayintro( objid, 1 );
    objective_onentity( objid, self );
    objective_setrotateonminimap( objid, 1 );
    objective_setbackground( objid, 0 );
    objective_state( objid, "active" );
    objective_setpings( objid, 1 );
    objective_addclienttomask( objid, self );
    objective_showtoplayersinmask( objid );
    thread function_af0cd279ada55a9c();
}

// Namespace honeypot
// Params 0, eflags: 0x4
// Checksum 0x1bc5ccdf, Offset: 0x783
// Size: 0x4f
function private function_3fcfdc930c3d1aa7()
{
    if ( isdefined( self.var_bae627af17551c5c ) )
    {
        self notify( #"hash_430c769fd62a5d59" );
        objidpoolmanager::returnobjectiveid( self.var_bae627af17551c5c );
        objidpoolmanager::returnobjectiveid( self.var_241e30c3cb7bc138 );
        self.var_bae627af17551c5c = undefined;
        self.var_241e30c3cb7bc138 = undefined;
    }
}

// Namespace honeypot
// Params 0, eflags: 0x4
// Checksum 0x402fdfcc, Offset: 0x7da
// Size: 0x1c
function private honeypotpulse()
{
    outline::_hudoutlineviewmodelenable( "outlinefill_nodepth_orange", 0 );
    wait 0.5;
    outline::_hudoutlineviewmodeldisable();
}

// Namespace honeypot
// Params 0, eflags: 0x4
// Checksum 0xb8e205a0, Offset: 0x7fe
// Size: 0xd1
function private function_af0cd279ada55a9c()
{
    self endon( #"death" );
    self endon( #"hash_430c769fd62a5d59" );
    honeypotinfo = supers_mp::getcurrentsuper();
    bundle = honeypotinfo.staticdata.bundle;
    revealinterval = bundle.var_fa307a0d5bb87279 ?? 0;
    var_9f47d3d739e659ff = istrue( bundle.var_5f199007b2336602 );
    
    while ( true )
    {
        objidpoolmanager::update_objective_position( self.var_bae627af17551c5c, self.origin );
        
        if ( revealinterval == 0 )
        {
            waitframe();
            continue;
        }
        
        objective_ping( self.var_bae627af17551c5c );
        objective_ping( self.var_241e30c3cb7bc138 );
        
        if ( var_9f47d3d739e659ff )
        {
            thread honeypotpulse();
        }
        
        wait revealinterval;
    }
}

