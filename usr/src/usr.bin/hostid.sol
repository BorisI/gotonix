pragma ton-solidity >= 0.61.0;

import "Utility.sol";

contract hostid is Utility {

    function main(s_proc p_in, mapping (uint16 => Inode) inodes, mapping (uint16 => bytes) data) external pure returns (s_proc p) {
        p = p_in;
        string host_name = p.env_value("HOSTNAME");
        bool long_host_name = p.flag_set("f");
        bool addresses = p.flag_set("i");

        (string[] f_hostname, uint n_fields) = libstring.split(fs.get_file_contents_at_path("/etc/hostname", inodes, data), "\n");
        if (n_fields > 0) {
            string sdomain = "tonix";
            if (addresses && n_fields > 1)
                p.puts(f_hostname[1]);
            else {
                p.puts(f_hostname[0]);
                if (long_host_name)
                    p.puts("." + sdomain);
            }
        } else
            p.puts(host_name);
    }

    function _command_help() internal override pure returns (CommandHelp) {
        return CommandHelp(
"hostid",
"[OPTION]",
"print the numeric identifier for the current host",
"Print the numeric identifier (in hexadecimal) for the current host.",
"",
"",
"Written by Boris",
"",
"gethostid",
"0.02");
    }

}
