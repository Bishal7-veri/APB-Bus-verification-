
module APB_memory (Pclk, Prst, Paddr, Pselx, Penable, Pwrite, Pwdata, Pready, Pslverr, Prdata, temp);
// input signals of APB memory

input Pclk, Prst;
input [31:0] Paddr;
input Pselx;
input Penable;
input Pwrite;
input [31:0] Pwdata;
// output signals of APB memory

output reg Pready;
output reg Pslverr;
output reg [31:0] Prdata;
output reg [31:0] temp;

// memory declaration

reg [31:0] mem [31:0];

// state declaration

parameter [1:0] idle = 2'b00;
parameter [1:0] setup = 2'b01;
parameter [1:0] access = 2'b10;

// state declaration

reg [1:0] present_state, next_state;

// asynchronous active low reset

always @ (posedge Pclk or negedge Prst)
begin
    if(Prst == 0) begin
                    present_state <= idle;
                    next_state <= present_state;
                  end 
     else
        present_state <= next_state;
end

always @(*)
begin
case(present_state)
idle : begin
        if(Pselx & !Penable)
        next_state <= setup;
        end
 setup : begin
            if(Penable & Pselx) begin
            Pready = 1;
            next_state = access;
            end
            else 
            next_state <= idle;
        end
        
 access : begin
            if(Pwrite == 1)
            begin
                mem[Paddr] = Pwdata;
                temp = mem[Paddr];
                Pslverr = 0;
            end
            else 
            begin
                Prdata = mem[Paddr];
                temp = mem[Paddr];
                Pslverr = 0;
            end 
            if (!Penable & !Pselx)
            begin
                next_state = idle;
                Pready = 0;
            end
          end
   endcase
end
   initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
