// scripts\mp\common\perks\vendetta.gsc  (hash_7e5d438a96481031.gscc) (size: 4421 Bytes / 0x1145 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81cbf272 (2177626738)
// size ...... 4421 (0x1145)
// includes .. 5   (offset: 0x1095)
// strings ... 7   (offset: 0x10bd)
// dev strs .. 0   (offset: 0x1145)
// exports ... 17  (offset: 0x8ed)
// cseg ...... 0xd4 + 0x819 (0x8ed)
// imports ... 44  (offset: 0xb95)
// animtree1 . 0   (offset: 0x1145)
// animtree2 . 0   (offset: 0x1145)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\objidpoolmanager;

#namespace vendetta;

// Namespace vendetta
// Params 0, eflags: 0x5
// Checksum 0xc5a8ee86, Offset: 0xf2
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_4297f68cc6806962 );
}

// Namespace vendetta
// Params 1
// Checksum 0xa6c78da5, Offset: 0x112
// Size: 0x62
function function_4297f68cc6806962( params )
{
    bundle = level.perkbundles[ "specialty_vendetta" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_vendetta", &vendetta_set, &vendetta_unset, [], &initvendetta );
    }
}

// Namespace vendetta
// Params 0
// Checksum 0x60782795, Offset: 0x17c
// Size: 0xc
function vendetta_set()
{
    self.vendettaowners = 0;
}

// Namespace vendetta
// Params 0
// Checksum 0x61b62d53, Offset: 0x190
// Size: 0xc
function vendetta_unset()
{
    self.vendettaowners = undefined;
}

