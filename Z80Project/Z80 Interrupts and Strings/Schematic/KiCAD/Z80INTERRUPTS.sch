EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:MCPARTS
LIBS:Z80INTERRUPTS-cache
EELAYER 27 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title ""
Date "28 apr 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CY62256N U?
U 1 1 550A0662
P 7100 3350
F 0 "U?" H 6800 4500 60  0000 C CNN
F 1 "CY62256N" H 7100 2750 47  0000 C CNN
F 2 "~" H 7250 3550 60  0000 C CNN
F 3 "~" H 7250 3550 60  0000 C CNN
	1    7100 3350
	1    0    0    -1  
$EndComp
$Comp
L PC16550DN U?
U 1 1 550AF784
P 10100 6550
F 0 "U?" H 9600 8300 70  0000 C CNN
F 1 "PC16550DN" H 10100 6550 59  0000 C CNN
F 2 "~" H 10300 6650 60  0000 C CNN
F 3 "~" H 10300 6650 60  0000 C CNN
	1    10100 6550
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 550AF29B
P 2200 5850
F 0 "R?" V 2280 5850 40  0000 C CNN
F 1 "1K" V 2207 5851 40  0000 C CNN
F 2 "~" V 2130 5850 30  0000 C CNN
F 3 "~" H 2200 5850 30  0000 C CNN
	1    2200 5850
	1    0    0    -1  
$EndComp
$Comp
L DPST SW?
U 1 1 550AF2B4
P 1700 6500
F 0 "SW?" H 1700 6600 70  0000 C CNN
F 1 "DPST" H 1700 6400 70  0000 C CNN
F 2 "~" H 1700 6500 60  0000 C CNN
F 3 "~" H 1700 6500 60  0000 C CNN
	1    1700 6500
	-1   0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 550AF2FA
P 2200 5500
F 0 "#PWR?" H 2200 5600 30  0001 C CNN
F 1 "VCC" H 2200 5600 30  0000 C CNN
F 2 "" H 2200 5500 60  0000 C CNN
F 3 "" H 2200 5500 60  0000 C CNN
	1    2200 5500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 550AF31D
P 1050 7400
F 0 "#PWR?" H 1050 7400 30  0001 C CNN
F 1 "GND" H 1050 7330 30  0001 C CNN
F 2 "" H 1050 7400 60  0000 C CNN
F 3 "" H 1050 7400 60  0000 C CNN
	1    1050 7400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 550AF5A8
P 3700 7400
F 0 "#PWR?" H 3700 7400 30  0001 C CNN
F 1 "GND" H 3700 7330 30  0001 C CNN
F 2 "" H 3700 7400 60  0000 C CNN
F 3 "" H 3700 7400 60  0000 C CNN
	1    3700 7400
	1    0    0    -1  
$EndComp
Entry Wire Line
	5850 4800 5950 4900
Entry Wire Line
	5750 4900 5850 4800
Entry Wire Line
	5850 4900 5950 5000
Entry Wire Line
	5850 5000 5950 5100
Entry Wire Line
	5850 5100 5950 5200
Entry Wire Line
	5850 5200 5950 5300
Entry Wire Line
	5850 5300 5950 5400
Entry Wire Line
	5850 5400 5950 5500
Entry Wire Line
	5850 5500 5950 5600
Entry Wire Line
	5850 5600 5950 5700
Entry Wire Line
	5850 5700 5950 5800
Entry Wire Line
	5750 5000 5850 4900
Entry Wire Line
	5750 5100 5850 5000
Entry Wire Line
	5750 5200 5850 5100
Entry Wire Line
	5750 5300 5850 5200
Entry Wire Line
	5750 5400 5850 5300
Entry Wire Line
	5750 5500 5850 5400
Entry Wire Line
	5750 5600 5850 5500
Entry Wire Line
	5750 5700 5850 5600
Entry Wire Line
	5750 5800 5850 5700
Entry Wire Line
	5850 5800 5950 5900
Text Label 5850 4150 1    60   ~ 0
ADDRESS BUS
Text Label 8450 3250 3    60   ~ 0
DATA BUS
Entry Wire Line
	5850 2450 5950 2350
Entry Wire Line
	5850 2550 5950 2450
Entry Wire Line
	5850 2650 5950 2550
Entry Wire Line
	5850 2750 5950 2650
Entry Wire Line
	5850 2850 5950 2750
Entry Wire Line
	5850 2950 5950 2850
Entry Wire Line
	5850 3050 5950 2950
Entry Wire Line
	5850 3150 5950 3050
Entry Wire Line
	5850 3250 5950 3150
Entry Wire Line
	5850 3350 5950 3250
Entry Wire Line
	8600 5950 8700 6050
Entry Wire Line
	8600 5850 8700 5950
Entry Wire Line
	8600 5750 8700 5850
Entry Wire Line
	5750 6600 5850 6700
Entry Wire Line
	5750 6700 5850 6800
Entry Wire Line
	5750 6800 5850 6900
Entry Wire Line
	5750 6900 5850 7000
Entry Wire Line
	5750 7000 5850 7100
Entry Wire Line
	5750 7100 5850 7200
Entry Wire Line
	5750 7200 5850 7300
Entry Wire Line
	5750 7300 5850 7400
Text Label 6900 7550 0    60   ~ 0
DATA BUS
Text Label 7450 4600 2    60   ~ 0
ADDRESS BUS
Entry Wire Line
	8350 4900 8450 5000
Entry Wire Line
	8350 5000 8450 5100
Entry Wire Line
	8350 5100 8450 5200
Entry Wire Line
	8350 5200 8450 5300
Entry Wire Line
	8350 5300 8450 5400
Entry Wire Line
	8350 5400 8450 5500
Entry Wire Line
	8350 5500 8450 5600
Entry Wire Line
	8350 5600 8450 5700
Entry Wire Line
	8350 2350 8450 2450
Entry Wire Line
	8350 2450 8450 2550
Entry Wire Line
	8350 2550 8450 2650
Entry Wire Line
	8350 2650 8450 2750
Entry Wire Line
	8350 2750 8450 2850
Entry Wire Line
	8350 2850 8450 2950
Entry Wire Line
	8350 2950 8450 3050
Entry Wire Line
	8350 3050 8450 3150
Entry Wire Line
	9000 4850 9100 4950
Entry Wire Line
	9000 4950 9100 5050
Entry Wire Line
	9000 5050 9100 5150
Entry Wire Line
	9000 5150 9100 5250
Entry Wire Line
	9000 5250 9100 5350
Entry Wire Line
	9000 5350 9100 5450
Entry Wire Line
	9000 5450 9100 5550
Entry Wire Line
	9000 5550 9100 5650
