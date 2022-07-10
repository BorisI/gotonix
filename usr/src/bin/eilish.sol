pragma ton-solidity >= 0.61.2;

import "Shell.sol";
import "libshellenv.sol";

struct Command {
    string cmd;
    string s_args;
    string redir_in;
    string redir_out;
}

contract eilish is Shell {

    using libshellenv for shell_env;
    function compound(string input, string aliases) external pure returns (Command[] res) {
        return _compound(input, aliases);
    }

    function _compound(string input, string aliases) internal pure returns (Command[] res) {
        if (input.empty())
            return res;
        (string[] commands, ) = input.split(";");
        for (string line: commands) {
            (string cmd_raw, string sargs) = line.csplit(" ");
            string cmd_expanded;// = vars.val(cmd_raw, aliases);
            input = cmd_expanded.empty() ? line : cmd_expanded + " " + sargs;
            string cmd;
            (cmd, sargs) = input.csplit(" ");
            string redir_in;
            string redir_out;
            if (!sargs.empty()) {
                uint p = sargs.strrchr(">");
                if (p > 0) {
                    redir_out = sargs.strtok(p, " ");
                    sargs = sargs.substr(0, p - 1);
                    sargs.trim_spaces();
                }
                uint q = sargs.strrchr("<");
                if (q > 0) {
                    redir_in = sargs.strtok(q, " ");
                    sargs = sargs.substr(0, q - 1);
                    sargs.trim_spaces();
                }
            }
            res.push(Command(cmd, sargs, redir_in, redir_out));
        }
    }

   function main(svm sv_in, string input, shell_env e_in) external pure returns (svm sv, shell_env e) {
        sv = sv_in;
        s_proc p = sv.cur_proc;
        e = e_in;

        string[][] ev = e.environ;
        string[] pages;
        string[] aliases = ev[sh.ALIAS];
        string opt_string;
        string index;
        string pool;
        if (sv.vmem.length > 1) {
            pages = sv.vmem[1].vm_pages;
            opt_string = pages[1];
            index = pages[2];
            pool = pages[3];
        }

        s_of f = p.stdout();
        f.fflush();
        p.p_fd.fdt_ofiles[io.STDOUT_FILENO] = f;
        e.ofiles[libfdt.STDOUT_FILENO] = f;
        f = p.stderr();
        f.fflush();
        p.p_fd.fdt_ofiles[io.STDERR_FILENO] = f;
        e.ofiles[libfdt.STDERR_FILENO] = f;
        f = p.p_fd.fdt_ofiles[3];
        f.fflush();
        p.p_fd.fdt_ofiles[3] = f;
        e.ofiles[3] = f;
        if (input.empty())
            return (sv, e);
        (string cmd_raw, string argv) = input.csplit(" ");
        string cmd_expanded = vars.val(cmd_raw, aliases);
        string sinput = cmd_expanded.empty() ? input : cmd_expanded + " " + argv;
        string cmd;
        (cmd, argv) = sinput.csplit(" ");
        string cmd_opt_string = vars.val(cmd, ev[sh.OPTSTRING]);//opt_string);

        string sflags;
        string redir_in;
        string redir_out;
        uint8 ec;
        string[][2] opt_values;
        string pos_params;
        string res;
        string serr;
        string[] params;
        uint n_params;
        string last_param;
        string sargs = argv;
        if (!argv.empty()) {
            string sbody;
            (sbody, redir_out) = argv.csplit(">");
            (sargs, redir_in) = sbody.csplit("<");
            (params, n_params) = sargs.split(" ");
            (sflags, opt_values, serr, pos_params, ) = _parse_params(params, cmd_opt_string);
            if (!serr.empty())
                ec = EX_BADUSAGE;
            for (string arg: params) {
                if (str.strchr(arg, '$') > 0) {
                    string ref = arg.val("$", " ");
                    if (str.strchr(ref, '{') > 0)
                        ref.unwrap();
                    string ref_val;// = vars.val(ref, pool);
                    pos_params.translate(arg, ref_val);
                    sargs.translate(arg, ref_val);
                }
            }
        }
        string cmd_type = vars.get_array_name(cmd, ev[sh.ARRAYVAR]);
        if (cmd_type == "builtin")
            res = "./bin/eilish.dir/builtin " + cmd + " " + sargs;
        else if (cmd_type == "command")
            res = "./bin/eilish.dir/command " + cmd + " " + sargs;
        else if (cmd_type == "sysmain")
            res = "./bin/eilish.dir/command " + cmd + " " + sargs;
        else if (cmd_type == "rsu")
            res = "./sbin/rsu " + cmd + " " + sargs;
        else if (cmd_type == "ki")
            res = "./sbin/ki " + cmd + " " + sargs;
        else if (cmd_type == "function") {
            res = "./tosh execute_function " + sinput;
        } else {
            if (!cmd_type.empty())
                serr.append("unknown commmand type: " + cmd_type);
            else
                serr.append("command not found: " + cmd);
            res = "echo " + serr;
            ec = EXECUTE_FAILURE;
        }

        // -------------
        (params, n_params) = pos_params.split(" ");
        last_param = pos_params.empty() ? cmd : params[n_params - 1];

        p.p_comm = cmd;
        s_dirent[] pas;
        for (string pm: params)
            pas.push(s_dirent(0, 0, pm));
        p.p_args.ar_misc = s_ar_misc(sinput, sflags, sargs, uint16(n_params), params, ec, last_param,
            serr, redir_in, redir_out, pas, opt_values);

        /*string[] pa;
        pa.push(vars.as_attributed_hashmap("COMMAND_LINE", args));
        p.p_args.ar_args = pa;
        p.p_args.ar_length = uint16(pa.length);*/

        p.p_args.ar_args = [vars.as_var_list("", [
            ["COMMAND", cmd],
            ["COMMAND_LINE", res],
            ["PARAMS", pos_params],
            ["FLAGS", sflags],
            ["ARGV", sinput],
            ["#", str.toa(n_params)],
            ["@", sargs],
            ["?", str.toa(ec)],
            ["_", last_param],
            ["OPTERR", serr],
            ["REDIR_IN", redir_in],
            ["REDIR_OUT", redir_out]]), res];
        sv.cur_proc = p;
    }

    function set_internal_vars(svm sv_in, string aliases, string opt_string, string index, string pool) external pure returns (svm sv) {
        sv = sv_in;
//        s_proc p = sv.cur_proc;
        string[] pages;
        pages.push(aliases);
        pages.push(opt_string);
        pages.push(index);
        pages.push(pool);
        s_vmem vmem1 = vmem.vmem_create("V1", 0, 4096, 0, 0, 0);
        vmem1.vm_pages = pages;
        if (sv.vmem.length > 1)
            sv.vmem[1] = vmem1;
        else
            sv.vmem.push(vmem1);
    }

    /*function set_tosh_vars(string profile) external pure returns (uint8 ec, string out) {
        ec = EXECUTE_SUCCESS;
        out = vars.as_var_list("", [
            ["_", vars.val("TOSH", profile)],
            ["-", vars.val("-", profile)],
            ["TOSH", vars.val("TOSH", profile)],
            ["TOSHOPTS", vars.as_map("expand_aliases")],
            ["TOSHPID", vars.val("TOSHPID", profile)],
            ["TOSH_SUBSHELL", vars.val("TOSH_SUBSHELL", profile)],
            ["TOSH_ALIASES", vars.val("TOSH_ALIASES", profile)],
            ["SHELLOPTS", "allexport:hashall"],
            ["TMPDIR", vars.val("TMPDIR", profile)],
            ["SHLVL", vars.val("SHLVL", profile)]]);
    }*/

    // Possible states for the parser that require it to do special things.
    uint16 constant PST_CASEPAT	    = 1;   // in a case pattern list
    uint16 constant PST_ALEXPNEXT	= 2;   // expand next word for aliases
    uint16 constant PST_ALLOWOPNBRC	= 4;   // allow open brace for function def
    uint16 constant PST_NEEDCLOSBRC	= 8;   // need close brace
    uint16 constant PST_DBLPAREN	= 16;  // double-paren parsing
    uint16 constant PST_SUBSHELL	= 32;  // ( ... ) subshell
    uint16 constant PST_CMDSUBST	= 64;  // $( ... ) command substitution
    uint16 constant PST_CASESTMT	= 128; // parsing a case statement
    uint16 constant PST_CONDCMD	    = 256; // parsing a [[...]] command
    uint16 constant PST_CONDEXPR	= 512; // parsing the guts of [[...]]
    uint16 constant PST_ARITHFOR	= 1024; // parsing an arithmetic for command

    function _parse_redirects(string s) internal pure returns (string sargs, string redir_in, string redir_out) {
        string sbody;
        (sbody, redir_out) = s.csplit(">");
        (sargs, redir_in) = sbody.csplit("<");
    }

    function _parse_params(string[] params, string opt_string) internal pure returns (string sflags, string[][2] opt_values, string serr, string pos_params, string sattrs) {
        uint n_params = params.length;
        uint opt_str_len = opt_string.byteLength();
        bool expect_options = true;
        for (uint i = 0; i < n_params; i++) {
            string token = params[i];
            bytes bt = bytes(params[i]);
            uint t_len = bt.length;//token.byteLength();
            if (t_len == 0)
                continue;
//            if (expect_options && token.substr(0, 1) == "-") {
            if (expect_options && bt[0] == '-') {
                string o;
                bytes bo;
                string val;
                if (t_len == 1)
                    continue; // stdin redirect
//                if (token.substr(1, 1) == "-") {
                if (bt[1] == '-') {
                    if (t_len == 2) { // arg separator
                        expect_options = false;
                        continue;
                    }
                    o = token.substr(2); // long option
                    bo = bt[2 : ];
                } else {
                    // short option(s)
                    o = token.substr(1);
                    bo = bt[1 : ];
                    if (t_len > 2) {     // short option sequence has no value
                        for (uint j = 1; j < t_len; j++)
                            sflags.append(token.substr(j, 1));
                        continue;
                    }
                }
                uint o_len = bo.length;//o.byteLength();
                if (o_len == 1) {
                    byte b = bo[0];//bytes(o)[0];
                    uint p = str.strchr(opt_string, b); // _strstr() for long options ?
                    if (p > 0) {
                        if (p < opt_str_len && opt_string.substr(p, 1) == ":") {
                            if (i + 1 < n_params) {
                                val = params[i + 1];
                                i++;
                            } else
                                serr.append(format("error: missing option {} value in {} at {} pos {}\n", o, opt_string, p, i));
                        } else
                            val = o;//o;
                        opt_values.push([o, val]);
                        sflags.append(o);
                    } else
                        serr.append("error: unrecognized option: " + o + " opt_string: " + (opt_string.empty() ? "empty" : opt_string) + "\n");
                } else {
                    if (o == "help" || o == "version")
                        opt_values.push([o, o]);
                    else
                        serr.append("error: unrecognized option: " + o + ". Long options are not yet supported\n");
                }
//            } else if (token.substr(0, 1) == "+")
            } else if (bt[0] == '+')
                sattrs.append(token);
            else {
                if (pos_params.empty())
                    pos_params = token;
                else
                    pos_params.append(" " + token);
            }
        }
    }

    function _builtin_help() internal pure override returns  (BuiltinHelp bh) {
        return BuiltinHelp("eilish",
            "[command ...]",
            "Command shell",
            "Command shell",
            "",
            "",
            "");
    }
}
