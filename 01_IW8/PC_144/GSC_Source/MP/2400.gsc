// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

getinfilpath( var_0 )
{
    var_1 = scripts\engine\utility::getstructarray( var_0, "targetname" );

    if ( !isdefined( var_1 ) )
        return;

    foreach ( var_3 in var_1 )
    {
        if ( istrue( level.interactiveinfil ) )
        {
            if ( isdefined( var_3.script_noteworthy ) && var_3.script_noteworthy == "interactive" )
                return var_3;
        }
        else if ( !isdefined( var_3.script_noteworthy ) || var_3.script_noteworthy != "interactive" )
            return var_3;
    }
}

player_unlink( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    if ( var_1 islinked() )
        var_1 unlink();
}

player_free_look( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    if ( var_1 islinked() )
        var_1 lerpviewangleclamp( 0, 0, 0, 45, 45, 45, 45 );
}

player_fov_80_instant( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 lerpfovbypreset( "80_instant" );
}

watch_for_total_counts_below_num( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 lerpfovbypreset( "zombiearcade" );
}

player_fov_default_2( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 lerpfovbypreset( "default_2seconds" );
}

player_lock_look_1_second( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    if ( var_1 islinked() )
        var_1 lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
}

player_lock_look_2_second( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    if ( var_1 islinked() )
        var_1 lerpviewangleclamp( 2, 0.5, 0.5, 0, 0, 0, 0 );
}

player_lock_look_instant( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    if ( var_1 islinked() )
        var_1 lerpviewangleclamp( 0, 0, 0, 0, 0, 0, 0 );
}

rumble_low( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread updateshakeonplayer( undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1 );
}

cam_shake_low( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread updateshakeonplayer( 0.06, 0.075, 2, var_1.origin, 8000, "mig_rumble", 0.05, 0.1 );
}

cam_shake_running( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread updateshakeonplayer( 0.09, 0.115, 2, var_1.origin, 8000, undefined, 0.15, 0.5 );
}

cam_shake_parked( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread updateshakeonplayer( 0.065, 0.09, 0.5, var_1.origin, 8000, undefined, 0.15, 0.5 );
}

cam_shake_off( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 notify( "stop_cam_shake" );
}

updateshakeonplayer( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( istrue( level.interactiveinfil ) && istrue( self.interactivecombat ) )
        return;

    self notify( "stop_cam_shake" );
    self endon( "stop_cam_shake" );
    level endon( "prematch_over" );
    level endon( "infil_done" );
    self endon( "death_or_disconnect" );

    while ( isdefined( self ) )
    {
        if ( isdefined( var_0 ) && isdefined( var_1 ) )
            self earthquakeforplayer( randomfloatrange( var_0, var_1 ), var_2, var_3, var_4 );

        if ( isdefined( var_5 ) )
            self playrumbleonpositionforclient( var_5, self.origin );

        wait( randomfloatrange( var_6, var_7 ) );
    }
}

hideactors()
{
    if ( !isdefined( self.actors ) )
        return;

    foreach ( var_1 in self.actors )
        var_1 hide();
}

showactors()
{
    if ( !isdefined( self.actors ) )
        return;

    foreach ( var_1 in self.actors )
        var_1 show();
}

setcinematicmotion_heli( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 setcinematicmotionoverride( "player_heli_ride" );
}

setcinematicmotion_playermotion( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 setcinematicmotionoverride( "iw8_playermotion_mp" );
}

setcinematicmotion_disabled( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 setcinematicmotionoverride( "disabled" );
}

set_cinematicmotionomnvaroverrides( var_0 )
{
    self setclientomnvar( "handheld_camera_rotation_move_mod_override", var_0 );
    self setclientomnvar( "handheld_camera_rotation_view_mod_override", var_0 );
    self setclientomnvar( "handheld_camera_translation_move_mod_override", var_0 );
    self setclientomnvar( "handheld_camera_translation_view_mod_override", var_0 );
}

