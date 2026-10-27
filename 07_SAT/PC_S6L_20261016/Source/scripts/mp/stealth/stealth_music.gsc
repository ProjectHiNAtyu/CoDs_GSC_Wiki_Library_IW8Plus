// scripts\mp\stealth\stealth_music.gsc  (hash_6639660db85dc7cb.gscc) (size: 5617 Bytes / 0x15f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97525595 (2538755477)
// size ...... 5617 (0x15f1)
// includes .. 2   (offset: 0x14a1)
// strings ... 15  (offset: 0x14b1)
// dev strs .. 8   (offset: 0x1591)
// exports ... 9   (offset: 0xe81)
// cseg ...... 0x160 + 0xd21 (0xe81)
// imports ... 39  (offset: 0xfe9)
// animtree1 . 0   (offset: 0x15f1)
// animtree2 . 0   (offset: 0x15f1)
#using scripts\common\ai\stealth\player;
#using scripts\common\utility;

#namespace stealth_music;

// Namespace stealth_music
// Params 0
// Checksum 0x1b43c7d2, Offset: 0x17e
// Size: 0x9
function main()
{
    childthread stealth_combat_music_init();
}

// Namespace stealth_music
// Params 0
// Checksum 0x664b124b, Offset: 0x18f
// Size: 0xcc
function stealth_combat_music_init()
{
    utility::flag_wait( "level_stealth_initialized" );
    setdvar( @"hash_4a4de8b30c5647a8", 1 );
    level.music_array[ 0 ] = "a";
    level.music_array[ 1 ] = "b";
    level.music_array[ 2 ] = "c";
    
    if ( getdvarint( @"scr_updated_stealth_music", 0 ) == 0 )
    {
        level.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
        level utility::flag_set( "threat_sight_audio_enabled" );
    }
    
    level.hvts_identified = 0;
    
    if ( utility::issharedfuncdefined( #"stealth_music", #"init" ) )
    {
        [[ utility::getsharedfunc( #"stealth_music", #"init" ) ]]();
    }
}

// Namespace stealth_music
// Params 1
// Checksum 0xd051087d, Offset: 0x263
// Size: 0x12c
function function_5197bc70e9265f24( params )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    player = self;
    
    if ( player.processed_key )
    {
        return;
    }
    
    if ( getdvarint( @"scr_updated_stealth_music", 0 ) )
    {
        player thread function_2d41d45f420c2ad();
    }
    
    player.fnstealthmusictransition = &stealth_music_transition_cp;
    player.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
    player utility::ent_flag_init( "player_in_combat" );
    player thread player::combatstate_thread();
    player.processed_key = 1;
    player.stealth.combatstate.maxcombatdist = 2000;
    player.stealth_combat_music_state = player.stealth.combatstate.name;
    player.stealth_combat_music_state_type = player.stealth.combatstate.type;
    player.music_last_stealth_cue = "";
}

// Namespace stealth_music
// Params 2
// Checksum 0xa2452ba4, Offset: 0x397
// Size: 0x26
function function_9d6f5db15bf157a( message, delay )
{
    self endon( message );
    wait delay;
    utility::ent_flag_clear( message );
}

// Namespace stealth_music
// Params 1
// Checksum 0xc30b03cf, Offset: 0x3c5
// Size: 0x132
function stealth_music_transition_cp( aliasto )
{
    self notify( #"stealth_music_transition_cp" );
    self endon( #"stealth_music_transition_cp" );
    self endon( #"disconnect" );
    assert( isplayer( self ) );
    
    if ( !isdefined( self.stealth ) )
    {
        thread player::main();
    }
    
    if ( level.var_2344e5d7f5b341d3 )
    {
        level.var_2344e5d7f5b341d3 = undefined;
        return;
    }
    
    if ( !isdefined( self.currentalias ) )
    {
        self.currentalias = "init";
    }
    
    transitiontime = 1;
    frametime = 0.05;
    
    if ( !isdefined( self.stealth.music_ent ) )
    {
        self.stealth.music_ent = [];
    }
    
    alias = aliasto;
    
    if ( !isdefined( aliasto ) )
    {
        self setplayermusicstate( "" );
        self.currentalias = "";
        return;
    }
    
    if ( aliasto != self.currentalias )
    {
        thread player_music_loop( alias );
        return;
    }
    
    self setplayermusicstate( "" );
    self.currentalias = "";
}

// Namespace stealth_music
// Params 1
// Checksum 0x8658fe80, Offset: 0x4ff
// Size: 0xb3
function player_music_loop( music_state )
{
    self notify( #"player_music_loop" );
    self endon( #"player_music_loop" );
    self endon( #"disconnect" );
    
    if ( self.currentalias != "init" && music_state == "" )
    {
        self setplayermusicstate( "" );
    }
    
    self.currentalias = music_state;
    
    if ( isdefined( music_state ) && music_state != "" && music_state != "init" )
    {
        self setplayermusicstate( music_state );
        
        if ( !level.var_4679b423aed8e000 )
        {
            wait 60;
            self setplayermusicstate( "" );
            self.currentalias = "";
        }
    }
}

// Namespace stealth_music
// Params 3
// Checksum 0xdaf391a3, Offset: 0x5ba
// Size: 0x85d
function threat_sight_player_sight_audio( anycansee, maxthreat, willdebugprint )
{
    var_abc39187f7beabab = 180;
    var_75e5b1bee5d67ecf = 0.01;
    threat_max_vol = 0.05;
    smoothing_alpha = 0.125;
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"threat_sight_player_sight_audio" );
    self endon( #"threat_sight_player_sight_audio" );
    level endon( #"hash_429ec9f239bdec5f" );
    
    /#
        if ( !isdefined( willdebugprint ) )
        {
            willdebugprint = 0;
        }
    #/
    
    aliases = [ "cp_stealth_threat_low", "cp_stealth_threat_med", "cp_stealth_threat_high" ];
    rumble = "damage_light";
    
    if ( !getdvarint( @"hash_21b72d8c9ff7a1b3", 0 ) )
    {
        maxthreat = 0;
    }
    
    if ( !isdefined( self.stealth.threat_sight_snd_ent ) && anycansee && maxthreat > 0 )
    {
        self.stealth.threat_sight_snd_ent = [];
        self.stealth.threat_sight_snd_vol = 0;
        self.stealth.threat_sight_snd_threat = 0;
        
        foreach ( index, alias in aliases )
        {
            snd_ent = spawn( "script_origin", self.origin );
            
            if ( !isplayer( self ) )
            {
                thread utility::delete_on_death( snd_ent );
            }
            else
            {
                snd_ent showonlytoplayer( self );
            }
            
            snd_ent linkto( self );
            
            if ( isplayer( self ) )
            {
                self setsoundsubmix( alias, 0, 1 );
            }
            
            snd_ent.isplaying = 0;
            self.stealth.threat_sight_snd_ent[ alias ] = snd_ent;
        }
    }
    
    /#
        if ( willdebugprint )
        {
            printtoscreen2d( 32, 492, "<dev string:x24>" + maxthreat + "<dev string:x32>" + anycansee + "<dev string:x35>", ( 1, 1, 1 ), 1.5 );
        }
    #/
    
    if ( isdefined( self.stealth.threat_sight_snd_ent ) )
    {
        self.stealth.threat_sight_snd_threat -= self.stealth.threat_sight_snd_threat * smoothing_alpha;
        self.stealth.threat_sight_snd_threat += maxthreat * smoothing_alpha;
        
        if ( self.stealth.threat_sight_snd_threat < 0.0001 )
        {
            self.stealth.threat_sight_snd_threat = 0;
        }
        
        maxthreat = self.stealth.threat_sight_snd_threat;
    }
    
    while ( isdefined( self.stealth.threat_sight_snd_ent ) )
    {
        index = 0;
        var_d167eaf46a9d236 = 0;
        
        if ( maxthreat > 0 )
        {
            stealthmaxthreatenemy = getstealthmaxthreatenemy( self );
            
            if ( maxthreat < threat_max_vol )
            {
                threat_clamped = clamp( maxthreat, 0, threat_max_vol );
                mu = threat_clamped / threat_max_vol;
                vol_delta = 1 - var_75e5b1bee5d67ecf;
                vol_lerp = var_75e5b1bee5d67ecf + vol_delta * mu;
                self.stealth.threat_sight_snd_vol = vol_lerp;
            }
            else
            {
                self.stealth.threat_sight_snd_vol = 1;
            }
        }
        else
        {
            self.stealth.threat_sight_snd_vol = 0;
            self.stealth.threat_sight_snd_threat = 0;
        }
        
        self.stealth.threat_sight_snd_vol = clamp( self.stealth.threat_sight_snd_vol, 0, 1 );
        
        /#
            if ( willdebugprint )
            {
                printtoscreen2d( 32, 508, "<dev string:x37>" + self.stealth.threat_sight_snd_threat, ( 1, 1, 1 ), 1.5 );
            }
            
            if ( willdebugprint )
            {
                printtoscreen2d( 32, 524, "<dev string:x45>" + self.stealth.threat_sight_snd_vol, ( 1, 1, 1 ), 1.5 );
            }
        #/
        
        foreach ( alias, snd_ent in self.stealth.threat_sight_snd_ent )
        {
            coef = 1;
            
            switch ( index )
            {
                case 0:
                    if ( maxthreat < 0.75 )
                    {
                        coef = cos( var_abc39187f7beabab * maxthreat * 0.666 );
                    }
                    else
                    {
                        coef = 0;
                    }
                    
                    break;
                case 1:
                    if ( maxthreat < 0.75 )
                    {
                        coef = sin( var_abc39187f7beabab * maxthreat * 0.666 );
                    }
                    else if ( maxthreat < 1 )
                    {
                        coef = sin( var_abc39187f7beabab * ( 1 - maxthreat ) * 2 );
                    }
                    else
                    {
                        coef = 0;
                    }
                    
                    break;
                case 2:
                    if ( maxthreat < 0.75 )
                    {
                        coef = 0;
                    }
                    else
                    {
                        coef = cos( var_abc39187f7beabab * ( 1 - maxthreat ) * 2 );
                    }
                    
                    break;
            }
            
            vol = clamp( self.stealth.threat_sight_snd_vol * coef, 0, 1 );
            
            if ( anycansee )
            {
                var_d167eaf46a9d236 = 1;
                
                if ( snd_ent.isplaying == 0 )
                {
                    if ( isplayer( self ) )
                    {
                        self setsoundsubmix( alias, 0, 1 );
                    }
                    
                    snd_ent utility::delaycall( 0.1, &playloopsound, alias );
                    snd_ent.isplaying = 1;
                    self playrumblelooponentity( rumble );
                }
                
                submix_vol = ( vol - 1 ) * -1;
                
                if ( isplayer( self ) )
                {
                    self scalesoundsubmix( alias, submix_vol );
                }
            }
            else if ( snd_ent.isplaying == 1 )
            {
                if ( isplayer( self ) )
                {
                    self setsoundsubmix( alias, 1, 1 );
                }
                
                snd_ent utility::delaycall( 1, &stoploopsound );
                snd_ent.isplaying = 0;
                self stoprumble( rumble );
            }
            
            /#
                if ( willdebugprint )
                {
                    printtoscreen2d( 32, 540 + index * 16, "<dev string:x53>" + index + "<dev string:x5a>" + vol, ( 1, 1, 1 ), 1.5 );
                }
                
                if ( willdebugprint )
                {
                    printtoscreen2d( 384, 540 + index * 16, "<dev string:x61>" + coef, ( 1, 1, 1 ), 1.5 );
                }
            #/
            
            index++;
        }
        
        if ( !var_d167eaf46a9d236 )
        {
            foreach ( alias, snd_ent in self.stealth.threat_sight_snd_ent )
            {
                if ( isplayer( self ) )
                {
                    self setsoundsubmix( alias, 1, 1 );
                }
                
                snd_ent utility::delaycall( 0.9, &stoploopsound );
                snd_ent utility::delaycall( 1, &delete );
            }
            
            self.stealth.threat_sight_snd_ent = undefined;
            self.stealth.threat_sight_snd_vol = undefined;
            self.stealth.threat_sight_snd_threat = undefined;
        }
        
        wait 0.25;
    }
}

// Namespace stealth_music
// Params 0
// Checksum 0xdee81beb, Offset: 0xe1f
// Size: 0x62
function function_2d41d45f420c2ad()
{
    level endon( #"hash_4bc572315aec76d4" );
    
    while ( true )
    {
        self waittill( #"hash_21bbbc18ef67e66" );
        
        if ( !self.var_8871c51ec41e29b9 )
        {
            self setplayermusicstate( "mx_cp_hydro_stealth_hidden" );
            self.var_8871c51ec41e29b9 = 1;
            
            while ( utility::flag( "stealth_spotted" ) )
            {
                waitframe();
            }
            
            self.var_8871c51ec41e29b9 = undefined;
        }
    }
}

