3 address pin input (000,001,...,111) correspond to nibble number (0,1,...,7).

Both read and write operation of the circuit will take multiple ticks (2 ticks).

The buffer connect to the output register is to make sure the data will be sent to the output register before the clock signal.

The falling-edge T flip flop build by D flip flop in the register is to seperate the write and read tick of the register.