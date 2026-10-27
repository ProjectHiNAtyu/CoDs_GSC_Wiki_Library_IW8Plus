// scripts\mp\gametypes\sugar.gsc  (hash_4d27c6c1a3b6fd4e.gscc) (size: 16004 Bytes / 0x3e84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f85d2d4 (528863956)
// size ...... 16004 (0x3e84)
// includes .. 14  (offset: 0x3754)
// strings ... 125 (offset: 0x37c4)
// dev strs .. 1   (offset: 0x3e78)
// exports ... 24  (offset: 0x290c)
// cseg ...... 0xd23 + 0x1be9 (0x290c)
// imports ... 88  (offset: 0x2ccc)
// animtree1 . 0   (offset: 0x3e84)
// animtree2 . 0   (offset: 0x3e84)
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\gold;
#using scripts\mp\gametypes\obj_moneypile;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace sugar;

// Namespace sugar
// Params 0
// Checksum 0x2e1fac36, Offset: 0xd41
// Size: 0x76
function main()
{
    level.allowed = [];
    level.allowed[ 0 ] = game_utility::getgametype();
    level.allowed[ 1 ] = "sugarpile";
    level.initializematchrules = &initializematchrules;
    level.var_ce73b67dce91932f = &function_ce73b67dce91932f;
    level.var_80fc5721e023ef12 = &function_80fc5721e023ef12;
    level.setupvfx = &setupvfx;
    gold::base_main();
    thread initaudio();
}

// Namespace sugar
// Params 0
// Checksum 0x6d852c42, Offset: 0xdbf
// Size: 0x302
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdvar( @"hash_b7318d7f06303895", 1 );
    var_9260fb60d66da973 = getmatchrulesdata( "sugarData", "lootingTimer" );
    level.neutralcapturetime = var_9260fb60d66da973 > 0 ? var_9260fb60d66da973 : getmatchrulesdata( "goldData", "neutralCaptureTime" );
    var_732178f0e79c50e7 = getmatchrulesdata( "sugarData", "eatTimer" );
    level.enemycapturetime = var_732178f0e79c50e7 > 0 ? var_732178f0e79c50e7 : getmatchrulesdata( "goldData", "enemyCaptureTime" );
    nextActiveTableTimer = getmatchrulesdata( "sugarData", "nextActiveTableTimer" );
    level.neutralpilechangetimer = nextActiveTableTimer > 0 ? nextActiveTableTimer : getmatchrulesdata( "goldData", "neutralPileChangeTimer" );
    var_c798ceef617b8bc3 = getmatchrulesdata( "sugarData", "depositTimer" );
    level.teampiledroptime = var_c798ceef617b8bc3 > 0 ? var_c798ceef617b8bc3 : getmatchrulesdata( "goldData", "teamPileDropTime" );
    tableActiveTimer = getmatchrulesdata( "sugarData", "tableActiveTimer" );
    level.neutralpiletimelimit = tableActiveTimer > 0 ? tableActiveTimer : getmatchrulesdata( "goldData", "neutralPileTimeLimit" );
    level.maxplayermoney = getmatchrulesdata( "goldData", "maxPlayerMoney" );
    level.neutralpilecount = getmatchrulesdata( "goldData", "neutralPileCount" );
    level.goldbarsheavyweightminvalue = getmatchrulesdata( "goldData", "goldBarsHeavyWeightMinValue" );
    level.timerbeforesamesplashappears = getmatchrulesdata( "goldData", "timerBeforeSameSplashAppears" );
    level.enemyscoretoshowwinningsplash = getmatchrulesdata( "goldData", "enemyScoreToShowWinningSplash" );
    level.var_d0b7c40089f7131b = getmatchrulesdata( "sugarData", "maxStealableCookies" );
    level.var_99de3aef5c7772fb = getmatchrulesdata( "sugarData", "cookiesEaten4FirstBuff" );
    level.var_9c1e464a52603165 = getmatchrulesdata( "sugarData", "cookiesEaten4SecondBuff" );
    level.var_533adc979c088e78 = getmatchrulesdata( "sugarData", "cookiesEaten4ThirdBuff" );
    level.var_fd69fb44d1fb494a = level.var_533adc979c088e78;
    level.movementSpeedBuff = getmatchrulesdata( "sugarData", "movementSpeedBuff" );
    setdvar( @"hash_94084550cb0f64e7", 1 + level.movementSpeedBuff );
    level.slideDiveMovementBuff = getmatchrulesdata( "sugarData", "slideDiveMovementBuff" );
    level.healthRegenDelayBuff = getmatchrulesdata( "sugarData", "healthRegenDelayBuff" );
    setdvar( @"hash_396fbb6db81e3ff6", level.healthRegenDelayBuff );
    level.perks = [];
    level.perks[ level.var_99de3aef5c7772fb ] = "specialty_super_speed";
    level.perks[ level.var_9c1e464a52603165 ] = "specialty_warhead";
    level.perks[ level.var_533adc979c088e78 ] = "specialty_regen_delay_reduced";
}

