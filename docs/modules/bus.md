# Bus (AXI-Lite)

AXI4-Lite bus interface modules.

---

## axi4_master

### NAME
axi4_master - AXI4-Lite master interface

### SYNOPSIS
```verilog
axi4_master instance_name (
    .axi_aclk(clk), .axi_rstn(rst_n), .enable(en),
    // Write address channel
    .m_axi_awaddr(awaddr), .m_axi_awvalid(awvalid), .s_axi_awready(awready),
    // Write data channel
    .m_axi_wdata(wdata), .m_axi_wstrb(wstrb), .m_axi_wvalid(wvalid), .s_axi_wready(wready),
    // Write response channel
    .s_axi_bresp(bresp), .s_axi_bvalid(bvalid), .m_axi_bready(bready),
    // Read address channel
    .m_axi_araddr(araddr), .m_axi_arvalid(arvalid), .s_axi_arready(arready),
    // Read data channel
    .s_axi_rdata(rdata), .s_axi_rvalid(rvalid), .s_axi_rresp(rresp), .m_axi_rready(rready)
);
```

### DESCRIPTION
AXI4-Lite master controller. Initiates read and write transactions on the AXI bus.

### PORTS

**Clock & Control:**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| axi_aclk | input | 1 | AXI clock |
| axi_rstn | input | 1 | Active-low reset |
| enable | input | 1 | Enable transactions |

**Write Address Channel (AW):**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| m_axi_awaddr | output | 32 | Write address |
| m_axi_awvalid | output | 1 | Write address valid |
| s_axi_awready | input | 1 | Slave ready for address |

**Write Data Channel (W):**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| m_axi_wdata | output | 32 | Write data |
| m_axi_wstrb | output | 4 | Write strobes (byte enables) |
| m_axi_wvalid | output | 1 | Write data valid |
| s_axi_wready | input | 1 | Slave ready for data |

**Write Response Channel (B):**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| s_axi_bresp | input | 2 | Write response |
| s_axi_bvalid | input | 1 | Response valid |
| m_axi_bready | output | 1 | Master ready for response |

**Read Address Channel (AR):**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| m_axi_araddr | output | 32 | Read address |
| m_axi_arvalid | output | 1 | Read address valid |
| s_axi_arready | input | 1 | Slave ready for address |

**Read Data Channel (R):**

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| s_axi_rdata | input | 32 | Read data |
| s_axi_rvalid | input | 1 | Read data valid |
| s_axi_rresp | input | 2 | Read response |
| m_axi_rready | output | 1 | Master ready for data |

---

## axi4_slave

### NAME
axi4_slave - AXI4-Lite slave interface

### SYNOPSIS
```verilog
axi4_slave instance_name (
    .axi_aclk(clk), .axi_rstn(rst_n),
    // AXI channels...
);
```

### DESCRIPTION
AXI4-Lite slave controller. Responds to read and write transactions from an AXI master.

---

## regs

### NAME
regs - AXI-accessible register bank

### DESCRIPTION
Memory-mapped register bank accessible via AXI4-Lite interface.

---

Location: `src/bus/axi_lite/`
