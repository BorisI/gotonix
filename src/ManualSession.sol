pragma ton-solidity >= 0.49.0;

import "Manual.sol";

/* Session management commands manual */
contract ManualSession is Manual {

    function _manual_name() internal pure override returns (string) {
        return "ManualSession";
    }

    function _init1() internal override accept {
        INodeS[] files = _files(
            ["account", "cd", "dd", "hostname", "id"], [
        _insert_lines("account", "print account information", "[OPTIONS] <ADDRESS>", "Obtains and prints account information.",
            "d", 0, M, ["dump account StateInit to a tvc file"]),
        _insert_lines("cd", "Change the shell working directory", "[-L|[-P [-e]]] [dir]", "Change the current directory to DIR.  The default DIR is the value of the HOME shell variable.",
            "LPE", 1, 1, ["force symbolic links to be followed",
            "use the physical directory structure without following symbolic links",
            "with -P, and if the current working directory is invalid, signal error"]),
        _insert_lines("dd", "convert and copy a file", "[OPERAND]...", "Copy a file, converting and formatting according to the operands.",
            "", 0, M, [""]),
        _insert_lines("hostname", "show or set the system's host name", "[-afis]", "display the system's hostname and address",
            "afis", 0, 0, ["alias names", "long host name (FQDN)", "addresses for the host name", "short host name"]),
        _insert_lines("id", "print real and effective user and group IDs", "[OPTION]... [USER]", "Print user and group information for the specified USER, or (when USER omitted) for the current user.",
            "gGnruz", 0, 1, ["print only the effective group ID",
            "print all group IDs",
            "print a name instead of a number, for -ugG",
            "print the real ID instead of the effective ID, with -ugG",
            "print only the effective user ID",
            "delimit entries with NUL characters, not whitespace"])]);
        _add_reg_files(ROOT_DIR + 1, files);
    }

    function init2() external override accept {
        INodeS[] files = _files(["login", "logout", "lslogins", "mapfile", "mount"], [
        _insert_lines("login", "begin session on the system", "[-h host] [username] -r host", "establish a new session with the system.",
            "fhr", 1, 1, ["", "", "", ""]),
        _insert_lines("logout", "exit a login shell", "", "Exits a login shell. Returns an error if not executed in a login shell.",
            "", 0, 0, [""]),
        _insert_lines("lslogins", "display information about known users in the system", "[options] [-s] [username]", "Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd and output the desired data.",
            "cenrsuz", 0, 1, ["display data in a format similar to /etc/passwd",
            "display in an export-able output format",
            "display each piece of information on a new line",
            "display in raw mode",
            "display system accounts",
            "display user accounts",
            "delimit user entries with a nul character"]),
        _insert_lines("mapfile", "read lines from the standard input into an indexed array variable.", "[-d delim] [-n count] [-s count] [-t] [-u fd] [array]", "",
            "dnstu", 1, M, ["Use DELIM to terminate lines, instead of newline",
            "Copy at most COUNT lines.  If COUNT is 0, all lines are copied",
            "Discard the first COUNT lines read",
            "Remove a trailing DELIM from each line read (default newline)",
            "Read lines from file descriptor FD instead of the standard input"]),
        _insert_lines("mount", "mount a filesystem", "[-l]\t-a [-fnrvw]\t-[NTBM] <source> <directory>", "attach the filesystem found on some device to the file tree",
            "acfTlbrvwNBM", 0, 3, ["mount all filesystems mentioned in fstab",
            "don't canonicalize paths",
            "dry run; skip the mount(2) syscall",
            "alternative file to /etc/fstab",
            "show also filesystem labels",
            "don't write to /etc/mtab",
            "mount the filesystem read-only",
            "say what is being done",
            "mount the filesystem read-write (default)",
            "perform mount in another namespace",
            "mount a subtree somewhere else",
            "move a subtree to some other place"])]);
        _add_reg_files(ROOT_DIR + 1, files);
    }

    function init3() external override accept {
        INodeS[] files = _files(["ping", "pwd", "uname", "whoami"], [
        _insert_lines("ping", "send a request to network hosts", "[-dDfhLnqUv] {destination}", "Elicit a response from a host.",
            "Dnqv", 0, M, ["print timestamps",
            "no dns name resolution",
            "quiet output",
            "verbose output"]),
        _insert_lines("pwd", "print name of the working directory", "[OPTION]...", "Print the full filename of the current working directory.",
            "LP", 0, 0, ["use PWD from environment, even if it contains symlinks",
            "avoid all symlinks"]),
        _insert_lines("uname", "print system information", "[OPTION]...", "Print certain system information.  With no OPTION, same as -s.",
            "asnrvmpio", 0, 0, ["print all information, in the following order, except omit -p and -i if unknown:",
            "print the kernel name",
            "print the network node hostname",
            "print the kernel release",
            "print the kernel version",
            "print the machine hardware name",
            "print the processor type (non-portable)",
            "print the hardware platform (non-portable)",
            "print the operating system"]),
        _insert_lines("whoami", "print effective userid", "[OPTION]...", "Print the user name associated with the current effective user ID. Same as id -un.",
            "", 0, 0, [""])]);

        _add_reg_files(ROOT_DIR + 1, files);
        _sb_exports[0].inode_count = _fs.ic - _sb_exports[0].first_inode;
    }
}