// scripts\anim\battlechatter_events_sat_ob.gsc  (hash_244540a3173b28a6.gscc) (size: 30048 Bytes / 0x7560 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xffa700a2 (4289134754)
// size ...... 30048 (0x7560)
// includes .. 1   (offset: 0x5688)
// strings ... 598 (offset: 0x5690)
// dev strs .. 1   (offset: 0x7554)
// exports ... 5   (offset: 0x5534)
// cseg ...... 0x3111 + 0x2423 (0x5534)
// imports ... 5   (offset: 0x55fc)
// animtree1 . 0   (offset: 0x7560)
// animtree2 . 0   (offset: 0x7560)
#using scripts\common\system;

#namespace battlechatter_events_sat_ob;

// Namespace battlechatter_events_sat_ob
// Params 0, eflags: 0x5
// Checksum 0x7636658, Offset: 0x312f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"battlechatter_events_sat_ob", undefined, &pre_main, undefined );
}

// Namespace battlechatter_events_sat_ob
// Params 0, eflags: 0x4
// Checksum 0x9849cc76, Offset: 0x3150
// Size: 0x6a
function private pre_main()
{
    level.var_69fd4cad0bf3f548 = &function_66165b984da85756;
    
    if ( isdefined( level.battlechatter ) && isdefined( level.battlechatter.eventstrings ) && level.battlechatter.eventstrings.size > 0 )
    {
        level.battlechatter.eventstrings = [];
        function_66165b984da85756();
    }
}

// Namespace battlechatter_events_sat_ob
// Params 0
// Checksum 0x65d74a21, Offset: 0x31c2
// Size: 0x3d
function function_66165b984da85756()
{
    function_c9b444422dbb56f4();
    
    /#
        level.battlechatter.var_63a95eda8c446908 = [];
        level.battlechatter.var_63a95eda8c446908[ "<dev string:x24>" ] = 1;
    #/
}

