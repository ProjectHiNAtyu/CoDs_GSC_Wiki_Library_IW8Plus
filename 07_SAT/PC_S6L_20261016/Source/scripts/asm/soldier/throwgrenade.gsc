// scripts\asm\soldier\throwgrenade.gsc  (hash_01d019cb9daa869f.gscc) (size: 13599 Bytes / 0x351f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfac889d (3752626333)
// size ...... 13599 (0x351f)
// includes .. 6   (offset: 0x30fb)
// strings ... 24  (offset: 0x312b)
// dev strs .. 48  (offset: 0x3283)
// exports ... 32  (offset: 0x1ddf)
// cseg ...... 0x1b1 + 0x1c2e (0x1ddf)
// imports ... 117 (offset: 0x22df)
// animtree1 . 0   (offset: 0x351f)
// animtree2 . 0   (offset: 0x351f)
#using scripts\anim\battlechatter_events;
#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;

#namespace throwgrenade;

// Namespace throwgrenade
// Params 3
// Checksum 0x5c0d972f, Offset: 0x1cf
// Size: 0x13f
function playanim_throwgrenade( asmname, statename, params )
{
    throwdata = spawnstruct();
    throwdata.xanim = self.throwdata_animindex;
    throwdata.vel = self.throwdata_throwvelocity;
    throwdata.target = self._blackboard.throwgrenadetarget;
    throwdata.targetpos = self._blackboard.var_ceec650495a39401;
    throwdata.fastthrow = self.throwdata_fastthrow;
    throwdata.withbounce = self.throwdata_withbounce;
    throwdata.time = self.throwdata_time;
    assert( isdefined( throwdata ) );
    assert( gettime() - throwdata.time <= 100 );
    self.ispreppinggrenade = 1;
    bthrew = trygrenadethrow( asmname, statename, throwdata );
    
    if ( !bthrew )
    {
        self endon( statename + "_finished" );
        wait 0.2;
        asm::asm_fireevent( asmname, "end" );
    }
}

// Namespace throwgrenade
// Params 3
// Checksum 0x5a75b06b, Offset: 0x316
// Size: 0x41
function playcoveranim_throwgrenade( asmname, statename, params )
{
    if ( isdefined( self.node ) )
    {
        self.keepclaimednodeifvalid = 1;
    }
    
    playanim_throwgrenade( asmname, statename, params );
}

// Namespace throwgrenade
// Params 2
// Checksum 0xb54bdcbb, Offset: 0x35f
// Size: 0x5c
function detachgrenade( model, tag )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self.isholdinggrenade )
    {
        return;
    }
    
    if ( isdefined( self.oldgrenawareness ) )
    {
        self.grenadeawareness = self.oldgrenawareness;
        self.oldgrenawareness = undefined;
    }
    
    self detach( model, tag );
}

// Namespace throwgrenade
// Params 3
// Checksum 0xb9a84d7a, Offset: 0x3c3
// Size: 0x35
function playcoveranim_throwgrenade_cleanup( asmname, statename, params )
{
    self function_b389a72141b859b0();
    playanim_throwgrenade_cleanup( asmname, statename, params );
    self function_cb0500ce4e3a2b70();
}

// Namespace throwgrenade
// Params 3
// Checksum 0x8b8b8824, Offset: 0x400
// Size: 0xc3
function playanim_throwgrenade_cleanup( asmname, statename, params )
{
    self._blackboard.throwdata = undefined;
    asm::asm_fireephemeralevent( "throwgrenade", "end" );
    self function_cb0500ce4e3a2b70();
    model = utility_common::getgrenademodel();
    
    if ( isdefined( self.grenadeattachtag ) )
    {
        detachgrenade( model, self.grenadeattachtag );
        self.grenadeattachtag = undefined;
    }
    
    if ( isdefined( self.isholdinggrenade ) && !self._blackboard.var_161790e3e0d95f07 )
    {
        combat_utility::dropgrenade();
        self.isholdinggrenade = undefined;
    }
    
    self.ispreppinggrenade = undefined;
}

