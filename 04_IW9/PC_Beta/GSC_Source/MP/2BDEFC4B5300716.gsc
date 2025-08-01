// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_FB7271D5EE18B98D( data )
{
    level._id_7E12F6EB4FCB4EA1 = spawnstruct();
    level._id_7E12F6EB4FCB4EA1.time = getdvarint( "dvar_364DCA8E32D958FA", 180 );
    level._id_7E12F6EB4FCB4EA1._id_987F2ECCF1688B21 = getdvarint( "dvar_7959DF486CBCDFD1", 5000 );
    level._id_7E12F6EB4FCB4EA1._id_877E83278A9F2EAC = getdvarint( "dvar_C7054640761BE2EF", 30000 );
    level._id_7E12F6EB4FCB4EA1._id_8718AEB5B6F8EB16 = getdvarint( "dvar_34D149DFDDECFA91", 5000 );
    level._id_7E12F6EB4FCB4EA1._id_FDDF856CA727F674 = getdvarint( "dvar_4CAF4C58C978D604", 100000 );
    level._id_7E12F6EB4FCB4EA1._id_2A708F42DF785976 = getdvarint( "dvar_50295A3311CE37EE", 100 );
    level._id_7E12F6EB4FCB4EA1._id_2A938142DF9E8264 = getdvarint( "dvar_50064C3311A7D16C", 1000 );
    level._id_7E12F6EB4FCB4EA1._id_3BD4A66A02968ECC = getdvarint( "dvar_025BA69E846763B6", 1500 );
    level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6 = getdvarint( "dvar_DD2F37F5EC580F08", 2000 );
    level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794 = getdvarint( "dvar_FADEC1D4ADEB8AC2", 3500 );
    level._id_7E12F6EB4FCB4EA1._id_65DD392CAFAB8111 = getdvarint( "dvar_5B3F6111A22668CD", 2500 );
    level._id_7E12F6EB4FCB4EA1._id_A12A720226632B47 = getdvarint( "dvar_BEFDE6C410585907", 5000 );
    game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
    game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
    game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
    game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
    game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
    game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
    level._id_AAB4FBA7A041B281 = [];
    data.funcs["onInit"] = ::_id_6E27EE56573D1441;
    data.funcs["onTeamAssigned"] = ::_id_B946C0DB13D4D90E;
}

_id_6E27EE56573D1441()
{
    return 1;
}