// Namespace battlechatter_events_sat_ob
// Params 0
// Checksum 0x55e9907, Offset: 0x3207
// Size: 0x232d
function function_c9b444422dbb56f4()
{
    level.battlechatter.eventstrings[ "GLD" ][ "target_wounded" ] = [ "c_affe_gotem", "c_affe_hitem", "c_affe_targethit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "wounded_target" ] = [ "c_affe_gotem", "c_affe_hitem", "c_affe_targethit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "neg_target" ] = [ "c_aqui_targetsghostingme", "c_aqui_wherearetheyhiding" ];
    level.battlechatter.eventstrings[ "GLD" ][ "aquired_target" ] = [ "c_aqui_gotvisual", "c_aqui_targetspotted", "c_aqui_seeemrightthere", "c_aqui_seethehostile" ];
    level.battlechatter.eventstrings[ "GLD" ][ "attacking" ] = [ "c_atta_attacking", "c_atta_movingin" ];
    level.battlechatter.eventstrings[ "GLD" ][ "using_grenade" ] = [ "c_atta_throwingabanger", "c_atta_headsdown" ];
    level.battlechatter.eventstrings[ "GLD" ][ "using_rpg" ] = [ "c_atta_rpggetready", "c_atta_firing" ];
    level.battlechatter.eventstrings[ "GLD" ][ "order_attack" ] = [ "c_atto_attack", "c_atto_openfire", "c_atto_approachandpacify", "c_atto_surroundandpoundlets", "c_atto_moveinboxandisolate", "c_atto_wipethegridnosurvivo", "c_atto_stormin", "c_atto_smashemnosurvivors", "c_atto_now" ];
    level.battlechatter.eventstrings[ "GLD" ][ "order_check_last" ] = [ "c_atto_attack", "c_atto_openfire", "c_atto_approachandpacify", "c_atto_surroundandpoundlets", "c_atto_moveinboxandisolate", "c_atto_wipethegridnosurvivo", "c_atto_stormin", "c_atto_smashemnosurvivors", "c_atto_now" ];
    level.battlechatter.eventstrings[ "GLD" ][ "use_grenade" ] = [ "c_atto_bangit", "c_atto_bangitlightemup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "casualties" ] = [ "c_casu_gettingdownsizedhere", "c_casu_takinghitswheresourb", "c_casu_takinglosses" ];
    level.battlechatter.eventstrings[ "GLD" ][ "casualty" ] = [ "c_casn_soldierdown", "c_casn_no" ];
    level.battlechatter.eventstrings[ "GLD" ][ "copy" ] = [ "c_conf_aok", "c_conf_copy", "c_conf_gotit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_attacking" ] = [ "c_enem_takingfire", "c_enem_needsomehelphere", "c_enem_takinghits" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_using_grenade" ] = [ "c_enem_grenade", "c_enem_watchoutgrenade", "c_enem_incoming" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_using_rpg" ] = [ "c_enem_rpg", "c_enem_rocketgetdown" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_moving" ] = [ "c_enet_theyreonthemove" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_moving_up" ] = [ "c_enet_targetmovingup", "c_enet_theyreadvancing", "c_enet_theyrepushingonus" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_reloading" ] = [ "c_enet_targetsreloading", "c_enet_theyrereloadingnowso" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_getting_cover" ] = [ "c_enet_targettakingcover", "c_enet_theyreincover", "c_enet_hostilestryingtohide", "c_enet_theyrehiding" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_lmg" ] = [ "c_enew_machinegunner", "c_enew_lmg", "c_enew_machinegun" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_shotgun" ] = [ "c_enew_shotgunmoveback", "c_enew_iseeashotgun", "c_enew_shotgun" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_sniper" ] = [ "c_enew_goteyesonthesniper", "c_enew_sniper", "c_enew_avoidthatsniper" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_covered" ] = [ "c_expo_theyreduckingdown", "c_expo_incover", "c_expo_theyrehidingbutnotfo" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_exposed" ] = [ "c_expo_iseeyou", "c_expo_targetexposed", "c_expo_foundyou" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_exposed" ] = [ "c_expo_iseeyou", "c_expo_targetexposed", "c_expo_foundyou" ];
    level.battlechatter.eventstrings[ "GLD" ][ "youre_exposed" ] = [ "c_expo_findcover", "c_expo_youreexposed" ];
    level.battlechatter.eventstrings[ "GLD" ][ "team_enemy_grenade_close" ] = [ "c_gren_no", "c_gren_shit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "killfirm_enemy" ] = [ "c_kill_yes", "c_kill_tookoneout", "c_kill_targetdown" ];
    level.battlechatter.eventstrings[ "GLD" ][ "killfirm_target" ] = [ "c_kill_gotem", "c_kill_targetdown_01", "c_kill_onedown" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ahead" ] = [ "c_posi_straightahead", "c_posi_rightthere", "c_posi_upfront" ];
    level.battlechatter.eventstrings[ "GLD" ][ "behind" ] = [ "c_posi_behindus", "c_posi_lookbehindyou", "c_posi_turnaround" ];
    level.battlechatter.eventstrings[ "GLD" ][ "high" ] = [ "c_posi_uptop", "c_posi_aboveus", "c_posi_lookup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "left" ] = [ "c_posi_leftside", "c_posi_left", "c_posi_onyourleft" ];
    level.battlechatter.eventstrings[ "GLD" ][ "right" ] = [ "c_posi_rightside", "c_posi_right", "c_posi_onyourright" ];
    level.battlechatter.eventstrings[ "GLD" ][ "praise" ] = [ "c_prai_thatsitpushit", "c_prai_goodkeeppushing", "c_prai_niceshot", "c_prai_hellyeah", "c_prai_goodwork" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_low_ammo" ] = [ "c_stat_yougoodonammo", "c_stat_ammogood" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_status" ] = [ "c_stat_theygetyou", "c_stat_youhurt", "c_stat_yougood" ];
    level.battlechatter.eventstrings[ "GLD" ][ "low_ammo" ] = [ "c_stat_runninglow", "c_stat_lowonammo", "c_stat_needsomeammo" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_keepshooting" ] = [ "c_stat_keeponem", "c_stat_wegotemnow", "c_stat_dontletup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_low_ammo" ] = [ "c_stat_runninglow_01", "c_stat_needsomeammo_01" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_okay" ] = [ "c_stat_allgood", "c_stat_imfine", "c_stat_thinkimgood" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_wounded" ] = [ "c_stat_fleshwounditsnothing", "c_stat_illbefine", "c_stat_justascratch" ];
    level.battlechatter.eventstrings[ "GLD" ][ "wounded" ] = [ "c_stat_needhelp", "c_stat_imhit", "c_stat_imwounded" ];
    level.battlechatter.eventstrings[ "GLD" ][ "suppressing" ] = [ "c_supp_moveinigotyou", "c_supp_suppressingfire", "c_supp_gotyoucovered" ];
    level.battlechatter.eventstrings[ "GLD" ][ "getting_cover" ] = [ "c_tact_takingcover", "c_tact_movingtocover", "c_tact_findingcover" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moving" ] = [ "c_tact_moving", "c_tact_takingposition", "c_tact_switching" ];
    level.battlechatter.eventstrings[ "GLD" ][ "movingup" ] = [ "c_tact_pushingup", "c_tact_advancing", "c_tact_movingup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reloading" ] = [ "c_tact_reloading", "c_tact_loadingup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "coverme" ] = [ "c_taco_coverme", "c_taco_getmysix", "c_taco_suppressingfireonme" ];
    level.battlechatter.eventstrings[ "GLD" ][ "move" ] = [ "c_taco_move", "c_taco_gogo", "c_taco_moveit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moveup" ] = [ "c_taco_moveup", "c_taco_advance", "c_taco_pushup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "lost_enemy_solo" ] = [ "c_targ_theyghostedme", "c_targ_lostem", "c_targ_dontseeem" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_target_wounded" ] = [ "c_targ_didyougetem", "c_targ_youhitem", "c_targ_youdropemorwhat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_unhurt" ] = [ "c_targ_imissed", "c_targ_didntgetthem", "c_targ_thisbastardsquick" ];
    level.battlechatter.eventstrings[ "GLD" ][ "lost_enemy_duo" ] = [ "c_targ_welostem", "c_targ_nothinghere", "c_targ_nosignofem" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_lmg" ] = [ "c_tarw_shitmachinegun", "c_tarw_theygotamachinegun", "c_tarw_machinegunner" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_shotgun" ] = [ "c_tarw_theygotashotgun", "c_tarw_goddamnshotgun" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_sniper" ] = [ "c_tarw_headsdowntheyresnipi", "c_tarw_theygotasniper" ];
    level.battlechatter.eventstrings[ "GLD" ][ "whizby_resp" ] = [ "s_aler_overthere", "s_aler_thatway", "s_aler_camefromoverthere" ];
    level.battlechatter.eventstrings[ "GLD" ][ "at_my_location" ] = [ "s_awar_righthere", "s_awar_theyrehere", "s_awar_onmehurry", "s_awar_righthereonme", "s_awar_onme", "s_awar_shittheyrehere", "s_awar_hostile" ];
    level.battlechatter.eventstrings[ "GLD" ][ "flanked" ] = [ "s_awar_movingbehindem", "s_awar_gettingbehindem", "s_awar_flanking" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_first_combat" ] = [ "s_awar_hostilesighted", "s_awar_visualonahostile", "s_awar_hostilemyposition", "s_awar_hostile_01", "s_awar_enemy", "s_awar_hostilehere" ];
    level.battlechatter.eventstrings[ "GLD" ][ "found_target" ] = [ "s_awar_foundem", "s_awar_gotyou", "s_awar_located", "s_awar_gotem", "s_awar_visual", "s_awar_spottedthem" ];
    level.battlechatter.eventstrings[ "GLD" ][ "found_you" ] = [ "s_awar_thereyouare", "s_awar_foundyou", "s_awar_youredone", "s_awar_heyyou", "s_awar_sayyourprayers" ];
    level.battlechatter.eventstrings[ "GLD" ][ "over_there" ] = [ "s_hunf_overthere", "s_hunf_theyreoverthere", "s_hunf_wayoverthere" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moving_alone" ] = [ "s_hunm_moving", "s_hunm_immoving", "s_hunm_changinglocations" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moving_there" ] = [ "s_hunm_letsmoveout", "s_hunm_movingoutletsgo", "s_hunm_movetothenextgridpoi" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moving" ] = [ "s_hunm_nextlocationletsmove", "s_hunm_gotitletsgo", "s_hunm_aokmovingout" ];
    level.battlechatter.eventstrings[ "GLD" ][ "moving_following" ] = [ "s_hunm_gotyoursix", "s_hunm_comingwithyou", "s_hunm_gotyourback" ];
    level.battlechatter.eventstrings[ "GLD" ][ "order_follow_me" ] = [ "s_hunm_followme", "s_hunm_onme", "s_hunm_takingpointletsmove" ];
    level.battlechatter.eventstrings[ "GLD" ][ "order_take_point" ] = [ "s_hunm_leadtheway", "s_hunm_youretheboss", "s_hunm_onyouletsmove", "s_hrep_goaheadrightbehindyo", "s_hrep_taketheleadgotyourba", "s_hrep_illfollowyourlead" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_cornercheck" ] = [ "s_huno_checkyourcorners", "s_huno_scanandpaneyesopen", "s_huno_searcheverycorner" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_order_hold" ] = [ "s_huno_holdit", "s_huno_stop", "s_huno_wait" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_reactions" ] = [ "s_hunr_surprisedintensereac", "s_hunr_surprisedintensereac_01", "s_hunr_surprisedintensereac_02" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_found_anything" ] = [ "s_hrep_gotanything", "s_hrep_heygotsomething", "s_hrep_anyaction", "s_hrep_pickingupanyhotspots", "s_hrep_anything", "s_hrep_theyreherekeeplookin" ];
    level.battlechatter.eventstrings[ "GLD" ][ "inv_ask_first" ] = [ "s_hrep_gotanything", "s_hrep_heygotsomething", "s_hrep_anyaction", "s_hrep_pickingupanyhotspots", "s_hrep_anything", "s_hrep_theyreherekeeplookin" ];
    level.battlechatter.eventstrings[ "GLD" ][ "inv_ask_second" ] = [ "s_hrep_gotanything", "s_hrep_heygotsomething", "s_hrep_anyaction", "s_hrep_pickingupanyhotspots", "s_hrep_anything", "s_hrep_theyreherekeeplookin" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_found_nothing" ] = [ "s_hrep_novisualonthehostile", "s_hrep_nosignofthem", "s_hrep_gridcleannohostiles" ];
    level.battlechatter.eventstrings[ "GLD" ][ "report_nothing" ] = [ "s_hrep_nothingyet", "s_hrep_notpickingupanyhotsp", "s_hrep_nothingtoreport" ];
    level.battlechatter.eventstrings[ "GLD" ][ "report_reply_search" ] = [ "s_hrep_nothingyet", "s_hrep_notpickingupanyhotsp", "s_hrep_nothingtoreport" ];
    level.battlechatter.eventstrings[ "GLD" ][ "report_searching" ] = [ "s_hrep_stillscanning", "s_hrep_searching", "s_hrep_stilllooking" ];
    level.battlechatter.eventstrings[ "GLD" ][ "resp_sound_first" ] = [ "s_hsea_allclear", "s_hsea_nothing", "s_hsea_clear", "s_hsea_secure" ];
    level.battlechatter.eventstrings[ "GLD" ][ "good_hunting" ] = [ "s_hsig_yougotthis", "s_hsig_goodluck", "s_hsig_happyhunting" ];
    level.battlechatter.eventstrings[ "GLD" ][ "confirming" ] = [ "s_idlc_aok", "s_idlc_yup", "s_idlc_copythat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "muttered_confusion" ] = [ "s_idli_thehell", "s_idli_huhhello", "s_idli_maybeitsjustme", "s_idli_whatwasthat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "reply_hear_you" ] = [ "s_idlr_yeah", "s_idlr_goaheadrightbehindyo", "s_idlr_imhere" ];
    level.battlechatter.eventstrings[ "GLD" ][ "report_reply_idle" ] = [ "s_irep_zeroaction", "s_irep_nothinghappening", "s_irep_yupclear", "s_irep_allclear", "s_irep_goodhere", "s_irep_allquiet", "s_irep_gridclean" ];
    level.battlechatter.eventstrings[ "GLD" ][ "lost_target" ] = [ "s_lkpl_lostthem", "s_lkpl_targetsghostingme", "s_lkpl_shittheywerejusthere", "s_lkpl_wheredtheygo" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_target_loc" ] = [ "s_lkpr_gotavisual", "s_lkpr_youseethem", "s_lkpr_whatstheirposition", "s_lkpr_aretheythereornot", "s_lkpr_wherearethey", "s_lkpr_seewheretheywent" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_report_alert" ] = [ "s_lkpo_searchthegrid", "s_lkpo_findthem", "s_lkpo_sweepthearea", "s_unab_needsomereinforcemen", "s_unab_wheresourbackup", "s_unab_needsomehelp" ];
    level.battlechatter.eventstrings[ "GLD" ][ "unaware_backup" ] = [ "s_unac_howmanyhostiles", "s_unac_howmanyofem", "s_unac_howmany" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_enemy_count" ] = [ "s_unal_wheredthatcomefrom", "s_unal_whatsthesource", "s_unal_wherearethey" ];
    level.battlechatter.eventstrings[ "GLD" ][ "ask_enemy_loc" ] = [ "s_unar_whatthe", "s_unar_what", "s_unar_hey", "s_unar_damn", "s_unar_shotsfired" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_whizby" ] = [ "s_ures_closerthanyouthinkst", "s_ures_hellifiknow", "s_ures_couldbeanywhere", "s_ures_novisual" ];
    level.battlechatter.eventstrings[ "GLD" ][ "enemy_loc_resp" ] = [ "s_cmbh_aok", "s_cmbh_roger", "s_cmbh_copy", "s_cmbh_copythat", "s_cmbh_onit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "cmb_hunt_confirmation" ] = [ "s_hunb_cmonwhereyouhiding", "s_hunb_yeahyoubetterhide", "s_hunb_knowyourearoundhere", "s_hunb_showyourselfcoward", "s_hunb_comeoutandplay", "s_hunb_illfindyou", "s_hunb_whereareyou" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt" ] = [ "s_huni_heardsomething", "s_huni_somethingsclose", "s_huni_whatwasthat", "s_huni_iheardthat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_inv_event" ] = [ "s_hres_gotit" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_affirm" ] = [ "s_hres_copy", "s_hres_rogerthat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_copy" ] = [ "s_hres_negative", "s_hres_zeroactivity", "s_hres_nothingyet" ];
    level.battlechatter.eventstrings[ "GLD" ][ "hunt_neg" ] = [ "s_hres_ireadyou" ];
    level.battlechatter.eventstrings[ "GLD" ][ "target_still_close" ] = [ "s_lkpc_dontknowwhathappened", "s_lkpc_couldvesworntheywere", "s_lkpc_theygottabeclose", "s_lkpc_theyghostedmeshit", "s_lkpc_theyrehiding", "s_lkpc_cantbefar", "s_lkpc_ghostingbastards" ];
    level.battlechatter.eventstrings[ "GLD" ][ "surprise" ] = [ "s_hrea_whoa", "s_hrea_holyshit", "s_hrea_damn", "s_hrea_ay", "s_hrea_shit" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "report_alert_combat" ] = [ "c_actr_wevegotahostileinthe", "c_actr_reportofoneormoreint", "c_actr_wevebeencompromisedk" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "order_attack" ] = [ "c_ator_weaponsfree", "c_ator_shootthem", "c_ator_lightthemup" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "order_continue_search" ] = [ "s_huno_theyreouttherekeepse", "s_huno_rebootyoursearchcycl", "s_huno_searchthensearchagai" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "order_stay_alert" ] = [ "s_huno_stayalert", "s_huno_keepyoureyesopen", "s_huno_eyesopenweaponsready" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "ask_found_anything" ] = [ "s_hrep_status", "s_hrep_givemesomething", "s_hrep_givemeasitrep", "s_hrep_sitrep", "s_hrep_findanything", "s_hrep_hopeyougotgoodnews" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "hunt_report_alert" ] = [ "s_hrep_hostilesdetectedtake", "s_hrep_enemyattackingalluni", "s_hrep_hostilessightedallun" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "good_hunting" ] = [ "s_hsig_happyhunting", "s_hsig_staysharp", "s_hsig_getitdone", "s_hsig_rogerthatlockandload" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "confirming" ] = [ "s_idlc_roger", "s_idlc_copythat", "s_idlc_aok" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "use_scene" ] = [ "s_idln_simmons", "s_idln_hoffman", "s_idln_paymer", "s_idln_cooper", "s_idln_jones", "s_idln_walsh", "s_idln_hong", "s_idln_palermo", "s_idln_li", "s_idln_griffin", "s_idln_guzmn", "s_idln_lopez", "s_idln_torres", "s_idln_vega", "s_idln_cho", "s_idln_kim", "s_idln_freeman", "s_idln_glover", "s_idln_davis", "s_idln_tucker", "s_idln_gibson", "s_idln_portman", "s_idln_stillman", "s_idln_weaver", "s_idln_keaton", "s_idln_comein", "s_idln_hey" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "reply_hear_you" ] = [ "s_idlr_starttalking", "s_idlr_goahead", "s_idlr_thisisgonetalktome", "s_idlr_rogerthatgoahead", "s_idlr_thisisgone", "s_idlr_goforgone" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "idle_name" ] = [ "s_hunn_simmons", "s_hunn_hoffman", "s_hunn_paymer", "s_hunn_cooper", "s_hunn_jones", "s_hunn_walsh", "s_hunn_hong", "s_hunn_palermo", "s_hunn_li", "s_hunn_griffin", "s_hunn_guzmn", "s_hunn_lopez", "s_hunn_torres", "s_hunn_vega", "s_hunn_cho", "s_hunn_kim", "s_hunn_freeman", "s_hunn_glover", "s_hunn_davis", "s_hunn_tucker", "s_hunn_gibson", "s_hunn_portman", "s_hunn_stillman", "s_hunn_weaver", "s_hunn_keaton", "s_hunn_listenup", "s_hunn_soldier" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "signoff" ] = [ "s_idls_out", "s_idls_goneout", "s_idls_okaystaysharp", "s_idls_copythatoverandout" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "order_find_perimeter" ] = [ "s_cord_lockdownthearea", "s_cord_clearthegrid", "s_cord_levelthreealertsecur" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "order_find_target" ] = [ "s_cord_whosgoteyesonthetarg", "s_cord_targetsghostingusfin", "s_cord_findthetarget" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "ask_how_copy" ] = [ "s_icom_commscheck", "s_icom_youhearme", "s_icom_onetwoyoureadme" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "report_search" ] = [ "s_alei_sitrep", "s_alei_status", "s_alei_findanything", "s_alei_whatsgoingon", "s_alei_tellmewhatsup" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "report_alert" ] = [ "s_arep_allunitsgridmaybecom", "s_arep_beadvisedpossiblehos", "s_arep_levelthreealertpoten", "s_arep_securitylevelraisedp" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "report_target_location" ] = [ "s_crep_whosgotthevisual", "s_crep_whatstheirlocationda", "s_crep_ineedtheirlocationno", "s_crep_doyouhaveeyesontheta" ];
    level.battlechatter.eventstrings[ "GLD_L" ][ "report_idle" ] = [ "s_idre_status", "s_idre_sitrep", "s_idre_yougood", "s_idre_gotanything", "s_idre_report" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_bubble_shield" ] = [ "c_reab_theythrewupashield", "c_reab_lightthatshieldup", "c_reab_crackthatshieldopen" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_active_camo" ] = [ "c_reac_activecamostaysharp", "c_reac_theygotcamowatchyour", "c_reac_wherethehelldidtheyg" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_special_weapon" ] = [ "c_reas_theyrepackingthebigg", "c_reas_wegottroublestayshar", "c_reas_shitgetback" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_generic_tech" ] = [ "c_reag_theygottechtoostaysh", "c_reag_thatssomenastytechwa", "c_reag_whatthehellisthat" ];
    level.battlechatter.eventstrings[ "GLD" ][ "react_in_air_above" ] = [ "c_posi_uptop", "c_posi_aboveus", "c_posi_lookup" ];
    level.battlechatter.eventstrings[ "GLD" ][ "deploy_dawg" ] = [ "c_depd_deploythedawg", "c_depd_releasethedawg", "c_depd_dawgout" ];
    level.battlechatter.eventstrings[ "GLD" ][ "deploy_hkd" ] = [ "c_deph_hkdsengage", "c_deph_fireupthehkds", "c_deph_getthosehunterkiller" ];
    level.battlechatter.eventstrings[ "GLD" ][ "deploy_bots" ] = [ "c_depb_deploythebots", "c_depb_thebotsllfinishemoff", "c_depb_botswipeemout" ];
    level.battlechatter.eventstrings[ "GLD" ][ "use_generic_tech" ] = [ "c_useg_usethetech", "c_useg_getreadyforasurprise", "c_useg_unleashthattech" ];
    level.battlechatter.eventstrings[ "CRD" ] = level.battlechatter.eventstrings[ "GLD" ];
    level.battlechatter.eventstrings[ "CRD_L" ] = level.battlechatter.eventstrings[ "GLD_L" ];
}

