// script_67400fd270992d79  (hash_67400fd270992d79.gscc) (size: 1679 Bytes / 0x68f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57eecde4 (1475268068)
// size ...... 1679 (0x68f)
// includes .. 3   (offset: 0x64b)
// strings ... 3   (offset: 0x663)
// dev strs .. 0   (offset: 0x68f)
// exports ... 9   (offset: 0x34b)
// cseg ...... 0xb5 + 0x296 (0x34b)
// imports ... 14  (offset: 0x4b3)
// animtree1 . 0   (offset: 0x68f)
// animtree2 . 0   (offset: 0x68f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\mp\playerhealth;

#namespace specialty_sprint_health_regen;

// Namespace specialty_sprint_health_regen
// Params 0, eflags: 0x5
// Checksum 0x41fa2273, Offset: 0xd3
// Size: 0x5a
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_fbcf235a14780d06 );
    level callback::add( #"sprint_begin", &function_112311fd68e46b6a );
    level callback::add( #"sprint_end", &function_43ce797bc10c8f8e );
    level callback::add( #"player_damaged", &onplayerdamaged );
}

// Namespace specialty_sprint_health_regen
// Params 1, eflags: 0x4
// Checksum 0x68050422, Offset: 0x135
// Size: 0x3a
function private function_fbcf235a14780d06( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_sprint_health_regen", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_sprint_health_regen
// Params 0, eflags: 0x4
// Checksum 0xc289f2b9, Offset: 0x177
// Size: 0x30
function private setspecialty()
{
    player = self;
    player.var_621ea2ab38d50c90 = player.var_9842326056fd7207.var_621ea2ab38d50c90;
}

// Namespace specialty_sprint_health_regen
// Params 0, eflags: 0x4
// Checksum 0xe1adf3e, Offset: 0x1af
// Size: 0x27
function private unsetspecialty()
{
    player = self;
    player.var_621ea2ab38d50c90 = undefined;
    self setclientomnvar( "ui_perk_sprint_health_regen_state", -1 );
}

// Namespace specialty_sprint_health_regen
// Params 1, eflags: 0x4
// Checksum 0xe8d4c348, Offset: 0x1de
// Size: 0x22
function private function_112311fd68e46b6a( params )
{
    player = self;
    player thread function_c75dbbf218cafacf();
}

// Namespace specialty_sprint_health_regen
// Params 0, eflags: 0x4
// Checksum 0xfeab9782, Offset: 0x208
// Size: 0xaf
function private function_c75dbbf218cafacf()
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"hash_3ad73e424198c7ff" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.var_621ea2ab38d50c90 ) )
    {
        return;
    }
    
    wait player.var_621ea2ab38d50c90;
    
    if ( isdefined( player ) && isdefined( player.perks[ "specialty_sprint_health_regen" ] ) )
    {
        if ( player.health < player.maxhealth )
        {
            playerhealth::forcehealthregen( player, 1, 1, { #var_a979d89e08fec370:1 } );
            player namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_grenadier" );
        }
    }
}

// Namespace specialty_sprint_health_regen
// Params 1, eflags: 0x4
// Checksum 0x56aaf159, Offset: 0x2bf
// Size: 0x5e
function private onplayerdamaged( params )
{
    player = params.victim;
    
    if ( isplayer( player ) && player issprinting() && isdefined( player.perks[ "specialty_sprint_health_regen" ] ) )
    {
        player function_43ce797bc10c8f8e();
        player thread function_c75dbbf218cafacf();
    }
}

// Namespace specialty_sprint_health_regen
// Params 1, eflags: 0x4
// Checksum 0x7de8b60d, Offset: 0x325
// Size: 0x26
function private function_43ce797bc10c8f8e( params )
{
    player = self;
    player notify( #"hash_3ad73e424198c7ff" );
}

