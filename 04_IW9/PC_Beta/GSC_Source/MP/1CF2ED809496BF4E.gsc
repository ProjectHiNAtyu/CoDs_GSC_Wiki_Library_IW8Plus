// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_35F02578B0C90838()
{
    if ( istrue( game["isLaunchChunk"] ) )
        return;

    minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine( "equip_deployed_decoy", 1 );
    minetriggerdata.triggercallback = ::_id_81D957F621CB0552;
}

_id_9AA20ECDD4292776()
{
    thread scripts\mp\damage::monitordamage( 150, "hitequip", ::_id_1621F495789F13E3, ::_id_19411386FD3D2E2D );
}

_id_1621F495789F13E3( data )
{
    _id_5D24D48D0B8EB170( 1 );
}

_id_19411386FD3D2E2D( data )
{
    _id_4FB949CE5DA41ECA = 0;

    if ( isdefined( data.objweapon.basename ) )
    {
        if ( data.objweapon.basename == "deployed_decoy_mp" )
            return _id_4FB949CE5DA41ECA;
    }

    if ( !isdefined( self ) )
        return _id_4FB949CE5DA41ECA;

    _id_8D480ACE410E1F75 = self.origin;
    _id_B404D98CCC440862 = self.team;
    _id_7CA58B9D801CFA0E = self.owner;
    _id_780FFFABE38CB3B5 = self.maxhealth;
    hits = _id_1E1A5A07121E30F8( data );

    if ( isdefined( hits ) )
    {
        pinglocationenemyteams( _id_8D480ACE410E1F75, _id_B404D98CCC440862, _id_7CA58B9D801CFA0E );
        thread _id_3972A29B456EBEEC( data );
        _id_4FB949CE5DA41ECA = int( ceil( min( 1, hits / 10 ) * _id_780FFFABE38CB3B5 ) );
    }

    if ( isdefined( data.attacker ) && !_id_69ADB0B10BAE1BE4( data ) )
        data.attacker _id_5762AC2F22202BA2::updatedamagefeedback( "hitequip", 0, 0, "hitequip", 0, 1 );

    thread _id_C71D3EEFA843DA49( data );
    return _id_4FB949CE5DA41ECA;
}

_id_C71D3EEFA843DA49( data )
{
    self endon( "death" );
    self notify( "deployedDecoy_animateHitReact" );
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "deployedDecoy_queueDummyDestroy_Interupt" );

    if ( istrue( self._id_3FE87ED1237724CC ) )
        return 0;

    _id_2DC841AFF232FB90 = _id_5D2CE17E3DE0719B( data );

    if ( isdefined( _id_2DC841AFF232FB90 ) )
    {
        self setscriptablepartstate( "hitreact", "neutral", 0 );
        waitframe();

        switch ( _id_2DC841AFF232FB90 )
        {
            case "frontToBack":
                thread _id_6F3C08A3A1B58895();
                break;
            case "backToFront":
                thread _id_B6E412B5E07835A5();
                break;
            case "rightToLeft":
                thread _id_AFF778CCCE490BAE();
                break;
            case "leftToRight":
                thread _id_2FC8C731D6BFD24A();
                break;
            default:
                break;
        }
    }
    else
    {

    }

    thread _id_1C5E39BEB07F8BB3();
}

_id_5D2CE17E3DE0719B( data )
{
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    direction = data.direction_vec;
    _id_DD4FEC1F7555332C = vectordot( forward, direction );
    _id_8BBCF51FF5504B0D = vectordot( right, direction );

    if ( _id_DD4FEC1F7555332C <= -0.707 )
        return "frontToBack";

    if ( _id_DD4FEC1F7555332C >= 0.707 )
        return "backToFront";

    if ( _id_8BBCF51FF5504B0D >= 0.707 )
        return "leftToRight";

    if ( _id_8BBCF51FF5504B0D <= -0.707 )
        return "rightToLeft";
}

#using_animtree("scriptables");

_id_6F3C08A3A1B58895()
{
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_front", 0 );
            wait( getanimlength( %iw9_mp_decoymine_hitreac_front ) );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_front", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_hitreac_front ) );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_front", 0 );
            wait( getanimlength( %iw9_mp_decoymine_swim_hitreac_front ) );
            break;
        default:
            break;
    }
}