_id_B946C0DB13D4D90E()
{
    _id_86A80A97F4672FC8 = !level.br_circle_disabled && istrue( level._id_2DF69B8E552238B6 ) && istrue( level._id_B31733F431ED12E0._id_CE4D234D77082447 );
    self.targetteam = determinetargetteam( self._id_0D154AC2657C5F44, _id_86A80A97F4672FC8 );

    if ( isdefined( self.targetteam ) )
    {
        self.hunterteam = self.teams[0];
        level._id_AAB4FBA7A041B281 = scripts\engine\utility::array_combine( level._id_AAB4FBA7A041B281, scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) );
        determinetargetplayer( self.targetteam, self._id_0D154AC2657C5F44 );

        if ( !isdefined( self.targetplayer ) )
            return;

        scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522( "Assassination_Br" );
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        updateassassinationhud();
        thread _id_6CA0A919D228D381();
        thread _id_7B16AC880855A705();
        time = level._id_7E12F6EB4FCB4EA1.time;
        _id_64ACB6CE534155B7::_id_5A15174D34F0670C( time, 0 );
        thread _id_D1967972E47F382A( time );
        params = spawnstruct();
        params.excludedplayers = [];
        params.excludedplayers[0] = self.targetplayer;

        if ( isdefined( self._id_0D154AC2657C5F44 ) )
            params.excludedplayers[1] = self._id_0D154AC2657C5F44;

        params.stringvar = self.targetplayer.name;
        _id_64ACB6CE534155B7::displayteamsplash( self.targetteam, "br_assassination_quest_start_target_team", params );
        _id_64ACB6CE534155B7::displayplayersplash( self.targetplayer, "br_assassination_quest_start_target_player" );

        if ( !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
            level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam( "mission_ass_hunted", self.targetteam, 1 );

        _id_64ACB6CE534155B7::displayteamsplash( self.hunterteam, "br_assassination_quest_start_hunter_team", params );

        if ( !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
            level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam( "mission_ass_accept", self.hunterteam, 1 );

        if ( isdefined( self._id_0D154AC2657C5F44 ) )
        {
            _id_64ACB6CE534155B7::displayplayersplash( self._id_0D154AC2657C5F44, "br_assassination_quest_start_tablet_finder", params );
            _id_64ACB6CE534155B7::displaysquadmessagetoteam( self.hunterteam, self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex( "assassination" ) );
            return;
        }
    }
    else
    {
        self._id_0D154AC2657C5F44 scripts\mp\utility\lower_message::setlowermessageomnvar( "br_assassination_notargets", undefined, 5 );
        _id_E141356311900568 = spawnstruct();
        _id_E141356311900568.origin = self._id_0D154AC2657C5F44.origin;
        _id_E141356311900568.angles = self._id_0D154AC2657C5F44.angles;
        _id_6B5E1783915835C1 = undefined;
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
        _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems( dropstruct, 0, 1, "health", _id_6B5E1783915835C1 );
        _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems( dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1 );
        _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems( dropstruct, 1, 1, "plunder", _id_6B5E1783915835C1 );
        _id_64ACB6CE534155B7::_id_93663FE58D95F174();
    }
}

_id_AC21667E0F251104( success )
{
    self notify( "task_ended" );
    level._id_AAB4FBA7A041B281 = scripts\engine\utility::array_remove_array( level._id_AAB4FBA7A041B281, scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) );
    wait 1.0;
    removeallaqui();
    _id_64ACB6CE534155B7::_id_93663FE58D95F174( scripts\engine\utility::ter_op( istrue( success ), self.teams[0], undefined ) );
}

