// scripts\mp\ftue\utility\ftue_loadout.gsc  (hash_0b5c3028255f05a7.gscc) (size: 978 Bytes / 0x3d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x105a7ca3 (274365603)
// size ...... 978 (0x3d2)
// includes .. 2   (offset: 0x39e)
// strings ... 3   (offset: 0x3ae)
// dev strs .. 0   (offset: 0x3d2)
// exports ... 6   (offset: 0x25a)
// cseg ...... 0x90 + 0x1ca (0x25a)
// imports ... 3   (offset: 0x34a)
// animtree1 . 0   (offset: 0x3d2)
// animtree2 . 0   (offset: 0x3d2)
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\br\gametypes\br_rewards;

#namespace ftue_loadout;

// Namespace ftue_loadout
// Params 3
// Checksum 0x8c5482f0, Offset: 0xae
// Size: 0x42
function function_4e21c3136e045675( player, position, callback )
{
    thread airdrop_loadout_crate::spawnloadoutcrate( player, position, 4 );
    level thread br_rewards::managedropbags();
    
    if ( isdefined( callback ) )
    {
        player thread function_1a91a9ce85fb9904( callback );
    }
}

// Namespace ftue_loadout
// Params 0
// Checksum 0xbdbfbdc3, Offset: 0xf8
// Size: 0xb
function function_70e44dcf20375ded()
{
    return level.br_crates;
}

// Namespace ftue_loadout
// Params 1
// Checksum 0x26b474aa, Offset: 0x10c
// Size: 0x56
function function_c1609cabe21411c7( callback )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "open_loadout_bag" )
        {
            self [[ callback ]]();
            return;
        }
        
        waitframe();
    }
}

// Namespace ftue_loadout
// Params 1
// Checksum 0xfa184e60, Offset: 0x16a
// Size: 0x6f
function function_1d0412b603b07201( callback )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "exit_loadout_bag" )
        {
            self [[ callback ]]( -1 );
            return;
        }
        else if ( channel == "class_select" )
        {
            self [[ callback ]]( class );
            return;
        }
        
        waitframe();
    }
}

// Namespace ftue_loadout
// Params 1
// Checksum 0xb7de35e, Offset: 0x1e1
// Size: 0x79
function function_1a91a9ce85fb9904( callback )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    for ( originalcratecount = level.br_crates.size; originalcratecount == level.br_crates.size ; originalcratecount = level.br_crates.size )
    {
        waitframe();
        
        if ( level.br_crates.size < originalcratecount )
        {
        }
    }
    
    self [[ callback ]]( level.br_crates );
}

