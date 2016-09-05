Approaches to Automatically Testing Visual Components
Richard B. Winston
CPCUG Programmers SIG
Nov. 1, 2006
rbwinst@usgs.gov
rbwinston@mindspring.com

--------------------------------------------------------------------------------
This software and related documentation were developed by
the U.S. Geological Survey (USGS) for use by the USGS in fulfilling its mission. 
The software can be used, copied, modified, and distributed without any fee 
or cost. Use of appropriate credit is requested. The software is provided as 
a minimum in source code form as used on USGS computers. In many cases, the 
executable runfiles also are provided for these computers.

The USGS provides no warranty, expressed or implied, as to the correctness 
of the furnished software or the suitability for any purpose. The software 
has been tested, but as with any complex software, there could be undetected 
errors. Users who find errors are requested to report them to the USGS. The 
USGS has limited resources to assist non-USGS users; however, we make an 
attempt to fix reported problems and help whenever possible.
--------------------------------------------------------------------------------

The most important unit in this demonstration of a method for testing visual 
components is "GuiTesterUnit.pas".  It is used in a DUnit project to test
two descendants of TStringGrid.  The components themselves are not of 
particularly great interest.  However, the code used to test the components
is interesting.

To run the test, you must first install the components.  They are in 
RbwDataGrid4.pas.  Then compile and run UnitTest1.exe in the DUnit subdirectory.
The tests will display, interact with and capture bitmaps of the components
in action.  Screen captures of the bitmaps will be compared with those in 
UnitTest1.bmpcollection.  Unless your computer is configured exactly the same
as the one on which UnitTest1.bmpcollection was created, the bitmap comparisons
will probably fail.  However, if you select the "scripted" option when starting
UnitTest1.exe, you will have an opportunity to compare the new and original 
bitmaps.  You will also be given a description of what the control should look 
like. Click Yes or No depending on whether the control looks like what it should 
look like.  When you click "Yes", the new bitmap will replace the old one in 
the collection (which will be saved when the application closes).  If you run the 
tests again.  All the bitmap comparisons for which you clicked "Yes" should now 
pass the test.

Do not move the mouse or press a key on the keyboard during the tests unless 
prompted to do so.

If you are interested in what the components can do, stop and restart 
UnitTest1.exe only this time select the "Manual" option.  Follow the on-screen 
instructions for each test.

If you select the "fully automatic" option when starting UnitTest1.exe, 
it will run without interruption even if the bitmap comparisons fail.
If a bitmap comparison fails, the test will fail.  (With the "scripted
option, if a bitmap comparison fails, you have to decide whether or not 
the test failed based on the on-screen instructions.