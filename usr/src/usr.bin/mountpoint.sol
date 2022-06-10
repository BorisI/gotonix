pragma ton-solidity >= 0.61.0;

import "Utility.sol";

contract mountpoint is Utility {

    function main(s_proc p_in, mapping (uint16 => Inode) inodes, mapping (uint16 => bytes) data) external pure returns (s_proc p) {
        p = p_in;
        string[] params = p.params();
        bool mounted_device = p.flag_set("d");
        bool quiet = p.flag_set("q");
        bool arg_device = p.flag_set("x");
        string out;
        string spath = params[0];
        uint16 wd = p.get_cwd();
        (uint16 index, uint8 t, , ) = fs.resolve_relative_path(spath, wd, inodes, data);
        if (arg_device) {
            if (t != ft.FT_BLKDEV)
                p.perror("not_a_block_device " + spath);
            else {
                (string major_id, string minor_id) = inode.get_device_version(inodes[index].device_id);
                out = major_id + ":" + minor_id;
            }
        }

        string text;
        text = fs.get_file_contents_at_path("/etc/fstab", inodes, data);
        text.append(fs.get_file_contents_at_path("/etc/mtab", inodes, data));

        DirEntry[] device_list = _list_devices(inodes, data);

        (string[] tab_lines, ) = text.split("\n");
        for (string line: tab_lines) {
            (string[] fields, uint n_fields) = line.split("\t");
            if (n_fields > 3) {
                if (fields[1] == spath) {
                    for (DirEntry de: device_list) {
                        if (de.file_name == fields[0]) {
                            (string major_id, string minor_id) = inode.get_device_version(inodes[de.index].device_id);
                            out.append(mounted_device ? format("{}:{}", major_id, minor_id) : (spath + " is a mountpoint"));
                        }
                    }
                }
            }
        }

        str.aif(out, out.empty(), spath + " is not a mountpoint");
        if (!quiet)
            p.puts(out);
    }

    function _list_devices(mapping (uint16 => Inode) inodes, mapping (uint16 => bytes) data) internal pure returns (DirEntry[] device_list) {
        uint16 dev_dir = fs.resolve_absolute_path("/dev", inodes, data);
        (DirEntry[] contents, int16 status) = udirent.read_dir(inodes[dev_dir], data[dev_dir]);
        if (status >= 0) {
            for (DirEntry de: contents)
                if (de.file_type == ft.FT_BLKDEV || de.file_type == ft.FT_CHRDEV)
                    device_list.push(de);
        }
    }

    function _command_help() internal override pure returns (CommandHelp) {
        return CommandHelp(
"mountpoint",
"[-d|-q] directory | file\t-x device",
"see if a directory or file is a mountpoint",
"Checks whether the given directory or file is mentioned in the /proc/self/mountinfo file.",
"-d      quiet mode - don't print anything\n\
-q      print maj:min device number of the filesystem\n\
-x      print maj:min device number of the block device",
"",
"Written by Boris",
"",
"",
"0.02");
    }

}
