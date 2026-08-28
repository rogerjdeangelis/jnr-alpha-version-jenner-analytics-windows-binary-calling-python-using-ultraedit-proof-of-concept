/*---
c:/utl/jnr-alpha-version-jenner-analytics-windows-binary-calling-python-using-ultraedit-proof-of-concept
---*/   
 
/*---
  
 Alpha version jenner analytics windows binary calling python using ultraedit proof of concept
 
 Example: select mean age, height and weight from sashelp.class by sex 
  
 Very early version of windows binary jenner analytics
 Jenner v1.5.46 (build v1.5.46+0dff9f1347.20260806T035922Z.x86_64-pc-windows-msvc)
  
 This can be streamlined using Javascript, but I would rather wait for proc python. 
 Proc R tomorrow?
 
 It is very easy to do a complete backup of UltraEdit. I had to restore a couple of times because I messed up
 mappings. Advanced>backup settings
 
 CONTENTS   
 --------
 
   1 Preparation
   2 Jenner (select mean age, height and weight from sashelp.class by sex)
   3 Python (exact same as proc sql using sqlite)
   
  1  PREPARTION
     ==========    
        
      a. Remember UE should look like this and match the CLIs   
         
           https://github.com/rogerjdeangelis/utl-chapter-IV-ultraedit-ebook-UltraEdit-SAS-DMS-Editor-for-SAS-Compatible-Systems
          
           /**********************************************************************************/   
           /*    C:\slc\current.lst     |     c:\slc\current.sas    |    c:\slc\current.log  */   
           /*                           |                           |                        */   
           /* ..                        |                           |                        */   
           /**********************************************************************************/   
     
      b. Set uo user tool
      
          Download the javascript in this repo, run_selectionpy.js(python) and run_selection(vanilla jenner)
          Save in C:\Program Files\IDM Computer Solutions\UltraEdit\scripts
          
      c.  Set up user tool
        
          Advanced>user tools>configure>insert
          
          Menu item: run_selectionpy

          Command line:
          
          jenner "c:/jnr/runsas_selection.sas" 
             -sasautos "c:/otojnr" 
             -log "c:/jnr/current.log" 
             -print "c:/jnr/current.lst" 
             -work "d:/wpswrk" 
             -rsasuser c:\etc 
             -autoexec c:/otojnr/autoexec.sas 
             && 
             python "c:/jnr/current.py" 
             >> "c:/jnr/current.lst" 
             2>> "c:/jnr/current.log"
             
             Note >> appends to existing log and list
          
          Working directory c:/jnr
          
          OK          
          
      d.  Link javascript to hotkey
          
          Advanced>all scripts>add
          Script: run_selectionpy.js
          HotKey: Ctrl+Alt+P   
          
          Close and Open Advanced>all scripts
          click on hotkey for run_selectionpy.js
          At the bottom you should see
          Current mapping assignment
          
          Highglight code and press Ctrl+Alt+P to run the highlighted code
          
          Check keyMapping                                                                                             
          Advanced>settings>keymapping                                                                                             
          Press new hotkey: Ctrl+Alt+P                                                                                             
          You should see 
          run_selectionpy.js                                                                                             
                                                                                                       
          You can also do this to run your highlighted code:
          Advanced>Play Script                                                                                             
          select run_selectionpy.js                                                                                             
        
      e. Save this in c:/jnr/dropDownPy.py
         
          data _null_;
            file "c:/jnr/current.py";
            input;
            put _infile_;
        
          Thats it!
          
      f.  Create these files
          
          c:/jnr/current.py 
          c:/jnr/py_current.lst 
          c:/jnr/py_current.log"
  ---*/ 

/******************************************************************************************************************/ 
/*  INPUT                                                                                                         */
/******************************************************************************************************************/ 
  
/*--- HIGHLIGHT AND RUN SCRIPT RUN_SELECTION.JS IF MAPPED TO CTRL+ALT+R - JUST PRESS CTRL+ALT+R  ---*/
libname workx sas7bdat "d:/wpswrkx";
data workx.classx;
 set sashelp.class;