// Namespace sugar
// Params 0
// Checksum 0x77f34abe, Offset: 0x10c9
// Size: 0x46c
function function_ce73b67dce91932f()
{
    level.teambase = 1;
    level.var_e2987972c7026904 = 0;
    level.var_df36669d60a1c27d = 0;
    level.var_e7612a23da6d81ce = "ui_sugar_player_cookies_eaten";
    level.var_71757aabdaab7cce = [];
    level.var_71757aabdaab7cce[ "specialty_super_speed" ] = "ui_sugar_buff_active_first";
    level.var_71757aabdaab7cce[ "specialty_warhead" ] = "ui_sugar_buff_active_second";
    level.var_71757aabdaab7cce[ "specialty_regen_delay_reduced" ] = "ui_sugar_buff_active_third";
    setomnvar( "ui_sugar_max_cookies_edible", level.var_fd69fb44d1fb494a );
    level.objectivehinttext = &"hash_38e3e07d46e7b957";
    level.var_e4ed3b7ce2e6e108 = "ui_icon_waypoint_team_gold";
    level.var_4782e97bc813ce69 = "ui_icon_waypoint_team_gold";
    level.var_d3fe1cf63a25c118 = "ui_icon_waypoint_enemy_gold";
    level.iconmoneypile = "ui_icon_waypoint_cookie";
    level.iconlocked = "ui_icon_waypoint_cookie";
    level.var_b26aa29dc5ad3fe9 = "ui_icon_minimap_gametype_cookie";
    level.var_7ca91561c2f5356b = 2;
    level.var_de7667cb06d02ed5 = "cookie_deposited";
    level.var_eb58d82511ece602 = "cookie_collected";
    level.var_cbfb7a2188d1f893 = "objective_kills";
    level.var_4a31452dd5884868 = "team_moneypile";
    level.var_6e84928eee853b5 = "team_moneypile_custom_trigger";
    level.var_5aa15e433ab5fb72 = "neutral_moneypile";
    level.var_d21713b4df20128b = "neutral_moneypile_custom_trigger";
    level.var_9be4fc75b4c09f7c = "splash_global_cookie_steal";
    level.var_fb58f9f41b70180f = "sugar_secure_cookies";
    level.var_e2c3bb3b92645165 = #"hash_49c31a71f4409ff5";
    level.var_5083bb8c7321f137 = #"hash_e8dcdca04dc128ca";
    level.goldbarmodels = [];
    level.goldbarmodels = [ "t10_loot_gold_bar_sr_01", "t10_loot_gold_bar_sr_02", "t10_loot_gold_bar_sr_03", "t10_loot_gold_bar_sr_04", "t10_loot_gold_bar_sr_05", "t10_loot_gold_bar_sr_06" ];
    level.moneypilesplashes = [];
    level.moneypilesplashes[ "showFriendlyPileSplash" ] = "sugar_friendly_base";
    level.moneypilesplashes[ "showEnemyPileSplash" ] = "sugar_enemy_base";
    level.moneypilesplashes[ "enemyWinning" ] = "sugar_enemy_winning";
    level.moneypilesplashes[ "newPile" ] = "sugar_new_pile";
    level.moneypilesplashes[ "allSecured" ] = "sugar_all_secured";
    level.var_e6bf8af9664dad5 = "uin_sugarrush_t10_new_cookiepile_unlocking";
    level.var_5a33157553cea407 = "uin_sugarrush_t10_enter_locked_cookiepile_zone";
    level.var_1c4afdc2ab0461c1 = "amb_emt_sugarrush_t10_cash_single_cookie";
    level.var_da2bc8b4af672c85 = "amb_emt_sugarrush_t10_cash_last_cookie";
    level.var_26b3c0d764a9f840 = "amb_emt_sugarrush_t10_collect_single_cookie";
    level.var_93c3a8f9411b63f0 = "amb_emt_sugarrush_t10_collect_last_cookie";
    level.var_353e2c3d8e6a7847 = "amb_emt_sugarrush_t10_collect_bag_cookies";
    level.var_cee1359744ddbca8 = "amb_emt_sugarrush_t10_dropping_cookies";
    level.var_d6d4aeac736fb4cc = "amb_emt_sugarrush_t10_dropping_some_cookies";
    level.var_3b969520cff1f7d3 = "amb_emt_sugarrush_t10_eat_single_cookie";
    level.var_f611366fc57edb2c = "amb_emt_sugarrush_t10_cookie_bag_empty";
    level.var_51a2ccca9b7ac32a = "amb_emt_sugarrush_t10_cookie_bag_full";
    level.var_996740190e9519f0 = "amb_mus_sugarrush_t10_stashes";
    level.buffsfx[ level.var_99de3aef5c7772fb ] = "uin_sugarrush_t10_buff_speed_activated";
    level.buffsfx[ level.var_9c1e464a52603165 ] = "uin_sugarrush_t10_buff_attack_activated";
    level.buffsfx[ level.var_533adc979c088e78 ] = "uin_sugarrush_t10_buff_heal_activated";
    level.var_3af89a1f3a671996 = "amb_emt_sugarrush_t10_full_sugar_rush_activated";
    level.goldeffects[ "pickup" ] = "vfx_misc_sugar_pickup_vm";
    level.goldeffects[ "deposit" ] = "vfx_misc_sugar_deposit_vm";
    level.goldeffects[ "full_constant" ] = "vfx_misc_sugar_full_constant_vm";
    level.goldeffects[ "steal" ] = "vfx_misc_sugar_eating_vm";
    level.buffvfx[ level.var_99de3aef5c7772fb ] = "vfx_t10_gameplay_mp_perk_sugar_buff_cam_01";
    level.buffvfx[ level.var_9c1e464a52603165 ] = "vfx_t10_gameplay_mp_perk_sugar_buff_cam_02";
    level.buffvfx[ level.var_533adc979c088e78 ] = "vfx_t10_gameplay_mp_perk_sugar_buff_cam_03";
    level.buffvfx[ "maxBuffEffect" ] = "vfx_t10_gameplay_mp_perk_sugar_buff_cam_04";
    level.var_c2e2d3a4caab63a6 = %"hash_125680f8a06b3db";
    level.var_7e9b2a787d0f71bd = &"T10_MP_INGAME_ONLY/SUGAR_VAULT_ENEMY";
    level.var_d606d9411cd70b91 = &depositcookie;
    level.var_fd0f9801c066cd36 = &stealcookie;
    level.var_c6a0a0f4f86321c2 = &function_c6a0a0f4f86321c2;
}

