`timescale 1ns/100ps
`default_nettype none
`include "E15Process.v"

module E15Process_TB;

   reg clk = 0;

   E15Process proc(clk);

   always #1
     clk = ~clk;

   initial begin
      $dumpfile("E15Process_tb.vcd");
      $dumpvars(0, E15Process_TB);
      #1000

      $display("Final state of register file:\n\tr0=%d\n\tr1=%d\n\tr2=%d\n\tr3=%d", proc.r0, proc.r1, proc.r2, proc.r3);

      $finish;
   end

endmodule // E15ProcessTB

              
