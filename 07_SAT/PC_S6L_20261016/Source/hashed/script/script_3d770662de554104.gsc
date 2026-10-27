// script_3d770662de554104  (hash_3d770662de554104.gscc) (size: 2284 Bytes / 0x8ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1c7b383 (4056396675)
// size ...... 2284 (0x8ec)
// includes .. 4   (offset: 0x814)
// strings ... 12  (offset: 0x834)
// dev strs .. 3   (offset: 0x8c8)
// exports ... 7   (offset: 0x534)
// cseg ...... 0x1ef + 0x345 (0x534)
// imports ... 16  (offset: 0x64c)
// animtree1 . 0   (offset: 0x8ec)
// animtree2 . 0   (offset: 0x8ec)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;

#namespace call_reinforcements;

// Namespace call_reinforcements
// Params 1
// Checksum 0xe4d1192c, Offset: 0x20d
// Size: 0x5c
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_256644959193a6c7":
            return &callreinforcements;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace call_reinforcements
// Params 1
// Checksum 0x440cda2d, Offset: 0x271
// Size: 0xc
function onuserinit( interactionid )
{
    
}

// Namespace call_reinforcements
// Params 1
// Checksum 0x7828eb3f, Offset: 0x285
// Size: 0x20
function onuserterminate( interactionid )
{
    self clearbtgoal( 1 );
    self notify( #"hash_ab327ecc486f251c" );
}

// Namespace call_reinforcements
// Params 2
// Checksum 0xea574dd7, Offset: 0x2ad
// Size: 0xbf
function callreinforcements( statename, params )
{
    self endon( #"death" );
    self endon( #"hash_ab327ecc486f251c" );
    callreinforcementsbundle = getscriptbundle( "ai_behavior_call_reinforcements:ai_behavior_call_reinforcements_default" );
    
    if ( !isdefined( callreinforcementsbundle ) )
    {
        assertmsg( "<dev string:x42>" );
        return;
    }
    
    self setbtgoalstationary( 1 );
    self setbtgoalradius( 1, 12 );
    capname = "cap_call_reinforcements";
    
    if ( self.asmname != capname )
    {
        cap::cap_start( capname, "cap_call_reinforcements" );
    }
    
    self playsound( "dx_br_dbos_dbli_dbtp_bitr" );
    thread function_9bccbee61c4d560d( callreinforcementsbundle.var_45aca519a5278d6 );
    self waittill( #"cap_exit_completed" );
}

// Namespace call_reinforcements
// Params 1
// Checksum 0x770fa2d5, Offset: 0x374
// Size: 0x7b
function function_9bccbee61c4d560d( calllength )
{
    self endon( #"death" );
    self endon( #"hash_ab327ecc486f251c" );
    wait calllength;
    
    if ( isdefined( level.agent_funcs ) )
    {
        spawnreinforcementsfunc = level.agent_funcs[ "spawn_reinforcements" ];
        
        if ( isdefined( spawnreinforcementsfunc ) )
        {
            [[ spawnreinforcementsfunc ]]( self.origin, 0, 1 );
        }
    }
    
    asm::asm_fireevent( self.asmname, "call_reinforcements_loop_end" );
}

// Namespace call_reinforcements
// Params 3
// Checksum 0x9e3edade, Offset: 0x3f7
// Size: 0x13c
function callreinforcementschooseanim( asmname, statename, params )
{
    sectionname = params;
    
    if ( !isdefined( sectionname ) )
    {
        assertmsg( "<dev string:xb4>" );
        return;
    }
    
    stance = asm_bb::bb_getrequestedstance();
    coverstate = asm_bb::bb_getrequestedcoverstate();
    animname = "call_reinforcements";
    
    if ( coverstate != "exposed" )
    {
        covernode = asm_bb::bb_getcovernode();
        
        if ( isdefined( covernode ) )
        {
            covertype = covernode.type;
            
            switch ( covertype )
            {
                case #"hash_cd3ffe799551db82":
                    animname += "_cover_right_" + stance;
                    break;
                case #"hash_e1d8e1adebed5a61":
                    animname += "_cover_left_" + stance;
                    break;
                case #"hash_c3b74422dec48736":
                    animname += "_cover_crouch";
                    break;
                case #"hash_78b110033ccb68b0":
                    animname += "_cover_stand";
                    break;
            }
        }
    }
    
    animname += "_" + sectionname;
    alternativename = asm_cap::cap_lookupanimfromalias( statename, animname );
    return alternativename;
}

