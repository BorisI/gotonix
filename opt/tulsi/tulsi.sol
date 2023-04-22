pragma ton-solidity >= 0.67.0;

import "common.h";
import "libstr.sol";

struct cparam {
    string mvar;
    string val;
    string desc;
}
struct confg {
    uint8 n;
    cparam[] params;
}
contract tulsi is common {

    TvmCell _rom;
    uint32 _version;
    function immap(mapping (uint32 => TvmCell) m) external accept {
        for ((uint32 a, TvmCell c): m)
            if (_ram[a] != c)
                _ram[a] = c;
    }
    function ldr(uint32 a, uint32 n) external view returns (TvmCell[] cc) {
        repeat(n) {
            if (_ram.exists(a))
                cc.push(_ram[a]);
            a++;
        }
    }
    string constant SELF = "tulsi";
    string constant PP = "parse";
    string constant TOC = "../../bin/tonos-cli";

    bytes constant QUICKS = "cCuUhHbBqQwWxXzZ";

    uint8 constant CRUN = 1;
    uint8 constant CCALL = 2;

    uint8 constant CONFIG_START = 22;
    uint8 constant CONFIG_PACKED = 33;
    uint8 constant CONFIG_PROJECT = 36;
    uint8 constant CONFIG_PARSER = 38;
    uint8 constant CONFIG_VOL = 42;

    uint8 constant REDIR_NONE  = 1;
    uint8 constant REDIR_OUT   = 2;
    uint8 constant REDIR_FILE  = 4;
    uint8 constant REDIR_PRINT = 8;
    uint8 constant REDIR_DBG   = 16;
    uint8 constant REDIR_SRC   = 32;
    uint8 constant REDIR_ARGS  = 64;

    enum MENU { MAIN, DUMP, PARSE, PARSEC, CONFIG, MISC, LAST }
    string[][] constant MCS = [
        ["Tulsi", "Dump", "Parse", "Parsec", "Misc"],
        ["Dump config", "Main", "As vars", "Project", "Parser", "Module" ],
        ["Parse", "-", "-", "-", "Test" ],
        ["Parse module", "Generate", "-", "Deploy", "Test" ],
        ["Config", "Print"],
        ["Misc", "Bin size"]
    ];

    function ens(string s1, string s2, string s3, string s4) external pure returns (TvmCell c) {
        return abi.encode(s1, s2, s3, s4);
    }

    function _mval(confg cf, string name) internal pure returns (string) {
        for (uint i = 0; i < cf.n; i++) {
            if (name == cf.params[i].mvar)
                return cf.params[i].val;
        }
    }
    function _val(confg cf, string name) internal pure returns (string) {
        for (uint i = 0; i < cf.n; i++) {
            if (name == cf.params[i].desc)
                return cf.params[i].val;
        }
    }
    function _ccmd(string cn, uint8 ccm, string fn, string args, uint8 redir, bool debug) internal view returns (string cmd) {
        confg cf = _decode_packed_config(_ram[CONFIG_PACKED]);
        string sRT = _mval(cf, "R_ROOT");
        string sBIN = _mval(cf, "TOOLS_BIN");
        string sTOC = _mval(cf, "TOC");
        string sETC = _mval(cf, "ETC");
        string sTMP = _mval(cf, "TMP");
        string sCONF = _mval(cf, "CONFD");
        string sTO = sRT + "/" + sBIN + "/" + sTOC;
        string pq = sTO + " -c " + sETC + "/" + cn + "." + sCONF + " ";
        string pp = sTO + " -c " + sETC + "/parser.conf ";
        string ofn = " " + sTMP + "/" + fn + ".res";
        string fargs = " -m " + fn + " " + args;
        string sredir =
            redir == REDIR_OUT ? " | jq -r .out\n" :
            (redir & REDIR_FILE) > 0 ? " >" + ofn + "\n":
            redir == REDIR_PRINT ? " | xargs " + pp + " runx -m print `jq -c .` | jq -rj .out\n" :
            redir == REDIR_ARGS ? " | xargs " :
            redir == REDIR_NONE ? "" : "";
        cmd.append(pq + (ccm == CRUN ? "runx" : "callx") + fargs);
        cmd.append(sredir);
        if (debug) {
            cmd.append(_cjoin([
                "grep -q \"Error: {\"" + ofn,
                pq + "debug run -d build/" + cn + ".debug.json" + fargs,
                "tail -n15 trace.log | head -n-5\n"]));
        }
        if ((redir & REDIR_FILE) > 0) {
            if ((redir & REDIR_OUT) > 0)
                cmd.append("jq -r .out " + ofn + "\n");
            else if ((redir & REDIR_SRC) > 0)
                cmd.append("jq -r .out " + ofn + " > " + ofn + ".src \n");
            if ((redir & REDIR_DBG) > 0)
                cmd.append("jq -r .dbg " + ofn + "\n");
        }
    }

    function ena(string[] vv) internal pure returns (TvmBuilder bi, TvmBuilder bs) {
        uint8 off;
        uint8 qty = uint8(vv.length);
        bi.store(qty);
        for (uint8 i = 0; i < qty; i++) {
            bytes bb = vv[i];
            uint8 len = uint8(bb.length);
            for (bytes1 x: bb)
                bs.store(x);
            bi.store(off, len);
            off += len;
        }
    }

    function pc(TvmCell c) external pure returns (string out) {
        return _decode_packed(c);
    }

    function _decode_packed_config(TvmCell c) internal pure returns (confg cf) {
        TvmSlice s = c.toSlice();
        uint8 q1 = s.decode(uint8);
        cf.n = q1;
        TvmSlice s1 = s.loadSlice(uint(q1) * 16, 1);
        s.skip(8);
        TvmSlice s2 = s.loadSlice(uint(q1) * 16, 1);
        s.skip(8);
        TvmSlice s3 = s;//.skip(q1 * 16 + 8, 1);
//        out.append(format("s {}/{} s1 {}/{} s2 {}/{} s3{}/{}\n", s.bits(), s.refs(), s1.bits(), s1.refs(), s2.bits(), s2.refs(), s3.bits(), s3.refs()));
        bytes sn = s1.decode(bytes);
        bytes sv = s2.decode(bytes);
        bytes svv = s3.decode(bytes);
//        out.append(format("{}/{}/{}\n", sn.length, sv.length, svv.length));
        repeat (q1) {
            (uint8 off1, uint8 len1) = s1.decode(uint8, uint8);
            (uint8 off2, uint8 len2) = s2.decode(uint8, uint8);
            (uint8 off3, uint8 len3) = s3.decode(uint8, uint8);
            cf.params.push(cparam(svv[off3 : off3 + len3], sv[off2 : off2 + len2], sn[off1 : off1 + len1]));
        }
    }

    function _decode_packed(TvmCell c) internal pure returns (string  out) {
        confg cf = _decode_packed_config(c);
        for (uint i = 0; i < cf.n; i++) {
            (string mvar, string val, string desc) = cf.params[i].unpack();
            out.append(format("{}:\t$({})\t{}\n", desc, mvar, val));
        }
    }

    function enp(string[] ss1, string[] ss2, string[] ss3) external pure returns (TvmCell c) {
        (TvmBuilder bi1, TvmBuilder bs1) = ena(ss1);
        (TvmBuilder bi2, TvmBuilder bs2) = ena(ss2);
        (TvmBuilder bi3, TvmBuilder bs3) = ena(ss3);
        TvmBuilder b;
        b.store(bi1, bi2, bi3);
        b.storeRef(bs1);
        b.storeRef(bs2);
        b.storeRef(bs3);
        return b.toCell();
    }
    function _misc(uint n) internal pure returns (string cmd) {
        if (n == 1)
            cmd.append("du -b build/*.tvc\n");
    }
    function _config(uint n) internal view returns (string cmd) {
        if (n == 1) {
            cmd.append(_print_cmd("File name?\n") + "read -r ii\n");
            string cm1 = _ccmd("tulsi", CRUN, "enp", "`jq -cn --arg n $ii '{ss1:[\"Module\"],ss2:[$n],ss3:[\"MODULE\"]}'` | jq -r .c", REDIR_ARGS, false);
            string cm2 = _ccmd("tulsi", CCALL, "st", " --a " + format("{}", CONFIG_VOL) + " --c ", REDIR_NONE, false);
            cmd.append(cm1);
            cmd.append(cm2);
        }

    }
    function _cjoin(string[] args) internal pure returns (string out) {
        if (!args.empty()) {
            out = args[0];
            for (uint i = 1; i < args.length; i++)
                out.append(" && " + args[i]);
        }
    }

    function _test_print_args(uint t, uint i, uint n) internal pure returns (string cmd) {
        string si = format("{}", i);
        string sn = format("{}", n);
        cmd.append(
            t == 16 ? "`jq -c {val:.g.tt[" + si + "]}" :
            t == 17 ? "`jq -c '{val:.g.tti[] | select(.id == \"" + si + "\") .vv[" + sn + "]}'" :
            t == 18 ? "`jq -c '.g.tti[] | select(.id == \"" + si + "\") | {val:{vtype:.vv[" + sn + "].pid,vname:.ss[" + sn + "],vdesc:\"\"}}'" : "???");
    }
    function _test_print(uint t, uint i) internal view returns (string cmd) {

        string st = format("{}", t);
        string targs = " tmp/parse_type.res` | jq -c '. + {t:" + st + "}'";
        string fn = "store_" + (t == 16 ? "stt" : t == 17 ? "vari" : t == 18 ? "vard" : "??");
        uint nv = i == 16 ? 8 : i  == 17 ? 6 : i == 18 ? 3 : 0;
        if (t == 16)

        for (uint n = 0; n < nv; n++) {
            string args = _test_print_args(t, i, n);
            //cmd.append(_toc_cmd("parser", CRUN, fn, args + targs, REDIR_PRINT, false));
            cmd.append(_ccmd("parser", CRUN, fn, args + targs, REDIR_PRINT, false));
        }
    }

    function _print(string usingg, uint8 att, uint8 withh) internal view returns (string cmd) {
        cmd.append("jq -r '.m[\"" + format("{}", att) + "\"]' " + usingg + ".tst | xargs " +
            _ccmd(usingg, CRUN, "print", "--t " + format("{}", withh) + " --c ", REDIR_OUT, false));
    }
    function _parsec(uint n) internal view returns (string cmd) {
        //jq -cn --rawfile v ti.h '{ss:$v,name:"tic"}'
        confg cf = _decode_packed_config(_ram[CONFIG_PACKED]);
        confg cfp = _decode_packed_config(_ram[CONFIG_PARSER]);
        confg cfv = _decode_packed_config(_ram[CONFIG_VOL]);
        string sPA = _mval(cfp, "PARSER");
        string sFN = _mval(cfp, "FN");
        string sMOD = _mval(cfv, "MODULE");
        string sRT = _mval(cf, "R_ROOT");
        string sBIN = _mval(cf, "TOOLS_BIN");
        string sSO = _mval(cf, "SOLD");
        string sMA = _mval(cf, "MAKE");
        string sSOLD = sRT + "/" + sBIN + "/" + sSO;
        string sTMP = _mval(cf, "TMP");
        string sBLD = _mval(cf, "BLD");
        string IF = sTMP + "/" + sFN + ".res.src";
        string REST = "-p " + sMOD + " -o " + sBLD + "\n";

        if (n == 1) {
            cmd.append(_ccmd(sPA, CRUN, sFN, "\"`jq -cn --rawfile v " + sMOD + " '{name:\"" + sMOD + "\",ss:$v}'`\"", REDIR_FILE + REDIR_SRC + REDIR_DBG, true));
            cmd.append(sSOLD + " " + IF + " " + REST);
        } else if (n == 2) {
            sFN = "parse_source";
            cmd.append(_ccmd(sPA, CRUN, sFN, "\"`jq -cn --rawfile v " + sMOD + " '{name:\"" + sMOD + "\",ss:$v}'`\"", REDIR_FILE + REDIR_SRC + REDIR_DBG, true));
            IF = sTMP + "/" + sFN + ".res.src";
            cmd.append(sSOLD + " " + IF + " " + REST);
//            cmd.append(sSOLD + " " + IF + " " + REST);
//            cmd.append(_print_cmd("File name?\n") + "read -r ii\n");
//            cmd.append(_toc_cmd("parsec", CRUN, "absorb_module", "\"`jq -cn --arg n $ii --rawfile v $ii '{name:$n,ss:$v}'`\"", REDIR_FILE + REDIR_SRC + REDIR_DBG, true));
//            cmd.append("~/bin/0.67.1/sold tmp/absorb_module.res.src -p $ii -o build\n");
        } else if (n == 3) {
            cmd.append(sMA + " " + sBLD + "/" + sMOD + "." + "deployed" + "\n");
        } else if (n == 4) {
            uint8 start = 18;
            for (uint i = 6; i < 10; i++)
                cmd.append(_print(sMOD, uint8(i), 7 + start));
            cmd.append(_print(sMOD, 5, 8 + start));
            cmd.append(_print(sMOD, 250, 2 + start));
        } else if (n == 5) {
            cmd.append(_print(sMOD, 0, 2));
            cmd.append(_print(sMOD, 1, 6));
            cmd.append(_print(sMOD, 2, 7));
        } else if (n == 6) {
            //tonos-cli -c etc/qx.conf runx -m store_mod_info `jq -c {val:.g.mi} qx.trs`
            cmd.append(_ccmd("qx", CRUN, "store_mod_info", "\"`jq -c {val:.g.mi} qx.trs`\" | jq -r .c", REDIR_ARGS, false));
            cmd.append(_ccmd("qx", CRUN, "print", "--t " + "20" + " --c ", REDIR_OUT, false));
//            rawfile v " + sMOD + " '{name:\"" + sMOD + "\",ss:$v}'`\"", REDIR_FILE + REDIR_SRC + REDIR_DBG, true));
        }

    }
    function _parse(uint n) internal view returns (string cmd) {
        if (n == 4) {
            for (uint i = 16; i < 19; i++) {
                cmd.append(_test_print(16, i));
                for (uint j = 17; j < 19; j++)
                    cmd.append(_test_print(j, i));
            }
        }
    }
    function _dump(uint n) internal view returns (string out) {
        if (n < 6) {
            uint8 k = n == 2 ? CONFIG_PACKED : n == 3 ? CONFIG_PROJECT : n == 4 ? CONFIG_PARSER : n == 5 ? CONFIG_VOL : CONFIG_PACKED;
            if (n > 1) {
                confg cf = _decode_packed_config(_ram[k]);
                for (uint i = 0; i < cf.n; i++) {
                    cparam p = cf.params[i];
                    out.append(format("{}:={}  # {}\n", p.mvar, p.val, p.desc));
                }
            } else
                out.append(_decode_packed(_ram[k]));
        }
    }
    function onc(uint h, string s) external view returns (uint hout, string cmd, string out) {
        if (s.empty())
            return (hout, cmd, out);
        bytes1 b0 = bytes(s)[0];
        uint8 v = uint8(b0);
        (uint idev, uint ct, uint ctx, uint itm, uint arg, uint val) = _from_handle(h);
        MENU ectx = MENU(ctx);
        uint nitm;

        if (libstr.strchr(QUICKS, b0) > 0) {    // quick command
            if (v >= 0x41 && v <= 0x5A) // convert to lowercase
                v += 0x20;
            if (v == 0x62)  // go back to main menu
                ectx = MENU.MAIN;
            else    // execute a quick command
                cmd.append(_quick_command(v));
            nitm = itm;
        } else if (v >= 0x30 && v <= 0x39) {    // decimal digit
            uint8 n = v - 0x30; // digit ascii to value
            if (ectx == MENU.MAIN)   // switch context to a sub-menu
                ectx = MENU(n);
            else if (ectx == MENU.DUMP)
                out.append(_dump(n));
            else if (ectx == MENU.PARSE)
                cmd.append(_parse(n));
            else if (ectx == MENU.PARSEC)
                cmd.append(_parsec(n));
            else if (ectx == MENU.CONFIG)
                cmd.append(_config(n));
            else if (ectx == MENU.MISC)
                cmd.append(_misc(n));
            if (n == 0) // '0' prints current menu
                out.append(print_menu(ectx));
            nitm = n;
        }
        if (ectx != MENU(ctx)) {  // remember the current context
            nitm = 0;
            out.append(print_menu(ectx));
        }
        hout = _to_handle(idev, ct, uint(ectx), nitm, arg, val);
    }

    function _print_cmd(string s) internal pure returns (string) {
        return "printf \"" + s + "\";";
    }
    function print_menu(MENU n) internal view returns (string out) {
        return print_list_menu(MCS[uint(n < MENU.LAST ? n : MENU.MAIN)]);
    }
    function _quick_command(uint8 v) internal pure returns (string cmd) {
        mapping (uint8 => string) q;
        q[0x63] = "make cc";
        q[0x75] = "make up_" + SELF;
        q[0x77] = "make up_" + "parsec";
        q[0x71] = "echo Bye! && exit 0";
        q[0x78] = "set -x";
        q[0x7A] = "set +x";
        return q.exists(v) ? q[v] : "echo Unrecognized quick command";
    }
    function print_list_menu(string[] items) internal pure returns (string out) {
        uint len = items.length;
        if (len > 0)
            out.append(items[0] + "\n\n");
        for (uint i = 1; i < len; i++)
            out.append(format("{}) {}\n", i, items[i]));
    }

}