// Namespace vendetta
// Params 0
// Checksum 0x16f6a62c, Offset: 0x1a4
// Size: 0x39
function initvendetta()
{
    level callback::add( #"player_death", &function_297a907f5fda5fd6 );
    level callback::add( #"player_spawned", &vendetta_onplayerspawned );
    level.var_76a8f2fd66e2cd91 = 1;
}

// Namespace vendetta
// Params 1, eflags: 0x4
// Checksum 0xc56ad0d2, Offset: 0x1e5
// Size: 0x12a
function private function_297a907f5fda5fd6( params )
{
    attacker = params.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = params.victim;
    
    if ( attacker.vendettatarget == victim )
    {
        attacker thread points::doscoreevent( #"hash_9feecd09d2a04352" );
        attacker.vendettatarget = undefined;
    }
    
    if ( !isdefined( victim.perks[ "specialty_vendetta" ] ) )
    {
        return;
    }
    
    if ( !victim player_utility::isenemy( attacker ) )
    {
        return;
    }
    
    if ( isdefined( attacker.perks[ "specialty_perceptive" ] ) )
    {
        if ( victim.vendettatarget == attacker )
        {
            victim.vendettatarget = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( attacker.vendettaowners ) )
    {
        attacker.vendettaowners = 0;
    }
    
    bundle = level.perkbundles[ "specialty_vendetta" ];
    
    if ( attacker.vendettaowners >= ( bundle.var_e0c13d5649ad141f ?? 3 ) )
    {
        return;
    }
    
    victim.vendettatarget = attacker;
}

// Namespace vendetta
// Params 1, eflags: 0x4
// Checksum 0x47970400, Offset: 0x317
// Size: 0x7d
function private vendetta_onplayerspawned( params )
{
    if ( !isdefined( self.perks[ "specialty_vendetta" ] ) )
    {
        return;
    }
    
    vendettaowner = self;
    target = vendettaowner.vendettatarget;
    
    if ( target )
    {
        target.vendettaowners += 1;
        vendettaowner vendetta_addwaypoint();
        target thread function_9f23e85751b7ef8d();
        target thread function_ec8ada8ef7dc1309();
    }
}

// Namespace vendetta
// Params 0, eflags: 0x4
// Checksum 0x60b93b70, Offset: 0x39c
// Size: 0x8b
function private vendetta_addwaypoint()
{
    bundle = level.perkbundles[ "specialty_vendetta" ];
    var_ef1e97ff1a96dfb7 = bundle.vendetta_objective_image;
    vendettaowner = self;
    vendettaowner.objidvendetta = objidpoolmanager::requestobjectiveid( 1 );
    vendettaowner thread function_3b036b208d965f78( vendettaowner.objidvendetta, &"MP_INGAME_ONLY/VENDETTA_PERK_TARGET", var_ef1e97ff1a96dfb7 );
    vendettaowner thread function_9c5af5ce1bb0869d();
    vendettaowner thread function_a4e931dcdf6df653();
    vendettaowner thread function_7182ee702c8b30ba();
}

// Namespace vendetta
// Params 3, eflags: 0x4
// Checksum 0xbf8aa47d, Offset: 0x42f
// Size: 0xf1
function private function_3b036b208d965f78( objid, objlabel, objicon )
{
    level endon( #"game_ended" );
    target = self.vendettatarget;
    
    if ( !isplayer( target ) || !isalive( target ) || !issentient( target ) )
    {
        return;
    }
    
    vendettaowner = self;
    objective_setbackground( objid, 1 );
    objective_setzoffset( objid, 30 );
    objective_position( objid, target geteye() + ( 0, 0, 14 ) );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, undefined );
    objective_icon( objid, objicon );
    objective_settint( objid, 245, 245, 245 );
    objective_setshowdistance( objid, 0 );
    objidpoolmanager::function_e4d6a71507372662( objid, 0 );
    vendettaowner objidpoolmanager::objective_playermask_single( vendettaowner.objidvendetta, vendettaowner );
}

// Namespace vendetta
// Params 0, eflags: 0xc
// Checksum 0x39585210, Offset: 0x528
// Size: 0x65
function private function_9f23e85751b7ef8d()
{
    self notify( #"hash_5dd4e47b0d1bda1a" );
    self endon( #"hash_5dd4e47b0d1bda1a" );
    level endon( #"game_ended" );
    target = self;
    
    if ( !target )
    {
        return;
    }
    
    if ( target getclientomnvar( "ui_perceptive" ) )
    {
        return;
    }
    
    target setclientomnvar( "ui_perceptive", 1 );
    target setclientomnvar( "ui_perceptive_indicator", 2 );
}

// Namespace vendetta
// Params 0, eflags: 0xc
// Checksum 0x6c320d78, Offset: 0x595
// Size: 0x59
function private function_ec8ada8ef7dc1309()
{
    self notify( #"hash_243324f8d8e0a678" );
    self endon( #"hash_243324f8d8e0a678" );
    target = self;
    level endon( #"game_ended" );
    
    while ( target && target.vendettaowners )
    {
        waitframe();
    }
    
    if ( target )
    {
        target function_3e42c1af36c02aa2();
    }
}

// Namespace vendetta
// Params 0, eflags: 0x4
// Checksum 0x22bb6e0e, Offset: 0x5f6
// Size: 0x29
function private function_3e42c1af36c02aa2()
{
    if ( !self getclientomnvar( "ui_perceptive" ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_perceptive", 0 );
    self setclientomnvar( "ui_perceptive_indicator", 0 );
}

// Namespace vendetta
// Params 0, eflags: 0x4
// Checksum 0x379201f2, Offset: 0x627
// Size: 0x55
function private function_7182ee702c8b30ba()
{
    vendettaowner = self;
    target = vendettaowner.vendettatarget;
    level utility::waittill_any_ents( target, "death", target, "disconnect" );
    
    if ( target )
    {
        target.vendettaowners = 0;
    }
    
    vendettaowner function_ecf568642b42b0d5();
}

// Namespace vendetta
// Params 0, eflags: 0xc
// Checksum 0x9ab34cd9, Offset: 0x684
// Size: 0x114
function private function_a4e931dcdf6df653()
{
    self notify( #"hash_ec6c57e0710fa3cb" );
    self endon( #"hash_ec6c57e0710fa3cb" );
    vendettaowner = self;
    target = vendettaowner.vendettatarget;
    target endon( #"death" );
    target endon( #"disconnect" );
    bundle = level.perkbundles[ "specialty_vendetta" ];
    duration = bundle.var_ad784aa585f8e45e ?? 9;
    msg = level utility::waittill_any_ents_or_timeout_return( duration, vendettaowner, "death", vendettaowner, "disconnect" );
    
    if ( target.vendettaowners )
    {
        target.vendettaowners -= 1;
    }
    
    if ( vendettaowner )
    {
        vendettaowner.var_d60e459a1a32188f = vendettaowner.vendettatarget;
        vendettaowner.vendettatarget = undefined;
        vendettaowner.var_f70fa0618b1b1559 = gettime();
        vendettaowner function_ecf568642b42b0d5();
    }
}

// Namespace vendetta
// Params 0, eflags: 0x4
// Checksum 0x53543f54, Offset: 0x7a0
// Size: 0x4f
function private function_ecf568642b42b0d5()
{
    vendettaowner = self;
    
    if ( vendettaowner.objidvendetta )
    {
        objective_delete( vendettaowner.objidvendetta );
        objidpoolmanager::returnobjectiveid( vendettaowner.objidvendetta );
    }
    
    if ( vendettaowner )
    {
        vendettaowner.objidvendetta = undefined;
    }
}

// Namespace vendetta
// Params 0, eflags: 0xc
// Checksum 0x9cd4014d, Offset: 0x7f7
// Size: 0xf6
function private function_9c5af5ce1bb0869d()
{
    self notify( #"hash_8a56557d5b518a4" );
    self endon( #"hash_8a56557d5b518a4" );
    vendettaowner = self;
    target = vendettaowner.vendettatarget;
    bundle = level.perkbundles[ "specialty_vendetta" ];
    interval = bundle.var_a76ac7bd84f031d6 ?? 1.5;
    
    while ( isdefined( vendettaowner ) && isdefined( vendettaowner.objidvendetta ) && isdefined( target ) )
    {
        if ( !isplayer( target ) || !isalive( target ) || !issentient( target ) )
        {
            return;
        }
        
        if ( !target utility::isusingremote() )
        {
            objidpoolmanager::update_objective_position( vendettaowner.objidvendetta, target geteye() + ( 0, 0, 14 ) );
            objective_ping( vendettaowner.objidvendetta );
        }
        
        wait interval;
    }
}