run;  
 
/******************************************************************************************************************/ 
/* INPUT                                                                                                          */ 
/*      Obs     NAME  SEX  AGE  HEIGHT  WEIGHT                                                                    */                                 
/*    -----  -------  ---  ---  ------  ------                                                                    */                                 
/*        1  Amir     M     13    61.2      95                                                                    */                                 
/*        2  Bethany  F     14    63.8     105                                                                    */                                 
/*        3  Carlos   M     12    58.5      88                                                                    */                                 
/*        4  Diana    F     11      53    62.5                                                                    */                                 
/*        5  Ethan    M     15      68     130                                                                    */                                 
/*        6  Fiona    F     13    60.5      92                                                                    */                                 
/*        7  George   M     14    65.5     115                                                                    */                                 
/*        8  Hannah   F     12      57      78                                                                    */                                 
/*        9  Ivan     M     11    55.8      72                                                                    */                                 
/*       10  Julia    F     15      64     108                                                                    */                                 
/*       11  Kevin    M     16    70.5     145                                                                    */                                 
/*       12  Lily     F     14      62    97.5                                                                    */                                 
/*       13  Marco    M     12    59.3      85                                                                    */                                 
/*       14  Nadia    F     13    61.8      93                                                                    */                                 
/*       15  Oscar    M     15    67.2     128                                                                    */                                 
/*       16  Priya    F     12    55.5      75                                                                    */                                 
/*       17  Quinn    M     13      63     100                                                                    */                                 
/*       18  Rosa     F     11    52.5      58                                                                    */                                 
/*       19  Samuel   M     14      66     120                                                                    */                                 
/*                                                                                                                */ 
/******************************************************************************************************************/ 

/*--- HIGHLIGHT AND RUN SCRIPT RUN_SELECTION.JS IF MAPPED TO CTRL+ALT+R - JUST PRESS CTRL+ALT+R  ---*/
options nocenter;
proc print data=workx.classx;
title "Jenner Input";
run;

/******************************************************************************************************************/ 
/* 2. Jenner Proc SQL                                                                                             */ 
/******************************************************************************************************************/ 

proc sql;
   create
      table workx.classAvg as
   select
      sex
     ,avg(age)    as avgAge
     ,avg(height) as avgHgt    
     ,avg(weight) as avgWgt
   from
     workx.classx
   group
     by sex
 ;quit;
 
title;
options nocenter;
proc print data=workx.classAvg;
title "Jenner Proc SQL";
run; 

/******************************************************************************************************************/ 
/*  LIST Jenner Proc SQL                                                                                          */               
/*                                                                                                                */ 
/*    Obs  SEX         AVGAGE  AVGHGT         AVGWGT                                                              */                                           
/*      1  F    12.7777777778    58.9  85.4444444444                                                              */                                           
/*      2  M             13.5    63.5          107.8                                                              */                                                                                                       
/******************************************************************************************************************/ 

