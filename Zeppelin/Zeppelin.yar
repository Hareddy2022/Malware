/*
Zeppelin / Buran ransomware
*/


rule Zeppelin
{
    meta:
        author = "rivitna"
        family = "ransomware.zeppelin.windows"
        description = "Zeppelin / Buran ransomware Windows payload"
        severity = 10
        score = 100

    strings:
        $s0 = "\x09TZeppelin" ascii
        $s1 = "\x07TKeyObj" ascii
        $s2 = "\x07TReadme" ascii
        $s3 = "\x0FTExcludeFolders" ascii
        $s4 = "\x0DTExcludeFiles" ascii
        $s5 = "\x09TSearcher" ascii
        $s6 = "\x0BTTaskKiller" ascii
        $s7 = "\x10TDrivesAndShares" ascii
        $s8 = "\x00!!! D !!!" ascii
        $s9 = "\x00!!! LOCALPUBKEY !!!" ascii
        $s10 = "\x00!!! ENCLOCALPRIVKEY !!!" ascii

        $h0 = { 80 38 00 74 0C BE 00 00 10 00 BB 00 00 01 00 EB 0A
                BE 00 00 04 00 BB 00 40 00 00 }
        $h1 = { 0F B7 C0 A3 [4] 81 3D [4] 22 04 00 00 74 24
                81 3D [4] 23 04 00 00 74 18 81 3D [4] 19 04 00 00
                74 0C 81 3D [4] 3F 04 00 00 75 }
        $h2 = { A3 [4] 83 3D [4] 07 74 18 81 3D [4] 77 01 00 00
                74 0C 81 3D [4] 7C 01 00 00 75 }
        $h3 = { E8 [3] FF 3D 6F A8 3D 2F 0F 94 45 }
        $h4 = "8D9A1F76-A705-426D-8722-CCD4F4263E2C" ascii

    condition:
        ((uint16(0) == 0x5A4D) and (uint32(uint32(0x3C)) == 0x00004550)) and
        (
            (4 of ($s*)) and (1 of ($h*))
        )
}
