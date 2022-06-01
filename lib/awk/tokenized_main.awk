{
    l = json_split2tokenarr_( $0 )
    for (i=1; i<=l; ++i) {
        t = O[i]
        if (t != "") print t
    }
}