set_cinematicmotionomnvarovertime( var_0, var_1, var_2 )
{
    self endon( "death_or_disconnect" );
    var_3 = gettime();
    var_2 = var_2 * 1000;
    var_4 = int( var_3 + var_2 );
    var_5 = abs( var_0 - var_1 );

    for (;;)
    {
        var_3 = gettime();
        var_6 = clamp( 1.0 - ( var_4 - var_3 ) / var_2, 0.0, 1.0 );
        var_7 = scripts\engine\utility::ter_op( var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6 );
        set_cinematicmotionomnvaroverrides( var_7 );

        if ( var_6 == 1.0 )
            break;

        waitframe();
    }
}

setcinematicmotion_omnvaroverride_max_instant( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 set_cinematicmotionomnvaroverrides( 1.0 );
}

setcinematicmotion_omnvaroverride_max_1( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 0.0, 1.0, 1.0 );
}

setcinematicmotion_omnvaroverride_max_2( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 0.0, 1.0, 2.0 );
}

setcinematicmotion_omnvaroverride_max_3( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 0.0, 1.0, 3.0 );
}

setcinematicmotion_omnvaroverride_max_4( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 0.0, 1.0, 4.0 );
}

setcinematicmotion_omnvaroverride_max_5( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 0.0, 1.0, 5.0 );
}

setcinematicmotion_omnvaroverride_min_instant( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 set_cinematicmotionomnvaroverrides( 0.0 );
}

setcinematicmotion_omnvaroverride_min_1( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 1.0, 0.0, 1.0 );
}

setcinematicmotion_omnvaroverride_min_2( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 1.0, 0.0, 2.0 );
}

setcinematicmotion_omnvaroverride_min_3( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 1.0, 0.0, 3.0 );
}

setcinematicmotion_omnvaroverride_min_4( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 1.0, 0.0, 4.0 );
}

setcinematicmotion_omnvaroverride_min_5( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 thread set_cinematicmotionomnvarovertime( 1.0, 0.0, 5.0 );
}

player_equip_nvg( var_0 )
{
    if ( !scripts\cp_mp\utility\game_utility::isnightmap() )
        return;

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_1 nightvisionviewon();
}

getgroundcompensationheight( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_0.player ) )
        var_1 = var_0.player;
    else
        var_1 = var_0;

    var_2 = var_1.origin[2];
    var_3 = scripts\engine\trace::create_solid_ai_contents( 1 );
    var_4 = var_1.origin + ( 0, 0, 12 );
    var_5 = var_1.origin - ( 0, 0, 24 );
    var_6 = scripts\engine\trace::player_trace( var_4, var_5, var_1.angles, [ var_1, var_1.infil.linktoent ], var_3 )["position"];
    var_7 = var_6[2];
    var_1.infilheightcompensation = var_7 - var_2;
}

compensatetoground()
{
    level endon( "prematch_over" );
    self endon( "death_or_disconnect" );
    var_0 = 0.0;
    self.personalscenenode unlink();

    while ( isdefined( self.personalscenenode ) )
    {
        getgroundcompensationheight( self.player_rig );
        var_1 = ( self.personalscenenode.origin[0], self.personalscenenode.origin[1], self.personalscenenode.origin[2] + self.infilheightcompensation );

        if ( abs( var_0 - self.infilheightcompensation ) > 0.01 )
        {
            var_0 = self.infilheightcompensation;
            self.personalscenenode moveto( var_1, 0.25, 0.05, 0.2 );
        }

        waitframe();
    }
}

#using_animtree("script_model");

infil_player_rig_updated( var_0, var_1, var_2 )
{
    self.animname = var_0;

    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 0, 0 );

    self predictstreampos( var_1 );
    var_3 = spawn( "script_arms", var_1, 0, 0, self );
    var_3.angles = var_2;
    var_3.player = self;
    self.player_rig = var_3;
    self.player_rig hide( 1 );
    self.player_rig.animname = var_0;
    self.player_rig useanimtree( #animtree );
    self.player_rig.updatedversion = 1;
    self.player_rig.weapon_state_func = ::handleweaponstatenotetrack;
    self.player_rig.cinematic_motion_override = ::handlecinematicmotionnotetrack;
    self.player_rig.dof_func = ::handledofnotetrack;
    self playerlinktodelta( self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1 );
    self notify( "rig_created" );
    scripts\engine\utility::_id_133EF( "remove_rig", "player_free_spot" );

    if ( istrue( level.gameended ) )
        return;

    if ( isdefined( self ) )
    {
        self unlink();
        thread takegunless();
    }

    if ( isdefined( var_3 ) )
        var_3 delete();
}

