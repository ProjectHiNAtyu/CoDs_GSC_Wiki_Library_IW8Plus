// IW9 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

registersharedfunc( category, _id_EA847593E957F2B0, function )
{
    if ( !isdefined( level.sharedfuncs ) )
        level.sharedfuncs = [];

    if ( !isdefined( level.sharedfuncs[category] ) )
        level.sharedfuncs[category] = [];

    level.sharedfuncs[category][_id_EA847593E957F2B0] = function;
}

issharedfuncdefined( category, _id_EA847593E957F2B0, _id_74E2CB47254BC22C )
{
    if ( !isdefined( level.sharedfuncs ) )
        return 0;

    if ( !isdefined( level.sharedfuncs[category] ) )
        return 0;

    func = level.sharedfuncs[category][_id_EA847593E957F2B0];

    if ( !isdefined( func ) )
    {
        if ( istrue( _id_74E2CB47254BC22C ) )
        {

        }

        return 0;
    }

    return 1;
}

getsharedfunc( category, _id_EA847593E957F2B0 )
{
    return level.sharedfuncs[category][_id_EA847593E957F2B0];
}

_id_F3BB4F4911A1BEB2( category, _id_EA847593E957F2B0, _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    if ( !isdefined( category ) || !isdefined( _id_EA847593E957F2B0 ) )
        return;

    if ( !issharedfuncdefined( category, _id_EA847593E957F2B0 ) )
        return;

    func = getsharedfunc( category, _id_EA847593E957F2B0 );

    if ( isdefined( param8 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7, param8 );

    if ( isdefined( param7 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7 );

    if ( isdefined( param6 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6 );

    if ( isdefined( param5 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5 );
    else if ( isdefined( param4 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3, param4 );
    else if ( isdefined( param3 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2, param3 );
    else if ( isdefined( param2 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1, param2 );
    else if ( isdefined( param1 ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA, param1 );
    else if ( isdefined( _id_F3CB1D51D632B4BA ) )
        return self [[ func ]]( _id_F3CB1D51D632B4BA );
    else
        return self [[ func ]]();
}