_id_B6E412B5E07835A5()
{
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_back", 0 );
            wait( getanimlength( %iw9_mp_decoymine_hitreac_back ) );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_back", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_hitreac_back ) );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_back", 0 );
            wait( getanimlength( %iw9_mp_decoymine_swim_hitreac_back ) );
            break;
        default:
            break;
    }
}

_id_AFF778CCCE490BAE()
{
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_right", 0 );
            wait( getanimlength( %iw9_mp_decoymine_hitreac_right ) );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_right", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_hitreac_right ) );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_right", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_hitreac_right ) );
            break;
        default:
            break;
    }
}

_id_2FC8C731D6BFD24A()
{
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );

    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_left", 0 );
            wait( getanimlength( %iw9_mp_decoymine_hitreac_left ) );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_left", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_hitreac_left ) );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_left", 0 );
            wait( getanimlength( %iw9_mp_decoymine_swim_hitreac_left ) );
            break;
        default:
            break;
    }
}

_id_1C5E39BEB07F8BB3()
{
    self endon( "deployedDecoy_animateHitReact" );
    self endon( "deployedDecoy_resumeIdleAnimation_cancel" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 2;

    if ( !isdefined( self ) )
        return 0;

    if ( istrue( self._id_3FE87ED1237724CC ) )
        return 0;

    self setscriptablepartstate( "idle", "neutral", 0 );
    waitframe();

    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_idle", 0 );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_crouch_idle", 0 );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_swim_idle", 0 );
            break;
        default:
            break;
    }
}

_id_69ADB0B10BAE1BE4( data )
{
    if ( !isdefined( self.owner ) )
        return 0;

    if ( self.owner == data.attacker )
        return 0;

    return !scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, data.attacker );
}

_id_1E1A5A07121E30F8( data )
{
    _id_7E6D3ACF41D01437 = [ "MOD_GRENADE_SPLASH", "MOD_GRENADE", "MOD_EXPLOSIVE" ];

    if ( _id_69ADB0B10BAE1BE4( data ) )
        return 0;

    if ( scripts\engine\utility::array_contains( _id_7E6D3ACF41D01437, data.meansofdeath ) )
        return 10;

    if ( data.meansofdeath == "MOD_IMPACT" )
        return 2;

    hits = 0;

    if ( data.damage >= 100 )
        return hits + 9;
    else if ( data.damage >= 40 )
        return hits + 4;
    else
        return hits + 2;
}

_id_255BED505249BC85( grenade )
{
    if ( isdefined( self.dummy ) )
        self.dummy thread _id_5D24D48D0B8EB170();

    if ( isdefined( self._id_90A102F2A8A3B75D ) && self._id_90A102F2A8A3B75D != grenade )
        self._id_90A102F2A8A3B75D thread _id_183A7478C53FD2F2();

    self._id_90A102F2A8A3B75D = grenade;
    grenade._id_2FD40475457DFFDF = grenade.owner.angles;
    grenade._id_1AE0630643036981 = 0;
    grenade.issuper = 1;
    thread scripts\mp\weapons::monitordisownedgrenade( self, grenade );
    grenade thread _id_02482348A6042306();
    grenade waittill( "missile_stuck", stuckto );
    grenade.angles = grenade._id_2FD40475457DFFDF;
    grenade._id_2FD40475457DFFDF = undefined;
    grenade _id_85364189C6F041D7();
    grenade thread _id_D030DD50CE502CE4();
}

