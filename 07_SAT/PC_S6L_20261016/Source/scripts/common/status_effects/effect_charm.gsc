// scripts\common\status_effects\effect_charm.gsc  (hash_554830d27078277d.gscc) (size: 1002 Bytes / 0x3ea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4802e544 (1208149316)
// size ...... 1002 (0x3ea)
// includes .. 1   (offset: 0x3d2)
// strings ... 1   (offset: 0x3da)
// dev strs .. 0   (offset: 0x3ea)
// exports ... 4   (offset: 0x24e)
// cseg ...... 0x61 + 0x1ed (0x24e)
// imports ... 8   (offset: 0x2ee)
// animtree1 . 0   (offset: 0x3ea)
// animtree2 . 0   (offset: 0x3ea)
#using scripts\common\status_effects\status_effects;

#namespace effect_charm;

// Namespace effect_charm
// Params 5
// Checksum 0x80cb5aa7, Offset: 0x7f
// Size: 0x109
function charm( durations, attacker, var_ec9eab1b0cf732fb, var_749345f344f55b77, var_f558bf1f9fce8cbe = 1 )
{
    if ( !isdefined( self ) || isplayer( self ) || !self.aisettings.var_abb7ad1e6db7fa37 || status_effects::has_status_effect_type( "charm" ) )
    {
        return 0;
    }
    
    assert( isdefined( attacker.team ) );
    var_6bee30cd741982fb = status_effects::function_93edde8d0fe48bb6( "charm", durations, undefined, &function_43a5a5c1b915f002, &function_9785f95cae31ecc3, var_749345f344f55b77 );
    var_6bee30cd741982fb.var_ee6f6b2cdf5ddbd7 = self.team;
    var_6bee30cd741982fb.attacker = attacker;
    var_6bee30cd741982fb.new_team = attacker.team;
    var_6bee30cd741982fb.var_ec9eab1b0cf732fb = var_ec9eab1b0cf732fb;
    var_6bee30cd741982fb.var_f558bf1f9fce8cbe = var_f558bf1f9fce8cbe;
    return status_effects::function_3747671c47b03216( var_6bee30cd741982fb );
}

// Namespace effect_charm
// Params 1, eflags: 0x4
// Checksum 0x13e8d02, Offset: 0x191
// Size: 0x5b
function private function_43a5a5c1b915f002( effect )
{
    if ( isdefined( self ) && isdefined( effect ) )
    {
        if ( effect.var_f558bf1f9fce8cbe )
        {
            self.health = self.maxhealth;
        }
        
        self.allowpain = 0;
        self.team = effect.new_team;
        self clearpath();
    }
}

// Namespace effect_charm
// Params 1, eflags: 0x4
// Checksum 0x93ff23d8, Offset: 0x1f4
// Size: 0x5a
function private function_9785f95cae31ecc3( effect )
{
    if ( isdefined( self ) && isdefined( effect ) )
    {
        self.allowpain = 1;
        self.team = effect.var_ee6f6b2cdf5ddbd7;
        self clearpath();
        
        if ( isdefined( effect.var_ec9eab1b0cf732fb ) )
        {
            self [[ effect.var_ec9eab1b0cf732fb ]]();
        }
    }
}

