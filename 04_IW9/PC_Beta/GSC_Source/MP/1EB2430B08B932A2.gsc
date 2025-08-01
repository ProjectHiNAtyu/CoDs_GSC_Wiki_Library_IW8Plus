// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_B2502F3345564ABF()
{
    if ( istrue( level._id_7B37B2193F163B9B._id_B871280CBDC11CAF ) )
        return 0;

    if ( _id_1E4A61DB11011446::_id_72CE5F47DA0F5661() )
        return 0;

    return !_id_6F6C5CB39CD095B0();
}

_id_6F6C5CB39CD095B0()
{
    if ( !scripts\mp\utility\game::matchmakinggame() && getdvarint( "dvar_D356A7876F773136", 0 ) )
        return 0;

    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata( self.team, "players" );

    foreach ( player in _id_6D5ED003AF1F9612 )
    {
        if ( !isai( player ) )
            return 1;
    }

    return 0;
}

_id_0D3638CF9A2DA76A( _id_401C3A2E68AAB0FD )
{
    if ( !_id_B2502F3345564ABF() )
        return 0;

    if ( !isdefined( _id_401C3A2E68AAB0FD ) )
        _id_401C3A2E68AAB0FD = "unknown reason";

    self._id_B4ADDE4C68BB0F24._id_C2AD339C4E95C7FE = strtok( _id_401C3A2E68AAB0FD, " " )[0];
    thread _id_B20F2224A6FA748E();
    return 1;
}

_id_B20F2224A6FA748E()
{
    deactivate();
}

deactivate()
{
    if ( _id_23DDC5A3E0D509D3::_id_D012729EAC1E7053() )
        level._id_7B37B2193F163B9B._id_892FA74A6B549EF0 = scripts\engine\utility::array_remove( level._id_7B37B2193F163B9B._id_892FA74A6B549EF0, self );

    _id_40E63DD222434655::_id_2C2B5B435027F895( undefined );
    _id_89A675C5BDE8848F = spawnstruct();
    _id_89A675C5BDE8848F._id_B4ADDE4C68BB0F24 = 1;
    _id_89A675C5BDE8848F.name = self.name;
    _id_89A675C5BDE8848F.team = self.team;
    _id_89A675C5BDE8848F.gulaguses = self.gulaguses;
    _id_89A675C5BDE8848F.operatorcustomization = self.operatorcustomization;
    _id_89A675C5BDE8848F.difficulty = self botgetdifficulty();
    _id_89A675C5BDE8848F._id_E2055BF088954E86 = self._id_E2055BF088954E86;
    _id_89A675C5BDE8848F.locked = 0;
    _id_89A675C5BDE8848F.plundercount = self.plundercount;
    _id_89A675C5BDE8848F._id_87439F119EAA14E3 = self._id_87439F119EAA14E3;
    _id_89A675C5BDE8848F.pers = [];
    _id_89A675C5BDE8848F.pers["kills"] = self.pers["kills"];
    _id_89A675C5BDE8848F.pers["deaths"] = self.pers["deaths"];
    _id_89A675C5BDE8848F.pers["shotsFired"] = self.pers["shotsFired"];
    _id_89A675C5BDE8848F.pers["shotsHit"] = self.pers["shotsHit"];
    level._id_7B37B2193F163B9B._id_156F390A5362BC55[level._id_7B37B2193F163B9B._id_156F390A5362BC55.size] = _id_89A675C5BDE8848F;
    self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 1;
    _id_40E63DD222434655::kickplayer( 1 );
    level notify( "ui_bot_counter_updated" );
}

_id_E81D83CFE1AB45FC( count, _id_A4273E17F90BFBE6 )
{
    for ( _id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++ )
    {
        _id_89A675C5BDE8848F = _id_32EC26AB4915F882();

        if ( !isdefined( _id_89A675C5BDE8848F ) )
            break;

        _id_89A675C5BDE8848F _id_7CAE93055DAE77EC( _id_A4273E17F90BFBE6, "ActivateSome" );
    }
}

_id_7CAE93055DAE77EC( _id_A4273E17F90BFBE6, _id_401C3A2E68AAB0FD )
{
    level endon( "game_ended" );
    self.locked = 1;
    bots = _id_4A0D1F5F6BE0F8C7::_id_7D92B857142DBDC6( [ self ], self.team, ::_id_9570B978F27641EF, undefined, "spawned_bots" );

    if ( !isdefined( bots[0] ) )
    {
        self.locked = 0;
        return undefined;
    }

    bot = bots[0];

    if ( !istrue( bot._id_0DEB55E4A0429EF1 ) )
    {
        bot scripts\engine\utility::waittill_any_return_2( "bot_br_super_think", "death_or_disconnect" );

        if ( !isalive( bot ) )
            return undefined;
    }

    bot _id_40E63DD222434655::_id_142B713A2846F9AC( "Activated - UI Bot" );
    bot _id_40E63DD222434655::_id_1E8FE34F5DFDEA49( _id_A4273E17F90BFBE6 );
    bot _id_4A0D1F5F6BE0F8C7::_id_7D256D3586241325( _id_401C3A2E68AAB0FD );
    bot playershow();
    level notify( "ui_bot_counter_updated" );
    return bot;
}