Text Label 9000 4000 3    60   ~ 0
DATA BUS
Entry Bus Bus
	8900 3750 9000 3850
Entry Bus Bus
	5850 4500 5950 4600
$Comp
L VCC #PWR?
U 1 1 550B0E99
P 3700 7050
F 0 "#PWR?" H 3700 7150 30  0001 C CNN
F 1 "VCC" H 3700 7150 30  0000 C CNN
F 2 "" H 3700 7050 60  0000 C CNN
F 3 "" H 3700 7050 60  0000 C CNN
	1    3700 7050
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 550B0EFD
P 6350 4100
F 0 "#PWR?" H 6350 4200 30  0001 C CNN
F 1 "VCC" H 6350 4200 30  0000 C CNN
F 2 "" H 6350 4100 60  0000 C CNN
F 3 "" H 6350 4100 60  0000 C CNN
	1    6350 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 550B0F03
P 6350 4450
F 0 "#PWR?" H 6350 4450 30  0001 C CNN
F 1 "GND" H 6350 4380 30  0001 C CNN
F 2 "" H 6350 4450 60  0000 C CNN
F 3 "" H 6350 4450 60  0000 C CNN
	1    6350 4450
	1    0    0    -1  
$EndComp
Text Label 3750 6300 0    60   ~ 0
~MR
$Comp
L 74LS14 U?
U 2 1 550B1CE8
P 2800 6700
F 0 "U?" H 2950 6800 40  0000 C CNN
F 1 "74LS14" H 3000 6600 40  0000 C CNN
F 2 "~" H 2800 6700 60  0000 C CNN
F 3 "~" H 2800 6700 60  0000 C CNN
	2    2800 6700
	1    0    0    -1  
$EndComp
Text Label 3350 6500 0    60   ~ 0
MR
Text Label 9100 4950 0    60   ~ 0
D0
Text Label 9100 5050 0    60   ~ 0
D1
Text Label 9100 5150 0    60   ~ 0
D2
Text Label 9100 5250 0    60   ~ 0
D3
Text Label 9100 5350 0    60   ~ 0
D4
Text Label 9100 5450 0    60   ~ 0
D5
Text Label 9100 5550 0    60   ~ 0
D6
Text Label 9100 5650 0    60   ~ 0
D7
Text Label 7800 4900 0    60   ~ 0
D0
Text Label 7800 5000 0    60   ~ 0
D1
Text Label 7800 5100 0    60   ~ 0
D2
Text Label 7800 5200 0    60   ~ 0
D3
Text Label 7800 5300 0    60   ~ 0
D4
Text Label 7800 5400 0    60   ~ 0
D5
Text Label 7800 5500 0    60   ~ 0
D6
Text Label 7800 5600 0    60   ~ 0
D7
Text Label 6250 2350 0    60   ~ 0
A0
Text Label 6250 2450 0    60   ~ 0
A1
Text Label 6250 2550 0    60   ~ 0
A2
Text Label 6250 2650 0    60   ~ 0
A3
Text Label 6250 2750 0    60   ~ 0
A4
Text Label 6250 2850 0    60   ~ 0
A5
Text Label 6250 2950 0    60   ~ 0
A6
Text Label 6250 3050 0    60   ~ 0
A7
Text Label 6250 3150 0    60   ~ 0
A8
Text Label 6250 3250 0    60   ~ 0
A9
Text Label 6250 3350 0    60   ~ 0
A10
Text Label 6250 4900 0    60   ~ 0
A0
Text Label 6250 5000 0    60   ~ 0
A1
Text Label 6250 5100 0    60   ~ 0
A2
Text Label 6250 5200 0    60   ~ 0
A3
Text Label 6250 5300 0    60   ~ 0
A4
Text Label 6250 5400 0    60   ~ 0
A5
Text Label 6250 5500 0    60   ~ 0
A6
Text Label 6250 5600 0    60   ~ 0
A7
Text Label 6250 5700 0    60   ~ 0
A8
Text Label 6250 5800 0    60   ~ 0
A9
Text Label 6250 5900 0    60   ~ 0
A10
Text Label 5300 6600 0    60   ~ 0
D0
Text Label 5300 6700 0    60   ~ 0
D1
Text Label 5300 6800 0    60   ~ 0
D2
Text Label 5300 6900 0    60   ~ 0
D3
Text Label 5300 7000 0    60   ~ 0
D4
Text Label 5300 7100 0    60   ~ 0
D5
Text Label 5300 7200 0    60   ~ 0
D6
Text Label 5300 7300 0    60   ~ 0
D7
Text Label 9100 5850 0    60   ~ 0
A0
Text Label 9100 5950 0    60   ~ 0
A1
Text Label 9100 6050 0    60   ~ 0
A2
Text Label 5300 4900 0    60   ~ 0
A0
Text Label 5300 5000 0    60   ~ 0
A1
Text Label 5300 5100 0    60   ~ 0
A2
Text Label 5300 5200 0    60   ~ 0
A3
Text Label 5300 5300 0    60   ~ 0
A4
Text Label 5300 5400 0    60   ~ 0
A5
Text Label 5300 5500 0    60   ~ 0
A6
Text Label 5300 5600 0    60   ~ 0
A7
Text Label 5300 5700 0    60   ~ 0
A8
Text Label 5300 5800 0    60   ~ 0
A9
Text Label 5300 5900 0    60   ~ 0
A10
Text Label 3650 6850 0    60   ~ 0
CLK
$Comp
L VCC #PWR?
U 1 1 550B24C8
P 6350 6600
F 0 "#PWR?" H 6350 6700 30  0001 C CNN
F 1 "VCC" H 6350 6700 30  0000 C CNN
F 2 "" H 6350 6600 60  0000 C CNN
F 3 "" H 6350 6600 60  0000 C CNN
	1    6350 6600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 550B24CE
P 6350 7000
F 0 "#PWR?" H 6350 7000 30  0001 C CNN
F 1 "GND" H 6350 6930 30  0001 C CNN
F 2 "" H 6350 7000 60  0000 C CNN
F 3 "" H 6350 7000 60  0000 C CNN
	1    6350 7000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 550B270B
P 9150 7950
F 0 "#PWR?" H 9150 8050 30  0001 C CNN
F 1 "VCC" H 9150 8050 30  0000 C CNN
F 2 "" H 9150 7950 60  0000 C CNN
F 3 "" H 9150 7950 60  0000 C CNN
	1    9150 7950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 550B2711
P 9150 8300
F 0 "#PWR?" H 9150 8300 30  0001 C CNN
F 1 "GND" H 9150 8230 30  0001 C CNN
F 2 "" H 9150 8300 60  0000 C CNN
F 3 "" H 9150 8300 60  0000 C CNN
	1    9150 8300
	1    0    0    -1  