_id_85364189C6F041D7()
{
    self endon( "death" );
    forward = anglestoforward( self.angles );
    up = anglestoup( self.angles );
    self._id_21B8BE41B5B72905 = [];
    ignorelist = [];
    ignorelist[0] = self;

    for ( _id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 8; _id_AC0E594AC96AA3A8++ )
    {
        _id_D90439D9C610BE2A = 0 + 45 * _id_AC0E594AC96AA3A8;
        _id_CB89120314447D62 = rotatepointaroundvector( up, forward, _id_D90439D9C610BE2A );
        _id_CB89120314447D62 = vectornormalize( _id_CB89120314447D62 ) * 28;
        _id_CB89120314447D62 = self.origin + _id_CB89120314447D62;
        _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace( self.origin, _id_CB89120314447D62, ignorelist, undefined, 0, 1, 0 );
        _id_0193CBB3CC7CCCDF = isdefined( _id_E021C2744CC7ED68 ) && _id_E021C2744CC7ED68.size > 0 && _id_E021C2744CC7ED68["hittype"] != "hittype_none";

        if ( _id_0193CBB3CC7CCCDF )
        {
            _id_92890A1F9C92F102 = _id_E021C2744CC7ED68["position"] - _id_CB89120314447D62;
            _id_92890A1F9C92F102 = _id_92890A1F9C92F102 * 2;
            _id_92890A1F9C92F102 = self.origin + _id_92890A1F9C92F102;
            self._id_21B8BE41B5B72905[self._id_21B8BE41B5B72905.size] = _id_92890A1F9C92F102;
        }

        waitframe();
    }

    self._id_94981AF7E247F403 = undefined;

    if ( isdefined( self._id_21B8BE41B5B72905 ) && self._id_21B8BE41B5B72905.size > 0 )
        self._id_94981AF7E247F403 = averagepoint( self._id_21B8BE41B5B72905 );
}

_id_02482348A6042306()
{
    self endon( "explode" );
    self endon( "death" );
    self endon( "missile_stuck" );
    self waittill( "missile_water_impact", _id_850FDF3FB1C7EB84, _id_53F81081D4E7F40B, _id_71C76F81EB0C95EE );

    if ( isdefined( _id_53F81081D4E7F40B ) )
    {
        self._id_87DF5E3D4BE5E294 = _id_53F81081D4E7F40B;
        self._id_D2F74CAC2EF25448 = self.owner _meth_6F55D55CCFF20D14();
    }
}

_id_D030DD50CE502CE4()
{
    self.owner endon( "disconnect" );
    self endon( "death" );
    scripts\cp_mp\ent_manager::registerspawn( 1, ::_id_0EC4ED8B35F49093 );
    thread scripts\mp\weapons::makeexplosiveusabletag( "tag_use", 1 );
    self.owner scripts\mp\weapons::onequipmentplanted( self, "equip_deployed_decoy", ::_id_0EC4ED8B35F49093 );
    thread scripts\mp\weapons::monitordisownedequipment( self.owner, self );
    _id_536A359E6FA67DF2();
    self setentityowner( self.owner );
    self setotherent( self.owner );
    self setnodeploy( 1 );
    self missilethermal();
    self missileoutline();
    self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 5, undefined, undefined, undefined, 0.1, 1 );
    thread scripts\mp\weapons::minedamagemonitor();
    thread _id_9B581BB90DFE8E0F();
    scripts\cp_mp\emp_debuff::set_apply_emp_callback( ::_id_3BF15B6532C44F8D );
    _id_736DEC95A49487A6::_id_172D848D58051FDF( ::_id_A6D1FD8A98751A36 );
    _id_FC9EAF4F16837717();
    self setscriptablepartstate( "plant", "active", 0 );
    self.owner thread _id_26408BD5A0A9179C();
    wait 0.5;
    thread _id_8BF9FB0F704ECEB0();
}

_id_536A359E6FA67DF2()
{
    if ( isdefined( self._id_87DF5E3D4BE5E294 ) )
    {
        _id_9BB71E2186BDAC1F = self.origin + ( 0, 0, 2000 );
        ignorelist = _id_3AD49688E4D76BF0();
        contents = scripts\engine\trace::_id_B88B8BD51EA7FE24();
        _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace( self.origin, _id_9BB71E2186BDAC1F, ignorelist, contents, 0, 1, 0 );

        if ( isdefined( _id_E021C2744CC7ED68 ) )
            self._id_FFE647A3E2FC6A87 = distance( self.origin, _id_E021C2744CC7ED68["position"] );
        else
            self._id_FFE647A3E2FC6A87 = undefined;
    }

    return self._id_FFE647A3E2FC6A87;
}

