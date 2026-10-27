// scripts\common\heartbeat.gsc  (hash_15047af555f1f9a0.gscc) (size: 8460 Bytes / 0x210c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46d0cb47 (1188088647)
// size ...... 8460 (0x210c)
// includes .. 3   (offset: 0x2024)
// strings ... 15  (offset: 0x203c)
// dev strs .. 0   (offset: 0x210c)
// exports ... 28  (offset: 0x159c)
// cseg ...... 0x1ee + 0x13ae (0x159c)
// imports ... 52  (offset: 0x19fc)
// animtree1 . 0   (offset: 0x210c)
// animtree2 . 0   (offset: 0x210c)
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\swim_common;

#namespace heartbeat;

// Namespace heartbeat
// Params 1
// Checksum 0x67fbaae1, Offset: 0x20c
// Size: 0x71
function initcommonheartbeat( playsoundfunc )
{
    level.heartbeat = spawnstruct();
    level.heartbeat.playsoundfunc = playsoundfunc;
    
    if ( isdefined( level.gamemodebundle.heartbeat ) )
    {
        level.heartbeat.bundle = getscriptbundle( level.gamemodebundle.heartbeat );
    }
}

// Namespace heartbeat
// Params 0
// Checksum 0x87e53a9f, Offset: 0x285
// Size: 0x59
function function_a9498ed6ab4895f0()
{
    self.heartbeat = spawnstruct();
    self.heartbeat.pulsetime = 0;
    self.heartbeat.pulsedurationms = 2000;
    self.heartbeat.var_a6f2e47cbb6ef228 = 2000;
    thread heartbeattimer();
}

// Namespace heartbeat
// Params 0
// Checksum 0x5e3cab41, Offset: 0x2e6
// Size: 0x21a
function function_3df8de1db8b0f82d()
{
    return [ [ level.heartbeat.bundle.var_aad7d2b0a3978c20.alias ?? "mvmt_heartbeat_plr_superfast", level.heartbeat.bundle.var_aad7d2b0a3978c20.time ?? 1.3 ], [ level.heartbeat.bundle.var_a191967fe474ad5d.alias ?? "mvmt_heartbeat_plr_fast", level.heartbeat.bundle.var_a191967fe474ad5d.time ?? 1.721 ], [ level.heartbeat.bundle.var_fd11398f46037966.alias ?? "mvmt_heartbeat_plr_med", level.heartbeat.bundle.var_fd11398f46037966.time ?? 1.973 ], [ level.heartbeat.bundle.var_ba123ee366dd1af8.alias ?? "mvmt_heartbeat_plr_slow", level.heartbeat.bundle.var_ba123ee366dd1af8.time ?? 2.321 ], [ level.heartbeat.bundle.var_81d3cbf6bc6b351.alias ?? "mvmt_heartbeat_plr_superslow", level.heartbeat.bundle.var_81d3cbf6bc6b351.time ?? 2.86 ] ];
}

// Namespace heartbeat
// Params 0
// Checksum 0x15e237, Offset: 0x509
// Size: 0x21a
function function_6bb12797eb4f44d1()
{
    return [ [ level.heartbeat.bundle.var_f76d9ba024a0d89.alias ?? "mvmt_heartbeat_plr_superfast", level.heartbeat.bundle.var_f76d9ba024a0d89.time ?? 1.3 ], [ level.heartbeat.bundle.var_af73d1b88436efb2.alias ?? "mvmt_heartbeat_plr_fast", level.heartbeat.bundle.var_af73d1b88436efb2.time ?? 1.721 ], [ level.heartbeat.bundle.var_8bdeab9b87d0be51.alias ?? "mvmt_heartbeat_plr_med", level.heartbeat.bundle.var_8bdeab9b87d0be51.time ?? 1.973 ], [ level.heartbeat.bundle.var_4b14a862c460f337.alias ?? "mvmt_heartbeat_plr_slow", level.heartbeat.bundle.var_4b14a862c460f337.time ?? 2.321 ], [ level.heartbeat.bundle.var_ba8adc086c822e8c.alias ?? "mvmt_heartbeat_plr_superslow", level.heartbeat.bundle.var_ba8adc086c822e8c.time ?? 2.86 ] ];
}

