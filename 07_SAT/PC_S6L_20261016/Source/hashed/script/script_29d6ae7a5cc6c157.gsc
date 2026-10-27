// script_29d6ae7a5cc6c157  (hash_29d6ae7a5cc6c157.gscc) (size: 1088 Bytes / 0x440 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a182ddb (2585275867)
// size ...... 1088 (0x440)
// includes .. 2   (offset: 0x410)
// strings ... 2   (offset: 0x420)
// dev strs .. 0   (offset: 0x440)
// exports ... 7   (offset: 0x214)
// cseg ...... 0x90 + 0x184 (0x214)
// imports ... 8   (offset: 0x32c)
// animtree1 . 0   (offset: 0x440)
// animtree2 . 0   (offset: 0x440)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\perk;

#namespace specialty_tracker_victim;

// Namespace specialty_tracker_victim
// Params 0, eflags: 0x5
// Checksum 0x9a9969e, Offset: 0xae
// Size: 0x2e
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_4784c98d0a70d54f );
    level callback::add( #"player_damaged", &onplayerdamaged );
}

// Namespace specialty_tracker_victim
// Params 1, eflags: 0x4
// Checksum 0xe2218469, Offset: 0xe4
// Size: 0x3a
function private function_4784c98d0a70d54f( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_tracker_victim", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_tracker_victim
// Params 0, eflags: 0x4
// Checksum 0x611593fe, Offset: 0x126
// Size: 0x18
function private setspecialty()
{
    player = self;
    player thread function_d323db4b32b1e5f5();
}

// Namespace specialty_tracker_victim
// Params 0, eflags: 0x4
// Checksum 0x25486456, Offset: 0x146
// Size: 0x2
function private unsetspecialty()
{
    
}

// Namespace specialty_tracker_victim
// Params 0, eflags: 0x4
// Checksum 0x89e930f5, Offset: 0x150
// Size: 0x3d
function private function_d323db4b32b1e5f5()
{
    player = self;
    player notify( #"hash_8ba05a7c6c9e9132" );
    player endon( #"hash_8ba05a7c6c9e9132" );
    wait 10;
    player perk::removeperk( "specialty_tracker_victim" );
}

// Namespace specialty_tracker_victim
// Params 1, eflags: 0x4
// Checksum 0x2f3de7a7, Offset: 0x195
// Size: 0x7f
function private onplayerdamaged( params )
{
    victim = self;
    
    if ( 1 && isdefined( params.eattacker ) && params.eattacker == victim )
    {
        return;
    }
    
    if ( !isdefined( params.eattacker ) )
    {
        return;
    }
    
    if ( isdefined( params.eattacker.perks[ "specialty_combat_tracker" ] ) )
    {
        victim perk::giveperk( "specialty_tracker_victim" );
    }
}