_id_8BF9FB0F704ECEB0()
{
    self endon( "mine_triggered" );
    self endon( "mine_destroyed" );
    self endon( "death" );
    _id_A7C5AFF6BE6DCE49 = 0;

    while ( !_id_A7C5AFF6BE6DCE49 )
    {
        self waittill( "trigger_grenade", _id_F9B008542CD70A05 );

        if ( istrue( self.stunned ) )
            continue;

        foreach ( ent in _id_F9B008542CD70A05 )
        {
            if ( !_id_B49D2E0ECA61DB98( ent ) )
                continue;

            _id_05FA9E8666A1B8DA( ent );

            if ( self._id_820C08BC4A68289F._id_2B7FCECFEF6352B4 )
            {
                thread _id_81D957F621CB0552( ent );
                _id_A7C5AFF6BE6DCE49 = 1;
                break;
            }
        }
    }
}

_id_B49D2E0ECA61DB98( ent )
{
    if ( ent == self.owner )
        return 0;

    if ( !isdefined( ent.team ) || ent.team == self.team )
        return 0;

    if ( !isdefined( ent.classname ) )
        return 0;

    if ( !isplayer( ent ) && !isagent( ent ) )
        return 0;

    return 1;
}

_id_26408BD5A0A9179C()
{
    self notify( "deployedDecoy_watchForDetonate" );
    self endon( "deployedDecoy_watchForDetonate" );
    self endon( "mine_destroyed" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "detonate" );

        if ( self getheldoffhand().basename == "deployed_decoy_mp" || self getheldoffhand().basename == "none" && istrue( self.isusingcamera ) )
        {
            _id_8C54DFF0AD6753D4();
            break;
        }
    }
}

_id_8C54DFF0AD6753D4()
{
    if ( isdefined( self._id_90A102F2A8A3B75D ) )
        self._id_90A102F2A8A3B75D _id_A5577C168F2CD487();
}

_id_6438A3C103F573EE( ent )
{
    _id_AD283A45677A1EA3 = ent gettagorigin( "j_mainroot" );
    _id_44060504F23C16AF = [ _id_AD283A45677A1EA3 ];
    _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent gettagorigin( "j_spineupper" );
    _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent.origin;
    return _id_44060504F23C16AF;
}

_id_05FA9E8666A1B8DA( ent )
{
    self._id_820C08BC4A68289F = undefined;
    _id_820C08BC4A68289F = undefined;
    _id_44060504F23C16AF = _id_6438A3C103F573EE( ent );

    foreach ( _id_A00164B06F60F5E6 in _id_44060504F23C16AF )
    {
        _id_820C08BC4A68289F = spawnstruct();
        _id_820C08BC4A68289F.targetpos = _id_A00164B06F60F5E6;
        _id_820C08BC4A68289F._id_F2A216076F977490 = 0;
        _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC = 0;
        _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = 0;
        _id_820C08BC4A68289F._id_E9B7D63908996C9E = 0;
        _id_820C08BC4A68289F._id_3045266DFC71B133 = 0;
        _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = 0;
        _id_820C08BC4A68289F._id_F2A216076F977490 = _id_1F54BEB17865D9C2( _id_A00164B06F60F5E6 );
        _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC = _id_284789987BABCE6E( _id_A00164B06F60F5E6 );
        _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = _id_5992CD0B16E52700( _id_A00164B06F60F5E6, 58 );
        _id_820C08BC4A68289F._id_E9B7D63908996C9E = _id_5992CD0B16E52700( _id_A00164B06F60F5E6, 40 );

        if ( isdefined( self._id_FFE647A3E2FC6A87 ) && istrue( self._id_FFE647A3E2FC6A87 >= 72 ) )
            _id_820C08BC4A68289F._id_3045266DFC71B133 = _id_5992CD0B16E52700( _id_A00164B06F60F5E6, self._id_FFE647A3E2FC6A87 );

        if ( isdefined( self._id_87DF5E3D4BE5E294 ) )
            _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC && ( _id_820C08BC4A68289F._id_3045266DFC71B133 || _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 );
        else
            _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = _id_820C08BC4A68289F._id_F2A216076F977490 && _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC && ( _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 || _id_820C08BC4A68289F._id_E9B7D63908996C9E );

        if ( _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 )
            break;
    }

    self._id_820C08BC4A68289F = _id_820C08BC4A68289F;
    return self._id_820C08BC4A68289F;
}

