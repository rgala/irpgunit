      /if defined(templates)
      /eof
      /endif
      /define templates
      // ==========================================================================
      //  iRPGUnit - Type Templates.
      // ==========================================================================
      //  Copyright (c) 2013-2020 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================

     D TEST_CASE_EXECUTOR...
     D                 c                   'CMDRUNSRV_runProc'

     D TEST_PREFIX     c                   const('TEST')

     D TSTPRC_ALL      c                   '*ALL'

     D ORDER_API       c                   '*API'
     D ORDER_REVERSE   c                   '*REVERSE'

     D DETAIL_BASIC    c                   '*BASIC'
     D DETAIL_ALL      c                   '*ALL'

     D OUTPUT_NONE     c                   '*NONE'
     D OUTPUT_ERROR    c                   '*ERROR'
     D OUTPUT_ALLWAYS  c                   '*ALLWAYS'

     D LIBRARY_LIST_JOBD...
     D                 c                   '*JOBD'
     D LIBRARY_LIST_CURRENT...
     D                 c                   '*CURRENT'

     D JOBD_DEFAULT    c                   '*DFT'

     D RCLRSC_NO       c                   '*NO'
     D RCLRSC_ALWAYS   c                   '*ALWAYS'
     D RCLRSC_ONCE     c                   '*ONCE'

     D NO_VALUE        c                   '*N'

     D NO_MSG_TEXT     c                   '*N'

       // Source member types
     D MBR_RPGLE       c                   const('RPGLE')
     D MBR_SQLRPGLE    c                   const('SQLRPGLE')
     D MBR_CBLLE       c                   const('CBLLE')
     D MBR_SQLCBLLE    c                   const('SQLCBLLE')

     D PARM_DBGVIEW    c                   const('DBGVIEW')
     D PARM_DEFINE     c                   const('DEFINE')

     D SLASH           c                   u'002F'
     D BACK_SLASH      c                   u'005C'
     D COLON           c                   u'003A'

     D order_t         s             10a   template
     D detail_t        s             10a   template
     D output_t        s             10a   template
     D rclrsc_t        s             10a   template
     D stmf_t          s           1024a   varying template
     D stmf_fl_t       s           1024a   template
     D yesNo_t         s              1a   template

     D MAX_NUM_LIB     c                   250

       // 'Modul created in' message IDs
     D MOD_CRT_RPG     c                   'RNS9305'
     D MOD_CRT_CBL     c                   'LNC0899'

     D LibL_t          ds                  template
     D  numE                   1      2i 0
     D  lib                    3   2502a   dim(MAX_NUM_LIB)

     D LiblData_t      ds                  qualified template
     D  curLib                 1     10a
     D  libL                               likeds(LibL_t)

       // ILE Activation Mark.
     D ActMark_t       s             10i 0 template

       // Empty Assertion Failure Event of version 1.
     D EMPTY_ASSERT_FAIL_EVT...
     D                 ds                  likeds(AssertFailEvt_t) inz

     D EMPTY_ASSERT_FAIL_EVT_LONG...
     D                 ds                  likeds(AssertFailEvtLong_t) inz

       // Assertion Failure Event.
     D AssertFailEvtLong_t...
     D                 ds                  qualified template
     D  msg                                like(msgText_t)
     D  callStk                            likeds(CallStk_t)

       // Assertion Failure Event of version 1
     D assertFailEvt_t...
     D                 ds                  qualified template
     D  msg                         256a   varying
     D  callStk                            likeds(CallStk_t)

       // Call Stack.
     D CallStk_t       ds                  qualified template
     D  numE                         10i 0
     D  entry                              likeds(CallStkEnt_t)
     D                                     Dim(MAX_CALL_STK_SIZE)

       // Call Stack Entry.
     D CallStkEnt_t    ds                  qualified template
     D  level                        10i 0
     D  qStmt                              likeds(qStatement_t)

       // Program Message.
     D Msg_t           ds                  qualified template
     D  id                            7a
     D  txt                                like(msgText_t)
     D  rplData                     256a   varying
     D  key                           4a
     D  qSndStmt                           likeds(qStatement_t)
     D  qRcvStmt                           likeds(qStatement_t)

       // Qualified program statement
     D qStatement_t    ds                  qualified template
     D  qPgm                               likeds(Object_t)
     D  qMod                               likeds(Object_t)
     D  procNm                             like(ProcNm_t)
     D  specNb                       10a

      // Old style error message prior to version 2.0.0.
     D OldMsg_t        s            256a

       // MsgInfo_t is and must be defined in member TESTCASE!

       // SQL pre-compiler option RPGPPOPT
     D RpgPpOpt_t      s             10a

       // SQL pre-compiler option COMPILEOPT
     D CompileOpt_t    s           5000a   varying

       // Object qualified Name.
     D Object_t        ds                  qualified template
     D  nm                           10a
     D  lib                          10a

       // Spooled file qualified Name.
     D SplF_t          ds                  qualified template
     D  system                       10a
     D  nm                           10a
     D  nbr                          10i 0
     D  job                                likeds(Job_t)

       // Job qualified Name.
     D Job_t           ds                  qualified template
     D  name                         10A
     D  user                         10A
     D  nbr                           6A

       // Named callable procedure.
     D Proc_t          ds                  qualified template
     D  procNm                             like(ProcNm_t)
     D  procPtr                        *   procptr

     D ProcNmList_t    ds                  qualified template
     D  handle                         *
     D  cnt                            *   procptr
     D  getNm                          *   procptr
     D  goToNext                       *   procptr

     D ProcNm_t        s            256a   varying template

     D ProcNms_t       ds                  qualified template
     D  numE                          5i 0
     D  name                               like(ProcNm_t) Dim(250)

       // qualified Job Name.
     D QlfJobNm_t      ds                  qualified template
     D  jobNm                        10a
     D  usrNm                        10a
     D  jobNb                         6a

     D TestResult_t    ds                  qualified template
     D  outcome                       1a
     D  details
     D  failure                            likeds(AssertFailEvtLong_t)
     D                                     Overlay(details)
     D  error                              likeds(Msg_t)
     D                                     Overlay(details)
     D  testName                           like(ProcNm_t)
     D  execTime                     20i 0
     D  srcFile                      10a
     D  srcLib                       10a
     D  srcMbr                       10a
     D  assertCnt                    10i 0

     D TestSuite_t     ds                  qualified template
     D  isCobol                        n
     D  qName                              likeds(Object_t)
     D  setUpSuite                         likeds(Proc_t)
     D  setUp                              likeds(Proc_t)
     D  testCasesCnt                 10i 0
     D  testList                       *
     D  tearDown                           likeds(Proc_t)
     D  teardownSuite                      likeds(Proc_t)
     D  testResults                    *

       // User profile name.
     D UsrNm_t         s             10a   template

       // Object description
     D Text_t          s             50a   varying template

       // String value (must be greater than COMPILEOPT)
     D String_t...
     D                 s           5120a   varying template

       // Value of a line of the log.
     D Line_t          s            256a   varying template

       // Message replacement data or message text.
     D msgText_t       s           1024a   varying template

       // Full qualified source member.
     D SrcMbr_t        ds                  qualified template
     D  file                         10a
     D  lib                          10a
     D  mbr                          10a

     D MAX_CALL_STK_SIZE...
     D                 c                   const(64)
     D CALL_STACK_INCOMPLETE...
     D                 c                   const('*INCOMPLETE')

       // TestResult_t.outcome can have three values.
     D TEST_CASE_SUCCESS...
     D                 c                   const('S')
     D TEST_CASE_FAILURE...
     D                 c                   const('F')
     D TEST_CASE_ERROR...
     D                 c                   const('E')

     D QUOTE           c                   const('''')


      // A sized array of OS400 objects.
     D ObjectArray_t   ds                  template qualified
     D  size                          5i 0
     D  object                             Dim(51) likeds(Object_t)

       // A sized list of options.
     D Options_t       ds                  template qualified
     D  size                          5i 0
     D  option                       12a   Dim(25)

       // A sized list of compiler directives.
     D Defines_t       ds                  template qualified
     D  size                          5i 0
     D  define                       50a   Dim(32)

     D HeadToken_t     s             10a   template
     D DbgView_t       s             10a   template
     D Export_t        s             10a   template
     D ActivationGroup_t...
     D                 s             10a   template

     D Cmd_t           s           8192a   template varying
     D SerializedArray_t...
     D                 s           2048a   template varying
     D SerializedObject_t...
     D                 s             21a   template varying
     D SerializedOptions_t...
     D                 s            512a   template varying
     D SerializedString_t...
     D                 s           5136a   template varying
     D TargetRelease_t...
     D                 s             10a   template
     D assertString_t...
     D                 s               a   len(32565) varying(4) ccsid(*utf8)
     D                                     template
     D assertNumeric_t...
     D                 s             63s20 template

       // Program Status Data Structure.
     D sds_t           ds                  template qualified
     D  pgmName                1     10A
     D  pgmStat               11     15S 0
     D  prevStat              16     20S 0
     D  lastSeq               21     28A
     D  lastSubr              29     36A
     D  nbrParm               37     39S 0
     D  excType               40     42A
     D  excNbr                43     46A
     D  miInstruction         47     50A
     D  workArea              51     80A
     D  pgmLib                81     90A
     D  excData               91    170A
     D  rnx9001Exc           171    174A
     D  lastFileLong         175    184A
     D  unused_1             185    190A
     D  datFmt               191    198A
     D  year                 199    200S 0
     D  lastFileShort        201    208A
     D  fileStat             209    243A
     D  job                  244    253A
     D  user                 254    263A
     D  nbr                  264    269S 0
     D  startDate            270    275S 0
     D  runDate              276    281S 0
     D  runTime              282    287S 0
     D  compDate             288    293A
     D  compTime             294    299A
     D  compLevel            300    303A
     D  srcFile              304    313A
     D  srcLib               314    323A
     D  srcMbr               324    333A
     D  pgmContProc          334    343A
     D  modContProc          344    353A
     D  sourceID1            354    355I 0
     D  sourceID2            356    357I 0
     D  currUser             358    367A
     D  unused_2             368    429A