_id_C827480E6D21A271()
{
    if ( isdefined( self._id_89A675C5BDE8848F ) && istrue( self._id_89A675C5BDE8848F._id_B4ADDE4C68BB0F24 ) )
    {
        self.gulaguses = self._id_89A675C5BDE8848F.gulaguses;

        if ( istrue( level.br_c130spawndone ) )
            self.jumped = 1;

        self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 0;
        self.plundercount = self._id_89A675C5BDE8848F.plundercount;
        self.pers["kills"] = self._id_89A675C5BDE8848F.pers["kills"];
        self.pers["deaths"] = self._id_89A675C5BDE8848F.pers["deaths"];
        self.pers["shotsFired"] = self._id_89A675C5BDE8848F.pers["shotsFired"];
        self.pers["shotsHit"] = self._id_89A675C5BDE8848F.pers["shotsHit"];
        level._id_7B37B2193F163B9B._id_156F390A5362BC55 = scripts\engine\utility::array_remove( level._id_7B37B2193F163B9B._id_156F390A5362BC55, self._id_89A675C5BDE8848F );
        level notify( "ui_bot_counter_updated" );
        self._id_89A675C5BDE8848F.locked = 0;
    }
}

_id_83574001589FB42D()
{
    if ( isdefined( self._id_89A675C5BDE8848F ) && istrue( self._id_89A675C5BDE8848F._id_B4ADDE4C68BB0F24 ) )
    {
        self.operatorcustomization = self._id_89A675C5BDE8848F.operatorcustomization;
        scripts\mp\teams::setmodelfromcustomization();
        self._id_89A675C5BDE8848F = undefined;
        logstring( "[Super Bots] Bot late recovered from uiBot:" + self.name );
    }
}

_id_9570B978F27641EF()
{
    self._id_B4ADDE4C68BB0F24 = spawnstruct();
    self._id_B4ADDE4C68BB0F24._id_7DBB8165D792B06C = 1;

    if ( isdefined( level._id_7B37B2193F163B9B._id_9F4A3632D9F75D32 ) )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = level._id_7B37B2193F163B9B._id_9F4A3632D9F75D32;
        spawnpoint.angles = ( 0, 0, 0 );
        spawnpoint.index = -1;
        self.prespawnspawn = spawnpoint;
    }
}

_id_966AB6FFD873EC11( count, _id_DCFAC6660215F3BE )
{
    if ( count <= 0 )
        return;

    for ( _id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++ )
    {
        _id_89A675C5BDE8848F = _id_32EC26AB4915F882();

        if ( !isdefined( _id_89A675C5BDE8848F ) )
            break;

        _id_629C48F843740B97 = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC( "Combat", "KillSome" );

        if ( isdefined( _id_629C48F843740B97 ) )
        {
            if ( istrue( _id_DCFAC6660215F3BE ) )
            {
                _id_629C48F843740B97.gulaguses = undefined;
                _id_629C48F843740B97._id_82BD86E99F1DD1E4 = 1;
            }

            wait 1;

            if ( _id_40E63DD222434655::_id_2CEE00BF93CE58E6( _id_629C48F843740B97 ) )
                _id_629C48F843740B97 suicide();
        }
    }
}

_id_32EC26AB4915F882( _id_6F5C365E73AD85FC )
{
    foreach ( _id_89A675C5BDE8848F in level._id_7B37B2193F163B9B._id_156F390A5362BC55 )
    {
        if ( isdefined( _id_6F5C365E73AD85FC ) && _id_89A675C5BDE8848F.team == _id_6F5C365E73AD85FC )
            continue;

        if ( !_id_89A675C5BDE8848F.locked )
            return _id_89A675C5BDE8848F;
    }

    return undefined;
}