_id_7B16AC880855A705()
{
    self endon( "task_ended" );
    level endon( "game_ended" );
    self.targetplayer waittill( "death_or_disconnect" );
    _id_1B4ADA49A21B51CA = undefined;

    if ( isdefined( self.targetplayer.lastkilledby ) && isplayer( self.targetplayer.lastkilledby ) && isdefined( self.targetplayer.lastkilledby.team ) && self.targetplayer.lastkilledby.team == self.teams[0] )
    {
        _id_1B4ADA49A21B51CA = "br_assassination_complete_hunters_win";
        _id_FA69571549E78551 = "assassin_target_killed";
        _id_64ACB6CE534155B7::displaysquadmessagetoteam( self.hunterteam, self.targetplayer.lastkilledby, 8, _id_64ACB6CE534155B7::getquestindex( "assassination" ) );
    }
    else
    {
        _id_1B4ADA49A21B51CA = "br_assassination_complete_target_vanished";
        _id_FA69571549E78551 = "assassin_target_vanished";
    }

    params = spawnstruct();
    rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF( _id_FA69571549E78551, self.hunterteam );

    if ( isdefined( rewards ) && isdefined( rewards[0] ) )
    {
        params.intvar = int( rewards[0] );
        _id_64ACB6CE534155B7::_id_878EBCC241B54505( _id_1B4ADA49A21B51CA, _id_64ACB6CE534155B7::_id_3D262D56274BD22E( "assassination" ), rewards[0], self.hunterteam );
    }

    if ( getdvarint( "dvar_827F1BF2224B0D61", 0 ) == 1 )
        self._id_0D154AC2657C5F44 _id_64ACB6CE534155B7::_id_496ED653FAACACD2( self.hunterteam );

    if ( !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam( "mission_ass_success", self.hunterteam, 1 );

    thread _id_AC21667E0F251104( 1 );
}

_id_D1967972E47F382A( time )
{
    self endon( "task_ended" );
    level endon( "game_ended" );
    wait( time );
    params = spawnstruct();
    params.intvar = 0;
    _id_64ACB6CE534155B7::displayteamsplash( self.hunterteam, "br_assassination_timer_expire_hunters_lose", params );
    rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF( "assassin_averted", self.targetteam );

    if ( isdefined( rewards ) && isdefined( rewards[0] ) )
    {
        params.intvar = int( rewards[0] );
        _id_64ACB6CE534155B7::_id_878EBCC241B54505( "br_assassination_timer_expire_targets_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E( "assassination" ), rewards[0], self.targetteam );
    }

    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam( "mission_ass_fail", self.hunterteam, 1 );
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam( "mission_ass_hunted_timed_out", self.targetteam, 1 );
    thread _id_AC21667E0F251104( 0 );
}

_id_6CA0A919D228D381()
{
    self endon( "task_ended" );
    level endon( "game_ended" );

    for (;;)
    {
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        updateassassinationthreatlevel( self.targetteam );
        wait 10.0;
    }
}

determinetargetteam( player, _id_86A80A97F4672FC8 )
{
    hunterteam = player.team;
    _id_3B8219D206004DFA = undefined;
    _id_0774C9CA5D1D6221 = 0;
    _id_12729FF62E52ED4D = level.players;
    _id_EA7CD2B67D803BC4 = level._id_AAB4FBA7A041B281;
    _id_EA7CD5B67D80425D = scripts\mp\utility\teams::getteamdata( hunterteam, "players" );
    excludedteams = scripts\engine\utility::array_combine_unique( _id_EA7CD2B67D803BC4, _id_EA7CD5B67D80425D );
    _id_EB362CD8AE206E57 = 0;
    _id_63B9EFF90CD38E5D = level._id_7E12F6EB4FCB4EA1._id_987F2ECCF1688B21;
    _id_877E83278A9F2EAC = level._id_7E12F6EB4FCB4EA1._id_877E83278A9F2EAC;

    while ( !isdefined( _id_3B8219D206004DFA ) )
    {
        _id_EB362CD8AE206E57 = _id_EB362CD8AE206E57 + level._id_7E12F6EB4FCB4EA1._id_8718AEB5B6F8EB16;
        _id_64D072985F0A15A5 = scripts\engine\utility::get_array_of_closest( player.origin, _id_12729FF62E52ED4D, excludedteams, undefined, _id_63B9EFF90CD38E5D + _id_EB362CD8AE206E57, _id_63B9EFF90CD38E5D );
        playerlist = [];

        foreach ( _id_BD73C7ACC56CD20C in _id_64D072985F0A15A5 )
        {
            if ( istrue( _id_86A80A97F4672FC8 ) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418( player.origin, _id_BD73C7ACC56CD20C.origin ) )
                continue;

            if ( !istrue( _id_BD73C7ACC56CD20C.hasbeentracked ) && !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_BD73C7ACC56CD20C ) )
                playerlist[playerlist.size] = _id_BD73C7ACC56CD20C;
        }

        if ( playerlist.size == 0 )
        {
            if ( _id_EB362CD8AE206E57 > _id_877E83278A9F2EAC )
            {
                _id_64D072985F0A15A5 = scripts\engine\utility::get_array_of_closest( player.origin, _id_12729FF62E52ED4D, scripts\mp\utility\teams::getteamdata( hunterteam, "players" ), undefined, undefined, undefined );

                foreach ( _id_BD73C7ACC56CD20C in _id_64D072985F0A15A5 )
                {
                    if ( istrue( _id_86A80A97F4672FC8 ) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418( player.origin, _id_BD73C7ACC56CD20C.origin ) )
                        continue;

                    if ( !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_BD73C7ACC56CD20C ) )
                        playerlist[playerlist.size] = _id_BD73C7ACC56CD20C;
                }

                if ( playerlist.size == 0 )
                    return undefined;
            }
        }

        _id_3A0D4DA4585D5B22 = [];
        _id_90B91D6205FCE07F = 0;
        _id_29F6D200784F77B3 = ( 0, 0, 0 );

        foreach ( _id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata( hunterteam, "players" ) )
        {
            if ( !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_F0EA4030349A33D5 ) )
            {
                _id_90B91D6205FCE07F++;
                _id_29F6D200784F77B3 = _id_29F6D200784F77B3 + _id_F0EA4030349A33D5.origin;
            }
        }

        _id_29F6D200784F77B3 = _id_29F6D200784F77B3 / _id_90B91D6205FCE07F;

        foreach ( _id_BD73C7ACC56CD20C in playerlist )
        {
            _id_B54FEA3B6F15223C = 0;

            foreach ( _id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata( _id_BD73C7ACC56CD20C.team, "players" ) )
            {
                if ( !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_F0EA4030349A33D5 ) )
                    _id_B54FEA3B6F15223C++;
            }

            if ( _id_B54FEA3B6F15223C == 0 )
                continue;

            if ( !isdefined( _id_3B8219D206004DFA ) )
            {
                _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
                _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
                continue;
            }

            if ( getdvar( "dvar_7611A2790A0BF7FE", "" ) == "plunder" || getdvar( "dvar_7611A2790A0BF7FE", "" ) == "risk" )
            {
                _id_E6A3E80614FBD020 = _id_56055017E5E588FE::getteamcarriedplunder( _id_3B8219D206004DFA );
                _id_C237B8FC2586F74F = _id_56055017E5E588FE::getteamcarriedplunder( _id_BD73C7ACC56CD20C.team );

                if ( _id_C237B8FC2586F74F > level._id_7E12F6EB4FCB4EA1._id_FDDF856CA727F674 )
                {
                    if ( _id_C237B8FC2586F74F > _id_E6A3E80614FBD020 )
                    {
                        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
                        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
                        continue;
                    }
                }
            }

            _id_2A83DF6C49112D96 = abs( _id_90B91D6205FCE07F - _id_0774C9CA5D1D6221 );

            if ( _id_2A83DF6C49112D96 < abs( _id_90B91D6205FCE07F - _id_B54FEA3B6F15223C ) )
            {
                _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
                _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
                continue;
            }
            else if ( _id_2A83DF6C49112D96 > abs( _id_90B91D6205FCE07F - _id_B54FEA3B6F15223C ) )
                continue;

            if ( _id_0774C9CA5D1D6221 > _id_B54FEA3B6F15223C )
            {
                _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
                _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
                continue;
            }
            else if ( _id_0774C9CA5D1D6221 < _id_B54FEA3B6F15223C )
                continue;

            _id_0B78E01E4CA8F50A = ( 0, 0, 0 );

            foreach ( _id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata( _id_BD73C7ACC56CD20C.team, "players" ) )
            {
                if ( !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_F0EA4030349A33D5 ) )
                    _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
            }

            _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A / _id_B54FEA3B6F15223C;
            _id_76E3E3800077282F = ( 0, 0, 0 );

            foreach ( _id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata( _id_3B8219D206004DFA, "players" ) )
            {
                if ( !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_F0EA4030349A33D5 ) )
                    _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
            }

            _id_76E3E3800077282F = _id_76E3E3800077282F / _id_B54FEA3B6F15223C;

            if ( distance2d( _id_29F6D200784F77B3, _id_0B78E01E4CA8F50A ) < distance2d( _id_29F6D200784F77B3, _id_76E3E3800077282F ) )
            {
                _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
                _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
                continue;
            }
        }
    }

    return _id_3B8219D206004DFA;
}

