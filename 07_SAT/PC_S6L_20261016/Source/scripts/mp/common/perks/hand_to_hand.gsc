// scripts\mp\common\perks\hand_to_hand.gsc  (hash_3365db7a0084c2ed.gscc) (size: 2134 Bytes / 0x856 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3734cb25 (926206757)
// size ...... 2134 (0x856)
// includes .. 3   (offset: 0x7f2)
// strings ... 5   (offset: 0x80a)
// dev strs .. 0   (offset: 0x856)
// exports ... 10  (offset: 0x4b6)
// cseg ...... 0xab + 0x40b (0x4b6)
// imports ... 15  (offset: 0x646)
// animtree1 . 0   (offset: 0x856)
// animtree2 . 0   (offset: 0x856)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\playerhealth;

#namespace hand_to_hand;

// Namespace hand_to_hand
// Params 0, eflags: 0x1
// Checksum 0x7b144f16, Offset: 0xc9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_712a64a2016b7eaa );
}

// Namespace hand_to_hand
// Params 1
// Checksum 0xfb958462, Offset: 0xe9
// Size: 0x77
function function_712a64a2016b7eaa( params )
{
    bundle = level.perkbundles[ "specialty_hand_to_hand" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hand_to_hand", &sethandtohand, &unsethandtohand, undefined, &inithandtohand );
    }
    
    callback::add( #"hash_6a8a551945faab9", &function_5b96bda9101c3941 );
}

// Namespace hand_to_hand
// Params 0
// Checksum 0x2d3c8ff3, Offset: 0x168
// Size: 0x17
function inithandtohand()
{
    callback::add( #"player_death", &handtohandonkill );
}

// Namespace hand_to_hand
// Params 0
// Checksum 0xba2cab4, Offset: 0x187
// Size: 0xd
function sethandtohand()
{
    self.var_ab4d7cd5a6a3ee1b = 1;
}

// Namespace hand_to_hand
// Params 0
// Checksum 0xa1983165, Offset: 0x19c
// Size: 0xc
function unsethandtohand()
{
    self.var_ab4d7cd5a6a3ee1b = undefined;
}

// Namespace hand_to_hand
// Params 1
// Checksum 0x4342eaaa, Offset: 0x1b0
// Size: 0x2f
function handtohandonkill( deathdata )
{
    if ( !deathdata.attacker.var_ab4d7cd5a6a3ee1b )
    {
        return;
    }
    
    function_a567900bd87dc30e( deathdata );
}

// Namespace hand_to_hand
// Params 1, eflags: 0x4
// Checksum 0xe0918594, Offset: 0x1e7
// Size: 0x190
function private function_a567900bd87dc30e( deathdata )
{
    attacker = deathdata.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = deathdata.victim;
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    if ( victim == attacker )
    {
        return;
    }
    
    ismeleekill = deathdata.meansofdeath === "MOD_MELEE";
    var_e2279129d3144144 = deathdata.meansofdeath === "MOD_EXECUTION";
    var_89a54915eae3f274 = deathdata.meansofdeath === "MOD_MEATSHIELD";
    var_db7a13eedede38ef = ismeleekill || var_e2279129d3144144 || var_89a54915eae3f274;
    
    if ( !var_db7a13eedede38ef )
    {
        var_db7a13eedede38ef = istrue( deathdata.inflictor.bundle.var_edee58adb6e07c4f );
    }
    
    if ( !var_db7a13eedede38ef )
    {
        return;
    }
    
    bundle = level.perkbundles[ "specialty_hand_to_hand" ];
    
    if ( ismeleekill && !bundle.var_c77bbf515b649026 && !deathdata.objweapon.ismelee )
    {
        return;
    }
    
    if ( isxhash( bundle.var_d1a12be7d311c2b7 ) )
    {
        var_dbd43a8b925f566f = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
        
        if ( isdefined( var_dbd43a8b925f566f ) )
        {
            attacker thread [[ var_dbd43a8b925f566f ]]( bundle.var_d1a12be7d311c2b7 );
        }
    }
    
    attacker thread function_7b318b509ba9c0a7();
}

// Namespace hand_to_hand
// Params 0
// Checksum 0xa7d38ec7, Offset: 0x37f
// Size: 0xa9
function function_7b318b509ba9c0a7()
{
    self notify( #"hand_to_hand_buff" );
    self endon( #"hand_to_hand_buff" );
    self.var_2c28af7805c1ac38 = 1;
    bundle = level.perkbundles[ "specialty_hand_to_hand" ];
    playerhealth::function_fd91e6d94cab77e7( #"handtohand_regendelay", bundle.var_817edf22d8121745 ?? 0 );
    result = utility::waittill_notify_or_timeout_return( "death", bundle.var_68f9448610af10da );
    playerhealth::function_b1fb4d148779580e( #"handtohand_regendelay" );
    self.var_2c28af7805c1ac38 = undefined;
    self notify( #"hand_to_hand_expired" );
}

// Namespace hand_to_hand
// Params 1
// Checksum 0x3104674c, Offset: 0x430
// Size: 0x86
function function_5b96bda9101c3941( params )
{
    if ( !self.var_63490a14ef1618a3 && !self.var_7d107b7503b87ff5 && self.var_2c28af7805c1ac38 )
    {
        bundle = level.perkbundles[ "specialty_hand_to_hand" ];
        handtohandscalar = bundle.var_132c2b0ed28e4542 ?? 1.5;
        params.var_2b32a8de075bfd54 *= handtohandscalar;
    }
}

