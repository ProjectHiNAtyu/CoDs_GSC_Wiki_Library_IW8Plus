// script_367a2802c7e0084c  (hash_367a2802c7e0084c.gscc) (size: 1517 Bytes / 0x5ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe37332f0 (3815977712)
// size ...... 1517 (0x5ed)
// includes .. 2   (offset: 0x5c5)
// strings ... 2   (offset: 0x5d5)
// dev strs .. 0   (offset: 0x5ed)
// exports ... 6   (offset: 0x3c5)
// cseg ...... 0x82 + 0x343 (0x3c5)
// imports ... 9   (offset: 0x4b5)
// animtree1 . 0   (offset: 0x5ed)
// animtree2 . 0   (offset: 0x5ed)
#using scripts\common\callbacks;
#using scripts\mp\playerhealth;

#namespace specialty_health_on_hit;

// Namespace specialty_health_on_hit
// Params 0, eflags: 0x1
// Checksum 0x300ec4d3, Offset: 0xa0
// Size: 0x44
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_damaged", &function_be8f002a1fe98979 );
    level callback::add( #"on_ai_damaged", &function_be8f002a1fe98979 );
}

// Namespace specialty_health_on_hit
// Params 1
// Checksum 0x6ea0036e, Offset: 0xec
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_health_on_hit", &setspecialty, &unsetspecialty );
    }
}

// Namespace specialty_health_on_hit
// Params 0
// Checksum 0x5c33c70c, Offset: 0x12c
// Size: 0x126
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    self.var_8f9b5c910272ba = { #hittypedata:[], #var_404de07ffaca98d5:bundle.var_d8d72e8353c6498d };
    
    if ( bundle.var_2551c9b993316d9a )
    {
        foreach ( item in bundle.var_2551c9b993316d9a )
        {
            if ( !item || !item.hittype || item.hittype == "MOD_UNKNOWN" || !item.var_3e1b5b937879bd0a )
            {
                continue;
            }
            
            self.var_8f9b5c910272ba.hittypedata[ item.hittype ] = item.var_3e1b5b937879bd0a;
        }
    }
}

// Namespace specialty_health_on_hit
// Params 0
// Checksum 0xae0dd603, Offset: 0x25a
// Size: 0xc
function unsetspecialty()
{
    self.var_8f9b5c910272ba = undefined;
}

// Namespace specialty_health_on_hit
// Params 1
// Checksum 0x521306c6, Offset: 0x26e
// Size: 0x157
function function_be8f002a1fe98979( params )
{
    if ( !isdefined( params ) )
    {
        return;
    }
    
    attacker = params.eattacker;
    meansofdeath = params.smeansofdeath;
    
    if ( !attacker || !meansofdeath || !attacker.var_8f9b5c910272ba.hittypedata[ meansofdeath ] || !isplayer( attacker ) )
    {
        return;
    }
    
    var_ec4d4eaaf675f202 = attacker.var_8f9b5c910272ba.hittypedata[ meansofdeath ];
    var_13beeeff1379440a = clamp( attacker.maxhealth - attacker.health, 0, var_ec4d4eaaf675f202 );
    var_6e03a3a422ec6698 = attacker.var_8f9b5c910272ba.var_404de07ffaca98d5;
    var_ebb25bc30311ec53 = attacker.temphealth ?? 0;
    var_1cd15acbddb54186 = 0;
    
    if ( var_6e03a3a422ec6698 && var_13beeeff1379440a < var_ec4d4eaaf675f202 && var_ebb25bc30311ec53 < var_6e03a3a422ec6698 )
    {
        var_1cd15acbddb54186 = clamp( var_ec4d4eaaf675f202 - var_13beeeff1379440a, 0, clamp( var_6e03a3a422ec6698 - var_ebb25bc30311ec53, 0, var_ec4d4eaaf675f202 ) );
        playerhealth::function_ed81022bf9702b0a( attacker, var_ebb25bc30311ec53 + var_1cd15acbddb54186 );
    }
    
    attacker.health += var_13beeeff1379440a + var_1cd15acbddb54186;
}

