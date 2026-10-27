// scripts\mp\br\gametypes\br_bank.gsc  (hash_2d66a03f490d377e.gscc) (size: 2485 Bytes / 0x9b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x753d0e38 (1966935608)
// size ...... 2485 (0x9b5)
// includes .. 2   (offset: 0x959)
// strings ... 5   (offset: 0x969)
// dev strs .. 1   (offset: 0x9a9)
// exports ... 7   (offset: 0x5c5)
// cseg ...... 0xc6 + 0x4ff (0x5c5)
// imports ... 22  (offset: 0x6dd)
// animtree1 . 0   (offset: 0x9b5)
// animtree2 . 0   (offset: 0x9b5)
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;

#namespace br_bank;

// Namespace br_bank
// Params 0
// Checksum 0xc9b49bd4, Offset: 0xe4
// Size: 0x125
function init()
{
    level.br_bank_alarm_enabled = getdvarint( @"scr_br_bank_alarm", 0 );
    
    if ( !level.br_bank_alarm_enabled )
    {
        return;
    }
    
    level._effect[ "poi_light_bank" ] = loadfxasset( "vfx_iw8_br_gameplay_poi_light_bank" );
    level.bankalltriggers = getentarray( "bank_entry_detector", #targetname );
    
    foreach ( trigger in level.bankalltriggers )
    {
        if ( !isdefined( trigger ) )
        {
            continue;
        }
        
        trigger.playersinsidebank = 0;
        trigger.alarmstillplaying = 0;
        trigger.banklights = utility::getstructarray( trigger.target, "targetname" );
        trigger thread trigger::makeenterexittrigger( trigger, &bankplayerentering, &bankplayerexiting );
    }
}

// Namespace br_bank
// Params 2
// Checksum 0x5c5b9c61, Offset: 0x211
// Size: 0x52
function bankplayerentering( player, banktrigger )
{
    if ( !isdefined( banktrigger ) )
    {
        return;
    }
    
    banktrigger.playersinsidebank += 1;
    
    if ( banktrigger.playersinsidebank != 1 )
    {
        return;
    }
    
    banktrigger thread bankturnonalarm();
}

// Namespace br_bank
// Params 2
// Checksum 0x7cb5a747, Offset: 0x26b
// Size: 0x6f
function bankplayerexiting( player, banktrigger )
{
    if ( !isdefined( banktrigger ) )
    {
        return;
    }
    
    assert( banktrigger.playersinsidebank > 0, "<dev string:x24>" );
    banktrigger.playersinsidebank = max( banktrigger.playersinsidebank - 1, 0 );
    
    if ( banktrigger.playersinsidebank == 0 )
    {
        banktrigger thread bankturnoffalarm();
    }
}

// Namespace br_bank
// Params 0
// Checksum 0x231fa6c1, Offset: 0x2e2
// Size: 0xa4
function bankplunderdeposited()
{
    if ( !level.br_bank_alarm_enabled )
    {
        return;
    }
    
    player = self;
    player notify( #"hash_ca66d0f3444a24fa" );
    player endon( #"hash_ca66d0f3444a24fa" );
    var_f24c2a0c5a9fbe7a = function_47c86977a18df38b( level.bankalltriggers, player.origin, 90000 );
    
    if ( !isdefined( var_f24c2a0c5a9fbe7a ) )
    {
        return;
    }
    
    var_f24c2a0c5a9fbe7a bankturnoffalarm();
    var_d1f4ba83758fc9bc = getdvarint( @"hash_32eab55ff865c3c", 15 );
    wait var_d1f4ba83758fc9bc;
    
    if ( var_f24c2a0c5a9fbe7a.playersinsidebank > 0 )
    {
        var_f24c2a0c5a9fbe7a bankturnonalarm();
    }
}

// Namespace br_bank
// Params 0
// Checksum 0x38004574, Offset: 0x38e
// Size: 0x16c
function bankturnonalarm()
{
    self notify( #"hash_37f81a168654f2f7" );
    banktrigger = self;
    banktrigger.alarmstillplaying = 1;
    banktrigger playloopsound( "bank_alarm_lp" );
    
    foreach ( banklight in banktrigger.banklights )
    {
        if ( !isdefined( banklight.fx ) )
        {
            forwardvect = anglestoforward( banklight.angles );
            upvect = anglestoup( banklight.angles );
            banklight.fx = spawnfx( level._effect[ "poi_light_bank" ], banklight.origin + forwardvect * 5, forwardvect, upvect );
            triggerfx( banklight.fx );
        }
    }
    
    var_29d805bae109ef01 = getdvarint( @"hash_5b11f68d6b008181", 5 );
    wait var_29d805bae109ef01;
    banktrigger.alarmstillplaying = 0;
    
    if ( banktrigger.playersinsidebank == 0 )
    {
        banktrigger bankturnoffalarm();
    }
}

// Namespace br_bank
// Params 0
// Checksum 0x47c50f1, Offset: 0x502
// Size: 0xc3
function bankturnoffalarm()
{
    self endon( #"hash_37f81a168654f2f7" );
    banktrigger = self;
    
    if ( banktrigger.alarmstillplaying )
    {
        return;
    }
    
    wait 3;
    banktrigger stoploopsound();
    
    foreach ( banklight in banktrigger.banklights )
    {
        if ( isdefined( banklight.fx ) )
        {
            banklight.fx delete();
        }
    }
}

