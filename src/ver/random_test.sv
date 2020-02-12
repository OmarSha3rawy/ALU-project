/* 
// Module: random_test.sv 
// Project: simple ALU project
// Description: create enviroment instance
// Owner : Omar Adel Abbas Sayed
// Version : 1.0 
// Date : 1 February 2020
// History : 
// // --------------------------- 
*/

`include "enviroment.sv"
program test(intf intf);
  parameter NUM_OF_SAMPLES = 10;
  //declaring environment instance
  environment env;
   
  initial begin
    //creating environment
    env = new(intf);
     
    //setting the repeat count of generator as 10, means to generate 10 packets
    env.gen.repeat_count = NUM_OF_SAMPLES;
     
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram