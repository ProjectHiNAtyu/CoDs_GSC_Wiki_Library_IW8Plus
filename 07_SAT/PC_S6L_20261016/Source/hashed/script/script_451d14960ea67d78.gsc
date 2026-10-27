// script_451d14960ea67d78  (hash_451d14960ea67d78.gscc) (size: 2483 Bytes / 0x9b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4bbe2fc (4105954044)
// size ...... 2483 (0x9b3)
// includes .. 1   (offset: 0x99f)
// strings ... 1   (offset: 0x9a7)
// dev strs .. 0   (offset: 0x9b3)
// exports ... 10  (offset: 0x66f)
// cseg ...... 0x60 + 0x60f (0x66f)
// imports ... 14  (offset: 0x7ff)
// animtree1 . 0   (offset: 0x9b3)
// animtree2 . 0   (offset: 0x9b3)
#using scripts\mp\common\killstreaks\killstreaks;

#namespace namespace_48301ef448d5ebec;

// Namespace namespace_48301ef448d5ebec
// Params 1
// Checksum 0xe1875c08, Offset: 0x7e
// Size: 0xa9
function killstreakdawg_init( taskid )
{
    profilestart();
    clear();
    
    if ( !hasdawg() )
    {
        profilestop();
        return anim.failure;
    }
    
    self.var_c8d50b6b9dff4afd = { #var_462eb822e04261c2:0, #var_285b5c853f99808e:gettime() };
    score = self._blackboard.var_494f3828f7e60cb;
    threshold = level.var_d4909c0acc55763c.var_f85906b0c2ac3122;
    
    if ( score < threshold )
    {
        profilestop();
        return anim.failure;
    }
    
    usedawg();
    profilestop();
    return anim.success;
}

// Namespace namespace_48301ef448d5ebec
// Params 1
// Checksum 0x615f11e6, Offset: 0x131
// Size: 0xda
function killstreakdawg_update( taskid )
{
    profilestart();
    istimeout = gettime() - self.var_c8d50b6b9dff4afd.var_285b5c853f99808e > 3000;
    
    if ( istimeout )
    {
        self._blackboard.var_4648fba0a58fbff0 = 4;
        profilestop();
        return anim.failure;
    }
    
    if ( !isdefined( self.var_c8d50b6b9dff4afd.deployresult ) )
    {
        profilestop();
        return anim.running;
    }
    
    if ( self.var_c8d50b6b9dff4afd.deployresult )
    {
        self._blackboard.var_4648fba0a58fbff0 = 1;
        profilestop();
        return anim.success;
    }
    else
    {
        self._blackboard.var_4648fba0a58fbff0 = 2;
        profilestop();
        return anim.failure;
    }
    
    profilestop();
}

// Namespace namespace_48301ef448d5ebec
// Params 1
// Checksum 0xa17d468b, Offset: 0x213
// Size: 0x7d
function killstreakdawg_terminate( taskid )
{
    profilestart();
    self notify( #"hash_a5c9bbd5a0d37b21" );
    self._blackboard.var_9f322ac54fb17be4 = 0;
    
    if ( self.var_c8d50b6b9dff4afd && self._blackboard.var_4648fba0a58fbff0 != 1 )
    {
        self.var_c8d50b6b9dff4afd.var_462eb822e04261c2 = gettime();
        thread killstreakdawg_retrythread();
    }
    
    profilestop();
    return anim.success;
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0xc
// Checksum 0x104138b1, Offset: 0x29a
// Size: 0xe2
function private killstreakdawg_retrythread()
{
    self notify( #"hash_886afc365c00c3a4" );
    self endon( #"hash_886afc365c00c3a4" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"killstreakdawg_retrythread" );
    threshold = level.var_d4909c0acc55763c.var_f85906b0c2ac3122;
    
    while ( hasdawg() )
    {
        if ( self.var_c8d50b6b9dff4afd.var_462eb822e04261c2 > 0 && gettime() - self.var_c8d50b6b9dff4afd.var_462eb822e04261c2 >= 3000 && self._blackboard.var_494f3828f7e60cb >= threshold && canusedawg() )
        {
            self._blackboard.var_7d1197a09a48b06b = 1;
            return;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0xc
// Checksum 0x81b043fa, Offset: 0x384
// Size: 0x1b3
function private function_c9772a96d7e565cc()
{
    self notify( #"hash_9938056b406208e7" );
    self endon( #"hash_9938056b406208e7" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a5c9bbd5a0d37b21" );
    const_pitch_min = 10;
    const_pitch_max = 30;
    var_5dcd37deb66bc6d3 = 90;
    var_b063363857801a8a = 10;
    var_8213592a9a265920 = 360 / var_5dcd37deb66bc6d3;
    var_99797bff39d27387 = ( const_pitch_max - const_pitch_min ) / var_b063363857801a8a + 1;
    
    while ( gettime() - self.var_c8d50b6b9dff4afd.var_285b5c853f99808e <= 3000 )
    {
        angles = self getplayerangles();
        var_6f2bb28c32422ec1 = angles[ 1 ];
        
        for ( yawindex = 0; yawindex < var_8213592a9a265920 ; yawindex++ )
        {
            yaw = var_6f2bb28c32422ec1 + yawindex * var_5dcd37deb66bc6d3;
            currentangles = self getplayerangles();
            pitch = clamp( currentangles[ 0 ], const_pitch_min, const_pitch_max );
            pitchsign = pitch < const_pitch_max ? 1 : -1;
            
            for ( pitchindex = 0; pitchindex < var_99797bff39d27387 ; pitchindex++ )
            {
                pitch += var_b063363857801a8a * pitchsign;
                self setplayerangles( ( pitch, yaw, angles[ 2 ] ) );
                wait 0.25;
                
                if ( self.var_c8d50b6b9dff4afd.var_ef727c3ceab7d1d6 )
                {
                    self notify( #"weapon_fired", self.var_c8d50b6b9dff4afd.weaponobj );
                    return;
                }
                
                if ( pitch < const_pitch_min || pitch > const_pitch_max )
                {
                    break;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0x4
// Checksum 0x84c8f479, Offset: 0x53f
// Size: 0x2b
function private canusedawg()
{
    slotnumber = 1;
    streakitem = killstreaks::getkillstreakinslot( slotnumber );
    return killstreaks::cantriggerkillstreak( streakitem, slotnumber );
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0x4
// Checksum 0x6bd5e019, Offset: 0x573
// Size: 0x54
function private usedawg()
{
    self.var_c8d50b6b9dff4afd.var_462eb822e04261c2 = 0;
    self._blackboard.var_9f322ac54fb17be4 = 1;
    self._blackboard.var_4648fba0a58fbff0 = 3;
    thread killstreaks::dokillstreakaction( undefined, 1 );
    thread function_c9772a96d7e565cc();
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0x4
// Checksum 0xf7edb615, Offset: 0x5cf
// Size: 0x34, Type: bool
function private hasdawg()
{
    selectedkillstreak = killstreaks::getselectedkillstreak();
    return selectedkillstreak.streakname == "dawg" && selectedkillstreak.available;
}

// Namespace namespace_48301ef448d5ebec
// Params 0, eflags: 0x4
// Checksum 0x116e30a3, Offset: 0x60c
// Size: 0x63
function private clear()
{
    self notify( #"killstreakdawg_retrythread" );
    self notify( #"hash_a5c9bbd5a0d37b21" );
    self._blackboard.var_9f322ac54fb17be4 = 0;
    self._blackboard.var_4648fba0a58fbff0 = 0;
    self._blackboard.var_7d1197a09a48b06b = 0;
    self.var_c8d50b6b9dff4afd = undefined;
}