_id_5992CD0B16E52700( _id_A00164B06F60F5E6, _id_AA95611290376282 )
{
    ignorelist = _id_3AD49688E4D76BF0();
    contents = _id_BA2606CFB4C66281();
    _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace( self.origin + ( 0, 0, _id_AA95611290376282 ), _id_A00164B06F60F5E6, ignorelist, contents, 0, 1, 0 );
    _id_0193CBB3CC7CCCDF = isdefined( _id_E021C2744CC7ED68 ) && _id_E021C2744CC7ED68.size > 0 && _id_E021C2744CC7ED68["hittype"] == "hittype_entity";
    return _id_0193CBB3CC7CCCDF;
}

_id_74514723C815EECA( _id_47293B1E94FF8FB0 )
{
    if ( !isdefined( _id_47293B1E94FF8FB0 ) )
        return 0;

    forward = anglestoforward( self.angles );
    _id_1650A941C8770F2F = vectornormalize( _id_47293B1E94FF8FB0 - self.origin );
    _id_3FE3A3DD483D56C9 = vectordot( forward, _id_1650A941C8770F2F );
    return _id_3FE3A3DD483D56C9 > 0.866 && _id_3FE3A3DD483D56C9 > -0.866;
}

_id_284789987BABCE6E( _id_A00164B06F60F5E6 )
{
    _id_27789E85BFA3EA1F = abs( self.origin[2] - _id_A00164B06F60F5E6[2] );
    return 384 >= _id_27789E85BFA3EA1F;
}

_id_1F54BEB17865D9C2( _id_A00164B06F60F5E6 )
{
    return 350 >= distance2d( _id_A00164B06F60F5E6, self.origin );
}

_id_81D957F621CB0552( attacker, ent )
{
    if ( isdefined( attacker ) )
        attacker endon( "death_or_disconnect" );
    else
        attacker = self.owner;

    scripts\mp\utility\print::printgameaction( "Decoy triggered", self.owner );
    scripts\mp\weapons::makeexplosiveunusuabletag();
    self setscriptablepartstate( "trigger", "active", 0 );
    thread _id_A5577C168F2CD487( attacker );
    self notify( "mine_triggered" );
}

_id_9B581BB90DFE8E0F()
{
    self endon( "death" );
    level endon( "game_ended" );
    owner = self.owner;
    self waittill( "detonateExplosive", attacker );
    self.detonatingplayer = attacker;
    thread _id_A5577C168F2CD487( attacker );
}

_id_BA2606CFB4C66281()
{
    contents = scripts\engine\trace::create_contents( 1, 1, 0, 1, 1, 1, 1, 1, 1 );
    return contents;
}

_id_3AD49688E4D76BF0()
{
    ignorelist = _id_E0F66654476DC4F4();
    return ignorelist;
}

_id_E0F66654476DC4F4()
{
    _id_F755FDDCDBF39420 = 1;
    ignorelist = [];

    if ( _id_F755FDDCDBF39420 )
    {
        ignorelist[ignorelist.size] = self.owner;
        linkedents = self getlinkedchildren( 1 );

        if ( !isdefined( linkedents ) )
            linkedents = [];

        linkedents[linkedents.size] = self getlinkedparent();

        foreach ( linkedent in linkedents )
        {
            if ( isdefined( linkedent ) && linkedent.classname == "grenade" )
                ignorelist[ignorelist.size] = linkedent;
        }
    }

    if ( isdefined( level.dynamicladders ) )
    {
        foreach ( struct in level.dynamicladders )
            ignorelist[ignorelist.size] = struct.ents[0];
    }

    return ignorelist;
}

_id_3BF15B6532C44F8D( data )
{
    scripts\mp\equipment\claymore::claymore_empapplied( data );
}

_id_A6D1FD8A98751A36( data )
{
    _id_A5577C168F2CD487( data.attacker );
}

