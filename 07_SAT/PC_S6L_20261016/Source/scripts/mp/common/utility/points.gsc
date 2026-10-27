// scripts\mp\common\utility\points.gsc  (hash_3c8ea7f78632414c.gscc) (size: 12781 Bytes / 0x31ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2c80d7ae (746641326)
// size ...... 12781 (0x31ed)
// includes .. 22  (offset: 0x2fd1)
// strings ... 18  (offset: 0x3081)
// dev strs .. 10  (offset: 0x3171)
// exports ... 25  (offset: 0x2105)
// cseg ...... 0x3c7 + 0x1d3e (0x2105)
// imports ... 92  (offset: 0x24ed)
// animtree1 . 0   (offset: 0x31ed)
// animtree2 . 0   (offset: 0x31ed)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\awards;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\potg;
#using scripts\mp\rank;
#using scripts\mp\supers;

#namespace points;

// Namespace points
// Params 0
// Checksum 0x6a87d082, Offset: 0x3e5
// Size: 0x10
function initpoints()
{
    level.var_dbd43a8b925f566f = &doscoreevent;
}

// Namespace points
// Params 3
// Checksum 0x8986ab16, Offset: 0x3fd
// Size: 0x89
function givestreakpointswithtext( event, objweapon, pointsoverride )
{
    if ( level.ignorescoring )
    {
        return;
    }
    
    if ( isdefined( pointsoverride ) )
    {
        points = pointsoverride;
    }
    else
    {
        points = rank::getscoreinfovalue( event );
        assert( isdefined( points ), "<dev string:x24>" + getxhashsourcename( event ) + "<dev string:x4c>" );
    }
    
    points = modifyunifiedpoints( event, points, objweapon );
    killstreaks::givestreakpoints( event, points );
    displayscoreeventpoints( points, event );
}

// Namespace points
// Params 2
// Checksum 0x7627606a, Offset: 0x48e
// Size: 0x84
function givexpwithtext( event, pointsoverride )
{
    if ( level.ignorescoring )
    {
        return;
    }
    
    assert( isxhash( event ) );
    points = undefined;
    
    if ( isdefined( pointsoverride ) )
    {
        points = pointsoverride;
    }
    else
    {
        points = rank::getscoreinfovalue( event );
        assert( isdefined( points ), "<dev string:x93>" + getxhashsourcename( event ) + "<dev string:x4c>" );
    }
    
    thread rank::giverankxp( event, points );
    thread rank::scoreeventpopup( event );
}

