VM Torture Test
===============

Testing relative performance of VMware Desktop and VirtualBox for the same load.

Results
-------

|   Test Name   | Bare Metal | VMware | VirtualBox
|---------------|------------|--------|-----------
| Kernel 1 CPU  |            |        |
| Kernel 2 CPUs |            |        |

Tests
-----

* Kernels/hour 1 CPU
  Compiles Linux Kernel 4.4.44 for an hour on a single CPU VM.  
  Reports number of completed compiles, plus seconds over an hour.

* Kernels/hour 2 CPUs
  Compiles Linux Kernel 4.4.44 for an hour on a two CPU VM.  
  Reports number of complete compiles, plus seconds over an hour.

Method
------

1. Create VM
2. Clone repo
3. Run install script
4. Run test suite
