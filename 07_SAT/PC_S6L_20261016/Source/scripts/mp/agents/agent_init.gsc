// scripts\mp\agents\agent_init.gsc  (hash_4c317673c276d697.gscc) (size: 2027 Bytes / 0x7eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51f1f733 (1374811955)
// size ...... 2027 (0x7eb)
// includes .. 7   (offset: 0x78f)
// strings ... 3   (offset: 0x7c7)
// dev strs .. 0   (offset: 0x7eb)
// exports ... 10  (offset: 0x2eb)
// cseg ...... 0x87 + 0x264 (0x2eb)
// imports ... 27  (offset: 0x47b)
// animtree1 . 0   (offset: 0x7eb)
// animtree2 . 0   (offset: 0x7eb)
#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\mp_agent;

#namespace agent_init;

// Namespace agent_init
// Params 0
// Checksum 0x24cfe12c, Offset: 0xa5
// Size: 0x61
function agent_init()
{
    if ( isdefined( anim.notfirsttime ) )
    {
        return;
    }
    
    anim.notfirsttime = 1;
    shared::initanimvars();
    asm_mp::function_f7a8bcd86dc6ead3();
    shared::initmeleecharges();
    shared::setuprandomtable();
    shared::init_squadmanager();
    setupgrenades();
    initanimcallbacks();
    function_aa5164693cf50c5b();
    initstealthfuncsmp();
    face::initlevelface();
}

// Namespace agent_init
// Params 0
// Checksum 0x3b5d34b7, Offset: 0x10e
// Size: 0x28
function setupgrenades()
{
    aisetgrenadetimer( undefined, "lethal", randomintrange( 0, 20000 ) );
    aisetgrenadetimer( undefined, "tactical", randomintrange( 0, 20000 ) );
}

// Namespace agent_init
// Params 0
// Checksum 0x54efff39, Offset: 0x13e
// Size: 0x2d
function initanimcallbacks()
{
    if ( !isdefined( anim.callbacks ) )
    {
        anim.callbacks = [];
    }
    
    anim.callbacks[ "PlaySoundAtViewHeight" ] = &play_sound_at_viewheightmp;
}

// Namespace agent_init
// Params 0
// Checksum 0x5eebc02, Offset: 0x173
// Size: 0xd4
function function_aa5164693cf50c5b()
{
    utility::registersharedfunc( #"ai", #"onHumanoidAgentKilledCommon_SharedFunc", &mp_agent::on_humanoid_agent_killed_common );
    utility::registersharedfunc( #"ai", #"spawnnewaitype_sharedfunc", &mp_agent::spawnnewagentaitype );
    utility::registersharedfunc( #"ai", #"hack", &mp_agent::agent_hack );
    utility::registersharedfunc( #"ai", #"Animscripted_SharedFunc", &utility::animscriptedagent );
    utility::registersharedfunc( #"ai", #"hash_eeabeb442ca0054", &utility::function_4c656524ecb504d6 );
    utility::registersharedfunc( #"ai", #"get_aitype_by_subclass_sharedfunc", &agent_utils::get_aitype_by_subclass );
    utility::registersharedfunc( #"ai", #"getfreeaicount", &function_52064c9536feae8a );
}

// Namespace agent_init
// Params 0, eflags: 0x4
// Checksum 0xd84816e3, Offset: 0x24f
// Size: 0x6
function private function_52064c9536feae8a()
{
    return getfreeagentcount();
}

// Namespace agent_init
// Params 3
// Checksum 0x87ba4ce0, Offset: 0x25e
// Size: 0x51
function play_sound_at_viewheightmp( aliasname, notification_string, var_868a4b7218755765 )
{
    if ( !isdefined( aliasname ) )
    {
        return;
    }
    
    if ( !soundexists( aliasname ) )
    {
        return;
    }
    
    self playsoundatviewheight( aliasname, undefined, self );
    
    if ( isdefined( notification_string ) )
    {
        wait lookupsoundlength( aliasname ) / 1000;
        self notify( notification_string );
    }
}

// Namespace agent_init
// Params 0
// Checksum 0x2cb089b8, Offset: 0x2b7
// Size: 0x10
function initstealthfuncsmp()
{
    level.stealthinit = &initstealthmp;
}

// Namespace agent_init
// Params 0
// Checksum 0x56654f9f, Offset: 0x2cf
// Size: 0x3
function getcorpsearraymp()
{
    return [];
}

// Namespace agent_init
// Params 0
// Checksum 0x1acd31ed, Offset: 0x2db
// Size: 0x10
function initstealthmp()
{
    level.fngetcorpsearrayfunc = &getcorpsearraymp;
}

