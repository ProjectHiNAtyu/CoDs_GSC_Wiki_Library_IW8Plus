// script_5e6781045e5b6b8a  (hash_5e6781045e5b6b8a.gscc) (size: 1155 Bytes / 0x483 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd72a32ae (3609866926)
// size ...... 1155 (0x483)
// includes .. 2   (offset: 0x447)
// strings ... 3   (offset: 0x457)
// dev strs .. 0   (offset: 0x483)
// exports ... 7   (offset: 0x22b)
// cseg ...... 0x85 + 0x1a6 (0x22b)
// imports ... 9   (offset: 0x343)
// animtree1 . 0   (offset: 0x483)
// animtree2 . 0   (offset: 0x483)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_prone_firing;

// Namespace specialty_prone_firing
// Params 0, eflags: 0x1
// Checksum 0x81925d69, Offset: 0xa3
// Size: 0x54
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"hash_474490f7ce8b74d0", &onfiredshot );
    setdvar( @"hash_1cb9c93df413efa7", 0.9 );
    setdvar( @"hash_e2207ae6dfe0025f", 0.75 );
}

// Namespace specialty_prone_firing
// Params 1
// Checksum 0x63dfbaa1, Offset: 0xff
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_prone_firing", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_prone_firing
// Params 0
// Checksum 0x8a2da3d1, Offset: 0x141
// Size: 0x2
function setspecialty()
{
    
}

// Namespace specialty_prone_firing
// Params 0
// Checksum 0xba9a17bf, Offset: 0x14b
// Size: 0x2
function unsetspecialty()
{
    
}

// Namespace specialty_prone_firing
// Params 1
// Checksum 0xe617da, Offset: 0x155
// Size: 0x98
function onfiredshot( params )
{
    player = self;
    
    if ( !isdefined( player.perks[ "specialty_prone_firing" ] ) )
    {
        return;
    }
    
    currentstance = player getstance();
    
    if ( !player.var_8781dd54c42a0a50 )
    {
        player.var_8781dd54c42a0a50 = 0;
        
        if ( currentstance == "crouch" || currentstance == "prone" )
        {
            player namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_prone_firing" );
            player.var_8781dd54c42a0a50 = 1;
            player thread function_72a672b279f551e9();
        }
    }
}

// Namespace specialty_prone_firing
// Params 0
// Checksum 0x54dbcdd6, Offset: 0x1f5
// Size: 0x36
function function_72a672b279f551e9()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 5;
    player.var_8781dd54c42a0a50 = undefined;
}

