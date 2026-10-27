// scripts\mp\gametypes\skydive_protection.gsc  (hash_4527cde5bd93f84d.gscc) (size: 5280 Bytes / 0x14a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37bdaa3a (935176762)
// size ...... 5280 (0x14a0)
// includes .. 4   (offset: 0x134c)
// strings ... 6   (offset: 0x136c)
// dev strs .. 19  (offset: 0x13b8)
// exports ... 14  (offset: 0xce4)
// cseg ...... 0x12e + 0xbb6 (0xce4)
// imports ... 36  (offset: 0xf14)
// animtree1 . 0   (offset: 0x14a0)
// animtree2 . 0   (offset: 0x14a0)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\damage;

#namespace skydive_protection;

// Namespace skydive_protection
// Params 1
// Checksum 0x6ec94bfa, Offset: 0x14c
// Size: 0x160
function init( var_b6b206c81aa2ba8e )
{
    level.modifyplayerdamage = &skydive_modifyplayerdamage;
    level.var_639691b3e96bd582 = var_b6b206c81aa2ba8e;
    level.skydive_spawnprotectionactive = getdvarint( @"hash_8dcdf86e1a8c0268", 1 ) == 1;
    level.var_3824f7757e4b01fe = getdvarint( @"scr_skydivespawnprotectiontimeoutenabled", 1 );
    level.var_33df8bd17207546d = getdvarfloat( @"scr_skydivespawnprotectiontimeoutduration", 2.5 );
    level.skydive_spawnprotectionmodifier = getdvarfloat( @"hash_9b573a0d1aa67773", 0.2 );
    level.var_e670b5c857aa0294 = getdvarfloat( @"hash_2d766a7032695e80", 0.1 );
    level.var_29b5b07e1886896a = getdvarint( @"scr_skydivespawnprotectionscaleheighttop", 2500 );
    level.var_9beae5d32a1d355c = getdvarint( @"scr_skydivespawnprotectionscaleheightbottom", 750 );
    level.var_b2785db7215a6ece = getdvarfloat( @"hash_14eaf6cedd5cb4a", 0.25 );
    level.var_38aad4fcdbe56b0 = getdvarfloat( @"hash_7f2806a81cfae7bc", 0.25 );
    level.var_b5cf138f8c728743 = getdvarfloat( @"scr_skydivespawnprotectionsafetydistance", 750 );
    level.var_455fc42f581a78d3 = level.var_b5cf138f8c728743 * level.var_b5cf138f8c728743;
    
    /#
        level.skydive_spawnprotectiondebug = getdvarint( @"hash_7701e71825a6380a", 0 );
    #/
}

// Namespace skydive_protection
// Params 2
// Checksum 0xc5e24526, Offset: 0x2b4
// Size: 0x76
function initprotection( var_5f342217b4072c, var_69fd22f9e720e316 )
{
    if ( !level.skydive_spawnprotectionactive )
    {
        return;
    }
    
    thread function_2d837eae79874018();
    thread function_9f3ac50274a26206();
    thread function_4cc5924c67173beb( var_5f342217b4072c );
    thread function_6e9720a5b3f7a9de( var_5f342217b4072c, var_69fd22f9e720e316 );
    thread function_4c9649fb460c137e( var_5f342217b4072c );
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            thread function_d0ec5a7518e2e84();
        }
    #/
    
    if ( level.var_3824f7757e4b01fe )
    {
        thread function_5ba087df2ee72196();
    }
}