/******************************************************************************************************************/ 
/*  LOG                                                                                                           */ 
/*  NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.                                              */                                                        
/*  NOTE: Jenner v1.5.46 (build v1.5.46+0dff9f1347.20260806T035922Z.x86_64-pc-windows-msvc)                       */                                                                               
/*        Licensed to Roger DeAngelis, Serial 3BF7B3E6.                                                           */                                           
/*  Jenner v1.5.46                                                                                                */      
/*  Licensed to Roger DeAngelis                                                                                   */                   
/*  Serial: 3BF7B3E6                                                                                              */        
/*                                                                                                                */ 
/*  NOTE: DATA _null_                                                                                             */         
/*                                                                                                                */ 
/*  autexec started.                                                                                              */        
/*                                                                                                                */ 
/*  NOTE: Wrote _null_ (0 rows, 0 columns).                                                                       */                               
/*  NOTE: DATA elapsed:                                                                                           */           
/*    wall  0.00 seconds                                                                                          */            
/*    cpu   0.00 seconds                                                                                          */            
/*  NOTE: DATA _null_                                                                                             */         
/*                                                                                                                */ 
/*  LOG:  14:09:20                                                                                                */      
/*  NOTE: DATA _null_ completed. Output written to FILE PRINT                                                     */                                                 
/*  NOTE: Option SASAUTOS changed to c:/otojnr.                                                                   */                                   
/*  NOTE: Library WORKX assigned path=d:\wpswrkx.                                                                 */                                     
/*  NOTE: Library SASUSER assigned path=c:/etc.                                                                   */                                   
/*  NOTE: DATA _null_                                                                                             */         
/*                                                                                                                */ 
/*  autexec completed.                                                                                            */          
/*                                                                                                                */   
/*  NOTE: Wrote _null_ (0 rows, 0 columns).                                                                       */                               
/*  NOTE: DATA elapsed:                                                                                           */           
/*    wall  0.00 seconds                                                                                          */            
/*    cpu   0.00 seconds                                                                                          */            
/*  NOTE: PROC SQL                                                                                                */       
/*                                                                                                                */ 
/*  NOTE: Table workx.classAvg created.                                                                           */                           
/*  NOTE: PROC SQL statement used.                                                                                */                      
/*  NOTE: PROC PRINT data=workx.classAvg                                                                          */                            
/*                                                                                                                */ 
/* NOTE: PROC PRINT completed: 2 observations printed, 4 variables                                                */                                                            
/*                                                                                                                */                                                           
/******************************************************************************************************************/                                                                                                                                                                                  

/******************************************************************************************************************/ 
/* 3. PYTHON  (SQLITE)                                                                                            */ 
/******************************************************************************************************************/ 

title;
%include "dropDownPy.py";
cards4;
import logging
import time
import pandas as pd
import numpy as np
import pyreadstat as ps
from pandasql import PandaSQL
pdsql = PandaSQL(persist=True)
start = time.time()
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")
logging.info("Python Run started")
have, meta = ps.read_sas7bdat('d:/wpswrkx/classx.sas7bdat')
print(have)
want = pdsql('''
   select
      sex
     ,avg(age)    as avgAge
     ,avg(height) as avgHgt    
     ,avg(weight) as avgWgt
   from
     have
   group
     by sex
''')
print(want)
want.to_parquet("d:/parquet/classx.parquet", engine="pyarrow", compression=None, index=False)
logging.info(f"Python Run completed in {time.time() - start:.3f} seconds")
;;;;
run; 
 
/******************************************************************************************************************/ 
/*  PYTHON LIST: 14:41:43                                                                                         */         
/*         Name Sex   Age  Height  Weight                                                                         */                                
/*  0      Amir   M  13.0    61.2    95.0                                                                         */                                
/*  1   Bethany   F  14.0    63.8   105.0                                                                         */                                
/*  2    Carlos   M  12.0    58.5    88.0                                                                         */                                
/*  3     Diana   F  11.0    53.0    62.5                                                                         */                                
/*  4     Ethan   M  15.0    68.0   130.0                                                                         */                                
/*  5     Fiona   F  13.0    60.5    92.0                                                                         */                                
/*  6    George   M  14.0    65.5   115.0                                                                         */                                
/*  7    Hannah   F  12.0    57.0    78.0                                                                         */                                
/*  8      Ivan   M  11.0    55.8    72.0                                                                         */                                
/*  9     Julia   F  15.0    64.0   108.0                                                                         */                                
/*  10    Kevin   M  16.0    70.5   145.0                                                                         */                                
/*  11     Lily   F  14.0    62.0    97.5                                                                         */                                
/*  12    Marco   M  12.0    59.3    85.0                                                                         */                                
/*  13    Nadia   F  13.0    61.8    93.0                                                                         */                                
/*  14    Oscar   M  15.0    67.2   128.0                                                                         */                                
/*  15    Priya   F  12.0    55.5    75.0                                                                         */                                
/*  16    Quinn   M  13.0    63.0   100.0                                                                         */                                
/*  17     Rosa   F  11.0    52.5    58.0                                                                         */                                
/*  18   Samuel   M  14.0    66.0   120.0                                                                         */                                
/*                                                                                                                */ 
/*    Sex     avgAge  avgHgt      avgWgt                                                                          */                               
/*  0   F  12.777778    58.9   85.444444                                                                          */                               
/*  1   M  13.500000    63.5  107.800000                                                                          */                                          
/******************************************************************************************************************/                                                                                                                 
                                                                                                                      
