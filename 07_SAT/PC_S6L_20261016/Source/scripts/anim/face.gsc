// scripts\anim\face.gsc  (hash_4ade3ae5c138c8b3.gscc) (size: 4121 Bytes / 0x1019 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca73241f (3396543519)
// size ...... 4121 (0x1019)
// includes .. 0   (offset: 0xec5)
// strings ... 22  (offset: 0xec5)
// dev strs .. 2   (offset: 0xffd)
// exports ... 9   (offset: 0xb35)
// cseg ...... 0x292 + 0x8a3 (0xb35)
// imports ... 19  (offset: 0xc9d)
// animtree1 . 0   (offset: 0x1019)
// animtree2 . 0   (offset: 0x1019)
#namespace face;

// Namespace face
// Params 1
// Checksum 0xf910ca0d, Offset: 0x2b0
// Size: 0x6e0
function saygenericdialogue( typestring )
{
    if ( self.unittype != "soldier" && self.unittype != "civilian" && self.unittype != "juggernaut" && self.unittype != "suicidebomber" )
    {
        return;
    }
    
    chance = undefined;
    
    switch ( typestring )
    {
        case #"hash_48992ea0e7c59d03":
        case #"hash_69cda088cc03687b":
            importance = 0.5;
            break;
        case #"hash_a36bc9705096e427":
            importance = 0.7;
            chance = 50;
            break;
        case #"hash_c6e9d384b1d615f5":
            importance = 0.9;
            chance = 98;
            break;
        case #"hash_9514bbb63c6ea4a9":
            importance = 0.95;
            break;
        case #"hash_5b2312cf1df3e0a":
        case #"hash_16385fce47a909fa":
        case #"hash_77066905f9ad0542":
        case #"hash_ba7993736731e211":
        case #"hash_c046c4a28eed6ea2":
        case #"hash_e8bc3da4af287c2d":
        case #"hash_f65dca6d4fbde6c6":
            importance = 1;
            break;
        default:
            println( "<dev string:x24>" + typestring );
            importance = 0.3;
            break;
    }
    
    if ( randomint( 100 ) > chance )
    {
        return;
    }
    
    voicenum = undefined;
    prefix = "generic_";
    voicestring = undefined;
    numvoices = undefined;
    var_9d6620ccc56ac65d = 1;
    usenpcid = 0;
    
    if ( isdefined( self.battlechatter ) && isdefined( self.battlechatter.npcid ) )
    {
        switch ( self.battlechatter.npcid )
        {
            case #"hash_c614d6c10a50c4f":
            case #"hash_21618e6c1b52ee5a":
            case #"hash_289af76c1f0f0908":
            case #"hash_3689ba6c261f7001":
            case #"hash_5562686c3699e6a9":
            case #"hash_9009aa6c552a085a":
            case #"hash_ed5cac6c000817dc":
                voicestring = self.battlechatter.npcid;
                prefix = "hero_";
                numvoices = 1;
                break;
        }
    }
    
    if ( self.unittype == "juggernaut" )
    {
        if ( issubstr( self.classname, "_bot" ) )
        {
            voicestring = "guild_robot";
            numvoices = 1;
        }
        else
        {
            voicestring = "juggernaut";
            numvoices = 8;
        }
    }
    
    if ( isdefined( self.battlechatter ) && isdefined( self.battlechatter.charoverride ) )
    {
        switch ( self.battlechatter.charoverride )
        {
            case #"hash_314c719009a9c131":
            case #"hash_502f5154499693e5":
            case #"hash_5d499909b39bdeee":
            case #"hash_5eb7ed9021b5fecf":
            case #"hash_7f671a0f12c4e73f":
            case #"hash_82ea0e6e4f123b62":
            case #"hash_ca51c48a00a0ad55":
                voicestring = self.battlechatter.charoverride;
                prefix = "elite_";
                numvoices = 1;
                var_9d6620ccc56ac65d = 0;
                break;
        }
    }
    else if ( isdefined( self.battlechatter ) && isdefined( self.battlechatter.countryid ) && self.battlechatter.ishero )
    {
        switch ( self.battlechatter.countryid )
        {
            case #"hash_22361c1e33d0024a":
            case #"hash_502f5154499693e5":
            case #"hash_8c15e634aaa3426d":
            case #"hash_9276fc494ccdba52":
            case #"hash_b5228689f5cdff2a":
            case #"hash_c72bae84b209b719":
            case #"hash_d1422e8a0422de05":
                voicestring = self.battlechatter.countryid;
                prefix = "hero_";
                numvoices = 1;
                var_9d6620ccc56ac65d = 0;
                break;
        }
    }
    
    if ( !isdefined( voicestring ) )
    {
        switch ( self.voice )
        {
            case #"sas":
            case #"unitednations":
            case #"unitedstates":
            case #"unitednationshelmet":
            case #"fsa":
                voicestring = "friendly";
                numvoices = anim.numfriendlyvoices;
                break;
            case #"sasfemale":
            case #"fsafemale":
            case #"unitednationsfemale":
            case #"alqatalafemale":
            case #"unitedstatesfemale":
            case #"russianfemale":
                voicestring = "friendly";
                prefix = "woman_";
                numvoices = anim.numfriendlyfemalevoices;
                break;
            case #"c6":
                voicestring = "c6";
                numvoices = 1;
                break;
            case #"guildcradle":
                voicestring = "crdc";
                numvoices = 6;
                usenpcid = 1;
                break;
            case #"Guild":
                voicestring = "enemy";
                numvoices = 6;
                usenpcid = 1;
                break;
            default:
                voicestring = "enemy";
                numvoices = anim.numenemyvoices;
                break;
        }
    }
    
    if ( isdmzgamemode() && isdefined( self.tier ) )
    {
        voicestring = "tier" + self.tier;
        numvoices = 1;
        
        if ( typestring == "death_quiet" )
        {
            typestring = "death";
        }
    }
    
    assert( isdefined( voicestring ) );
    
    if ( usenpcid && isdefined( self.battlechatter.npcid ) )
    {
        voicestring = voicestring + "_" + self.battlechatter.npcid;
    }
    else
    {
        assert( isdefined( numvoices ) );
        voicenum = 1 + self getentitynumber() % numvoices;
        assert( isdefined( voicenum ) );
        voicestring = voicestring + "_" + voicenum;
    }
    
    soundalias = undefined;
    
    if ( !isdefined( soundalias ) )
    {
        if ( isdefined( self.generic_voice_override ) )
        {
            soundalias = self.generic_voice_override + "_" + typestring + "_" + voicestring;
        }
        else
        {
            soundalias = prefix + typestring + "_" + voicestring;
        }
        
        if ( !soundexists( soundalias ) && var_9d6620ccc56ac65d )
        {
            soundalias = "generic_" + typestring + "_" + voicestring;
        }
    }
    
    if ( getdvarint( @"hash_67846a0d7aa3030a", 1 ) )
    {
        println( "<dev string:x47>" + soundalias );
        println( "<dev string:x47>" + soundalias );
    }
    
    thread playfacethread( soundalias, undefined );
}

