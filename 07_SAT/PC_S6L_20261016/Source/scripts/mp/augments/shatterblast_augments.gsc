// scripts\mp\augments\shatterblast_augments.gsc  (hash_39f1cf2fa4014d8b.gscc) (size: 2706 Bytes / 0xa92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ca874db (2091414747)
// size ...... 2706 (0xa92)
// includes .. 5   (offset: 0xa22)
// strings ... 6   (offset: 0xa4a)
// dev strs .. 0   (offset: 0xa92)
// exports ... 8   (offset: 0x656)
// cseg ...... 0xee + 0x568 (0x656)
// imports ... 22  (offset: 0x796)
// animtree1 . 0   (offset: 0xa92)
// animtree2 . 0   (offset: 0xa92)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\shatterblast;
#using scripts\mp\armor;

#namespace shatterblast_augments;

// Namespace shatterblast_augments
// Params 0, eflags: 0x5
// Checksum 0x2f6c6e58, Offset: 0x10c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"shatterblast_augments", undefined, &init_shatterblast_augments, undefined );
}

// Namespace shatterblast_augments
// Params 0
// Checksum 0x8cb874eb, Offset: 0x12d
// Size: 0x58
function init_shatterblast_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level thread function_ed497c200b3535f1();
    callback::add( "shatterblast_destroyed_armor", &function_c34d1e5814553929 );
    callback::add( "shatterblast_begin_blast_shield", &shatterblast_begin_blast_shield );
    utility::registersharedfunc( #"shatterblast", #"hash_4086acd0fbc92388", &function_9d29217e182429e1 );
}

// Namespace shatterblast_augments
// Params 0
// Checksum 0x36e24e64, Offset: 0x18d
// Size: 0x26
function function_ed497c200b3535f1()
{
    level endon( #"game_ended" );
    utility::flag_wait( "shatterblast_ready" );
    shatterblast::register_shatterblast_result_func( &function_9d29217e182429e1 );
}

// Namespace shatterblast_augments
// Params 9
// Checksum 0xc36c3214, Offset: 0x1bb
// Size: 0xe0
function function_9d29217e182429e1( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_11e304524b039190 = 0, var_9f3ca9dcada2e0ef = 0 )
{
    level endon( #"game_ended" );
    
    if ( isplayer( attacker ) && ( var_11e304524b039190 || attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_chain" ) ) )
    {
        thread function_b0b1cee35b62c0df( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker.var_72df153bbe9683e7 = 0;
    }
    
    shatterblast::function_2160cd1e98996a4f( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef );
}

// Namespace shatterblast_augments
// Params 8
// Checksum 0x91b1063b, Offset: 0x2a3
// Size: 0x1f5
function function_b0b1cee35b62c0df( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef = 0 )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    attacker endon( #"death_or_disconnect" );
    count = 0;
    totalexplosions = level.zombie_augments[ #"shatterblast_blast_chain" ].var_192518d909e3d07 ?? 3;
    radius = level.var_b7d9d7926154819d.ammomodbundles[ "shatterblast" ].var_d208127147eabcce ?? 128;
    original_radius = radius;
    origin = vpoint;
    
    if ( isdefined( self.origin ) )
    {
        origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 48 );
    }
    
    waittime = level.zombie_augments[ #"shatterblast_blast_chain" ].var_f51cc1dec98e18f6 ?? 1;
    randomwaittime = randomfloatrange( waittime - 0.5, waittime + 0.5 );
    wait randomwaittime;
    
    if ( isplayer( attacker ) )
    {
        while ( count < totalexplosions )
        {
            if ( isplayer( attacker ) )
            {
                damagecenter = utility::function_8ae0ea62537eafc5( origin, original_radius );
                damagecenter = ( damagecenter[ 0 ], damagecenter[ 1 ], origin[ 2 ] );
                count++;
                playfx( utility::getfx( "shatterblast_explosion_effect" ), damagecenter );
                attacker shatterblast::shatterblast_explosion( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef, damagecenter );
            }
            else
            {
                return;
            }
            
            randomwaittime = randomfloatrange( waittime - 0.5, waittime + 0.5 );
            wait waittime;
        }
    }
}

// Namespace shatterblast_augments
// Params 1
// Checksum 0xf4971d7d, Offset: 0x4a0
// Size: 0x74
function shatterblast_begin_blast_shield( sparams )
{
    duration = level.zombie_augments[ #"shatterblast_blast_shield" ].var_54800d43dcb7182e;
    self.var_bd752fd42b2e2193[ #"shatterblast_blast_shield" ] = 1;
    thread utility::callsharedfunc( #"zombie", #"hash_d654f8d8c48840f", duration, #"shatterblast_blast_shield", "b_shield" );
}

// Namespace shatterblast_augments
// Params 1
// Checksum 0xc00f885, Offset: 0x51c
// Size: 0x13a
function function_c34d1e5814553929( sparams )
{
    if ( sparams.var_9f3ca9dcada2e0ef )
    {
        return;
    }
    
    if ( isplayer( sparams.eattacker ) && sparams.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_repair" ) )
    {
        sparams.eattacker.var_72df153bbe9683e7++;
        var_b5c8109adb37c9d4 = level.zombie_augments[ #"shatterblast_blast_repair" ].var_3237d29efaf14e76 ?? 25;
        repair_cap = level.zombie_augments[ #"shatterblast_blast_repair" ].var_9ed3fa79eb45aece ?? 150;
        
        if ( sparams.eattacker.var_72df153bbe9683e7 * var_b5c8109adb37c9d4 <= repair_cap )
        {
            newarmorhealth = sparams.eattacker.armorhealth + var_b5c8109adb37c9d4;
            sparams.eattacker armor::setarmorhealth( newarmorhealth );
            sparams.eattacker playlocalsound( #"hash_747daaa054e58e48" );
        }
    }
}

