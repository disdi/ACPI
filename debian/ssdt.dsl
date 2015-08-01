/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20140926-32 [Oct  1 2014]
 * Copyright (c) 2000 - 2014 Intel Corporation
 * 
 * Disassembly of ssdt.dat, Sat Aug  1 13:51:44 2015
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000008E7 (2279)
 *     Revision         0x01
 *     Checksum         0x0E
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "BXPCSSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("ssdt.aml", "SSDT", 1, "BOCHS ", "BXPCSSDT", 0x00000001)
{
    /*
     * iASL Warning: There were 2 external control methods found during
     * disassembly, but additional ACPI tables to resolve these externals
     * were not specified. This resulting disassembler output file may not
     * compile because the disassembler did not know how many arguments
     * to assign to these methods. To specify the tables needed to resolve
     * external control method references, the -e option can be used to
     * specify the filenames. Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (CPEJ, MethodObj)    // Warning: Unresolved method, guessing 2 arguments
    External (PCEJ, MethodObj)    // Warning: Unresolved method, guessing 2 arguments

    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.ISA_, DeviceObj)
    External (BNUM, UnknownObj)
    External (CPMA, IntObj)
    External (CPST, IntObj)
    External (PCID, UnknownObj)
    External (PCIU, UnknownObj)

    Scope (\)
    {
        Name (P0S, 0x08000000)
        Name (P0E, 0xFEBFFFFF)
        Name (P1V, 0x00)
        Name (P1S, Buffer (0x08)
        {
             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
        })
        Name (P1E, Buffer (0x08)
        {
             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
        })
        Name (P1L, Buffer (0x08)
        {
             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
        })
        Name (MDNR, 0x00000000)
    }

    Scope (\)
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            One, 
            One, 
            Zero, 
            Zero
        })
        Name (_S4, Package (0x04)  // _S4_: S4 System State
        {
            0x02, 
            0x02, 
            Zero, 
            Zero
        })
        Name (_S5, Package (0x04)  // _S5_: S5 System State
        {
            Zero, 
            Zero, 
            Zero, 
            Zero
        })
    }

    Scope (\_SB.PCI0.ISA)
    {
        Device (PEVT)
        {
            Name (_HID, "QEMU0001")  // _HID: Hardware ID
            Name (PEST, 0x0000)
            OperationRegion (PEOR, SystemIO, PEST, One)
            Field (PEOR, ByteAcc, NoLock, Preserve)
            {
                PEPT,   8
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (PEST, Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (RDPT, 0, NotSerialized)
            {
                Store (PEPT, Local0)
                Return (Local0)
            }

            Method (WRPT, 1, NotSerialized)
            {
                Store (Arg0, PEPT) /* \_SB_.PCI0.ISA_.PEVT.PEPT */
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0000,             // Range Minimum
                    0x0000,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    _Y00)
            })
            CreateWordField (_CRS, \_SB.PCI0.ISA.PEVT._Y00._MIN, IOMN)  // _MIN: Minimum Base Address
            CreateWordField (_CRS, \_SB.PCI0.ISA.PEVT._Y00._MAX, IOMX)  // _MAX: Maximum Base Address
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Store (PEST, IOMN) /* \_SB_.PCI0.ISA_.PEVT.IOMN */
                Store (PEST, IOMX) /* \_SB_.PCI0.ISA_.PEVT.IOMX */
            }
        }
    }

    Scope (_SB)
    {
        Processor (CP00, 0x00, 0x00000000, 0x00)
        {
            Name (ID, 0x00)
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Method (_MAT, 0, NotSerialized)  // _MAT: Multiple APIC Table Entry
            {
                Return (CPMA) /* External reference */
                ID
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (CPST) /* External reference */
                ID
            }

            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
            {
                CPEJ (ID, Arg0)
            }
        }

        Method (NTFY, 2, NotSerialized)
        {
            If (LEqual (Arg0, 0x00))
            {
                Notify (CP00, Arg1)
            }
        }

        Name (CPON, Package (0x01)
        {
            One
        })
        Scope (PCI0)
        {
            Name (BSEL, Zero)
            Device (S00)
            {
                Name (_ADR, 0x00000000)  // _ADR: Address
            }

            Device (S10)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
                {
                    Return (Zero)
                }

                Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                {
                    Return (Zero)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (Zero)
                }
            }

            Device (S18)
            {
                Name (_SUN, 0x03)  // _SUN: Slot User Number
                Name (_ADR, 0x00030000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S20)
            {
                Name (_SUN, 0x04)  // _SUN: Slot User Number
                Name (_ADR, 0x00040000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S28)
            {
                Name (_SUN, 0x05)  // _SUN: Slot User Number
                Name (_ADR, 0x00050000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S30)
            {
                Name (_SUN, 0x06)  // _SUN: Slot User Number
                Name (_ADR, 0x00060000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S38)
            {
                Name (_SUN, 0x07)  // _SUN: Slot User Number
                Name (_ADR, 0x00070000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S40)
            {
                Name (_SUN, 0x08)  // _SUN: Slot User Number
                Name (_ADR, 0x00080000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S48)
            {
                Name (_SUN, 0x09)  // _SUN: Slot User Number
                Name (_ADR, 0x00090000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S50)
            {
                Name (_SUN, 0x0A)  // _SUN: Slot User Number
                Name (_ADR, 0x000A0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S58)
            {
                Name (_SUN, 0x0B)  // _SUN: Slot User Number
                Name (_ADR, 0x000B0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S60)
            {
                Name (_SUN, 0x0C)  // _SUN: Slot User Number
                Name (_ADR, 0x000C0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S68)
            {
                Name (_SUN, 0x0D)  // _SUN: Slot User Number
                Name (_ADR, 0x000D0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S70)
            {
                Name (_SUN, 0x0E)  // _SUN: Slot User Number
                Name (_ADR, 0x000E0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S78)
            {
                Name (_SUN, 0x0F)  // _SUN: Slot User Number
                Name (_ADR, 0x000F0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S80)
            {
                Name (_SUN, 0x10)  // _SUN: Slot User Number
                Name (_ADR, 0x00100000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S88)
            {
                Name (_SUN, 0x11)  // _SUN: Slot User Number
                Name (_ADR, 0x00110000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S90)
            {
                Name (_SUN, 0x12)  // _SUN: Slot User Number
                Name (_ADR, 0x00120000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S98)
            {
                Name (_SUN, 0x13)  // _SUN: Slot User Number
                Name (_ADR, 0x00130000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SA0)
            {
                Name (_SUN, 0x14)  // _SUN: Slot User Number
                Name (_ADR, 0x00140000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SA8)
            {
                Name (_SUN, 0x15)  // _SUN: Slot User Number
                Name (_ADR, 0x00150000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SB0)
            {
                Name (_SUN, 0x16)  // _SUN: Slot User Number
                Name (_ADR, 0x00160000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SB8)
            {
                Name (_SUN, 0x17)  // _SUN: Slot User Number
                Name (_ADR, 0x00170000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SC0)
            {
                Name (_SUN, 0x18)  // _SUN: Slot User Number
                Name (_ADR, 0x00180000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SC8)
            {
                Name (_SUN, 0x19)  // _SUN: Slot User Number
                Name (_ADR, 0x00190000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SD0)
            {
                Name (_SUN, 0x1A)  // _SUN: Slot User Number
                Name (_ADR, 0x001A0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SD8)
            {
                Name (_SUN, 0x1B)  // _SUN: Slot User Number
                Name (_ADR, 0x001B0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SE0)
            {
                Name (_SUN, 0x1C)  // _SUN: Slot User Number
                Name (_ADR, 0x001C0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SE8)
            {
                Name (_SUN, 0x1D)  // _SUN: Slot User Number
                Name (_ADR, 0x001D0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SF0)
            {
                Name (_SUN, 0x1E)  // _SUN: Slot User Number
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SF8)
            {
                Name (_SUN, 0x1F)  // _SUN: Slot User Number
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Method (DVNT, 2, NotSerialized)
            {
                If (And (Arg0, 0x08))
                {
                    Notify (S18, Arg1)
                }

                If (And (Arg0, 0x10))
                {
                    Notify (S20, Arg1)
                }

                If (And (Arg0, 0x20))
                {
                    Notify (S28, Arg1)
                }

                If (And (Arg0, 0x40))
                {
                    Notify (S30, Arg1)
                }

                If (And (Arg0, 0x80))
                {
                    Notify (S38, Arg1)
                }

                If (And (Arg0, 0x0100))
                {
                    Notify (S40, Arg1)
                }

                If (And (Arg0, 0x0200))
                {
                    Notify (S48, Arg1)
                }

                If (And (Arg0, 0x0400))
                {
                    Notify (S50, Arg1)
                }

                If (And (Arg0, 0x0800))
                {
                    Notify (S58, Arg1)
                }

                If (And (Arg0, 0x1000))
                {
                    Notify (S60, Arg1)
                }

                If (And (Arg0, 0x2000))
                {
                    Notify (S68, Arg1)
                }

                If (And (Arg0, 0x4000))
                {
                    Notify (S70, Arg1)
                }

                If (And (Arg0, 0x8000))
                {
                    Notify (S78, Arg1)
                }

                If (And (Arg0, 0x00010000))
                {
                    Notify (S80, Arg1)
                }

                If (And (Arg0, 0x00020000))
                {
                    Notify (S88, Arg1)
                }

                If (And (Arg0, 0x00040000))
                {
                    Notify (S90, Arg1)
                }

                If (And (Arg0, 0x00080000))
                {
                    Notify (S98, Arg1)
                }

                If (And (Arg0, 0x00100000))
                {
                    Notify (SA0, Arg1)
                }

                If (And (Arg0, 0x00200000))
                {
                    Notify (SA8, Arg1)
                }

                If (And (Arg0, 0x00400000))
                {
                    Notify (SB0, Arg1)
                }

                If (And (Arg0, 0x00800000))
                {
                    Notify (SB8, Arg1)
                }

                If (And (Arg0, 0x01000000))
                {
                    Notify (SC0, Arg1)
                }

                If (And (Arg0, 0x02000000))
                {
                    Notify (SC8, Arg1)
                }

                If (And (Arg0, 0x04000000))
                {
                    Notify (SD0, Arg1)
                }

                If (And (Arg0, 0x08000000))
                {
                    Notify (SD8, Arg1)
                }

                If (And (Arg0, 0x10000000))
                {
                    Notify (SE0, Arg1)
                }

                If (And (Arg0, 0x20000000))
                {
                    Notify (SE8, Arg1)
                }

                If (And (Arg0, 0x40000000))
                {
                    Notify (SF0, Arg1)
                }

                If (And (Arg0, 0x80000000))
                {
                    Notify (SF8, Arg1)
                }
            }

            Method (PCNT, 0, NotSerialized)
            {
                Store (Zero, BNUM) /* External reference */
                DVNT (PCIU, One)
                DVNT (PCID, 0x03)
            }
        }
    }
}

