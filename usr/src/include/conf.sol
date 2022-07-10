pragma ton-solidity >= 0.61.2;

library conf {
    uint16 constant D_TAPE  = 0x0001;
    uint16 constant D_DISK  = 0x0002;
    uint16 constant D_TTY   = 0x0004;
    uint16 constant D_MEM   = 0x0008;
    uint16 constant UID_ROOT    = 0;
    uint16 constant UID_BIN	    = 3;
    uint16 constant UID_UUCP    = 66;
    uint16 constant UID_NOBODY  = 65534;
    uint16 constant GID_WHEEL   = 0;
    uint16 constant GID_KMEM    = 2;
    uint16 constant GID_TTY	    = 4;
    uint16 constant GID_OPERATOR = 5;
    uint16 constant GID_BIN	    = 7;
    uint16 constant GID_GAMES   = 13;
    uint16 constant GID_VIDEO   = 44;
    uint16 constant GID_RT_PRIO = 47;
    uint16 constant GID_ID_PRIO = 48;
    uint16 constant GID_DIALER  = 68;
    uint16 constant GID_NOGROUP = 65533;
    uint16 constant GID_NOBODY  = 65534;
    uint16 constant D_TYPEMASK  = 0xffff;

    uint32 constant	D_TRACKCLOSE = 0x00080000; // track all closes
    uint32 constant	D_MMAP_ANON  = 0x00100000; // special treatment in vm_mmap.c
    uint32 constant	D_GIANTOK    = 0x00200000; // suppress warning about using Giant
    uint32 constant	D_NEEDGIANT  = 0x00400000; // driver want Giant
    uint32 constant	D_NEEDMINOR  = 0x00800000; // driver uses clone_create()


    /*
     * POSIX options and option groups we unconditionally do or don't
     * implement.  This list includes those options which are exclusively
     * implemented (or not) in user mode.  Please keep this list in
     * alphabetical order.
     *
     * Anything which is defined as zero below **must** have an
     * implementation for the corresponding sysconf() which is able to
     * determine conclusively whether or not the feature is supported.
     * Anything which is defined as other than -1 below **must** have
     * complete headers, types, and function declarations as specified by
     * the POSIX standard; however, if the relevant sysconf() function
     * returns -1, the functions may be stubbed out.
     */
    int32 constant _POSIX_BARRIERS                   = 200112;
    int32 constant _POSIX_CPUTIME                    = 200112;
    int32 constant _POSIX_READER_WRITER_LOCKS        = 200112;
    int32 constant _POSIX_REGEXP                     = 1;
    int32 constant _POSIX_SHELL                      = 1;
    int32 constant _POSIX_SPAWN                      = 200112;
    int32 constant _POSIX_SPIN_LOCKS                 = 200112;
    int32 constant _POSIX_THREAD_ATTR_STACKADDR      = 200112;
    int32 constant _POSIX_THREAD_ATTR_STACKSIZE      = 200112;
    int32 constant _POSIX_THREAD_CPUTIME             = 200112;
    int32 constant _POSIX_THREAD_PRIO_INHERIT        = 200112;
    int32 constant _POSIX_THREAD_PRIO_PROTECT        = 200112;
    int32 constant _POSIX_THREAD_PRIORITY_SCHEDULING = 200112;
    int32 constant _POSIX_THREAD_PROCESS_SHARED      = 200112;
    int32 constant _POSIX_THREAD_SAFE_FUNCTIONS      = -1;
    int32 constant _POSIX_THREAD_SPORADIC_SERVER     = -1;
    int32 constant _POSIX_THREADS                    = 200112;
    int32 constant _POSIX_TRACE                      = -1;
    int32 constant _POSIX_TRACE_EVENT_FILTER         = -1;
    int32 constant _POSIX_TRACE_INHERIT              = -1;
    int32 constant _POSIX_TRACE_LOG                  = -1;
    int32 constant _POSIX2_C_BIND                    = 200112; // mandatory
    int32 constant _POSIX2_C_DEV                     = -1;      // need c99 utility
    int32 constant _POSIX2_CHAR_TERM                 = 1;
    int32 constant _POSIX2_FORT_DEV                  = -1;      // need fort77 utility
    int32 constant _POSIX2_FORT_RUN                  = 200112;
    int32 constant _POSIX2_LOCALEDEF                 = -1;
    int32 constant _POSIX2_PBS                       = -1;
    int32 constant _POSIX2_PBS_ACCOUNTING            = -1;
    int32 constant _POSIX2_PBS_CHECKPOINT            = -1;
    int32 constant _POSIX2_PBS_LOCATE                = -1;
    int32 constant _POSIX2_PBS_MESSAGE               = -1;
    int32 constant _POSIX2_PBS_TRACK                 = -1;
    int32 constant _POSIX2_SW_DEV                    = -1;      // XXX ???
    int32 constant _POSIX2_UPE                       = 200112;
    int32 constant _V6_ILP32_OFF32                   = -1;
    int32 constant _V6_ILP32_OFFBIG                  = 0;
    int32 constant _V6_LP64_OFF64                    = 0;
    int32 constant _V6_LPBIG_OFFBIG                  = -1;
    int32 constant _XOPEN_CRYPT                      = -1;      // XXX ???
    int32 constant _XOPEN_ENH_I18N                   = -1;      // mandatory in XSI
    int32 constant _XOPEN_LEGACY                     = -1;
    int32 constant _XOPEN_REALTIME                   = -1;
    int32 constant _XOPEN_REALTIME_THREADS           = -1;
    int32 constant _XOPEN_UNIX                       = -1;
    // Define the POSIX.2 version we target for compliance.
    int32 constant _POSIX2_VERSION = 199212;
/* configurable pathname variables */
    uint8 constant _PC_LINK_MAX		    = 1;
    uint8 constant _PC_MAX_CANON		= 2;
    uint8 constant _PC_MAX_INPUT		= 3;
    uint8 constant _PC_NAME_MAX		    = 4;
    uint8 constant _PC_PATH_MAX		    = 5;
    uint8 constant _PC_PIPE_BUF		    = 6;
    uint8 constant _PC_CHOWN_RESTRICTED	= 7;
    uint8 constant _PC_NO_TRUNC		    = 8;
    uint8 constant _PC_VDISABLE		    = 9;
    uint8 constant _PC_ASYNC_IO	= 53;
    uint8 constant _PC_PRIO_IO	= 54;
    uint8 constant _PC_SYNC_IO	= 55;
    uint8 constant _PC_ALLOC_SIZE_MIN	  = 10;
    uint8 constant _PC_FILESIZEBITS	      = 12;
    uint8 constant _PC_REC_INCR_XFER_SIZE = 14;
    uint8 constant _PC_REC_MAX_XFER_SIZE  = 15;
    uint8 constant _PC_REC_MIN_XFER_SIZE  = 16;
    uint8 constant _PC_REC_XFER_ALIGN	  = 17;
    uint8 constant _PC_SYMLINK_MAX		  = 18;
    uint8 constant _PC_ACL_EXTENDED = 59;
    uint8 constant _PC_ACL_PATH_MAX = 60;
    uint8 constant _PC_CAP_PRESENT	= 61;
    uint8 constant _PC_INF_PRESENT	= 62;
    uint8 constant _PC_MAC_PRESENT	= 63;
    uint8 constant _PC_ACL_NFS4	    = 64;
    uint8 constant _PC_MIN_HOLE_SIZE = 21;
    /*
     * POSIX-style system configuration variable accessors (for the
     * sysconf function).  The kernel does not directly implement the
     * sysconf() interface; rather, a C library stub translates references
     * to sysconf() into calls to sysctl() using a giant switch statement.
     * Those that are marked `user' are implemented entirely in the C
     * library and never query the kernel.  pathconf() is implemented
     * directly by the kernel so those are not defined here.
     */
    uint8 constant _SC_ARG_MAX              =  1;
    uint8 constant _SC_CHILD_MAX            =  2;
    uint8 constant _SC_CLK_TCK              =  3;
    uint8 constant _SC_NGROUPS_MAX          =  4;
    uint8 constant _SC_OPEN_MAX             =  5;
    uint8 constant _SC_JOB_CONTROL          =  6;
    uint8 constant _SC_SAVED_IDS            =  7;
    uint8 constant _SC_VERSION              =  8;
    uint8 constant _SC_BC_BASE_MAX          =  9; /* user */
    uint8 constant _SC_BC_DIM_MAX           = 10; /* user */
    uint8 constant _SC_BC_SCALE_MAX         = 11; /* user */
    uint8 constant _SC_BC_STRING_MAX        = 12; /* user */
    uint8 constant _SC_COLL_WEIGHTS_MAX     = 13; /* user */
    uint8 constant _SC_EXPR_NEST_MAX        = 14; /* user */
    uint8 constant _SC_LINE_MAX             = 15; /* user */
    uint8 constant _SC_RE_DUP_MAX           = 16; /* user */
    uint8 constant _SC_2_VERSION            = 17; /* user */
    uint8 constant _SC_2_C_BIND             = 18; /* user */
    uint8 constant _SC_2_C_DEV              = 19; /* user */
    uint8 constant _SC_2_CHAR_TERM          = 20; /* user */
    uint8 constant _SC_2_FORT_DEV           = 21; /* user */
    uint8 constant _SC_2_FORT_RUN           = 22; /* user */
    uint8 constant _SC_2_LOCALEDEF          = 23; /* user */
    uint8 constant _SC_2_SW_DEV             = 24; /* user */
    uint8 constant _SC_2_UPE                = 25; /* user */
    uint8 constant _SC_STREAM_MAX           = 26; /* user */
    uint8 constant _SC_TZNAME_MAX           = 27; /* user */
    uint8 constant _SC_ASYNCHRONOUS_IO      = 28;
    uint8 constant _SC_MAPPED_FILES         = 29;
    uint8 constant _SC_MEMLOCK              = 30;
    uint8 constant _SC_MEMLOCK_RANGE        = 31;
    uint8 constant _SC_MEMORY_PROTECTION    = 32;
    uint8 constant _SC_MESSAGE_PASSING      = 33;
    uint8 constant _SC_PRIORITIZED_IO       = 34;
    uint8 constant _SC_PRIORITY_SCHEDULING  = 35;
    uint8 constant _SC_REALTIME_SIGNALS     = 36;
    uint8 constant _SC_SEMAPHORES           = 37;
    uint8 constant _SC_FSYNC                = 38;
    uint8 constant _SC_SHARED_MEMORY_OBJECTS  = 39;
    uint8 constant _SC_SYNCHRONIZED_IO      = 40;
    uint8 constant _SC_TIMERS               = 41;
    uint8 constant _SC_AIO_LISTIO_MAX       = 42;
    uint8 constant _SC_AIO_MAX              = 43;
    uint8 constant _SC_AIO_PRIO_DELTA_MAX   = 44;
    uint8 constant _SC_DELAYTIMER_MAX       = 45;
    uint8 constant _SC_MQ_OPEN_MAX          = 46;
    uint8 constant _SC_PAGESIZE             = 47;
    uint8 constant _SC_RTSIG_MAX            = 48;
    uint8 constant _SC_SEM_NSEMS_MAX        = 49;
    uint8 constant _SC_SEM_VALUE_MAX        = 50;
    uint8 constant _SC_SIGQUEUE_MAX         = 51;
    uint8 constant _SC_TIMER_MAX            = 52;
    uint8 constant _SC_2_PBS                = 59; /* user */
    uint8 constant _SC_2_PBS_ACCOUNTING     = 60; /* user */
    uint8 constant _SC_2_PBS_CHECKPOINT     = 61; /* user */
    uint8 constant _SC_2_PBS_LOCATE         = 62; /* user */
    uint8 constant _SC_2_PBS_MESSAGE        = 63; /* user */
    uint8 constant _SC_2_PBS_TRACK          = 64; /* user */
    uint8 constant _SC_ADVISORY_INFO        = 65;
    uint8 constant _SC_BARRIERS             = 66; /* user */
    uint8 constant _SC_CLOCK_SELECTION      = 67;
    uint8 constant _SC_CPUTIME              = 68;
    uint8 constant _SC_FILE_LOCKING         = 69;
    uint8 constant _SC_GETGR_R_SIZE_MAX     = 70; /* user */
    uint8 constant _SC_GETPW_R_SIZE_MAX     = 71; /* user */
    uint8 constant _SC_HOST_NAME_MAX        = 72;
    uint8 constant _SC_LOGIN_NAME_MAX       = 73;
    uint8 constant _SC_MONOTONIC_CLOCK      = 74;
    uint8 constant _SC_MQ_PRIO_MAX          = 75;
    uint8 constant _SC_READER_WRITER_LOCKS  = 76; /* user */
    uint8 constant _SC_REGEXP               = 77; /* user */
    uint8 constant _SC_SHELL                = 78; /* user */
    uint8 constant _SC_SPAWN                = 79; /* user */
    uint8 constant _SC_SPIN_LOCKS           = 80; /* user */
    uint8 constant _SC_SPORADIC_SERVER      = 81;
    uint8 constant _SC_THREAD_ATTR_STACKADDR  = 82; /* user */
    uint8 constant _SC_THREAD_ATTR_STACKSIZE  = 83; /* user */
    uint8 constant _SC_THREAD_CPUTIME       = 84; /* user */
    uint8 constant _SC_THREAD_DESTRUCTOR_ITERATIONS  = 85; /* user */
    uint8 constant _SC_THREAD_KEYS_MAX      = 86; /* user */
    uint8 constant _SC_THREAD_PRIO_INHERIT  = 87; /* user */
    uint8 constant _SC_THREAD_PRIO_PROTECT  = 88; /* user */
    uint8 constant _SC_THREAD_PRIORITY_SCHEDULING  = 89; /* user */
    uint8 constant _SC_THREAD_PROCESS_SHARED  = 90; /* user */
    uint8 constant _SC_THREAD_SAFE_FUNCTIONS  = 91; /* user */
    uint8 constant _SC_THREAD_SPORADIC_SERVER  = 92; /* user */
    uint8 constant _SC_THREAD_STACK_MIN     = 93; /* user */
    uint8 constant _SC_THREAD_THREADS_MAX   = 94; /* user */
    uint8 constant _SC_TIMEOUTS             = 95; /* user */
    uint8 constant _SC_THREADS              = 96; /* user */
    uint8 constant _SC_TRACE                = 97; /* user */
    uint8 constant _SC_TRACE_EVENT_FILTER   = 98; /* user */
    uint8 constant _SC_TRACE_INHERIT        = 99; /* user */
    uint8 constant _SC_TRACE_LOG            = 100; /* user */
    uint8 constant _SC_TTY_NAME_MAX         = 101; /* user */
    uint8 constant _SC_TYPED_MEMORY_OBJECTS = 102;
    uint8 constant _SC_V6_ILP32_OFF32       = 103; /* user */
    uint8 constant _SC_V6_ILP32_OFFBIG      = 104; /* user */
    uint8 constant _SC_V6_LP64_OFF64        = 105; /* user */
    uint8 constant _SC_V6_LPBIG_OFFBIG      = 106; /* user */
    uint8 constant _SC_IPV6                 = 118;
    uint8 constant _SC_RAW_SOCKETS          = 119;
    uint8 constant _SC_SYMLOOP_MAX          = 120;
    uint8 constant _SC_ATEXIT_MAX           = 107; /* user */
    uint8 constant _SC_IOV_MAX              = 56;
    uint8 constant _SC_PAGE_SIZE            = _SC_PAGESIZE;
    uint8 constant _SC_XOPEN_CRYPT          = 108; /* user */
    uint8 constant _SC_XOPEN_ENH_I18N       = 109; /* user */
    uint8 constant _SC_XOPEN_LEGACY         = 110; /* user */
    uint8 constant _SC_XOPEN_REALTIME       = 111;
    uint8 constant _SC_XOPEN_REALTIME_THREADS = 112;
    uint8 constant _SC_XOPEN_SHM            = 113;
    uint8 constant _SC_XOPEN_STREAMS        = 114;
    uint8 constant _SC_XOPEN_UNIX           = 115;
    uint8 constant _SC_XOPEN_VERSION        = 116;
    uint8 constant _SC_XOPEN_XCU_VERSION    = 117; /* user */
    uint8 constant _SC_NPROCESSORS_CONF     = 57;
    uint8 constant _SC_NPROCESSORS_ONLN     = 58;
    uint8 constant _SC_CPUSET_SIZE          = 122;
    uint8 constant _SC_PHYS_PAGES           = 121; // Extensions found in Solaris and Linux.
    // Keys for the confstr(3) function.
    uint8 constant _CS_PATH                           = 1;   //  default value of PATH
    uint8 constant _CS_POSIX_V6_ILP32_OFF32_CFLAGS    = 2;
    uint8 constant _CS_POSIX_V6_ILP32_OFF32_LDFLAGS   = 3;
    uint8 constant _CS_POSIX_V6_ILP32_OFF32_LIBS      = 4;
    uint8 constant _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS   = 5;
    uint8 constant _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS  = 6;
    uint8 constant _CS_POSIX_V6_ILP32_OFFBIG_LIBS     = 7;
    uint8 constant _CS_POSIX_V6_LP64_OFF64_CFLAGS     = 8;
    uint8 constant _CS_POSIX_V6_LP64_OFF64_LDFLAGS    = 9;
    uint8 constant _CS_POSIX_V6_LP64_OFF64_LIBS       = 10;
    uint8 constant _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS   = 11;
    uint8 constant _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS  = 12;
    uint8 constant _CS_POSIX_V6_LPBIG_OFFBIG_LIBS     = 13;
    uint8 constant _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS = 14;
}