_id_A5577C168F2CD487( attacker )
{
    level.mines[self getentitynumber()] = undefined;
    scripts\cp_mp\ent_manager::deregisterspawn();
    scripts\mp\weapons::makeexplosiveunusuabletag();

    if ( isdefined( self.useobj ) )
        self.useobj delete();

    self.exploding = 1;
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    _id_A199D96200A367D6 = self.angles;

    if ( isdefined( attacker ) )
    {
        if ( !isdefined( self._id_820C08BC4A68289F ) )
            _id_05FA9E8666A1B8DA( attacker );

        if ( attacker == self.owner )
            _id_A199D96200A367D6 = self.angles;
        else
        {
            _id_A199D96200A367D6 = vectortoangles( attacker.origin - self.origin );
            _id_A199D96200A367D6 = ( 0, _id_A199D96200A367D6[1], 0 );
        }
    }

    self.dummy = _id_8958B19A2ECC8D46();
    self.owner.dummy = self.dummy;
    self.dummy._id_9AADBD8D704D2FAB = self._id_9AADBD8D704D2FAB;
    self.dummy.angles = _id_A199D96200A367D6;
    self setscriptablepartstate( "plant", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
    self setscriptablepartstate( "explode", "active", 0 );
    glassradiusdamage( self.origin, 84, 75, 25 );

    if ( isdefined( self.dummy ) )
    {
        self.dummy thread _id_2AE474EB2C763DCA( self._id_9AADBD8D704D2FAB );
        self.dummy _id_38042B771A7DE69D();
        pinglocationenemyteams( self.dummy.origin, self.team, self.owner );
    }

    _id_183A7478C53FD2F2();
}

_id_FC9EAF4F16837717()
{
    if ( istrue( level.dangerzoneskipequipment ) )
        return;

    if ( isdefined( self.dangerzone ) )
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );

    self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone( self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1 );
}

_id_A6856182B82CBC63( _id_629E073572854F50, _id_A50D4AC45EC0F007 )
{
    if ( !isdefined( _id_A50D4AC45EC0F007 ) )
        spawnpos = scripts\engine\utility::ter_op( isdefined( self._id_94981AF7E247F403 ), self._id_94981AF7E247F403, self.origin );
    else
        spawnpos = scripts\engine\utility::ter_op( isdefined( self._id_94981AF7E247F403 ), self._id_94981AF7E247F403, self.origin ) + _id_A50D4AC45EC0F007;

    model = spawn( "script_model", spawnpos );
    model setmodel( _id_629E073572854F50 );
    model.weapon_name = "deployed_decoy_mp";
    model.team = self.owner.team;
    model.owner = self.owner;
    return model;
}

_id_8958B19A2ECC8D46()
{
    dummy = undefined;

    if ( isdefined( self._id_FFE647A3E2FC6A87 ) && self._id_FFE647A3E2FC6A87 > 40 )
        dummy = _id_120277E9245ABEF8();
    else if ( isdefined( self._id_820C08BC4A68289F ) && istrue( self._id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 && !self._id_820C08BC4A68289F._id_E9B7D63908996C9E ) )
        dummy = _id_65BAB2B826C7C79F();
    else if ( isdefined( self._id_820C08BC4A68289F ) && istrue( !self._id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 && self._id_820C08BC4A68289F._id_E9B7D63908996C9E ) )
        dummy = _id_A9B9F466BD2859C7();
    else
    {
        _id_F4CAE9D2914CC11B = randomint( 2 );

        if ( _id_F4CAE9D2914CC11B > 0 )
            dummy = _id_65BAB2B826C7C79F();
        else
            dummy = _id_A9B9F466BD2859C7();
    }

    dummy _id_9AA20ECDD4292776();
    dummy scripts\cp_mp\ent_manager::registerspawn( 1, ::_id_D3862975BB307EE3 );
    return dummy;
}

_id_65BAB2B826C7C79F()
{
    _id_32255DAB0BC79F68 = _id_A6856182B82CBC63( "offhand_2h_wm_decoy_mine_dummy01_v0_mp" );
    self._id_9AADBD8D704D2FAB = "dummy_standing";
    return _id_32255DAB0BC79F68;
}

_id_A9B9F466BD2859C7()
{
    _id_32255DAB0BC79F68 = _id_A6856182B82CBC63( "offhand_2h_wm_decoy_mine_dummy02_v0_mp" );
    self._id_9AADBD8D704D2FAB = "dummy_crouching";
    return _id_32255DAB0BC79F68;
}

