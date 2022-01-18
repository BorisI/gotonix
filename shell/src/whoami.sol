pragma ton-solidity >= 0.54.0;

import "Utility.sol";

contract whoami is Utility {

    function exec_env(string args, string pool) external pure returns (uint8 ec, string out, string err) {
        ec = args.empty() ? EXECUTE_SUCCESS : EXECUTE_FAILURE;
        out = _val("USER", pool);
        err = "";
    }

    function _command_info() internal override pure returns (string command, string purpose, string synopsis, string description, string option_list, uint8 min_args, uint16 max_args, string[] option_descriptions) {
        string[] empty;
        return (
"whoami",
"print effective userid",
"[OPTION]...",
"Print the user name associated with the current effective user ID. Same as id -un.",
"",
0,
0,
empty);
    }

    function _command_help() internal override pure returns (CommandHelp) {
        return CommandHelp(
"whoami",
"OPTION...",
"print effective userid",
"Print the user name associated with the current effective user ID. Same as id -un.",
"",
"",
"Written by Boris",
"",
"",
"0.01");
    }

}
