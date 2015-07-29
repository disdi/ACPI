/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20100528
 *
 * Disassembly of SSDT.dat, Thu Jul 30 00:54:02 2015
 *
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000008E7 (2279)
 *     Revision         0x01
 *     Checksum         0x96
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "BXPCSSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("SSDT.aml", "SSDT", 1, "BOCHS ", "BXPCSSDT", 0x00000001)
{
    External (PCID)
    External (PCIU)
    External (BNUM)
    External (PCEJ, MethodObj)    // 2 Arguments
    External (CPEJ, MethodObj)    // 2 Arguments
    External (CPST, IntObj)
    External (CPMA, IntObj)
    External (\_SB_.PCI0.ISA_, DeviceObj)

    Scope (\)
    {
        Name (P0S, 0x80000000)
        Name (P0E, 0xFEBFFFFF)
        Name (P1V, 0x00)
        Name (P1S, Buffer (0x08)
        {
            /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        })
        Name (P1E, Buffer (0x08)
        {
            /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        })
        Name (P1L, Buffer (0x08)
        {
            /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        })
        Name (MDNR, 0x00000000)
    }

    Scope (\)
    {
        Name (_S3, Package (0x04)
        {
            One, 
            One, 
            Zero, 
            Zero
        })
        Name (_S4, Package (0x04)
        {
            0x02, 
            0x02, 
            Zero, 
            Zero
        })
        Name (_S5, Package (0x04)
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
            Name (_HID, "QEMU0001")
            Name (PEST, 0x0000)
            OperationRegion (PEOR, SystemIO, PEST, One)
            Field (PEOR, ByteAcc, NoLock, Preserve)
            {
                PEPT,   8
            }

            Method (_STA, 0, NotSerialized)
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
                Store (Arg0, PEPT)
            }

            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0000,             // Range Minimum
                    0x0000,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
            })
            CreateWordField (_CRS, 0x02, IOMN)
            CreateWordField (_CRS, 0x04, IOMX)
            Method (_INI, 0, NotSerialized)
            {
                Store (PEST, IOMN)
                Store (PEST, IOMX)
            }
        }
    }

    Scope (_SB)
    {
        Processor (CP00, 0x00, 0x00000000, 0x00)
        {
            Name (ID, 0x00)
            Name (_HID, "ACPI0007")
            Method (_MAT, 0, NotSerialized)
            {
                Return (CPMA)
                ID
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (CPST)
                ID
            }

            Method (_EJ0, 1, NotSerialized)
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
                Name (_ADR, 0x00000000)
            }

            Device (S10)
            {
                Name (_ADR, 0x00020000)
                Method (_S1D, 0, NotSerialized)
                {
                    Return (Zero)
                }

                Method (_S2D, 0, NotSerialized)
                {
                    Return (Zero)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (Zero)
                }
            }

            Device (S18)
            {
                Name (_SUN, 0x03)
                Name (_ADR, 0x00030000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S20)
            {
                Name (_SUN, 0x04)
                Name (_ADR, 0x00040000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S28)
            {
                Name (_SUN, 0x05)
                Name (_ADR, 0x00050000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S30)
            {
                Name (_SUN, 0x06)
                Name (_ADR, 0x00060000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S38)
            {
                Name (_SUN, 0x07)
                Name (_ADR, 0x00070000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S40)
            {
                Name (_SUN, 0x08)
                Name (_ADR, 0x00080000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S48)
            {
                Name (_SUN, 0x09)
                Name (_ADR, 0x00090000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S50)
            {
                Name (_SUN, 0x0A)
                Name (_ADR, 0x000A0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S58)
            {
                Name (_SUN, 0x0B)
                Name (_ADR, 0x000B0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S60)
            {
                Name (_SUN, 0x0C)
                Name (_ADR, 0x000C0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S68)
            {
                Name (_SUN, 0x0D)
                Name (_ADR, 0x000D0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S70)
            {
                Name (_SUN, 0x0E)
                Name (_ADR, 0x000E0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S78)
            {
                Name (_SUN, 0x0F)
                Name (_ADR, 0x000F0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S80)
            {
                Name (_SUN, 0x10)
                Name (_ADR, 0x00100000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S88)
            {
                Name (_SUN, 0x11)
                Name (_ADR, 0x00110000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S90)
            {
                Name (_SUN, 0x12)
                Name (_ADR, 0x00120000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (S98)
            {
                Name (_SUN, 0x13)
                Name (_ADR, 0x00130000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SA0)
            {
                Name (_SUN, 0x14)
                Name (_ADR, 0x00140000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SA8)
            {
                Name (_SUN, 0x15)
                Name (_ADR, 0x00150000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SB0)
            {
                Name (_SUN, 0x16)
                Name (_ADR, 0x00160000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SB8)
            {
                Name (_SUN, 0x17)
                Name (_ADR, 0x00170000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SC0)
            {
                Name (_SUN, 0x18)
                Name (_ADR, 0x00180000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SC8)
            {
                Name (_SUN, 0x19)
                Name (_ADR, 0x00190000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SD0)
            {
                Name (_SUN, 0x1A)
                Name (_ADR, 0x001A0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SD8)
            {
                Name (_SUN, 0x1B)
                Name (_ADR, 0x001B0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SE0)
            {
                Name (_SUN, 0x1C)
                Name (_ADR, 0x001C0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SE8)
            {
                Name (_SUN, 0x1D)
                Name (_ADR, 0x001D0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SF0)
            {
                Name (_SUN, 0x1E)
                Name (_ADR, 0x001E0000)
                Method (_EJ0, 1, NotSerialized)
                {
                    PCEJ (BSEL, _SUN)
                }
            }

            Device (SF8)
            {
                Name (_SUN, 0x1F)
                Name (_ADR, 0x001F0000)
                Method (_EJ0, 1, NotSerialized)
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
                Store (Zero, BNUM)
                DVNT (PCIU, One)
                DVNT (PCID, 0x03)
            }
        }
    }
}

