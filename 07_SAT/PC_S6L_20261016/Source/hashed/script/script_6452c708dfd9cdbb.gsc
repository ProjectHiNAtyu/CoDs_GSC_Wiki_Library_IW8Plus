// script_6452c708dfd9cdbb  (hash_6452c708dfd9cdbb.gscc) (size: 1915 Bytes / 0x77b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35d05705 (902846213)
// size ...... 1915 (0x77b)
// includes .. 4   (offset: 0x727)
// strings ... 3   (offset: 0x747)
// dev strs .. 0   (offset: 0x77b)
// exports ... 9   (offset: 0x3c3)
// cseg ...... 0xa6 + 0x31d (0x3c3)
// imports ... 17  (offset: 0x52b)
// animtree1 . 0   (offset: 0x77b)
// animtree2 . 0   (offset: 0x77b)
#using scripts\common\callbacks;
#using scripts\mp\armor;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_revived_buff;

// Namespace specialty_revived_buff
// Params 0, eflags: 0x5
// Checksum 0x1ddd5690, Offset: 0xc4
// Size: 0x44
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_b940917f26d0dc15 );
    level callback::add( #"hash_399a5fbd0e29ab64", &function_7d8d7c570661edb3 );
    level callback::add( #"hash_1d25b1f60ee0c1b5", &function_aeaa342538fa6445 );
}

// Namespace specialty_revived_buff
// Params 1, eflags: 0x4
// Checksum 0x85fd09a3, Offset: 0x110
// Size: 0x3a
function private function_b940917f26d0dc15( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_revived_buff", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_revived_buff
// Params 0, eflags: 0x4
// Checksum 0xe436db1a, Offset: 0x152
// Size: 0x51
function private setspecialty()
{
    player = self;
    player.var_d016fd47f928a556 = player.var_9842326056fd7207.var_a3d7b9068455976e;
    player.var_7c05dcd7771a720e = player.var_9842326056fd7207.var_7c05dcd7771a720e;
}

// Namespace specialty_revived_buff
// Params 0, eflags: 0x4
// Checksum 0x84f7e00, Offset: 0x1ab
// Size: 0x25
function private unsetspecialty()
{
    player = self;
    player.var_d016fd47f928a556 = undefined;
    player.var_7c05dcd7771a720e = undefined;
}

// Namespace specialty_revived_buff
// Params 1, eflags: 0x4
// Checksum 0xc0834c23, Offset: 0x1d8
// Size: 0x62
function private function_7d8d7c570661edb3( params )
{
    reviver = self;
    revivee = params.revivee;
    
    if ( !isplayer( revivee ) )
    {
        return;
    }
    
    if ( isdefined( reviver.perks[ "specialty_revived_buff" ] ) )
    {
        revivee thread function_5fcae05754d7b02d( reviver );
        revivee function_e43582e4fd932430( reviver );
    }
}

// Namespace specialty_revived_buff
// Params 1, eflags: 0x4
// Checksum 0xd214eda, Offset: 0x242
// Size: 0x7a
function private function_aeaa342538fa6445( params )
{
    revivee = self;
    reason = params.reason;
    reviver = revivee;
    
    if ( !isplayer( revivee ) || reason != "last_stand_self_revive" )
    {
        return;
    }
    
    if ( isdefined( revivee.perks[ "specialty_revived_buff" ] ) )
    {
        revivee thread function_5fcae05754d7b02d( reviver );
        revivee function_e43582e4fd932430( reviver );
    }
}

// Namespace specialty_revived_buff
// Params 1, eflags: 0x4
// Checksum 0x52ef5432, Offset: 0x2c4
// Size: 0x79
function private function_e43582e4fd932430( reviver )
{
    revivee = self;
    
    if ( !( reviver.var_7c05dcd7771a720e ?? 0 ) )
    {
        if ( revivee armor::function_22290101992e4874() > 0 && revivee armor::getarmorhealth() < 50 )
        {
            revivee armor::function_164c824617d7e8d7( -1 );
            revivee armor::setarmorhealth( 50 );
            return;
        }
        
        return;
    }
    
    if ( revivee armor::getarmorhealth() < 50 )
    {
        revivee armor::setarmorhealth( 50 );
    }
}

// Namespace specialty_revived_buff
// Params 1, eflags: 0x4
// Checksum 0x64d9e082, Offset: 0x345
// Size: 0x7e
function private function_5fcae05754d7b02d( reviver )
{
    revivee = self;
    
    if ( !isdefined( reviver.var_d016fd47f928a556 ) )
    {
        return;
    }
    
    revivee common::function_ac4bf3256b2545e3( "revivedBuffSpeedScalar", reviver.var_d016fd47f928a556 );
    revivee weapons::updatemovespeedscale();
    wait 3;
    
    if ( !isdefined( revivee ) )
    {
        return;
    }
    
    if ( revivee common::function_8ff835bf23198a0( "revivedBuffSpeedScalar" ) )
    {
        revivee common::function_d85a92c557ea5a52( "revivedBuffSpeedScalar" );
        revivee weapons::updatemovespeedscale();
    }
}