_id_947B37D99674B59C()
{
    level endon( "game_ended" );
    _id_81A80043D8CE8EEF = 3000;
    _id_6B7BEE46F2C6DA28 = gettime();

    if ( isdefined( self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D ) && _id_6B7BEE46F2C6DA28 - self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D < _id_81A80043D8CE8EEF )
        return;

    self._id_44F4FB2FDD683FFA._id_446D5C9F0F95831D = _id_6B7BEE46F2C6DA28;
    radius = getdvarint( "dvar_358164E65D640280", 390 );
    radius = max( radius, 390 );
    _id_89A675C5BDE8848F = _id_32EC26AB4915F882( self.team );

    if ( !isdefined( _id_89A675C5BDE8848F ) )
        return;

    _id_17F9769ECC54CD5A = randomint( 2 );
    _id_E2270F384295FABA = _id_17F9769ECC54CD5A == 0 || _id_1E4A61DB11011446::_id_72CE5F47DA0F5661();

    if ( _id_E2270F384295FABA )
        bot = _id_063BDF181A81CBD9( _id_89A675C5BDE8848F, self.origin, self.angles, radius, self.name );
    else
        bot = _id_FFBE03EA2562F5AC( _id_89A675C5BDE8848F, self.origin, self.angles, radius, self.name );

    if ( isdefined( bot ) )
    {
        if ( !bot._id_AB5F5270CB22E3C8 && _id_E2270F384295FABA )
            bot thread _id_40E63DD222434655::_id_916E2512538553DB();

        if ( !_id_E2270F384295FABA )
            bot._id_6601CCD8EC4B0356 = self;

        bot switchtoweapon( bot.primaryweapons[0] );

        if ( isdefined( self ) )
            self._id_44F4FB2FDD683FFA._id_F315B15BF1BD4B5E = gettime();
    }
}

_id_38B0BF785F0D3321( type, origin, bot, name )
{
    _id_D5BB04F234D19728 = distance( origin, bot.origin );
    _id_2A740F1203C3EF99 = bot;

    foreach ( player in level.players )
    {
        if ( _id_40E63DD222434655::_id_40034C2FAF09A87B( player ) )
        {
            _id_DF8E0358F6E2B842 = distance( player.origin, bot.origin );

            if ( _id_DF8E0358F6E2B842 < _id_D5BB04F234D19728 )
            {
                _id_D5BB04F234D19728 = _id_DF8E0358F6E2B842;
                _id_2A740F1203C3EF99 = player;
            }
        }
    }

    logstring( "[Super Bots] Deploy Bot in " + type + " bot:" + bot.name + " (" + bot.origin[0] + ", " + bot.origin[1] + ", " + bot.origin[2] + ") player:" + name + " (" + origin[0] + ", " + origin[1] + ", " + origin[2] + ")" + " distToPlayer:" + distance( origin, bot.origin ) + " minDistPlayer:" + _id_2A740F1203C3EF99.name + " (" + _id_2A740F1203C3EF99.origin[0] + ", " + _id_2A740F1203C3EF99.origin[1] + ", " + _id_2A740F1203C3EF99.origin[2] + ")" + " minDistToPlayer:" + _id_D5BB04F234D19728 );
}

_id_063BDF181A81CBD9( _id_89A675C5BDE8848F, origin, angles, radius, name )
{
    level endon( "game_ended" );
    bot = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC( "Combat", "DeployOneBotOnGround" );

    if ( !_id_40E63DD222434655::isvalidplayer( bot ) )
        return undefined;

    bot._id_B4ADDE4C68BB0F24._id_6ECC7CD453466014 = 1;
    bot playerhide();
    bot botsetflag( "suspended", 1 );
    _id_F1F1BC7727CA599B = undefined;
    _id_724926DBAC2BB2FB = 10;
    _id_6D39356E6E1F0FC1 = 0;
    _id_99E8FCB28E160694 = [];

    foreach ( player in level.players )
    {
        if ( _id_40E63DD222434655::_id_40034C2FAF09A87B( player ) )
            _id_99E8FCB28E160694[_id_99E8FCB28E160694.size] = player;
    }

    while ( !isdefined( _id_F1F1BC7727CA599B ) && _id_6D39356E6E1F0FC1 < _id_724926DBAC2BB2FB )
    {
        waitframe();

        if ( _id_5D2AAE3A7D90DF56() >= getdvarint( "dvar_789BFEB36C8E00FD", 999 ) )
            break;

        circleradius = _id_2695A20D4011076D::getdangercircleradius();

        if ( circleradius > 0 )
        {
            circleorigin = _id_2695A20D4011076D::getdangercircleorigin();
            _id_5BC945B12CD2C2C6 = distance2d( circleorigin, origin );

            if ( _id_5BC945B12CD2C2C6 > radius + circleradius )
            {
                logstring( "[Super Bots] Warning: no valid bot deploy position found for player, the player is faraway from the circle" );
                break;
            }
        }

        _id_6D39356E6E1F0FC1++;
        _id_25854DB1807F021A = _id_F24F661DC7782EBC( origin, _id_99E8FCB28E160694, radius );

        if ( isdefined( _id_25854DB1807F021A ) )
        {
            bot setorigin( _id_25854DB1807F021A, 1 );

            if ( !bot _id_40E63DD222434655::_id_B74CF5EB822312CB() )
                _id_F1F1BC7727CA599B = _id_25854DB1807F021A;
        }
    }

    bot._id_B4ADDE4C68BB0F24._id_6ECC7CD453466014 = 0;

    if ( isdefined( _id_F1F1BC7727CA599B ) )
    {
        bot botsetflag( "suspended", 0 );
        bot setorigin( _id_F1F1BC7727CA599B, 1 );
        bot playershow();

        if ( getdvarint( "dvar_429176496A1B2FD8", 0 ) )
            _id_38B0BF785F0D3321( "ground", origin, bot, name );

        return bot;
    }

    if ( _id_6D39356E6E1F0FC1 == _id_724926DBAC2BB2FB )
        logstring( "[Super Bots] Warning: no valid bot deploy position found for player origin " + origin );

    if ( !bot _id_0D3638CF9A2DA76A( "deployment fails" ) )
        bot _id_40E63DD222434655::kickplayer();

    return undefined;
}

