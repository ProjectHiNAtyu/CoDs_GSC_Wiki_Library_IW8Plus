// scripts\asm\shared\sp\utility.gsc  (hash_23366f933e3cf3a6.gscc) (size: 13781 Bytes / 0x35d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b712e0 (112661216)
// size ...... 13781 (0x35d5)
// includes .. 6   (offset: 0x3279)
// strings ... 18  (offset: 0x32a9)
// dev strs .. 32  (offset: 0x33a9)
// exports ... 35  (offset: 0x22bd)
// cseg ...... 0x178 + 0x2145 (0x22bd)
// imports ... 75  (offset: 0x2835)
// animtree1 . 1   (offset: 0x35b9)
// animtree2 . 1   (offset: 0x35c5)
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\sp\art;

#namespace utility;

// Namespace utility
// Params 3
// Checksum 0x667ef2bf, Offset: 0x196
// Size: 0x97
function loopanimfortime( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self endon( #"terminate_ai_threads" );
    endevent = "loop_end";
    t = 2;
    
    if ( isarray( params ) )
    {
        if ( params.size > 0 )
        {
            t = params[ 0 ];
        }
        
        if ( params.size > 1 )
        {
            endevent = params[ 1 ];
        }
    }
    else
    {
        t = params;
    }
    
    thread asm::function_b7619cbe4e9abaf4( asmname, statename, 1 );
    wait t;
    asm::asm_fireevent( asmname, endevent );
}

// Namespace utility
// Params 3
// Checksum 0xfd1aa454, Offset: 0x235
// Size: 0xa9
function loopanimfortime_blendspace( asmname, statename, params )
{
    self endon( statename + "_finished" );
    endevent = "loop_end";
    t = 2;
    
    if ( isarray( params ) )
    {
        if ( params.size > 0 )
        {
            t = params[ 0 ];
        }
        
        if ( params.size > 1 )
        {
            endevent = params[ 1 ];
        }
    }
    else
    {
        t = params;
    }
    
    blankindex = asm::asm_lookupanimfromalias( statename, "blank" );
    self aisetanim( statename, blankindex );
    thread function_7856ebb27be186dc( asmname, statename );
    wait t;
    asm::asm_fireevent( asmname, endevent );
}

// Namespace utility
// Params 2
// Checksum 0xf16721c5, Offset: 0x2e6
// Size: 0x32
function function_7856ebb27be186dc( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        asm::asm_donotetracks( asmname, statename );
    }
}

// Namespace utility
// Params 3
// Checksum 0xf9b82cf8, Offset: 0x320
// Size: 0x63
function function_c58ef9d5cf27835e( asmname, statename, params )
{
    animid = asm::asm_getanim( asmname, statename, params );
    xanim = asm::asm_getxanim( statename, animid );
    self setflaggedanimknob( statename, xanim, 1, 0.2, 1 );
    thread function_7856ebb27be186dc( asmname, statename );
}

// Namespace utility
// Params 3
// Checksum 0x8c7b4ff2, Offset: 0x38b
// Size: 0xc0
function function_76c24566517bcb2f( asmname, statename, params )
{
    self endon( statename + "_finished" );
    endevent = "loop_end";
    t = 2;
    
    if ( isarray( params ) )
    {
        if ( params.size > 0 )
        {
            t = params[ 0 ];
        }
        
        if ( params.size > 1 )
        {
            endevent = params[ 1 ];
        }
    }
    else
    {
        t = params;
    }
    
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    self setanimknob( xanim, 1, 0.2, 1 );
    thread function_7856ebb27be186dc( asmname, statename );
    wait t;
    asm::asm_fireevent( asmname, endevent );
}

// Namespace utility
// Params 2
// Checksum 0xd44999e2, Offset: 0x453
// Size: 0x3d
function handlenotetrack( note, flagname )
{
    switch ( note )
    {
        case #"hash_3f80c02caeb2ec99":
            asm::asm_setupaim( undefined, flagname, 0.3 );
            break;
    }
}

// Namespace utility
// Params 0
// Checksum 0x15e50131, Offset: 0x498
// Size: 0xd
function asm_powerdown()
{
    self.bpowerdown = 1;
}

// Namespace utility
// Params 0
// Checksum 0xa0209a9a, Offset: 0x4ad
// Size: 0xc
function asm_powerup()
{
    self.bpowerdown = undefined;
}

