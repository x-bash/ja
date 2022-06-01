{
    a = 1 - a
    if (a == 0) val = $0
    else {
        KP = $0
        D = split(KP, _, "\001")
        K = _[ D ]
        next
    }
}