// Namespace points
// Params 2
// Checksum 0x9ed9ecc, Offset: 0x51a
// Size: 0x36
function function_a0b28fbe32e53f12( event, endon1 )
{
    self endon( #"disconnect" );
    
    if ( isdefined( endon1 ) )
    {
        self endon( endon1 );
    }
    
    waittillframeend();
    doscoreevent( event );
}

// Namespace points
// Params 11
// Checksum 0xf5e252aa, Offset: 0x558
// Size: 0x55a
function doscoreevent( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo )
{
    if ( level.ignoreallscoreevent )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
    {
        [ suspiciouskill, suspiciousdown ] = utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker );
        
        if ( suspiciouskill > 0 || suspiciousdown > 0 )
        {
            return;
        }
    }
    
    if ( level.gameended )
    {
        isvalidevent = 0;
        
        if ( isarray( event ) )
        {
            if ( isnumber( level.gameendtime ) )
            {
                if ( event[ 1 ] <= level.gameendtime )
                {
                    isvalidevent = 1;
                    event = event[ 0 ];
                }
            }
        }
        else if ( isdefined( event ) )
        {
            isvalidevent = 1;
        }
        
        if ( !isvalidevent )
        {
            return;
        }
    }
    else if ( isarray( event ) )
    {
        event = event[ 0 ];
    }
    
    if ( !isxhash( event ) )
    {
        assert( 0, event );
        event = getxhash( event );
    }
    
    if ( level.var_c03337b0d81a9e27[ event ] )
    {
        return;
    }
    
    if ( getdvarint( @"hash_28825c0c0b691b0d", 0 ) == 1 )
    {
        hexname = getxhashhexname( event );
        hashname = hashcat( @"hash_1e443aaa4347a9c", hexname );
        
        if ( getdvarint( hashname, 0 ) == 1 )
        {
            return;
        }
    }
    
    if ( level.var_23730bd6be76cb84 )
    {
        if ( isdefined( self.var_e111789bdf9bcbda ) )
        {
            if ( rank::function_87d0d607f0e5e545( event ) )
            {
                if ( rank::function_3df8217e471be8f7( event ) )
                {
                    self.var_e111789bdf9bcbda.isobjectivekill = 1;
                }
            }
        }
    }
    
    showsplash = rank::function_c93ef027a4ddaca8( event ) || self.var_3f98a27bd6d0f2b3;
    
    if ( showsplash )
    {
        var_9a287dca429d8c28 = 1;
        
        if ( level.var_af0045e470655ee )
        {
            if ( ( !level.var_296253a91eeebfc6 || rank::getscoreinfocategory( event, #"hash_e98734bda1c5c091" ) ) && level.var_bbf4f9dff7b0244e[ event ] && ( level.var_931ca47cc298f7af == #"display_score" && level.scoreinfo_value[ event ] > 0 || level.var_931ca47cc298f7af == #"display_xp" && level.scoreinfo_xp[ event ] > 0 ) )
            {
                var_9a287dca429d8c28 = 0;
                
                if ( !isdefined( eventinfo ) )
                {
                    eventinfo = {};
                }
                
                eventinfo.var_8995f5d0a717335f = 1;
            }
        }
        
        if ( var_9a287dca429d8c28 )
        {
            if ( level.var_dd30bf39c0753f31 )
            {
                if ( level.var_931ca47cc298f7af == #"display_xp" )
                {
                    should_combine = rank::function_87d0d607f0e5e545( event );
                    var_357c5114c9527e62 = rank::getscoreinfoxp( event );
                    thread events::killeventtextpopup( event, 1, undefined, { #victim:victim, #calledfrom:#"doScoreEvent", #extraparam:eventinfo.extraparam, #var_e7696e45bbb0a313:should_combine, #xpgiven:var_357c5114c9527e62 } );
                }
            }
            else
            {
                thread events::killeventtextpopup( event, 1, undefined, { #victim:victim, #calledfrom:#"doScoreEvent", #extraparam:eventinfo.extraparam } );
            }
        }
    }
    
    var_f6e4e189d0b9a271 = isdefined( victim ) && utility::function_143713a7a54c776e( event );
    self setclientomnvar( "ui_score_event_is_special_kia", var_f6e4e189d0b9a271 );
    
    if ( rank::function_4d2b4b1cc1dec6fd( event ) )
    {
        awards::givemidmatchaward( event, objweapon, pointsoverride, xpoverride, var_ae2a12845c1ef7c1, victim, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo );
    }
    else
    {
        giveunifiedpoints( event, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo );
    }
    
    params = { #objweapon:objweapon, #event:event };
    callback::callback( #"hash_fa7263897b3164e", params );
    
    if ( level.gametypebundle.var_2e615b9703b5b0be && !eventinfo.var_fa13397bbf3bd94a )
    {
        attackerdata = victim.attackerdata[ self.guid ];
        
        if ( eventinfo.var_9f71c6384859861d && victim.juggcontext.var_af0e1deab5671dfa )
        {
            attackerdata = victim.juggcontext.var_af0e1deab5671dfa.attackerdata[ self.guid ];
        }
        
        potg::processevent( event, attackerdata.firsttimedamaged, attackerdata.lasttimedamaged, attackerdata.psoffsettime, undefined, undefined, eventinfo, objweapon, attackerdata.smeansofdeath );
        
        /#
            if ( isplayer( victim ) && !attackerdata )
            {
                assertmsg( "<dev string:xb1>" );
            }
        #/
    }
}

// Namespace points
// Params 3
// Checksum 0x73a61cd0, Offset: 0xaba
// Size: 0x6b
function function_aa3f27bc29d005fc( event, objweapon, victim )
{
    if ( !isdefined( level.var_39a88169ff8aa22d ) )
    {
        level.var_39a88169ff8aa22d = spawnstruct();
        level.var_39a88169ff8aa22d.var_a2675be6a2abfeb4 = 1;
    }
    
    doscoreevent( event, objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, level.var_39a88169ff8aa22d );
}

// Namespace points
// Params 3
// Checksum 0xcaaddde0, Offset: 0xb2d
// Size: 0x3c
function function_f8a0deb1a12da52e( event, weapon, lootid )
{
    doscoreevent( event, weapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #lootid:lootid } );
}

// Namespace points
// Params 9
// Checksum 0x75020732, Offset: 0xb71
// Size: 0x69d
function giveunifiedpoints( event, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo )
{
    if ( level.gameended )
    {
        isvalidevent = 0;
        
        if ( isarray( event ) )
        {
            if ( isnumber( level.gameendtime ) )
            {
                if ( event[ 1 ] <= level.gameendtime )
                {
                    isvalidevent = 1;
                    event = event[ 0 ];
                }
            }
        }
        else if ( isdefined( event ) )
        {
            isvalidevent = 1;
        }
        
        if ( !isvalidevent )
        {
            return;
        }
    }
    else if ( isarray( event ) )
    {
        event = event[ 0 ];
    }
    
    if ( !isxhash( event ) )
    {
        assert( 0, event );
        event = getxhash( event );
    }
    
    if ( level.ignorescoring )
    {
        var_bbbdde8daf7862 = 1;
        var_42c077b88db74a9c = isbrgamemode() && !flags::gameflag( "prematch_done" );
        
        if ( var_42c077b88db74a9c )
        {
            var_bbbdde8daf7862 = 0;
        }
        
        if ( var_bbbdde8daf7862 )
        {
            return;
        }
    }
    
    if ( game[ "practiceRound" ] )
    {
        return;
    }
    
    iskill = event == #"kill";
    
    if ( isdefined( pointsoverride ) )
    {
        points = pointsoverride;
    }
    else
    {
        points = rank::getscoreinfovalue( event );
        
        /#
            if ( getdvarint( @"hash_34d5471aab291648", 0 ) )
            {
                assert( isdefined( points ), "<dev string:x163>" + getxhashsourcename( event ) + "<dev string:x18b>" );
            }
        #/
    }
    
    if ( !isdefined( points ) )
    {
        /#
            debugprint = isdefined( pointsoverride ) ? "<dev string:x1fc>" : "<dev string:x210>" + getxhashsourcename( event ) + "<dev string:x21c>";
            println( "<dev string:x270>" + debugprint );
        #/
        
        points = 0;
    }
    
    points = modifyunifiedpoints( event, points, objweapon, eventinfo );
    
    if ( function_fa21b31530bfb9f( points, event ) )
    {
        gamescore::giveplayerscore( event, points, victim, objweapon, eventinfo );
        
        if ( isdefined( objweapon ) )
        {
            weaponobj = weapon::mapweapon( objweapon );
            thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, points, "total_score_earned" );
        }
        
        if ( isdefined( streakinfo.score ) )
        {
            streakinfo.score += points;
        }
        
        var_98941849f0ec3cd8 = rank::getscoreinfocategory( event, #"hash_2322564347237f7" );
        
        if ( !var_c9f5190087459c78 && !var_98941849f0ec3cd8 && function_25a6a379d12750a8( self, objweapon, event, eventinfo, cankillchain ) )
        {
            if ( level.gametypebundle.requisitionsenabled && getdvarint( @"hash_fde6241a6a888ee5", 0 ) == 1 )
            {
                var_91a7e639160601bd = killstreak::isjuggernaut();
                iskillstreakkill = var_91a7e639160601bd || eventinfo.iskillstreakkill || isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon );
                
                if ( iskillstreakkill )
                {
                    points = int( points * getdvarfloat( @"hash_fbb908c0bf030802", 0.5 ) );
                }
            }
            
            killstreaks::givestreakpoints( event, 1, points );
        }
        
        supermultiplier = 1;
        
        if ( iskill || event == #"assist" )
        {
            supermultiplier = function_12f8928ed9f98c0b( supermultiplier );
        }
        
        if ( !level.superglobals.var_7528e3d743bcb734 && !self.var_2364be08b6facb67 )
        {
            supers_mp::givesuperpoints( points, event, undefined, supermultiplier, undefined, undefined, undefined, eventinfo );
        }
        
        if ( isdefined( level.var_98208664e6000da6 ) )
        {
            [[ level.var_98208664e6000da6 ]]( self, victim, event, points );
        }
        
        params = { #points:points, #event:event, #victim:victim, #player:self };
        callback::callback( #"hash_3b81ca15a16b5585", params );
    }
    
    shouldgivexp = 1;
    
    if ( xpoverride < 0 )
    {
        shouldgivexp = 0;
    }
    
    if ( shouldgivexp )
    {
        xp = xpoverride;
        
        if ( !isdefined( xp ) )
        {
            if ( isdefined( pointsoverride ) )
            {
                xp = points;
            }
            else
            {
                xp = rank::getscoreinfoxp( event );
            }
        }
        
        if ( !isdefined( xp ) )
        {
            xp = 0;
        }
        
        if ( iskill )
        {
            var_74172b11a749c13a = objweapon && ( objweapon hasattachment( "gunperk_xp" ) || isdefined( self.perks[ "specialty_gunperk_xp" ] ) );
            
            if ( var_74172b11a749c13a )
            {
                xp += 20;
            }
            
            xp = sharekillxp( xp );
        }
        
        if ( xp > 0 )
        {
            rank::giverankxp( event, xp, objweapon, undefined, undefined, eventinfo.var_ef32324b503188b8, eventinfo );
        }
    }
    
    popuppoints = points;
    
    if ( level.var_23730bd6be76cb84 )
    {
        if ( self.var_e111789bdf9bcbda.var_1478d6a5815e4bf5 )
        {
            popuppoints += self.var_e111789bdf9bcbda.objectivekillpoints ?? 0;
        }
        else if ( self.var_e111789bdf9bcbda.isobjectivekill )
        {
            if ( !self.var_e111789bdf9bcbda.var_b5f29032f94f1b6e )
            {
                var_953298f2bec03988 = 1;
                self.var_e111789bdf9bcbda.var_b5f29032f94f1b6e = 1;
            }
        }
    }
    
    if ( isdefined( level.var_951445557a9211da ) )
    {
        var_953298f2bec03988 = self [[ level.var_951445557a9211da ]]( var_953298f2bec03988 );
    }
    
    should_combine = rank::function_87d0d607f0e5e545( event );
    thread events::killeventtextpopup( event, eventinfo.var_8995f5d0a717335f, var_953298f2bec03988, { #victim:victim, #var_e7696e45bbb0a313:should_combine, #extraparam:eventinfo.extraparam, #isobjectivekill:eventinfo.isobjectivekill, #xpgiven:xp, #pointsgiven:popuppoints } );
    
    if ( level.var_99e6db424e4b2f5c && isdefined( level.var_cc4ceaea968640d2 ) && points > 0 && event != "br_kioskBuy" )
    {
        self [[ level.var_cc4ceaea968640d2 ]]( points );
    }
    
    if ( level.var_4a6ab8d878dcdb93 && ( objweapon || ( eventinfo.lootid ?? streakinfo.bundle.lootid ) ) )
    {
        loadoutxp = rank::function_d1309dc6fb66ebc( event );
        
        if ( loadoutxp > 0 )
        {
            self [[ level.var_4a6ab8d878dcdb93 ]]( objweapon, loadoutxp, eventinfo.lootid ?? streakinfo.bundle.lootid );
        }
    }
}

// Namespace points
// Params 2
// Checksum 0x4ea9a5a6, Offset: 0x1216
// Size: 0x2b, Type: bool
function function_fa21b31530bfb9f( points, event )
{
    return points > 0 || level.var_5baf51b4058a08a2[ event ] > 0;
}

// Namespace points
// Params 1
// Checksum 0x770af86c, Offset: 0x124a
// Size: 0x41c
function sharekillxp( inxp )
{
    if ( getdvarint( @"hash_97ad5e7b7a25f1ca", 0 ) == 0 )
    {
        return inxp;
    }
    
    var_3066d05a5ca7db4a = 0;
    buddy_kill_xp = inxp;
    returnval = inxp;
    players = teams::getteamdata( self.team, "players" );
    
    if ( players.size > 1 )
    {
        switch ( game_utility::getgametype() )
        {
            case #"hash_21eed743fb721f4a":
            case #"hash_ea061d29bbd1f237":
            case #"hash_ec72fd25bbbac99e":
            case #"hash_1a5d186c17c00d3c":
            case #"hash_1b1eecd3863a50cf":
            case #"hash_4d60179017f5a28a":
            case #"hash_f4a9126c03d3385b":
            case #"hash_2f5af599c5c220d3":
            case #"hash_fa0ed2f6bd4f4395":
            case #"hash_fa34c5f6bd6d4432":
            case #"hash_fa44d9f6bd7a2fa1":
            case #"hash_515260130b210bff":
            case #"hash_fa50b0f6bd82e972":
            case #"hash_6efb0f59a62300fb":
            case #"hash_719dd4821355f699":
            case #"hash_7485fa6c474ec865":
            case #"hash_77eb1179a728005e":
            case #"hash_78ebb3b7ce8f864f":
            case #"hash_7a322834c148e09a":
            case #"hash_fa7b69e7b63430d3":
            case #"hash_973d1db8b6644466":
            case #"hash_a1313b745c17c07e":
            case #"hash_a93dacd349d98a99":
            case #"hash_aac44b0b52bacb8e":
            case #"hash_aada280b52cbdd96":
            case #"hash_cf3000550ee7e8b3":
            case #"hash_d82d642e83fb9772":
            case #"hash_dd160d04d4a296a9":
            case #"hash_dd5b900f435d3f36":
                var_7adab3869b6f3e41 = getdvarfloat( @"hash_23ceb5f30cd9cf48", 0.8 );
                buddy_kill_xp *= ( 1 - var_7adab3869b6f3e41 ) / ( players.size - 1 );
                var_3066d05a5ca7db4a = 1;
                returnval *= var_7adab3869b6f3e41;
                break;
            case #"hash_25397d96e5bc8403":
            case #"hash_8f01ce022684fbc8":
                var_2a698ff02028cb75 = getdvarfloat( @"hash_94a2f41d316613ec", 0.65 );
                buddy_kill_xp *= ( 1 - var_2a698ff02028cb75 ) / ( players.size - 1 );
                var_3066d05a5ca7db4a = 1;
                returnval *= var_2a698ff02028cb75;
                break;
            case #"hash_c51506c10984515":
            case #"hash_3696c16c262a0862":
            case #"hash_7e89154a96f625d":
            case #"hash_fa0ed9f6bd4f4e9a":
            case #"hash_b9458959b10637f8":
            case #"hash_ab00240b52e9ec5e":
            case #"hash_ddd385f0a27d71bb":
            case #"hash_fb5b5e6c07253005":
                break;
            case #"hash_5ff8e011d5b9d1c8":
                if ( getdvarint( @"ui_team_gunfight", 0 ) == 1 )
                {
                    var_7adab3869b6f3e41 = getdvarfloat( @"hash_23ceb5f30cd9cf48", 0.8 );
                    buddy_kill_xp *= ( 1 - var_7adab3869b6f3e41 ) / ( players.size - 1 );
                    var_3066d05a5ca7db4a = 1;
                    returnval *= var_7adab3869b6f3e41;
                }
                
                break;
            case #"hash_ca6516c10db2c95":
            case #"hash_448b7248104bfa9c":
            case #"hash_c065cef60f38490a":
                var_da42f735cdb57dd3 = getdvarfloat( @"hash_9a6b4d162b5aee8a", 0.9 );
                buddy_kill_xp *= ( 1 - var_da42f735cdb57dd3 ) / ( players.size - 1 );
                var_3066d05a5ca7db4a = 1;
                returnval *= var_da42f735cdb57dd3;
                break;
            default:
                break;
        }
    }
    
    if ( var_3066d05a5ca7db4a )
    {
        foreach ( player in players )
        {
            if ( player != self )
            {
                player thread rank::giverankxp( #"buddy_kill", buddy_kill_xp, player.weapon, 1 );
            }
        }
    }
    
    return returnval;
}

// Namespace points
// Params 5
// Checksum 0x6541929, Offset: 0x166f
// Size: 0x2a0
function function_25a6a379d12750a8( var_a51535bd6a837427, objweapon, event, eventinfo, cankillchain )
{
    var_13ebc0f157cb5de8 = isdefined( self.perks[ "specialty_perkstreaks" ] );
    
    if ( !level.allowkillstreaks && !var_13ebc0f157cb5de8 )
    {
        return 0;
    }
    
    if ( level.gametypebundle.var_8fac055b38f4fe9f && !var_13ebc0f157cb5de8 )
    {
        return 0;
    }
    
    if ( isagent( var_a51535bd6a837427 ) )
    {
        return 0;
    }
    
    if ( !var_a51535bd6a837427 player::isreallyalive() )
    {
        return 0;
    }
    
    var_4461d6b59d8bbc21 = event == #"hash_3608ebf29db71598";
    var_91a7e639160601bd = var_a51535bd6a837427 killstreak::isjuggernaut() && !game_utility_mp::isjuggermoshgamemode();
    iskillstreakkill = var_91a7e639160601bd || eventinfo.iskillstreakkill || isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon ) || var_4461d6b59d8bbc21;
    var_8a6ae751a77abeae = level.scoreeventglobals.var_925fd96b69d0c610 || function_1e926c5e888a364b( objweapon );
    
    if ( level.gamemodebundle.streaktypeenabled )
    {
        streaktype = killstreaks::getstreaktype();
        
        if ( !streaktype.chain && iskillstreakkill )
        {
            return 0;
        }
    }
    
    if ( !level.gamemodebundle.var_949c828a91190394 && isdefined( self.perks[ "specialty_chain_killstreaks" ] ) && iskillstreakkill )
    {
        if ( !cankillchain )
        {
            return 0;
        }
        
        if ( !isdefined( self.perks[ "specialty_chain_killstreaks" ] ) )
        {
            var_a51535bd6a837427.pers[ "canKillChain" ] = undefined;
        }
        
        return var_a51535bd6a837427.pers[ "canKillChain" ];
    }
    
    iskill = event == #"kill" || event == #"elimination_kill" || event == #"elimination_assist";
    hasscorestreak = isdefined( var_a51535bd6a837427.perks[ "specialty_strategist" ] ) || isdefined( var_a51535bd6a837427.perks[ "specialty_killstreak_to_scorestreak" ] ) || var_a51535bd6a837427 killstreaks::function_938f935822b1b43d();
    
    if ( !iskill && !hasscorestreak )
    {
        return 0;
    }
    
    if ( level.var_dd30bf39c0753f31 )
    {
        if ( iskill && iskillstreakkill && !hasscorestreak && !isdefined( self.perks[ "specialty_chain_killstreaks" ] ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( objweapon ) && !var_8a6ae751a77abeae )
    {
        return 0;
    }
    
    return 1;
}

// Namespace points
// Params 4, eflags: 0x4
// Checksum 0x23547065, Offset: 0x1918
// Size: 0xa8
function private modifyunifiedpoints( event, points, objweapon, eventinfo )
{
    if ( event == #"damage" )
    {
        return 0;
    }
    
    if ( isdefined( level.modifyunifiedpointscallback ) )
    {
        points = [[ level.modifyunifiedpointscallback ]]( points, event, self, objweapon, eventinfo );
    }
    else
    {
        if ( event == #"headshot" && isdefined( self.headshot_point_scalar ) )
        {
            points *= self.headshot_point_scalar;
        }
        
        if ( isdefined( self.point_scalar ) )
        {
            points *= self.point_scalar;
        }
    }
    
    return int( points );
}

// Namespace points
// Params 2
// Checksum 0x238b402d, Offset: 0x19c9
// Size: 0x138
function displayscoreeventpoints( points, event )
{
    if ( getdvarint( @"scr_disablescoresplash", 0 ) == 1 )
    {
        return;
    }
    
    if ( level.codcasterenabled )
    {
        foreach ( player in level.players )
        {
            if ( player iscodcaster() )
            {
                spectatingplayer = player getspectatingplayer();
                
                if ( isdefined( spectatingplayer ) )
                {
                    spectatingplayerclientnum = spectatingplayer getentitynumber();
                    clientnum = self getentitynumber();
                    
                    if ( spectatingplayerclientnum == clientnum )
                    {
                        player thread rank::scorepointspopup( points );
                        player thread rank::scoreeventpopup( event );
                    }
                }
            }
        }
    }
    
    if ( !level.var_46dc170ddb18e3e9 )
    {
        var_b6096667f5173068 = 0;
        
        if ( game_utility_mp::issimultaneouskillenabled() )
        {
            var_b6096667f5173068 = event == #"kill";
        }
        
        thread rank::scorepointspopup( points, var_b6096667f5173068 );
    }
}

// Namespace points
// Params 1
// Checksum 0xd31b34e4, Offset: 0x1b09
// Size: 0x1e, Type: bool
function function_1e926c5e888a364b( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    return !vehicle::isvehicleweapon( objweapon );
}

// Namespace points
// Params 1
// Checksum 0xfd02657c, Offset: 0x1b30
// Size: 0x6d, Type: bool
function isforcekillstreakprogressweapon( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    if ( isstring( objweapon ) )
    {
        objweapon = makeweapon( objweapon );
    }
    
    switch ( objweapon.basename )
    {
        case #"hash_405f9521b5ee8402":
        case #"hash_448b7248104bfa9c":
        case #"hash_807ae3204119bd41":
        case #"hash_aacdf3a6d5b91585":
            return true;
    }
    
    return false;
}

// Namespace points
// Params 1
// Checksum 0x86ced825, Offset: 0x1ba6
// Size: 0x38
function function_12f8928ed9f98c0b( multiplier )
{
    if ( isdefined( self.perks[ "specialty_underkill" ] ) )
    {
        multiplier *= getdvarfloat( @"hash_1cd604fc4c6912", 3 );
    }
    
    return multiplier;
}

// Namespace points
// Params 1
// Checksum 0x9037a0c1, Offset: 0x1be7
// Size: 0x3c
function function_cc4ceaea968640d2( cash )
{
    if ( cash < 10 )
    {
        cash = int( cash );
    }
    else
    {
        cash = int( max( cash / 10, 1 ) );
    }
    
    br_plunder::playerplunderpickup( cash, undefined, 1 );
}

// Namespace points
// Params 1
// Checksum 0x7f71e917, Offset: 0x1c2b
// Size: 0x18b
function giveluckykillstreak( eventinfo )
{
    is_killstreak_kill = 0;
    
    if ( eventinfo.iskillstreakkill == 1 )
    {
        is_killstreak_kill = 1;
    }
    
    if ( !isdefined( self.var_11373d882fe587a5 ) )
    {
        self.var_11373d882fe587a5 = 1;
    }
    else
    {
        self.var_11373d882fe587a5++;
    }
    
    if ( is_killstreak_kill )
    {
        return;
    }
    
    if ( !isdefined( self.lucky_kill_streak ) )
    {
        self.lucky_kill_streak = 1;
    }
    else
    {
        self.lucky_kill_streak++;
    }
    
    progress = ceil( self.lucky_kill_streak * 100 / 3 );
    self setclientomnvar( "ui_lucky_killstreak_progress", int( progress ) );
    
    if ( self.lucky_kill_streak < 3 )
    {
        return;
    }
    
    self.lucky_kill_streak = 0;
    excludekillstreaklist = [];
    
    if ( isdefined( self.var_253417263996fef6 ) )
    {
        excludekillstreaklist[ excludekillstreaklist.size ] = self.var_253417263996fef6;
    }
    
    if ( isdefined( self.var_253416263996fcc3 ) )
    {
        excludekillstreaklist[ excludekillstreaklist.size ] = self.var_253416263996fcc3;
    }
    
    var_4df919eda4a9baa4 = airdrop::function_b77b0ab5e9d69f35( excludekillstreaklist );
    
    if ( !isdefined( self.var_acdceaa7afaeb323 ) )
    {
        self.var_acdceaa7afaeb323 = 1;
    }
    
    if ( self.var_acdceaa7afaeb323 == 1 )
    {
        self.var_acdceaa7afaeb323 = 2;
        self.var_253417263996fef6 = var_4df919eda4a9baa4;
    }
    else
    {
        self.var_acdceaa7afaeb323 = 1;
        self.var_253416263996fcc3 = var_4df919eda4a9baa4;
    }
    
    killstreaks::awardkillstreak( var_4df919eda4a9baa4, "other" );
    hud_message::showkillstreaksplash( var_4df919eda4a9baa4, 4 );
}

// Namespace points
// Params 2
// Checksum 0x7c0dad6e, Offset: 0x1dbe
// Size: 0x9e
function function_40522c040a4e7b1( team, event )
{
    assert( isdefined( team ) );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player doscoreevent( event );
    }
}

// Namespace points
// Params 2
// Checksum 0xf7a12eed, Offset: 0x1e64
// Size: 0x93
function function_7664124ba4690b6a( players, event )
{
    assert( isdefined( players ) );
    
    foreach ( player in players )
    {
        player doscoreevent( event );
    }
}

// Namespace points
// Params 2
// Checksum 0x2fd77a6c, Offset: 0x1eff
// Size: 0xe2
function function_64df29ab09feee8b( player, event )
{
    if ( !function_2cd20d1ac49bfdf3() )
    {
        return;
    }
    
    bonusthreshold = level.gamemodebundle.var_e1660c9722ed73ca ?? 1000;
    var_46e916b078c23ac0 = getdvarint( @"hash_8e28396bf98b1efd", 0 );
    
    if ( var_46e916b078c23ac0 > 0 )
    {
        bonusthreshold = var_46e916b078c23ac0;
    }
    
    bonusScore = player.pers[ "bonusScore" ];
    scoreprogress = bonusScore >= bonusthreshold ? 1 : bonusScore / bonusthreshold;
    var_e863c9f9fd2f64dd = scoreprogress == 1;
    player setclientomnvar( "ui_killstreak_bonus_meter", scoreprogress );
    
    if ( var_e863c9f9fd2f64dd )
    {
        player killstreaks::givestreakpoints( event, 1, 100 );
        level thread function_a4d7e6250c59331e( player, 1 );
    }
}

// Namespace points
// Params 2
// Checksum 0x9c9b4b5f, Offset: 0x1fe9
// Size: 0x79
function function_a4d7e6250c59331e( player, var_84af36d6ad0625fd )
{
    self notify( #"hash_62c229017e794118" );
    self endon( #"hash_62c229017e794118" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !function_2cd20d1ac49bfdf3() )
    {
        return;
    }
    
    player.pers[ "bonusScore" ] = 0;
    
    if ( var_84af36d6ad0625fd )
    {
        wait var_84af36d6ad0625fd;
    }
    
    player setclientomnvar( "ui_killstreak_bonus_meter", 0 );
}

// Namespace points
// Params 1
// Checksum 0xa453d4d4, Offset: 0x206a
// Size: 0x4b, Type: bool
function function_de6cf556771ca25b( event )
{
    if ( !function_2cd20d1ac49bfdf3() )
    {
        return false;
    }
    
    if ( event != #"kill" && event != #"elimination_kill" && event != #"elimination_assist" )
    {
        return true;
    }
    
    return false;
}

// Namespace points
// Params 0
// Checksum 0x93028bc5, Offset: 0x20be
// Size: 0x46, Type: bool
function function_2cd20d1ac49bfdf3()
{
    if ( !level.gamemodebundle.var_af161b612947bdf )
    {
        return false;
    }
    
    if ( utility::function_9e8f69121ec4b65d( #"hash_673c647280f740fc" ) )
    {
        return false;
    }
    
    if ( !getdvarint( @"hash_91d8e47c501b6b33", 1 ) )
    {
        return false;
    }
    
    return true;
}

