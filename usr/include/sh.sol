pragma ton-solidity >= 0.62.0;

// Information about the current user. */
struct user_info {
    uint16 uid;
    uint16 euid;
    uint16 gid;
    uint16 egid;
    string user_name;
    string shell;
    string home_dir;
}

library sh {
    uint8 constant ALIAS     = 0;
    uint8 constant ARRAYVAR  = 1;
    uint8 constant BINDING   = 2;
    uint8 constant BUILTIN   = 3;
    uint8 constant COMMAND   = 4;
    uint8 constant DIRECTORY = 5;
    uint8 constant DISABLED  = 6;
    uint8 constant ENABLED   = 7;
    uint8 constant EXPORT    = 8;
    uint8 constant FILE      = 9;
    uint8 constant FUNCTION	 = 10;
    uint8 constant GROUP	 = 11;
    uint8 constant HELPTOPIC = 12;
    uint8 constant HOSTNAME  = 13;
    uint8 constant JOB       = 14;
    uint8 constant KEYWORD   = 15;
    uint8 constant RUNNING   = 16;
    uint8 constant SERVICE   = 17;
    uint8 constant SETOPT    = 18;
    uint8 constant SHOPT     = 19;
    uint8 constant SIGNAL    = 20;
    uint8 constant STOPPED   = 21;
    uint8 constant USER      = 22;
    uint8 constant VARIABLE  = 23;
    uint8 constant RESERVED1 = 24;
    uint8 constant OPTSTRING = 25;
    uint8 constant PATHHASH  = 26;
    uint8 constant DIRSTACK  = 27;
    uint8 constant SPECVARS  = 28;
    uint8 constant OPTARGS   = 29;
    uint8 constant NEXTCMD   = 30;
    uint8 constant ERRORSTR  = 31;
    uint8 constant ERRNO     = 32;
    uint8 constant ERRBUILTIN = 33;
    uint8 constant PIPELINE  = 35;
    uint8 constant RESERVED3 = 36;
    uint8 constant LAST      = RESERVED3;

    uint8 constant NONE      = 255;
}