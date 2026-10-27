// scripts\mp\common\equipment\support_box.gsc  (hash_6a1b268260f5489a.gscc) (size: 31880 Bytes / 0x7c88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb596deba (3046563514)
// size ...... 31880 (0x7c88)
// includes .. 43  (offset: 0x73dc)
// strings ... 97  (offset: 0x7534)
// dev strs .. 14  (offset: 0x7ba4)
// exports ... 64  (offset: 0x4b7c)
// cseg ...... 0x850 + 0x432c (0x4b7c)
// imports ... 250 (offset: 0x557c)
// animtree1 . 0   (offset: 0x7c58)
// animtree2 . 3   (offset: 0x7c58)
#using scripts\common\ae_utility;
#using scripts\common\devgui;
#using scripts\common\elevators;
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\movers;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace support_box;

// Namespace support_box
// Params 0, eflags: 0x1
// Checksum 0x1feb5b0d, Offset: 0x86e
// Size: 0x9
function autoexec main()
{
    supportbox_init();
}

// Namespace support_box
// Params 0
// Checksum 0xfe097341, Offset: 0x87f
// Size: 0x303
function supportbox_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_ammo_drop", &superset, &supportbox_unset, undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    level.allsupportboxes = [];
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "super_ammo_drop" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_armorbox" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_utilitybox" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_blastshieldbox" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_leaderbox" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_self_revive_box" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_medical_box" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_hauntedbox" );
    interactive::interactive_addusedcallback( &supportbox_usedcallback, "super_reward_box" );
    weapons::registerusedcallback( "ammo_box", &supportbox_used );
    weapons::registerusedcallback( "armor_box", &supportbox_used );
    weapons::registerusedcallback( "utility_box", &supportbox_used );
    weapons::registerusedcallback( "blastshield_box", &supportbox_used );
    weapons::registerusedcallback( "leader_box", &supportbox_used );
    weapons::registerusedcallback( "self_revive_box", &supportbox_used );
    weapons::registerusedcallback( "medical_box", &supportbox_used );
    weapons::registerusedcallback( "haunted_box", &supportbox_used );
    weapons::registerusedcallback( "reward_box", &supportbox_used );
    weapons::registerusedcallback( "equip_ammo_box", &supportbox_used );
    function_4c961ba12b426c16();
    join_team_aggregator::registeronplayerjointeamcallback( &supportbox_updateheadicononjointeam );
    
    if ( !isdefined( level.onarmorboxusedbyplayer ) && utility::issharedfuncdefined( #"armor_drop", #"init" ) )
    {
        [[ utility::getsharedfunc( #"armor_drop", #"init" ) ]]();
    }
    
    /#
        init_dev_gui();
    #/
    
    var_d1814a71672c7390 = [ #"tag_wheel_front_left", #"tag_wheel_front_right", #"tag_wheel_back_left", #"tag_wheel_back_right", #"tag_wheel_middle_left", #"tag_wheel_middle_right", #"tag_wheel_front_left_d0", #"tag_wheel_front_right_d0", #"tag_wheel_back_left_d0", #"tag_wheel_back_right_d0", #"tag_wheel_middle_left_d0", #"tag_wheel_middle_right_d0" ];
    level.var_d1814a71672c7390 = [];
    
    foreach ( var_e40bc4c28bbc251f in var_d1814a71672c7390 )
    {
        level.var_d1814a71672c7390[ var_e40bc4c28bbc251f ] = 1;
    }
}

/#

    // Namespace support_box
    // Params 0
    // Checksum 0xbbd0ad71, Offset: 0xb8a
    // Size: 0x78, Type: dev
    function init_dev_gui()
    {
        if ( isbrgamemode() )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            devgui::add_devgui_command( "<dev string:x59>", "<dev string:x62>" );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            devgui::add_devgui_command( "<dev string:x9d>", "<dev string:xa7>" );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            devgui::add_devgui_command( "<dev string:xde>", "<dev string:xea>" );
            devgui::function_77df7fe7dd273e10();
        }
    }

#/

// Namespace support_box
// Params 1
// Checksum 0xa65bbc43, Offset: 0xc0a
// Size: 0x8c
function supportbox_updateheadicononjointeam( player )
{
    foreach ( supportbox in level.allsupportboxes )
    {
        if ( isdefined( supportbox ) )
        {
            supportbox supportbox_updateheadicon( player );
        }
    }
}

// Namespace support_box
// Params 0
// Checksum 0x32b2bbf8, Offset: 0xc9e
// Size: 0x24
function function_30094038a9641b36()
{
    self.var_f8055900086ace69 = 1;
    self waittill( #"death" );
    self.var_f8055900086ace69 = undefined;
}

#using_animtree( "scriptables" );

// Namespace support_box
// Params 4
// Checksum 0x653ceb4c, Offset: 0xcca
// Size: 0x541
function box_used_common_setup( grenade, equipmentname, superid, headicon )
{
    grenade endon( #"death" );
    grenade.issuper = 1;
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( superid );
    staticsuperdata = level.superglobals.staticsuperdata[ superid ];
    grenade.superid = staticsuperdata.id;
    grenade.lifetime = staticsuperdata.bundle.maxlifetime;
    
    if ( grenade.lifetime > 0 && !staticsuperdata.bundle.var_84b7ee21b17a096b )
    {
        grenade thread supportbox_watchdisownedtimeout();
    }
    
    if ( !grenade.madedamageable && !staticsuperdata.bundle.var_c2d1fcdc917c640f )
    {
        grenade supportbox_makedamageable();
    }
    
    grenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            if ( !self.var_f8055900086ace69 )
            {
                thread function_30094038a9641b36();
            }
            
            supers_mp::refundsuper();
            hud_message::showerrormessage( %"equipment/plant_failed" );
            grenade delete();
            return;
        }
        else
        {
            self.var_f8055900086ace69 = undefined;
        }
    }
    
    if ( staticsuperdata.bundle.var_543bb66477c08ac4 )
    {
        supportbox_usedcallback( grenade, self, 0 );
    }
    
    grenade supportbox_handlemovingplatforms( stuckto, stuckpart );
    
    if ( true )
    {
        thread weapons::outlineequipmentforowner( grenade );
    }
    
    grenade.var_b8e9dbcd0d904452 = staticsuperdata.bundle.var_ab28de8628007732 ?? 0;
    grenade.onusesoundalias = staticsuperdata.bundle.var_80686c2e2ca1dc48;
    
    if ( vectornormalize( anglestoup( grenade.angles ) ) != vectornormalize( normal ) )
    {
        projectedforward = vectornormalize( vectorcross( normal, anglestoright( grenade.angles ) ) );
        grenade.angles = vectortoangles( projectedforward );
    }
    
    weapons::onequipmentplanted( grenade, equipmentname, &supportbox_destroy );
    grenade thread function_4df48c4ac9b2191a();
    level.allsupportboxes[ grenade getentitynumber() ] = grenade;
    
    if ( !staticsuperdata.var_89a23b678129894e )
    {
        grenade emp_debuff::set_apply_emp_callback( &supportbox_empapplied );
        
        if ( utility::issharedfuncdefined( #"emp", #"setemp_applied_callback" ) )
        {
            grenade [[ utility::getsharedfunc( #"emp", #"setemp_applied_callback" ) ]]( &supportbox_empapplied );
        }
        
        grenade haywire::function_7f69a1eb3d590f76( &supportbox_haywireapplied );
    }
    
    utility::function_969f9f5596dba07a( grenade, &supportbox_destroy );
    grenade function_a4ebfb83ec0621b9( &supportbox_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    grenade setscriptablepartstate( "visibility", "show", 0 );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        grenade supportbox_addheadicon( headicon );
    }
    
    grenade.var_3a41121d030b796b = grenade.bundle.var_cc61c5bcbd5ff926;
    grenade.maxusecount = grenade.bundle.var_2f683ff4d88b229d;
    grenade.deployanim = grenade.bundle.var_d64e3d2190e43fb9.id ?? %t10_wm_ammo_pack_deploy;
    grenade.useanim = grenade.bundle.var_f454be684155d98f.id ?? %t10_wm_ammo_pack_interact;
    grenade.closeanim = grenade.bundle.var_f99275ad09f6b570.id ?? %t10_wm_ammo_pack_close;
    grenade.var_2ac3ca6dacfeb97a = grenade.bundle.var_3fb4743df8ed5c7e ?? 0.75;
    
    if ( !grenade.bundle.var_cca633cb929ca240 )
    {
        grenade supportbox_animations( grenade );
    }
    else
    {
        grenade thread supportbox_animations( grenade );
    }
    
    thread weapons::monitordisownedequipment( self, grenade );
}

// Namespace support_box
// Params 1
// Checksum 0x3a9e927c, Offset: 0x1213
// Size: 0x6b4
function supportbox_used( grenade )
{
    grenade endon( #"death" );
    grenade notify( #"support_box_used" );
    grenade.superref = "super_ammo_drop";
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    ammoboxbundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    vfxtimeout = ammoboxbundle.var_63489f6a0131e7c4 ?? "vfx_iw9_fieldupgrades_ammobox_timeout";
    sfxtimeout = "mp_equip_box_destroyed";
    equipname = "super_ammo_drop";
    supername = "super_ammo_drop";
    headicon = level.gamemodebundle.var_a43747faa623d1b0 ?? "ui_hud_icon_field_upgrade";
    usehint = &"equipment_hints/support_box_use";
    weaponname = grenade.weapon_name ?? "ammo_box";
    ref = grenade.equipmentref ?? getweaponrootstring( weaponname );
    
    if ( isdefined( ref ) )
    {
        switch ( ref )
        {
            case #"hash_7e0a03ed7c4c87be":
            case #"hash_91076f076ee682f4":
                vfxtimeout = "vfx_iw9_fieldupgrades_ammobox_armorbox_timeout";
                equipname = "equip_armorbox";
                supername = "super_armor_drop";
                headicon = "hud_icon_fieldupgrade_armor_box";
                usehint = &"equipment_hints/armor_box_use";
                break;
            case #"hash_b3d0752364b0193d":
            case #"hash_f0c0b9ea65729629":
                vfxtimeout = "vfx_t10_gameplay_fieldupgrades_utilitybox_timeout";
                equipname = "equip_utilitybox";
                supername = "super_utility_drop";
                headicon = "hud_icon_fieldupgrade_utility_box";
                usehint = &"equipment_hints/utility_box_use";
                break;
            case #"hash_5bb446fe7b2c92da":
                vfxtimeout = "vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx";
                sfxtimeout = "eqp_haunted_box_destroy";
                equipname = "equip_hauntedbox";
                supername = "super_haunted_drop";
                headicon = "hud_icon_fieldupgrade_haunted_box";
                usehint = &"equipment_hints/haunted_box_use";
                break;
            case #"hash_187c7d31342c1d7c":
                vfxtimeout = "vfx_iw9_fieldupgrades_ammobox_armorbox_timeout";
                equipname = "equip_blastshieldbox";
                supername = "super_blastshield_drop";
                headicon = "hud_icon_equipment_blastshield_box";
                usehint = &"equipment_hints/blastshield_box_use";
                break;
            case #"hash_526718f50b85440e":
            case #"hash_cf0bf67369c3ff42":
                vfxtimeout = "vfx_iw9_fieldupgrades_ammobox_armorbox_timeout";
                equipname = "equip_leaderbox";
                supername = "super_leader_drop";
                headicon = "hud_icon_fieldupgrade_armor_box";
                usehint = &"equipment_hints/self_revive_box_use";
                self setclientomnvar( "ui_squad_leader_pack_dropped", 1 );
                playersquad = teams::getfriendlyplayers( self.team, 0 );
                
                foreach ( teammate in playersquad )
                {
                    teammate setclientomnvar( "ui_squad_leader_pack_dropped", 1 );
                }
                
                break;
            case #"hash_bdd285c401cf9498":
                vfxtimeout = "vfx_iw9_prop_script_offhand_2h_vm_self_revive_box_v0_timeout";
                equipname = "equip_self_revive_box";
                supername = "super_self_revive_box";
                headicon = "hud_icon_fieldupgrade_self_revive_box";
                usehint = &"equipment_hints/self_revive_box_use";
                break;
            case #"hash_c8f1686e93be22bd":
                vfxtimeout = "vfx_iw9_fieldupgrades_ammobox_armorbox_timeout";
                equipname = "equip_medical_box";
                supername = "super_medical_box";
                headicon = "hud_icon_fieldupgrade_ammo_box";
                usehint = &"EQUIPMENT_HINTS/MEDICAL_BOX_USE";
                level.var_7cd0fffaf0353e8e = level.superglobals.staticsuperdata[ supername ].bundle;
                level.var_d392a7c5f9e393ec = level.var_7cd0fffaf0353e8e.var_a3026959e84ee01b;
                level.var_5a47d90a1c8fc8d8 = common_item_database::function_ca9ca606e66b5911( level.var_d392a7c5f9e393ec );
                level.var_3485bc539b066e57 = level.var_7cd0fffaf0353e8e.var_65527368ff34e3cf ?? 1;
                break;
            case #"hash_81ec3793e86f460":
            case #"hash_1b263df988458934":
                vfxtimeout = "vfx_t10_gameplay_fieldupgrades_utilitybox_timeout";
                equipname = "super_reward_box";
                supername = "super_reward_box";
                headicon = "hud_icon_fieldupgrade_utility_box";
                usehint = &"WZ_FUNCTIONALS/REWARD_BOX_USE";
                grenade.supername = supername;
                grenade.equipname = equipname;
                
                if ( !isdefined( grenade.bundle ) )
                {
                    grenade.bundle = level.superglobals.staticsuperdata[ supername ].bundle;
                }
                
                utility::callsharedfunc( getxhash( "super_reward_box" ), #"onspawned", grenade );
                break;
        }
    }
    
    if ( isdefined( supername ) )
    {
        grenade.superref = supername;
        boxbundle = level.superglobals.staticsuperdata[ supername ].bundle;
        
        if ( isdefined( boxbundle.supportbox_headicon ) )
        {
            headicon = boxbundle.supportbox_headicon;
        }
    }
    
    if ( usehint == &"equipment_hints/support_box_use" && isdefined( ammoboxbundle.var_f99cea43f70c6b58 ) && isdefined( ammoboxbundle.var_e1e79753db03d114 ) )
    {
        if ( ammoboxbundle.var_f99cea43f70c6b58 == 0 && ammoboxbundle.var_e1e79753db03d114 == 0 )
        {
            usehint = &"equipment_hints/offhand_ammo_box_use";
        }
    }
    
    grenade.timeoutvfxname = vfxtimeout;
    grenade.playersused = [];
    grenade.usedcount = 0;
    grenade.equipmentref = equipname;
    grenade.enableusable = 1;
    
    if ( utility::issharedfuncdefined( #"support_box", #"supportboxused" ) )
    {
        thread [[ utility::getsharedfunc( #"support_box", #"supportboxused" ) ]]( self, grenade );
    }
    
    function_f99aee7a66ebaf1c( grenade );
    box_used_common_setup( grenade, equipname, supername, headicon );
    
    if ( grenade.enableusable )
    {
        if ( level.gamemodebundle.var_738c716858d0a544 && grenade getscriptablehaspart( "reclaimable_equipment" ) )
        {
            grenade utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df", &function_7ee44e1ff3c64366 );
            grenade.var_e91124d0e91c33d3 = 1;
            grenade thread supportbox_watchallplayeruse();
        }
        else
        {
            grenade thread supportbox_makeusable( equipname, usehint );
        }
    }
    
    challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace support_box
// Params 1
// Checksum 0x1b7603b6, Offset: 0x18cf
// Size: 0x89
function supportbox_animations( grenade )
{
    grenade endon( #"death" );
    grenade notify( #"support_box_used" );
    wait grenade.var_2ac3ca6dacfeb97a - 0;
    grenade setscriptablepartstate( "effects", "plant", 0 );
    grenade setscriptablepartstate( "anims", "open", 0 );
    wait grenade supportbox_getdeployanimduration();
    grenade setscriptablepartstate( "beacon", "active", 0 );
    grenade setscriptablepartstate( "anims", "openidle", 0 );
}

// Namespace support_box
// Params 0
// Checksum 0x32f33e4d, Offset: 0x1960
// Size: 0xe9
function superset()
{
    bundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    
    if ( !isdefined( self.var_6a2d9548aeda69ae ) )
    {
        self.var_6a2d9548aeda69ae = [];
    }
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_ammo_drop", bundle.var_c7709714d768097c ) )
    {
        self.var_6a2d9548aeda69ae[ "super_ammo_drop" ] = 1;
        assert( bundle.var_9d92b48d905a0eaa, "<dev string:x123>" );
        multiplier = bundle.var_9d92b48d905a0eaa ?? 1.2;
        perk::giveperk( "specialty_faster_field_upgrade" );
        val::set( "super_ammo_drop", "field_upgrade_recharge_mult", multiplier );
        return;
    }
    
    self.var_6a2d9548aeda69ae[ "super_ammo_drop" ] = 0;
}

// Namespace support_box
// Params 0
// Checksum 0xf1a8f5b7, Offset: 0x1a51
// Size: 0x106
function supportbox_unset()
{
    if ( self.var_6a2d9548aeda69ae[ "super_ammo_drop" ] )
    {
        val::reset( "super_ammo_drop", "field_upgrade_recharge_mult" );
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    self.var_6a2d9548aeda69ae[ "super_ammo_drop" ] = undefined;
    
    if ( false )
    {
        foreach ( superequip in self.plantedsuperequip )
        {
            if ( superequip.equipmentref == "super_ammo_drop" || superequip.equipmentref == "equip_armorbox" || superequip.equipmentref == "equip_leaderbox" )
            {
                superequip thread supportbox_destroy( 1 );
                weapons::removeequip( superequip );
            }
        }
    }
}

// Namespace support_box
// Params 4
// Checksum 0x753f36ad, Offset: 0x1b5f
// Size: 0x20c
function supportbox_destroy( immediate = !self.planted, wasdestroyed, var_4f1331fa70f48a8d, shouldplaysound )
{
    ammoboxbundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    timeoutvfxname = self.timeoutvfxname ?? ammoboxbundle.var_63489f6a0131e7c4 ?? "vfx_iw9_fieldupgrades_ammobox_timeout";
    var_95f2032ef7a1c353 = self.var_95f2032ef7a1c353 ?? "mp_equip_box_destroyed";
    closetime = 0;
    
    if ( var_4f1331fa70f48a8d )
    {
        closetime = supportbox_getcloseanimduration();
    }
    
    deletiondelay = 0;
    
    if ( !immediate )
    {
        deletiondelay = 0.1;
    }
    
    if ( var_4f1331fa70f48a8d )
    {
        deletiondelay += closetime + 1;
    }
    
    thread supportbox_delete( deletiondelay, wasdestroyed );
    moving_platform = undefined;
    fxoriginoffset = undefined;
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        fxforward = anglestoforward( self.angles );
        fxup = anglestoup( self.angles );
        var_6978ba6f62479219 = self getlinkedparent();
        
        if ( isdefined( var_6978ba6f62479219 ) )
        {
            moving_platform = var_6978ba6f62479219;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        self setscriptablepartstate( "beacon", "neutral", 0 );
        self setscriptablepartstate( "hacked", "neutral", 0 );
        
        if ( var_4f1331fa70f48a8d )
        {
            self setscriptablepartstate( "anims", "close", 0 );
            wait closetime;
            self setscriptablepartstate( "anims", "closedidle", 0 );
            wait 1;
        }
        
        if ( isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
        
        self setscriptablepartstate( "effects", "destroy", 0 );
        
        if ( shouldplaysound && !self.var_b8e9dbcd0d904452 )
        {
            playsoundatpos( fxorigin, var_95f2032ef7a1c353 );
        }
    }
}

// Namespace support_box
// Params 2
// Checksum 0x69a6ae99, Offset: 0x1d73
// Size: 0x1d8
function supportbox_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    supportbox_removeheadicon();
    supportbox_makeunusable();
    supername = "super_ammo_drop";
    
    if ( self.equipmentref == "equip_armorbox" )
    {
        supername = "super_armor_drop";
    }
    else if ( self.equipmentref == "equip_utilitybox" )
    {
        supername = "super_utility_drop";
    }
    else if ( self.equipmentref == "equip_hauntedbox" )
    {
        supername = "super_haunted_drop";
    }
    else if ( self.equipmentref == "equip_blastshieldbox" )
    {
        supername = "super_blastshield_drop";
    }
    else if ( self.equipmentref == "equip_leaderbox" )
    {
        supername = "super_leader_drop";
    }
    else if ( self.equipmentref == "super_reward_box" )
    {
        supername = "super_reward_box";
    }
    
    if ( supername == "super_armor_drop" || supername == "super_ammo_drop" )
    {
        self.owner challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    }
    
    analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"support_box", #"supportboxdeleted" ) )
        {
            thread [[ utility::getsharedfunc( #"support_box", #"supportboxdeleted" ) ]]( self.owner, self );
        }
        
        self delete();
    }
}

// Namespace support_box
// Params 1
// Checksum 0x2af54f0f, Offset: 0x1f53
// Size: 0x61
function function_f99aee7a66ebaf1c( supportbox )
{
    if ( supportbox function_829ac03dee871dbd() )
    {
        if ( isdefined( supportbox.owner ) )
        {
            supportbox.owner hud_message::showerrormessage( %"hash_776259af8c8b715a" );
            supportbox.owner supers_mp::refundsuper();
            supportbox thread supportbox_destroy( 1, undefined, undefined, 0 );
        }
    }
}

// Namespace support_box
// Params 0
// Checksum 0x3eaafc97, Offset: 0x1fbc
// Size: 0x3d
function function_4df48c4ac9b2191a()
{
    self endon( #"death" );
    
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        while ( true )
        {
            if ( function_829ac03dee871dbd() )
            {
                thread supportbox_destroy();
            }
            
            wait 1;
        }
    }
}

// Namespace support_box
// Params 1
// Checksum 0x13423051, Offset: 0x2001
// Size: 0x44
function function_16163d2fc1fa0ea1( params )
{
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( function_829ac03dee871dbd() )
    {
        hud_message::showerrormessage( %"equipment/plant_failed" );
        self playsoundtoplayer( "ui_select_purchase_deny", self );
        self canceloffhands();
    }
}

// Namespace support_box
// Params 2
// Checksum 0xc3e922c0, Offset: 0x204d
// Size: 0x1a2
function supportbox_makeusable( equipmentname, hintstring )
{
    bundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    
    if ( bundle.var_bead9b1c34058722 )
    {
        var_10dcf295c6e0c64b = spawn( "script_origin", self.origin );
        var_10dcf295c6e0c64b.owner = self.owner;
        var_10dcf295c6e0c64b.team = self.team;
        var_10dcf295c6e0c64b.grenadeowner = self;
        var_10dcf295c6e0c64b setcandamage( 1 );
        var_10dcf295c6e0c64b linkto( self );
        self.var_10dcf295c6e0c64b = var_10dcf295c6e0c64b;
        thread function_75fec5be02ab0e5e();
        var_aacb78da5016573c = bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = bundle.var_d698fcfe464f1b17 ?? 128;
        var_b21377d6aeba80eb = bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        var_10dcf295c6e0c64b thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, var_b21377d6aeba80eb, var_10dcf295c6e0c64b.team );
    }
    
    interactive::interactive_addusedcallbacktoentity( equipmentname );
    self makeusable();
    self setusepriority( -1 );
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( hintstring );
    self setuserange( 128 );
    self setuseholdduration( "duration_short" );
    self sethinttag( "tag_use" );
    self function_e02978580deb4430( ( 0, 0, 30 ) );
    thread supportbox_watchallplayeruse();
}

// Namespace support_box
// Params 0
// Checksum 0x6fc9063, Offset: 0x21f7
// Size: 0xd8
function function_75fec5be02ab0e5e()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.var_10dcf295c6e0c64b waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time );
        self dodamage( damage, self.origin, attacker, inflictor, meansofdeath );
    }
}

// Namespace support_box
// Params 1
// Checksum 0x312889dc, Offset: 0x22d7
// Size: 0x3a
function function_7f9b0d5fda915496( attacker )
{
    if ( self.grenadeowner )
    {
        self.grenadeowner supportbox_givepointsfordeath( attacker );
        self.grenadeowner thread supportbox_destroy();
    }
}

// Namespace support_box
// Params 0
// Checksum 0x16382259, Offset: 0x2319
// Size: 0x59
function supportbox_makeunusable()
{
    self notify( #"supportbox_makeunusable" );
    
    if ( self.var_10dcf295c6e0c64b )
    {
        self.var_10dcf295c6e0c64b equipment_interact::function_2e1b95de8d0440b9();
        self.var_10dcf295c6e0c64b delete();
        self.var_10dcf295c6e0c64b = undefined;
    }
    
    interactive::interactive_removeusedcallbackfromentity();
    self makeunusable();
    self.playersused = undefined;
}

// Namespace support_box
// Params 0
// Checksum 0xf9919dd1, Offset: 0x237a
// Size: 0x54
function supportbox_watchallplayeruse()
{
    self endon( #"death" );
    self endon( #"supportbox_makeunusable" );
    var_d94c20f799b7a19a = gettime();
    
    while ( true )
    {
        supportbox_updateplayersused();
        
        if ( gettime() >= var_d94c20f799b7a19a )
        {
            supportbox_updateplayerusevisibility();
            var_d94c20f799b7a19a = gettime() + 150;
        }
        
        waitframe();
    }
}

// Namespace support_box
// Params 0
// Checksum 0x1ddbc19d, Offset: 0x23d6
// Size: 0x100
function supportbox_updateplayerusevisibility()
{
    nearplayers = utility::playersnear( self.origin, 300 );
    
    foreach ( player in nearplayers )
    {
        if ( isdefined( player ) )
        {
            if ( !supportbox_playercanuse( player ) )
            {
                if ( self.var_e91124d0e91c33d3 )
                {
                    utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_239423f5c2f16dbb", player );
                }
                else
                {
                    self disableplayeruse( player );
                }
                
                continue;
            }
            
            if ( self.var_e91124d0e91c33d3 )
            {
                utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_b95f2006e0998bca", player );
                continue;
            }
            
            self enableplayeruse( player );
        }
    }
}

// Namespace support_box
// Params 0
// Checksum 0xe8356fc2, Offset: 0x24de
// Size: 0xba
function supportbox_updateplayersused()
{
    foreach ( player in self.playersused )
    {
        if ( isdefined( player ) )
        {
            entnum = player getentitynumber();
            
            if ( !player::isreallyalive( player ) && isdefined( self.playersused[ entnum ] ) )
            {
                self.playersused[ entnum ] = undefined;
                supportbox_updateheadicon( player );
            }
        }
    }
}

// Namespace support_box
// Params 1
// Checksum 0xd4cb3ea8, Offset: 0x25a0
// Size: 0x9f, Type: bool
function supportbox_playercanuse( player )
{
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "crate_use" ) )
    {
        return false;
    }
    
    if ( isdefined( self.playersused[ player getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( !self.var_909f0f88fb0946be && player_utility::playersareenemies( player, self.owner ) )
    {
        return false;
    }
    
    if ( isdefined( self.maxusecount ) && self.maxusecount != -1 && self.usedcount >= self.maxusecount )
    {
        return false;
    }
    
    return true;
}

// Namespace support_box
// Params 2
// Checksum 0xa290a9c4, Offset: 0x2648
// Size: 0x3f7
function refillplayer( player, isrally )
{
    if ( common_inventory::inventory_isenabled() && !isdefined( level.init_item_ammo_override ) )
    {
        supportboxclips = player modified_values::function_14d05d73e63e1f9e( 0, level.gametypebundle.supportboxclips ?? 2 );
        
        if ( level.var_e9d733627b29a6 )
        {
            itembundle = common_item::function_cf68ad18114498b2( level.var_e9d733627b29a6 );
            item = common_item::function_77600f92048df72d( itembundle, item_ammo::function_bc44ebafb97454a0( itembundle ) * supportboxclips );
            player common_item::function_41751a7f86839f01( item, undefined, 1 );
        }
        else
        {
            player item_ammo::function_5b3e00ec8cebdbea( undefined, supportboxclips );
        }
        
        return;
    }
    
    var_2af3de90be1f4162 = [];
    var_2af3de90be1f4162 = arraycombine( var_2af3de90be1f4162, player.primaryweapons ?? [] );
    var_2af3de90be1f4162 = arraycombine( var_2af3de90be1f4162, player.meleeweapons ?? [] );
    ammoboxbundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    
    foreach ( weaponobj in var_2af3de90be1f4162 )
    {
        if ( weapon::ismeleeonly( weaponobj ) || weapon::issuperweapon( weaponobj ) || weapon::iskillstreakweapon( weaponobj ) || weapon::isgamemodeweapon( weaponobj ) )
        {
            continue;
        }
        
        weapongroup = weapon::getweapongroup( weaponobj );
        clipnum = undefined;
        
        if ( weapon::issinglehitweapon( weaponobj ) )
        {
            clipnum = 1;
        }
        else if ( weapongroup == "weapon_sniper" )
        {
            clipnum = 1.5;
        }
        else
        {
            clipnum = 3;
        }
        
        if ( weaponobj.hasalternate )
        {
            weaponaltobj = weaponobj getaltweapon();
            var_cf9a66baeefb77cf = weaponclass( weaponaltobj );
            
            if ( var_cf9a66baeefb77cf == "grenade" )
            {
                addammo = weapons::getammooverride( weaponaltobj );
                stockammo = player getweaponammostock( weaponaltobj );
                newammo = int( stockammo + addammo );
                player setweaponammostock( weaponaltobj, newammo );
            }
            else if ( weaponaltobj.type == "bullet" )
            {
                if ( !weaponaltobj function_195d62e346d13f13() )
                {
                    addammo = weapons::getammooverride( weaponaltobj );
                    stockammo = player getweaponammostock( weaponaltobj );
                    newammo = int( stockammo + addammo );
                    player setweaponammostock( weaponaltobj, newammo );
                }
            }
            else
            {
                addammo = weapons::getammooverride( weaponaltobj );
                stockammo = player getweaponammostock( weaponaltobj );
                newammo = int( stockammo + addammo );
                player setweaponammostock( weaponaltobj, newammo );
            }
        }
        
        if ( ammoboxbundle.var_b54bc0d3a2cf15e )
        {
            player setweaponammostock( weaponobj, weaponobj.maxammo );
            continue;
        }
        
        var_bf7798d24f699644 = weaponclipsize( weaponobj );
        addammo = weapons::getammooverride( weaponobj ) * clipnum;
        
        if ( weaponobj.reloaddisabled )
        {
            newammo = int( min( player getweaponammoclip( weaponobj ) + addammo, var_bf7798d24f699644 ) );
            player setweaponammoclip( weaponobj, newammo );
            continue;
        }
        
        addammo = max( var_bf7798d24f699644, addammo );
        stockammo = player getweaponammostock( weaponobj );
        newammo = int( stockammo + addammo );
        
        if ( weaponmaxammo( weaponobj ) <= player getweaponammostock( weaponobj ) )
        {
            continue;
        }
        
        player setweaponammostock( weaponobj, newammo );
    }
    
    if ( !isrally )
    {
        primary = player equipment_mp::getcurrentequipment( "primary" );
        
        if ( isdefined( primary ) )
        {
            player equipment_mp::incrementequipmentammo( primary, function_59fd58aae407eb8e( primary ) );
        }
        
        secondary = player equipment_mp::getcurrentequipment( "secondary" );
        
        if ( isdefined( secondary ) )
        {
            player equipment_mp::incrementequipmentammo( secondary, function_59fd58aae407eb8e( secondary ) );
        }
    }
}

// Namespace support_box
// Params 2
// Checksum 0xd0752db9, Offset: 0x2a47
// Size: 0x239
function supportbox_onplayeruse( player, var_14546e102fa89f0a = 1 )
{
    if ( !isdefined( self.equipmentref ) )
    {
        assertmsg( "<dev string:x17a>" );
        return;
    }
    
    if ( self.equipmentref == "equip_blastshieldbox" )
    {
        player perk::giveperk( "specialty_blastshield" );
        player damagefeedback::hudicontype( "blastshield_box" );
    }
    else if ( self.equipmentref == "equip_armorbox" )
    {
        armor = player equipment_mp::getcurrentequipment( "health" );
        
        if ( isdefined( armor ) )
        {
            var_78e7416ea6080fad = player equipment_mp::getcurrentequipment( armor );
            maxarmorcount = equipment_mp::getequipmentmaxammo( armor );
            var_a953c1f42caac1b0 = max( 0, int( player modified_values::function_14d05d73e63e1f9e( 11, maxarmorcount ) ) );
            
            if ( !isdefined( var_78e7416ea6080fad ) || var_78e7416ea6080fad < maxarmorcount )
            {
                player equipment_mp::incrementequipmentammo( armor, var_a953c1f42caac1b0 );
            }
            else
            {
                player utility::callsharedfunc( #"hud", #"showerrormessage", %"hash_71831895a153ddbb" );
                return 0;
            }
        }
    }
    else
    {
        grantrefill = !player.var_f8055900086ace69 || player != self.owner;
        
        if ( grantrefill )
        {
            refillplayer( player );
        }
        
        if ( !common_inventory::inventory_isenabled() )
        {
            player damagefeedback::hudicontype( "ammobox" );
        }
    }
    
    supportbox_playusesound( player, self.onusesoundalias );
    
    if ( var_14546e102fa89f0a )
    {
        thread supportbox_onplayeruseanim();
    }
    
    if ( self.var_3a41121d030b796b )
    {
        function_bd63e87bad0a276e();
    }
    
    if ( isdefined( self.maxusecount ) && self.maxusecount != -1 && self.usedcount >= self.maxusecount )
    {
        thread supportbox_destroy( 0, 0, 1 );
    }
    
    self.var_e372bc89347f7dfc = 1;
    self.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weapon_object, 1, "restocks" );
    self.owner telemetry_mp::function_b653df8a1833e78d( self.owner, self getentitynumber(), self.weapon_object );
    return 1;
}

// Namespace support_box
// Params 2
// Checksum 0xb63e01a0, Offset: 0x2c89
// Size: 0x156
function supportbox_onplayerusearmor( player, var_14546e102fa89f0a = 1 )
{
    if ( !isdefined( self.equipmentref ) )
    {
        assertmsg( "<dev string:x17a>" );
        return;
    }
    
    armorname = level.armorbundlename;
    armorbundle = getscriptbundle( armorname );
    armoritem = spawnstruct();
    armoritem.type = armorbundle.scriptable;
    maxplates = player armor::function_db9ebf086f67fe92();
    var_a01a56cb216e142d = max( 0, int( player modified_values::function_14d05d73e63e1f9e( 11, maxplates ) ) );
    armoritem.count = var_a01a56cb216e142d;
    used = player common_item::function_96119bed8ab4c5d9( armoritem, 0, 1, 1 );
    armoritem.count = max( 0, var_a01a56cb216e142d - used );
    
    if ( armoritem.count > 0 )
    {
        common_item::function_47324f290423b2d1( armorname, self.origin, player.origin, armoritem.count );
    }
    
    supportbox_playusesound( player, self.onusesoundalias );
    
    if ( var_14546e102fa89f0a )
    {
        thread supportbox_onplayeruseanim();
    }
    
    self.var_e372bc89347f7dfc = 1;
    return 1;
}

// Namespace support_box
// Params 2
// Checksum 0x96a4780b, Offset: 0x2de8
// Size: 0x8c, Type: bool
function supportbox_onplayerusemedical( player, var_14546e102fa89f0a = 1 )
{
    var_9b0bb0ecd749d243 = level.var_5a47d90a1c8fc8d8;
    amount = level.var_3485bc539b066e57;
    assert( isdefined( var_9b0bb0ecd749d243 ), "<dev string:x1c9>" );
    function_43cf49cb88207734( player, var_9b0bb0ecd749d243, amount );
    supportbox_playusesound( player, self.onusesoundalias );
    
    if ( var_14546e102fa89f0a )
    {
        thread supportbox_onplayeruseanim();
    }
    
    self.var_e372bc89347f7dfc = 1;
    return true;
}

// Namespace support_box
// Params 3
// Checksum 0x81641053, Offset: 0x2e7d
// Size: 0x101
function function_43cf49cb88207734( player, itembundlename, amount )
{
    itemname = itembundlename;
    itembundle = getscriptbundle( itemname );
    item = spawnstruct();
    item.type = itembundle.scriptable;
    maxitems = itembundle.maxcount;
    var_43985a7b592b1702 = amount ?? maxitems;
    item.count = var_43985a7b592b1702;
    used = player common_item::function_96119bed8ab4c5d9( item, 0, 1, 1 );
    
    if ( var_43985a7b592b1702 != used )
    {
        item.count = max( 0, var_43985a7b592b1702 - used );
    }
    
    if ( item.count > 0 )
    {
        common_item::function_47324f290423b2d1( itemname, self.origin, player.origin, item.count );
    }
}

// Namespace support_box
// Params 3
// Checksum 0x42d8448b, Offset: 0x2f86
// Size: 0xdc
function function_59fd58aae407eb8e( equipref, incrementamount = 1, box = undefined )
{
    switch ( equipref )
    {
        case #"hash_61206775eae1c854":
            incrementamount = 3;
            break;
        default:
            break;
    }
    
    if ( isdefined( box ) )
    {
        equipmenttableinfo = weapon::getequipmenttableinfo( equipref );
        
        if ( box.equipmentref == "super_ammo_drop" && isdefined( equipmenttableinfo.ammoboxammo ) )
        {
            incrementamount = equipmenttableinfo.ammoboxammo;
        }
        else if ( box.equipmentref == "equip_utilitybox" && isdefined( equipmenttableinfo.utilityboxammo ) )
        {
            incrementamount = equipmenttableinfo.utilityboxammo;
        }
    }
    
    return incrementamount;
}

// Namespace support_box
// Params 2
// Checksum 0x61705d95, Offset: 0x306b
// Size: 0x95
function supportbox_playusesound( player, onusesoundalias )
{
    if ( isdefined( player ) )
    {
        if ( !isdefined( onusesoundalias ) )
        {
            if ( self.equipmentref == "equip_armorbox" || self.equipmentref == "equip_blastshieldbox" )
            {
                player playsoundtoplayer( "fly_pickup_armor_crate", player );
            }
            else if ( self.equipmentref == "equip_leaderbox" )
            {
                player playsoundtoplayer( "fly_pickup_armor_crate", player );
            }
            else
            {
                player playsoundtoplayer( "ammo_crate_use", player );
            }
            
            return;
        }
        
        player playsoundtoplayer( onusesoundalias, player );
    }
}

// Namespace support_box
// Params 0
// Checksum 0x8ebd802, Offset: 0x3108
// Size: 0x59
function supportbox_onplayeruseanim()
{
    self endon( #"death" );
    
    if ( self.onuseanimplaying )
    {
        return;
    }
    
    self setscriptablepartstate( "anims", "openuse", 0 );
    self.onuseanimplaying = 1;
    wait supportbox_getuseanimduration();
    self setscriptablepartstate( "anims", "openidle", 0 );
    self.onuseanimplaying = undefined;
}

// Namespace support_box
// Params 0
// Checksum 0x5f006eb9, Offset: 0x3169
// Size: 0x7e
function supportbox_makedamageable()
{
    if ( isdefined( self.equipmentref ) )
    {
        if ( self.equipmentref == "equip_leaderbox" )
        {
            return;
        }
    }
    
    bundle = self.bundle;
    boxmaxhealth = 100;
    
    if ( isdefined( bundle ) )
    {
        boxmaxhealth = bundle.support_box_max_health ?? 100;
    }
    
    thread damage::monitordamage( boxmaxhealth, "hitequip", &supportbox_handlefataldamage, &supportbox_handledamage );
    self.madedamageable = 1;
}

// Namespace support_box
// Params 1
// Checksum 0xe00caa13, Offset: 0x31ef
// Size: 0x148
function supportbox_handledamage( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return ( data.damage * ( self.bundle.var_22453475ccbe1454 ?? 0 ) );
    }
    
    isenemydamage = !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, data.attacker );
    hits = undefined;
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        hits = supportbox_explosivedamagetohits( data, isenemydamage );
    }
    else if ( utility::isbulletdamage( data.meansofdeath ) )
    {
        hits = supportbox_bulletdamagetohits( data, isenemydamage );
    }
    
    if ( isdefined( hits ) )
    {
        hitstokill = self.bundle.var_6e1b8cd8cbf10403 ?? 5;
        
        if ( isenemydamage )
        {
            hitstokill = self.bundle.var_17492013b6fa5253 ?? 5;
        }
        
        hitstokill += self.var_58c6098c31adbc5a ?? 0;
        return int( ceil( min( 1, hits / hitstokill ) * self.maxhealth ) );
    }
    
    return data.damage;
}

// Namespace support_box
// Params 1
// Checksum 0xace84ada, Offset: 0x3340
// Size: 0x4b
function supportbox_handlefataldamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    supportbox_givepointsfordeath( data.attacker, data.objweapon );
    thread supportbox_destroy( 0, 1, 0 );
}

// Namespace support_box
// Params 2
// Checksum 0xbcef6873, Offset: 0x3393
// Size: 0x9d
function supportbox_bulletdamagetohits( data, isenemydamage )
{
    basehits = damage::isfmjdamage( data.objweapon, data.meansofdeath ) && isenemydamage ? 2 : 0;
    
    if ( data.damage > 150 )
    {
        return ( basehits + 10 );
    }
    
    if ( data.damage >= 80 )
    {
        return ( basehits + 5 );
    }
    
    if ( data.damage >= 30 )
    {
        return ( basehits + 2 );
    }
    
    return basehits + 1;
}

// Namespace support_box
// Params 2
// Checksum 0xa6b75fee, Offset: 0x3438
// Size: 0x5a
function supportbox_explosivedamagetohits( data, isenemydamage )
{
    if ( data.damage > 200 )
    {
        return 20;
    }
    
    if ( data.damage > 70 )
    {
        return 10;
    }
    
    if ( data.damage > 30 )
    {
        return 7;
    }
    
    return 2;
}

// Namespace support_box
// Params 0
// Checksum 0x8f7d060e, Offset: 0x349a
// Size: 0x20
function supportbox_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        outline::outlinedisable( self.outlineid, self );
    }
}

// Namespace support_box
// Params 1
// Checksum 0x9649b40a, Offset: 0x34c2
// Size: 0xbd
function supportbox_addheadicon( headicon )
{
    imageoverride = self.var_30656af96b2ac2a4.size > 0 ? self.bundle.buffedheadicon : undefined;
    
    if ( !isdefined( headicon ) )
    {
        headicon = level.gamemodebundle.var_a43747faa623d1b0;
    }
    
    if ( !( self.bundle.var_9526fd5c44eee510 && self.bundle.headicon_enable ) )
    {
        self.headiconbox = entityheadicons::setheadicon_singleimage( [], headicon, 20, 1, 1000, 100, undefined, 1 );
    }
    
    self.headiconfaction = entityheadicons::setheadicon_equipment( self, imageoverride );
    supportbox_updateheadiconallplayers();
}

// Namespace support_box
// Params 0
// Checksum 0xa5b35fa3, Offset: 0x3587
// Size: 0x50
function supportbox_removeheadicon()
{
    if ( isdefined( self.headiconbox ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconbox );
        self.headiconbox = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace support_box
// Params 2
// Checksum 0x55174bab, Offset: 0x35df
// Size: 0x61
function supportbox_givepointsfordeath( attacker, weaponobj )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( isdefined( self.owner ) )
        {
            thread utility::callsharedfunc( #"supers", #"hash_28aeb93023a8a138", attacker, weaponobj );
        }
    }
}

// Namespace support_box
// Params 4
// Checksum 0x63e3eca7, Offset: 0x3648
// Size: 0x24d
function supportbox_givexpforuse( player, eventname, persstat, supername )
{
    if ( isdefined( self.owner ) && !player_utility::playersareenemies( self.owner, player ) )
    {
        if ( self.owner != player )
        {
            self.owner thread points::doscoreevent( self.bundle.var_400093e54e967ed0 ?? eventname, self.weapon_object );
            
            if ( !isdefined( self.var_ec94ca59d1a9f60e ) )
            {
                self.var_ec94ca59d1a9f60e = 0;
            }
            
            self.var_ec94ca59d1a9f60e += 1;
            
            if ( self.var_ec94ca59d1a9f60e == 3 )
            {
                self.owner thread points::doscoreevent( #"munitions_box_triple_used", self.weapon_object );
            }
        }
        else if ( self.bundle.var_de2acbbed47abec6 )
        {
            self.owner thread points::doscoreevent( self.bundle.var_de2acbbed47abec6, self.weapon_object );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
        {
            if ( isdefined( self.owner.leaderboarddata[ persstat ] ) )
            {
                self.owner.leaderboarddata[ persstat ] += 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ persstat ] ) )
            {
                [[ level.leaderboardfunc[ persstat ] ]]( self.owner, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x23c>" );
            
            if ( isdefined( self.owner.pers[ persstat ] ) )
            {
                self.owner.pers[ persstat ] += 1;
            }
        }
        
        self.owner supers_mp::combatrecordsupermisc( supername );
        self.usedcount++;
    }
}

// Namespace support_box
// Params 1
// Checksum 0xd3441a65, Offset: 0x389d
// Size: 0x15
function supportbox_onmovingplatformdeath( data )
{
    supportbox_destroy( 1 );
}

// Namespace support_box
// Params 1
// Checksum 0x7777ffbd, Offset: 0x38ba
// Size: 0x83
function function_ec8de6a63ffbb4ea( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    superinfo = owner supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo ) && level.allowsupers )
    {
        if ( !self.var_e372bc89347f7dfc )
        {
            superinfo.wasrefunded = 1;
            owner supers_mp::setsuperbasepoints( owner supers_mp::getsuperpointsneeded() );
        }
    }
    
    supportbox_destroy( 1 );
}

// Namespace support_box
// Params 1
// Checksum 0x2c33587b, Offset: 0x3945
// Size: 0x18
function function_4cc9c04dd1482287( partname )
{
    return level.var_d1814a71672c7390[ partname ];
}

// Namespace support_box
// Params 1
// Checksum 0x221ec179, Offset: 0x3966
// Size: 0xe3
function function_b563ff80ef5ce666( stuckto )
{
    issupportbox = isdefined( stuckto.superref ) && ( stuckto.superref == "super_ammo_drop" || stuckto.superref == "super_armor_drop" || stuckto.superref == "super_utility_drop" || stuckto.superref == "super_haunted_drop" || stuckto.superref == "super_blastshield_drop" || stuckto.superref == "super_leader_drop" || stuckto.superref == "super_self_revive_box" || stuckto.superref == "super_medical_box" || stuckto.superref == "super_reward_box" );
    return issupportbox;
}

// Namespace support_box
// Params 2
// Checksum 0x7d1a06ca, Offset: 0x3a52
// Size: 0xc9
function supportbox_handlemovingplatforms( stuckto, stuckpart )
{
    if ( function_4cc9c04dd1482287( stuckpart ) )
    {
        self unlink();
        return;
    }
    
    if ( function_b563ff80ef5ce666( stuckto ) )
    {
        self unlink();
        return;
    }
    
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &supportbox_onmovingplatformdeath;
    data.invalidparentoverridecallback = &function_ec8de6a63ffbb4ea;
    data.endonstring = "death";
    data.validateaccuratetouching = 1;
    
    if ( isdefined( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
    {
        data.var_f07590e06f628942 = 1;
        self setmissileantilagged( 1 );
    }
    
    thread movers::handle_moving_platforms( data );
}

// Namespace support_box
// Params 0
// Checksum 0x3d1a0539, Offset: 0x3b23
// Size: 0x3b
function supportbox_watchdisownedtimeout()
{
    self endon( #"death" );
    self endon( #"remove_timeout" );
    supportbox_watchdisownedtimeoutinternal();
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread supportbox_destroy();
    }
}

// Namespace support_box
// Params 0
// Checksum 0xc1af39ba, Offset: 0x3b66
// Size: 0x68
function supportbox_watchdisownedtimeoutinternal()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    if ( self.lifetime > 0 )
    {
        hostmigration::waitlongdurationwithhostmigrationpause( self.lifetime );
    }
}

// Namespace support_box
// Params 1
// Checksum 0x80947b96, Offset: 0x3bd6
// Size: 0x35
function supportbox_empapplied( data )
{
    attacker = data.attacker;
    supportbox_givepointsfordeath( attacker );
    thread supportbox_destroy( 1 );
}

// Namespace support_box
// Params 1
// Checksum 0x314deb09, Offset: 0x3c13
// Size: 0x41
function supportbox_haywireapplied( data )
{
    attacker = data.attacker;
    attacker damagefeedback::updatedamagefeedback( "hitequip" );
    supportbox_givepointsfordeath( attacker );
    thread supportbox_destroy();
}

// Namespace support_box
// Params 0
// Checksum 0x1b469510, Offset: 0x3c5c
// Size: 0x83
function supportbox_updateheadiconallplayers()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        supportbox_updateheadicon( player );
    }
}

// Namespace support_box
// Params 1
// Checksum 0x5fb60586, Offset: 0x3ce7
// Size: 0x195
function supportbox_updateheadicon( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idbox = self.headiconbox;
    
    if ( !isdefined( idbox ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    assert( !( self.bundle.var_9526fd5c44eee510 && self.bundle.headicon_enable ), "<dev string:x262>" );
    isfriendly = player_utility::isfriendly( self.owner.team, player ) || self.var_909f0f88fb0946be;
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    ammoboxbundle = level.superglobals.staticsuperdata[ self.superref ].bundle;
    var_6494cc4a40ba6b5e = istrue( ammoboxbundle.var_9526fd5c44eee510 );
    
    if ( isfriendly && !isused && !var_6494cc4a40ba6b5e )
    {
        entityheadicons::setheadicon_addclienttomask( idbox, player );
        entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        entityheadicons::setheadicon_removeclientfrommask( idbox, player );
        entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( idbox, player );
    entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

// Namespace support_box
// Params 0
// Checksum 0x94d6b275, Offset: 0x3e84
// Size: 0xf
function supportbox_getdeployanimduration()
{
    return getanimlength( self.deployanim );
}

// Namespace support_box
// Params 0
// Checksum 0xa72bff1e, Offset: 0x3e9c
// Size: 0xf
function supportbox_getuseanimduration()
{
    return getanimlength( self.useanim );
}

// Namespace support_box
// Params 0
// Checksum 0xad514285, Offset: 0x3eb4
// Size: 0xf
function supportbox_getcloseanimduration()
{
    return getanimlength( self.closeanim );
}

// Namespace support_box
// Params 1
// Checksum 0x936a650e, Offset: 0x3ecc
// Size: 0x4c
function function_7ee44e1ff3c64366( params )
{
    player = params.player;
    entity = params.instance.entity;
    supportbox_usedcallback( entity, player );
}

// Namespace support_box
// Params 3
// Checksum 0x830a68df, Offset: 0x3f20
// Size: 0x653
function supportbox_usedcallback( entity, player, var_14546e102fa89f0a = 1 )
{
    if ( player.isjuggernaut && !isbrgamemode() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_used" );
        }
        
        return;
    }
    
    if ( entity supportbox_playercanuse( player ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( entity );
        spawnoptions.var_2321e933cbdf46d8 = 59;
        spawnoptions.var_fd76732c1cbd4b05 = 1;
        usesuccessful = 0;
        eventname = undefined;
        persstat = undefined;
        supername = undefined;
        
        if ( isdefined( entity.equipmentref ) )
        {
            switch ( entity.equipmentref )
            {
                case #"hash_29972969a98220a1":
                    eventname = #"munitions_box_teammate_used";
                    persstat = "munitionsBoxUsed";
                    supername = "super_ammo_drop";
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        usesuccessful = entity [[ level.onsupportboxusedbyplayer ]]( player, spawnoptions );
                    }
                    else
                    {
                        usesuccessful = entity supportbox_onplayeruse( player, var_14546e102fa89f0a );
                    }
                    
                    bundle = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
                    
                    if ( usesuccessful && bundle.var_e36b84555e7df1d3 && entity.owner supers_mp::function_d45945781d29204a( "super_ammo_drop", bundle.var_e36b84555e7df1d3 ) )
                    {
                        player.var_27a561637e13dd5c = 1;
                    }
                    
                    break;
                case #"hash_91076f076ee682f4":
                    eventname = #"hash_511c5e7cabbce4d";
                    persstat = "armorBoxUsed";
                    supername = "super_armor_drop";
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        usesuccessful = entity [[ level.onarmorboxusedbyplayer ]]( player, spawnoptions );
                    }
                    else if ( common_item::items_isenabled() )
                    {
                        usesuccessful = entity supportbox_onplayerusearmor( player, var_14546e102fa89f0a );
                    }
                    
                    break;
                case #"hash_b3d0752364b0193d":
                    eventname = #"hash_9f4eefc129360272";
                    persstat = "utilityBoxUsed";
                    supername = "super_utility_drop";
                    var_247a353f750c339f = undefined;
                    var_bb598bbbac07c3b2 = undefined;
                    var_42ecb4869fe6ece2 = undefined;
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        var_247a353f750c339f = entity [[ level.onarmorboxusedbyplayer ]]( player, spawnoptions );
                    }
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        var_bb598bbbac07c3b2 = entity [[ level.onsupportboxusedbyplayer ]]( player, spawnoptions );
                    }
                    
                    if ( isdefined( level.var_c70c786e914a4337 ) )
                    {
                        var_42ecb4869fe6ece2 = entity [[ level.var_c70c786e914a4337 ]]( player );
                    }
                    
                    usesuccessful = istrue( var_247a353f750c339f ) && istrue( var_bb598bbbac07c3b2 ) && istrue( var_42ecb4869fe6ece2 );
                    break;
                case #"hash_5bb446fe7b2c92da":
                    eventname = #"hash_c58ed46ec4e4b357";
                    persstat = "hauntedBoxUsed";
                    supername = "super_haunted_drop";
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        var_247a353f750c339f = entity [[ level.onarmorboxusedbyplayer ]]( player, spawnoptions );
                    }
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        var_bb598bbbac07c3b2 = entity [[ level.onsupportboxusedbyplayer ]]( player, spawnoptions );
                    }
                    
                    if ( isdefined( level.var_260abcfe2c67c6d4 ) )
                    {
                        var_13c606422b1554a9 = entity [[ level.var_260abcfe2c67c6d4 ]]( player, spawnoptions );
                    }
                    
                    usesuccessful = var_247a353f750c339f && var_bb598bbbac07c3b2 && var_13c606422b1554a9;
                    break;
                case #"hash_187c7d31342c1d7c":
                    eventname = #"hash_54106ec746cc7885";
                    persstat = "blastshieldBoxUsed";
                    supername = "super_blastshield_drop";
                    usesuccessful = entity supportbox_onplayeruse( player );
                    break;
                case #"hash_cf0bf67369c3ff42":
                    eventname = #"hash_7986e8dccdee31d";
                    persstat = "leaderBoxUsed";
                    supername = "super_leader_drop";
                    
                    if ( isdefined( level.var_4161f6bfb35eb94e ) )
                    {
                        usesuccessful = entity [[ level.var_4161f6bfb35eb94e ]]( player );
                    }
                    
                    break;
                case #"hash_bdd285c401cf9498":
                    eventname = #"hash_dd967db653b981b4";
                    persstat = "selfReviveBoxUsed";
                    supername = "super_self_revive_box";
                    
                    if ( isdefined( level.var_a1a56d352c70c610 ) )
                    {
                        usesuccessful = entity [[ level.var_a1a56d352c70c610 ]]( player );
                    }
                    
                    break;
                case #"hash_c8f1686e93be22bd":
                    eventname = #"hash_91188812aa1ea7c5";
                    persstat = "medicalBoxUsed";
                    supername = "super_medical_box";
                    
                    if ( isdefined( level.var_890e6b65228fffc2 ) )
                    {
                        usesuccessful = entity [[ level.var_890e6b65228fffc2 ]]( player, spawnoptions );
                    }
                    else if ( common_item::items_isenabled() )
                    {
                        usesuccessful = entity supportbox_onplayerusemedical( player, var_14546e102fa89f0a );
                    }
                    
                    break;
                case #"hash_81ec3793e86f460":
                case #"hash_1b263df988458934":
                    supername = "super_reward_box";
                    usesuccessful = entity utility::callsharedfunc( getxhash( supername ), #"hash_4e0e0e2e8c02b731", player, spawnoptions );
                    break;
                default:
                    assertmsg( "<dev string:x32d>" + entity.equipmentref + "<dev string:x33d>" );
                    break;
            }
            
            if ( usesuccessful )
            {
                entity.playersused[ player getentitynumber() ] = player;
                entity supportbox_updateheadicon( player );
                entity supportbox_givexpforuse( player, eventname, persstat, supername );
                
                if ( isdefined( entity.var_a4335f460e1238ed ) )
                {
                    entity.var_a4335f460e1238ed += 10;
                }
                
                if ( level.superglobals.staticsuperdata[ supername ].bundle.var_1e16173299f10c72 )
                {
                    allplayersused = 1;
                    squadplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid, 1 );
                    
                    foreach ( squadplayer in squadplayers )
                    {
                        if ( !arraycontains( entity.playersused, squadplayer ) )
                        {
                            allplayersused = 0;
                            break;
                        }
                    }
                    
                    if ( allplayersused )
                    {
                        entity supportbox_destroy();
                    }
                }
            }
        }
    }
}

// Namespace support_box
// Params 0
// Checksum 0x91cd981c, Offset: 0x457b
// Size: 0x3c
function function_4c961ba12b426c16()
{
    if ( isbrgamemode() )
    {
        weapons::function_2cd25260a11d5e40( "ammo_box", &function_16163d2fc1fa0ea1 );
        weapons::function_2cd25260a11d5e40( "armor_box", &function_16163d2fc1fa0ea1 );
        weapons::function_2cd25260a11d5e40( "utility_box", &function_16163d2fc1fa0ea1 );
    }
}

// Namespace support_box
// Params 0
// Checksum 0xc145f316, Offset: 0x45bf
// Size: 0x6a
function function_829ac03dee871dbd()
{
    if ( !isbrgamemode() )
    {
        return 0;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return 0;
    }
    
    if ( level.br_circle_disabled )
    {
        return 0;
    }
    
    var_8b217f269a1d0c8d = exclusion_zones::function_1efc19de6199fff6( self.origin, 0, 0 ) == -1 && !br_circle_util::ispointindangercircle( self.origin, level.var_ea96217a33eb6457 );
    return var_8b217f269a1d0c8d;
}

// Namespace support_box
// Params 1
// Checksum 0xae573e8a, Offset: 0x4632
// Size: 0x239
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_70eeafa0483690f4" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_70eeafa0483690f4", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size >= 1 )
        {
            if ( isdefined( self.headiconfaction ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconfaction, self.bundle.buffedheadicon, 1 );
            }
            
            if ( isdefined( self.headiconbox ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconbox, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_58c6098c31adbc5a = params.bundle.var_58c6098c31adbc5a ?? undefined;
        }
    }
}

// Namespace support_box
// Params 1
// Checksum 0x59929679, Offset: 0x4873
// Size: 0xff
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconfaction ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconfaction, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                if ( isdefined( self.headiconbox ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconbox, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                self.var_58c6098c31adbc5a = undefined;
            }
        }
    }
}

// Namespace support_box
// Params 1
// Checksum 0xd4607ff9, Offset: 0x497a
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace support_box
// Params 0
// Checksum 0xc45c707a, Offset: 0x4999
// Size: 0x1e3
function function_bd63e87bad0a276e()
{
    if ( !self.var_3a41121d030b796b )
    {
        return;
    }
    
    if ( !self getscriptablehaspart( "ammo" ) )
    {
        return;
    }
    
    usages = self.usedcount + 1;
    
    if ( isdefined( self.maxusecount ) && self.maxusecount != -1 && usages > self.maxusecount )
    {
        if ( self getscriptableparthasstate( "ammo", "empty" ) )
        {
            self setscriptablepartstate( "ammo", "empty" );
        }
        
        return;
    }
    
    curindex = usages / self.maxusecount / 6;
    
    switch ( int( curindex ) )
    {
        case 1:
            if ( self getscriptableparthasstate( "ammo", "firstuse" ) )
            {
                self setscriptablepartstate( "ammo", "firstuse" );
            }
            
            break;
        case 2:
            if ( self getscriptableparthasstate( "ammo", "seconduse" ) )
            {
                self setscriptablepartstate( "ammo", "seconduse" );
            }
            
            break;
        case 3:
            if ( self getscriptableparthasstate( "ammo", "thirduse" ) )
            {
                self setscriptablepartstate( "ammo", "thirduse" );
            }
            
            break;
        case 4:
            if ( self getscriptableparthasstate( "ammo", "fourthuse" ) )
            {
                self setscriptablepartstate( "ammo", "fourthuse" );
            }
            
            break;
        case 5:
            if ( self getscriptableparthasstate( "ammo", "fifthuse" ) )
            {
                self setscriptablepartstate( "ammo", "fifthuse" );
            }
            
            break;
        case 6:
            if ( self getscriptableparthasstate( "ammo", "empty" ) )
            {
                self setscriptablepartstate( "ammo", "empty" );
            }
            
            break;
        default:
            break;
    }
}

