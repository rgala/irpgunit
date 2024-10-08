      // ==========================================================================
      //  iRPGUnit - ACPTSTT Unit Test Helper.
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================

     D chkAndCloSplF   pr                  extproc('chkAndCloSplF')

     D cloSplf         pr                  extproc('cloSplf')

     D opnSplf         pr                  extproc('opnSplf')
     D  splfNm                       10a   const
     D  usrData                      10a   const

     D splfLineStartsWith...
     D                 pr                  extproc('splfLineStartsWith')
     D  expString                   256a   const varying

     D splfContains...
     D                 pr                  extproc('splfContains')
     D  expString                   256a   const varying

     D splfSkipLine...
     D                 pr                  extproc('splfSkipLine')

     D dltSplfs        pr            10i 0 extproc('dltSplfs')
     D  splfNm                       10a   const
     D  usrData                      10a   const