determinetargetplayer( targetteam, _id_A9FF06560DA3D11F, _id_86A80A97F4672FC8 )
{
    _id_6864BEE22874201B = undefined;
    _id_B803EA87ECF23294 = undefined;
    targetplayer = undefined;
    _id_29F6D200784F77B3 = ( 0, 0, 0 );
    _id_90B91D6205FCE07F = 0;

    foreach ( _id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata( targetteam, "players" ) )
    {
        if ( !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( _id_F0EA4030349A33D5 ) )
        {
            _id_29F6D200784F77B3 = _id_29F6D200784F77B3 + _id_F0EA4030349A33D5.origin;
            _id_90B91D6205FCE07F++;
        }
    }

    _id_29F6D200784F77B3 = _id_29F6D200784F77B3 / _id_90B91D6205FCE07F;

    foreach ( player in scripts\mp\utility\teams::getteamdata( targetteam, "players" ) )
    {
        if ( istrue( _id_86A80A97F4672FC8 ) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418( player.origin, _id_A9FF06560DA3D11F.origin ) )
            continue;

        if ( player _id_2CEDCC356F1B9FC8::isplayeringulag() || !scripts\mp\utility\player::isreallyalive( player ) )
            continue;

        if ( _id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
        {
            if ( scripts\engine\utility::is_equal( player.script_noteworthy, "assassination_target" ) )
            {
                targetplayer = player;
                break;
            }
        }

        if ( !isdefined( targetplayer ) )
            targetplayer = player;

        if ( getdvar( "dvar_7611A2790A0BF7FE", "" ) == "plunder" || getdvar( "dvar_7611A2790A0BF7FE", "" ) == "risk" )
        {
            _id_B3D7D06E99EFD05E = player.plundercount;

            if ( isdefined( _id_B3D7D06E99EFD05E ) )
            {
                _id_2CC640C4CF5D3E6A = distance2dsquared( _id_A9FF06560DA3D11F.origin, player.origin );

                if ( !isdefined( _id_B803EA87ECF23294 ) || _id_2CC640C4CF5D3E6A <= _id_B803EA87ECF23294 )
                {
                    if ( !isdefined( _id_6864BEE22874201B ) || _id_B3D7D06E99EFD05E >= _id_6864BEE22874201B )
                    {
                        _id_6864BEE22874201B = _id_B3D7D06E99EFD05E;
                        _id_B803EA87ECF23294 = _id_2CC640C4CF5D3E6A;
                        targetplayer = player;
                    }
                }
            }

            continue;
        }

        if ( distance2d( _id_29F6D200784F77B3, player.origin ) < distance2d( _id_29F6D200784F77B3, targetplayer.origin ) )
            targetplayer = player;
    }

    targetplayer.hasbeentracked = 0;
    self.targetplayer = targetplayer;
}

determinetrackingcircleposition( targetplayer )
{
    search_location = ( targetplayer.origin[0], targetplayer.origin[1], level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6 );

    if ( !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
        search_location = search_location + scripts\engine\math::random_vector_2d() * randomfloatrange( level._id_7E12F6EB4FCB4EA1._id_2A708F42DF785976, level._id_7E12F6EB4FCB4EA1._id_2A938142DF9E8264 );

    scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13( search_location );
}

determinetrackingcirclesize()
{
    if ( _id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() )
    {
        scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC( level.lootleadermarksize );
        self.threat_level = 2;
    }
    else
    {
        _id_579AC64EAFB44D97 = [];

        foreach ( player in scripts\mp\utility\teams::getteamdata( self.hunterteam, "players" ) )
        {
            if ( !player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive( player ) )
                _id_579AC64EAFB44D97[_id_579AC64EAFB44D97.size] = player;
        }

        if ( _id_579AC64EAFB44D97.size == 0 )
        {
            scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC( level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794 );
            self.threat_level = 0;
        }
        else
        {
            _id_42CA41C7DADAE0C0 = undefined;

            foreach ( player in _id_579AC64EAFB44D97 )
            {
                dist = distance2d( player.origin, self.targetplayer.origin );

                if ( !isdefined( _id_42CA41C7DADAE0C0 ) || dist < _id_42CA41C7DADAE0C0 )
                    _id_42CA41C7DADAE0C0 = dist;
            }

            if ( _id_42CA41C7DADAE0C0 > level._id_7E12F6EB4FCB4EA1._id_A12A720226632B47 )
            {
                scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC( level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794 );
                self.threat_level = 0;
                return;
            }

            if ( _id_42CA41C7DADAE0C0 > level._id_7E12F6EB4FCB4EA1._id_65DD392CAFAB8111 )
            {
                scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC( level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6 );
                self.threat_level = 1;
                return;
            }

            scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC( level._id_7E12F6EB4FCB4EA1._id_3BD4A66A02968ECC );
            self.threat_level = 2;
        }
    }
}

determineobjectivevisibility()
{
    foreach ( player in scripts\mp\utility\teams::getteamdata( self.hunterteam, "players" ) )
    {
        _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
        _id_4D454E0079090D74 = isdefined( player.aq_hudenabled ) && player.aq_hudenabled;

        if ( _id_1B7F5108008D55B6 && _id_4D454E0079090D74 )
            player hideassassinationhud( self );

        if ( !_id_1B7F5108008D55B6 && !_id_4D454E0079090D74 )
            player showassassinationhud( self );
    }

    foreach ( player in scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) )
    {
        _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
        _id_4D454E0079090D74 = isdefined( player.aq_targethudenabled ) && player.aq_targethudenabled;

        if ( _id_1B7F5108008D55B6 && _id_4D454E0079090D74 )
            player hideassassinationtargethud();

        if ( !_id_1B7F5108008D55B6 && !_id_4D454E0079090D74 )
            player showassassinationtargethud( self.targetplayer, self.threat_level );
    }
}

getnewtargetplayer( _id_A9FF06560DA3D11F )
{
    determinetargetplayer( self.targetteam, _id_A9FF06560DA3D11F );
    determinetrackingcircleposition( self.targetplayer );
    determinetrackingcirclesize();
    updateassassinationhud();
}

removeallaqui()
{
    foreach ( player in scripts\mp\utility\teams::getteamdata( self.hunterteam, "players" ) )
        player hideassassinationhud( self );

    foreach ( player in scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) )
        player hideassassinationtargethud();

    scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

getplayerkills()
{
    if ( level.br_leaderbystreak )
        return self.killsthislife.size;
    else
        return self.kills;
}

getfilterformodifier( modifier )
{
    switch ( modifier )
    {
        case "_all_timed":
        case "_all":
            return level.questinfo.defaultfilter;
        default:
            return 0;
    }
}

showassassinationhud( instance )
{
    self.aq_hudenabled = 1;
    _id_64ACB6CE534155B7::uiobjectiveshow( "assassination" );
    instance scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F( self );
}

hideassassinationhud( instance )
{
    self.aq_hudenabled = 0;
    _id_64ACB6CE534155B7::uiobjectivehide();
    instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B( self );
}

updateassassinationthreatlevel( targetteam )
{
    foreach ( player in scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) )
        player _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0( self.targetplayer, self.threat_level );
}

