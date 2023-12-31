pragma ton-solidity >= 0.62.0;

import "putil_stat.sol";
import "pw.sol";

contract finger is putil_stat {

    function _main(shell_env e_in, mapping (uint16 => Inode) inodes, mapping (uint16 => bytes) data) internal override pure returns (shell_env e) {
        e = e_in;
        string[] params = e.params();
        bool flag_multi_line = e.flag_set("l");
        bool flag_short_format = e.flag_set("s");
        bool short_format = flag_short_format && !flag_multi_line;
        if (params.empty())
            e.puts("No one logged on");
        else {
            string user_name = params[0];
            string[][] table;
            if (short_format)
                table = [["Login", "Tty", "Idle", "Login Time"]];
            (string etc_passwd, , , ) = fs.get_passwd_group(inodes, data);
            (string line, s_passwd res) = pw.getnam(user_name, etc_passwd);
            if (line.empty())
                e.perror(user_name + ": no such user");
            (string pw_name, , , string pw_gecos, string pw_dir, string pw_shell) = res.unpack();
            if (short_format)
                table.push([pw_name, "*", "*", "No logins"]);
            else
                table = [["Login: " + pw_name, "Directory: " + pw_dir],
                        ["Name: " + pw_gecos, "Shell: " + pw_shell]];
            e.puts(fmt.format_table(table, " ", "\n", fmt.CENTER));
        }
    }

    function _command_help() internal override pure returns (CommandHelp) {
        return CommandHelp(
"finger",
"[-lms] [user ...]",
"user information lookup program",
"Displays information about the system users.",
"-l      produces a multi-line format displaying all of the information described for the -s option as well as the user's home directory\n\
-m      prevent matching of user names\n\
-s      displays the user's login name, write status and login time",
"",
"Written by Boris",
"",
"",
"0.02");
    }

}