$EndComp
Text Label 9100 7800 0    60   ~ 0
MR
Text Label 7800 2350 0    60   ~ 0
D0
Text Label 7800 2450 0    60   ~ 0
D1
Text Label 7800 2550 0    60   ~ 0
D2
Text Label 7800 2650 0    60   ~ 0
D3
Text Label 7800 2750 0    60   ~ 0
D4
Text Label 7800 2850 0    60   ~ 0
D5
Text Label 7800 2950 0    60   ~ 0
D6
Text Label 7800 3050 0    60   ~ 0
D7
Text Label 8100 6700 2    60   ~ 0
ROMCS
Text Label 8100 6800 2    60   ~ 0
MEMRD
Text Label 8100 4150 2    60   ~ 0
RAMCS
Text Label 8100 4250 2    60   ~ 0
MEMRD
Text Label 8100 4350 2    60   ~ 0
MEMWR
Entry Wire Line
	5850 3450 5950 3350
$Comp
L Z80CPU U?
U 1 1 550AF57F
P 4550 6200
F 0 "U?" H 4150 7650 50  0000 C CNN
F 1 "Z80CPU" H 4550 6250 50  0000 C CNN
F 2 "~" H 4550 6200 50  0001 C CNN
F 3 "~" H 4550 6200 50  0001 C CNN
	1    4550 6200
	1    0    0    -1  
$EndComp
$Comp
L CAT28C256 U?
U 1 1 55086ED5
P 7100 5900
F 0 "U?" H 6800 7050 60  0000 C CNN
F 1 "CAT28C256" H 7100 5300 47  0000 C CNN
F 2 "" H 7250 6100 60  0000 C CNN
F 3 "" H 7250 6100 60  0000 C CNN
	1    7100 5900
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U?
U 1 1 550B3D1C
P 4550 2700
F 0 "U?" H 4550 2750 60  0000 C CNN
F 1 "74LS32" H 4550 2650 60  0000 C CNN
F 2 "~" H 4550 2700 60  0000 C CNN
F 3 "~" H 4550 2700 60  0000 C CNN
	1    4550 2700
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U?
U 2 1 550B3D29
P 4550 3200
F 0 "U?" H 4550 3250 60  0000 C CNN
F 1 "74LS32" H 4550 3150 60  0000 C CNN
F 2 "~" H 4550 3200 60  0000 C CNN
F 3 "~" H 4550 3200 60  0000 C CNN
	2    4550 3200
	1    0    0    -1  
$EndComp
Text Label 3600 2950 2    60   ~ 0
~MREQ
Text Label 3800 5000 2    60   ~ 0
~MREQ
Text Label 3800 5200 2    60   ~ 0
~RD
Text Label 3800 5300 2    60   ~ 0
~WR
Text Label 3950 2600 2    60   ~ 0
~RD
Text Label 3950 3300 2    60   ~ 0
~WR
Text Label 5150 2700 0    60   ~ 0
MEMRD
Text Label 5150 3200 0    60   ~ 0
MEMWR
$Comp
L VCC #PWR?
U 1 1 550B3E39
P 8200 6900
F 0 "#PWR?" H 8200 7000 30  0001 C CNN
F 1 "VCC" H 8200 7000 30  0000 C CNN
F 2 "" H 8200 6900 60  0000 C CNN
F 3 "" H 8200 6900 60  0000 C CNN
	1    8200 6900
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U?
U 3 1 550B3E7D
P 4550 3750
F 0 "U?" H 4550 3800 60  0000 C CNN
F 1 "74LS32" H 4550 3700 60  0000 C CNN
F 2 "~" H 4550 3750 60  0000 C CNN
F 3 "~" H 4550 3750 60  0000 C CNN
	3    4550 3750
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U?
U 4 1 550B3E83
P 4550 4250
F 0 "U?" H 4550 4300 60  0000 C CNN
F 1 "74LS32" H 4550 4200 60  0000 C CNN
F 2 "~" H 4550 4250 60  0000 C CNN
F 3 "~" H 4550 4250 60  0000 C CNN
	4    4550 4250
	1    0    0    -1  
$EndComp
Text Label 3600 4000 2    60   ~ 0
~MREQ
Text Label 5150 3750 0    60   ~ 0
ROMCS
Text Label 5150 4250 0    60   ~ 0
RAMCS
Text Label 3950 3650 2    60   ~ 0
A15
Text Label 3950 4350 2    60   ~ 0
~A15
$Comp
L 74LS14 U?
U 1 1 550B3E96
P 4500 2150
F 0 "U?" H 4650 2250 40  0000 C CNN
F 1 "74LS14" H 4700 2050 40  0000 C CNN
F 2 "~" H 4500 2150 60  0000 C CNN
F 3 "~" H 4500 2150 60  0000 C CNN
	1    4500 2150
	1    0    0    -1  
$EndComp
Text Label 4050 2150 2    60   ~ 0
A15
Text Label 4950 2150 0    60   ~ 0
~A15
$Comp
L 74LS32 U?
U 1 1 550B31D5
P 2300 2650
F 0 "U?" H 2300 2700 60  0000 C CNN
F 1 "74LS32" H 2300 2600 60  0000 C CNN
F 2 "~" H 2300 2650 60  0000 C CNN
F 3 "~" H 2300 2650 60  0000 C CNN
	1    2300 2650
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U?
U 2 1 550B31DB
P 2300 3150
F 0 "U?" H 2300 3200 60  0000 C CNN
F 1 "74LS32" H 2300 3100 60  0000 C CNN
F 2 "~" H 2300 3150 60  0000 C CNN
F 3 "~" H 2300 3150 60  0000 C CNN
	2    2300 3150
	1    0    0    -1  
$EndComp
Text Label 1350 2900 2    60   ~ 0
~IORQ
Text Label 1700 2550 2    60   ~ 0
~RD
Text Label 1700 3250 2    60   ~ 0
~WR
Text Label 2900 2650 0    60   ~ 0
IORD
Text Label 2900 3150 0    60   ~ 0
IOWR
Text Label 9250 7100 2    60   ~ 0
IORD
Text Label 9250 7000 2    60   ~ 0
IOWR
$Comp
L VCC #PWR?
U 1 1 550B3380
P 9150 6200
F 0 "#PWR?" H 9150 6300 30  0001 C CNN
F 1 "VCC" H 9150 6300 30  0000 C CNN
F 2 "" H 9150 6200 60  0000 C CNN
F 3 "" H 9150 6200 60  0000 C CNN
	1    9150 6200
	1    0    0    -1  
