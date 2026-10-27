// script_3628824af00f0d4e  (hash_3628824af00f0d4e.gscc) (size: 1385 Bytes / 0x569 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78b36537 (2025022775)
// size ...... 1385 (0x569)
// includes .. 2   (offset: 0x541)
// strings ... 2   (offset: 0x551)
// dev strs .. 0   (offset: 0x569)
// exports ... 7   (offset: 0x341)
// cseg ...... 0x8d + 0x2b4 (0x341)
// imports ... 8   (offset: 0x459)
// animtree1 . 0   (offset: 0x569)
// animtree2 . 0   (offset: 0x569)
#using scripts\common\callbacks;
#using scripts\mp\playerhealth;

#namespace specialty_give_revivee_temp_health;

// Namespace specialty_give_revivee_temp_health
// Params 0, eflags: 0x1
// Checksum 0xd7368aa4, Offset: 0xab
// Size: 0x44
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_laststand_revived", &onplayerrevived );
    level callback::add( #"player_laststand", &function_def1e1d24ede9b70 );
}

// Namespace specialty_give_revivee_temp_health
// Params 1
// Checksum 0xdc0fa01b, Offset: 0xf7
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_give_revivee_temp_health", &setspecialty, &unsetspecialty );
    }
}

// Namespace specialty_give_revivee_temp_health
// Params 0
// Checksum 0xe39f8561, Offset: 0x137
// Size: 0x5d
function setspecialty()
{
    if ( !isdefined( self.var_9842326056fd7207.var_ccd4e989fc3ea42 ) )
    {
        return;
    }
    
    self.var_86d9240adad283cb = { #var_d29cd2fbc5f97e14:self.var_9842326056fd7207.var_e5420647155ee35c, #temphealth:self.var_9842326056fd7207.var_ccd4e989fc3ea42 };
}

// Namespace specialty_give_revivee_temp_health
// Params 0
// Checksum 0x62b0df86, Offset: 0x19c
// Size: 0xc
function unsetspecialty()
{
    self.var_86d9240adad283cb = undefined;
}

// Namespace specialty_give_revivee_temp_health
// Params 1
// Checksum 0xf51a3325, Offset: 0x1b0
// Size: 0x96
function function_def1e1d24ede9b70( params )
{
    if ( params.victim )
    {
        var_522b870f8e086aae = params.meansofdeath != "MOD_FALLING";
        
        if ( params.attacker )
        {
            var_522b870f8e086aae &= params.victim.team != params.attacker.team;
        }
        
        params.victim.var_522b870f8e086aae = var_522b870f8e086aae ? 1 : undefined;
    }
}

// Namespace specialty_give_revivee_temp_health
// Params 1
// Checksum 0xde6b3fe1, Offset: 0x24e
// Size: 0xf3
function onplayerrevived( params )
{
    reviver = params.reviver;
    revivee = params.victim;
    
    if ( !revivee || !revivee.var_522b870f8e086aae )
    {
        return;
    }
    
    revivee.var_522b870f8e086aae = undefined;
    
    if ( !reviver || !reviver.var_86d9240adad283cb )
    {
        return;
    }
    
    if ( reviver.var_86d9240adad283cb.temphealth <= 0 || reviver == revivee && !reviver.var_86d9240adad283cb.var_d29cd2fbc5f97e14 )
    {
        return;
    }
    
    playerhealth::function_ed81022bf9702b0a( revivee, reviver.var_86d9240adad283cb.temphealth );
    revivee thread playerhealth::function_e32a83bf4c298600( undefined, 3, { #amount:1000, #nobattlechatter:1 } );
}

