`timescale 1ns/1ps

module APB_memory_tb;

// Testbench signals
reg Pclk, Prst;
reg [31:0] Paddr;
reg Pselx, Penable, Pwrite;
reg [31:0] Pwdata;
wire Pready, Pslverr;
wire [31:0] Prdata;
wire [31:0] temp;

// Instantiate the design under test (DUT)
APB_memory dut (
    .Pclk(Pclk),
    .Prst(Prst),
    .Paddr(Paddr),
    .Pselx(Pselx),
    .Penable(Penable),
    .Pwrite(Pwrite),
    .Pwdata(Pwdata),
    .Pready(Pready),
    .Pslverr(Pslverr),
    .Prdata(Prdata),
    .temp(temp)
);

// Clock generation
initial begin
    Pclk = 0;
    forever #5 Pclk = ~Pclk; // 10ns clock period
end

// Test sequence
initial begin
    // Initialize inputs
    Prst = 0;
    Paddr = 0;
    Pselx = 0;
    Penable = 0;
    Pwrite = 0;
    Pwdata = 0;

    // Apply reset
    #10 Prst = 1;
    #10 Prst = 0; // Assert reset
    #10 Prst = 1; // Deassert reset

    // Write operation
    #10;
    Pselx = 1;
    Paddr = 5;
    Pwdata = 32'hDEADBEEF;
    Pwrite = 1;
    Penable = 0;
    #10 Penable = 1; // Enable access
    #10 Penable = 0;

    // Read operation
    #10;
    Pselx = 1;
    Paddr = 5;
    Pwrite = 0;
    Penable = 0;
    #10 Penable = 1; // Enable access
    #10 Penable = 0;

    // End of simulation
    #20;
    $finish;
end

// Monitor signals for debugging
initial begin
    $monitor("Time=%0t | Pclk=%b | Prst=%b | Paddr=%h | Pwdata=%h | Pwrite=%b | Pselx=%b | Penable=%b | Pready=%b | Prdata=%h | Pslverr=%b | temp=%h",
             $time, Pclk, Prst, Paddr, Pwdata, Pwrite, Pselx, Penable, Pready, Prdata, Pslverr, temp);
end

endmodule
