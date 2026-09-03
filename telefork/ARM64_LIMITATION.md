# Telefork ARM64 Compatibility Test

## Test Environment

- Machine: session-source
- Operating system: Ubuntu Linux
- Architecture: aarch64
- Rust compiler: rustc 1.93.1
- Cargo: cargo 1.93.1
- Telefork commit: 2ec53fe128b6e5350e578c087b8f39d0900a7a04

## Result

The original Telefork implementation could not be compiled on ARM64.

The source code directly accesses x86-64 register fields, including:

- rax
- rdi
- rsi
- rdx
- r8
- r10
- rip

On ARM64, `user_regs_struct` instead exposes architecture-specific fields such
as:

- regs
- sp
- pc
- pstate

The build therefore failed with architecture-related Rust compiler errors.

## Conclusion

The original Telefork implementation targets x86-64 Linux and cannot run
unchanged on the current ARM64 Ubuntu virtual machines.

A complete ARM64 port would require changes to:

- register capture and restoration
- syscall argument registers
- syscall instruction injection
- ptrace handling
- architecture-specific syscall numbers

The next experiment will run the original Telefork implementation in an
x86-64 Linux environment.# Telefork ARM64 Build Limitation

Telefork was tested on:

- Architecture: aarch64
- Operating system: Ubuntu Linux
- Rust toolchain: rustc 1.93.1
- Source commit: 2ec53fe128b6e5350e578c087b8f39d0900a7a04

The original Telefork source did not compile on ARM64.

The implementation directly accesses x86-64 register fields such as:

- rip
- rax
- rdi
- rsi
- rdx

- r10
- r8
- r9

On ARM64, libc::user_regs_struct instead exposes fields including:

- regs
- sp
- pc
- pstate

The original implementation therefore requires either:

1. an x86-64 Linux environment, or
2. a substantial ARM64 port of its ptrace and syscall injection logic.

The next experiment will use an x86-64 Linux environment.