/******************************************************************************************************************/ 
/*  PYTHON LOG (if there were errors you would see them here)                                                     */         
/*                                                                                                                */ 
/*  2026-08-27 14:41:45,449 - INFO - Python Run started                                                           */                                                  
/*  2026-08-27 14:41:45,747 - INFO - Python Run completed in 0.298 seconds                                        */                                                                     
/******************************************************************************************************************/ 
                                                                                                                     
/*--- END ---*/                                                                                                                     
                                                                                                                      
                                                                                                                      
                                                                                                                      
                                                                                                                      
                                                                                                                      
 
















































/******************************************************************************************************************/ 
/* LIST JENNER                                                                                                    */ 
/*                                                                                                                */ 
/*   LIST: 13:04:48                                                                                               */  
/*                                                                                                                */ 
/*     Obs     NAME  SEX  AGE  HEIGHT  WEIGHT                                                                     */                            
/*   -----  -------  ---  ---  ------  ------                                                                     */                            
/*       1  Amir     M     13    61.2      95                                                                     */                            
/*       2  Bethany  F     14    63.8     105                                                                     */                            
/*       3  Carlos   M     12    58.5      88                                                                     */                            
/*       4  Diana    F     11      53    62.5                                                                     */                            
/*       5  Ethan    M     15      68     130                                                                     */                            
/*       6  Fiona    F     13    60.5      92                                                                     */                            
/*       7  George   M     14    65.5     115                                                                     */                            
/*       8  Hannah   F     12      57      78                                                                     */                            
/*       9  Ivan     M     11    55.8      72                                                                     */                            
/*      10  Julia    F     15      64     108                                                                     */                            
/*      11  Kevin    M     16    70.5     145                                                                     */                            
/*      12  Lily     F     14      62    97.5                                                                     */                            
/*      13  Marco    M     12    59.3      85                                                                     */                            
/*      14  Nadia    F     13    61.8      93                                                                     */                            
/*      15  Oscar    M     15    67.2     128                                                                     */                            
/*      16  Priya    F     12    55.5      75                                                                     */                            
/*      17  Quinn    M     13      63     100                                                                     */                            
/*      18  Rosa     F     11    52.5      58                                                                     */                            
/*      19  Samuel   M     14      66     120                                                                     */                                                                                                                                     
/******************************************************************************************************************/ 

    
proc contents data="d:/parquet/classx.parquet"; 
run; 
 
