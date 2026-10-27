// script_8eb9a7924d15c6e  (hash_08eb9a7924d15c6e.gscc) (size: 948 Bytes / 0x3b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7828b15d (2015932765)
// size ...... 948 (0x3b4)
// includes .. 1   (offset: 0x394)
// strings ... 1   (offset: 0x39c)
// dev strs .. 0   (offset: 0x3b4)
// exports ... 5   (offset: 0x224)
// cseg ...... 0x7a + 0x1aa (0x224)
// imports ... 6   (offset: 0x2ec)
// animtree1 . 0   (offset: 0x3b4)
// animtree2 . 0   (offset: 0x3b4)
#using scripts\common\callbacks;

#namespace specialty_footstep_audio_focus;

// Namespace specialty_footstep_audio_focus
// Params 0, eflags: 0x5
// Checksum 0xb1e1c676, Offset: 0x98
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_footstep_audio_focus
// Params 1, eflags: 0x4
// Checksum 0xe25b8d70, Offset: 0xb8
// Size: 0x3a
function private registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_footstep_audio_focus", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_footstep_audio_focus
// Params 0, eflags: 0x4
// Checksum 0x2cff0cd7, Offset: 0xfa
// Size: 0xa8
function private setspecialty()
{
    bundle = self.var_9842326056fd7207;
    
    if ( !bundle || !bundle.var_c433b959bd9af1c9 )
    {
        return;
    }
    
    fadeintime = bundle.var_b9e8c6f9ad10eca6 ?? -1;
    scale = bundle.var_ab41474055b39b8c ?? 1;
    self setsoundsubmix( bundle.var_c433b959bd9af1c9, fadeintime, scale );
    
    if ( !isdefined( self.var_bb73d2455014e3c ) )
    {
        self.var_bb73d2455014e3c = [];
    }
    
    self.var_bb73d2455014e3c[ "specialty_footstep_audio_focus" ] = { #bundle:bundle };
}

// Namespace specialty_footstep_audio_focus
// Params 0, eflags: 0x4
// Checksum 0x3f82bcc7, Offset: 0x1aa
// Size: 0x7a
function private unsetspecialty()
{
    bundle = self.var_bb73d2455014e3c[ "specialty_footstep_audio_focus" ].bundle;
    
    if ( !bundle || !bundle.var_c433b959bd9af1c9 )
    {
        return;
    }
    
    fadeouttime = bundle.var_962e298a5e87c29d ?? -1;
    self clearsoundsubmix( bundle.var_c433b959bd9af1c9, fadeouttime );
    self.var_bb73d2455014e3c[ "specialty_footstep_audio_focus" ] = undefined;
}

