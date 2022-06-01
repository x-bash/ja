{
    ___x_cmd_ja_awk_kp_main_state = 1 - ___x_cmd_ja_awk_kp_main_state
    if (___x_cmd_ja_awk_kp_main_state == 0) V = $0
    else {
        KP = $0
        D = split(KP, _, "\001")
        K = _[ D ]
        next
    }
}