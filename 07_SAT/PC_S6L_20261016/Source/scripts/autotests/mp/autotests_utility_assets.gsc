// scripts\autotests\mp\autotests_utility_assets.gsc  (hash_6cfadb08c64552b8.gscc) (size: 22316 Bytes / 0x572c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4fe0a45 (3304983109)
// size ...... 22316 (0x572c)
// includes .. 7   (offset: 0x429c)
// strings ... 429 (offset: 0x42d4)
// dev strs .. 0   (offset: 0x572c)
// exports ... 15  (offset: 0x3c6c)
// cseg ...... 0x2316 + 0x1956 (0x3c6c)
// imports ... 33  (offset: 0x3ec4)
// animtree1 . 0   (offset: 0x572c)
// animtree2 . 0   (offset: 0x572c)
#using scripts\autotests\autotests;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\operator;

#namespace autotests_utility_assets;

// Namespace autotests_utility_assets
// Params 1
// Checksum 0xa913ca5a, Offset: 0x2334
// Size: 0x54
function test_setorigin( origin )
{
    self setorigin( origin );
    starttime = gettime();
    
    while ( !self isonground() )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Player did not land on ground in 5 seconds.", 0, "scripts/autotests/mp/autotests_utility_assets.gsc", 16 );
            return;
        }
    }
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0xab17711a, Offset: 0x2390
// Size: 0x10d
function function_afcf75b6412f73b9()
{
    selected_skins = [];
    skinRefs = operator::function_27f5412663e0a09();
    
    foreach ( skinref in skinRefs )
    {
        if ( !skinref )
        {
            continue;
        }
        
        skinbundle = operator::function_d1e10cddb12fbe17( skinref );
        visibilitylevel = skinbundle.visibilitylevel;
        
        if ( visibilitylevel )
        {
            if ( isxhash( visibilitylevel ) )
            {
                if ( visibilitylevel == #"always_hidden" )
                {
                    continue;
                }
                
                /#
                    visibilitylevel = getxhashsourcename( visibilitylevel );
                #/
            }
            
            if ( isstring( visibilitylevel ) && !isstartstr( visibilitylevel, "CER_SEASON" ) )
            {
                continue;
            }
        }
        
        selected_skins[ selected_skins.size ] = autotests::as_string( skinref );
    }
    
    return selected_skins;
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0x4d862503, Offset: 0x24a6
// Size: 0x1a4
function function_cfcc8cf1bd83f387()
{
    blueprintnames = [];
    var_15dd55f313034f43 = bots_loadout::function_14747e70f3e57908( &function_eae94d3ad5447714, 0, 0 );
    
    foreach ( weapon in var_15dd55f313034f43 )
    {
        rootname = weapon::getweaponrootname( weapon );
        assetname = undefined;
        
        if ( isdefined( level.weaponmapdata[ rootname ].assetname ) )
        {
            assetname = level.weaponmapdata[ rootname ].assetname;
        }
        
        foreach ( varianthash, variantid in getweaponblueprintnames( weapon ) )
        {
            weaponinfo = spawnstruct();
            weaponinfo.name = weapon;
            weaponinfo.assetname = assetname;
            weaponinfo.rootname = rootname;
            weaponinfo.variantid = variantid;
            weaponinfo.varianthash = varianthash;
            blueprintnames[ blueprintnames.size ] = weaponinfo;
        }
    }
    
    return blueprintnames;
}

// Namespace autotests_utility_assets
// Params 1
// Checksum 0x7e669c1, Offset: 0x2653
// Size: 0x99
function function_e8be7eb679e055bc( varianthash )
{
    blueprintnames = function_cfcc8cf1bd83f387();
    
    foreach ( weaponinfo in blueprintnames )
    {
        if ( weaponinfo.varianthash == varianthash )
        {
            return weaponinfo;
        }
    }
}

// Namespace autotests_utility_assets
// Params 1, eflags: 0x4
// Checksum 0xcd06c48d, Offset: 0x26f5
// Size: 0x39, Type: bool
function private function_eae94d3ad5447714( weapon )
{
    if ( !weapon::iscacprimaryweapon( weapon ) )
    {
        return false;
    }
    
    ammotype = item_ammo::function_b162feeed34a4640( weapon );
    
    if ( !isdefined( ammotype ) )
    {
        return false;
    }
    
    return true;
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0xc420aadd, Offset: 0x2737
// Size: 0x3f
function function_2cb796a82417f4a1()
{
    prefix = tolower( getprojectname() );
    
    if ( prefix == "wz2" )
    {
        prefix = "t10";
    }
    else if ( prefix == "saw" )
    {
        prefix = "sat";
    }
    
    return prefix;
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0xf99c67c2, Offset: 0x277f
// Size: 0x3a
function function_ce83b8dc73a08ccf()
{
    projectname = function_2cb796a82417f4a1();
    
    if ( isbrgamemode() )
    {
        return getxhashasset( "blacknoir_eastern_a" );
    }
    
    if ( projectname == "t10" )
    {
        return getxhashasset( "t10_usa_pl_jack_gray1_skin" );
    }
}

// Namespace autotests_utility_assets
// Params 2
// Checksum 0x3de5b0f, Offset: 0x27c1
// Size: 0xd6
function getrandomattachments( weaponname, var_408522e3869135b )
{
    rootname = weapon::getweaponrootname( weaponname );
    slots = [ "receiver", "frontpiece", "backpiece", "magazine", "muzzle", "reargrip", "scope" ];
    attachments = [];
    
    for ( i = 0; i < var_408522e3869135b ; i++ )
    {
        slot = utility::array_random( slots );
        attachmentlist = function_2e5ecdd8ac47f308( weaponname, slot, 1 );
        randompick = utility::array_random( attachmentlist );
        attachments[ attachments.size ] = randompick;
    }
    
    return attachments;
}

// Namespace autotests_utility_assets
// Params 2
// Checksum 0x9843a0f4, Offset: 0x28a0
// Size: 0x9c
function function_702fafde642f1e6f( items, substring )
{
    newitems = [];
    
    foreach ( item in items )
    {
        if ( issubstr( item, substring ) )
        {
            newitems[ newitems.size ] = item;
        }
    }
    
    return newitems;
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0x3f300108, Offset: 0x2945
// Size: 0x86
function function_ef152c4cfa78485e()
{
    weapontypes = [ "pi", "ar", "sm", "lm", "me", "sl", "ks", "dm", "sn", "sh", "br", "la", "other" ];
    return weapontypes;
}

// Namespace autotests_utility_assets
// Params 1
// Checksum 0x34eb1815, Offset: 0x29d4
// Size: 0x12c
function function_86d95cabe35d0078( projectname )
{
    weapontypes = function_ef152c4cfa78485e();
    weaponlist = [];
    
    foreach ( weapontype in weapontypes )
    {
        var_ad7c88e5c6c260da = function_8bfef6532b69a433( weapontype );
        filteredlist = function_702fafde642f1e6f( var_ad7c88e5c6c260da, projectname + "_" );
        
        foreach ( weapon in filteredlist )
        {
            weaponlist[ weaponlist.size ] = weapon;
        }
    }
    
    return weaponlist;
}

// Namespace autotests_utility_assets
// Params 1
// Checksum 0xd6d7bbd7, Offset: 0x2b09
// Size: 0xa1d
function function_8bfef6532b69a433( weapontype )
{
    pi = [ "iw9_pi_golf17", "iw9_pi_golf18", "iw9_pi_decho", "iw9_pi_papa220", "iw9_pi_swhiskey", "t10_pi_p42_pyork", "iw9_pi_tango9", "iw9_pi_dechoauto", "iw9_pi_mike2011", "jup_jp07_pi_uzulum", "jup_jp12_pi_mike93", "jup_cp24_pi_glima21", "jup_jp14_pi_rsierra12", "jup_jp32_pi_mpapa9", "t10_pi_p13_usugar9", "t10_pi_p12_paris30", "t10_pi_p14_mable", "t10_pi_p14_stiger", "sat_pi_atlas", "sat_pi_timir", "sat_pi_orion", "sat_pi_ztronraygun" ];
    ar = [ "t10_ar_p34_tbaker", "t10_ar_p45_kent", "t10_ar_p47_gilroy", "t10_ar_p49_fresno", "t10_ar_p54_aspen", "iw9_ar_schotel", "iw9_ar_mcbravo", "iw9_ar_kilo53", "iw9_ar_augolf", "iw9_ar_golf3", "iw9_ar_mike4", "iw9_ar_mike16", "iw9_ar_akilo", "iw9_ar_akilo74", "iw9_ar_akilo105", "iw9_ar_mcharlie", "iw9_ar_scharlie", "iw9_ar_acharlie300", "iw9_ar_helima", "iw9_ar_falpha", "iw9_ar_fecho", "iw9_ar_ralpha", "iw9_ar_malima", "jup_jp01_ar_golf36", "jup_jp02_ar_bromeo805", "jup_jp19_ar_acharlie", "jup_jp05_ar_foxtrot2000", "jup_jp08_ar_qbravo97", "jup_jp25_ar_talpha95", "jup_jp36_ar_anov94", "jup_cp06_ar_falpha", "jup_jp34_ar_balpha27", "jup_jp44_ar_stango44", "t10_ar_p01_coslo723", "t10_ar_p02_aking74", "t10_ar_p04_clove", "t10_ar_p05_rmary2", "t10_ar_p06_asvalor", "t10_ar_p22_able18", "t10_ar_p23_love85", "t10_ar_p05_fable", "t10_ar_p56_milan", "sat_ar_falcon", "sat_ar_hawk", "sat_ar_vulture", "sat_ar_condor", "sat_ar_eagle", "sat_ar_kite" ];
    sm = [ "iw9_sm_mpapa5", "iw9_sm_mpapax", "iw9_sm_apapa", "iw9_sm_aviktor", "iw9_sm_alpha57", "iw9_sm_beta", "iw9_sm_papa", "iw9_sm_mpapa", "iw9_sm_victor", "t10_sm_p41_perth", "t10_sm_p43_schuck", "t10_sm_p52_lisbon", "iw9_sm_acharlie45", "iw9_sm_sdelta", "iw9_sm_acharlie9", "jup_jp07_sm_uzulup", "jup_jp07_sm_uzulu", "jup_jp02_sm_scharlie3", "jup_cp01_sm_coscar635", "jup_jp04_sm_umike", "jup_jp04_sm_lwhiskey", "jup_jp03_sm_pmike", "jup_jp25_sm_talpham", "jup_cp01_sm_pcharlie9", "jup_jp41_sm_kpappa50", "t10_sm_p04_chuck9", "t10_sm_p03_safox", "t10_sm_p06_sroger3", "t10_sm_p02_geasy9", "t10_sm_p12_roger31", "t10_sm_p21_pparis90", "t10_sm_p28_saug", "iw9_sm_papa90", "iw9_sm_mpapa7", "sat_sm_zebra", "sat_sm_orca", "sat_sm_otter", "sat_sm_puma", "sat_sm_cobra", "sat_sm_komodo" ];
    lm = [ "t10_lm_p33_uxray", "t10_lm_p53_mesa", "iw9_lm_slima", "iw9_lm_ahotel", "iw9_lm_foxtrot", "iw9_lm_rkilo", "iw9_lm_kilo21", "iw9_lm_ngolf7", "iw9_lm_mkilo3", "jup_jp01_lm_mgolf36", "jup_jp06_lm_pkilop", "jup_jp20_lm_evictor", "jup_jp08_lm_qbravo95lsw", "jup_cp05_lm_halpha", "jup_cp15_lm_mkilo3", "jup_jp28_lm_rpapa20", "t10_lm_p07_ksugar58", "t10_lm_p01_aroger10", "t10_lm_p02_puncle21", "sat_lm_hades", "sat_lm_zeus", "sat_lm_ztronjetgun" ];
    me = [ "t10_me_p36_skateboard", "t10_me_p37_katanas", "t10_me_p38_sais", "t10_me_p39_nunchaku", "t10_me_p40_bostaff", "t10_me_p48_keene", "t10_me_p51_pickaxe", "t10_me_p55_bgloves", "iw9_me_riotshield", "iw9_me_knife", "iw9_knifestab", "iw9_me_sword01", "iw9_me_tonfa", "iw9_me_pickaxe", "iw9_me_kamas", "jup_jp23_me_knife", "jup_jp23_me_kalpha", "jup_jp23_me_swhiskey", "jup_jp23_me_pdango", "jup_jp23_me_shotel", "jup_jp23_me_spear", "t10_me_p15_knife", "t10_me_p16_bat", "t10_me_p30_cleaver", "t10_me_p31_drill", "sat_me_knife", "sat_me_shockbaton", "sat_me_ballisticknife" ];
    sl = [ "t10_sl_p35_blauncher", "t10_sl_p44_napa", "t10_sl_p29_goslo" ];
    ks = [ "t10_ks_deathmachine", "sat_ks_handcannon", "sat_ks_deathmachine" ];
    dm = [ "t10_dm_p50_erie", "iw9_dm_pgolf1", "iw9_dm_mike24", "iw9_dm_mike14", "iw9_dm_sa700", "iw9_dm_sbeta", "iw9_dm_scromeo", "iw9_dm_la700", "iw9_dm_xmike2010", "iw9_dm_crossbow", "iw9_dm_stango25", "jup_jp01_dm_slima8", "jup_jp13_dm_svictork", "jup_jp19_dm_acharlied", "jup_jp31_dm_compound", "jup_jp37_dm_kappa98", "t10_dm_p01_sroger25", "t10_dm_p02_aeasy", "t10_dm_p03_sgeorge550", "t10_dm_p05_falove", "t10_dm_p09_svalor", "jup_p38_dm_crossbow", "jup_jp02_dm_bromeop", "jup_p19_dm_sbeta", "jup_p20_dm_mike24", "wpm_p18_dm_soscar14", "iw9_dm_msecho", "sat_dm_scotia", "sat_dm_oman", "sat_dm_kara" ];
    sn = [ "t10_sn_p46_hugo", "iw9_sn_mromeo", "iw9_sn_alpha50", "iw9_sn_limax", "iw9_sn_india", "iw9_sn_walpha", "jup_jp17_sn_hsierra", "jup_jp13_sn_svictor", "jup_jp10_sn_cdelta50", "jup_jp36_sn_boscar", "jup_jp35_sn_moscar", "t10_sn_p09_droger", "t10_sn_p08_ultiger", "t10_sn_p24_love96", "t10_sn_p26_mary82", "sat_sn_drake", "sat_sn_caspian", "sat_sn_baltic" ];
    sh = [ "iw9_sh_charlie725", "iw9_sh_mbravo", "iw9_sh_mviktor", "iw9_sh_mike1014", "iw9_sh_vecho", "iw9_sh_tsierra12", "jup_jp16_sh_recho870", "jup_jp09_sh_oromeo12", "jup_cp01_sh_aromeo410", "jup_jp38_sh_spapa12", "t10_sh_p10_moslo500", "t10_sh_p25_uncle12", "t10_sh_p27_jhavana", "t10_sh_p11_olove", "sat_sh_husky", "sat_sh_akita", "sat_sh_corso" ];
    br = [ "iw9_br_soscar14", "iw9_br_msecho", "iw9_br_ngsierra", "jup_jp02_br_bromeo2", "jup_jp19_br_acharlie450", "jup_cp08_br_xmike5", "jup_jp03_br_aromeo200", "jup_jp40_br_hcharlie36" ];
    la = [ "iw9_la_rpapa", "jup_jp22_la_dromeo", "jup_jp26_la_mike32", "t10_la_p17_pable3", "t10_la_p18_stisaac", "sat_la_fang" ];
    other = [ "tac_cover_mp" ];
    
    if ( weapontype == "pi" )
    {
        return pi;
    }
    
    if ( weapontype == "ar" )
    {
        return ar;
    }
    
    if ( weapontype == "sm" )
    {
        return sm;
    }
    
    if ( weapontype == "lm" )
    {
        return lm;
    }
    
    if ( weapontype == "me" )
    {
        return me;
    }
    
    if ( weapontype == "sl" )
    {
        return sl;
    }
    
    if ( weapontype == "ks" )
    {
        return ks;
    }
    
    if ( weapontype == "dm" )
    {
        return dm;
    }
    
    if ( weapontype == "sn" )
    {
        return sn;
    }
    
    if ( weapontype == "sh" )
    {
        return sh;
    }
    
    if ( weapontype == "br" )
    {
        return br;
    }
    
    if ( weapontype == "la" )
    {
        return la;
    }
    
    if ( weapontype == "other" )
    {
        return other;
    }
}

// Namespace autotests_utility_assets
// Params 1
// Checksum 0xf5444640, Offset: 0x352e
// Size: 0x1b9
function function_11fd9d7231952a28( operators )
{
    skins = [];
    
    foreach ( operatorname in operators )
    {
        found = 0;
        hashname = getxhashasset( operatorname );
        operatorrefs = operator::getoperatorrefs();
        
        foreach ( operatorref in operatorrefs )
        {
            if ( operatorref == hashname )
            {
                skinRefs = operator::function_98bc5ea0c0c97599( operatorref );
                
                foreach ( skinref in skinRefs )
                {
                    skins[ skins.size ] = autotests::as_string( skinref );
                }
                
                found = 1;
                break;
            }
        }
        
        if ( !found )
        {
            skins[ skins.size ] = operatorname;
        }
    }
    
    return skins;
}

// Namespace autotests_utility_assets
// Params 0
// Checksum 0x27e593df, Offset: 0x36f0
// Size: 0x57b
function function_6cf56b36fc49d848()
{
    t10_emotes = [ "t10_emote_522_punch", "t10_emote_516_battlepass_s5", "t10_emote_514_battlepass_s5", "t10_emote_515_battlepass_s5", "t10_emote_501_classic_anime_girl", "t10_emote_505_time_machine", "t10_emote_521_action_stormare", "t10_emote_513_battlepass_s5", "t10_emote_504_modern_trojan", "t10_emote_502_apocalypse", "t10_emote_oni", "t10_emote_509_trading_cards", "t10_emote_523_90s_superstar_2", "t10_emote_508_white_ninja", "t10_emote_507_astrology_girl", "t10_emote_517_egyptain_god", "t10_emote506_bonghead", "t10_emote_penguin", "t10_emote_617_nuketown", "t10_emote_503_space_cowboy", "t10_emote1", "t10_emote2", "t10_emote3", "t10_emote4", "t10_emote5", "t10_emote6", "t10_emote7", "t10_emote8", "t10_emote9", "t10_weapon_inspect", "t10_emote10", "t10_emote11", "t10_emote12", "t10_emote13", "t10_emote14", "t10_emote15", "t10_emote16", "t10_emote17", "t10_emote18", "t10_emote19", "t10_emote20", "t10_emote21", "t10_emote22", "t10_emote23", "t10_emote24", "t10_emote25", "t10_emote26", "t10_emote27", "t10_emote28", "t10_emote29", "t10_emote30", "t10_emote31", "t10_emote32", "t10_emote33", "t10_emote34", "t10_emote35", "t10_emote36", "t10_emote37", "t10_emote38", "t10_emote39", "t10_emote40", "t10_emote41", "t10_emote42", "t10_emote43", "t10_emote44", "t10_emote45_cigar", "t10_emote46", "t10_emote47", "t10_emote48_anime", "t10_emote49_stl_mnt_rid", "t10_emote50", "t10_emote53", "t10_emote52", "t10_emote52", "t10_emote55_specialist", "t10_emote54_hacker", "t10_emote56_headhunter", "t10_emote57_ninja_dissapear", "t10_emote58_tombstone", "t10_emote60_aero_space", "t10_emote59_ghillie_suit", "t10_emote61_red_lacquer", "t10_emote62_dont_shoot", "t10_emote63_terminator", "t10_emote64_angel_demon", "t10_emote_144_danceteam_01", "t10_emote_257_dame_time", "t10_emote_220_forever_alone", "t10_214_explosive_specialist", "t10_emote65_red_panda", "t10_emote66_foamfinger_celebration", "t10_emote67_boba_jasmine", "t10_emote68_taro", "t10_emote_202_thai", "t10_emote69_boba_assam", "t10_emote_265_close_call", "t10_emote_113_watching_you", "t10_emote_210_weed_wizard", "t10_emote205_punk_klaus", "t10_emote103_come_at_me_bro", "t10_emote100_roger_that", "t10_emote_358_lettuce", "t10_emote359_cabbage", "t10_emote_289_paintball", "t10_emote253_baby_powder", "t10_emote122_night_night", "t10_emote_354_battle_bot", "t10_emote_365_battle_pass_3", "t10_emote_355_haunted_housse", "t10_emote_369_cardboard", "t10_emote_368_bulldog", "t10_emote_285_big_joke", "t10_emote_370_bacon", "t10_emote_352_nuclear", "t10_emote_356_hammerhead", "t10_emote_363_blackcell", "t10_emote_363_juggling_mortar", "t10_emote_364_finger_crank", "t10_emote_354_combat_robot", "t10_mp_emote_279_redacted", "t10_mp_emote_98_tranquility", "t10_emote_275_deep_voyage_2", "t10_emote_353_necromancer", "t10_emote_362_cucumber", "t10_emote_286_viking", "t10_emote_351_archies_atom", "t10_emote_350_pinata", "t10_emote_371_gameshow", "t10_emote126_champs_celebration", "t10_emote_367_enforcer", "t10_emote_132_geode_golem", "t10_emote_406_anime_zombie", "t10_emote_421_handcuff", "t10_emote_408_punk_shark", "t10_emote_420_shiv_taunt", "t10_emote_417_3d_printer", "t10_emote_423_battlepass_s4", "t10_emote_441_doberman", "t10_emote_405_lightning_god", "t10_emote_404_dark_magic", "t10_emote_409_goated", "t10_emote_422_battlepass", "t10_emote_401_doberman_pistols", "t10_emote_418_alien_queen", "t10_emote_411_low_res", "t10_mp_emote_410_claymation", "t10_emote_402_bichon_corgi", "t10_emote_403_bichon_pitbull", "t10_emote_424_retriever", "t10_emote_412_poodle", "t10_emote_416_japanese_urbanware", "t10_emote_419_fighter_jet", "t10_emote_mechhuman", "t10_emote_510_90s_superstar" ];
    return t10_emotes;
}