// Namespace heartbeat
// Params 0
// Checksum 0x361a7209, Offset: 0x72c
// Size: 0x21a
function function_b7fd5d39b313b5e7()
{
    return [ [ level.heartbeat.bundle.var_9feaaa64b77a9fae.alias ?? "mvmt_swim_heartbeat_plr_superfast", level.heartbeat.bundle.var_9feaaa64b77a9fae.time ?? 1.3 ], [ level.heartbeat.bundle.var_c57f94c19ac00abf.alias ?? "mvmt_swim_heartbeat_plr_fast", level.heartbeat.bundle.var_c57f94c19ac00abf.time ?? 1.721 ], [ level.heartbeat.bundle.var_b710b63b7e01b538.alias ?? "mvmt_swim_heartbeat_plr_med", level.heartbeat.bundle.var_b710b63b7e01b538.time ?? 1.973 ], [ level.heartbeat.bundle.var_2a4ac2b578230a0e.alias ?? "mvmt_swim_heartbeat_plr_slow", level.heartbeat.bundle.var_2a4ac2b578230a0e.time ?? 2.321 ], [ level.heartbeat.bundle.var_8e59339e060da5eb.alias ?? "mvmt_swim_heartbeat_plr_superslow", level.heartbeat.bundle.var_8e59339e060da5eb.time ?? 2.86 ] ];
}

// Namespace heartbeat
// Params 0
// Checksum 0xea38794a, Offset: 0x94f
// Size: 0x69
function function_f296c98936bc1389()
{
    return [ level.heartbeat.bundle.var_641ce723b55382a1.alias ?? "mvmt_swim_heartbeat_plr_ultrafast", level.heartbeat.bundle.var_641ce723b55382a1.time ?? 0.65 ];
}

// Namespace heartbeat
// Params 0
// Checksum 0x346d159, Offset: 0x9c1
// Size: 0x24, Type: bool
function function_43e47531d549e6a5()
{
    return level.heartbeat.bundle.var_1f8d235e2b1b313e ?? 2;
}

