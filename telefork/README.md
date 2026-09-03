# Level 4 - Telefork Process Migration

This directory is reserved for studying and reproducing Telefork-based
cross-machine process migration.

The existing CRIU implementation is preserved separately in:

~/docker-checkpoint-demo/level3/final_criu_working

## Planned Work

1. Obtain the Telefork source code.
2. Review its architecture and dependencies.
3. Compile it on the ARM64 Ubuntu virtual machines.
4. Run the original example locally.
5. Test process transfer between session-source and session-target.
6. Compare Telefork with the completed CRIU implementation.