// Namespace throwgrenade
// Params 1
// Checksum 0xd327c394, Offset: 0x4cb
// Size: 0x42
function throwgrenade_notehandler( note )
{
    statename = self asmgetcurrentstate( self.asmname );
    
    if ( note == "grenade_primed" )
    {
        asm::asm_fireephemeralevent( "throwgrenade", "start" );
    }
}

// Namespace throwgrenade
// Params 1
// Checksum 0x9cfef6cf, Offset: 0x516
// Size: 0x43, Type: bool
function shouldbounce( objgrenadeweapon )
{
    grenadetype = objgrenadeweapon.basename;
    return grenadetype != "antigrav" && grenadetype != "emp" && grenadetype != "c8_grenade";
}

// Namespace throwgrenade
// Params 4
// Checksum 0x8541b173, Offset: 0x562
// Size: 0x2fc, Type: bool
function trygrenadethrow( asmname, statename, throwdata, throwinthread )
{
    destination = throwdata.targetpos;
    throwingat = throwdata.target;
    withbounce = throwdata.withbounce;
    
    if ( !isdefined( withbounce ) )
    {
        withbounce = 1;
    }
    
    assert( isdefined( throwdata.xanim ) );
    
    if ( isdefined( destination ) )
    {
        armoffset = getgrenadethrowoffset( statename, throwdata.xanim, self.animsetname );
        
        if ( !isdefined( throwdata.fastthrow ) )
        {
            throwvel = self checkgrenadethrowpos( armoffset, destination, withbounce, "min energy", "min time", "max time" );
        }
        else
        {
            throwvel = self checkgrenadethrowpos( armoffset, destination, withbounce, "min time", "min energy" );
        }
    }
    else
    {
        throwvel = throwdata.vel;
        assert( isdefined( throwvel ) );
    }
    
    throwingat = throwdata.target;
    
    if ( isdefined( throwvel ) )
    {
        if ( !isdefined( self.oldgrenawareness ) )
        {
            self.oldgrenawareness = self.grenadeawareness;
        }
        
        self.grenadeawareness = 0;
        
        if ( self.var_21fe256899fee00 && self.var_4168ba7f5b3299f3 )
        {
            self.grenadeweapon = makeweapon( self.var_4168ba7f5b3299f3 );
        }
        
        /#
            if ( getdvarint( @"anim_debug" ) == 1 )
            {
                thread utility::debugpos( destination, "<dev string:x24>" );
            }
        #/
        
        var_6f0d3134570347c2 = getdesiredgrenadetimervalue();
        setgrenadetimer( min( gettime() + 3000, var_6f0d3134570347c2 ) );
        var_61d34ec07184901c = 0;
        
        if ( isdefined( throwingat ) && usingplayergrenadetimer() )
        {
            assert( throwingat == self.var_62cab1d078e4afb );
            throwingat function_884711fc94b10261();
            thread reducegiptponkillanimscript( statename, throwingat );
            
            if ( throwingat function_ea1c30d42bd9c659() > 1 )
            {
                var_61d34ec07184901c = 1;
            }
            
            if ( self.var_a0c0473ec3dea373 == "lethal" )
            {
                if ( throwingat function_ea1c30d42bd9c659() <= 1 )
                {
                    throwingat function_e45b1e2106a2e439( gettime() );
                }
            }
        }
        
        /#
            if ( getdvar( @"grenade_spam" ) == "<dev string:x26>" )
            {
                var_6f0d3134570347c2 = 0;
            }
        #/
        
        if ( isdefined( throwinthread ) )
        {
            thread dogrenadethrow( asmname, statename, throwdata.xanim, throwvel, var_6f0d3134570347c2, var_61d34ec07184901c );
        }
        else
        {
            dogrenadethrow( asmname, statename, throwdata.xanim, throwvel, var_6f0d3134570347c2, var_61d34ec07184901c );
        }
        
        return true;
    }
    else
    {
        /#
            function_be4ee37be09a7c20( "<dev string:x29>" );
        #/
        
        /#
            if ( getdvar( @"hash_4f3a4c91fee3cc20" ) == "<dev string:x26>" && isdefined( throwdata.destination ) )
            {
                armoffset = getgrenadethrowoffset( statename, throwdata.xanim, self.animsetname );
                thread grenadeline( armoffset, destination );
            }
        #/
    }
    
    return false;
}

