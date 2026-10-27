// script_1f417595acc2636f  (hash_1f417595acc2636f.gscc) (size: 1819 Bytes / 0x71b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98147813 (2551478291)
// size ...... 1819 (0x71b)
// includes .. 4   (offset: 0x6af)
// strings ... 5   (offset: 0x6cf)
// dev strs .. 0   (offset: 0x71b)
// exports ... 7   (offset: 0x363)
// cseg ...... 0xdb + 0x288 (0x363)
// imports ... 20  (offset: 0x47b)
// animtree1 . 0   (offset: 0x71b)
// animtree2 . 0   (offset: 0x71b)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\perks\perks;
#using scripts\mp\playerhealth;

#namespace specialty_reduce_regen_delay_on_kill;

// Namespace specialty_reduce_regen_delay_on_kill
// Params 0, eflags: 0x1
// Checksum 0x874b7427, Offset: 0xf9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_17ca4be6f69e8939 );
}

// Namespace specialty_reduce_regen_delay_on_kill
// Params 1
// Checksum 0x300c5fb, Offset: 0x119
// Size: 0x3b
function function_17ca4be6f69e8939( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reduce_regen_delay_on_kill", &setreduceregendelayonkill, undefined, [], &initspecialty );
    }
}

// Namespace specialty_reduce_regen_delay_on_kill
// Params 0
// Checksum 0x23195a49, Offset: 0x15c
// Size: 0x20
function initspecialty()
{
    utility::registersharedfunc( #"specialty_reduce_regen_delay_on_kill", #"reduceregendelayonkill", &regendelayreduce_onkill );
}

// Namespace specialty_reduce_regen_delay_on_kill
// Params 0
// Checksum 0x75a6ab6f, Offset: 0x184
// Size: 0x4a
function setreduceregendelayonkill()
{
    self.var_86f80b7f1c5ff36e = self.var_9842326056fd7207.var_4a220aeb9875587 ?? 1;
    perks::function_70e4256c5fb41ada( "specialty_reduce_regen_delay_on_kill" );
    
    if ( self.lastgunkilltime == gettime() )
    {
        regendelayreduce_onkill();
    }
}

// Namespace specialty_reduce_regen_delay_on_kill
// Params 0
// Checksum 0x662b9f87, Offset: 0x1d6
// Size: 0x115
function regendelayreduce_onkill()
{
    var_f58b83e445f53d6f = utility::function_2a082dafe6f4bd5b();
    usingnvgs = self isnightvisionon();
    var_c6a607bf90f35dc8 = var_f58b83e445f53d6f && usingnvgs;
    fx = var_c6a607bf90f35dc8 ? utility::getfx( "super_sprint_refresh_night" ) : utility::getfx( "super_sprint_refresh" );
    playfxontagforclients( fx, self, "tag_eye", self );
    
    if ( self.health < 100 )
    {
        if ( isdefined( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_kill" ] ) )
        {
            if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" && !perks::function_387a7a1ee90cd5bd( "specialty_combat_medic" ) )
            {
                perks::function_ef056eae4d523635( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_kill" ], 1 );
            }
            else if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"center" )
            {
                perks::activateperk( self.var_773b81cf576594e5[ "specialty_reduce_regen_delay_on_kill" ] );
            }
        }
    }
    
    thread regendelayreduce_delayedregen();
}

// Namespace specialty_reduce_regen_delay_on_kill
// Params 0
// Checksum 0x30247f44, Offset: 0x2f3
// Size: 0x70
function regendelayreduce_delayedregen()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"hash_ac4cab938c10995f" );
    self endon( #"hash_ac4cab938c10995f" );
    self notify( #"hash_c4700f9ace6b3e19" );
    
    if ( isbrgamemode() )
    {
        playerhealth::forcehealthregen( self, 1, 1 );
        return;
    }
    
    playerhealth::function_fd91e6d94cab77e7( #"hash_ac4cab938c10995f", self.var_86f80b7f1c5ff36e, 500 );
}

