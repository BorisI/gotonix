pragma ton-solidity >= 0.67.0;

struct ucsum { //3 x 2 = 6
	uint16 ndir;   // number of directories
	uint16 nbfree; // number of free blocks
	uint16 nifree; // number of free inodes
}

struct ucg { //12 x 2 + 6 = 30; 30 * 4 = 120
    uint16 cgx;         // we are the cgx'th cylinder group
    ucsum cs;            // cylinder summary information
    uint16 ndblk;       // number of data blocks this cg
    uint16 iusedoff;    // used inode map
    uint16 freeoff;     // free block map
    uint16 niblk;       // number of inode blocks this cg
    uint16 rotor;       // position of last used block
    uint16 irotor;      // position of last used inode
    uint16 nextfreeoff; // next available space
    uint16 initediblk;  // last initialized inode
    uint16 unrefs;      // number of unreferenced inodes
    uint16 space;       // space for cylinder group maps
    uint16 magic;       // magic number
}
struct ufsb {
    uint16 sblkno;	    // offset of super-block in filesys
    uint16 cblkno;	    // offset of cyl-block in filesys
    uint16 iblkno;	    // offset of inode-blocks in filesys
    uint16 dblkno;	    // offset of first data	after cg
    uint16 ncg;		    // number of cylinder groups
	uint16 bsize;		// size of basic blocks in fs
	uint16 maxcontig;	// max number of contiguous blks
    uint16 maxbpg;      // max number of blks per cyl group
    uint16 fsbtodb;     // fsbtodb and dbtofsb shift constant
    uint16 id;          // unique filesystem id
    uint16 sbsize;	    // actual size of super	block
    uint16 cssize;	    // size	of cyl grp summary area
    uint16 cgsize;	    // cylinder group size
    uint16 inosize;	    // inode size
    uint16 desize;	    // directory entry size
	uint16 inopb;		// value of INOPB
    uint16 ipg;         // inodes per group
    ucsum cs;            // cylinder summary information
    uint16 flags;	    // fmod, clean, ronly, fs
	bytes12 fs_fsmnt;	// name mounted on
	bytes8 volname;	    // volume name
	uint32 time;		// last time written
	uint16 size;		// number of blocks in fs
	uint16 dsize;		// number of data blocks in fs
    uint16 magic;		// magic number
}

struct ug {
    ucg g;
    uint16 nino;
    uint16 nblk;
    uint248 inobmp;
    uint248 bbmp;
}

struct ufsd {
	string name;	 // disk name
	uint8 ufs;		 // decimal UFS version
	uint8 fd;		 // raw device file descriptor
	uint32 bsize;	 // device bsize
	uint16 sblock;	 // superblock location
	uint16 si;	     // Superblock summary info // struct fs_summary_info *
	uint16 inoblock; // inode block
	uint16 inomin;	 // low ino, not ino_t for ABI compat
	uint16 inomax;	 // high ino, not ino_t for ABI compat
	uint16 dp;	     // pointer to currently active inode // dinodep
	ufsb fs;	     // filesystem information
	ug cg;		     // cylinder group
	uint16 ccg;		 // current cylinder group
	uint16 lcg;		 // last cylinder group (in d_cg)
	string error;	 // human readable disk error
	uint16 sblockloc;// where to look for the superblock
	uint8 lookupflags;// flags to superblock lookup
	uint8 mine;		 // internal flags
}

contract istru {

    function libu(ufsd ud, uint8 n) external view returns (ufsd d, mapping (uint32 => TvmCell) res, string out, string cmd) {
    }
}