# APB Bus Protocol

The Advanced Peripheral Bus (APB) is a part of the AMBA (Advanced Microcontroller Bus Architecture) family, designed for low-power and low-bandwidth communication between the processor and peripheral components. It is commonly used in microcontrollers and SoCs for interfacing with peripherals such as timers, UARTs, and GPIOs.

## Key Features

- **Low Complexity:** Simplified protocol for easy implementation.
- **Low Power Consumption:** Suitable for peripherals that do not require high bandwidth.
- **Single Clock Operation:** Operates with a single clock cycle for control, read, and write operations.
- **Ease of Integration:** Seamless integration with other AMBA protocols, such as AHB or AXI.

## APB Bus Signals

The APB bus uses the following key signals:

1. **PCLK:** Peripheral clock signal.
2. **PRESETn:** Active-low reset signal.
3. **PADDR:** Address bus for accessing specific registers or peripherals.
4. **PWRITE:** Write signal (1 for write, 0 for read).
5. **PENABLE:** Enables the transfer of data.
6. **PWDATA:** Data bus for writing to peripherals.
7. **PRDATA:** Data bus for reading from peripherals.
8. **PSEL:** Select signal for the target peripheral.
9. **PSLVERR:** Indicates transfer errors (optional).

## APB Protocol Phases

1. **Idle Phase:**
   - No transaction is initiated.
   - PSEL = 0, PENABLE = 0.

2. **Setup Phase:**
   - The address, control signals, and write data are driven.
   - PSEL is asserted, but PENABLE remains low.

3. **Access Phase:**
   - PENABLE is asserted high to indicate the active transfer.
   - The target peripheral processes the request and responds with data (for read) or acknowledges the write.

4. **Completion Phase:**
   - The transfer completes, and signals are de-asserted.

## Applications

- Interfacing low-bandwidth peripherals like UART, I2C, and GPIO.
- Configuring control registers in various peripheral modules.
- Low-power applications in embedded systems and SoCs.

## Advantages

- Simplified design and implementation.
- Efficient for low-bandwidth peripheral communication.
- Scalable and compatible with higher-performance AMBA protocols.

## Example Implementation

Refer to the `apb_driver.v` and `apb_slave.v` files in this repository for a Verilog-based implementation of the APB protocol. The testbench demonstrates typical read and write operations and validates the protocol's functionality.

## References

- [AMBA Specification by ARM](https://developer.arm.com/documentation/ihi0024/latest)
- Embedded system design textbooks and resources.

Feel free to explore the repository and contribute to the project!