$EndComp
Text Label 9250 6500 2    60   ~ 0
IOCS0
NoConn ~ 9250 6800
$Comp
L GND #PWR?
U 1 1 550B378E
P 9050 7550
F 0 "#PWR?" H 9050 7550 30  0001 C CNN
F 1 "GND" H 9050 7480 30  0001 C CNN
F 2 "" H 9050 7550 60  0000 C CNN
F 3 "" H 9050 7550 60  0000 C CNN
	1    9050 7550
	1    0    0    -1  
$EndComp
Text Label 1600 3900 2    60   ~ 0
A7
Text Label 1600 3800 2    60   ~ 0
A6
Text Label 1600 3700 2    60   ~ 0
A5
Text Label 2800 3700 0    60   ~ 0
IOCS0
Text Label 2800 3800 0    60   ~ 0
IOCS1
Text Label 2800 3900 0    60   ~ 0
IOCS2
Text Label 2800 4000 0    60   ~ 0
IOCS3
Text Label 2800 4100 0    60   ~ 0
IOCS4
Text Label 2800 4200 0    60   ~ 0
IOCS5
Text Label 2800 4300 0    60   ~ 0
IOCS6
Text Label 2800 4400 0    60   ~ 0
IOCS7
NoConn ~ 10950 5850
NoConn ~ 10950 6150
NoConn ~ 10950 6950
NoConn ~ 10950 7050
NoConn ~ 10950 7250
$Comp
L 74LS138 U?
U 1 1 550D74FD
P 2200 4050
F 0 "U?" H 2300 4550 60  0000 C CNN
F 1 "74LS138" H 2300 3550 60  0000 C CNN
F 2 "~" H 2200 4050 60  0000 C CNN
F 3 "~" H 2200 4050 60  0000 C CNN
	1    2200 4050
	1    0    0    -1  
$EndComp
Text Label 3800 5100 2    60   ~ 0
~IORQ
NoConn ~ 3800 5500
NoConn ~ 3800 6600
$Comp
L VCC #PWR?
U 1 1 550D7F7E
P 3600 5750
F 0 "#PWR?" H 3600 5850 30  0001 C CNN
F 1 "VCC" H 3600 5850 30  0000 C CNN
F 2 "" H 3600 5750 60  0000 C CNN
F 3 "" H 3600 5750 60  0000 C CNN
	1    3600 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 5600 2200 5500
Wire Wire Line
	3800 6300 2200 6300
Wire Wire Line
	2200 6300 2200 6100
Wire Wire Line
	1200 6300 1050 6300
Wire Wire Line
	1050 6300 1050 6700
Wire Wire Line
	1050 6700 1050 7400
Wire Wire Line
	1050 6700 1200 6700
Connection ~ 1050 6700
Wire Wire Line
	3800 7300 3700 7300
Wire Wire Line
	3700 7300 3700 7400
Wire Wire Line
	5300 4900 5750 4900
Wire Wire Line
	5300 5000 5750 5000
Wire Wire Line
	5300 5100 5750 5100
Wire Wire Line
	5300 5200 5750 5200
Wire Wire Line
	5300 5300 5750 5300
Wire Wire Line
	5300 5400 5750 5400
Wire Wire Line
	5300 5500 5750 5500
Wire Wire Line
	5300 5600 5750 5600
Wire Wire Line
	5300 5700 5750 5700
Wire Wire Line
	5750 5800 5300 5800
Wire Wire Line
	5300 5900 5750 5900
Wire Wire Line
	5950 4900 6450 4900
Wire Wire Line
	6450 5000 5950 5000
Wire Wire Line
	5950 5100 6450 5100
Wire Wire Line
	6450 5200 5950 5200
Wire Wire Line
	5950 5300 6450 5300
Wire Wire Line
	6450 5400 5950 5400
Wire Wire Line
	5950 5500 6450 5500
Wire Wire Line
	6450 5600 5950 5600
Wire Wire Line
	5950 5700 6450 5700
Wire Wire Line
	5950 5800 6450 5800
Wire Wire Line
	6450 5900 5950 5900
Wire Bus Line
	5850 6700 5850 6800
Wire Bus Line
	5850 6800 5850 6900
Wire Bus Line
	5850 6900 5850 7000
Wire Bus Line
	5850 7000 5850 7100
Wire Bus Line
	5850 7100 5850 7200
Wire Bus Line
	5850 7200 5850 7300
Wire Bus Line
	5850 7300 5850 7400
Wire Bus Line
	5850 7400 5850 7550
Wire Bus Line
	5850 7550 8450 7550
Wire Bus Line
	8450 7550 8450 5700
Wire Bus Line
	8450 5700 8450 5600
Wire Bus Line
	8450 5600 8450 5500
Wire Bus Line
	8450 5500 8450 5400
Wire Bus Line
	8450 5400 8450 5300
Wire Bus Line
	8450 5300 8450 5200
Wire Bus Line
	8450 5200 8450 5100
Wire Bus Line
	8450 5100 8450 5000
Wire Bus Line
	8450 5000 8450 3150
Wire Bus Line
	8450 3150 8450 3050
Wire Bus Line
	8450 3050 8450 2950
Wire Bus Line
	8450 2950 8450 2850
Wire Bus Line
	8450 2850 8450 2750
Wire Bus Line
	8450 2750 8450 2650
Wire Bus Line
	8450 2650 8450 2550
Wire Bus Line
	8450 2550 8450 2450
Wire Wire Line
	5950 2350 6450 2350
Wire Wire Line
	6450 2450 5950 2450
Wire Wire Line
	5950 2550 6450 2550
Wire Wire Line
	6450 2650 5950 2650
Wire Wire Line
	5950 2750 6450 2750
Wire Wire Line
	6450 2850 5950 2850
Wire Wire Line
	5950 2950 6450 2950
Wire Wire Line
	6450 3050 5950 3050
Wire Wire Line
	5950 3150 6450 3150
Wire Wire Line
	6450 3250 5950 3250
Wire Wire Line
	8700 5850 9250 5850
Wire Wire Line
	9250 5950 8700 5950
Wire Wire Line
	8700 6050 9250 6050
Wire Bus Line
	8600 4600 8600 5750
Wire Bus Line
	8600 5750 8600 5850
Wire Bus Line
	8600 5850 8600 5950
Wire Wire Line
	5300 7300 5750 7300
Wire Wire Line
	5750 7200 5300 7200
Wire Wire Line
	5300 7100 5750 7100
Wire Wire Line
	5750 7000 5300 7000
Wire Wire Line
	5300 6900 5750 6900
Wire Wire Line
	5750 6800 5300 6800
Wire Wire Line
	5300 6700 5750 6700
Wire Wire Line
	5750 6600 5300 6600
Wire Wire Line
	7800 4900 8350 4900
Wire Wire Line
	8350 5000 7800 5000
