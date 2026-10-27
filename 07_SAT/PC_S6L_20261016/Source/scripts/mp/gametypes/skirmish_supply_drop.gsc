// scripts\mp\gametypes\skirmish_supply_drop.gsc  (hash_1e11e27534bc6708.gscc) (size: 12081 Bytes / 0x2f31 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2789eedd (663351005)
// size ...... 12081 (0x2f31)
// includes .. 8   (offset: 0x2bc1)
// strings ... 54  (offset: 0x2c01)
// dev strs .. 6   (offset: 0x2ee5)
// exports ... 25  (offset: 0x1d2d)
// cseg ...... 0x551 + 0x17dc (0x1d2d)
// imports ... 90  (offset: 0x2115)
// animtree1 . 0   (offset: 0x2f31)
// animtree2 . 0   (offset: 0x2f31)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\equipment\grappling_hook;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace skirmish_supply_drop;

// Namespace skirmish_supply_drop
// Params 0
// Checksum 0xe392d0be, Offset: 0x56f
// Size: 0x1db
function init()
{
    /#
        debug_init();
    #/
    
    skirmish_supply_drop_update_dvars();
    setup_killstreak_crate_data();
    level.var_6c7da61a12ef9d1b = 1;
    level.disallowheadiconid = 1;
    utility::registersharedfunc( #"airdrop", #"giveplayerpointsoncratecapture", &function_8bb70b31949a0889 );
    utility::registersharedfunc( #"airdrop", #"hash_737e51bff1a56876", &skirmish_supply_drop_grappling_hook );
    utility::registersharedfunc( #"airdrop", #"hash_9ff09166359e2ed7", &function_e66c44ffec7bb65e );
    utility::registersharedfunc( #"airdrop", #"hash_59b4e0bb0811b551", &function_8e2000d2aed1530f );
    utility::registersharedfunc( #"airdrop", #"hash_5a322d704b74ab61", &function_8d9e7bf32df6186a );
    level._effect[ "vfx_sat_skirmish_smoke_carepackage_blue" ] = loadfxasset( "vfx_sat_skirmish_smoke_carepackage_blue" );
    level thread skirmish_supply_drop_update();
    level thread function_ec7c5194a3d548e5();
    level.var_842d107088463381 = [];
    supply_drops = utility::getstructarray( "skr_supply_drop", "targetname" );
    
    foreach ( Supply in supply_drops )
    {
        if ( !level.var_842d107088463381[ Supply.team_area ] )
        {
            level.var_842d107088463381[ Supply.team_area ] = [];
        }
        
        level.var_842d107088463381[ Supply.team_area ][ level.var_842d107088463381[ Supply.team_area ].size ] = Supply;
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x427b65f1, Offset: 0x752
// Size: 0x462
function private skirmish_supply_drop_update_dvars()
{
    level.var_289bb3457c052e3a = getdvarvector( @"scr_skirmish_supply_drop_point", level.mapcenter );
    level.var_ea6e26af2fbac4fa = getdvarint( @"scr_skirmish_supply_drop_radius", 5500 );
    level.var_c01a32a5d44d1b04 = getdvarint( @"hash_99ab5e32f1bac075", level.gametypebundle.var_32bd811cf6100c3c );
    level.var_c03d40a5d4738186 = getdvarint( @"hash_99ce4832f1e0d7cb", level.gametypebundle.var_329a6f1cf5e99cee );
    level.var_d7280a2b04a7d45f = getdvarint( @"hash_5da4779f362067b4", level.gametypebundle.var_2bebc3f5a9961937 );
    level.var_d705182b0481ab71 = getdvarint( @"hash_5dc7659f364687d6", level.gametypebundle.var_2c0ed1f5a9bc7fb9 );
    level.var_bc65285e864c2bbe = getdvarint( @"scr_skirmish_supply_drop_use_time", level.gametypebundle.var_d6ae027cd6ddbd16 );
    setdvar( @"hash_4be0d2ecac9ada5b", 0 );
    level.var_d1c525626e82fb10 = getdvarint( @"hash_be6b89b3bf9aab9e", level.gametypebundle.var_d1c525626e82fb10 );
    level.var_65443c5cf6e48f7e = getdvarint( @"hash_d5e2e39a34231023", 1 );
    level.var_802ad9ecbe0c041 = getdvarint( @"hash_daa1f323e2e6afa", level.gametypebundle.var_802ad9ecbe0c041 );
    level.var_5d5d6a3dae39b7c3 = getdvarint( @"hash_edc9a30e07eb4c8f", level.gametypebundle.var_1ea042002044c1b8 );
    level.var_65294701987288ca = getdvarint( @"hash_b7e645f0fe1452ee", level.gametypebundle.var_705588421c4de907 );
    level.var_56f09dc5b659faad = getdvarint( @"hash_c1a5589f43d23da9", level.gametypebundle.var_e24ff50a5afafee1 );
    level.var_eaad3405bf01ae4b = getdvarint( @"hash_2a52d61c5b660eb7", level.gametypebundle.var_f1bdc6e6eae4f0e7 );
    level.var_e28005ecfcc7adaf = getdvarint( @"hash_229c493542baedfb", level.gametypebundle.var_2e12856b09fcf9e7 );
    level.var_657c7b2619d3c9b0 = getdvarint( @"hash_1ae5fb247e77b24", level.gametypebundle.var_2add5c50ac15a434 );
    level.var_1bd51906133b9fa5 = getdvarint( @"hash_a74fb8a26dd55609", level.gametypebundle.var_e6cb4b40fd9f66d5 );
    level.var_7ada68779e842e6c = getdvarint( @"hash_a4dc6783f0114fd8", level.gametypebundle.var_5b292828cdb698a4 );
    level.var_162dc5d9aa3aa6fd = getdvarint( @"hash_cdf9ca1a6836c731", level.gametypebundle.var_14187787171def2f );
    level.var_e2b9aec4b05bb4c8 = getdvarint( @"hash_39f1dbd7d42b186c", level.gametypebundle.var_bf675dd43c41599c );
    level.var_895f91c45d81a2a0 = getdvarint( @"hash_f86e0425e03e34e4", level.gametypebundle.var_5413a2ceefcda02c );
    level.var_11150a3bd22e73a = getdvarint( @"hash_412ea07e250768ce", level.gametypebundle.var_2a2ec193c123f39e );
    level.var_a24154916c9a0482 = getdvarint( @"hash_53251b81d39e1e7e", level.gametypebundle.var_581d92bbea5920f7 );
    level.var_75536d7c80eb77c0 = getdvarint( @"hash_33d1de3c735c1cbc", level.gametypebundle.var_24712a25e146da21 );
    level.var_3c8b0c472f6c8ed0 = getdvarint( @"hash_8bda327c70a8edbc", level.gametypebundle.var_ecb152a5ec3168e9 );
    level.var_bcc3842c4c8e76e2 = getdvarint( @"hash_1f03037f0ed3dbbe", level.gametypebundle.var_b9a6616c4df409 );
    level.var_ff01c365dd2b24c0 = getdvarint( @"hash_c69a9197e93e709c", level.gametypebundle.var_4d01f6f34fb3aa6e );
    level.var_a572db68f52ff5ef = getdvarint( @"hash_97c7eb8d4bb42eb3", level.gametypebundle.var_d10103177a9073e7 );
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x27cef006, Offset: 0xbbc
// Size: 0x16a
function private function_8bb70b31949a0889( crate )
{
    skirmish_util::function_d3edf86605109102( self );
    
    if ( level.var_67ca8a17f531fb7c > 0 )
    {
        isheat = self.var_bf516d5ed5a5050d;
        var_b953543d7e8d89ac = isheat ? level.var_67ca8a17f531fb7c * 2 : level.var_67ca8a17f531fb7c;
        var_95097aad3fa56ce5 = isheat ? "skirmish_cache_supply_collected_heat" : "skirmish_cache_supply_collected";
        scoreeventref = isheat ? "mode_skr_supply_package_secured_hvs" : "mode_skr_supply_package_secured";
        skirmish_util::function_9bc92b9d0f473f97( var_b953543d7e8d89ac, scoreeventref, self );
        
        if ( !isbot( self ) )
        {
            hud_message::function_78fedf6f526825f4( var_95097aad3fa56ce5, level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
    
    location = crate.origin;
    streakname = crate.data.streakname;
    self dlog_recordplayerevent( "dlog_event_mp_skr_supply_drop_picked_up", [ "player_uno_id", self getplayerunoid(), "supply_drop_location_x", location[ 0 ], "supply_drop_location_y", location[ 1 ], "supply_drop_location_z", location[ 2 ], "time_s", getsystemtime(), "supply_drop_scorestreak", streakname ] );
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0xb35d29f2, Offset: 0xd2e
// Size: 0xfa
function private function_7b418afa4d6a0c67( teamarea )
{
    availablenodes = level.var_842d107088463381[ teamarea ];
    
    if ( !availablenodes || availablenodes.size == 0 )
    {
        logstring( "[SKIRMISH_SUPPLY_DROP] No available nodes for team area: " + teamarea );
        return;
    }
    
    clearnodes = [];
    
    foreach ( node in availablenodes )
    {
        istooclose = is_crate_too_close( node.origin );
        
        if ( !istooclose )
        {
            clearnodes[ clearnodes.size ] = node;
        }
    }
    
    if ( clearnodes.size > 0 )
    {
        randomindex = randomintrange( 0, clearnodes.size );
        return clearnodes[ randomindex ];
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x798294d6, Offset: 0xe30
// Size: 0x108
function private function_f2729f7059c6cd6b()
{
    if ( !level.var_381a2707068a8afe )
    {
        return "neutral";
    }
    
    var_9c819beaced3fdac = game[ "teamScores" ][ "axis" ];
    var_8216556cb11eaf9d = game[ "teamScores" ][ "allies" ];
    winningteam = var_9c819beaced3fdac <= var_8216556cb11eaf9d ? "allies" : "axis";
    losingteam = winningteam == "allies" ? "axis" : "allies";
    scoredifference = abs( var_9c819beaced3fdac - var_8216556cb11eaf9d );
    var_4754a5d7bf1dd7f2 = mapfloat( 0, 200, 0.333333, 0.533333, scoredifference ) * 100;
    var_654f5744d27eb160 = mapfloat( 0, 200, 0.333333, 0.133333, scoredifference ) * 100;
    rollednumber = randomintrange( 0, 100 );
    
    if ( rollednumber < var_654f5744d27eb160 )
    {
        return winningteam;
    }
    else if ( rollednumber >= 100 - var_4754a5d7bf1dd7f2 )
    {
        return losingteam;
    }
    
    return "neutral";
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0xbb6c5fd7, Offset: 0xf41
// Size: 0x127
function private function_7e7e39c90e365b9a( var_ce1eed9af4cfe970 )
{
    droppoint = function_7b418afa4d6a0c67( var_ce1eed9af4cfe970 );
    
    if ( droppoint )
    {
        return droppoint;
    }
    
    logstring( "[SKIRMISH_SUPPLY_DROP] Primary team area '" + var_ce1eed9af4cfe970 + "' full, trying fallback areas" );
    fallbackareas = [];
    
    if ( var_ce1eed9af4cfe970 != "neutral" )
    {
        fallbackareas[ fallbackareas.size ] = "neutral";
    }
    
    if ( var_ce1eed9af4cfe970 != "allies" )
    {
        fallbackareas[ fallbackareas.size ] = "allies";
    }
    
    if ( var_ce1eed9af4cfe970 != "axis" )
    {
        fallbackareas[ fallbackareas.size ] = "axis";
    }
    
    foreach ( fallbackarea in fallbackareas )
    {
        droppoint = function_7b418afa4d6a0c67( fallbackarea );
        
        if ( droppoint )
        {
            logstring( "[SKIRMISH_SUPPLY_DROP] Using fallback area: " + fallbackarea + " (primary '" + var_ce1eed9af4cfe970 + "' was full)" );
            return droppoint;
        }
    }
    
    logstring( "[SKIRMISH_SUPPLY_DROP] ALL team areas full, skipping spawn this cycle" );
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x4e1f04fa, Offset: 0x1070
// Size: 0xa0
function private skirmish_supply_drop_update()
{
    level endon( #"game_ended" );
    wait randomintrange( level.var_c01a32a5d44d1b04, level.var_c03d40a5d4738186 );
    
    while ( true )
    {
        if ( level.var_65443c5cf6e48f7e )
        {
            var_3f730d7133840613 = function_f2729f7059c6cd6b();
            droppoint = function_7e7e39c90e365b9a( var_3f730d7133840613 );
            
            if ( droppoint )
            {
                function_697730f2f12cd4ab( droppoint.origin );
                level.var_381a2707068a8afe = 1;
            }
        }
        else
        {
            function_697730f2f12cd4ab();
        }
        
        wait randomintrange( level.var_d7280a2b04a7d45f, level.var_d705182b0481ab71 );
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x2bf7cce2, Offset: 0x1118
// Size: 0x3d4
function private setup_killstreak_crate_data()
{
    level.cratedata.kscapturestrings = [];
    level.cratedata.ksrerollstrings = [];
    level.cratedata.ksweights = [];
    streaks = [ { #weight:level.var_5d5d6a3dae39b7c3, #name:"uav" }, { #weight:level.var_65294701987288ca, #name:"counter_uav" }, { #weight:level.var_56f09dc5b659faad, #name:"toma_strike" }, { #weight:level.var_eaad3405bf01ae4b, #name:"napalm_strike" }, { #weight:level.var_e28005ecfcc7adaf, #name:"remote_turret" }, { #weight:level.var_657c7b2619d3c9b0, #name:"hand_cannon" }, { #weight:level.var_1bd51906133b9fa5, #name:"sniper_briefcase" }, { #weight:level.var_7ada68779e842e6c, #name:"hellstorm_missile" }, { #weight:level.var_162dc5d9aa3aa6fd, #name:"airdrop_escort" }, { #weight:level.var_e2b9aec4b05bb4c8, #name:"directional_uav" }, { #weight:level.var_895f91c45d81a2a0, #name:"emp_blast" }, { #weight:level.var_11150a3bd22e73a, #name:"air_patrol" }, { #weight:level.var_75536d7c80eb77c0, #name:"skewer" }, { #weight:level.var_a24154916c9a0482, #name:"rcxd" }, { #weight:level.var_3c8b0c472f6c8ed0, #name:"dawg" }, { #weight:level.var_bcc3842c4c8e76e2, #name:"ground_drone_unit" }, { #weight:level.var_ff01c365dd2b24c0, #name:"remote_robot" }, { #weight:level.var_a572db68f52ff5ef, #name:"vtol_warship" } ];
    
    foreach ( streak in streaks )
    {
        airdrop::addkillstreakcratedata( streak.name, undefined, undefined, streak.weight );
    }
    
    leveldata = airdrop::getleveldata( "killstreak_no_owner" );
    leveldata.capturestring = &"mp/pick_up_supply_cache";
    
    if ( isdefined( leveldata ) )
    {
        var_37612e609a072de7 = level.gametypebundle.var_37612e609a072de7;
        leveldata.timeout = var_37612e609a072de7 > 0 ? var_37612e609a072de7 : undefined;
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xd51df155, Offset: 0x14f4
// Size: 0x10f
function private function_62f22927793cf2a()
{
    maxattempts = 10;
    
    for ( attempt = 0; attempt < maxattempts ; attempt++ )
    {
        origin = level.var_289bb3457c052e3a;
        angle = anglestoforward( ( 0, randomintrange( -180, 180 ), 0 ) ) + anglestoup( ( 0, 0, randomintrange( 0, 90 ) ) );
        direction = angle * randomintrange( 0, level.var_ea6e26af2fbac4fa );
        var_55d2772925afb982 = origin + direction;
        point = findclosesttacpoint( var_55d2772925afb982 );
        
        if ( !point || !tacpointexposedtosky( point ) )
        {
            continue;
        }
        
        exposedpoint = function_5a577f4e6e89a130( point.groundpos, point.groundpos, 0, 1024, 150 );
        
        if ( !exposedpoint || !tacpointexposedtosky( exposedpoint ) || is_crate_too_close( exposedpoint.groundpos ) )
        {
            continue;
        }
        
        return exposedpoint.groundpos;
    }
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x2d7708e5, Offset: 0x160b
// Size: 0xbf
function private function_697730f2f12cd4ab( origin )
{
    angles = ( 0, 0, 0 );
    
    if ( !origin )
    {
        origin = function_62f22927793cf2a();
        
        if ( !origin )
        {
            return;
        }
    }
    
    streakinfo = killstreak_utility::createstreakinfo( "airdrop", undefined );
    drop = level airdrop::dropkillstreakcratefromscriptedheli( undefined, "neutral", undefined, origin, angles, undefined, undefined, streakinfo );
    
    if ( drop )
    {
        crate = utility::array_get_first_item( drop.crates );
        crate.usetimeoverride = level.var_bc65285e864c2bbe;
        crate.var_332923074ceef731 = 1;
        logstring( "[SKIRMISH_SUPPLY_DROP] Crate successfully spawned at: " + origin );
    }
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x4c1b0412, Offset: 0x16d2
// Size: 0xdb, Type: bool
function private is_crate_too_close( testposition )
{
    if ( !level.cratedata.crates )
    {
        return false;
    }
    
    foreach ( crate in level.cratedata.crates )
    {
        if ( !crate.origin )
        {
            continue;
        }
        
        distancesquared = distancesquared( testposition, crate.origin );
        
        if ( distancesquared < 250000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xbac5be50, Offset: 0x17b6
// Size: 0x38
function private function_ec7c5194a3d548e5()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player thread function_ff9b07a0de85571e();
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x3650ff30, Offset: 0x17f6
// Size: 0x103
function private function_ff9b07a0de85571e()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    if ( level.cratedata.crates )
    {
        foreach ( crate in level.cratedata.crates )
        {
            if ( crate && crate.cratetype == "killstreak_no_owner" )
            {
                if ( crate.var_36e300d147bf6f25 )
                {
                    crate.var_36e300d147bf6f25 hidefromplayer( self );
                }
                
                if ( crate.var_88accb953478a622 )
                {
                    crate.var_88accb953478a622 hidefromplayer( self );
                }
            }
        }
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xa18f4da6, Offset: 0x1901
// Size: 0x1d
function private skirmish_supply_drop_grappling_hook()
{
    if ( level.var_d1c525626e82fb10 )
    {
        grappling_hook::function_51f847aef825ec26( self );
        thread function_aae2bafe17ca7c82();
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x9d636506, Offset: 0x1926
// Size: 0x28
function private function_aae2bafe17ca7c82()
{
    wait 2;
    hud_message::function_78fedf6f526825f4( #"hash_5cec2b980ed5fdd", level.gametypebundle.var_e662dd7f27d462eb );
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x99b455d5, Offset: 0x1956
// Size: 0x2f
function private function_8d9e7bf32df6186a()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.cratetype != "killstreak_no_owner" )
    {
        return;
    }
    
    if ( level.var_802ad9ecbe0c041 )
    {
        thread function_852525d285848a44();
    }
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x2904ab8f, Offset: 0x198d
// Size: 0xbd
function private function_852525d285848a44()
{
    level endon( #"game_ended" );
    fxent = spawn( "script_model", self.origin );
    fxent setmodel( "tag_origin" );
    fxent linkto( self );
    fxent playloopsound( "smoke_carepackage_smoke_lp" );
    vfxsmoke = utility::getfx( "vfx_sat_skirmish_smoke_carepackage_blue" );
    waitframe();
    
    if ( vfxsmoke )
    {
        playfxontag( vfxsmoke, self, "tag_origin" );
    }
    
    self waittill( #"crate_capture_end" );
    
    if ( vfxsmoke )
    {
        stopfxontag( vfxsmoke, self, "tag_origin" );
    }
    
    fxent endon( #"death" );
    fxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    fxent stoploopsound();
    fxent delete();
}

// Namespace skirmish_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x4903eace, Offset: 0x1a52
// Size: 0x54
function private function_e66c44ffec7bb65e( crate )
{
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( crate.cratetype != "killstreak_no_owner" )
    {
        return;
    }
    
    skirmish_util::function_f0219df3de59b8fc( #"supply_drop_available", crate.origin, level.var_fd5a14340d3320e9 );
    function_b1fa99deccaffa35();
}

// Namespace skirmish_supply_drop
// Params 0, eflags: 0x4
// Checksum 0xd23b8195, Offset: 0x1aae
// Size: 0x35
function private function_8e2000d2aed1530f()
{
    self notify( #"crate_capture_end" );
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidnum );
        self.objidnum = undefined;
    }
}

// Namespace skirmish_supply_drop
// Params 0
// Checksum 0xfdbcdba5, Offset: 0x1aeb
// Size: 0xa6
function function_b1fa99deccaffa35()
{
    self.offset3d = ( 0, 0, 45 );
    self.objidnum = objidpoolmanager::requestobjectiveid( 1 );
    skirmish_util::function_27e85aa699653fa1( "waypoint_skirmish_deaddrop", undefined, self.objidnum );
    function_c00df47304a6a6d3( self.objidnum );
    objidpoolmanager::function_6dfdf7da8037a1ee( self.objidnum );
    objidpoolmanager::update_objective_size( self.objidnum, "icon_regular" );
    objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, &"mpui/skr_poi2" );
    objidpoolmanager::update_objective_setenemylabel( self.objidnum, &"mpui/skr_poi2" );
}

// Namespace skirmish_supply_drop
// Params 1
// Checksum 0x4ea1684, Offset: 0x1b99
// Size: 0x98
function function_c00df47304a6a6d3( objid )
{
    objective_setbackground( objid, 1 );
    objective_setshowprogress( objid, 0 );
    objective_setzoffset( objid, 45 );
    objective_position( objid, self.origin + self.offset3d );
    objective_state( objid, "active" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, "neutral" );
    objective_icon( objid, "ui_icon_minimap_deaddrop" );
    objective_setlabel( objid, level.waypointstring[ "waypoint_skirmish_deaddrop" ] );
    function_8eab38514b79538d( objid, 1 );
    function_ac9886e0e2860e18( objid, 1378, 1575 );
}

/#

    // Namespace skirmish_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0xc9efdefc, Offset: 0x1c39
    // Size: 0x44, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x31>", "<dev string:x4f>", &call_in_supply_drop );
        devgui::add_devgui_func( "<dev string:x63>", "<dev string:x7e>", &function_f87e189c62604614 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace skirmish_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x914d881d, Offset: 0x1c85
    // Size: 0x3e, Type: dev
    function private call_in_supply_drop()
    {
        if ( level.players.size <= 0 )
        {
            return;
        }
        
        player = level.players[ 0 ];
        function_697730f2f12cd4ab( player.origin );
    }

    // Namespace skirmish_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x9d67edca, Offset: 0x1ccb
    // Size: 0x62, Type: dev
    function private function_f87e189c62604614()
    {
        if ( level.var_65443c5cf6e48f7e )
        {
            index = randomintrange( 0, level.var_842d107088463381[ "<dev string:x99>" ].size - 1 );
            function_697730f2f12cd4ab( level.var_842d107088463381[ "<dev string:x99>" ][ index ].origin );
            return;
        }
        
        function_697730f2f12cd4ab();
    }

#/
