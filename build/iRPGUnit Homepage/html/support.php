<html>
    <head>
        <meta http-equiv="cache-control" content="no-cache">
        <meta name="description" content="iRPGUnit Support">
        <meta name="author" content="iRPGUnit Project Team">
        <meta name="keywords" content="iRPGUnit, Plugin, RDP, RDI, Eclipse, AS400">
        <link href="assets/stylesheet.css" rel="stylesheet" type="text/css" />
        <title>iRPGUnit Plug-in Support</title>
    </head>
    <body>
        <?php
            function parseJarManifest($manifestFileContents) {
               $manifest = array();	
               $lines = explode("\n", $manifestFileContents);
               foreach ($lines as $line) {
                  if (preg_match("/^([^:]+):\s*(.+)$/", $line, $m)) {
                     $manifest[$m[1]] = trim($m[2]);
                  }
               }
               return $manifest;
            }
            $manifestFileContents = file_get_contents('http://sourceforge.net/p/irpgunit/code/HEAD/tree/trunk/build/iRPGUnit%20Core%20Plugin/MANIFEST.MF?format=raw');
            $manifest = parseJarManifest($manifestFileContents);
            $current_version = $manifest['Bundle-Version'];
        ?>
      
        <table width="100%" border="0">
        <tr><td align="left" >
        <a href="https://sourceforge.net/projects/irpgunit/"><img src="assets/iRPGUnit.png" alt="iRPGUnit - Unit Tests for i" border="0" style="padding-right: 10px;"/></a>
        </td>
        <td align="left" width="100%" >
        <h1>iRPGUnit Plug-in</h1>
        <p>Hi, this is the support page of the iRPGUnit plug-in for IBM Rational Developer for i.</p>
        </td>
        <td>
        
        <table>
        <tr>
        <td align="left">
        <img src="assets/irpgunit_support.png" alt="iRPGUnit Plug-in" border="0" style="padding-right: 10px;"/>
        </td>
        </tr>
        <tr>
        <td valign="bottom" align="right" nowrap>
        <b>Version: @VERSION_NUMBER@</b>
        </td>
        </tr>
        </table>
        
        </td>
        </tr>
        </table>
        
        <h2 class="release">Getting Support</h2>
        <div class="section">
        When you are in doubt whether or not something is wrong with iRPGUnit, please, start with the iRPGUnit <a target="_help" href="@HELP_SITE_URL@">help</a> 
        and check for remarks regarding your concerns or ask your questions at the 
        <a target="_wdsci-l" href="http://lists.midrange.com/mailman/listinfo/wdsci-l">WDSCI-L</a> mailing list. In
        case you are sure that you spotted a bug, add a bug report at the 
        <a target="_iRPGUnit-bugs" href="https://sourceforge.net/p/irpgunit/tickets/">iRPGUnit bug tracker</a>.
        <p>
        <table>
        <tr><td>Ask your questions at the <a target="_wdsci-l" href="http://lists.midrange.com/mailman/listinfo/wdsci-l">WDSCI-L</a> mailing list at <a target="_wdsci-l" href="http://www.midrange.com">midrange.com</a>.</td></tr>
        <tr><td>For bug reports open a ticket at the <a href="https://sourceforge.net/p/irpgunit/tickets/">iRPGUnit bug tracker.</a></td></tr>
        </table>
        </div>
        <p/>

        <h2 class="release">Trademarks</h2>
        <div class="section">
        The following terms are trademarks of the IBM Corporation in the United States or other countries or both:
        <ul>
        <li>IBM Rational Developer for i 9.5.1.3+</li>
        </ul>
        </div>
        <p/>

        <br>
        <hr>
        <table border="0" class="copyright">
        <tr><td class="copyright" align="left" width="50%">Version: @VERSION_NUMBER@ - Copyright: @TODAY_YEAR@, iRPGUnit project team</td><td class="copyright" align="right" width="50%">Updated: @TODAY@</td></tr>
        </table>
        <br>
    </body>
</html>