// Namespace utility
// Params 0
// Checksum 0xe2f260b5, Offset: 0x4c1
// Size: 0x11, Type: bool
function wantstocrouch()
{
    return self.currentpose == "crouch";
}

// Namespace utility
// Params 0
// Checksum 0xcc6dca6f, Offset: 0x4db
// Size: 0x1f
function arrivalhack_emptywait()
{
    self waittill( self.a.arrivalasmstatename + "_finished" );
}

// Namespace utility
// Params 6
// Checksum 0xdd20804b, Offset: 0x502
// Size: 0xbb
function animscriptedactor( anime, anim_string, org, animangles, anim_flag, dont_clear )
{
    if ( isstring( anim_flag ) )
    {
        ent_flag_set( anim_flag );
    }
    
    callback_name = anime + "_animscripted";
    callback::callback( callback_name );
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    asm::asm_clearfacialanim();
    asm::function_48f01027f17c6d8( "animscripted", anime );
    self notify( anim_string, "end" );
    
    if ( isstring( anim_flag ) )
    {
        ent_flag_clear( anim_flag );
    }
}

// Namespace utility
// Params 4
// Checksum 0x48e6cb3b, Offset: 0x5c5
// Size: 0x5b
function delayslowmotion( delay, start, end, time )
{
    level.player endon( #"meleegrab_interupt" );
    level.player endon( #"hash_1441bd239f07f75e" );
    wait delay;
    setslowmotion( start, end, time );
}

// Namespace utility
// Params 3
// Checksum 0xc64f21b7, Offset: 0x628
// Size: 0x5a
function delaymodifybasefov( delay, fov, time )
{
    level.player endon( #"meleegrab_interupt" );
    level.player endon( #"hash_1441bd239f07f75e" );
    wait delay;
    level.player modifybasefov( fov, time );
}

// Namespace utility
// Params 8
// Checksum 0x3d8d025c, Offset: 0x68a
// Size: 0x87
function delayenabledof( delay, nearstart, nearend, nearblur, farstart, farend, farblur, time )
{
    level.player endon( #"meleegrab_interupt" );
    level.player endon( #"hash_1441bd239f07f75e" );
    wait delay;
    art::dof_enable_script( nearstart, nearend, nearblur, farstart, farend, farblur, time );
}

// Namespace utility
// Params 1
// Checksum 0x7b202aae, Offset: 0x719
// Size: 0x43
function delaydisabledof( delay )
{
    level.player endon( #"meleegrab_interupt" );
    level.player endon( #"hash_1441bd239f07f75e" );
    wait delay;
    art::dof_disable_script( 0.5 );
}

#using_animtree( "player" );

// Namespace utility
// Params 0
// Checksum 0x34b1af26, Offset: 0x764
// Size: 0x5d
function spawnplayerrig()
{
    player_rig = spawn( "script_model", level.player.origin );
    player_rig.root = %root;
    player_rig setmodel( "viewmodel_base_viewhands_iw7" );
    player_rig useanimtree( #animtree );
    player_rig hide();
    return player_rig;
}

// Namespace utility
// Params 1
// Checksum 0x8dc7582e, Offset: 0x7ca
// Size: 0x133
function playergrabbed( type )
{
    level.player val::set( "PlayerGrabbed", "action_slot_weapon", 0 );
    
    if ( !isdefined( type ) )
    {
        level.player disableweapons();
        level.player disableusability();
        level.player allowstand( 1 );
        level.player allowcrouch( 0 );
        level.player allowprone( 0 );
    }
    else if ( type == "seeker" )
    {
        level.player disableweapons();
        level.player allowstand( 1 );
        level.player allowcrouch( 0 );
        level.player allowprone( 0 );
    }
    else if ( type == "crawlmelee" )
    {
        level.player disableusability();
        level.player allowstand( 0 );
        level.player allowcrouch( 1 );
        level.player allowprone( 0 );
    }
    
    level.player allowoffhandshieldweapons( 0 );
    level.player enableslowaim( 0.2, 0.5 );
}

// Namespace utility
// Params 0
// Checksum 0xe914778d, Offset: 0x905
// Size: 0x81
function playerletgo()
{
    level.player allowstand( 1 );
    level.player allowcrouch( 1 );
    level.player allowprone( 1 );
    level.player enableweapons();
    level.player allowoffhandshieldweapons( 1 );
    level.player disableslowaim();
    level.player enableusability();
    level.player val::reset_all( "PlayerGrabbed" );
}

// Namespace utility
// Params 0
// Checksum 0x33ed7130, Offset: 0x98e
// Size: 0x12b
function playerhealth()
{
    self endon( #"death" );
    wait 0.2;
    time = 3;
    timer = gettime() + time * 1000;
    self.health_overlay.alpha += ( 1 - level.player.health_overlay.alpha ) * 0.8;
    self.health_overlay fadeovertime( 3 );
    self.health_overlay.alpha = 0;
    
    while ( gettime() < timer )
    {
        if ( self.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( self.disable_breathing_sound ) && self.disable_breathing_sound )
        {
            continue;
        }
        
        if ( isdefined( level.gameskill_breath_func ) )
        {
            [[ level.gameskill_breath_func ]]( "breathing_hurt" );
        }
        else
        {
            self playlocalsound( "breathing_hurt" );
        }
        
        breathing_time = 0.1;
        wait breathing_time + randomfloat( 0.8 );
    }
}

// Namespace utility
// Params 0
// Checksum 0xdd8c99df, Offset: 0xac1
// Size: 0x17
function meleegrab_common()
{
    self.hackable = 0;
    self.bmeleeinprogress = 1;
    InvalidOpCode( 0x97 );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace utility
// Params 1
// Checksum 0x8d1c574e, Offset: 0xb50
// Size: 0x153
function meleegrab_counterinput( animtime )
{
    level.player endon( #"meleegrab_interupt" );
    level.player endon( #"hash_d133506cca2a7dbd" );
    countertime = 0.5;
    time = gettime();
    start_delay = animtime - countertime;
    start_time = time + start_delay * 1000;
    end_delay = animtime;
    end_time = time + end_delay * 1000;
    thread meleegrab_slowmo( start_delay, end_delay );
    thread meleegrab_counterhint( start_delay, countertime );
    
    while ( playercounterpress() )
    {
        wait 0.05;
    }
    
    for ( ;; )
    {
        time = gettime();
        
        if ( time >= end_time )
        {
            break;
        }
        
        if ( playercounterpress() )
        {
            if ( time > start_time && time < end_time )
            {
                if ( isdefined( self.melee.meleecounterhint ) )
                {
                    level.player thread counterhintdestroy( 0.1 );
                }
                
                self.melee.countersuccess = 1;
                level.player notify( #"bt_meleegrab_slowmo" );
                return;
            }
        }
        
        wait 0.05;
    }
    
    level.player notify( #"bt_meleegrab_slowmo" );
}

// Namespace utility
// Params 2
// Checksum 0x99e4a8c5, Offset: 0xcab
// Size: 0x84
function meleegrab_slowmo( start_delay, end_delay )
{
    level.player endon( #"meleegrab_interupt" );
    wait start_delay;
    setslowmotion( 1, 0.3, 0.1 );
    
    if ( !isdefined( self.melee.countersuccess ) )
    {
        level.player waittill( #"bt_meleegrab_slowmo" );
    }
    else
    {
        wait 0.05;
    }
    
    setslowmotion( 0.2, 1, 0.05 );
}

// Namespace utility
// Params 0
// Checksum 0xf5426848, Offset: 0xd37
// Size: 0x20, Type: bool
function playercounterpress()
{
    return isalive( level.player ) && level.player meleebuttonpressed();
}

// Namespace utility
// Params 2
// Checksum 0x696656a5, Offset: 0xd60
// Size: 0x365
function meleegrab_counterhint( delay, presstime )
{
    level.player endon( #"meleegrab_interupt" );
    growtime = 0.2;
    post_growtime = 0.3;
    wait delay - growtime - 0.05;
    
    if ( isdefined( self.melee.meleecounterhint ) )
    {
        self.melee.meleecounterhint destroy();
    }
    
    self.melee.meleecounterhint = newclienthudelem( level.player );
    self.melee.meleecounterhint.color = ( 1, 1, 1 );
    self.melee.meleecounterhint settext( &"script_platform/hint_melee_counter" );
    self.melee.meleecounterhint.x = 0;
    self.melee.meleecounterhint.y = 20;
    self.melee.meleecounterhint.alignx = "center";
    self.melee.meleecounterhint.aligny = "middle";
    self.melee.meleecounterhint.horzalign = "center";
    self.melee.meleecounterhint.vertalign = "middle";
    self.melee.meleecounterhint.foreground = 1;
    self.melee.meleecounterhint.alpha = 0;
    self.melee.meleecounterhint.fontscale = 0.5;
    self.melee.meleecounterhint.hidewhendead = 1;
    self.melee.meleecounterhint.sort = -1;
    self.melee.meleecounterhint endon( #"death" );
    self.melee.meleecounterhint fadeovertime( growtime );
    self.melee.meleecounterhint changefontscaleovertime( growtime );
    self.melee.meleecounterhint.fontscale = 1.3;
    self.melee.meleecounterhint.alpha = 1;
    wait growtime;
    
    if ( !isdefined( self.melee.meleecounterhint ) )
    {
        return;
    }
    
    self.melee.meleecounterhint fadeovertime( post_growtime );
    self.melee.meleecounterhint changefontscaleovertime( post_growtime );
    self.melee.meleecounterhint.fontscale = 1.2;
}

// Namespace utility
// Params 3
// Checksum 0x51534196, Offset: 0x10cd
// Size: 0x3c, Type: bool
function meleeset( asmname, statename, params )
{
    return isdefined( level.player.melee.countersuccess );
}

// Namespace utility
// Params 3
// Checksum 0x20dcd9ae, Offset: 0x1112
// Size: 0x5d, Type: bool
function meleecountered( asmname, statename, params )
{
    return isdefined( level.player.melee.countersuccess ) && level.player.melee.countersuccess;
}

// Namespace utility
// Params 3
// Checksum 0xa106afb0, Offset: 0x1178
// Size: 0x5e, Type: bool
function meleecounteredfailed( asmname, statename, params )
{
    return isdefined( level.player.melee.countersuccess ) && !level.player.melee.countersuccess;
}

// Namespace utility
// Params 1
// Checksum 0xf21a6133, Offset: 0x11df
// Size: 0x10a
function counterhintdestroy( fade )
{
    if ( isdefined( fade ) )
    {
        level.player.melee.meleecounterhint fadeovertime( fade );
        level.player.melee.meleecounterhint changefontscaleovertime( fade );
        level.player.melee.meleecounterhint.fontscale = 2;
        level.player.melee.meleecounterhint.alpha = 0;
        wait fade;
    }
    
    if ( level.player.in_melee && isdefined( level.player.melee.meleecounterhint ) )
    {
        level.player.melee.meleecounterhint destroy();
    }
}

/#

    // Namespace utility
    // Params 1
    // Checksum 0xe88d9c6a, Offset: 0x12f1
    // Size: 0x119, Type: dev
    function function_fabd5e7657d842c7( asmname )
    {
        wait 1;
        ai_array = getaiarray();
        assert( ai_array.size > 0 );
        my_ai = ai_array[ 0 ];
        asm = anim.asm[ asmname ];
        
        foreach ( statename, state in asm.states )
        {
            if ( !isdefined( state.flags ) || !( arraycontains( state.flags, "<dev string:x24>" ) || arraycontains( state.flags, "<dev string:x31>" ) ) )
            {
                continue;
            }
            
            println( "<dev string:x35>" + statename + "<dev string:x48>" );
        }
    }

    // Namespace utility
    // Params 2
    // Checksum 0xa7d67c81, Offset: 0x1412
    // Size: 0x1fa, Type: dev
    function function_b63ff545e590ee64( asmname, archetypename )
    {
        var_6a04752d0315cd76 = asmdevgetallnotetrackaimstates( asmname );
        
        foreach ( statename in var_6a04752d0315cd76 )
        {
            if ( issubstr( statename, "<dev string:x5e>" ) )
            {
                continue;
            }
            
            aliases = archetypegetaliases( archetypename, statename );
            assert( isdefined( aliases ), "<dev string:x66>" + statename + "<dev string:x8b>" + archetypename );
            
            foreach ( alias in aliases )
            {
                if ( issubstr( alias, "<dev string:x31>" ) || issubstr( alias, "<dev string:x94>" ) || issubstr( alias, "<dev string:x9c>" ) )
                {
                    continue;
                }
                
                anims = asm::asm_getallanimsforalias( archetypename, statename, alias );
                
                if ( !isdefined( anims ) )
                {
                    continue;
                }
                
                foreach ( xanim in anims )
                {
                    function_393f7331e6b5ac05( asmname, statename, xanim, "<dev string:xa1>" );
                }
            }
        }
    }

    // Namespace utility
    // Params 2
    // Checksum 0x3fbac6e4, Offset: 0x1614
    // Size: 0x71, Type: dev
    function function_1928afd33824b5a2( asmname, arcname )
    {
        allstates = asmdevgetallstates( asmname );
        numstates = allstates.size;
        
        for ( istate = 0; istate < numstates ; istate++ )
        {
            if ( !isdefined( self asmgetfacialstate( asmname, allstates[ istate ] ) ) )
            {
                println( asmname + "<dev string:xab>" + allstates[ istate ] );
            }
        }
    }

    // Namespace utility
    // Params 2
    // Checksum 0xf14054f7, Offset: 0x168d
    // Size: 0x344, Type: dev
    function function_452af855f21e6412( asmname, archetypename )
    {
        wait 1;
        ai_array = getaiarray();
        assert( ai_array.size > 0 );
        my_ai = ai_array[ 0 ];
        asm = anim.asm[ asmname ];
        
        foreach ( statename, state in asm.states )
        {
            if ( !issubstr( statename, "<dev string:xbe>" ) )
            {
                continue;
            }
            
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( !isdefined( aliases ) || aliases.size == 0 )
            {
                continue;
            }
            
            foreach ( alias in aliases )
            {
                if ( issubstr( alias, "<dev string:x31>" ) || issubstr( alias, "<dev string:x94>" ) || issubstr( alias, "<dev string:x9c>" ) )
                {
                    continue;
                }
                
                anim_array = undefined;
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ 0 ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = animstruct.anims;
                    }
                }
                
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ anim_array.size ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = arraycombineunique( anim_array, animstruct.anims );
                    }
                }
                
                if ( !isdefined( anim_array ) || anim_array.size == 0 )
                {
                    println( "<dev string:xc4>" + statename + "<dev string:xcb>" + alias + "<dev string:xd3>" );
                    continue;
                }
                
                foreach ( anime in anim_array )
                {
                    times = getnotetracktimes( anime, "<dev string:xee>" );
                    
                    if ( !isdefined( times ) || times.size == 0 )
                    {
                        println( string( anime ) + "<dev string:xfc>" );
                        continue;
                    }
                    
                    animlength = getanimlength( anime );
                    maxtime = ( animlength - 0.1 ) / animlength;
                    
                    if ( times[ 0 ] > maxtime )
                    {
                        println( string( anime ) + "<dev string:x127>" );
                    }
                }
            }
        }
    }

    // Namespace utility
    // Params 2
    // Checksum 0xef5b5a7, Offset: 0x19d9
    // Size: 0x46e, Type: dev
    function function_fa76b3dbe5acd610( asmname, archetypename )
    {
        wait 1;
        ai_array = getaiarray();
        assert( ai_array.size > 0 );
        my_ai = ai_array[ 0 ];
        asm = anim.asm[ asmname ];
        
        foreach ( statename, state in asm.states )
        {
            if ( issubstr( statename, "<dev string:x168>" ) )
            {
                continue;
            }
            
            is_turn_state = issubstr( statename, "<dev string:x170>" );
            is_arrival_state = issubstr( statename, "<dev string:x175>" ) && !issubstr( statename, "<dev string:x17d>" );
            is_exit_state = issubstr( statename, "<dev string:x184>" ) && !issubstr( statename, "<dev string:x17d>" );
            
            if ( issubstr( statename, "<dev string:x189>" ) && !is_turn_state )
            {
                continue;
            }
            
            if ( !is_turn_state && !is_arrival_state && !is_exit_state )
            {
                continue;
            }
            
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( !isdefined( aliases ) || aliases.size == 0 )
            {
                continue;
            }
            
            foreach ( alias in aliases )
            {
                if ( issubstr( alias, "<dev string:x31>" ) || issubstr( alias, "<dev string:x94>" ) || issubstr( alias, "<dev string:x9c>" ) )
                {
                    continue;
                }
                
                if ( ( is_arrival_state || is_exit_state ) && !( issubstr( alias, "<dev string:x191>" ) || issubstr( alias, "<dev string:x193>" ) || issubstr( alias, "<dev string:x195>" ) ) )
                {
                    continue;
                }
                
                if ( is_turn_state && issubstr( alias, "<dev string:x184>" ) )
                {
                    continue;
                }
                
                anim_array = undefined;
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ 0 ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = animstruct.anims;
                    }
                }
                
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ anim_array.size ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = arraycombineunique( anim_array, animstruct.anims );
                    }
                }
                
                if ( !isdefined( anim_array ) || anim_array.size == 0 )
                {
                    println( "<dev string:xc4>" + statename + "<dev string:xcb>" + alias + "<dev string:xd3>" );
                    continue;
                }
                
                foreach ( anime in anim_array )
                {
                    times = getnotetracktimes( anime, "<dev string:x197>" );
                    
                    if ( !isdefined( times ) || times.size == 0 )
                    {
                        if ( is_exit_state )
                        {
                            times = getnotetracktimes( anime, "<dev string:x19e>" );
                            
                            if ( !isdefined( times ) || times.size == 0 )
                            {
                                println( string( anime ) + "<dev string:x1a9>" );
                            }
                            else
                            {
                                println( string( anime ) + "<dev string:x1cd>" );
                            }
                        }
                        else
                        {
                            println( string( anime ) + "<dev string:x1a9>" );
                        }
                        
                        continue;
                    }
                    
                    animlength = getanimlength( anime );
                    maxtime = ( animlength - 0.1 ) / animlength;
                    
                    if ( times[ 0 ] > maxtime )
                    {
                        println( string( anime ) + "<dev string:x20f>" );
                    }
                }
            }
        }
    }

    // Namespace utility
    // Params 2
    // Checksum 0x2f749add, Offset: 0x1e4f
    // Size: 0x46e, Type: dev
    function function_e4a8a805d1c53cd9( asmname, archetypename )
    {
        wait 1;
        ai_array = getaiarray();
        assert( ai_array.size > 0 );
        my_ai = ai_array[ 0 ];
        asm = anim.asm[ asmname ];
        
        foreach ( statename, state in asm.states )
        {
            if ( issubstr( statename, "<dev string:x168>" ) )
            {
                continue;
            }
            
            is_turn_state = issubstr( statename, "<dev string:x170>" );
            is_arrival_state = issubstr( statename, "<dev string:x175>" ) && !issubstr( statename, "<dev string:x17d>" );
            is_exit_state = issubstr( statename, "<dev string:x184>" ) && !issubstr( statename, "<dev string:x17d>" );
            
            if ( issubstr( statename, "<dev string:x189>" ) && !is_turn_state )
            {
                continue;
            }
            
            if ( !is_turn_state && !is_arrival_state && !is_exit_state )
            {
                continue;
            }
            
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( !isdefined( aliases ) || aliases.size == 0 )
            {
                continue;
            }
            
            foreach ( alias in aliases )
            {
                if ( issubstr( alias, "<dev string:x31>" ) || issubstr( alias, "<dev string:x94>" ) || issubstr( alias, "<dev string:x9c>" ) )
                {
                    continue;
                }
                
                if ( ( is_arrival_state || is_exit_state ) && !( issubstr( alias, "<dev string:x191>" ) || issubstr( alias, "<dev string:x193>" ) || issubstr( alias, "<dev string:x195>" ) ) )
                {
                    continue;
                }
                
                if ( is_turn_state && issubstr( alias, "<dev string:x184>" ) )
                {
                    continue;
                }
                
                anim_array = undefined;
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ 0 ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = animstruct.anims;
                    }
                }
                
                animstruct = archetypegetalias( archetypename, statename, alias );
                
                if ( isdefined( animstruct ) )
                {
                    if ( !isarray( animstruct.anims ) )
                    {
                        anim_array[ anim_array.size ] = animstruct.anims;
                    }
                    else
                    {
                        anim_array = arraycombineunique( anim_array, animstruct.anims );
                    }
                }
                
                if ( !isdefined( anim_array ) || anim_array.size == 0 )
                {
                    println( "<dev string:xc4>" + statename + "<dev string:xcb>" + alias + "<dev string:xd3>" );
                    continue;
                }
                
                foreach ( anime in anim_array )
                {
                    times = getnotetracktimes( anime, "<dev string:x197>" );
                    
                    if ( !isdefined( times ) || times.size == 0 )
                    {
                        if ( is_exit_state )
                        {
                            times = getnotetracktimes( anime, "<dev string:x19e>" );
                            
                            if ( !isdefined( times ) || times.size == 0 )
                            {
                                println( string( anime ) + "<dev string:x1a9>" );
                            }
                            else
                            {
                                println( string( anime ) + "<dev string:x1cd>" );
                            }
                        }
                        else
                        {
                            println( string( anime ) + "<dev string:x1a9>" );
                        }
                        
                        continue;
                    }
                    
                    animlength = getanimlength( anime );
                    maxtime = ( animlength - 0.1 ) / animlength;
                    
                    if ( times[ 0 ] > maxtime )
                    {
                        println( string( anime ) + "<dev string:x20f>" );
                    }
                }
            }
        }
    }

#/
