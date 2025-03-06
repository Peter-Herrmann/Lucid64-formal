
`include "Lucid64.vh"


module rvfi_wrapper # (
    parameter VADDR      =`ADDRESS_WD, 
    parameter RESET_ADDR =`RESET_VECTOR 
) (
    input                   clock,
    input                   reset,

    `RVFI_OUTPUTS
);

    (* keep *) `rvformal_rand_reg             m_ext_inter_i;
    (* keep *) `rvformal_rand_reg             m_soft_inter_i;
    (* keep *) `rvformal_rand_reg             m_timer_inter_i;
    (* keep *) `rvformal_rand_reg [`XLEN-1:0] time_i;
    (* keep *) `rvformal_rand_reg             imem_gnt_i;
    (* keep *) `rvformal_rand_reg             imem_rvalid_i;
    (* keep *) `rvformal_rand_reg [31:0]      imem_rdata_i;
    (* keep *) `rvformal_rand_reg             dmem_gnt_i;
    (* keep *) `rvformal_rand_reg             dmem_rvalid_i;
    (* keep *) `rvformal_rand_reg [`XLEN-1:0] dmem_rdata_i;

    (* keep *) wire                           fencei_flush_ao;
    (* keep *) wire                           imem_req_o;
    (* keep *) wire               [VADDR-1:0] imem_addr_ao;
    (* keep *) wire                           dmem_req_o;
    (* keep *) wire               [VADDR-1:0] dmem_addr_ao;
    (* keep *) wire                           dmem_we_ao;
    (* keep *) wire                [7:0]      dmem_be_ao;
    (* keep *) wire               [`XLEN-1:0] dmem_wdata_ao;


    Lucid64 #(
        .VADDR              (VADDR),
        .RESET_ADDR         (RESET_ADDR)
    ) DUT (
        .clk_i              (clock),
        .rst_ni             (~reset),

        .m_ext_inter_i      (`TODO_DUMMY),
        .m_soft_inter_i     (`TODO_DUMMY),
        .m_timer_inter_i    (`TODO_DUMMY),

        .time_i             (time_i),

        .fencei_flush_ao    (fencei_flush_ao),

        // Instruction Memory Interface (RI5CY subset of OBI, read-only)
        .imem_req_o         (imem_req_o),
        .imem_gnt_i         (imem_gnt_i),
        .imem_addr_ao       (imem_addr_ao),

        .imem_rvalid_i      (imem_rvalid_i),
        .imem_rdata_i       (imem_rdata_i),

        // Data Memory Interface (RI5CY subset of OBI, read-write)
        .dmem_req_o         (dmem_req_o),
        .dmem_gnt_i         (dmem_gnt_i),
        .dmem_addr_ao       (dmem_addr_ao),
        .dmem_we_ao         (dmem_we_ao),
        .dmem_be_ao         (dmem_be_ao),
        .dmem_wdata_ao      (dmem_wdata_ao),

        .dmem_rvalid_i      (dmem_rvalid_i),
        .dmem_rdata_i       (dmem_rdata_i),
        
        .rvfi_valid         (rvfi_valid),
        .rvfi_order         (rvfi_order),
        .rvfi_insn          (rvfi_insn),
        .rvfi_trap          (rvfi_trap),
        .rvfi_halt          (rvfi_halt),
        .rvfi_intr          (rvfi_intr),
        .rvfi_mode          (rvfi_mode),
        .rvfi_ixl           (rvfi_ixl),
        .rvfi_rs1_addr      (rvfi_rs1_addr),
        .rvfi_rs2_addr      (rvfi_rs2_addr),
        .rvfi_rs1_rdata     (rvfi_rs1_rdata),
        .rvfi_rs2_rdata     (rvfi_rs2_rdata),
        .rvfi_rd_addr       (rvfi_rd_addr),
        .rvfi_rd_wdata      (rvfi_rd_wdata),
        .rvfi_pc_rdata      (rvfi_pc_rdata),
        .rvfi_pc_wdata      (rvfi_pc_wdata),
        .rvfi_mem_addr      (rvfi_mem_addr),
        .rvfi_mem_rmask     (rvfi_mem_rmask),
        .rvfi_mem_wmask     (rvfi_mem_wmask),
        .rvfi_mem_rdata     (rvfi_mem_rdata),
        .rvfi_mem_wdata     (rvfi_mem_wdata),
    );


    ///////////////////////////////////////////////////////////////////////////////////////////////
    ////                               Memory Interface Timeouts                               ////
    ///////////////////////////////////////////////////////////////////////////////////////////////

`ifndef IMEM_TIMEOUT
    `define IMEM_TIMEOUT 5
`endif

`ifndef DMEM_TIMEOUT
    `define DMEM_TIMEOUT 5
`endif


    localparam IMEM_TIMEOUT = `IMEM_TIMEOUT;
    localparam DMEM_TIMEOUT = `DMEM_TIMEOUT;



endmodule