showassassinationtargethud( targetplayer, threatlevel )
{
    self.aq_targethudenabled = 1;
    _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0( targetplayer, threatlevel );
}

hideassassinationtargethud()
{
    self.aq_targethudenabled = 0;
    self setclientomnvar( "ui_br_assassination_target", 0 );
}

updateassassinationhud()
{
    foreach ( player in scripts\mp\utility\teams::getteamdata( self.hunterteam, "players" ) )
    {
        player showassassinationhud( self );
        player _id_64ACB6CE534155B7::uiobjectivesetparameter( self.targetplayer getentitynumber() );
    }

    foreach ( player in scripts\mp\utility\teams::getteamdata( self.targetteam, "players" ) )
        player showassassinationtargethud( self.targetplayer, self.threat_level );
}

gametypeoverrideassassinsearchparams()
{
    _id_9254FE14251C6557 = 0;
    gametype = scripts\mp\utility\game::getsubgametype();

    switch ( gametype )
    {
        case "mini_mgl":
        case "mini":
        case "vanilla":
        case "risk":
        case "plunder":
            _id_9254FE14251C6557 = 1;
            break;
    }

    return _id_9254FE14251C6557;
}

_id_5F352FB76C54705C()
{
    if ( isdefined( level._id_AAB4FBA7A041B281 ) )
        return 0;

    return scripts\engine\utility::array_contains( level._id_AAB4FBA7A041B281, self );
}
