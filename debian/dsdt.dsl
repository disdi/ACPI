/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20140926-32 [Oct  1 2014]
 * Copyright (c) 2000 - 2014 Intel Corporation
 * 
 * Disassembly of dsdt.dat, Sat Aug  1 13:51:02 2015
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00000E08 (3592)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0x64
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "BXPCDSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("dsdt.aml", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
{
    /*
     * iASL Warning: There were 3 external control methods found during
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
    External (_SB_.PCI0.PCNT, MethodObj)    // Warning: Unresolved method, guessing 0 arguments
    External (MTFY, MethodObj)    // Warning: Unresolved method, guessing 2 arguments
    External (NTFY, MethodObj)    // Warning: Unresolved method, guessing 2 arguments

    External (CPON, UnknownObj)
    External (MDNR, UnknownObj)
    External (P0E_, IntObj)
    External (P0S_, IntObj)
    External (P1E_, IntObj)
    External (P1L_, IntObj)
    External (P1S_, IntObj)
    External (P1V_, UnknownObj)

    Scope (\)
    {
        OperationRegion (DBG, SystemIO, 0x0402, One)
        Field (DBG, ByteAcc, NoLock, Preserve)
        {
            DBGB,   8
        }

        Method (DBUG, 1, NotSerialized)
        {
            ToHexString (Arg0, Local0)
            ToBuffer (Local0, Local0)
            Subtract (SizeOf (Local0), One, Local1)
            Store (Zero, Local2)
            While (LLess (Local2, Local1))
            {
                Store (DerefOf (Index (Local0, Local2)), DBGB) /* \DBGB */
                Increment (Local2)
            }

            Store (0x0A, DBGB) /* \DBGB */
        }
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
            Name (_ADR, Zero)  // _ADR: Address
            Name (_UID, One)  // _UID: Unique ID
        }
    }

    Scope (_SB.PCI0)
    {
        Name (CRES, ResourceTemplate ()
        {
            WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x00FF,             // Range Maximum
                0x0000,             // Translation Offset
                0x0100,             // Length
                ,, )
            IO (Decode16,
                0x0CF8,             // Range Minimum
                0x0CF8,             // Range Maximum
                0x01,               // Alignment
                0x08,               // Length
                )
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x0CF7,             // Range Maximum
                0x0000,             // Translation Offset
                0x0CF8,             // Length
                ,, , TypeStatic)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0D00,             // Range Minimum
                0xADFF,             // Range Maximum
                0x0000,             // Translation Offset
                0xA100,             // Length
                ,, , TypeStatic)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0xAE0F,             // Range Minimum
                0xAEFF,             // Range Maximum
                0x0000,             // Translation Offset
                0x00F1,             // Length
                ,, , TypeStatic)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0xAF20,             // Range Minimum
                0xAFDF,             // Range Maximum
                0x0000,             // Translation Offset
                0x00C0,             // Length
                ,, , TypeStatic)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0xAFE4,             // Range Minimum
                0xFFFF,             // Range Maximum
                0x0000,             // Translation Offset
                0x501C,             // Length
                ,, , TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0x000A0000,         // Range Minimum
                0x000BFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x00020000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                0x00000000,         // Granularity
                0xE0000000,         // Range Minimum
                0xFEBFFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x1EC00000,         // Length
                ,, _Y00, AddressRangeMemory, TypeStatic)
        })
        Name (CR64, ResourceTemplate ()
        {
            QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x0000000000000000, // Granularity
                0x0000008000000000, // Range Minimum
                0x000000FFFFFFFFFF, // Range Maximum
                0x0000000000000000, // Translation Offset
                0x0000008000000000, // Length
                ,, _Y01, AddressRangeMemory, TypeStatic)
        })
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateDWordField (CRES, \_SB.PCI0._Y00._MIN, PS32)  // _MIN: Minimum Base Address
            CreateDWordField (CRES, \_SB.PCI0._Y00._MAX, PE32)  // _MAX: Maximum Base Address
            CreateDWordField (CRES, \_SB.PCI0._Y00._LEN, PL32)  // _LEN: Length
            Store (P0S, PS32) /* \_SB_.PCI0._CRS.PS32 */
            Store (P0E, PE32) /* \_SB_.PCI0._CRS.PE32 */
            Store (Add (Subtract (P0E, P0S), One), PL32) /* \_SB_.PCI0._CRS.PL32 */
            If (LEqual (P1V, Zero))
            {
                Return (CRES) /* \_SB_.PCI0.CRES */
            }

            CreateQWordField (CR64, \_SB.PCI0._Y01._MIN, PS64)  // _MIN: Minimum Base Address
            CreateQWordField (CR64, \_SB.PCI0._Y01._MAX, PE64)  // _MAX: Maximum Base Address
            CreateQWordField (CR64, \_SB.PCI0._Y01._LEN, PL64)  // _LEN: Length
            Store (P1S, PS64) /* \_SB_.PCI0._CRS.PS64 */
            Store (P1E, PE64) /* \_SB_.PCI0._CRS.PE64 */
            Store (P1L, PL64) /* \_SB_.PCI0._CRS.PL64 */
            ConcatenateResTemplate (CRES, CR64, Local0)
            Return (Local0)
        }
    }

    Scope (_SB)
    {
        Device (HPET)
        {
            Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            OperationRegion (HPTM, SystemMemory, 0xFED00000, 0x0400)
            Field (HPTM, DWordAcc, Lock, Preserve)
            {
                VEND,   32, 
                PRD,    32
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (VEND, Local0)
                Store (PRD, Local1)
                ShiftRight (Local0, 0x10, Local0)
                If (LOr (LEqual (Local0, Zero), LEqual (Local0, 0xFFFF)))
                {
                    Return (Zero)
                }

                If (LOr (LEqual (Local1, Zero), LGreater (Local1, 0x05F5E100)))
                {
                    Return (Zero)
                }

                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadOnly,
                    0xFED00000,         // Address Base
                    0x00000400,         // Address Length
                    )
            })
        }
    }

    Scope (_SB.PCI0)
    {
        Device (PX13)
        {
            Name (_ADR, 0x00010003)  // _ADR: Address
            OperationRegion (P13C, PCI_Config, Zero, 0xFF)
        }
    }

    Scope (_SB.PCI0)
    {
        Device (ISA)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
            OperationRegion (P40C, PCI_Config, 0x60, 0x04)
            Field (^PX13.P13C, AnyAcc, NoLock, Preserve)
            {
                Offset (0x5F), 
                    ,   7, 
                LPEN,   1, 
                Offset (0x67), 
                    ,   3, 
                CAEN,   1, 
                    ,   3, 
                CBEN,   1
            }

            Name (FDEN, One)
        }
    }

    Scope (_SB.PCI0.ISA)
    {
        Device (SMC)
        {
            Name (_HID, EisaId ("APP0001"))  // _HID: Hardware ID
            Name (_STA, 0x00)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0300,             // Range Minimum
                    0x0300,             // Range Maximum
                    0x01,               // Alignment
                    0x20,               // Length
                    )
                IRQNoFlags ()
                    {6}
            })
        }

        Device (RTC)
        {
            Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0070,             // Range Minimum
                    0x0070,             // Range Maximum
                    0x10,               // Alignment
                    0x02,               // Length
                    )
                IRQNoFlags ()
                    {8}
                IO (Decode16,
                    0x0072,             // Range Minimum
                    0x0072,             // Range Maximum
                    0x02,               // Alignment
                    0x06,               // Length
                    )
            })
        }

        Device (KBD)
        {
            Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0060,             // Range Minimum
                    0x0060,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
                IO (Decode16,
                    0x0064,             // Range Minimum
                    0x0064,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
                IRQNoFlags ()
                    {1}
            })
        }

        Device (MOU)
        {
            Name (_HID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IRQNoFlags ()
                    {12}
            })
        }

        Device (FDC0)
        {
            Name (_HID, EisaId ("PNP0700"))  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (FDEN, Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x03F2,             // Range Minimum
                    0x03F2,             // Range Maximum
                    0x00,               // Alignment
                    0x04,               // Length
                    )
                IO (Decode16,
                    0x03F7,             // Range Minimum
                    0x03F7,             // Range Maximum
                    0x00,               // Alignment
                    0x01,               // Length
                    )
                IRQNoFlags ()
                    {6}
                DMA (Compatibility, NotBusMaster, Transfer8, )
                    {2}
            })
        }

        Device (LPT)
        {
            Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (LPEN, Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0378,             // Range Minimum
                    0x0378,             // Range Maximum
                    0x08,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {7}
            })
        }

        Device (COM1)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (CAEN, Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x03F8,             // Range Minimum
                    0x03F8,             // Range Maximum
                    0x00,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {4}
            })
        }

        Device (COM2)
        {
            Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (CBEN, Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x02F8,             // Range Minimum
                    0x02F8,             // Range Maximum
                    0x00,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {3}
            })
        }
    }

    Scope (_SB.PCI0)
    {
        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
        {
            PCIU,   32, 
            PCID,   32
        }

        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
        {
            B0EJ,   32
        }

        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
        {
            BNUM,   32
        }

        Mutex (BLCK, 0x00)
        Method (PCEJ, 2, NotSerialized)
        {
            Acquire (BLCK, 0xFFFF)
            Store (Arg0, BNUM) /* \_SB_.PCI0.BNUM */
            Store (ShiftLeft (One, Arg1), B0EJ) /* \_SB_.PCI0.B0EJ */
            Release (BLCK)
            Return (Zero)
        }
    }

    Scope (_SB)
    {
        Scope (PCI0)
        {
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                Store (Package (0x80) {}, Local0)
                Store (Zero, Local1)
                While (LLess (Local1, 0x80))
                {
                    Store (ShiftRight (Local1, 0x02), Local2)
                    Store (And (Add (Local1, Local2), 0x03), Local3)
                    If (LEqual (Local3, Zero))
                    {
                        Store (Package (0x04)
                            {
                                Zero, 
                                Zero, 
                                LNKD, 
                                Zero
                            }, Local4)
                    }

                    If (LEqual (Local3, One))
                    {
                        If (LEqual (Local1, 0x04))
                        {
                            Store (Package (0x04)
                                {
                                    Zero, 
                                    Zero, 
                                    LNKS, 
                                    Zero
                                }, Local4)
                        }
                        Else
                        {
                            Store (Package (0x04)
                                {
                                    Zero, 
                                    Zero, 
                                    LNKA, 
                                    Zero
                                }, Local4)
                        }
                    }

                    If (LEqual (Local3, 0x02))
                    {
                        Store (Package (0x04)
                            {
                                Zero, 
                                Zero, 
                                LNKB, 
                                Zero
                            }, Local4)
                    }

                    If (LEqual (Local3, 0x03))
                    {
                        Store (Package (0x04)
                            {
                                Zero, 
                                Zero, 
                                LNKC, 
                                Zero
                            }, Local4)
                    }

                    Store (Or (ShiftLeft (Local2, 0x10), 0xFFFF), Index (Local4, 
                        Zero))
                    Store (And (Local1, 0x03), Index (Local4, One))
                    Store (Local4, Index (Local0, Local1))
                    Increment (Local1)
                }

                Return (Local0)
            }
        }

        Field (PCI0.ISA.P40C, ByteAcc, NoLock, Preserve)
        {
            PRQ0,   8, 
            PRQ1,   8, 
            PRQ2,   8, 
            PRQ3,   8
        }

        Method (IQST, 1, NotSerialized)
        {
            If (And (0x80, Arg0))
            {
                Return (0x09)
            }

            Return (0x0B)
        }

        Method (IQCR, 1, Serialized)
        {
            Name (PRR0, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, _Y02)
                {
                    0x00000000,
                }
            })
            CreateDWordField (PRR0, \_SB.IQCR._Y02._INT, PRRI)  // _INT: Interrupts
            If (LLess (Arg0, 0x80))
            {
                Store (Arg0, PRRI) /* \_SB_.IQCR.PRRI */
            }

            Return (PRR0) /* \_SB_.IQCR.PRR0 */
        }

        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQ0))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Or (PRQ0, 0x80, PRQ0) /* \_SB_.PRQ0 */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQ0))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                Store (PRRI, PRQ0) /* \_SB_.PRQ0 */
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQ1))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Or (PRQ1, 0x80, PRQ1) /* \_SB_.PRQ1 */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQ1))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                Store (PRRI, PRQ1) /* \_SB_.PRQ1 */
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQ2))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Or (PRQ2, 0x80, PRQ2) /* \_SB_.PRQ2 */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQ2))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                Store (PRRI, PRQ2) /* \_SB_.PRQ2 */
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000005,
                    0x0000000A,
                    0x0000000B,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (IQST (PRQ3))
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                Or (PRQ3, 0x80, PRQ3) /* \_SB_.PRQ3 */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (IQCR (PRQ3))
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateDWordField (Arg0, 0x05, PRRI)
                Store (PRRI, PRQ3) /* \_SB_.PRQ3 */
            }
        }

        Device (LNKS)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                {
                    0x00000009,
                }
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (_PRS) /* \_SB_.LNKS._PRS */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
            }
        }
    }

    Scope (_SB)
    {
        Method (CPMA, 1, NotSerialized)
        {
            Store (DerefOf (Index (CPON, Arg0)), Local0)
            Store (Buffer (0x08)
                {
                     0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                }, Local1)
            Store (Arg0, Index (Local1, 0x02))
            Store (Arg0, Index (Local1, 0x03))
            Store (Local0, Index (Local1, 0x04))
            Return (Local1)
        }

        Method (CPST, 1, NotSerialized)
        {
            Store (DerefOf (Index (CPON, Arg0)), Local0)
            If (Local0)
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (CPEJ, 2, NotSerialized)
        {
            Sleep (0xC8)
        }

        OperationRegion (PRST, SystemIO, 0xAF00, 0x20)
        Field (PRST, ByteAcc, NoLock, Preserve)
        {
            PRS,    256
        }

        Method (PRSC, 0, NotSerialized)
        {
            Store (PRS, Local5)
            Store (Zero, Local2)
            Store (Zero, Local0)
            While (LLess (Local0, SizeOf (CPON)))
            {
                Store (DerefOf (Index (CPON, Local0)), Local1)
                If (And (Local0, 0x07))
                {
                    ShiftRight (Local2, One, Local2)
                }
                Else
                {
                    Store (DerefOf (Index (Local5, ShiftRight (Local0, 0x03))), Local2)
                }

                Store (And (Local2, One), Local3)
                If (LNotEqual (Local1, Local3))
                {
                    Store (Local3, Index (CPON, Local0))
                    If (LEqual (Local3, One))
                    {
                        NTFY (Local0, One)
                    }
                    Else
                    {
                        NTFY (Local0, 0x03)
                    }
                }

                Increment (Local0)
            }
        }

        Device (PRES)
        {
            Name (_HID, EisaId ("PNP0A06") /* Generic Container Device */)  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0xAF00,             // Range Minimum
                    0xAF00,             // Range Maximum
                    0x00,               // Alignment
                    0x20,               // Length
                    )
            })
            Name (_STA, 0x0B)  // _STA: Status
        }
    }

    Scope (_SB.PCI0)
    {
        Device (MHPD)
        {
            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
            Name (_UID, "Memory hotplug resources")  // _UID: Unique ID
            OperationRegion (HPMR, SystemIO, 0x0A00, 0x18)
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x0A00,             // Range Minimum
                    0x0A00,             // Range Maximum
                    0x00,               // Alignment
                    0x18,               // Length
                    )
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LEqual (MDNR, Zero))
                {
                    Return (Zero)
                }

                Return (0x0B)
            }

            Field (HPMR, DWordAcc, NoLock, Preserve)
            {
                MRBL,   32, 
                MRBH,   32, 
                MRLL,   32, 
                MRLH,   32, 
                MPX,    32
            }

            Field (HPMR, ByteAcc, NoLock, Preserve)
            {
                Offset (0x14), 
                MES,    1, 
                MINS,   1
            }

            Mutex (MLCK, 0x00)
            Field (HPMR, DWordAcc, NoLock, Preserve)
            {
                MSEL,   32, 
                MOEV,   32, 
                MOSC,   32
            }

            Method (MSCN, 0, NotSerialized)
            {
                If (LEqual (MDNR, Zero))
                {
                    Return (Zero)
                }

                Store (Zero, Local0)
                Acquire (MLCK, 0xFFFF)
                While (LLess (Local0, MDNR))
                {
                    Store (Local0, MSEL) /* \_SB_.PCI0.MHPD.MSEL */
                    If (LEqual (MINS, One))
                    {
                        MTFY (Local0, One)
                        Store (One, MINS) /* \_SB_.PCI0.MHPD.MINS */
                    }

                    Add (Local0, One, Local0)
                }

                Release (MLCK)
                Return (One)
            }

            Method (MRST, 1, NotSerialized)
            {
                Store (Zero, Local0)
                Acquire (MLCK, 0xFFFF)
                Store (ToInteger (Arg0), MSEL) /* \_SB_.PCI0.MHPD.MSEL */
                If (LEqual (MES, One))
                {
                    Store (0x0F, Local0)
                }

                Release (MLCK)
                Return (Local0)
            }

            Method (MCRS, 1, Serialized)
            {
                Acquire (MLCK, 0xFFFF)
                Store (ToInteger (Arg0), MSEL) /* \_SB_.PCI0.MHPD.MSEL */
                Name (MR64, ResourceTemplate ()
                {
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000000000000, // Range Minimum
                        0xFFFFFFFFFFFFFFFE, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0xFFFFFFFFFFFFFFFF, // Length
                        ,, _Y03, AddressRangeMemory, TypeStatic)
                })
                CreateDWordField (MR64, \_SB.PCI0.MHPD.MCRS._Y03._MIN, MINL)  // _MIN: Minimum Base Address
                CreateDWordField (MR64, 0x12, MINH)
                CreateDWordField (MR64, \_SB.PCI0.MHPD.MCRS._Y03._LEN, LENL)  // _LEN: Length
                CreateDWordField (MR64, 0x2A, LENH)
                CreateDWordField (MR64, \_SB.PCI0.MHPD.MCRS._Y03._MAX, MAXL)  // _MAX: Maximum Base Address
                CreateDWordField (MR64, 0x1A, MAXH)
                Store (MRBH, MINH) /* \_SB_.PCI0.MHPD.MCRS.MINH */
                Store (MRBL, MINL) /* \_SB_.PCI0.MHPD.MCRS.MINL */
                Store (MRLH, LENH) /* \_SB_.PCI0.MHPD.MCRS.LENH */
                Store (MRLL, LENL) /* \_SB_.PCI0.MHPD.MCRS.LENL */
                Add (MINL, LENL, MAXL) /* \_SB_.PCI0.MHPD.MCRS.MAXL */
                Add (MINH, LENH, MAXH) /* \_SB_.PCI0.MHPD.MCRS.MAXH */
                If (LLess (MAXL, MINL))
                {
                    Add (MAXH, One, MAXH) /* \_SB_.PCI0.MHPD.MCRS.MAXH */
                }

                If (LLess (MAXL, One))
                {
                    Subtract (MAXH, One, MAXH) /* \_SB_.PCI0.MHPD.MCRS.MAXH */
                }

                Subtract (MAXL, One, MAXL) /* \_SB_.PCI0.MHPD.MCRS.MAXL */
                If (LEqual (MAXH, Zero))
                {
                    Name (MR32, ResourceTemplate ()
                    {
                        DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                            0x00000000,         // Granularity
                            0x00000000,         // Range Minimum
                            0xFFFFFFFE,         // Range Maximum
                            0x00000000,         // Translation Offset
                            0xFFFFFFFF,         // Length
                            ,, _Y04, AddressRangeMemory, TypeStatic)
                    })
                    CreateDWordField (MR32, \_SB.PCI0.MHPD.MCRS._Y04._MIN, MIN)  // _MIN: Minimum Base Address
                    CreateDWordField (MR32, \_SB.PCI0.MHPD.MCRS._Y04._MAX, MAX)  // _MAX: Maximum Base Address
                    CreateDWordField (MR32, \_SB.PCI0.MHPD.MCRS._Y04._LEN, LEN)  // _LEN: Length
                    Store (MINL, MIN) /* \_SB_.PCI0.MHPD.MCRS.MIN_ */
                    Store (MAXL, MAX) /* \_SB_.PCI0.MHPD.MCRS.MAX_ */
                    Store (LENL, LEN) /* \_SB_.PCI0.MHPD.MCRS.LEN_ */
                    Release (MLCK)
                    Return (MR32) /* \_SB_.PCI0.MHPD.MCRS.MR32 */
                }

                Release (MLCK)
                Return (MR64) /* \_SB_.PCI0.MHPD.MCRS.MR64 */
            }

            Method (MPXM, 1, NotSerialized)
            {
                Acquire (MLCK, 0xFFFF)
                Store (ToInteger (Arg0), MSEL) /* \_SB_.PCI0.MHPD.MSEL */
                Store (MPX, Local0)
                Release (MLCK)
                Return (Local0)
            }

            Method (MOST, 4, NotSerialized)
            {
                Acquire (MLCK, 0xFFFF)
                Store (ToInteger (Arg0), MSEL) /* \_SB_.PCI0.MHPD.MSEL */
                Store (Arg1, MOEV) /* \_SB_.PCI0.MHPD.MOEV */
                Store (Arg2, MOSC) /* \_SB_.PCI0.MHPD.MOSC */
                Release (MLCK)
            }
        }
    }

    Scope (_GPE)
    {
        Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
        Method (_L00, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
        {
            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
            \_SB.PCI0.PCNT ()
            Release (\_SB.PCI0.BLCK)
        }

        Method (_E02, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
        {
            \_SB.PRSC ()
        }

        Method (_E03, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
        {
            \_SB.PCI0.MHPD.MSCN ()
        }

        Method (_L04, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L05, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L07, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0A, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0C, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0E, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }

        Method (_L0F, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
        }
    }
}

