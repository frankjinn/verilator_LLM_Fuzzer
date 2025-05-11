/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_VERILOG_PRETMP_H_INCLUDED
# define YY_YY_VERILOG_PRETMP_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    yaFLOATNUM = 258,              /* "FLOATING-POINT NUMBER"  */
    yaID__ETC = 259,               /* "IDENTIFIER"  */
    yaID__CC = 260,                /* "IDENTIFIER-::"  */
    yaID__LEX = 261,               /* "IDENTIFIER-in-lex"  */
    yaID__aCELL = 262,             /* "IDENTIFIER-for-cell"  */
    yaID__aTYPE = 263,             /* "IDENTIFIER-for-type"  */
    yaINTNUM = 264,                /* "INTEGER NUMBER"  */
    yaTIMENUM = 265,               /* "TIME NUMBER"  */
    yaSTRING = 266,                /* "STRING"  */
    yaSTRING__IGNORE = 267,        /* "STRING-ignored"  */
    yaTIMINGSPEC = 268,            /* "TIMING SPEC ELEMENT"  */
    ygenSTRENGTH = 269,            /* "STRENGTH keyword (strong1/etc)"  */
    yaTABLELINE = 270,             /* "TABLE LINE"  */
    yaSCHDR = 271,                 /* "`systemc_header BLOCK"  */
    yaSCINT = 272,                 /* "`systemc_ctor BLOCK"  */
    yaSCIMP = 273,                 /* "`systemc_dtor BLOCK"  */
    yaSCIMPH = 274,                /* "`systemc_interface BLOCK"  */
    yaSCCTOR = 275,                /* "`systemc_implementation BLOCK"  */
    yaSCDTOR = 276,                /* "`systemc_imp_header BLOCK"  */
    yVLT_CLOCKER = 277,            /* "clocker"  */
    yVLT_CLOCK_ENABLE = 278,       /* "clock_enable"  */
    yVLT_COVERAGE_BLOCK_OFF = 279, /* "coverage_block_off"  */
    yVLT_COVERAGE_OFF = 280,       /* "coverage_off"  */
    yVLT_COVERAGE_ON = 281,        /* "coverage_on"  */
    yVLT_FORCEABLE = 282,          /* "forceable"  */
    yVLT_FULL_CASE = 283,          /* "full_case"  */
    yVLT_HIER_BLOCK = 284,         /* "hier_block"  */
    yVLT_HIER_PARAMS = 285,        /* "hier_params"  */
    yVLT_INLINE = 286,             /* "inline"  */
    yVLT_ISOLATE_ASSIGNMENTS = 287, /* "isolate_assignments"  */
    yVLT_LINT_OFF = 288,           /* "lint_off"  */
    yVLT_LINT_ON = 289,            /* "lint_on"  */
    yVLT_NO_CLOCKER = 290,         /* "no_clocker"  */
    yVLT_NO_INLINE = 291,          /* "no_inline"  */
    yVLT_PARALLEL_CASE = 292,      /* "parallel_case"  */
    yVLT_PROFILE_DATA = 293,       /* "profile_data"  */
    yVLT_PUBLIC = 294,             /* "public"  */
    yVLT_PUBLIC_FLAT = 295,        /* "public_flat"  */
    yVLT_PUBLIC_FLAT_RD = 296,     /* "public_flat_rd"  */
    yVLT_PUBLIC_FLAT_RW = 297,     /* "public_flat_rw"  */
    yVLT_PUBLIC_MODULE = 298,      /* "public_module"  */
    yVLT_SC_BV = 299,              /* "sc_bv"  */
    yVLT_SFORMAT = 300,            /* "sformat"  */
    yVLT_SPLIT_VAR = 301,          /* "split_var"  */
    yVLT_TIMING_OFF = 302,         /* "timing_off"  */
    yVLT_TIMING_ON = 303,          /* "timing_on"  */
    yVLT_TRACING_OFF = 304,        /* "tracing_off"  */
    yVLT_TRACING_ON = 305,         /* "tracing_on"  */
    yVLT_D_BLOCK = 306,            /* "--block"  */
    yVLT_D_CONTENTS = 307,         /* "--contents"  */
    yVLT_D_COST = 308,             /* "--cost"  */
    yVLT_D_FILE = 309,             /* "--file"  */
    yVLT_D_FUNCTION = 310,         /* "--function"  */
    yVLT_D_HIER_DPI = 311,         /* "--hier-dpi"  */
    yVLT_D_LEVELS = 312,           /* "--levels"  */
    yVLT_D_LINES = 313,            /* "--lines"  */
    yVLT_D_MATCH = 314,            /* "--match"  */
    yVLT_D_MODEL = 315,            /* "--model"  */
    yVLT_D_MODULE = 316,           /* "--module"  */
    yVLT_D_MTASK = 317,            /* "--mtask"  */
    yVLT_D_RULE = 318,             /* "--rule"  */
    yVLT_D_SCOPE = 319,            /* "--scope"  */
    yVLT_D_TASK = 320,             /* "--task"  */
    yVLT_D_VAR = 321,              /* "--var"  */
    yaD_PLI = 322,                 /* "${pli-system}"  */
    yaT_NOUNCONNECTED = 323,       /* "`nounconnecteddrive"  */
    yaT_RESETALL = 324,            /* "`resetall"  */
    yaT_UNCONNECTED_PULL0 = 325,   /* "`unconnected_drive pull0"  */
    yaT_UNCONNECTED_PULL1 = 326,   /* "`unconnected_drive pull1"  */
    ya1STEP = 327,                 /* "1step"  */
    yACCEPT_ON = 328,              /* "accept_on"  */
    yALIAS = 329,                  /* "alias"  */
    yALWAYS = 330,                 /* "always"  */
    yALWAYS_COMB = 331,            /* "always_comb"  */
    yALWAYS_FF = 332,              /* "always_ff"  */
    yALWAYS_LATCH = 333,           /* "always_latch"  */
    yAND = 334,                    /* "and"  */
    yASSERT = 335,                 /* "assert"  */
    yASSIGN = 336,                 /* "assign"  */
    yASSUME = 337,                 /* "assume"  */
    yAUTOMATIC = 338,              /* "automatic"  */
    yBEFORE = 339,                 /* "before"  */
    yBEGIN = 340,                  /* "begin"  */
    yBIND = 341,                   /* "bind"  */
    yBINS = 342,                   /* "bins"  */
    yBINSOF = 343,                 /* "binsof"  */
    yBIT = 344,                    /* "bit"  */
    yBREAK = 345,                  /* "break"  */
    yBUF = 346,                    /* "buf"  */
    yBUFIF0 = 347,                 /* "bufif0"  */
    yBUFIF1 = 348,                 /* "bufif1"  */
    yBYTE = 349,                   /* "byte"  */
    yCASE = 350,                   /* "case"  */
    yCASEX = 351,                  /* "casex"  */
    yCASEZ = 352,                  /* "casez"  */
    yCHANDLE = 353,                /* "chandle"  */
    yCHECKER = 354,                /* "checker"  */
    yCLASS = 355,                  /* "class"  */
    yCLOCKING = 356,               /* "clocking"  */
    yCMOS = 357,                   /* "cmos"  */
    yCONSTRAINT = 358,             /* "constraint"  */
    yCONST__ETC = 359,             /* "const"  */
    yCONST__LEX = 360,             /* "const-in-lex"  */
    yCONST__REF = 361,             /* "const-then-ref"  */
    yCONTEXT = 362,                /* "context"  */
    yCONTINUE = 363,               /* "continue"  */
    yCOVER = 364,                  /* "cover"  */
    yCOVERGROUP = 365,             /* "covergroup"  */
    yCOVERPOINT = 366,             /* "coverpoint"  */
    yCROSS = 367,                  /* "cross"  */
    yDEASSIGN = 368,               /* "deassign"  */
    yDEFAULT = 369,                /* "default"  */
    yDEFPARAM = 370,               /* "defparam"  */
    yDISABLE = 371,                /* "disable"  */
    yDIST = 372,                   /* "dist"  */
    yDO = 373,                     /* "do"  */
    yEDGE = 374,                   /* "edge"  */
    yELSE = 375,                   /* "else"  */
    yEND = 376,                    /* "end"  */
    yENDCASE = 377,                /* "endcase"  */
    yENDCHECKER = 378,             /* "endchecker"  */
    yENDCLASS = 379,               /* "endclass"  */
    yENDCLOCKING = 380,            /* "endclocking"  */
    yENDFUNCTION = 381,            /* "endfunction"  */
    yENDGENERATE = 382,            /* "endgenerate"  */
    yENDGROUP = 383,               /* "endgroup"  */
    yENDINTERFACE = 384,           /* "endinterface"  */
    yENDMODULE = 385,              /* "endmodule"  */
    yENDPACKAGE = 386,             /* "endpackage"  */
    yENDPRIMITIVE = 387,           /* "endprimitive"  */
    yENDPROGRAM = 388,             /* "endprogram"  */
    yENDPROPERTY = 389,            /* "endproperty"  */
    yENDSEQUENCE = 390,            /* "endsequence"  */
    yENDSPECIFY = 391,             /* "endspecify"  */
    yENDTABLE = 392,               /* "endtable"  */
    yENDTASK = 393,                /* "endtask"  */
    yENUM = 394,                   /* "enum"  */
    yEVENT = 395,                  /* "event"  */
    yEVENTUALLY = 396,             /* "eventually"  */
    yEXPECT = 397,                 /* "expect"  */
    yEXPORT = 398,                 /* "export"  */
    yEXTENDS = 399,                /* "extends"  */
    yEXTERN = 400,                 /* "extern"  */
    yFINAL = 401,                  /* "final"  */
    yFIRST_MATCH = 402,            /* "first_match"  */
    yFOR = 403,                    /* "for"  */
    yFORCE = 404,                  /* "force"  */
    yFOREACH = 405,                /* "foreach"  */
    yFOREVER = 406,                /* "forever"  */
    yFORK = 407,                   /* "fork"  */
    yFORKJOIN = 408,               /* "forkjoin"  */
    yFUNCTION = 409,               /* "function"  */
    yGENERATE = 410,               /* "generate"  */
    yGENVAR = 411,                 /* "genvar"  */
    yGLOBAL__CLOCKING = 412,       /* "global-then-clocking"  */
    yGLOBAL__ETC = 413,            /* "global"  */
    yGLOBAL__LEX = 414,            /* "global-in-lex"  */
    yHIGHZ0 = 415,                 /* "highz0"  */
    yHIGHZ1 = 416,                 /* "highz1"  */
    yIF = 417,                     /* "if"  */
    yIFF = 418,                    /* "iff"  */
    yIGNORE_BINS = 419,            /* "ignore_bins"  */
    yILLEGAL_BINS = 420,           /* "illegal_bins"  */
    yIMPLEMENTS = 421,             /* "implements"  */
    yIMPLIES = 422,                /* "implies"  */
    yIMPORT = 423,                 /* "import"  */
    yINITIAL = 424,                /* "initial"  */
    yINOUT = 425,                  /* "inout"  */
    yINPUT = 426,                  /* "input"  */
    yINSIDE = 427,                 /* "inside"  */
    yINT = 428,                    /* "int"  */
    yINTEGER = 429,                /* "integer"  */
    yINTERCONNECT = 430,           /* "interconnect"  */
    yINTERFACE = 431,              /* "interface"  */
    yINTERSECT = 432,              /* "intersect"  */
    yJOIN = 433,                   /* "join"  */
    yJOIN_ANY = 434,               /* "join_any"  */
    yJOIN_NONE = 435,              /* "join_none"  */
    yLET = 436,                    /* "let"  */
    yLOCALPARAM = 437,             /* "localparam"  */
    yLOCAL__COLONCOLON = 438,      /* "local-then-::"  */
    yLOCAL__ETC = 439,             /* "local"  */
    yLOCAL__LEX = 440,             /* "local-in-lex"  */
    yLOGIC = 441,                  /* "logic"  */
    yLONGINT = 442,                /* "longint"  */
    yMATCHES = 443,                /* "matches"  */
    yMODPORT = 444,                /* "modport"  */
    yMODULE = 445,                 /* "module"  */
    yNAND = 446,                   /* "nand"  */
    yNEGEDGE = 447,                /* "negedge"  */
    yNETTYPE = 448,                /* "nettype"  */
    yNEW__ETC = 449,               /* "new"  */
    yNEW__LEX = 450,               /* "new-in-lex"  */
    yNEW__PAREN = 451,             /* "new-then-paren"  */
    yNEXTTIME = 452,               /* "nexttime"  */
    yNMOS = 453,                   /* "nmos"  */
    yNOR = 454,                    /* "nor"  */
    yNOT = 455,                    /* "not"  */
    yNOTIF0 = 456,                 /* "notif0"  */
    yNOTIF1 = 457,                 /* "notif1"  */
    yNULL = 458,                   /* "null"  */
    yOR = 459,                     /* "or"  */
    yOUTPUT = 460,                 /* "output"  */
    yPACKAGE = 461,                /* "package"  */
    yPACKED = 462,                 /* "packed"  */
    yPARAMETER = 463,              /* "parameter"  */
    yPMOS = 464,                   /* "pmos"  */
    yPOSEDGE = 465,                /* "posedge"  */
    yPRIMITIVE = 466,              /* "primitive"  */
    yPRIORITY = 467,               /* "priority"  */
    yPROGRAM = 468,                /* "program"  */
    yPROPERTY = 469,               /* "property"  */
    yPROTECTED = 470,              /* "protected"  */
    yPULL0 = 471,                  /* "pull0"  */
    yPULL1 = 472,                  /* "pull1"  */
    yPULLDOWN = 473,               /* "pulldown"  */
    yPULLUP = 474,                 /* "pullup"  */
    yPURE = 475,                   /* "pure"  */
    yRAND = 476,                   /* "rand"  */
    yRANDC = 477,                  /* "randc"  */
    yRANDCASE = 478,               /* "randcase"  */
    yRANDOMIZE = 479,              /* "randomize"  */
    yRANDSEQUENCE = 480,           /* "randsequence"  */
    yRCMOS = 481,                  /* "rcmos"  */
    yREAL = 482,                   /* "real"  */
    yREALTIME = 483,               /* "realtime"  */
    yREF = 484,                    /* "ref"  */
    yREG = 485,                    /* "reg"  */
    yREJECT_ON = 486,              /* "reject_on"  */
    yRELEASE = 487,                /* "release"  */
    yREPEAT = 488,                 /* "repeat"  */
    yRESTRICT = 489,               /* "restrict"  */
    yRETURN = 490,                 /* "return"  */
    yRNMOS = 491,                  /* "rnmos"  */
    yRPMOS = 492,                  /* "rpmos"  */
    yRTRAN = 493,                  /* "rtran"  */
    yRTRANIF0 = 494,               /* "rtranif0"  */
    yRTRANIF1 = 495,               /* "rtranif1"  */
    ySCALARED = 496,               /* "scalared"  */
    ySEQUENCE = 497,               /* "sequence"  */
    ySHORTINT = 498,               /* "shortint"  */
    ySHORTREAL = 499,              /* "shortreal"  */
    ySIGNED = 500,                 /* "signed"  */
    ySOFT = 501,                   /* "soft"  */
    ySOLVE = 502,                  /* "solve"  */
    ySPECIFY = 503,                /* "specify"  */
    ySPECPARAM = 504,              /* "specparam"  */
    ySTATIC__CONSTRAINT = 505,     /* "static-then-constraint"  */
    ySTATIC__ETC = 506,            /* "static"  */
    ySTATIC__LEX = 507,            /* "static-in-lex"  */
    ySTRING = 508,                 /* "string"  */
    ySTRONG = 509,                 /* "strong"  */
    ySTRONG0 = 510,                /* "strong0"  */
    ySTRONG1 = 511,                /* "strong1"  */
    ySTRUCT = 512,                 /* "struct"  */
    ySUPER = 513,                  /* "super"  */
    ySUPPLY0 = 514,                /* "supply0"  */
    ySUPPLY1 = 515,                /* "supply1"  */
    ySYNC_ACCEPT_ON = 516,         /* "sync_accept_on"  */
    ySYNC_REJECT_ON = 517,         /* "sync_reject_on"  */
    yS_ALWAYS = 518,               /* "s_always"  */
    yS_EVENTUALLY = 519,           /* "s_eventually"  */
    yS_NEXTTIME = 520,             /* "s_nexttime"  */
    yS_UNTIL = 521,                /* "s_until"  */
    yS_UNTIL_WITH = 522,           /* "s_until_with"  */
    yTABLE = 523,                  /* "table"  */
    yTASK = 524,                   /* "task"  */
    yTHIS = 525,                   /* "this"  */
    yTHROUGHOUT = 526,             /* "throughout"  */
    yTIME = 527,                   /* "time"  */
    yTIMEPRECISION = 528,          /* "timeprecision"  */
    yTIMEUNIT = 529,               /* "timeunit"  */
    yTRAN = 530,                   /* "tran"  */
    yTRANIF0 = 531,                /* "tranif0"  */
    yTRANIF1 = 532,                /* "tranif1"  */
    yTRI = 533,                    /* "tri"  */
    yTRI0 = 534,                   /* "tri0"  */
    yTRI1 = 535,                   /* "tri1"  */
    yTRIAND = 536,                 /* "triand"  */
    yTRIOR = 537,                  /* "trior"  */
    yTRIREG = 538,                 /* "trireg"  */
    yTRUE = 539,                   /* "true"  */
    yTYPEDEF = 540,                /* "typedef"  */
    yTYPE__EQ = 541,               /* "type-then-eqneq"  */
    yTYPE__ETC = 542,              /* "type"  */
    yTYPE__LEX = 543,              /* "type-in-lex"  */
    yUNION = 544,                  /* "union"  */
    yUNIQUE = 545,                 /* "unique"  */
    yUNIQUE0 = 546,                /* "unique0"  */
    yUNSIGNED = 547,               /* "unsigned"  */
    yUNTIL = 548,                  /* "until"  */
    yUNTIL_WITH = 549,             /* "until_with"  */
    yUNTYPED = 550,                /* "untyped"  */
    yVAR = 551,                    /* "var"  */
    yVECTORED = 552,               /* "vectored"  */
    yVIRTUAL__CLASS = 553,         /* "virtual-then-class"  */
    yVIRTUAL__ETC = 554,           /* "virtual"  */
    yVIRTUAL__INTERFACE = 555,     /* "virtual-then-interface"  */
    yVIRTUAL__LEX = 556,           /* "virtual-in-lex"  */
    yVIRTUAL__anyID = 557,         /* "virtual-then-identifier"  */
    yVOID = 558,                   /* "void"  */
    yWAIT = 559,                   /* "wait"  */
    yWAIT_ORDER = 560,             /* "wait_order"  */
    yWAND = 561,                   /* "wand"  */
    yWEAK = 562,                   /* "weak"  */
    yWEAK0 = 563,                  /* "weak0"  */
    yWEAK1 = 564,                  /* "weak1"  */
    yWHILE = 565,                  /* "while"  */
    yWILDCARD = 566,               /* "wildcard"  */
    yWIRE = 567,                   /* "wire"  */
    yWITHIN = 568,                 /* "within"  */
    yWITH__BRA = 569,              /* "with-then-["  */
    yWITH__CUR = 570,              /* "with-then-{"  */
    yWITH__ETC = 571,              /* "with"  */
    yWITH__LEX = 572,              /* "with-in-lex"  */
    yWITH__PAREN = 573,            /* "with-then-("  */
    yWOR = 574,                    /* "wor"  */
    yWREAL = 575,                  /* "wreal"  */
    yXNOR = 576,                   /* "xnor"  */
    yXOR = 577,                    /* "xor"  */
    yD_ACOS = 578,                 /* "$acos"  */
    yD_ACOSH = 579,                /* "$acosh"  */
    yD_ASIN = 580,                 /* "$asin"  */
    yD_ASINH = 581,                /* "$asinh"  */
    yD_ASSERTCTL = 582,            /* "$assertcontrol"  */
    yD_ASSERTKILL = 583,           /* "$assertkill"  */
    yD_ASSERTOFF = 584,            /* "$assertoff"  */
    yD_ASSERTON = 585,             /* "$asserton"  */
    yD_ATAN = 586,                 /* "$atan"  */
    yD_ATAN2 = 587,                /* "$atan2"  */
    yD_ATANH = 588,                /* "$atanh"  */
    yD_BITS = 589,                 /* "$bits"  */
    yD_BITSTOREAL = 590,           /* "$bitstoreal"  */
    yD_BITSTOSHORTREAL = 591,      /* "$bitstoshortreal"  */
    yD_C = 592,                    /* "$c"  */
    yD_CAST = 593,                 /* "$cast"  */
    yD_CEIL = 594,                 /* "$ceil"  */
    yD_CHANGED = 595,              /* "$changed"  */
    yD_CHANGED_GCLK = 596,         /* "$changed_gclk"  */
    yD_CLOG2 = 597,                /* "$clog2"  */
    yD_COS = 598,                  /* "$cos"  */
    yD_COSH = 599,                 /* "$cosh"  */
    yD_COUNTBITS = 600,            /* "$countbits"  */
    yD_COUNTONES = 601,            /* "$countones"  */
    yD_DIMENSIONS = 602,           /* "$dimensions"  */
    yD_DISPLAY = 603,              /* "$display"  */
    yD_DISPLAYB = 604,             /* "$displayb"  */
    yD_DISPLAYH = 605,             /* "$displayh"  */
    yD_DISPLAYO = 606,             /* "$displayo"  */
    yD_DIST_CHI_SQUARE = 607,      /* "$dist_chi_square"  */
    yD_DIST_ERLANG = 608,          /* "$dist_erlang"  */
    yD_DIST_EXPONENTIAL = 609,     /* "$dist_exponential"  */
    yD_DIST_NORMAL = 610,          /* "$dist_normal"  */
    yD_DIST_POISSON = 611,         /* "$dist_poisson"  */
    yD_DIST_T = 612,               /* "$dist_t"  */
    yD_DIST_UNIFORM = 613,         /* "$dist_uniform"  */
    yD_DUMPALL = 614,              /* "$dumpall"  */
    yD_DUMPFILE = 615,             /* "$dumpfile"  */
    yD_DUMPFLUSH = 616,            /* "$dumpflush"  */
    yD_DUMPLIMIT = 617,            /* "$dumplimit"  */
    yD_DUMPOFF = 618,              /* "$dumpoff"  */
    yD_DUMPON = 619,               /* "$dumpon"  */
    yD_DUMPPORTS = 620,            /* "$dumpports"  */
    yD_DUMPVARS = 621,             /* "$dumpvars"  */
    yD_ERROR = 622,                /* "$error"  */
    yD_EXIT = 623,                 /* "$exit"  */
    yD_EXP = 624,                  /* "$exp"  */
    yD_FATAL = 625,                /* "$fatal"  */
    yD_FCLOSE = 626,               /* "$fclose"  */
    yD_FDISPLAY = 627,             /* "$fdisplay"  */
    yD_FDISPLAYB = 628,            /* "$fdisplayb"  */
    yD_FDISPLAYH = 629,            /* "$fdisplayh"  */
    yD_FDISPLAYO = 630,            /* "$fdisplayo"  */
    yD_FELL = 631,                 /* "$fell"  */
    yD_FELL_GCLK = 632,            /* "$fell_gclk"  */
    yD_FEOF = 633,                 /* "$feof"  */
    yD_FERROR = 634,               /* "$ferror"  */
    yD_FFLUSH = 635,               /* "$fflush"  */
    yD_FGETC = 636,                /* "$fgetc"  */
    yD_FGETS = 637,                /* "$fgets"  */
    yD_FINISH = 638,               /* "$finish"  */
    yD_FLOOR = 639,                /* "$floor"  */
    yD_FMONITOR = 640,             /* "$fmonitor"  */
    yD_FMONITORB = 641,            /* "$fmonitorb"  */
    yD_FMONITORH = 642,            /* "$fmonitorh"  */
    yD_FMONITORO = 643,            /* "$fmonitoro"  */
    yD_FOPEN = 644,                /* "$fopen"  */
    yD_FREAD = 645,                /* "$fread"  */
    yD_FREWIND = 646,              /* "$frewind"  */
    yD_FSCANF = 647,               /* "$fscanf"  */
    yD_FSEEK = 648,                /* "$fseek"  */
    yD_FSTROBE = 649,              /* "$fstrobe"  */
    yD_FSTROBEB = 650,             /* "$fstrobeb"  */
    yD_FSTROBEH = 651,             /* "$fstrobeh"  */
    yD_FSTROBEO = 652,             /* "$fstrobeo"  */
    yD_FTELL = 653,                /* "$ftell"  */
    yD_FWRITE = 654,               /* "$fwrite"  */
    yD_FWRITEB = 655,              /* "$fwriteb"  */
    yD_FWRITEH = 656,              /* "$fwriteh"  */
    yD_FWRITEO = 657,              /* "$fwriteo"  */
    yD_GLOBAL_CLOCK = 658,         /* "$global_clock"  */
    yD_HIGH = 659,                 /* "$high"  */
    yD_HYPOT = 660,                /* "$hypot"  */
    yD_INCREMENT = 661,            /* "$increment"  */
    yD_INFERRED_DISABLE = 662,     /* "$inferred_disable"  */
    yD_INFO = 663,                 /* "$info"  */
    yD_ISUNBOUNDED = 664,          /* "$isunbounded"  */
    yD_ISUNKNOWN = 665,            /* "$isunknown"  */
    yD_ITOR = 666,                 /* "$itor"  */
    yD_LEFT = 667,                 /* "$left"  */
    yD_LN = 668,                   /* "$ln"  */
    yD_LOG10 = 669,                /* "$log10"  */
    yD_LOW = 670,                  /* "$low"  */
    yD_MONITOR = 671,              /* "$monitor"  */
    yD_MONITORB = 672,             /* "$monitorb"  */
    yD_MONITORH = 673,             /* "$monitorh"  */
    yD_MONITORO = 674,             /* "$monitoro"  */
    yD_MONITOROFF = 675,           /* "$monitoroff"  */
    yD_MONITORON = 676,            /* "$monitoron"  */
    yD_ONEHOT = 677,               /* "$onehot"  */
    yD_ONEHOT0 = 678,              /* "$onehot0"  */
    yD_PAST = 679,                 /* "$past"  */
    yD_POW = 680,                  /* "$pow"  */
    yD_PRINTTIMESCALE = 681,       /* "$printtimescale"  */
    yD_RANDOM = 682,               /* "$random"  */
    yD_READMEMB = 683,             /* "$readmemb"  */
    yD_READMEMH = 684,             /* "$readmemh"  */
    yD_REALTIME = 685,             /* "$realtime"  */
    yD_REALTOBITS = 686,           /* "$realtobits"  */
    yD_REWIND = 687,               /* "$rewind"  */
    yD_RIGHT = 688,                /* "$right"  */
    yD_ROOT = 689,                 /* "$root"  */
    yD_ROSE = 690,                 /* "$rose"  */
    yD_ROSE_GCLK = 691,            /* "$rose_gclk"  */
    yD_RTOI = 692,                 /* "$rtoi"  */
    yD_SAMPLED = 693,              /* "$sampled"  */
    yD_SFORMAT = 694,              /* "$sformat"  */
    yD_SFORMATF = 695,             /* "$sformatf"  */
    yD_SHORTREALTOBITS = 696,      /* "$shortrealtobits"  */
    yD_SIGNED = 697,               /* "$signed"  */
    yD_SIN = 698,                  /* "$sin"  */
    yD_SINH = 699,                 /* "$sinh"  */
    yD_SIZE = 700,                 /* "$size"  */
    yD_SQRT = 701,                 /* "$sqrt"  */
    yD_SSCANF = 702,               /* "$sscanf"  */
    yD_STABLE = 703,               /* "$stable"  */
    yD_STABLE_GCLK = 704,          /* "$stable_gclk"  */
    yD_STACKTRACE = 705,           /* "$stacktrace"  */
    yD_STIME = 706,                /* "$stime"  */
    yD_STOP = 707,                 /* "$stop"  */
    yD_STROBE = 708,               /* "$strobe"  */
    yD_STROBEB = 709,              /* "$strobeb"  */
    yD_STROBEH = 710,              /* "$strobeh"  */
    yD_STROBEO = 711,              /* "$strobeo"  */
    yD_SWRITE = 712,               /* "$swrite"  */
    yD_SWRITEB = 713,              /* "$swriteb"  */
    yD_SWRITEH = 714,              /* "$swriteh"  */
    yD_SWRITEO = 715,              /* "$swriteo"  */
    yD_SYSTEM = 716,               /* "$system"  */
    yD_TAN = 717,                  /* "$tan"  */
    yD_TANH = 718,                 /* "$tanh"  */
    yD_TESTPLUSARGS = 719,         /* "$test$plusargs"  */
    yD_TIME = 720,                 /* "$time"  */
    yD_TIMEFORMAT = 721,           /* "$timeformat"  */
    yD_TIMEPRECISION = 722,        /* "$timeprecision"  */
    yD_TIMEUNIT = 723,             /* "$timeunit"  */
    yD_TYPENAME = 724,             /* "$typename"  */
    yD_UNGETC = 725,               /* "$ungetc"  */
    yD_UNIT = 726,                 /* "$unit"  */
    yD_UNPACKED_DIMENSIONS = 727,  /* "$unpacked_dimensions"  */
    yD_UNSIGNED = 728,             /* "$unsigned"  */
    yD_URANDOM = 729,              /* "$urandom"  */
    yD_URANDOM_RANGE = 730,        /* "$urandom_range"  */
    yD_VALUEPLUSARGS = 731,        /* "$value$plusargs"  */
    yD_WARNING = 732,              /* "$warning"  */
    yD_WRITE = 733,                /* "$write"  */
    yD_WRITEB = 734,               /* "$writeb"  */
    yD_WRITEH = 735,               /* "$writeh"  */
    yD_WRITEMEMB = 736,            /* "$writememb"  */
    yD_WRITEMEMH = 737,            /* "$writememh"  */
    yD_WRITEO = 738,               /* "$writeo"  */
    yVL_CLOCKER = 739,             /* "/\*verilator clocker*\/"  */
    yVL_CLOCK_ENABLE = 740,        /* "/\*verilator clock_enable*\/"  */
    yVL_COVERAGE_BLOCK_OFF = 741,  /* "/\*verilator coverage_block_off*\/"  */
    yVL_FORCEABLE = 742,           /* "/\*verilator forceable*\/"  */
    yVL_FULL_CASE = 743,           /* "/\*verilator full_case*\/"  */
    yVL_HIER_BLOCK = 744,          /* "/\*verilator hier_block*\/"  */
    yVL_INLINE_MODULE = 745,       /* "/\*verilator inline_module*\/"  */
    yVL_ISOLATE_ASSIGNMENTS = 746, /* "/\*verilator isolate_assignments*\/"  */
    yVL_NO_CLOCKER = 747,          /* "/\*verilator no_clocker*\/"  */
    yVL_NO_INLINE_MODULE = 748,    /* "/\*verilator no_inline_module*\/"  */
    yVL_NO_INLINE_TASK = 749,      /* "/\*verilator no_inline_task*\/"  */
    yVL_PARALLEL_CASE = 750,       /* "/\*verilator parallel_case*\/"  */
    yVL_PUBLIC = 751,              /* "/\*verilator public*\/"  */
    yVL_PUBLIC_FLAT = 752,         /* "/\*verilator public_flat*\/"  */
    yVL_PUBLIC_FLAT_ON = 753,      /* "/\*verilator public_flat_on*\/"  */
    yVL_PUBLIC_FLAT_RD = 754,      /* "/\*verilator public_flat_rd*\/"  */
    yVL_PUBLIC_FLAT_RD_ON = 755,   /* "/\*verilator public_flat_rd_on*\/"  */
    yVL_PUBLIC_FLAT_RW = 756,      /* "/\*verilator public_flat_rw*\/"  */
    yVL_PUBLIC_FLAT_RW_ON = 757,   /* "/\*verilator public_flat_rw_on*\/"  */
    yVL_PUBLIC_FLAT_RW_ON_SNS = 758, /* "/\*verilator public_flat_rw_on_sns*\/"  */
    yVL_PUBLIC_ON = 759,           /* "/\*verilator public_on*\/"  */
    yVL_PUBLIC_OFF = 760,          /* "/\*verilator public_off*\/"  */
    yVL_PUBLIC_MODULE = 761,       /* "/\*verilator public_module*\/"  */
    yVL_SC_BV = 762,               /* "/\*verilator sc_bv*\/"  */
    yVL_SFORMAT = 763,             /* "/\*verilator sformat*\/"  */
    yVL_SPLIT_VAR = 764,           /* "/\*verilator split_var*\/"  */
    yVL_TAG = 765,                 /* "/\*verilator tag*\/"  */
    yVL_UNROLL_DISABLE = 766,      /* "/\*verilator unroll_disable*\/"  */
    yVL_UNROLL_FULL = 767,         /* "/\*verilator unroll_full*\/"  */
    yP_TICK = 768,                 /* "'"  */
    yP_TICKBRA = 769,              /* "'{"  */
    yP_OROR = 770,                 /* "||"  */
    yP_ANDAND = 771,               /* "&&"  */
    yP_NOR = 772,                  /* "~|"  */
    yP_XNOR = 773,                 /* "^~"  */
    yP_NAND = 774,                 /* "~&"  */
    yP_EQUAL = 775,                /* "=="  */
    yP_NOTEQUAL = 776,             /* "!="  */
    yP_CASEEQUAL = 777,            /* "==="  */
    yP_CASENOTEQUAL = 778,         /* "!=="  */
    yP_WILDEQUAL = 779,            /* "==?"  */
    yP_WILDNOTEQUAL = 780,         /* "!=?"  */
    yP_GTE = 781,                  /* ">="  */
    yP_LTE = 782,                  /* "<="  */
    yP_LTE__IGNORE = 783,          /* "<=-ignored"  */
    yP_SLEFT = 784,                /* "<<"  */
    yP_SRIGHT = 785,               /* ">>"  */
    yP_SSRIGHT = 786,              /* ">>>"  */
    yP_POW = 787,                  /* "**"  */
    yP_COLON__BEGIN = 788,         /* ":-begin"  */
    yP_COLON__FORK = 789,          /* ":-fork"  */
    yP_PAR__IGNORE = 790,          /* "(-ignored"  */
    yP_PAR__STRENGTH = 791,        /* "(-for-strength"  */
    yP_LTMINUSGT = 792,            /* "<->"  */
    yP_PLUSCOLON = 793,            /* "+:"  */
    yP_MINUSCOLON = 794,           /* "-:"  */
    yP_MINUSGT = 795,              /* "->"  */
    yP_MINUSGTGT = 796,            /* "->>"  */
    yP_EQGT = 797,                 /* "=>"  */
    yP_ASTGT = 798,                /* "*>"  */
    yP_ANDANDAND = 799,            /* "&&&"  */
    yP_POUNDPOUND = 800,           /* "##"  */
    yP_POUNDMINUSPD = 801,         /* "#-#"  */
    yP_POUNDEQPD = 802,            /* "#=#"  */
    yP_DOTSTAR = 803,              /* ".*"  */
    yP_ATAT = 804,                 /* "@@"  */
    yP_COLONCOLON = 805,           /* "::"  */
    yP_COLONEQ = 806,              /* ":="  */
    yP_COLONDIV = 807,             /* ":/"  */
    yP_ORMINUSGT = 808,            /* "|->"  */
    yP_OREQGT = 809,               /* "|=>"  */
    yP_BRASTAR = 810,              /* "[*"  */
    yP_BRAEQ = 811,                /* "[="  */
    yP_BRAMINUSGT = 812,           /* "[->"  */
    yP_BRAPLUSKET = 813,           /* "[+]"  */
    yP_PLUSPLUS = 814,             /* "++"  */
    yP_MINUSMINUS = 815,           /* "--"  */
    yP_PLUSEQ = 816,               /* "+="  */
    yP_MINUSEQ = 817,              /* "-="  */
    yP_TIMESEQ = 818,              /* "*="  */
    yP_DIVEQ = 819,                /* "/="  */
    yP_MODEQ = 820,                /* "%="  */
    yP_ANDEQ = 821,                /* "&="  */
    yP_OREQ = 822,                 /* "|="  */
    yP_XOREQ = 823,                /* "^="  */
    yP_SLEFTEQ = 824,              /* "<<="  */
    yP_SRIGHTEQ = 825,             /* ">>="  */
    yP_SSRIGHTEQ = 826,            /* ">>>="  */
    yP_PLUSSLASHMINUS = 827,       /* "+/-"  */
    yP_PLUSPCTMINUS = 828,         /* "+%-"  */
    prTAGGED = 829,                /* prTAGGED  */
    prPOUNDPOUND_MULTI = 830,      /* prPOUNDPOUND_MULTI  */
    prUNARYARITH = 831,            /* prUNARYARITH  */
    prREDUCTION = 832,             /* prREDUCTION  */
    prNEGATION = 833,              /* prNEGATION  */
    prLOWER_THAN_ELSE = 834        /* prLOWER_THAN_ELSE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_VERILOG_PRETMP_H_INCLUDED  */
