
function k(){
    if (_k_reset == 1) return _k
    _k_reset = 1
    return _k = juq( key )
}

function v(){
    if (_v_reset == 1) return _v
    _v_reset = 1
    return _v = juq( $0 )
}

function juq(str){
    if (str !~ /^"/) { # "
        return str
    }
    gsub(/\\\\/, "\001\001", str)
    gsub(/\\"/, /"/, str)
    gsub("\001\001", "\\\\", str)
    return substr(str, 2, length(str)-2)
}

function jqu(str){
    gsub(/\\/, "\\\\", str)
    gsub(/"/, "\\\"", str)
    return "\"" str "\""
}

function ga( k1, k2, k3, k4, k5, k6, k7, k8, k9 ){ # absolute
    return _[ kpgen( k1, k2, k3, k4, k5, k6, k7, k8, k9 ) ]
}

function gr( k1, k2, k3, k4, k5, k6, k7, k8, k9 ){ # relative
    return _[ KP S kpgen( k1, k2, k3, k4, k5, k6, k7, k8, k9 ) ]
}

function kpmatch( k1, k2, k3, k4, k5, k6, k7, k8, k9 ){
    return match(KP, kpgen( k1, k2, k3, k4, k5, k6, k7, k8, k9 ) "$" )
}

function kpglob( k1, k2, k3, k4, k5, k6, k7, k8, k9 ){
    return match( KP, glob(k1, k2, k3, k4, k5, k6, k7, k8, k9) "$" )
}


function kpgen( k1, k2, k3, k4, k5, k6, k7, k8, k9, _ret ){
    _ret = ""
    if ( k1 == "" ) return _ret
    _ret = _ret S jqu( k1 )
    if ( k2 == "" ) return _ret
    _ret = _ret S jqu( k2 )
    if ( k3 == "" ) return _ret
    _ret = _ret S jqu( k3 )
    if ( k4 == "" ) return _ret
    _ret = _ret S jqu( k4 )
    if ( k5 == "" ) return _ret
    _ret = _ret S jqu( k5 )
    if ( k6 == "" ) return _ret
    _ret = _ret S jqu( k6 )
    if ( k7 == "" ) return _ret
    _ret = _ret S jqu( k7 )
    if ( k8 == "" ) return _ret
    _ret = _ret S jqu( k8 )
    if ( k9 == "" ) return _ret
    _ret = _ret S jqu( k9 )
    return _ret
}

function glob_item( key ){
    gsub(/\*/, "[^\001]+", key);    return key
}

function glob( k1, k2, k3, k4, k5, k6, k7, k8, k9 ){
    _ret = ""
    if ( k1 == "" ) return _ret
    _ret = _ret S glob_item( k1 )
    if ( k2 == "" ) return _ret
    _ret = _ret S glob_item( k2 )
    if ( k3 == "" ) return _ret
    _ret = _ret S glob_item( k3 )
    if ( k4 == "" ) return _ret
    _ret = _ret S glob_item( k4 )
    if ( k5 == "" ) return _ret
    _ret = _ret S glob_item( k5 )
    if ( k6 == "" ) return _ret
    _ret = _ret S glob_item( k6 )
    if ( k7 == "" ) return _ret
    _ret = _ret S glob_item( k7 )
    if ( k8 == "" ) return _ret
    _ret = _ret S glob_item( k8 )
    if ( k9 == "" ) return _ret
    _ret = _ret S glob_item( k9 )
    return _ret
}
