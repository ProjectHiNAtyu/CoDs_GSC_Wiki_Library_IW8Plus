// script_1c6358679ee73bff  (hash_1c6358679ee73bff.gscc) (size: 3257 Bytes / 0xcb9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a5cd0dc (1516032220)
// size ...... 3257 (0xcb9)
// includes .. 5   (offset: 0xc55)
// strings ... 5   (offset: 0xc7d)
// dev strs .. 0   (offset: 0xcb9)
// exports ... 11  (offset: 0x6f1)
// cseg ...... 0xc4 + 0x62d (0x6f1)
// imports ... 32  (offset: 0x8a9)
// animtree1 . 0   (offset: 0xcb9)
// animtree2 . 0   (offset: 0xcb9)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\mp\emp_debuff;

#namespace namespace_ff35ee0212f06c9d;

// Namespace namespace_ff35ee0212f06c9d
// Params 0, eflags: 0x1
// Checksum 0xd7404db4, Offset: 0xe2
// Size: 0x17
function autoexec init()
{
    callback::add( #"player_spawned", &targetfinder_onplayerspawned );
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0
// Checksum 0x21b26d9f, Offset: 0x101
// Size: 0x12, Type: bool
function targetfinder_hasperk()
{
    return isdefined( self.perks[ "specialty_targetfinder" ] );
}

// Namespace namespace_ff35ee0212f06c9d
// Params 1
// Checksum 0xf48b4639, Offset: 0x11c
// Size: 0x29
function targetfinder_onplayerspawned( params )
{
    level.var_51b3db7be0baa336 = gettime();
    
    if ( isbot( self ) )
    {
        return;
    }
    
    thread function_3a18c4aec57acd35();
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0
// Checksum 0xb177c41e, Offset: 0x14d
// Size: 0x2e
function function_3a18c4aec57acd35()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        childthread function_763826fbf39178ec();
        utility::waittill_any( "weapon_change", "giveLoadout" );
    }
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0, eflags: 0xc
// Checksum 0xd13fcf28, Offset: 0x183
// Size: 0x4d
function private function_763826fbf39178ec()
{
    self notify( #"hash_b11523c35b9277a9" );
    self endon( #"hash_b11523c35b9277a9" );
    wait 0.1;
    
    if ( targetfinder_hasperk() )
    {
        function_90cb27dc92b723e1();
        thread function_918b16f87540980e();
        return;
    }
    
    function_a69af933f97d83c9();
    self notify( #"hash_bd743a1afbb3c7bb" );
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0, eflags: 0x4
// Checksum 0x12a3e685, Offset: 0x1d8
// Size: 0x60
function private function_90cb27dc92b723e1()
{
    if ( isdefined( self.scopetargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( self.scopetargetmarkergroup ) )
    {
        targetmarkergroups::function_fb26696556bb5e3d( self.scopetargetmarkergroup );
        return;
    }
    
    var_12756e16f03f4f4e = [];
    self.scopetargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"hash_1fdcbd8ca4e842ab", self, var_12756e16f03f4f4e, self, 0, 0, 1 );
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0, eflags: 0x4
// Checksum 0x150d4a1, Offset: 0x240
// Size: 0x3f
function private function_a69af933f97d83c9()
{
    if ( !isdefined( self.scopetargetmarkergroup ) || !targetmarkergroups::targetmarkergroupexists( self.scopetargetmarkergroup ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::targetmarkergroup_offsharedfunc( self.scopetargetmarkergroup );
    self.scopetargetmarkergroup = undefined;
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0
// Checksum 0x9bc18818, Offset: 0x287
// Size: 0x2b, Type: bool
function function_237a731d5dfb6ee2()
{
    return self playerads() >= 0.75 && !emp_debuff::is_empd() && !self function_25af1328b3e8da54( self.currentweapon );
}

// Namespace namespace_ff35ee0212f06c9d
// Params 3, eflags: 0x4
// Checksum 0x210a7a52, Offset: 0x2bb
// Size: 0x43, Type: bool
function private function_839d7f0bc0ee450a( eyepos, eyeangles, enemypos )
{
    if ( withinfov( eyepos, eyeangles, enemypos, 0.992546 ) && distancesquared( eyepos, enemypos ) < 3873024 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_ff35ee0212f06c9d
// Params 0
// Checksum 0x5e3fac10, Offset: 0x307
// Size: 0x3ea
function function_918b16f87540980e()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bd743a1afbb3c7bb" );
    
    if ( !isdefined( self.scopetargetmarkergroup ) || !targetmarkergroups::targetmarkergroupexists( self.scopetargetmarkergroup ) )
    {
        return;
    }
    
    enemies = [];
    markedenemies = [];
    var_4cb234fca68fbcfa = -1;
    
    while ( true )
    {
        while ( function_237a731d5dfb6ee2() )
        {
            eyepos = self getvieworigin();
            eyeangles = self getgunangles();
            
            if ( var_4cb234fca68fbcfa < level.var_51b3db7be0baa336 || var_4cb234fca68fbcfa < level.var_31086716d15138bb )
            {
                while ( gettime() == level.var_51b3db7be0baa336 )
                {
                    waitframe();
                }
                
                previous_enemies = arraycopy( enemies );
                enemies = [];
                
                foreach ( p in level.players )
                {
                    if ( self.team != p.team )
                    {
                        if ( isdefined( p.perks[ "specialty_noscopeoutline" ] ) || isdefined( p.perks[ "specialty_blindeye" ] ) )
                        {
                            continue;
                        }
                        
                        enemies[ enemies.size ] = p;
                    }
                }
                
                var_33502ff8d532713 = arrayremove( previous_enemies, enemies );
                
                if ( var_33502ff8d532713.size > 0 )
                {
                    foreach ( p in var_33502ff8d532713 )
                    {
                        if ( markedenemies[ p.entnum ?? utility::get_entity_number( p ) ] )
                        {
                            markedenemies[ p.entnum ] = undefined;
                            targetmarkergroups::targetmarkergroup_unmarkentity( p, self.scopetargetmarkergroup );
                        }
                    }
                }
                
                var_4cb234fca68fbcfa = gettime();
            }
            
            if ( level.gametypebundle.var_446b8fdac052ecb7 && utility::issharedfuncdefined( #"targetfinder", #"hash_d2ecc9c85468418f" ) )
            {
                enemies = utility::callsharedfunc( #"targetfinder", #"hash_d2ecc9c85468418f", enemies, markedenemies );
            }
            
            foreach ( p in enemies )
            {
                if ( !isdefined( p ) )
                {
                    continue;
                }
                
                centroid = p getcentroid();
                shouldmark = withinfov( eyepos, eyeangles, centroid, 0.992546 ) && distancesquared( eyepos, centroid ) < 3873024;
                ismarking = markedenemies[ p.entnum ?? utility::get_entity_number( p ) ];
                
                if ( shouldmark )
                {
                    if ( !ismarking )
                    {
                        markedenemies[ p.entnum ] = p;
                        targetmarkergroups::targetmarkergroup_markentity( p, self.scopetargetmarkergroup, 1 );
                        var_ac2057b42090c19e = 1;
                    }
                    
                    continue;
                }
                
                if ( ismarking )
                {
                    markedenemies[ p.entnum ] = undefined;
                    targetmarkergroups::targetmarkergroup_unmarkentity( p, self.scopetargetmarkergroup );
                }
            }
            
            wait 0.048;
        }
        
        if ( var_ac2057b42090c19e )
        {
            markedenemies = [];
            var_ac2057b42090c19e = 0;
            targetmarkergroups::function_fb26696556bb5e3d( self.scopetargetmarkergroup );
        }
        
        wait 0.1;
    }
}