Wire Wire Line
	7800 5100 8350 5100
Wire Wire Line
	8350 5200 7800 5200
Wire Wire Line
	7800 5300 8350 5300
Wire Wire Line
	8350 5400 7800 5400
Wire Wire Line
	7800 5500 8350 5500
Wire Wire Line
	7800 5600 8350 5600
Wire Wire Line
	7800 2350 8350 2350
Wire Wire Line
	8350 2450 7800 2450
Wire Wire Line
	7800 2550 8350 2550
Wire Wire Line
	8350 2650 7800 2650
Wire Wire Line
	7800 2750 8350 2750
Wire Wire Line
	8350 2850 7800 2850
Wire Wire Line
	7800 2950 8350 2950
Wire Wire Line
	8350 3050 7800 3050
Wire Bus Line
	9000 3850 9000 4850
Wire Bus Line
	9000 4850 9000 4950
Wire Bus Line
	9000 4950 9000 5050
Wire Bus Line
	9000 5050 9000 5150
Wire Bus Line
	9000 5150 9000 5250
Wire Bus Line
	9000 5250 9000 5350
Wire Bus Line
	9000 5350 9000 5450
Wire Bus Line
	9000 5450 9000 5550
Wire Wire Line
	9100 4950 9250 4950
Wire Wire Line
	9250 5050 9100 5050
Wire Wire Line
	9100 5150 9250 5150
Wire Wire Line
	9250 5250 9100 5250
Wire Wire Line
	9100 5350 9250 5350
Wire Wire Line
	9250 5450 9100 5450
Wire Wire Line
	9100 5550 9250 5550
Wire Wire Line
	9250 5650 9100 5650
Wire Bus Line
	8900 3750 8450 3750
Wire Bus Line
	8450 3750 8450 3700
Wire Bus Line
	5950 4600 8600 4600
Wire Wire Line
	10950 7650 11100 7650
Wire Wire Line
	11100 7650 11100 7850
Wire Wire Line
	11100 7850 10950 7850
Wire Wire Line
	3800 7100 3700 7100
Wire Wire Line
	3700 7100 3700 7050
Wire Wire Line
	6450 4150 6350 4150
Wire Wire Line
	6350 4150 6350 4100
Wire Wire Line
	6450 4350 6350 4350
Wire Wire Line
	6350 4350 6350 4450
Wire Wire Line
	5950 3350 6450 3350
Wire Wire Line
	3800 6850 3550 6850
Wire Wire Line
	3550 6850 3550 7850
Wire Wire Line
	2200 6700 2350 6700
Wire Wire Line
	3250 6700 3350 6700
Wire Wire Line
	3350 6700 3350 6500
Wire Wire Line
	6450 6700 6350 6700
Wire Wire Line
	6350 6700 6350 6600
Wire Wire Line
	6450 6900 6350 6900
Wire Wire Line
	6350 6900 6350 7000
Wire Wire Line
	9250 8000 9150 8000
Wire Wire Line
	9150 8000 9150 7950
Wire Wire Line
	9250 8200 9150 8200
Wire Wire Line
	9150 8200 9150 8300
Wire Wire Line
	9250 7800 9100 7800
Wire Wire Line
	7800 6700 8100 6700
Wire Wire Line
	7800 6800 8100 6800
Wire Wire Line
	7800 6900 8200 6900
Wire Wire Line
	7800 4150 8100 4150
Wire Wire Line
	7800 4250 8100 4250
Wire Wire Line
	7800 4350 8100 4350
Wire Wire Line
	3950 2800 3950 2950
Wire Wire Line
	3950 2950 3950 3100
Wire Wire Line
	3950 2950 3600 2950
Connection ~ 3950 2950
Wire Wire Line
	3950 3850 3950 4000
Wire Wire Line
	3950 4000 3950 4150
Wire Wire Line
	3950 4000 3600 4000
Connection ~ 3950 4000
Wire Wire Line
	1700 2750 1700 2900
Wire Wire Line
	1700 2900 1700 3050
Wire Wire Line
	1700 2900 1350 2900
Connection ~ 1700 2900
Wire Wire Line
	9050 7300 9050 7400
Wire Wire Line
	9050 7400 9050 7500
Wire Wire Line
	9050 7500 9050 7550
Connection ~ 9050 7400
Wire Wire Line
	9250 6300 9150 6300
Wire Wire Line
	9150 6200 9150 6300
Wire Wire Line
	9150 6300 9150 6400
Wire Wire Line
	9150 6400 9250 6400
Connection ~ 9150 6300
Connection ~ 9050 7500
Wire Wire Line
	3600 5750 3600 5800
Wire Wire Line
	3600 5800 3600 6100
Wire Wire Line
	3600 5800 3800 5800
Connection ~ 3600 5800
Wire Wire Line
	10950 6750 11800 6750
Wire Wire Line
	11600 6650 11600 7500
Wire Wire Line
	11600 6650 10950 6650
$Comp
L CAP C?
U 1 1 551C4C38
P 10050 2950
F 0 "C?" H 10050 3050 40  0000 L CNN
F 1 "100nF" H 10056 2865 40  0000 L CNN
F 2 "~" H 10088 2800 30  0000 C CNN
F 3 "~" H 10050 2950 60  0000 C CNN
	1    10050 2950
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C3E
P 9750 2950
F 0 "C?" H 9750 3050 40  0000 L CNN
F 1 "10uF" H 9756 2865 40  0000 L CNN
F 2 "~" H 9788 2800 30  0000 C CNN
F 3 "~" H 9750 2950 60  0000 C CNN
	1    9750 2950
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 551C4C44
P 9450 2700
F 0 "#PWR?" H 9450 2800 30  0001 C CNN
F 1 "VCC" H 9450 2800 30  0000 C CNN
F 2 "" H 9450 2700 60  0000 C CNN
F 3 "" H 9450 2700 60  0000 C CNN
	1    9450 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 551C4C4A