handledofnotetrack( var_0 )
{
    if ( !isdefined( self ) || !isdefined( self.player ) )
        return;

    switch ( var_0 )
    {
        case "blima_interior":
            self.player enablephysicaldepthoffieldscripting();

            switch ( self.animname )
            {
                case "slot_0":
                    self.player setphysicaldepthoffield( 1.8, 40, 20, 20 );
                    break;
                case "slot_1":
                    self.player setphysicaldepthoffield( 1.8, 60, 20, 20 );
                    break;
                case "slot_2":
                    self.player setphysicaldepthoffield( 1.9, 50, 20, 20 );
                    break;
            }

            break;
        case "blima_exit":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case "umike_interior":
            self.player enablephysicaldepthoffieldscripting();

            switch ( self.animname )
            {
                case "slot_0":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case "slot_1":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case "slot_2":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case "slot_3":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case "slot_4":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case "slot_5":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
            }

            break;
        case "umike_exit":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case "van_interior":
            self.player enablephysicaldepthoffieldscripting();

            switch ( self.animname )
            {
                case "slot_0":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case "slot_1":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case "slot_2":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case "slot_3":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case "slot_4":
                    self.player setphysicaldepthoffield( 2.3, 60, 20, 20 );
                    break;
                case "slot_5":
                    self.player setphysicaldepthoffield( 2.3, 60, 20, 20 );
                    break;
            }

            break;
        case "van_exit":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
    }
}

handlecinematicmotionnotetrack( var_0 )
{
    if ( !isdefined( self ) || !isdefined( self.player ) )
        return;

    var_1 = getsubstr( var_0, 0, 4 );

    if ( var_1 == "set_" )
    {
        var_2 = getsubstr( var_0, 4 );
        self.player setcinematicmotionoverride( var_2 );
        return;
    }

    switch ( var_0 )
    {
        case "max_instant":
            setcinematicmotion_omnvaroverride_max_instant( self );
            break;
        case "max_1":
            setcinematicmotion_omnvaroverride_max_1( self );
            break;
        case "max_2":
            setcinematicmotion_omnvaroverride_max_2( self );
            break;
        case "max_3":
            setcinematicmotion_omnvaroverride_max_3( self );
            break;
        case "max_4":
            setcinematicmotion_omnvaroverride_max_4( self );
            break;
        case "max_5":
            setcinematicmotion_omnvaroverride_max_5( self );
            break;
        case "min_instant":
            setcinematicmotion_omnvaroverride_min_instant( self );
            break;
        case "min_1":
            setcinematicmotion_omnvaroverride_min_1( self );
            break;
        case "min_2":
            setcinematicmotion_omnvaroverride_min_2( self );
            break;
        case "min_3":
            setcinematicmotion_omnvaroverride_min_3( self );
            break;
        case "min_4":
            setcinematicmotion_omnvaroverride_min_4( self );
            break;
        case "min_5":
            setcinematicmotion_omnvaroverride_min_5( self );
            break;
    }
}