_id_120277E9245ABEF8()
{
    _id_32255DAB0BC79F68 = _id_A6856182B82CBC63( "offhand_2h_wm_decoy_mine_dummy03_v0_mp", ( 0, 0, self._id_FFE647A3E2FC6A87 - 8 ) );
    self._id_9AADBD8D704D2FAB = "dummy_swimming";
    return _id_32255DAB0BC79F68;
}

_id_2AE474EB2C763DCA( _id_F3F6E0AEF7920E0B )
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "endgame" );

    if ( !isdefined( _id_F3F6E0AEF7920E0B ) )
        return 0;

    switch ( _id_F3F6E0AEF7920E0B )
    {
        case "dummy_standing":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_inflate", 0 );
            wait( getanimlength( %iw9_mp_decoymine_inflate ) );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_idle", 0 );
            self setscriptablepartstate( "inflate", "neutral", 0 );
            break;
        case "dummy_crouching":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_crouch_inflate", 0 );
            wait( getanimlength( %iw9_mp_decoymine_crouch_inflate ) );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_crouch_idle", 0 );
            self setscriptablepartstate( "inflate", "neutral", 0 );
            break;
        case "dummy_swimming":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_swim_inflate", 0 );
            wait( getanimlength( %iw9_mp_decoymine_swim_inflate ) );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_swim_idle", 0 );
            self setscriptablepartstate( "inflate", "neutral", 0 );
            break;
        default:
            break;
    }
}

_id_3F3CE37397B66E92( _id_F3F6E0AEF7920E0B, _id_4BA1C61DF5B425CC )
{
    self endon( "death" );

    switch ( _id_F3F6E0AEF7920E0B )
    {
        case "dummy_standing":
            if ( istrue( _id_4BA1C61DF5B425CC ) )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_pop", 0 );
                wait( getanimlength( %iw9_mp_decoymine_pop ) );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_deflate", 0 );
                wait( getanimlength( %iw9_mp_decoymine_deflate ) );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }

            break;
        case "dummy_crouching":
            if ( istrue( _id_4BA1C61DF5B425CC ) )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_crouch_pop", 0 );
                wait( getanimlength( %iw9_mp_decoymine_crouch_pop ) );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_crouch_deflate", 0 );
                wait( getanimlength( %iw9_mp_decoymine_crouch_deflate ) );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }

            break;
        case "dummy_swimming":
            if ( istrue( _id_4BA1C61DF5B425CC ) )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_swim_pop", 0 );
                wait( getanimlength( %iw9_mp_decoymine_swim_pop ) );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_swim_deflate", 0 );
                wait( getanimlength( %iw9_mp_decoymine_swim_deflate ) );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }

            break;
        default:
            break;
    }
}

_id_38042B771A7DE69D()
{
    switch ( self._id_9AADBD8D704D2FAB )
    {
        case "dummy_standing":
            self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 75, undefined, undefined, undefined, 0.1, 1 );
            break;
        case "dummy_crouching":
            self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 52, undefined, undefined, undefined, 0.1, 1 );
            break;
        case "dummy_swimming":
            self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 35, undefined, undefined, undefined, 0.1, 1 );
            break;
        default:
            break;
    }
}

_id_91B48467F9DA9F0E()
{
    _id_913576E1DC1762B5 = getentitylessscriptablearray( undefined, undefined, self.origin, 50 );

    foreach ( _id_1109E0CCF82E9964 in _id_913576E1DC1762B5 )
    {
        if ( _id_1109E0CCF82E9964 scriptableisdoor() )
            self._id_44736CEE8AFAD49B[self._id_44736CEE8AFAD49B.size] = _id_1109E0CCF82E9964;
    }
}

_id_183A7478C53FD2F2()
{
    self endon( "disconnect" );
    level endon( "endgame" );
    self setscriptablepartstate( "destroy", "active", 0 );
    childthread _id_0EC4ED8B35F49093();
}