P 9450 3200
F 0 "#PWR?" H 9450 3200 30  0001 C CNN
F 1 "GND" H 9450 3130 30  0001 C CNN
F 2 "" H 9450 3200 60  0000 C CNN
F 3 "" H 9450 3200 60  0000 C CNN
	1    9450 3200
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C50
P 10350 2950
F 0 "C?" H 10350 3050 40  0000 L CNN
F 1 "100nF" H 10356 2865 40  0000 L CNN
F 2 "~" H 10388 2800 30  0000 C CNN
F 3 "~" H 10350 2950 60  0000 C CNN
	1    10350 2950
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C56
P 10650 2950
F 0 "C?" H 10650 3050 40  0000 L CNN
F 1 "100nF" H 10656 2865 40  0000 L CNN
F 2 "~" H 10688 2800 30  0000 C CNN
F 3 "~" H 10650 2950 60  0000 C CNN
	1    10650 2950
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C5C
P 10950 2950
F 0 "C?" H 10950 3050 40  0000 L CNN
F 1 "100nF" H 10956 2865 40  0000 L CNN
F 2 "~" H 10988 2800 30  0000 C CNN
F 3 "~" H 10950 2950 60  0000 C CNN
	1    10950 2950
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C62
P 11250 2950
F 0 "C?" H 11250 3050 40  0000 L CNN
F 1 "100nF" H 11256 2865 40  0000 L CNN
F 2 "~" H 11288 2800 30  0000 C CNN
F 3 "~" H 11250 2950 60  0000 C CNN
	1    11250 2950
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C4C68
P 11550 2950
F 0 "C?" H 11550 3050 40  0000 L CNN
F 1 "100nF" H 11556 2865 40  0000 L CNN
F 2 "~" H 11588 2800 30  0000 C CNN
F 3 "~" H 11550 2950 60  0000 C CNN
	1    11550 2950
	1    0    0    -1  
$EndComp
Text Notes 10050 2600 0    60   ~ 0
Tank + Decoupling Caps
Wire Wire Line
	9450 3200 9450 3150
Wire Wire Line
	9450 3150 11550 3150
Wire Wire Line
	9450 2700 9450 2750
Wire Wire Line
	9450 2750 11550 2750
Text Notes 9600 3250 0    24   ~ 0
Near \nPower Supply\nBetween\nVCC and GND
Text Notes 9950 3250 0    24   ~ 0
Across \nSW1\nPin 1 & 3
Text Notes 10300 3250 0    24   ~ 0
Near \nU1\nPin 11
Text Notes 10600 3250 0    24   ~ 0
Near \nU2 \nPIN 28
Text Notes 10900 3250 0    24   ~ 0
Near \nU3\nPin 40
Text Notes 11200 3250 0    24   ~ 0
Near \nU4\nPin 9
Text Notes 11500 3250 0    24   ~ 0
Across\nX1\nPIN 7 & 14\n
Text Notes 10050 2650 0    24   ~ 0
Electrolytic
Text Notes 10550 2650 0    24   ~ 0
Ceramic
$Comp
L MAX237 U?
U 1 1 551C5197
P 12600 6550
F 0 "U?" H 12150 7700 70  0000 C CNN
F 1 "MAX237" H 12600 7350 70  0000 C CNN
F 2 "" H 12600 6550 60  0000 C CNN
F 3 "" H 12600 6550 60  0000 C CNN
	1    12600 6550
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 551C519D
P 13700 5400
F 0 "#PWR?" H 13700 5500 30  0001 C CNN
F 1 "VCC" H 13700 5500 30  0000 C CNN
F 2 "" H 13700 5400 60  0000 C CNN
F 3 "" H 13700 5400 60  0000 C CNN
	1    13700 5400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 551C51A3
P 13750 6150
F 0 "#PWR?" H 13750 6150 30  0001 C CNN
F 1 "GND" H 13750 6080 30  0001 C CNN
F 2 "" H 13750 6150 60  0000 C CNN
F 3 "" H 13750 6150 60  0000 C CNN
	1    13750 6150
	1    0    0    -1  
$EndComp
$Comp
L DB9 J?
U 1 1 551C51AA
P 14550 7300
F 0 "J?" H 14550 7850 70  0000 C CNN
F 1 "DB9" H 14550 6750 70  0000 C CNN
F 2 "" H 14550 7300 60  0000 C CNN
F 3 "" H 14550 7300 60  0000 C CNN
F 4 "Serial Connector" H 14150 8000 79  0000 C CNN "Part Description"
	1    14550 7300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 551C51B0
P 14200 6750
F 0 "#PWR?" H 14200 6750 30  0001 C CNN
F 1 "GND" H 14200 6680 30  0001 C CNN
F 2 "" H 14200 6750 60  0000 C CNN
F 3 "" H 14200 6750 60  0000 C CNN
	1    14200 6750
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 551C51BC
P 11700 7250
F 0 "#PWR?" H 11700 7250 30  0001 C CNN
F 1 "GND" H 11700 7180 30  0001 C CNN
F 2 "" H 11700 7250 60  0000 C CNN
F 3 "" H 11700 7250 60  0000 C CNN
	1    11700 7250
	1    0    0    -1  
$EndComp
NoConn ~ 13400 7050
NoConn ~ 13400 7150
$Comp
L CAP C?
U 1 1 551C51C6
P 11700 5750
F 0 "C?" H 11700 5850 40  0000 L CNN
F 1 "1uF" H 11706 5665 40  0000 L CNN
F 2 "~" H 11738 5600 30  0000 C CNN
F 3 "~" H 11700 5750 60  0000 C CNN
	1    11700 5750
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C51CC
P 11700 6250
F 0 "C?" H 11700 6350 40  0000 L CNN
F 1 "1uF" H 11706 6165 40  0000 L CNN
F 2 "~" H 11738 6100 30  0000 C CNN
F 3 "~" H 11700 6250 60  0000 C CNN
	1    11700 6250
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C51D2
P 13500 6250
F 0 "C?" H 13500 6350 40  0000 L CNN
F 1 "1uF" H 13506 6165 40  0000 L CNN
F 2 "~" H 13538 6100 30  0000 C CNN
F 3 "~" H 13500 6250 60  0000 C CNN
	1    13500 6250
	1    0    0    -1  
$EndComp
$Comp
L CAP C?
U 1 1 551C51D8
P 13500 5750
F 0 "C?" H 13500 5850 40  0000 L CNN
F 1 "1uF" H 13506 5665 40  0000 L CNN
F 2 "~" H 13538 5600 30  0000 C CNN
F 3 "~" H 13500 5750 60  0000 C CNN
	1    13500 5750
	-1   0    0    1   
$EndComp
Text Notes 14800 6200 3    60   ~ 0
Direct connection to USB->RS232 cable.\n
Text Notes 15150 6350 0    79   ~ 0
1    DCD\n__________\n2     RD\n__________\n3     TD\n__________\n4    DTR\n__________\n5    GND\n__________\n6    DSR\n__________\n7    RTS\n__________\n8    CTS\n__________\n9     RI\n
Wire Wire Line
	11700 5550 11800 5550
Wire Wire Line
	11800 5950 11700 5950
Wire Wire Line
	11700 6050 11800 6050
Wire Wire Line
	11800 6450 11700 6450
Wire Wire Line
	13400 6050 13500 6050
Wire Wire Line
	13500 6050 13750 6050
Wire Wire Line
	13500 6450 13400 6450