// Namespace throwgrenade
// Params 0
// Checksum 0x483fbc91, Offset: 0x867
// Size: 0x78
function getdesiredgrenadetimervalue()
{
    var_6f0d3134570347c2 = undefined;
    
    if ( usingplayergrenadetimer() )
    {
        player = self.var_62cab1d078e4afb;
        var_6f0d3134570347c2 = gettime() + player.gs.playergrenadebasetime + randomint( player.gs.playergrenaderangetime );
    }
    else
    {
        var_6f0d3134570347c2 = gettime() + 30000 + randomint( 30000 );
    }
    
    return var_6f0d3134570347c2;
}

// Namespace throwgrenade
// Params 0
// Checksum 0x4650c54, Offset: 0x8e8
// Size: 0x38, Type: bool
function usingplayergrenadetimer()
{
    if ( self.var_a5d92eb2b87789c9 )
    {
        return false;
    }
    
    assert( self.var_dad32d6fd4d3eb0d );
    return self.var_7d2e49f72fa1942b && isdefined( self.var_62cab1d078e4afb );
}

// Namespace throwgrenade
// Params 2
// Checksum 0xbab1b9db, Offset: 0x929
// Size: 0x3a
function reducegiptponkillanimscript( statename, throwingat )
{
    self endon( #"hash_5ad7dd4a92990c59" );
    self waittill( statename + "_finished" );
    
    if ( isdefined( throwingat ) )
    {
        throwingat function_88a6736ac53d2a25();
    }
}

// Namespace throwgrenade
// Params 1
// Checksum 0xaabd71dd, Offset: 0x96b
// Size: 0x75
function function_e964a57e3c2b3dd3( throwngrenade )
{
    self notify( #"hash_cc37e8ec79b66866" );
    self endon( #"hash_cc37e8ec79b66866" );
    self endon( #"death" );
    
    if ( throwngrenade && self.var_21fe256899fee00 )
    {
        throwngrenade endon( #"death" );
        throwngrenade waittill( #"explode" );
        
        if ( self.var_40c1cc0dd2dd839c >= 0 )
        {
            self.var_b0948ce568464c51 = 0;
        }
    }
}

// Namespace throwgrenade
// Params 6
// Checksum 0x9882c41f, Offset: 0x9e8
// Size: 0x599
function dogrenadethrow( asmname, statename, throw_anim, throwvel, var_6f0d3134570347c2, var_61d34ec07184901c )
{
    self endon( #"killanimscript" );
    self endon( statename + "_finished" );
    
    /#
        thread grenadedebug( statename, "<dev string:x42>", 3 );
    #/
    
    covernode = asm_bb::bb_getcovernode();
    
    if ( !isdefined( covernode ) || covernode.type == "Exposed" || covernode.type == "Path" )
    {
        self orientmode( "face direction", throwvel );
    }
    
    bodyknob = asm::asm_getbodyknob();
    assert( isdefined( bodyknob ) );
    throw_xanim = asm::asm_getxanim( statename, throw_anim );
    
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, undefined, "grenade_throw", battlechatter_events::function_e08b029c30762ab3( self.grenadeweapon ) );
    }
    
    self setbattlechatterflag( "grenade_throw", 1, 2 );
    asm::asm_playfacialanim( asmname, statename, throw_xanim );
    throwanimrate = fasteranimspeed();
    self aisetanim( statename, throw_anim, throwanimrate );
    thread asm::asm_donotetracks( asmname, statename );
    model = utility_common::getgrenademodel();
    attachside = "none";
    var_f60f7eb779f3f5f0 = 0;
    
    while ( !var_f60f7eb779f3f5f0 )
    {
        self waittill( statename, notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        foreach ( notetrack in notes )
        {
            if ( notetrack == "grenade_right" )
            {
                attachside = attachgrenademodel( statename, model, "tag_accessory_right" );
                self.isholdinggrenade = 1;
                self.grenadeattachtag = "tag_accessory_right";
            }
            else if ( notetrack == "grenade_left" )
            {
                attachside = attachgrenademodel( statename, model, "tag_accessory_left" );
                self.isholdinggrenade = 1;
                self.grenadeattachtag = "tag_accessory_left";
            }
            
            if ( notetrack == "grenade_throw" || notetrack == "grenade throw" )
            {
                var_f60f7eb779f3f5f0 = 1;
                continue;
            }
            
            assert( notetrack != "<dev string:x51>" );
            
            if ( notetrack == "end" )
            {
                self.var_62cab1d078e4afb function_88a6736ac53d2a25();
                self notify( #"hash_5ad7dd4a92990c59" );
                return 0;
            }
        }
    }
    
    /#
        if ( getdvar( @"hash_27494f1d75fc0809" ) == "<dev string:x26>" )
        {
            tags = [];
            numtags = self getattachsize();
            emptyslot = [];
            
            for ( i = 0; i < numtags ; i++ )
            {
                name = self getattachmodelname( i );
                
                if ( issubstr( name, "<dev string:x55>" ) )
                {
                    tagname = self getattachtagname( i );
                    emptyslot[ tagname ] = 0;
                    tags[ tags.size ] = tagname;
                }
            }
            
            for ( i = 0; i < tags.size ; i++ )
            {
                emptyslot[ tags[ i ] ]++;
                
                if ( emptyslot[ tags[ i ] ] < 2 )
                {
                    continue;
                }
                
                iprintlnbold( "<dev string:x5c>" );
                println( "<dev string:x87>", throw_xanim, "<dev string:xa0>", tags[ i ] );
                break;
            }
        }
        
        thread grenadedebug( statename, "<dev string:xc3>", 5 );
    #/
    
    self notify( #"hash_5ad7dd4a92990c59" );
    var_281ae97a459abcee = usingplayergrenadetimer();
    
    if ( var_281ae97a459abcee )
    {
        thread watchgrenadetowardsplayer( statename, self.var_62cab1d078e4afb, var_6f0d3134570347c2 );
    }
    else
    {
        thread function_2524efb153ffdcd1( statename );
        setgrenadetimer( var_6f0d3134570347c2 );
    }
    
    grenadetag = undefined;
    
    if ( getdvarint( @"hash_e4a1f0f8938917ac", 0 ) )
    {
        grenadetag = self.grenadeattachtag;
    }
    
    var_133be109c44aa43a = !self.var_a5d92eb2b87789c9 || self.var_a5d92eb2b87789c9 && self.var_48621f5ca56d64e1;
    throwngrenade = undefined;
    
    if ( var_133be109c44aa43a )
    {
        throwngrenade = self throwgrenade( grenadetag );
        self.var_c4c535d1f47c26f2 = throwngrenade;
    }
    
    if ( var_61d34ec07184901c && var_281ae97a459abcee )
    {
        player = self.var_62cab1d078e4afb;
        assert( isplayer( player ) );
        
        if ( player function_ea1c30d42bd9c659() > 1 || gettime() - player function_a5d42feda6699278() < 2000 )
        {
            function_3a069799911ffb2a( player, gettime() + min( 5000, player.gs.playerdoublegrenadetime ) );
        }
    }
    
    thread function_e964a57e3c2b3dd3( throwngrenade );
    self notify( #"hash_c5477af52e60c91f" );
    
    if ( attachside != "none" )
    {
        self detach( model, attachside );
    }
    
    self.isholdinggrenade = undefined;
    self.ispreppinggrenade = undefined;
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
    self.throwgrenadeatenemyasap = 0;
    
    if ( isdefined( throwngrenade ) && self.team == "axis" )
    {
        level notify( #"enemy_grenade_fire", throwngrenade );
    }
    
    self waittillmatch( statename, #"end" );
    self notify( #"done_grenade_throw" );
    self notify( #"weapon_switch_done" );
}

// Namespace throwgrenade
// Params 0
// Checksum 0xe8ef3764, Offset: 0xf89
// Size: 0x25
function fasteranimspeed()
{
    var_7237854e3be197ca = self.grenadethrowanimrate;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 1.5;
}

// Namespace throwgrenade
// Params 3
// Checksum 0x43902de, Offset: 0xfb7
// Size: 0x29
function attachgrenademodel( statename, model, tag )
{
    self attach( model, tag );
    return tag;
}

// Namespace throwgrenade
// Params 1
// Checksum 0x96a3416f, Offset: 0xfe9
// Size: 0x24
function waittillscriptchange( statename )
{
    self endon( statename + "_finished" );
    self waittill( #"killanimscript" );
}

// Namespace throwgrenade
// Params 3
// Checksum 0x25c6d1b6, Offset: 0x1015
// Size: 0x6c
function detachgrenadeonscriptchange( statename, model, tag )
{
    self endon( #"hash_c5477af52e60c91f" );
    waittillscriptchange( statename );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.oldgrenawareness ) )
    {
        self.grenadeawareness = self.oldgrenawareness;
        self.oldgrenawareness = undefined;
    }
    
    self detach( model, tag );
}

// Namespace throwgrenade
// Params 1
// Checksum 0xe6f16806, Offset: 0x1089
// Size: 0xdb
function function_2524efb153ffdcd1( statename )
{
    timeoutobj = spawnstruct();
    timeoutobj thread watchgrenadetowardstargettimeout( 5 );
    timeoutobj endon( #"watchgrenadetowardstargettimeout" );
    grenade = getgrenadeithrew( statename );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    /#
        grenade thread grenadedebug( statename, "<dev string:xc9>", 5 );
    #/
    
    for ( prevorigin = grenade.origin; true ; prevorigin = grenade.origin )
    {
        wait 0.1;
        
        if ( !isdefined( grenade ) )
        {
            break;
        }
        
        if ( distancesquared( grenade.origin, prevorigin ) < 400 )
        {
            /#
                grenade thread grenadedebug( statename, "<dev string:xd2>", 5 );
            #/
            
            function_168fdeae018c7954( grenade.origin );
            break;
        }
    }
}

// Namespace throwgrenade
// Params 3
// Checksum 0xebf3fcc1, Offset: 0x116c
// Size: 0x42
function watchgrenadetowardsplayer( statename, player, var_6f0d3134570347c2 )
{
    player endon( #"death" );
    watchgrenadetowardsplayerinternal( statename, var_6f0d3134570347c2 );
    
    if ( isdefined( player ) )
    {
        player function_88a6736ac53d2a25();
    }
}

// Namespace throwgrenade
// Params 2
// Checksum 0x1f07d891, Offset: 0x11b6
// Size: 0x22c
function watchgrenadetowardsplayerinternal( statename, var_6f0d3134570347c2 )
{
    var_a0c0473ec3dea373 = self.var_a0c0473ec3dea373;
    timeoutobj = spawnstruct();
    timeoutobj thread watchgrenadetowardstargettimeout( 5 );
    timeoutobj endon( #"watchgrenadetowardstargettimeout" );
    type = self.grenadeweapon.basename;
    grenade = getgrenadeithrew( statename );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    setgrenadetimer( min( gettime() + 5000, var_6f0d3134570347c2 ) );
    
    /#
        grenade thread grenadedebug( statename, "<dev string:xc9>", 5 );
    #/
    
    goodradiussqrd = 62500;
    giveupradiussqrd = 160000;
    
    if ( type == "flash_grenade" )
    {
        goodradiussqrd = 810000;
        giveupradiussqrd = 1690000;
    }
    
    playerstocheck = level.players;
    prevorigin = grenade.origin;
    haslanded = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( grenade ) )
        {
            break;
        }
        
        if ( distancesquared( grenade.origin, prevorigin ) < 400 )
        {
            /#
                grenade thread grenadedebug( statename, "<dev string:xd2>", 5 );
            #/
            
            if ( !haslanded )
            {
                function_168fdeae018c7954( grenade.origin );
                haslanded = 1;
            }
            
            newplayerstocheck = [];
            
            for ( i = 0; i < playerstocheck.size ; i++ )
            {
                player = playerstocheck[ i ];
                
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                distsqrd = distancesquared( grenade.origin, player.origin );
                
                if ( distsqrd < goodradiussqrd )
                {
                    /#
                        grenade thread grenadedebug( statename, "<dev string:xd9>", 5 );
                    #/
                    
                    player grenadelandednearplayer( var_a0c0473ec3dea373, var_6f0d3134570347c2 );
                    continue;
                }
                
                if ( distsqrd < giveupradiussqrd )
                {
                    newplayerstocheck[ newplayerstocheck.size ] = player;
                }
            }
            
            playerstocheck = newplayerstocheck;
            
            if ( playerstocheck.size == 0 )
            {
                break;
            }
        }
        
        prevorigin = grenade.origin;
    }
}

// Namespace throwgrenade
// Params 2
// Checksum 0x32763114, Offset: 0x13ea
// Size: 0x8d
function grenadelandednearplayer( var_a0c0473ec3dea373, var_6f0d3134570347c2 )
{
    player = self;
    function_bee5df22fff6b7cc( 0 );
    curtime = gettime();
    
    if ( curtime - player function_a5d42feda6699278() < 3000 )
    {
        function_3a069799911ffb2a( player, curtime + player.gs.playerdoublegrenadetime );
    }
    
    player function_951cc2faa0f3007c( curtime );
    oldvalue = function_df78c5e9af5755b3( player, var_a0c0473ec3dea373 );
    aisetgrenadetimer( player, var_a0c0473ec3dea373, max( var_6f0d3134570347c2, oldvalue ) );
}

// Namespace throwgrenade
// Params 1
// Checksum 0xd7ef5497, Offset: 0x147f
// Size: 0x91
function setgrenadetimer( newvalue )
{
    weapontype = self.var_a0c0473ec3dea373;
    
    if ( !isdefined( weapontype ) )
    {
        return;
    }
    
    if ( usingplayergrenadetimer() && isalive( self.var_62cab1d078e4afb ) )
    {
        player = self.var_62cab1d078e4afb;
        oldvalue = function_df78c5e9af5755b3( player, weapontype );
        aisetgrenadetimer( player, weapontype, max( newvalue, oldvalue ) );
        return;
    }
    
    oldvalue = function_df78c5e9af5755b3( undefined, weapontype );
    aisetgrenadetimer( undefined, weapontype, max( newvalue, oldvalue ) );
}

// Namespace throwgrenade
// Params 1
// Checksum 0x4a310c1, Offset: 0x1518
// Size: 0x3e
function getgrenadeithrew( statename )
{
    self endon( #"killanimscript" );
    self endon( statename + "_finished" );
    self waittill( #"grenade_fire", grenade );
    return grenade;
}

// Namespace throwgrenade
// Params 1
// Checksum 0x44a413a5, Offset: 0x155f
// Size: 0x1b
function watchgrenadetowardstargettimeout( timerlength )
{
    wait timerlength;
    self notify( #"watchgrenadetowardstargettimeout" );
}

// Namespace throwgrenade
// Params 1
// Checksum 0x1183dcbe, Offset: 0x1582
// Size: 0x74
function offsettoorigin( start )
{
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    up = anglestoup( self.angles );
    forward *= start[ 0 ];
    right *= start[ 1 ];
    up *= start[ 2 ];
    return forward + right + up;
}

/#

    // Namespace throwgrenade
    // Params 2
    // Checksum 0xe66c0ba9, Offset: 0x15ff
    // Size: 0x94, Type: dev
    function grenadeline( start, end )
    {
        level notify( #"armoffset" );
        level endon( #"armoffset" );
        start = self.origin + offsettoorigin( start );
        
        for ( ;; )
        {
            line( start, end, ( 1, 0, 1 ) );
            print3d( start, start, ( 0.2, 0.5, 1 ), 1, 1 );
            print3d( end, end, ( 0.2, 0.5, 1 ), 1, 1 );
            wait 0.05;
        }
    }

    // Namespace throwgrenade
    // Params 1
    // Checksum 0x47f95dce, Offset: 0x169b
    // Size: 0x2e, Type: dev
    function function_be4ee37be09a7c20( reason )
    {
        if ( getdvarint( @"scr_grenade_debug" ) != 1 )
        {
            return;
        }
        
        self.var_6bced4b5bf1fe908 = reason;
    }

    // Namespace throwgrenade
    // Params 4
    // Checksum 0xde79d559, Offset: 0x16d1
    // Size: 0x12a, Type: dev
    function grenadedebug( statename, state, duration, var_3a025eb656c860d3 )
    {
        if ( getdvarint( @"scr_grenade_debug" ) != 1 )
        {
            return;
        }
        
        self notify( #"grenade_debug" );
        self endon( #"grenade_debug" );
        self endon( #"killanimscript" );
        self endon( statename + "<dev string:xec>" );
        self endon( #"death" );
        endtime = gettime() + 1000 * duration;
        
        while ( gettime() < endtime )
        {
            print3d( self getshootatpos() + ( 0, 0, 10 ), state );
            
            if ( isdefined( var_3a025eb656c860d3 ) && isdefined( self.var_6bced4b5bf1fe908 ) )
            {
                print3d( self getshootatpos() + ( 0, 0, 0 ), "<dev string:xf6>" + self.var_6bced4b5bf1fe908 );
            }
            else if ( self.var_dad32d6fd4d3eb0d )
            {
                print3d( self getshootatpos() + ( 0, 0, 0 ), "<dev string:xff>" + function_6b6f2fb367e67c7() );
            }
            
            wait 0.05;
        }
    }

    // Namespace throwgrenade
    // Params 0
    // Checksum 0xb213512f, Offset: 0x1803
    // Size: 0x7c, Type: dev
    function function_6b6f2fb367e67c7()
    {
        if ( usingplayergrenadetimer() )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                if ( level.players[ i ] == self.var_62cab1d078e4afb )
                {
                    break;
                }
            }
            
            return ( "<dev string:x107>" + i + 1 + "<dev string:x10f>" + self.var_a0c0473ec3dea373 );
        }
        
        return "<dev string:x111>" + self.var_a0c0473ec3dea373;
    }

    // Namespace throwgrenade
    // Params 2
    // Checksum 0xb898c430, Offset: 0x1887
    // Size: 0x53a, Type: dev
    function function_a8e75202e39429d7( asmname, archetypename )
    {
        assert( self.animsetname == asmname, "<dev string:x115>" );
        rootknob = archetypegetalias( archetypename, "<dev string:x16a>", "<dev string:x170>" );
        rootknob = rootknob.anims;
        animarray = "<dev string:x175>" + archetypename + "<dev string:x18f>";
        offsetarray = "<dev string:x193>" + archetypename + "<dev string:x18f>";
        println( "<dev string:x1af>" );
        println( "<dev string:x1fc>" + archetypename + "<dev string:x227>" );
        println( "<dev string:x23a>" + animarray + "<dev string:x23c>" );
        println( "<dev string:x23a>" + offsetarray + "<dev string:x23c>" );
        allstates = asmdevgetallstates( asmname );
        
        foreach ( statename in allstates )
        {
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( isdefined( aliases ) )
            {
                foreach ( alias in aliases )
                {
                    if ( issubstr( statename, "<dev string:x243>" ) || issubstr( statename, "<dev string:x24b>" ) )
                    {
                        throwanims = asm::asm_getallanimindicesforalias( statename, alias );
                        throwxanim0 = asm::asm_getxanim( statename, throwanims[ 0 ] );
                        assert( !animhasnotetrack( throwxanim0, "<dev string:x251>" ) );
                        
                        if ( animhasnotetrack( throwxanim0, "<dev string:x25f>" ) )
                        {
                            foreach ( animidx in throwanims )
                            {
                                xanim = asm::asm_getxanim( statename, animidx );
                                assert( animhasnotetrack( xanim, "<dev string:x25f>" ) && !animhasnotetrack( xanim, "<dev string:x251>" ) );
                            }
                            
                            println( "<dev string:x23a>" + animarray + "<dev string:x26d>" + statename + "<dev string:x271>" + alias + "<dev string:x278>" + statename + "<dev string:x2a4>" + alias + "<dev string:x2a9>" );
                            println( "<dev string:x23a>" + offsetarray + "<dev string:x26d>" + statename + "<dev string:x271>" + alias + "<dev string:x2ae>" );
                            
                            foreach ( ianim, animidx in throwanims )
                            {
                                xanim = asm::asm_getxanim( statename, animidx );
                                notetracktimes = getnotetracktimes( xanim, "<dev string:x25f>" );
                                self clearanim( rootknob, 0 );
                                self setanimrestart( xanim, 1, 0, 0 );
                                wait 0.05;
                                startpos = self.origin;
                                startangles = self.angles;
                                self setanimtime( xanim, notetracktimes[ 0 ] );
                                wait 0.05;
                                animdelta = getmovedelta( xanim, 0, notetracktimes[ 0 ] );
                                startpos -= rotatevector( animdelta, startangles );
                                handpos = self gettagorigin( "<dev string:x2b8>" );
                                handangles = self gettagangles( "<dev string:x2b8>" );
                                localhandpos = rotatevectorinverted( handpos - startpos, startangles );
                                line( handpos, handpos + anglestoforward( handangles ) * 12, ( 0, 0, 1 ), 1, 0, 5 );
                                line( handpos, handpos + anglestoleft( handangles ) * 12, ( 1, 0, 0 ), 1, 0, 5 );
                                line( handpos, handpos + anglestoup( handangles ) * 12, ( 0, 1, 0 ), 1, 0, 5 );
                                wait 0.25;
                                println( "<dev string:x23a>" + offsetarray + "<dev string:x26d>" + statename + "<dev string:x271>" + alias + "<dev string:x2cc>" + ianim + "<dev string:x2d2>" + localhandpos + "<dev string:x2d8>" );
                            }
                            
                            println( "<dev string:x2da>" + animarray + "<dev string:x26d>" + statename + "<dev string:x271>" + alias + "<dev string:x2e4>" + offsetarray + "<dev string:x26d>" + statename + "<dev string:x271>" + alias + "<dev string:x2f1>" );
                        }
                    }
                }
            }
        }
    }

    // Namespace throwgrenade
    // Params 0
    // Checksum 0x9f1b8afc, Offset: 0x1dc9
    // Size: 0x16, Type: dev
    function function_c5b529be9707e285()
    {
        function_a8e75202e39429d7( "<dev string:x2fd>", "<dev string:x2fd>" );
    }

#/