// Namespace sugar
// Params 0
// Checksum 0xe071a205, Offset: 0x153d
// Size: 0x64
function function_80fc5721e023ef12()
{
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &gold::getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onnormaldeath = &onnormaldeath;
    level.modeonsuicidedeath = &onsuicidedeath;
    level.weapondropfunction = &dropweaponfordeath;
}

// Namespace sugar
// Params 0, eflags: 0x4
// Checksum 0x5f6c6204, Offset: 0x15a9
// Size: 0x27
function private initaudio()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_sugarrush_t10" );
}

// Namespace sugar
// Params 0, eflags: 0x4
// Checksum 0xf8d1dc95, Offset: 0x15d8
// Size: 0x178
function private setupvfx()
{
    level._effect[ level.goldeffects[ "pickup" ] ] = loadfxasset( level.goldeffects[ "pickup" ] );
    level._effect[ level.goldeffects[ "deposit" ] ] = loadfxasset( level.goldeffects[ "deposit" ] );
    level._effect[ level.goldeffects[ "full_constant" ] ] = loadfxasset( level.goldeffects[ "full_constant" ] );
    level._effect[ level.goldeffects[ "steal" ] ] = loadfxasset( level.goldeffects[ "steal" ] );
    level._effect[ level.buffvfx[ level.var_99de3aef5c7772fb ] ] = loadfxasset( level.buffvfx[ level.var_99de3aef5c7772fb ] );
    level._effect[ level.buffvfx[ level.var_9c1e464a52603165 ] ] = loadfxasset( level.buffvfx[ level.var_9c1e464a52603165 ] );
    level._effect[ level.buffvfx[ level.var_533adc979c088e78 ] ] = loadfxasset( level.buffvfx[ level.var_533adc979c088e78 ] );
    level._effect[ "maxBuffEffect" ] = loadfxasset( level.buffvfx[ "maxBuffEffect" ] );
}