Wire Wire Line
	13400 5950 13500 5950
Wire Wire Line
	13400 5550 13500 5550
Wire Wire Line
	13500 5550 13700 5550
Wire Wire Line
	13700 5550 13700 5400
Connection ~ 13500 5550
Wire Wire Line
	13750 6050 13750 6150
Connection ~ 13500 6050
Wire Wire Line
	14100 6900 14000 6900
Wire Wire Line
	14000 6900 14000 6750
Wire Wire Line
	14000 6750 14200 6750
Wire Notes Line
	15150 6200 15150 8300
Wire Notes Line
	15750 8300 15750 6200
Wire Notes Line
	15750 6200 15150 6200
Wire Notes Line
	15150 8300 15750 8300
Wire Notes Line
	15400 6200 15400 8300
Text Notes 14900 6450 3    60   ~ 0
I do not have a NULL MODEM cable.\n
Wire Wire Line
	11600 7500 11800 7500
$Comp
L VCC #PWR?
U 1 1 551C59A4
P 11050 5100
F 0 "#PWR?" H 11050 5200 30  0001 C CNN
F 1 "VCC" H 11050 5200 30  0000 C CNN
F 2 "" H 11050 5100 60  0000 C CNN
F 3 "" H 11050 5100 60  0000 C CNN
	1    11050 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	10950 5550 11200 5550
Entry Wire Line
	5750 5900 5850 5800
Wire Bus Line
	5850 2450 5850 2550
Wire Bus Line
	5850 2550 5850 2650
Wire Bus Line
	5850 2650 5850 2750
Wire Bus Line
	5850 2750 5850 2850
Wire Bus Line
	5850 2850 5850 2950
Wire Bus Line
	5850 2950 5850 3050
Wire Bus Line
	5850 3050 5850 3150
Wire Bus Line
	5850 3150 5850 3250
Wire Bus Line
	5850 3250 5850 3350
Wire Bus Line
	5850 3350 5850 3450
Wire Bus Line
	5850 3450 5850 4500
Wire Bus Line
	5850 4500 5850 4800
Wire Bus Line
	5850 4800 5850 4900
Wire Bus Line
	5850 4900 5850 5000
Wire Bus Line
	5850 5000 5850 5100
Wire Bus Line
	5850 5100 5850 5200
Wire Bus Line
	5850 5200 5850 5300
Wire Bus Line
	5850 5300 5850 5400
Wire Bus Line
	5850 5400 5850 5500
Wire Bus Line
	5850 5500 5850 5600
Wire Bus Line
	5850 5600 5850 5700
Wire Bus Line
	5850 5700 5850 5800
NoConn ~ 5300 6000
NoConn ~ 5300 6100
NoConn ~ 5300 6200
NoConn ~ 5300 6300
$Comp
L GND #PWR?
U 1 1 551C6734
P 6350 6400
F 0 "#PWR?" H 6350 6400 30  0001 C CNN
F 1 "GND" H 6350 6330 30  0001 C CNN
F 2 "" H 6350 6400 60  0000 C CNN
F 3 "" H 6350 6400 60  0000 C CNN
	1    6350 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 6000 6350 6000
Wire Wire Line
	6350 6000 6350 6100
Wire Wire Line
	6350 6100 6350 6200
Wire Wire Line
	6350 6200 6350 6300
Wire Wire Line
	6350 6300 6350 6400
Wire Wire Line
	6450 6100 6350 6100
Connection ~ 6350 6100
Wire Wire Line
	6450 6200 6350 6200
Connection ~ 6350 6200
Wire Wire Line
	6450 6300 6350 6300
Connection ~ 6350 6300
$Comp
L GND #PWR?
U 1 1 551C6A82
P 6350 3850
F 0 "#PWR?" H 6350 3850 30  0001 C CNN
F 1 "GND" H 6350 3780 30  0001 C CNN
F 2 "" H 6350 3850 60  0000 C CNN
F 3 "" H 6350 3850 60  0000 C CNN
	1    6350 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3450 6350 3450
Wire Wire Line
	6350 3450 6350 3550
Wire Wire Line
	6350 3550 6350 3650
Wire Wire Line
	6350 3650 6350 3750
Wire Wire Line
	6350 3750 6350 3850
Wire Wire Line
	6450 3550 6350 3550
Connection ~ 6350 3550
Wire Wire Line
	6450 3650 6350 3650
Connection ~ 6350 3650
Wire Wire Line
	6450 3750 6350 3750
Connection ~ 6350 3750
$Comp
L VCC #PWR?
U 1 1 551C852E
P 3600 6450
F 0 "#PWR?" H 3600 6550 30  0001 C CNN
F 1 "VCC" H 3600 6550 30  0000 C CNN
F 2 "" H 3600 6450 60  0000 C CNN
F 3 "" H 3600 6450 60  0000 C CNN
	1    3600 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 6500 3600 6500
Wire Wire Line
	3600 6500 3600 6450
$Comp
L XTAL4PIN X?
U 1 1 551C8CD1
P 4600 7950
F 0 "X?" H 4360 8310 60  0000 C CNN
F 1 "XTAL4PIN" H 4650 7650 60  0000 C CNN
F 2 "~" H 4600 7950 60  0000 C CNN
F 3 "~" H 4600 7950 60  0000 C CNN
F 4 "6.3360MHz" H 4750 8300 60  0000 C CNN "Freqency"
	1    4600 7950
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR?
U 1 1 551C8CD7
P 5200 8250
F 0 "#PWR?" H 5200 8350 30  0001 C CNN
F 1 "VCC" H 5200 8350 30  0000 C CNN
F 2 "" H 5200 8250 60  0000 C CNN
F 3 "" H 5200 8250 60  0000 C CNN
	1    5200 8250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 551C8CDD
P 5200 7550
F 0 "#PWR?" H 5200 7550 30  0001 C CNN
F 1 "GND" H 5200 7480 30  0001 C CNN
F 2 "" H 5200 7550 60  0000 C CNN
F 3 "" H 5200 7550 60  0000 C CNN
	1    5200 7550
	-1   0    0    1   
$EndComp
NoConn ~ 3900 8150
Wire Wire Line
	5200 7750 5200 7550
Wire Wire Line
	5200 8250 5200 8150
Wire Wire Line
	3550 7850 3900 7850