/******************************************************************************************************************/ 
/*  LIST: 11:13:00                                                                                                */           
/*                                                                                                                */                    
/*  PROC CONTENTS                                                                                                 */                                                                                                                                                          
/*  -------------------------------------------------------------------------------                               */                                                                                                                                                                                                                            
/*                                                                                                                */                                                                                                                                             
/*  Data Set Name: d:/parquet/classx.parquet                                                                      */                                                                                                                                                                                     
/*  Observations:  2                                                                                              */                                                                                                                                                             
/*  Variables:     4                                                                                              */                                                                                                                                                             
/*                                                                                                                */                                                                                                                                             
/*  Variables (in alphabetical order):                                                                            */                                                                                                                                                                               
/*                                                                                                                */                                                                                                                                             
/*    #  Variable  Type    Len  Format  Label                                                                     */                                                                                                                                                                                      
/*  ---  --------  ----  -----  ------  -----                                                                     */                                                                                                                                                                                      
/*    1  AVGAGE     Num      8                                                                                    */                                                                                                                                                                                 
/*    2  AVGHGT     Num      8                                                                                    */                                                                                                                                                                                 
/*    3  AVGWGT     Num      8                                                                                    */                                                                                                                                                                                 
/*    4  SEX       Char    200                                                                                    */                                                                                                                                                                                 
/*                                                                                                                */                                                                                                                                             
/*  -------------------------------------------------------------------------------                               */                                                                                                                                                                                                                            
/******************************************************************************************************************/                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                    
/*******************************************************************************************************************/   
/*  LOG                                                                                                            */    
/*                                                                                                                 */ 
/*  NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.                                               */                                                                 
/*  NOTE: Jenner v1.5.46 (build v1.5.46+0dff9f1347.20260806T035922Z.x86_64-pc-windows-msvc)                        */                                                                                        
/*        Licensed to Roger DeAngelis, Serial 3BF7B3E6.                                                            */                                                    
/*  Jenner v1.5.46                                                                                                 */               
/*  Licensed to Roger DeAngelis                                                                                    */                            
/*  Serial: 3BF7B3E6                                                                                               */                 
/*                                                                                                                 */ 
/*  NOTE: DATA _null_                                                                                              */                  
/*                                                                                                                 */ 
/*  autexec started.                                                                                               */                 
/*                                                                                                                 */ 
/*  NOTE: Wrote _null_ (0 rows, 0 columns).                                                                        */                                        
/*  NOTE: DATA elapsed:                                                                                            */                    
/*    wall  0.00 seconds                                                                                           */                     
/*    cpu   0.00 seconds                                                                                           */                     
/*  NOTE: DATA _null_                                                                                              */                  
/*                                                                                                                 */ 
/*  LOG:  11:13:00                                                                                                 */               
/*  NOTE: DATA _null_ completed. Output written to FILE PRINT                                                      */                                                          
/*  NOTE: Option SASAUTOS changed to c:/otojnr.                                                                    */                                            
/*  NOTE: Library WORKX assigned path=d:\wpswrkx.                                                                  */                                              
/*  NOTE: Library SASUSER assigned path=c:/etc.                                                                    */                                            
/*  NOTE: DATA _null_                                                                                              */                  
/*                                                                                                                 */ 
/*  autexec completed.                                                                                             */                   
/*                                                                                                                 */ 
/*  NOTE: Wrote _null_ (0 rows, 0 columns).                                                                        */                                        
/*  NOTE: DATA elapsed:                                                                                            */                    
/*    wall  0.00 seconds                                                                                           */                     
/*    cpu   0.00 seconds                                                                                           */                     
/*  NOTE: PROC CONTENTS data=d:/parquet/classx.parquet                                                             */                                                   
/*                                                                                                                 */ 
/*  NOTE: PROC CONTENTS completed: 2 observations, 4 variables                                                     */                                                           
/*                                                                                                                 */ 
/*******************************************************************************************************************/  
 
/*--- 
 jenner "c:/jnr/current.sas" -sasautos "c:/otojnr" -log "c:/jnr/current.log" -print "c:/jnr/current.lst" -work "d:/wpswrk" -rsasuser c:\etc -autoexec c:/otojnr/autoexec.sas && python "c:/jnr/current.py" >> "c:/jnr/current.lst" 2> "c:/jnr/current.log"
 jenner "c:/jnr/current.sas" -sasautos "c:/otojnr" -log "c:/jnr/current.log" -print "c:/jnr/current.lst" -work "d:/wpswrk" -rsasuser c:\etc -autoexec c:/otojnr/autoexec.sas && python "c:/jnr/current.py" > "c:/jnr/py_current.lst" 2> "c:/jnr/py_current.log"
 ---*/