_id_5D2AAE3A7D90DF56()
{
    _id_4F304A8F807B9777 = 0;

    foreach ( player in level.players )
    {
        if ( isbot( player ) && !player _id_40E63DD222434655::_id_A9CBF557DC66D201() && !player _id_23DDC5A3E0D509D3::_id_6ECC7CD453466014() )
            _id_4F304A8F807B9777++;
    }

    return _id_4F304A8F807B9777;
}

_id_F24F661DC7782EBC( origin, _id_99E8FCB28E160694, radius )
{
    _id_25854DB1807F021A = _id_2695A20D4011076D::getrandompointincircle( origin, radius, 0.8, 1.0, 1, 0 );

    if ( !_id_2695A20D4011076D::ispointincurrentsafecircle( _id_25854DB1807F021A ) )
        return undefined;

    _id_2BC127F950AD927C = radius * 0.8;

    foreach ( player in _id_99E8FCB28E160694 )
    {
        if ( _id_40E63DD222434655::_id_40034C2FAF09A87B( player ) && scripts\engine\utility::ispointinsidecircle( player.origin, _id_25854DB1807F021A, _id_2BC127F950AD927C ) )
            return undefined;
    }

    return _id_25854DB1807F021A;
}

_id_FFBE03EA2562F5AC( _id_89A675C5BDE8848F, origin, angles, radius, name )
{
    spawnorigin = _id_67708F418B1FAC79::getsafeoriginaroundpoint( origin, radius );

    if ( isdefined( spawnorigin ) )
    {
        bot = _id_89A675C5BDE8848F _id_7CAE93055DAE77EC( "Skydive", "DeployOneBotInAir" );

        if ( !_id_40E63DD222434655::isvalidplayer( bot ) )
            return undefined;

        spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace( spawnorigin );
        spawnangles = _id_67708F418B1FAC79::getanglesfacingorigin( spawnorigin, origin );
        height = scripts\cp_mp\parachute::getc130height();

        if ( isdefined( level.br_circle ) )
        {
            circleindex = level.br_circle.circleindex;
            _id_AE439BDE76B3E937 = _id_67708F418B1FAC79::getgulagclosedcircleindex();
            _id_F0B695BB4C38471B = isdefined( circleindex ) && circleindex >= _id_AE439BDE76B3E937;

            if ( _id_F0B695BB4C38471B )
                height = height * getdvarfloat( "dvar_A1C2D6B19BB6A568", 0.55 );
        }

        if ( isdefined( level.respawnheightoverride ) )
            height = level.respawnheightoverride;

        _id_A6427A6A24F058DC = ( 0, 0, height );
        spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin( spawnorigin, _id_A6427A6A24F058DC );
        bot setorigin( spawnorigin );
        bot setplayerangles( spawnangles );
        _id_BDA1DE83E1856735 = 0;

        if ( isdefined( level.parachutedeploydelay ) )
            _id_BDA1DE83E1856735 = level.parachutedeploydelay;

        _id_CB4FAD49263E20C4 = bot _id_6AFF3948CF4CCA03::_id_79275E2FAB13F54D();
        bot.plundercount = _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5;
        bot thread scripts\cp_mp\parachute::startfreefall( _id_BDA1DE83E1856735, 0, undefined, undefined, 1 );

        if ( getdvarint( "dvar_429176496A1B2FD8", 0 ) )
            _id_38B0BF785F0D3321( "air", origin, bot, name );

        return bot;
    }

    return undefined;
}