$Comp
L XTAL4PIN X?
U 1 1 55209E51
P 10000 8800
F 0 "X?" H 9760 9160 60  0000 C CNN
F 1 "XTAL4PIN" H 10050 8500 60  0000 C CNN
F 2 "~" H 10000 8800 60  0000 C CNN
F 3 "~" H 10000 8800 60  0000 C CNN
F 4 "1.8432MHz" H 10150 9150 60  0000 C CNN "Freqency"
	1    10000 8800
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR?
U 1 1 55209E57
P 10600 9100
F 0 "#PWR?" H 10600 9200 30  0001 C CNN
F 1 "VCC" H 10600 9200 30  0000 C CNN
F 2 "" H 10600 9100 60  0000 C CNN
F 3 "" H 10600 9100 60  0000 C CNN
	1    10600 9100
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 55209E5D
P 10600 8400
F 0 "#PWR?" H 10600 8400 30  0001 C CNN
F 1 "GND" H 10600 8330 30  0001 C CNN
F 2 "" H 10600 8400 60  0000 C CNN
F 3 "" H 10600 8400 60  0000 C CNN
	1    10600 8400
	-1   0    0    1   
$EndComp
NoConn ~ 9300 9000
Wire Wire Line
	10600 8600 10600 8400
Wire Wire Line
	10600 9100 10600 9000
Wire Wire Line
	8950 8700 9300 8700
Wire Wire Line
	9250 6700 8950 6700
Wire Wire Line
	8950 6700 8950 8700
Text Label 9000 6700 0    60   ~ 0
UCLK
Wire Wire Line
	1300 4300 1500 4300
Wire Wire Line
	1500 4300 1600 4300
Wire Wire Line
	1600 4400 1500 4400
Wire Wire Line
	1500 4400 1500 4300
Connection ~ 1500 4300
Wire Wire Line
	3600 6100 3800 6100
Wire Wire Line
	9050 7300 9250 7300
Wire Wire Line
	9050 7400 9250 7400
Wire Wire Line
	9250 7600 9250 7500
Wire Wire Line
	9250 7500 9050 7500
Wire Wire Line
	5300 6400 5450 6400
Text Label 5450 6400 2    60   ~ 0
A15
Text Label 1300 4300 0    60   ~ 0
~IORQ
Wire Wire Line
	1600 4200 1300 4200
Text Label 1300 4200 0    60   ~ 0
~M1
Wire Wire Line
	10950 5950 11500 5950
Wire Wire Line
	11500 5950 11500 6850
Wire Wire Line
	11800 7050 11700 7050
Wire Wire Line
	11700 7050 11700 7150
Wire Wire Line
	11700 7150 11700 7250
Wire Wire Line
	11800 7150 11700 7150
Connection ~ 11700 7150
Wire Wire Line
	11500 6850 11800 6850
Wire Wire Line
	10950 6050 11400 6050
Wire Wire Line
	11400 6050 11400 6950
Wire Wire Line
	11400 6950 11800 6950
Wire Wire Line
	11800 7600 11300 7600
Wire Wire Line
	11300 7600 11300 5450
Wire Wire Line
	11300 5450 11050 5450
Wire Wire Line
	11050 5450 10950 5450
Wire Wire Line
	11050 5100 11050 5250
Wire Wire Line
	11050 5250 10950 5250
Wire Wire Line
	10950 5350 11050 5350
Wire Wire Line
	11050 5350 11050 5450
Connection ~ 11050 5450
Wire Wire Line
	11200 5550 11200 7700
Wire Wire Line
	11200 7700 11800 7700
Wire Wire Line
	13650 7600 13400 7600
Wire Wire Line
	13650 7100 13650 7600
Wire Wire Line
	14100 7100 13650 7100
Connection ~ 13800 7600
Wire Wire Line
	13800 7700 14100 7700
Wire Wire Line
	13800 7600 14100 7600
Wire Wire Line
	13800 6850 13800 7600
Wire Wire Line
	13800 7600 13800 7700
Wire Wire Line
	13400 6850 13800 6850
Wire Wire Line
	13850 6750 13400 6750
Wire Wire Line
	13850 7500 13850 6750
Wire Wire Line
	14100 7500 13850 7500
Wire Wire Line
	13600 7500 13400 7500
Wire Wire Line
	13600 7300 13600 7500
Wire Wire Line
	14100 7300 13600 7300
Wire Wire Line
	13400 6950 13750 6950
Wire Wire Line
	13750 6950 13750 7200
Wire Wire Line
	13750 7200 14100 7200
Wire Wire Line
	14100 7400 13700 7400
Wire Wire Line
	13700 7400 13700 7700
Wire Wire Line
	13700 7700 13400 7700
Text Notes 15000 6300 3    60   ~ 0
I use a cross-over connection between\n
Text Notes 15100 6250 3    60   ~ 0
the RS-232 and serial DB-9 connector.
NoConn ~ 14950 8000
Text Label 3800 4900 2    60   ~ 0
~M1
$Comp
L LED D?
U 1 1 553FBFC5
P 3100 5600
F 0 "D?" H 3100 5700 50  0000 C CNN
F 1 "LED" H 3100 5500 50  0000 C CNN
F 2 "~" H 3100 5600 60  0000 C CNN
F 3 "~" H 3100 5600 60  0000 C CNN
	1    3100 5600
	-1   0    0    1   
$EndComp
Wire Wire Line
	3800 5650 3700 5650
Wire Wire Line
	3700 5650 3700 5600
Wire Wire Line
	3700 5600 3500 5600
Wire Wire Line
	3500 5600 3500 5600
Wire Wire Line
	3500 5600 3300 5600
$Comp
L R R?
U 1 1 553FC307
P 2550 5850
F 0 "R?" V 2630 5850 40  0000 C CNN
F 1 "330" V 2557 5851 40  0000 C CNN
F 2 "~" V 2480 5850 30  0000 C CNN
F 3 "~" H 2550 5850 30  0000 C CNN
	1    2550 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 5600 2550 5600
$Comp
L GND #PWR?
U 1 1 553FC405
P 2550 6150
F 0 "#PWR?" H 2550 6150 30  0001 C CNN
F 1 "GND" H 2550 6080 30  0001 C CNN
F 2 "" H 2550 6150 60  0000 C CNN
F 3 "" H 2550 6150 60  0000 C CNN
	1    2550 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 6100 2550 6150
$Comp
L 74LS14 U?
U 3 1 553FC918
P 8300 8100
F 0 "U?" H 8450 8200 40  0000 C CNN
F 1 "74LS14" H 8500 8000 40  0000 C CNN
F 2 "~" H 8300 8100 60  0000 C CNN
F 3 "~" H 8300 8100 60  0000 C CNN
	3    8300 8100
	-1   0    0    1   
$EndComp
Wire Wire Line
	8750 7700 9250 7700
Text Label 7850 8100 2    60   ~ 0
UART_IRQ
Wire Wire Line
	3450 6000 3800 6000
Text Label 3450 6000 2    60   ~ 0
UART_IRQ
Wire Wire Line
	8750 7700 8750 8100
$EndSCHEMATC
