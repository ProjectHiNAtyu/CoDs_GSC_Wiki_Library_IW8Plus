// scripts\mp\damage_range_indicator.gsc  (hash_0dc8e00418efcae7.gscc) (size: 926 Bytes / 0x39e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd040744b (3493885003)
// size ...... 926 (0x39e)
// includes .. 1   (offset: 0x37e)
// strings ... 2   (offset: 0x386)
// dev strs .. 0   (offset: 0x39e)
// exports ... 2   (offset: 0x22e)
// cseg ...... 0x6e + 0x1c0 (0x22e)
// imports ... 9   (offset: 0x27e)
// animtree1 . 0   (offset: 0x39e)
// animtree2 . 0   (offset: 0x39e)
#using scripts\common\trace;

#namespace damage_range_indicator;

// Namespace damage_range_indicator
// Params 0
// Checksum 0x16a57519, Offset: 0x8c
// Size: 0x1a2
function function_f0076932d98e2191()
{
    self endon( #"death" );
    self endon( #"hash_b5fcbc77ee7be0ee" );
    currentpart = #"off";
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( !isdefined( currentweapon ) )
        {
            wait 0.1;
            continue;
        }
        
        weaponranges = function_cc6d8e547793427a( currentweapon );
        start = self geteye();
        tracerange = 99999;
        trace = trace::ray_trace( start, start + anglestoforward( self getgunangles() ) * tracerange );
        
        if ( isdefined( trace[ "entity" ] ) )
        {
            end = trace[ "position" ];
            scriptablepart = #"hash_fb1566ffee5b03e3";
            distance = length( start - end );
            
            if ( distance <= weaponranges[ 0 ] )
            {
                scriptablepart = #"hash_e42819afc9b57459";
            }
            else if ( distance <= weaponranges[ 1 ] )
            {
                scriptablepart = #"hash_5396abfbe9565bea";
            }
            else if ( distance <= weaponranges[ 2 ] )
            {
                scriptablepart = #"hash_f224d2805a96df45";
            }
            else if ( distance <= weaponranges[ 3 ] )
            {
                scriptablepart = #"hash_e31bb4a6aa3639c4";
            }
            
            if ( self isscriptable() && currentpart != scriptablepart )
            {
                self setscriptablepartstate( #"reactive_damage_range", scriptablepart );
                currentpart = scriptablepart;
            }
        }
        else if ( currentpart != #"off" )
        {
            self setscriptablepartstate( #"reactive_damage_range", #"off" );
            currentpart = #"off";
        }
        
        wait 0.1;
    }
}