// Namespace sugar
// Params 0
// Checksum 0xc6d63753, Offset: 0x1758
// Size: 0x10
function onstartgametype()
{
    gold::base_onstartgametype();
    thread function_cb80aab33e128741();
}

// Namespace sugar
// Params 1
// Checksum 0xa6524258, Offset: 0x1770
// Size: 0x50
function onplayerconnect( player )
{
    gold::base_onplayerconnect( player );
    player.cookieseaten = 0;
    player.stolencookies = 0;
    player.givenperks = [];
    player function_ffebde0cdcbedb93();
    player thread gold::function_5d22ac46bde75cab( 1 );
}

// Namespace sugar
// Params 1
// Checksum 0x54976447, Offset: 0x17c8
// Size: 0x23
function onspawnplayer( revivespawn )
{
    gold::base_onspawnplayer( revivespawn );
    function_97b79995d87c29b2();
    function_ffebde0cdcbedb93();
}

// Namespace sugar
// Params 6
// Checksum 0x1ca711d7, Offset: 0x17f3
// Size: 0x51
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    gold::function_6c4abc3cd05a0d7c( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    victim function_97b79995d87c29b2();
}

// Namespace sugar
// Params 1
// Checksum 0xb884c001, Offset: 0x184c
// Size: 0x1e
function onsuicidedeath( victim )
{
    gold::function_f70f4e5477ecdd7f( victim );
    victim function_97b79995d87c29b2();
}

// Namespace sugar
// Params 4
// Checksum 0xba274980, Offset: 0x1872
// Size: 0x34
function dropweaponfordeath( attacker, smeansofdeath, weaponoverride, damage )
{
    gold::function_43e09cc220540096( attacker, smeansofdeath, weaponoverride, damage );
}

