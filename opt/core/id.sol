pragma ton-solidity >= 0.62.0;

import "putil.sol";
import "libenv.sol";
//import "unistd.sol";

contract id is putil {

//    using unistd for s_proc;

    function _main(shell_env e_in) internal pure override returns (shell_env e) {
        e = e_in;
        s_of res = e.ofiles[libfdt.STDOUT_FILENO];
        (bool effective_gid_only, bool name_not_number, bool real_id, bool effective_uid_only, bool all_group_ids, , , ) =
            e.flag_values("gnruG");
        bool is_ugG = effective_uid_only || effective_gid_only || all_group_ids;

        string[] ev = e.env_vars();
        string user_name = e.env_value("USER");
        string group_name = e.env_value("USER");
        /*uint16 uid = p.getuid();
        uint16 eid = p.geteuid();
        uint16 gid = p.getgid();*/
        uint16 uid = libenv.getuid(ev);
        uint16 eid = libenv.geteuid(ev);
        uint16 gid = libenv.getgid(ev);

        string out;
        if ((name_not_number || real_id) && !is_ugG)
            e.perror("cannot print only names or real IDs in default format");

        else if (effective_gid_only && effective_uid_only)
            e.perror("cannot print \"only\" of more than one choice");
        else if (effective_gid_only)
            out = name_not_number ? group_name : str.toa(gid);
        else if (effective_uid_only)
            out = name_not_number ? user_name : str.toa(eid);
        else
            out = format("uid={}({}) gid={}({})", uid, user_name, gid, group_name);
        res.fputs(out);
        e.ofiles[libfdt.STDOUT_FILENO] = res;
    }

    function _command_help() internal override pure returns (CommandHelp) {
        return CommandHelp(
"id",
"[OPTION]... [USER]",
"print real and effective user and group IDs",
"Print user and group information for the specified USER, or (when USER omitted) for the current user.",
"-a      ignore, for compatibility with other versions\n\
-g      print only the effective group ID\n\
-G      print all group IDs\n\
-n      print a name instead of a number, for -ugG\n\
-r      print the real ID instead of the effective ID, with -ugG\n\
-u      print only the effective user ID\n\
-z      delimit entries with NUL characters, not whitespace",
"",
"Written by Boris",
"",
"",
"0.01");
    }

}
