      // ==========================================================================
      //  iRPGUnit - Logging Facilities for CMDRUN.
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================
      // >>PRE-COMPILER<<
      //   >>CRTCMD<<  CRTRPGMOD MODULE(&LI/&OB) SRCFILE(&SL/&SF) SRCMBR(&SM);
      //   >>IMPORTANT<<
      //     >>PARM<<  OPTION(*EVENTF);
      //     >>PARM<<  DBGVIEW(*LIST);
      //   >>END-IMPORTANT<<
      //   >>EXECUTE<<
      // >>END-PRE-COMPILER<<
      // ==========================================================================

     H NoMain
      /include qinclude,H_SPEC
      /include qinclude,COPYRIGHT

      //----------------------------------------------------------------------
      //   Exports
      //----------------------------------------------------------------------

      /include qinclude,CMDRUNLOG

      //----------------------------------------------------------------------
      //   Imports
      //----------------------------------------------------------------------

      /include qinclude,CMDRUNPRT
      /include qinclude,TEMPLATES
      /include qinclude,STRING
      /include qinclude,VERSION
      /include qinclude,OSVERSION

      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

       // Log a header message.
     D logHdr          pr                  extproc('logHdr')
        // Name of the service program containing the tests.
     D  srvPgm                             const likeds(Object_t)

     D getFormattedJob...
     D                 pr            32A   varying
     D                                     extproc('getFormattedJob')

     D getLeftMargin...
     D                 pr            32A   varying
     D                                     extproc('getLeftMargin')

      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

     D indent          c                   const('  ')
     D separator       c                   const(' - ')
     D lineSeparator   c                   const('-----------------------')

      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Was the spool file header already printed?
     D hdrWasPrinted   s               n
       // Test service program being run.
     D g_srvPgm        ds                  likeds(Object_t)
       // Specifies how detailed the test run report should be.
     D g_detail        s             10a   inz(DETAIL_BASIC)
       // Specifies whether a report is created.
     D g_output        s             10a   inz(OUTPUT_ALLWAYS)
       // Library list, the test suite is executed with.
     D g_liblData      ds                  likeds(LiblData_t) inz

       //----------------------------------------------------------------------
       //   Program Status Data Structure
       //----------------------------------------------------------------------

      /include qinclude,SDS

       //----------------------------------------------------------------------
       // Linefeed.
       //----------------------------------------------------------------------
     P linefeed...
     P                 b                   export
     D                 pi
      /free

        if (g_output = OUTPUT_NONE);
           return;
        endif;

        prtLine('');

      /end-free
     P                 e

       //----------------------------------------------------------------------
       // Log the completion message. See prototype.
       //----------------------------------------------------------------------
     P logCompMsg...
     P                 b                   export
     D                 pi
     D  msg                       16384a   const varying options(*Varsize)
     D  failures                     10i 0 const
     D  errors                       10i 0 const
      /free

        if (g_output = OUTPUT_NONE);
           return;
        endif;

        if (g_output = OUTPUT_ERROR and (failures + errors = 0));
           return;
        endif;

        logHdr( g_srvPgm );
        logRawLine( msg );
        clsPrt();
        clear hdrWasPrinted;

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Log an error event. See prototype.
       //----------------------------------------------------------------------
     P logError...
     P                 b                   export
     D                 pi
     D  testNm                             const like(ProcNm_t)
     D  excpMsgInfo                        const likeds(Msg_t)

     D line            s           2048a   varying
      /free

        if (g_output = OUTPUT_NONE);
          return;
        endif;

        logHdr( g_srvPgm );

        prtLine( getLeftMargin() + %trimr(testNm) + separator + 'ERROR' );

        line = '';
        if excpMsgInfo.id <> *blank;
          line += excpMsgInfo.id;
          line += separator;
        endif;
        line += excpMsgInfo.txt;
        logRawLine( line );

        if ( excpMsgInfo.qSndStmt.procNm <> *blank and
             excpMsgInfo.qSndStmt.qPgm.nm  <> *blank and
             excpMsgInfo.qSndStmt.specNb <> *blank );
          logStackEntry( excpMsgInfo.qSndStmt );
        endif;

        prtLine( getLeftMargin() + lineSeparator );
        linefeed();

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Log a failure event. See prototype.
       //----------------------------------------------------------------------
     P logFailure...
     P                 b                   export
     D                 pi
     D  testNm                             const like(ProcNm_t)
     D  failure                            const
     D                                     likeds(AssertFailEvtLong_t)

       // Index.
     D i               s             10i 0
      /free

        if (g_output = OUTPUT_NONE);
          return;
        endif;

        logHdr( g_srvPgm );

        logRawLine( %trimr(testNm) + separator + 'FAILURE' );
        logRawLine( failure.msg );

        for i = 1 to failure.callStk.numE;
          logStackEntry( failure.callStk.entry(i).qStmt );
        endfor;

        prtLine( getLeftMargin() + lineSeparator );
        linefeed();

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Print the report header.
       //----------------------------------------------------------------------
     P logHdr...
     P                 b
     D                 pi
     D  srvPgm                             const likeds(Object_t)

     D version         s             20a
     D date            s             10a
      /free

        if not hdrWasPrinted;
          getVersion(version: date);
          opnPrt( srvPgm );
          logRawLine( '*** Tests of ' + %trim(srvPgm.nm) + ' ***');
          logRawLine('Date        : ' + %char(%date())
                                      + ' / '+%char(%time():*HMS));
          logRawLine('Job         : ' + getFormattedJob());
          logRawLine('User        : ' + %trimR(sds.currUser));
          logRawLine('iRPGUnit    : ' + 'v' + %trim(version));
          logRawLine('IBM i       : ' + OS_getVersion());
          linefeed();
          logLibraryList(g_liblData);
          hdrWasPrinted = *on;
        endif;

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Append a line to the report. Splitt long lines.
       // !!INFO!! Exported for self-test only.
       //----------------------------------------------------------------------
     P logRawLine...
     P                 b                   export
     D                 pi
     D  line                       2048a   Value varying

       // Printing area width (in characters).
     D prtWidth        s             10i 0
     D leftMargin      s             32a   varying

     D RIGHT_MARGIN    c                   5
      /free

        if line = *blank;    // Do not log blank lines.
          return;
        endif;

        line = %trimr(line);
        leftMargin = getLeftMargin();

        prtWidth = getPrtWidth() - %len(leftMargin) - RIGHT_MARGIN;

        dow %len(line) > prtWidth;
          prtLine( leftMargin + %subst( line : 1 : prtWidth ) );
          line = %subst( line : prtWidth+1 );
        enddo;

        if (%len(%trimR(line)) > 0);
          prtLine( leftMargin + line );
        endif;

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Append a SUCCESS message to the report.
       //----------------------------------------------------------------------
     P logSuccess...
     P                 b                   export
     D                 pi
     D  testNm                             const like(ProcNm_t)
     D  assertionCnt                 10i 0 const
      /free

        if (g_detail <> DETAIL_ALL);
           return;
        endif;

        if (g_output <> OUTPUT_ALLWAYS);
           return;
        endif;

        logHdr( g_srvPgm );

        logRawLine( %trimr(testNm) + ' - Success' );
        logRawLine( indent + %char(assertionCnt) + ' assertions' );
        logRawLine( lineSeparator );
        linefeed();

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Print a call stack entry.
       //----------------------------------------------------------------------
     P logStackEntry...
     P                 b                   export
     D                 pi
     D  qSndStmt                           const likeds(qStatement_t)

     D line            s            256a   varying
      /free

        line = fmtStackEntry( qSndStmt );
        logRawLine( line );

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Log runtime error.
       //----------------------------------------------------------------------
     P logRuntimeError...
     P                 b                   export
     D                 pi
     D  line                       2048a   const varying options(*varsize)
      /free

        if (g_output = OUTPUT_NONE);
           return;
        endif;

        logHdr( g_srvPgm );

        logRawLine( line );

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Log library list.
       // Prints the library list in an arry of 3 items in a row by
       // number of rows required. The minimum number of rows is 5:
       //
       // Output for up to 5 libraries:
       //   Cur. library: LLLLLLLLLL
       //   Library list: nnnn LLLLLLLLLL
       //                 ...
       //                 nnnn LLLLLLLLLL
       //
       // Output for 5+ libraries:
       //   Cur. library: LLLLLLLLLL
       //   Library list: nnnn LLLLLLLLLL   nnnn LLLLLLLLLL   nnnn LLLLLLLLLL
       //                 ...
       //                 nnnn LLLLLLLLLL   nnnn LLLLLLLLLL   nnnn LLLLLLLLLL
       //----------------------------------------------------------------------
     P logLibraryList...
     P                 b
     D                 pi
     D  libraryList                        const likeds(LiblData_t)

     D MIN_NUM_ROWS    c                   5
     D STEP_WIDTH      c                   10

     D numRows         s             10i 0
     D row             s             10i 0
     D column          s             10i 0
     D x               s             10i 0
     D seq             s              4s 0

     D line            s             80a   varying

     D item            ds                  qualified
     D  seq                    1      4a
     D  name                   6     15a
      /free

        if (g_output = OUTPUT_NONE);
          return;
        endif;

        line = 'Cur. library: ' + libraryList.curLib;
        logRawLine( line );

        if (libraryList.libL.numE = 0);
          line = 'Library list: *NONE';
          logRawLine( line );
          linefeed();
          return;
        endif;

        numRows = %div(libraryList.libL.numE: 3);
        if (numRows * 3 <> libraryList.libL.numE);
          numRows += 1;
        endif;

        if (numRows < MIN_NUM_ROWS);
          numRows = MIN_NUM_ROWS;
        endif;

        for row = 1 to numRows;

          if (row = 1);
            line = 'Library list: ';
          endif;

          for column = 0 to 2;

            x = row + (column * numRows);
            if (x <= libraryList.libL.numE);
              seq = (row * STEP_WIDTH) + (column * (numRows * STEP_WIDTH));
              clear item;
              item.seq = %editc(seq: '3');
              item.name = libraryList.libL.lib(x);
              line = line + item + '   ';
            endif;

          endfor;

          logRawLine( line );
          line = '              ';

        endfor;

        linefeed();

      /end-free
     P                 e


       //----------------------------------------------------------------------
       // Formats a call stack entry.
       //----------------------------------------------------------------------
     P fmtStackEntry...
     P                 b
     D                 pi                  like(Line_t)
     D  qSndStmt                           const likeds(qStatement_t)

     D line            s                   like(Line_t)
       // Specification number. Special value '*N' if not available.
     D specNb          s             10a   varying
      /free

          if (%trim(qSndStmt.specNb) = '');
             specNb = '*N';
          else;
             specNb = %trimL(%trim(qSndStmt.specNb): '0');
          endif;

          line = indent
               + %trim(qSndStmt.procNm)
               + ' ('
               + %trim(qSndStmt.qPgm.nm)
               + '->'
               + %trim(qSndStmt.qMod.nm)
               + ':'
               + %trim(specNb)
               + ')';
          Return line;

      /end-free
     P                 e


     P setLogContext...
     P                 b                   export
     D                 pi
     D  testPgm                            const likeds(Object_t)
     D  detail                       10a   const
     D  output                       10a   const
      /free

        g_srvPgm = testPgm;
        g_detail = detail;
        g_output = output;

      /end-free
     P                 e


     P updateLogContext...
     P                 b                   export
     D                 pi
     D  liblData                           const likeds(LiblData_t)
      /free

        g_liblData = liblData;

      /end-free
     P                 e


     P getLogSplF...
     P                 b                   export
     D                 pi                  likeds(SplF_t)

     D splF            ds                  likeds(SplF_t)
      /free

         clear splF;

         if (hdrWasPrinted);
            splF = getSplF();
         endif;

         return getSplF();

      /end-free
     P                 e


     P getFormattedJob...
     P                 b
     D                 pi            32A   varying
      /free

         return %editc(sds.nbr: 'X') + '/' +
                %trimR(sds.user) + '/' +
                %trim(sds.job);

      /end-free
     P                 e


     P getLeftMargin...
     P                 b
     D                 pi            32A   varying

     D leftMargin      s             32A   varying static

     D LEFT_MARGIN     c                   5
      /free

        if (%len(leftMargin) <> LEFT_MARGIN);
          leftMargin = spaces(LEFT_MARGIN);
        endif;

        return leftMargin;

      /end-free
     P                 e