_id_0EC4ED8B35F49093()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "endgame" );

    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "hack_usable", "off" );

        if ( isdefined( self.owner ) && isdefined( self.owner._id_90A102F2A8A3B75D ) )
        {
            if ( self.owner._id_90A102F2A8A3B75D == self )
                self.owner._id_90A102F2A8A3B75D = undefined;
        }

        scripts\mp\damage::monitordamageend();
        level.mines[self getentitynumber()] = undefined;
        self setcandamage( 0 );
        scripts\mp\weapons::makeexplosiveunusuabletag();
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
        self.exploding = 1;

        if ( isdefined( self.dangerzone ) )
        {
            scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
            self.dangerzone = undefined;
        }

        if ( isdefined( self.dummy ) )
            self.dummy thread _id_13249D21F9C1C453( 30 );

        scripts\cp_mp\ent_manager::deregisterspawn();

        if ( isdefined( self.owner ) )
            self.owner scripts\mp\weapons::removeequip( self );

        waitframe();
        self delete();
    }
}

_id_D3862975BB307EE3()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\mp\damage::monitordamageend();
    scripts\cp_mp\ent_manager::deregisterspawn();
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.owner scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB( "super_deployed_decoy", 0 );
    self delete();
}

_id_5D24D48D0B8EB170( _id_4BA1C61DF5B425CC )
{
    self endon( "death" );
    self._id_3FE87ED1237724CC = 1;
    self notify( "deployedDecoy_resumeIdleAnimation_cancel" );
    self notify( "deployedDecoy_queueDummyDestroy_Interupt" );
    self setscriptablepartstate( "hitreact", "neutral", 0 );
    _id_3F3CE37397B66E92( self._id_9AADBD8D704D2FAB, _id_4BA1C61DF5B425CC );
    waitframe();
    _id_D3862975BB307EE3();
}

_id_13249D21F9C1C453( _id_CBF7BE4F62A0DDB2 )
{
    self endon( "deployedDecoy_queueDummyDestroy_Interupt" );

    if ( !isdefined( _id_CBF7BE4F62A0DDB2 ) )
        _id_CBF7BE4F62A0DDB2 = 0;

    wait( _id_CBF7BE4F62A0DDB2 );
    thread _id_5D24D48D0B8EB170();
}

_id_34669788FDE2926B( objweapon, _id_7004DB721E68783E )
{
    if ( istrue( _id_7004DB721E68783E ) )
        return isdefined( objweapon ) && istrue( objweapon.basename == "deployed_decoy_mp" );

    return isdefined( objweapon ) && istrue( objweapon.basename == "deployed_decoy_mp" );
}

_id_31ABC24CEAA8D163( _id_F357880CC9ACABDA )
{
    if ( !isdefined( _id_F357880CC9ACABDA ) || !isdefined( _id_F357880CC9ACABDA.owner ) )
        return 0;

    self notify( "deployedDecoy_watchScoringThread" );
    self endon( "deployedDecoy_watchScoringThread" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self._id_A4D803F0A1114E87 = _id_F357880CC9ACABDA getentitynumber();
    self._id_B8B8B6B0AF551E03 = _id_F357880CC9ACABDA.owner;
    scripts\engine\utility::waittill_any_timeout_1( 10, "decoyDummyEndScoring" );
    self._id_A4D803F0A1114E87 = undefined;
    self._id_B8B8B6B0AF551E03 = undefined;
}

_id_3972A29B456EBEEC( data )
{
    if ( data.attacker != self.owner )
    {
        if ( !data.attacker _id_A26953A3E8E58A3F( self ) )
            self.owner childthread scripts\mp\utility\points::_id_0366980B6A8796AE( "stat_218B72EF391E7F09", undefined, 25 );

        data.attacker childthread _id_31ABC24CEAA8D163( self );
    }
}

_id_A22D831B624CCCD2()
{
    level endon( "game_ended" );

    if ( _id_A26953A3E8E58A3F() )
    {
        self._id_B8B8B6B0AF551E03 childthread scripts\mp\utility\points::_id_0366980B6A8796AE( "stat_63DDB3737FCC850D", undefined, 25 );
        self notify( "decoyDummyEndScoring" );
    }
}

_id_A26953A3E8E58A3F( _id_734C4B4E112907B2 )
{
    if ( isdefined( _id_734C4B4E112907B2 ) )
        return isdefined( self._id_A4D803F0A1114E87 ) && isdefined( self._id_B8B8B6B0AF551E03 ) && istrue( _id_734C4B4E112907B2 getentitynumber() == self._id_A4D803F0A1114E87 );
    else
        return isdefined( self._id_A4D803F0A1114E87 ) && isdefined( self._id_B8B8B6B0AF551E03 );
}
