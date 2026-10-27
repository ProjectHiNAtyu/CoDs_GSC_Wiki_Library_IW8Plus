// scripts\mp\killcam_reaction.gsc  (hash_7fbd05e331c8c231.gscc) (size: 898 Bytes / 0x382 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97e947a6 (2548647846)
// size ...... 898 (0x382)
// includes .. 1   (offset: 0x37a)
// strings ... 0   (offset: 0x382)
// dev strs .. 0   (offset: 0x382)
// exports ... 5   (offset: 0x1e6)
// cseg ...... 0x58 + 0x18e (0x1e6)
// imports ... 7   (offset: 0x2ae)
// animtree1 . 0   (offset: 0x382)
// animtree2 . 0   (offset: 0x382)
#using scripts\common\callbacks;

#namespace killcam_reaction;

// Namespace killcam_reaction
// Params 0
// Checksum 0xf3067656, Offset: 0x76
// Size: 0x2c
function init()
{
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_death", &on_player_death );
}

// Namespace killcam_reaction
// Params 1
// Checksum 0x5ceb4db7, Offset: 0xaa
// Size: 0x28
function on_player_connect( params )
{
    self.var_e2daa50d590f8732 = -1;
    self.var_bd549e376e2b3ff2 = 0;
    thread function_c3c9ab69c1cb5885();
}

// Namespace killcam_reaction
// Params 1
// Checksum 0xacf7dc23, Offset: 0xda
// Size: 0x99
function on_player_death( deathdata )
{
    if ( !deathdata )
    {
        return;
    }
    
    victim = deathdata.victim;
    
    if ( !victim || !isplayer( victim ) )
    {
        return;
    }
    
    attacker = deathdata.attacker;
    
    if ( attacker && isplayer( attacker ) && attacker != victim )
    {
        victim.var_e2daa50d590f8732 = attacker getentitynumber();
    }
    else
    {
        victim.var_e2daa50d590f8732 = -1;
    }
    
    victim.var_bd549e376e2b3ff2 = 1;
}

// Namespace killcam_reaction
// Params 0
// Checksum 0x25a5736a, Offset: 0x17b
// Size: 0x6b
function function_c3c9ab69c1cb5885()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_1876fb9368cf7c9", reactionid );
        
        if ( !self.var_bd549e376e2b3ff2 )
        {
            continue;
        }
        
        if ( self.var_e2daa50d590f8732 < 0 )
        {
            continue;
        }
        
        self.var_bd549e376e2b3ff2 = 0;
        self function_14481c5cc24994b0( self.var_e2daa50d590f8732, reactionid );
    }
}