// Namespace face
// Params 2
// Checksum 0x22cf05c5, Offset: 0x998
// Size: 0x1f
function sayspecificdialogue( soundalias, notifystring )
{
    thread playfacethread( soundalias, notifystring );
}

// Namespace face
// Params 2
// Checksum 0xa46dcdc1, Offset: 0x9bf
// Size: 0x49
function playfacethread( soundalias, notifystring )
{
    if ( isdefined( notifystring ) )
    {
        if ( isdefined( soundalias ) )
        {
            playfacesound( soundalias, "animscript facesound" + notifystring, 1 );
            thread waitforfacesound( notifystring );
        }
        
        return;
    }
    
    playfacesound( soundalias );
}

// Namespace face
// Params 3
// Checksum 0x5d33b608, Offset: 0xa10
// Size: 0x73
function playfacesound( alias, notification, stoppable )
{
    if ( isai( self ) )
    {
        self [[ anim.callbacks[ "PlaySoundAtViewHeight" ] ]]( alias, notification, stoppable );
        return;
    }
    
    if ( isdefined( notification ) && isdefined( stoppable ) )
    {
        self playsound( alias, notification, stoppable );
        return;
    }
    
    if ( isdefined( notification ) )
    {
        self playsound( alias, notification );
        return;
    }
    
    self playsound( alias );
}

// Namespace face
// Params 1
// Checksum 0xbe85e016, Offset: 0xa8b
// Size: 0x29
function waitforfacesound( msg )
{
    self endon( #"death" );
    self waittill( "animscript facesound" + msg );
    self notify( msg );
}

// Namespace face
// Params 0
// Checksum 0x83b42578, Offset: 0xabc
// Size: 0x45
function initlevelface()
{
    if ( getprojectname() == "T10" )
    {
        anim.numenemyvoices = 4;
    }
    else
    {
        anim.numenemyvoices = 7;
    }
    
    anim.numfriendlyvoices = 7;
    anim.numfriendlyfemalevoices = 3;
    initfacialanims();
}

// Namespace face
// Params 0
// Checksum 0x774022e8, Offset: 0xb09
// Size: 0xc
function initfacialanims()
{
    anim.facial = [];
}

// Namespace face
// Params 1
// Checksum 0x172ab35f, Offset: 0xb1d
// Size: 0x17
function animhasfacialoverride( a_anim )
{
    return animhasnotetrack( a_anim, "facial_override" );
}