// Namespace skydive_protection
// Params 1, eflags: 0xc
// Checksum 0xfae03438, Offset: 0x332
// Size: 0xad
function private function_4cc5924c67173beb( var_5f342217b4072c )
{
    self notify( #"hash_9373e0fcf27458c0" );
    self endon( #"hash_9373e0fcf27458c0" );
    self endon( #"death_or_disconnect" );
    self endon( #"skydive_remove_spawn_protection" );
    self.skydive_spawnprotection = 1;
    
    if ( var_5f342217b4072c > 0 )
    {
        wait var_5f342217b4072c;
    }
    
    while ( !function_30aad36f3e478f7() )
    {
        if ( self isonground() || self isswimming() )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            self iprintln( "<dev string:x24>" );
        }
    #/
    
    self.skydive_spawnprotection = undefined;
    self.skydive_spawnprotectionmodifier = undefined;
    self notify( #"skydive_remove_spawn_protection" );
}

// Namespace skydive_protection
// Params 0
// Checksum 0x1ee5bfd7, Offset: 0x3e7
// Size: 0x125, Type: bool
function function_30aad36f3e478f7()
{
    ignoreai = getdvarint( @"scr_skydivespawnprotectionsafetydistanceignoreai", 0 );
    
    foreach ( player in utility::playersnear( self.origin, level.var_b5cf138f8c728743 ) )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.team ) || player.team == self.team )
        {
            continue;
        }
        
        if ( ignoreai && isai( player ) )
        {
            continue;
        }
        
        if ( !player isonground() && !player isswimming() )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, player.origin ) < level.var_455fc42f581a78d3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skydive_protection
// Params 1
// Checksum 0x407c55b1, Offset: 0x515
// Size: 0x86
function function_4c9649fb460c137e( var_5f342217b4072c )
{
    self endon( #"death_or_disconnect" );
    self endon( #"skydive_remove_launcher_protection" );
    self.var_a422b89d7d7aa4f1 = 1;
    
    if ( var_5f342217b4072c > 0 )
    {
        wait var_5f342217b4072c;
    }
    
    while ( true )
    {
        if ( self isonground() || self isswimming() )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            self iprintln( "<dev string:x7e>" );
        }
    #/
    
    self.var_a422b89d7d7aa4f1 = undefined;
    self notify( #"skydive_remove_launcher_protection" );
}

// Namespace skydive_protection
// Params 0
// Checksum 0xbadc40ce, Offset: 0x5a3
// Size: 0x5b
function function_2d837eae79874018()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"perk", #"hash_33213c147fc82a20" );
    utility::waittill_any( "death_or_disconnect", "skydive_remove_launcher_protection", "skydive_remove_spawn_protection" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"perk", #"hash_2a5ab737103ff341" );
}

// Namespace skydive_protection
// Params 0
// Checksum 0x7284b2b9, Offset: 0x606
// Size: 0x6c
function function_9f3ac50274a26206()
{
    self endon( #"death_or_disconnect" );
    self endon( #"skydive_remove_spawn_protection" );
    self.skydive_spawnprotection = 1;
    self waittill( #"weapon_fired" );
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            self iprintln( "<dev string:xcd>" );
        }
    #/
    
    self.skydive_spawnprotection = undefined;
    self.skydive_spawnprotectionmodifier = undefined;
    self notify( #"skydive_remove_spawn_protection" );
}

// Namespace skydive_protection
// Params 0
// Checksum 0xbacfc33f, Offset: 0x67a
// Size: 0x4f
function function_5ba087df2ee72196()
{
    self endon( #"death_or_disconnect" );
    self endon( #"skydive_remove_spawn_protection" );
    self.skydive_spawnprotection = 1;
    wait level.var_33df8bd17207546d;
    self.skydive_spawnprotection = undefined;
    self.skydive_spawnprotectionmodifier = undefined;
    self notify( #"skydive_remove_spawn_protection" );
}

// Namespace skydive_protection
// Params 2, eflags: 0xc
// Checksum 0x10a631ae, Offset: 0x6d1
// Size: 0x18b
function private function_6e9720a5b3f7a9de( var_5f342217b4072c, var_69fd22f9e720e316 )
{
    self notify( #"hash_76aa1b0eeaea8cee" );
    self endon( #"hash_76aa1b0eeaea8cee" );
    self endon( #"death_or_disconnect" );
    self endon( #"skydive_remove_spawn_protection" );
    valuerange = level.var_b2785db7215a6ece - level.var_38aad4fcdbe56b0;
    self.skydive_spawnprotectionmodifier = valuerange + level.var_38aad4fcdbe56b0;
    
    if ( var_5f342217b4072c > 0 )
    {
        wait var_5f342217b4072c;
    }
    
    range = level.var_29b5b07e1886896a - level.var_9beae5d32a1d355c;
    
    if ( isdefined( var_69fd22f9e720e316 ) )
    {
        var_b71bb6197841a7f5 = level.var_29b5b07e1886896a + 100;
        var_d24ad7fcbfed8975 = var_b71bb6197841a7f5;
    }
    
    while ( true )
    {
        if ( var_d24ad7fcbfed8975 >= var_b71bb6197841a7f5 )
        {
            var_d24ad7fcbfed8975 = function_f467b383b084da29( var_b71bb6197841a7f5, var_69fd22f9e720e316 );
            var_47a1e35a3c0da2a3 = 1;
        }
        else
        {
            var_d24ad7fcbfed8975 = function_f467b383b084da29();
            var_47a1e35a3c0da2a3 = 0;
        }
        
        if ( var_d24ad7fcbfed8975 < level.var_9beae5d32a1d355c )
        {
            break;
        }
        
        heightscale = clamp( var_d24ad7fcbfed8975 / range, 0, 1 );
        self.skydive_spawnprotectionmodifier = heightscale * valuerange + level.var_38aad4fcdbe56b0;
        
        if ( var_47a1e35a3c0da2a3 && var_d24ad7fcbfed8975 >= var_b71bb6197841a7f5 )
        {
            wait 0.1;
            continue;
        }
        
        waitframe();
    }
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            self iprintln( "<dev string:x113>" );
        }
    #/
    
    self.skydive_spawnprotection = undefined;
    self.skydive_spawnprotectionmodifier = undefined;
    self notify( #"skydive_remove_spawn_protection" );
}

// Namespace skydive_protection
// Params 1
// Checksum 0x6a999a20, Offset: 0x864
// Size: 0x1b, Type: bool
function function_3be5971dc6b50f2e( objweapon )
{
    return isdefined( objweapon ) && damage::function_b8d8959a0b118c87( objweapon );
}

// Namespace skydive_protection
// Params 11
// Checksum 0x63ec78ad, Offset: 0x888
// Size: 0x23e
function skydive_modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( level.skydive_spawnprotectionactive )
    {
        if ( !function_3be5971dc6b50f2e( objweapon ) )
        {
            if ( smeansofdeath != "MOD_FALLING" && victim.skydive_spawnprotection && isdefined( victim.skydive_spawnprotectionmodifier ) )
            {
                idamage *= victim.skydive_spawnprotectionmodifier;
            }
            
            if ( isdefined( eattacker ) && victim.var_a422b89d7d7aa4f1 )
            {
                switch ( smeansofdeath )
                {
                    case #"hash_3c20f39c73a1422b":
                    case #"hash_66cb246f3e55fbe2":
                    case #"hash_a911a1880d996edb":
                    case #"hash_c22b13f81bed11f0":
                        idamage *= level.var_e670b5c857aa0294;
                        break;
                }
            }
        }
    }
    
    premodifydamage = idamage;
    
    if ( isdefined( level.var_639691b3e96bd582 ) )
    {
        idamage = [[ level.var_639691b3e96bd582 ]]( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 );
    }
    
    /#
        if ( level.skydive_spawnprotectiondebug )
        {
            if ( objweapon.basename != level.laststandweapon && !function_3be5971dc6b50f2e( objweapon ) )
            {
                spawnprotection = istrue( victim.skydive_spawnprotection );
                spawnprotectionmodifier = victim.skydive_spawnprotectionmodifier ?? 0;
                logstring( "<dev string:x16a>" + victim.name + "<dev string:x17f>" + premodifydamage + "<dev string:x191>" + idamage + "<dev string:x19b>" + shitloc + "<dev string:x1a5>" + ( var_cdd29ad5d1362c2 ?? 0 ) + "<dev string:x1b7>" + objweapon.basename + "<dev string:x1c3>" + spawnprotection + "<dev string:x1d5>" + spawnprotectionmodifier + "<dev string:x1ef>" + victim.health + "<dev string:x1f8>" + victim.armorhealth );
            }
        }
    #/
    
    return idamage;
}

// Namespace skydive_protection
// Params 2
// Checksum 0x84e4b4a5, Offset: 0xacf
// Size: 0xc6
function function_f467b383b084da29( var_b71bb6197841a7f5, var_69fd22f9e720e316 )
{
    if ( !isdefined( level.var_c3629765f87d5379 ) )
    {
        level.var_c3629765f87d5379 = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1 );
    }
    
    result = br_public::function_3881e27a5abdb6ff( self.origin, 0, ( var_b71bb6197841a7f5 ?? 100000 ) * -1, level.var_c3629765f87d5379, undefined, var_69fd22f9e720e316 );
    
    if ( isdefined( var_b71bb6197841a7f5 ) && isdefined( var_69fd22f9e720e316 ) )
    {
        if ( result[ "fraction" ] == 0 )
        {
            return var_b71bb6197841a7f5;
        }
        
        return clamp( self.origin[ 2 ] - result[ "position" ][ 2 ], 0, var_b71bb6197841a7f5 );
    }
    
    return self.origin[ 2 ] - result[ "position" ][ 2 ];
}

/#

    // Namespace skydive_protection
    // Params 0, eflags: 0x4
    // Checksum 0x638a581a, Offset: 0xb9e
    // Size: 0x146, Type: dev
    function private function_d0ec5a7518e2e84()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"skydive_remove_launcher_protection" );
        host = self ishost();
        
        while ( true )
        {
            var_d48a17fffb7b7000 = function_f467b383b084da29();
            text = "<dev string:x206>";
            color = ( 1, 0, 0 );
            
            if ( self.skydive_spawnprotection || self.var_a422b89d7d7aa4f1 )
            {
                color = ( 0, 1, 0 );
                text = "<dev string:x214>";
                
                if ( self.skydive_spawnprotection && isdefined( self.skydive_spawnprotectionmodifier ) )
                {
                    text += "<dev string:x221>" + self.skydive_spawnprotectionmodifier + "<dev string:x225>";
                }
                
                if ( self.var_a422b89d7d7aa4f1 )
                {
                    text += "<dev string:x22a>" + level.var_e670b5c857aa0294 + "<dev string:x225>";
                }
                
                text += var_d48a17fffb7b7000;
            }
            
            if ( host )
            {
                printtoscreen2d( 500, 500, text, color, 1, 1 );
            }
            else
            {
                print3d( self.origin + ( 0, 0, 100 ), text, color, 1, 0.75, 1, 1 );
            }
            
            waitframe();
        }
    }

#/