handleweaponstatenotetrack( var_0 )
{
    if ( !isdefined( self ) || !isdefined( self.player ) )
        return;

    switch ( var_0 )
    {
        case "drop":
            self.player setdemeanorviewmodel( "normal" );
            self.player scripts\engine\utility::ent_flag_init( "swapLoadout_blocked" );
            self.player scripts\engine\utility::ent_flag_init( "swapLoadout_pending" );
            self.player scripts\engine\utility::ent_flag_init( "swapLoadout_complete" );
            self.player scripts\engine\utility::ent_flag_set( "swapLoadout_blocked" );
            self.player thread fallback_index();

            if ( !isai( self.player ) )
                self.player givegunless();

            if ( istrue( self.updatedversion ) )
                self showonlytoplayer( self.player );

            self.player scripts\common\utility::allow_reload( 0 );
            break;
        case "raise":
            if ( isdefined( self.player.infilweapon ) && self.player hasweapon( self.player.infilweapon ) )
                self.player scripts\cp_mp\utility\inventory_utility::_takeweapon( self.player.infilweapon );

            self.player.propminigamesetting = 1;

            if ( self.player scripts\engine\utility::ent_flag_exist( "swapLoadout_blocked" ) && self.player scripts\engine\utility::ent_flag( "swapLoadout_blocked" ) )
                self.player scripts\engine\utility::ent_flag_clear( "swapLoadout_blocked" );

            self.player setdemeanorviewmodel( "normal" );

            if ( !istrue( self.updatedversion ) )
                self.player stopviewmodelanim();

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "loadout_finalizeWeapons" ) )
                self.player [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "loadout_finalizeWeapons" ) ]]();

            if ( !isai( self.player ) )
                self.player takegunless();

            if ( istrue( self.updatedversion ) && self.player islinked() )
                self.player playerlinkedsetforceparentvisible( 0 );

            if ( !self.player scripts\common\utility::is_reload_allowed() )
                self.player scripts\common\utility::allow_reload( 1 );

            break;
        case "safe":
            self.player setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
            break;
        case "normal":
            self.player setdemeanorviewmodel( "normal" );
            break;
        case "free":
            self.player scripts\common\utility::allow_fire( 1 );
            self.player scripts\common\utility::allow_ads( 1 );

            if ( !self.player scripts\common\utility::is_reload_allowed() )
                self.player scripts\common\utility::allow_reload( 1 );

            break;
        case "hold":
            self.player scripts\common\utility::allow_fire( 0 );
            self.player scripts\common\utility::allow_ads( 0 );

            if ( !self.player scripts\common\utility::is_reload_allowed() )
                self.player scripts\common\utility::allow_reload( 0 );

            break;
    }
}

fallback_index()
{
    self endon( "disconnect" );
    scripts\engine\utility::waittill_any_ents( self, "death", level, "prematch_over" );
    scripts\engine\utility::ent_flag_clear( "swapLoadout_blocked", 1 );
    scripts\engine\utility::ent_flag_clear( "swapLoadout_pending", 1 );
    scripts\engine\utility::ent_flag_clear( "swapLoadout_complete", 1 );
}

takegunless()
{
    self endon( "death_or_disconnect" );

    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
        return;

    if ( scripts\engine\utility::ent_flag_exist( "swapLoadout_pending" ) && scripts\engine\utility::ent_flag( "swapLoadout_pending" ) )
        scripts\engine\utility::ent_flag_wait( "swapLoadout_complete" );

    if ( !scripts\common\utility::is_script_weapon_switch_allowed() )
        scripts\common\utility::allow_script_weapon_switch( 1 );

    while ( self hasweapon( self.gunnlessweapon ) )
    {
        if ( !scripts\cp_mp\utility\inventory_utility::iscurrentweapon( self.gunnlessweapon ) )
            scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( self.gunnlessweapon );
        else
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.gunnlessweapon );
            scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        }

        waitframe();
    }

    self.gunnlessweapon = undefined;
    scripts\common\utility::allow_script_weapon_switch( 0 );
}

givegunless()
{
    self endon( "death_or_disconnect" );

    if ( isdefined( self.gunnlessweapon ) )
        return;

    var_0 = getcompleteweaponname( "iw8_gunless_infil" );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var_0, undefined, undefined, 1 );

    if ( !scripts\common\utility::is_script_weapon_switch_allowed() )
        scripts\common\utility::allow_script_weapon_switch( 1 );

    var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var_0, 0 );

    if ( var_1 )
        self.gunnlessweapon = var_0;
    else
    {
        scripts\cp_mp\utility\inventory_utility::_takeweapon( var_0 );
        scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    scripts\common\utility::allow_script_weapon_switch( 0 );
    return var_1;
}