// Namespace heartbeat
// Params 0
// Checksum 0x8236d3ed, Offset: 0x9ee
// Size: 0x171
function heartbeattimer()
{
    self notify( #"heartbeattimer" );
    self endon( #"heartbeattimer" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    waitframe();
    
    while ( true )
    {
        time = gettime();
        var_44fe07dd7d807a4a = function_c47d9b08a7866c2e();
        
        if ( isdefined( var_44fe07dd7d807a4a ) )
        {
            pulsesoundalias = var_44fe07dd7d807a4a[ 0 ];
            childthread function_be749f41dcf386df( pulsesoundalias );
            var_43e47531d549e6a5 = function_43e47531d549e6a5();
            pulsedurationms = var_44fe07dd7d807a4a[ 1 ] * 1000 * 1 / var_43e47531d549e6a5;
            self.heartbeat.pulseduration = pulsedurationms / 1000;
            earlybreak = 0;
            
            while ( var_43e47531d549e6a5 > 0 )
            {
                pulsestarttime = time;
                self.heartbeat notify( #"heartbeat", self.heartbeat.previousintensity );
                
                while ( time < pulsestarttime + pulsedurationms )
                {
                    factorpulsetime( time, pulsestarttime, pulsedurationms );
                    waitframe();
                    time = gettime();
                    earlybreak = function_26118fbe09beb65d( time, pulsestarttime );
                    
                    if ( earlybreak )
                    {
                        break;
                    }
                }
                
                var_43e47531d549e6a5--;
                
                if ( earlybreak )
                {
                    break;
                }
            }
            
            self.heartbeat.var_a6f2e47cbb6ef228 = pulsedurationms;
            continue;
        }
        
        childthread function_fa4746b2319e1ba3();
        self waittill( #"hash_8a4f2396a57e506e" );
    }
}

// Namespace heartbeat
// Params 0
// Checksum 0x3ad2d94e, Offset: 0xb67
// Size: 0x7b
function function_fa4746b2319e1ba3()
{
    if ( !level.projectbundle.var_8bb0c098c608ca9b )
    {
        return;
    }
    
    self endon( #"hash_8a4f2396a57e506e" );
    
    while ( self.heartbeat.previousintensity < 4 )
    {
        wait 1;
        self.heartbeat.previousintensity++;
    }
    
    self.heartbeat.previousintensity = undefined;
    wait 1;
    self notify( #"hash_86d84fd66e110f6f" );
}

// Namespace heartbeat
// Params 2
// Checksum 0x70325143, Offset: 0xbea
// Size: 0x9c, Type: bool
function function_26118fbe09beb65d( currenttime, pulsestarttime )
{
    if ( !level.projectbundle.var_8bb0c098c608ca9b )
    {
        return false;
    }
    
    var_8357f600b95e082d = currenttime - pulsestarttime;
    
    if ( var_8357f600b95e082d > 650 )
    {
        var_c5de6a56223f4f3f = currenttime - self.damage.var_7765940a1ee100f;
        timesincelastdamage = currenttime - self.damage.lastdamagetime;
        
        if ( var_c5de6a56223f4f3f < var_8357f600b95e082d )
        {
            return true;
        }
        
        if ( timesincelastdamage < var_8357f600b95e082d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace heartbeat
// Params 3
// Checksum 0xc7d8fc34, Offset: 0xc8f
// Size: 0x5f
function factorpulsetime( time, pulsestarttime, pulsedurationms )
{
    pulsenormalized = ( time - pulsestarttime ) / pulsedurationms;
    pulsenormalized = math::normalized_offset( pulsenormalized, 0.65 );
    self.heartbeat.pulsetime = 1 - math::normalized_parabola( pulsenormalized );
}

// Namespace heartbeat
// Params 1
// Checksum 0xd570f414, Offset: 0xcf6
// Size: 0x53
function pulse_rumble( pulsedurationms )
{
    if ( swim_common::isbreathcritical() || !function_c37faca28092d9e1() || !damage_effects::isdeathsdoor() )
    {
        return;
    }
    
    pulseduration = pulsedurationms / 1000;
    wait pulseduration * 0.1;
    childthread function_8dc91616e5f2c60( "heartbeatSuperLight" );
}

// Namespace heartbeat
// Params 0
// Checksum 0x68f4d059, Offset: 0xd51
// Size: 0xd, Type: bool
function function_c37faca28092d9e1()
{
    return !isdefined( self.usingremote );
}

// Namespace heartbeat
// Params 1
// Checksum 0xaad37f66, Offset: 0xd67
// Size: 0x2f
function function_8dc91616e5f2c60( heartbeat )
{
    self setscriptablepartstate( "heartbeat", heartbeat );
    wait 0.05;
    self setscriptablepartstate( "heartbeat", "neutral" );
}

// Namespace heartbeat
// Params 0
// Checksum 0x4cb27a0b, Offset: 0xd9e
// Size: 0x1c5
function function_c47d9b08a7866c2e()
{
    deathsdoorindex = function_1543a90769b5206d();
    underwaterindex = function_e0d9d2247bbac15b();
    self.heartbeat.var_bfeaa58c5d1ec905 = deathsdoorindex;
    var_82e5d8ce9afa3476 = [ deathsdoorindex, underwaterindex ];
    lowestindex = undefined;
    
    foreach ( index in var_82e5d8ce9afa3476 )
    {
        if ( isdefined( index ) && ( !isdefined( lowestindex ) || index < lowestindex ) )
        {
            lowestindex = index;
        }
    }
    
    if ( isdefined( lowestindex ) )
    {
        if ( level.projectbundle.var_8bb0c098c608ca9b )
        {
            if ( lowestindex > self.heartbeat.previousintensity )
            {
                lowestindex = self.heartbeat.previousintensity + 1;
            }
        }
        
        if ( swim_common::isplayerunderwater() && swim_common::function_72cf1914334a83de() )
        {
            self.heartbeat.previousintensity = 0;
            return [ "mvmt_swim_heartbeat_plr_ultrafast", 0.65 ];
        }
        
        self.heartbeat.previousintensity = lowestindex;
        
        if ( !swim_common::isplayerunderwater() )
        {
            if ( !damage_effects::function_b1fbb5b747b5663a() || damage_effects::isdeathsdoor() )
            {
                var_23c77a201f62ac58 = function_6bb12797eb4f44d1();
            }
            else
            {
                var_23c77a201f62ac58 = function_3df8de1db8b0f82d();
            }
        }
        else
        {
            var_23c77a201f62ac58 = function_b7fd5d39b313b5e7();
        }
        
        return var_23c77a201f62ac58[ lowestindex ];
    }
}

// Namespace heartbeat
// Params 0
// Checksum 0x2cda846a, Offset: 0xf6b
// Size: 0x40
function function_1543a90769b5206d()
{
    if ( level.gamemodebundle.var_faebbaa9bdf8fa64 )
    {
        return;
    }
    
    if ( level.projectbundle.var_8bb0c098c608ca9b )
    {
        return function_bfb91adaa6eb8566();
    }
    
    return function_ccb83290f7bcfba6();
}

// Namespace heartbeat
// Params 0
// Checksum 0xa7e4e5c2, Offset: 0xfb3
// Size: 0x1ac
function function_bfb91adaa6eb8566()
{
    currenttime = gettime();
    var_c5de6a56223f4f3f = currenttime - self.damage.var_7765940a1ee100f;
    timesincelastdamage = currenttime - self.damage.lastdamagetime;
    
    if ( damage_effects::isdeathsdoor() )
    {
        if ( var_c5de6a56223f4f3f < self.heartbeat.var_a6f2e47cbb6ef228 )
        {
            return 0;
        }
    }
    
    if ( damage_effects::function_b1fbb5b747b5663a() && damage_effects::function_b921453be5b6a831() )
    {
        if ( !isdefined( self.heartbeat.var_bfeaa58c5d1ec905 ) )
        {
            return 0;
        }
    }
    
    if ( !damage_effects::recentdeathsdoor() && !damage_effects::function_724e8a0b2df6c8fa() || !isdefined( self.heartbeat.var_bfeaa58c5d1ec905 ) )
    {
        return;
    }
    
    if ( isfocus() )
    {
        return function_800e5b1aafb5a5a4( 4 );
    }
    
    if ( timesincelastdamage < self.heartbeat.var_a6f2e47cbb6ef228 )
    {
        return 0;
    }
    
    if ( timesincelastdamage < 2300 )
    {
        if ( self.heartbeat.var_bfeaa58c5d1ec905 >= 1 )
        {
            return 1;
        }
    }
    
    if ( function_4f9513538baf7473() )
    {
        return function_e879732b6307927f();
    }
    
    if ( !function_d3d82f561554f7a() )
    {
        return self.heartbeat.var_bfeaa58c5d1ec905;
    }
    
    if ( isdefined( self.var_264be95670df90e3 ) )
    {
        if ( var_c5de6a56223f4f3f < 2500 )
        {
            return 0;
        }
        else if ( var_c5de6a56223f4f3f < 3000 )
        {
            return function_800e5b1aafb5a5a4( 1 );
        }
        else if ( var_c5de6a56223f4f3f < 4500 )
        {
            return function_800e5b1aafb5a5a4( 2 );
        }
        else
        {
            return function_800e5b1aafb5a5a4( 4 );
        }
        
        return;
    }
    
    return function_800e5b1aafb5a5a4( 4 );
}

// Namespace heartbeat
// Params 0
// Checksum 0x3ad2adc7, Offset: 0x1167
// Size: 0x8f
function function_ccb83290f7bcfba6()
{
    if ( !damage_effects::isdeathsdoor() )
    {
        return;
    }
    
    if ( !isdefined( self.var_264be95670df90e3 ) && !self.healing && !( self.playerhealth.current_healing.size > 0 ) )
    {
        return;
    }
    
    if ( self.var_264be95670df90e3 > 4.5 )
    {
        return 0;
    }
    
    if ( self.var_264be95670df90e3 > 2.8 )
    {
        return 1;
    }
    
    if ( self.var_264be95670df90e3 > 0.7 )
    {
        return 2;
    }
    
    return 3;
}

// Namespace heartbeat
// Params 1
// Checksum 0x19fdd057, Offset: 0x11fe
// Size: 0x2c
function function_800e5b1aafb5a5a4( ceil )
{
    return int( min( self.heartbeat.var_bfeaa58c5d1ec905 + 1, ceil ) );
}

// Namespace heartbeat
// Params 0
// Checksum 0x958e462, Offset: 0x1233
// Size: 0x21
function function_e879732b6307927f()
{
    return int( max( self.heartbeat.var_bfeaa58c5d1ec905 - 1, 0 ) );
}

// Namespace heartbeat
// Params 0
// Checksum 0x8306539f, Offset: 0x125d
// Size: 0xb5, Type: bool
function function_d3d82f561554f7a()
{
    if ( self.heartbeat.var_bfeaa58c5d1ec905 == 0 )
    {
        if ( self getsprintmeterfraction() < 0.6 )
        {
            return false;
        }
    }
    
    if ( self.heartbeat.var_bfeaa58c5d1ec905 >= 1 )
    {
        if ( self issprinting() || self isjumping() || self isdiving() || self issprintsliding() || self getsprintmeterfraction() < 0.9 )
        {
            return false;
        }
    }
    
    if ( self.heartbeat.var_bfeaa58c5d1ec905 >= 2 )
    {
        if ( self getstance() == "stand" && length2d( self getnormalizedmovement() ) > 0.8 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace heartbeat
// Params 0
// Checksum 0xbbf651c7, Offset: 0x131b
// Size: 0x6c
function function_4f9513538baf7473()
{
    if ( isfocus() )
    {
        return 0;
    }
    
    if ( self.heartbeat.var_bfeaa58c5d1ec905 >= 2 )
    {
        if ( self issprinting() || self isjumping() || self isdiving() || self issprintsliding() || self getsprintmeterfraction() < 0.99 )
        {
            return 1;
        }
    }
    
    if ( self getsprintmeterfraction() < 0.8 )
    {
        return 1;
    }
}

// Namespace heartbeat
// Params 0
// Checksum 0x97f2afc6, Offset: 0x138f
// Size: 0x192
function function_e0d9d2247bbac15b()
{
    if ( !swim_common::isplayerunderwater() || !swim_common::function_65b1171cbe9502ee() )
    {
        return;
    }
    
    var_43e47531d549e6a5 = function_43e47531d549e6a5();
    var_c603e01ac6391ed3 = 4 / function_43e47531d549e6a5();
    pulselevelindex = 0;
    time = 0;
    beats = 0;
    var_23c77a201f62ac58 = function_b7fd5d39b313b5e7();
    var_828018e00c7a5dd8 = [];
    
    if ( swim_common::isbreathcritical() )
    {
        var_8f1b9a933aa4ee09 = [ 0, 1 ];
        remainingtime = swim_common::function_e17d5a8ae0a27da8();
    }
    else
    {
        var_8f1b9a933aa4ee09 = [ 2, 3, 4 ];
        remainingtime = swim_common::function_e17d5a8ae0a27da8() - [[ level.swim.var_91e79c1e5d912497 ]]();
    }
    
    foreach ( index in var_8f1b9a933aa4ee09 )
    {
        var_828018e00c7a5dd8[ var_828018e00c7a5dd8.size ] = var_23c77a201f62ac58[ index ];
    }
    
    while ( true )
    {
        if ( beats < var_c603e01ac6391ed3 )
        {
            time += var_828018e00c7a5dd8[ pulselevelindex ][ 1 ];
            beats++;
            
            if ( time > remainingtime )
            {
                break;
            }
            
            continue;
        }
        
        pulselevelindex++;
        beats = 0;
        
        if ( pulselevelindex >= var_828018e00c7a5dd8.size - 1 )
        {
            break;
        }
    }
    
    return var_8f1b9a933aa4ee09[ pulselevelindex ];
}

// Namespace heartbeat
// Params 0
// Checksum 0x6b88db74, Offset: 0x152a
// Size: 0xf
function function_e39bab1ee8f8ec38()
{
    if ( !isfocus() )
    {
        return;
    }
    
    return 5;
}

// Namespace heartbeat
// Params 0
// Checksum 0x5008525b, Offset: 0x1542
// Size: 0xb
function isfocus()
{
    return self.focusbreath;
}

// Namespace heartbeat
// Params 1
// Checksum 0xd878a86c, Offset: 0x1556
// Size: 0x30
function function_be749f41dcf386df( plrsfx )
{
    if ( !function_9a5048c0a49700a9() )
    {
        return;
    }
    
    self [[ level.heartbeat.playsoundfunc ]]( plrsfx );
}

// Namespace heartbeat
// Params 0
// Checksum 0x2c6955b5, Offset: 0x158e
// Size: 0xd, Type: bool
function function_9a5048c0a49700a9()
{
    return !isdefined( self.usingremote );
}