// Namespace sugar
// Params 1
// Checksum 0x8f5a28d2, Offset: 0x18ae
// Size: 0x4cd
function depositcookie( dropzone )
{
    self notify( #"hash_2a38d868124a2b67" );
    self endon( #"hash_2a38d868124a2b67" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_660e947eda5d64e4 = 0;
    self.isdepositing = 0;
    self.usetime = self.currentmoney * level.teampiledroptime * 1000;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    userate = self.objectivescaler;
    startmoney = self.currentmoney;
    currentprogress = 0;
    
    if ( !isdefined( dropzone.gameobject.clientprogress[ self.clientid ] ) )
    {
        dropzone.gameobject.clientprogress[ self.clientid ] = 0;
    }
    
    while ( self istouching( dropzone ) && isalive( self ) && !self ismeatshieldvictim() && self.currentmoney > 0 && !level.gameended )
    {
        dropzone.gameobject.clientprogress[ self.clientid ] += updateratems * userate;
        currentprogress += updateratems * userate;
        
        if ( startmoney > 1 )
        {
            gameobjects::updateuiprogress( dropzone.gameobject );
        }
        
        if ( currentprogress >= level.teampiledroptime * 1000 )
        {
            self.isdepositing = 1;
            thread points::doscoreevent( #"hash_e54e69f2e2f071e2" );
            self.var_660e947eda5d64e4 += 1;
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ level.var_de7667cb06d02ed5 ] ) )
                {
                    self.leaderboarddata[ level.var_de7667cb06d02ed5 ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ level.var_de7667cb06d02ed5 ] ) )
                {
                    [[ level.leaderboardfunc[ level.var_de7667cb06d02ed5 ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( self.pers[ level.var_de7667cb06d02ed5 ] ) )
                {
                    self.pers[ level.var_de7667cb06d02ed5 ] += 1;
                }
            }
            
            stats::setextrascore0( self.pers[ level.var_de7667cb06d02ed5 ] );
            dropzone.gameobject.currentmoney += 1;
            gold::function_b7678d37022afe8a( self.currentmoney - 1 );
            eatcookie();
            obj_moneypile::function_3a0a8ebf10d60239( dropzone.gameobject );
            self playlocalsound( level.var_1c4afdc2ab0461c1 );
            
            if ( isdefined( self.var_8d05f30e445f6cea ) )
            {
                stopfxontagforclients( utility::getfx( level.goldeffects[ "full_constant" ] ), self.var_8d05f30e445f6cea, "tag_origin", self );
                self.var_8d05f30e445f6cea delete();
                self notify( #"gold_deposited" );
            }
            
            if ( !self.var_b8c5a17122756db0 )
            {
                self.var_b8c5a17122756db0 = 1;
            }
            
            currentprogress = 0;
            playfxontagforclients( utility::getfx( level.goldeffects[ "deposit" ] ), self, "tag_eye", self );
            
            if ( self.var_660e947eda5d64e4 == self.maxmoney )
            {
                wait 0.1;
                thread points::doscoreevent( #"hash_fb6decda4b9cd9de" );
                self.dlogs_gold_full_deposit++;
            }
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    if ( isalive( self ) && self.isdepositing && self.currentmoney == 0 )
    {
        hud_message::function_78fedf6f526825f4( "sugar_all_secured", level.gametypebundle.var_e662dd7f27d462eb );
        playerteamflag = self.team == "axis" ? "axis_team_steal_splash_appeared" : "allies_team_steal_splash_appeared";
        
        if ( !utility::flag( playerteamflag ) )
        {
            hud_message::function_ef4318a0090caa0f( #"hash_80e21ea029970929" );
        }
    }
    
    self.var_94e40a5960ec5c1e = 1;
    obj_moneypile::moneypile_onuseend( self, dropzone );
}

// Namespace sugar
// Params 2
// Checksum 0xf07ba319, Offset: 0x1d83
// Size: 0x40d
function stealcookie( player, dropzone )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player setclientomnvar( "ui_gold_show_inventory", 0 );
    
    if ( level.var_d0b7c40089f7131b > 0 && player.stolencookies >= level.var_d0b7c40089f7131b )
    {
        return;
    }
    
    player.usetime = player.currentmoney * level.enemycapturetime * 1000;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    userate = player.objectivescaler;
    startmoney = player.currentmoney;
    var_c840daece0583595 = 0;
    currentprogress = 0;
    
    if ( !isdefined( dropzone.gameobject.clientprogress[ player.clientid ] ) )
    {
        dropzone.gameobject.clientprogress[ player.clientid ] = 0;
    }
    
    while ( player istouching( dropzone ) && player::isreallyalive( player ) && !player ismeatshieldvictim() && dropzone.gameobject.currentmoney > 0 && !level.gameended && ( level.var_d0b7c40089f7131b == 0 || player.stolencookies < level.var_d0b7c40089f7131b ) )
    {
        player setclientomnvar( "ui_gold_show_inventory", 0 );
        dropzone.gameobject.clientprogress[ player.clientid ] += updateratems * userate;
        currentprogress += updateratems * userate;
        
        if ( currentprogress >= level.enemycapturetime * 1000 )
        {
            dropzone.gameobject.currentmoney -= 1;
            obj_moneypile::function_3a0a8ebf10d60239( dropzone.gameobject );
            player thread points::doscoreevent( #"hash_b0116b1d1fdffa13" );
            player playlocalsound( level.var_3b969520cff1f7d3 );
            obj_moneypile::function_41a84ac2c3d3ff65( player );
            obj_moneypile::function_11195bb369c4cb7f( dropzone.gameobject.ownerteam, 1 );
            player eatcookie( 1 );
            playfxontagforclients( utility::getfx( level.goldeffects[ "steal" ] ), player, "tag_eye", player );
            
            if ( dropzone.gameobject.ownerteam != "neutral" && dropzone.gameobject.compassicons[ "friendly" ] != "waypoint_defend_moneypile" )
            {
                dropzone.gameobject gameobjects::setobjectivestatusicons( "waypoint_defend_moneypile", "waypoint_steal_moneypile" );
                friendlylabel = gameobjects::getwaypointstring( dropzone.gameobject.compassicons[ "friendly" ] );
                objidpoolmanager::update_objective_setfriendlylabel( dropzone.gameobject.var_338a55f1a3def196, friendlylabel );
            }
            
            currentprogress = 0;
        }
        
        trackedgold = startmoney + var_c840daece0583595;
        
        if ( trackedgold < player.currentmoney && player.currentmoney < player.maxmoney )
        {
            golddifference = player.currentmoney - trackedgold;
            var_c840daece0583595 += golddifference;
            thread obj_moneypile::function_3778c8bca914563a( dropzone.gameobject, player, golddifference * player.usetime * 1000 );
        }
        
        wait updaterate;
        hostmigration::waittillhostmigrationdone();
    }
    
    obj_moneypile::moneypile_onuseend( player, dropzone );
}

// Namespace sugar
// Params 2
// Checksum 0x67d83794, Offset: 0x2198
// Size: 0xee
function eatcookie( issteal = 0, value = 1 )
{
    if ( self.cookieseaten + value == level.var_99de3aef5c7772fb )
    {
        self.var_a9168a63db9c1820++;
    }
    else if ( self.cookieseaten + value == level.var_9c1e464a52603165 )
    {
        self.var_a9168d63db9c1eb9++;
    }
    else if ( self.cookieseaten + value == level.var_533adc979c088e78 )
    {
        self.var_a9168c63db9c1c86++;
    }
    
    if ( issteal )
    {
        self.stolencookies++;
        self.dlogs_gold_stolen++;
    }
    else
    {
        self.dlogs_gold_deposited++;
    }
    
    self.cookieseaten += value;
    updateplayerperks( 0 );
    self [[ level.var_c6a0a0f4f86321c2 ]]( issteal );
    updateplayereffects();
}

// Namespace sugar
// Params 0
// Checksum 0xe528dd6b, Offset: 0x228e
// Size: 0x2e
function function_97b79995d87c29b2()
{
    self.stolencookies = 0;
    self.cookieseaten = 0;
    updateplayerperks( 1 );
    self [[ level.var_c6a0a0f4f86321c2 ]]( 1 );
}

// Namespace sugar
// Params 1
// Checksum 0xa97e810c, Offset: 0x22c4
// Size: 0xef
function updateplayerperks( var_c2c2d8f9c3a18577 )
{
    if ( var_c2c2d8f9c3a18577 )
    {
        foreach ( perk in self.givenperks )
        {
            perk::removeperk( perk );
        }
        
        self.givenperks = [];
        self.var_fff20d0e22e94e9c = 0;
        return;
    }
    
    perk = level.perks[ self.cookieseaten ];
    
    if ( perk )
    {
        perk::giveperk( perk );
        self.givenperks[ self.givenperks.size ] = perk;
        
        if ( perk == "specialty_super_speed" )
        {
            self.var_fff20d0e22e94e9c = 1;
        }
    }
}

// Namespace sugar
// Params 0
// Checksum 0x9bc61a02, Offset: 0x23bb
// Size: 0xbd
function updateplayereffects()
{
    if ( self.cookieseaten >= level.var_fd69fb44d1fb494a )
    {
        if ( self.var_114a462fc663b688 )
        {
            return;
        }
        else
        {
            self.var_114a462fc663b688 = 1;
            function_7ad7d1ed69df1c5e( level._effect[ "maxBuffEffect" ] );
            self playsoundtoplayer( level.var_3af89a1f3a671996, self );
        }
    }
    
    vfx = level.buffvfx[ self.cookieseaten ];
    sfx = level.buffsfx[ self.cookieseaten ];
    
    if ( vfx && sfx )
    {
        playfxontagforclients( utility::getfx( vfx ), self, "tag_eye", self );
        self playsoundtoplayer( sfx, self );
    }
}

// Namespace sugar
// Params 1, eflags: 0x4
// Checksum 0x6736df6f, Offset: 0x2480
// Size: 0x91
function private function_7ad7d1ed69df1c5e( vfx )
{
    if ( !self.var_76e0dc6caeacde71 )
    {
        self.var_76e0dc6caeacde71 = spawn( "script_model", self gettagorigin( "tag_eye" ) );
        self.var_76e0dc6caeacde71 setmodel( "tag_origin" );
        self.var_76e0dc6caeacde71 linkto( self, "tag_eye", ( 0, 0, 0 ), self gettagangles( "tag_eye" ) );
        waitframe();
        playfxontagforclients( vfx, self.var_76e0dc6caeacde71, "tag_origin", self );
        thread function_db0c4b6f4ace5ee9();
    }
}

// Namespace sugar
// Params 0
// Checksum 0x16035b6b, Offset: 0x2519
// Size: 0x50
function function_db0c4b6f4ace5ee9()
{
    self waittill( #"death_or_disconnect" );
    
    if ( self )
    {
        stopfxontagforclients( level._effect[ "maxBuffEffect" ], self.var_76e0dc6caeacde71, "tag_origin", self );
    }
    
    if ( self.var_76e0dc6caeacde71 )
    {
        self.var_76e0dc6caeacde71 delete();
    }
}

// Namespace sugar
// Params 0
// Checksum 0xfa13f505, Offset: 0x2571
// Size: 0x1d
function function_ffebde0cdcbedb93()
{
    self.var_114a462fc663b688 = 0;
    self stoploopsound( level.var_3af89a1f3a671996, 1 );
}

// Namespace sugar
// Params 1
// Checksum 0x26c7cb2e, Offset: 0x2596
// Size: 0x15b
function function_c6a0a0f4f86321c2( suppressinventory )
{
    if ( self getclientomnvar( "ui_gold_show_inventory" ) == 0 && player::isreallyalive( self ) && !suppressinventory )
    {
        thread gold::function_813a6d4ac34cdd35();
        return;
    }
    
    self setclientomnvar( "ui_gold", self.currentmoney );
    self setclientomnvar( "ui_hud_carried_item_count", self.currentmoney );
    self setclientomnvar( level.var_e7612a23da6d81ce, self.cookieseaten >= level.var_fd69fb44d1fb494a ? level.var_fd69fb44d1fb494a : self.cookieseaten );
    self setclientomnvar( "ui_objectiveSteppedProgressBar", self.currentmoney / self.maxmoney );
    thread gold::function_b9414aec5e5fbf38();
    
    foreach ( perk in level.perks )
    {
        omnvar = level.var_71757aabdaab7cce[ perk ];
        self setclientomnvar( omnvar, arraycontains( self.givenperks, perk ) );
    }
}

// Namespace sugar
// Params 0
// Checksum 0x46b34f36, Offset: 0x26f9
// Size: 0x213
function function_cb80aab33e128741()
{
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    foreach ( player in level.players )
    {
        player dlog_recordplayerevent( "dlog_event_mp_player_sugar_matchend", [ "gold_collected", player.dlogs_gold_collected ?? 0, "gold_deposited", player.dlogs_gold_deposited ?? 0, "gold_stolen", player.dlogs_gold_stolen ?? 0, "gold_stolen_success", player.dlogs_gold_stolen_success ?? 0, "stash_visit_neutral", player.dlogs_stash_visit_neutral ?? 0, "stash_visit_friendly", player.dlogs_stash_visit_friendly ?? 0, "stash_visit_enemy", player.dlogs_stash_visit_enemy ?? 0, "player_lives", player.dlogs_player_lives ?? 0, "gold_capacity_reached", player.dlogs_gold_capacity_reached ?? 0, "gold_full_deposit", player.dlogs_gold_full_deposit ?? 0, "map_name", level.mapname, "sugar_buff_1", player.var_a9168a63db9c1820 ?? 0, "sugar_buff_2", player.var_a9168d63db9c1eb9 ?? 0, "sugar_buff_3", player.var_a9168c63db9c1c86 ?? 0 ] );
    }
}

