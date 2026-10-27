// scripts\mp\swim_cp_mp.gsc  (hash_01c42ccce845bc50.gscc) (size: 5001 Bytes / 0x1389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc2a8cc2 (3693776066)
// size ...... 5001 (0x1389)
// includes .. 6   (offset: 0x129d)
// strings ... 10  (offset: 0x12cd)
// dev strs .. 4   (offset: 0x1359)
// exports ... 20  (offset: 0x97d)
// cseg ...... 0x115 + 0x868 (0x97d)
// imports ... 52  (offset: 0xc9d)
// animtree1 . 0   (offset: 0x1389)
// animtree2 . 0   (offset: 0x1389)
#using scripts\common\callbacks;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\mtx_weapon;

#namespace swim_cp_mp;

// Namespace swim_cp_mp
// Params 0
// Checksum 0x3de148be, Offset: 0x133
// Size: 0x68
function main()
{
    swim_common::initcommonswim( &getbreathtime, &function_161a44d32adfebb5, &function_13351f0697c90de4, &enterfunc, &exitfunc, &surfacefunc, &descendfunc, &playsoundfunc, &visionsetfunc, &drownfunc, &function_3869cac93d7db6df, &function_394f3efa6a3b3a4d );
    function_953f2f60d47ab91b();
    function_575b2b0e020ed463();
    callback::add( #"player_spawned", &function_b9d9121a3e9dfdf3 );
}

// Namespace swim_cp_mp
// Params 1
// Checksum 0x1628ad6b, Offset: 0x1a3
// Size: 0x13
function function_b9d9121a3e9dfdf3( params )
{
    thread swim_common::function_5f2e885971e27d50();
}

// Namespace swim_cp_mp
// Params 2
// Checksum 0xb5249bfa, Offset: 0x1be
// Size: 0xbc
function function_575b2b0e020ed463( breathnormal, breathsprint )
{
    if ( !isdefined( level.swim.breathtimes ) )
    {
        level.swim.breathtimes = spawnstruct();
    }
    
    level.swim.breathtimes.normal = breathnormal ?? level.gametypebundle.var_f2982b738a12cd8b ?? 27.5;
    level.swim.breathtimes.sprint = breathsprint ?? level.gametypebundle.var_dd7575f8c8603ec ?? 14;
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x21ad9766, Offset: 0x282
// Size: 0xac
function getbreathtime()
{
    if ( self isswimsprinting() )
    {
        breathtime = level.swim.breathtimes.sprint;
    }
    else
    {
        breathtime = level.swim.breathtimes.normal;
    }
    
    /#
        if ( getdvarfloat( @"scr_swimbreathtime", -1 ) > 0 )
        {
            breathtime = getdvarfloat( @"scr_swimbreathtime", -1 );
            
            if ( self isswimsprinting() )
            {
                if ( getdvarfloat( @"hash_eb6fc369d3b1d968", -1 ) > 0 )
                {
                    breathtime = getdvarfloat( @"hash_eb6fc369d3b1d968", -1 );
                }
            }
        }
    #/
    
    return breathtime;
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x919b6530, Offset: 0x337
// Size: 0x19
function function_161a44d32adfebb5()
{
    if ( self isswimsprinting() )
    {
        return 4;
    }
    
    return 6;
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0xabe685ab, Offset: 0x358
// Size: 0x7
function function_13351f0697c90de4()
{
    return 6;
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x64ee0295, Offset: 0x368
// Size: 0xd8
function surfacefunc()
{
    if ( isdefined( self.perks[ "specialty_swimming" ] ) )
    {
        utility::callsharedfunc( #"perk", #"removeperk", "specialty_swimming" );
    }
    
    if ( utility::issharedfuncdefined( #"stealth", #"hash_52cbfcaac72d7a8c" ) )
    {
        self [[ utility::getsharedfunc( #"stealth", #"hash_52cbfcaac72d7a8c" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"player", #"hash_db590c602f05adda" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"hash_db590c602f05adda" ) ]]();
    }
    
    if ( utility::callsharedfunc( #"scubagasmask", #"hasscubagasmask", self ) )
    {
        utility::callsharedfunc( #"scubagasmask", #"updatescubagasmask", self, 0 );
    }
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x53a630aa, Offset: 0x448
// Size: 0xc6
function descendfunc()
{
    if ( utility::issharedfuncdefined( #"perk", #"giveperk" ) )
    {
        self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( "specialty_swimming" );
    }
    
    if ( utility::issharedfuncdefined( #"stealth", #"hash_88f1e6bd1abde097" ) )
    {
        self [[ utility::getsharedfunc( #"stealth", #"hash_88f1e6bd1abde097" ) ]]();
    }
    
    if ( utility::callsharedfunc( #"scubagasmask", #"hasscubagasmask", self ) )
    {
        utility::callsharedfunc( #"scubagasmask", #"updatescubagasmask", self, 1 );
        thread utility::callsharedfunc( #"scubagasmask", #"monitorscubagasmaskdamage" );
    }
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x49dec2bf, Offset: 0x516
// Size: 0x45
function enterfunc()
{
    if ( utility::issharedfuncdefined( #"ftue", #"player_action" ) )
    {
        self [[ utility::getsharedfunc( #"ftue", #"player_action" ) ]]( "br_ftue_swimming" );
    }
    
    mtx_weapon::function_8647be440ecf68e9();
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x3064dfa, Offset: 0x563
// Size: 0x2
function exitfunc()
{
    
}

// Namespace swim_cp_mp
// Params 3
// Checksum 0x42f7eb51, Offset: 0x56d
// Size: 0x40
function playsoundfunc( firstpersonalias, thirdpersonalias, soundsource = self )
{
    if ( isdefined( thirdpersonalias ) )
    {
        self playsound( thirdpersonalias, self );
    }
    
    soundsource playsoundtoplayer( firstpersonalias, self, soundsource );
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x5b45f4b, Offset: 0x5b5
// Size: 0x99
function drownfunc()
{
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        if ( utility::isusingremote() )
        {
        }
        else
        {
            data = spawnstruct();
            data.allowairexit = 1;
            data.exittype = "INVOLUNTARY";
            thread vehicle_occupancy::exit( self.vehicle, undefined, self, data, 1 );
            
            while ( self isvehicleactive() )
            {
                waitframe();
            }
        }
    }
    
    utility::trycall( level.custom_drownfunc );
    return makeweapon( level.projectbundle.var_68c894f5d919aa16 ?? "iw9_drown_mp" );
}

// Namespace swim_cp_mp
// Params 2
// Checksum 0x97871135, Offset: 0x668
// Size: 0x1e
function visionsetfunc( visionset, transitiontime )
{
    self visionsetnakedforplayer( visionset, transitiontime );
}

// Namespace swim_cp_mp
// Params 1
// Checksum 0xa5677575, Offset: 0x68e
// Size: 0x52, Type: bool
function function_1e1adfdb14b5e1d1( objweapon )
{
    if ( !isdefined( objweapon.basename ) )
    {
        return false;
    }
    
    return level.projectbundle.var_68c894f5d919aa16 == objweapon.basename || objweapon.basename == "iw9_drown_mp";
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x105b0d18, Offset: 0x6e9
// Size: 0x7
function function_3869cac93d7db6df()
{
    return self function_65267a768ced48a0();
}

// Namespace swim_cp_mp
// Params 0
// Checksum 0x85b99e8e, Offset: 0x6f9
// Size: 0xf4
function function_953f2f60d47ab91b()
{
    for ( currentid = 1; currentid <= 4 ; currentid++ )
    {
        currenttriggers = getentarray( "trigger_multiple_mp_proto_current_" + currentid, #classname );
        
        foreach ( currenttrigger in currenttriggers )
        {
            currenttrigger.currentid = currentid;
            
            if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
            {
                [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( currenttrigger, &function_a295767a33af6c89, &function_5f20b15515490689 );
            }
        }
    }
}

// Namespace swim_cp_mp
// Params 2
// Checksum 0xa36fe9a1, Offset: 0x7f5
// Size: 0x34
function function_a295767a33af6c89( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player setwatercurrent( trigger.currentid, 1 );
}

// Namespace swim_cp_mp
// Params 2
// Checksum 0x8ce479a, Offset: 0x831
// Size: 0x33
function function_5f20b15515490689( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player setwatercurrent( trigger.currentid, 0 );
}

// Namespace swim_cp_mp
// Params 3
// Checksum 0x32010fca, Offset: 0x86c
// Size: 0x111
function function_394f3efa6a3b3a4d( vfx, notify_kill, timeout )
{
    self endon( #"disconnect" );
    nomodel = 0;
    var_43c48a2184fe84c7 = 0;
    
    if ( !isdefined( self.model ) || self.model == "" )
    {
        nomodel = 1;
    }
    
    if ( !utility::hastag( self.model, "tag_eye" ) )
    {
        var_43c48a2184fe84c7 = 1;
    }
    
    /#
        if ( nomodel )
        {
            iprintlnbold( "<dev string:x24>" + self getentitynumber() + "<dev string:x48>" );
        }
        
        if ( var_43c48a2184fe84c7 )
        {
            iprintlnbold( "<dev string:x60>" + self.model + "<dev string:x83>" );
        }
    #/
    
    if ( nomodel || var_43c48a2184fe84c7 )
    {
        return;
    }
    
    playfxontagforclients( level._effect[ vfx ], self, "tag_eye", self );
    
    if ( isdefined( notify_kill ) )
    {
        swim_common::function_bd47027c4d3e9288( notify_kill, "death", timeout );
        killfxontag( level._effect[ vfx ], self, "tag_eye" );
    }
}

