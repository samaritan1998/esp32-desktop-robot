// SPDX-License-Identifier: CC-BY-SA-4.0
// Copyright (c) 2026 samaritan1998 and contributors
// Third-party character and trademark rights are not granted.
// BoxBot 1.83: original WALL-E-inspired STATIC enclosure. Units: mm.

// Factory black case stays intact, rotated landscape with USB/buttons downward.

// This is a first fit prototype; print fit_coupon before the full head.

// Source generated from the same CSG construction as the supplied STLs.

$fn=64;

part="assembly"; // [assembly,print_layout,01_body_shell,02_body_back,03_track_left,04_track_right,05_arm_left,06_arm_right,07_neck,08_head_shell,09_head_back,10_fit_coupon]

explode=0; // [0:25]

show_case=true;

module m_01_body_shell() {
difference() {
union() {
difference() {
translate([0,0,27]) {
rotate([90,0,0]) {
linear_extrude(height=34.0,center=true) offset(r=3,$fn=64) square([44.0,28.0],center=true);
}
}
translate([0,2.4,27]) {
rotate([90,0,0]) {
linear_extrude(height=34,center=true) offset(r=1.5,$fn=64) square([42.2,26.2],center=true);
}
}
}
translate([-21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([-21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
}
translate([-21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([0,9,43]) {
cube([10.5,8.5,4],center=true);
}
translate([0,-16.9,28.5]) {
rotate([90,0,0]) {
linear_extrude(height=0.9,center=true) offset(r=2,$fn=64) square([31,16],center=true);
}
}
translate([-10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,17,12.0]) {
cube([10,6,4],center=true);
}
translate([0,-2.5,44]) {
linear_extrude(height=5,center=true) offset(r=1.2,$fn=64) square([15.6,9.6],center=true);
}
}
}

module m_02_body_back() {
difference() {
translate([0,18.2,27]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=3,$fn=64) square([44,28],center=true);
}
}
translate([-21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,18.2,24]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,28]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,32]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,12]) {
cube([10,5,4],center=true);
}
}
}

module m_03_track_left() {
mirror([1,0,0]) {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}
}

module m_04_track_right() {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}

module m_05_arm_left() {
mirror([1,0,0]) {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}
}

module m_06_arm_right() {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}

module m_07_neck() {
union() {
translate([0,9,42.5]) {
cube([10,8,3],center=true);
}
translate([0,9,44.5]) {
cube([12,10,1],center=true);
}
translate([0,9,48]) {
linear_extrude(height=6,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,52.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
}

module m_08_head_shell() {
difference() {
union() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
rotate([90,0,90]) linear_extrude(height=12,center=true) polygon([[5.2,51],[13,51],[13,55.2],[1,55.2]]);
}
translate([0,9,52.75]) {
cylinder(d=6.5,h=3.7,center=true,$fn=64);
}
}
}

module m_09_head_back() {
union() {
difference() {
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([-24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,14.2,71.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,81.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
}
translate([-12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([-12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
}
}

module m_10_fit_coupon() {
intersection() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
translate([0,-10,76.5]) {
cube([60,6,48],center=true);
}
}
}

module assembled() {

color("#D8A23E") translate([0*explode,0*explode,0*explode]) m_01_body_shell();

color("#D8A23E") translate([0*explode,1*explode,0*explode]) m_02_body_back();

color("#3D4248") translate([-1*explode,0*explode,0*explode]) m_03_track_left();

color("#3D4248") translate([1*explode,0*explode,0*explode]) m_04_track_right();

color("#D8A23E") translate([-1*explode,0*explode,0*explode]) m_05_arm_left();

color("#D8A23E") translate([1*explode,0*explode,0*explode]) m_06_arm_right();

color("#525B61") translate([0*explode,0*explode,0.4*explode]) m_07_neck();

color("#BEC3C8") translate([0*explode,0*explode,1*explode]) m_08_head_shell();

color("#BEC3C8") translate([0*explode,1*explode,1*explode]) m_09_head_back();

if(show_case) color("#15191D") translate([0,0,explode]) stock_case_preview();
}

module stock_case_preview() {
translate([0,-1.9,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=19.0,center=true) offset(r=7.5,$fn=64) square([29.200000000000003,22.200000000000003],center=true);
}
}
}

module print_layout() {

translate([0,0,0]) {
translate([-0.0,27.0,17.0]) {
rotate([90,0,0]) {
difference() {
union() {
difference() {
translate([0,0,27]) {
rotate([90,0,0]) {
linear_extrude(height=34.0,center=true) offset(r=3,$fn=64) square([44.0,28.0],center=true);
}
}
translate([0,2.4,27]) {
rotate([90,0,0]) {
linear_extrude(height=34,center=true) offset(r=1.5,$fn=64) square([42.2,26.2],center=true);
}
}
}
translate([-21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([-21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
}
translate([-21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([0,9,43]) {
cube([10.5,8.5,4],center=true);
}
translate([0,-16.9,28.5]) {
rotate([90,0,0]) {
linear_extrude(height=0.9,center=true) offset(r=2,$fn=64) square([31,16],center=true);
}
}
translate([-10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,17,12.0]) {
cube([10,6,4],center=true);
}
translate([0,-2.5,44]) {
linear_extrude(height=5,center=true) offset(r=1.2,$fn=64) square([15.6,9.6],center=true);
}
}
}
}
}

translate([70,0,0]) {
translate([-0.0,-27.0,19.4]) {
rotate([-90,0,0]) {
difference() {
translate([0,18.2,27]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=3,$fn=64) square([44,28],center=true);
}
}
translate([-21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,18.2,24]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,28]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,32]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,12]) {
cube([10,5,4],center=true);
}
}
}
}
}

translate([140,0,0]) {
translate([30.2,-0.0,-0.0]) {
rotate([0,0,0]) {
mirror([1,0,0]) {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}
}
}
}

translate([0,62,0]) {
translate([-30.2,-0.0,-0.0]) {
rotate([0,0,0]) {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}
}
}

translate([70,62,0]) {
translate([30.0,10.5,33.0]) {
rotate([0,-90,0]) {
mirror([1,0,0]) {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}
}
}
}

translate([140,62,0]) {
translate([-30.0,10.5,33.0]) {
rotate([0,90,0]) {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}
}
}

translate([0,124,0]) {
translate([-0.0,-9.0,-41.0]) {
rotate([0,0,0]) {
union() {
translate([0,9,42.5]) {
cube([10,8,3],center=true);
}
translate([0,9,44.5]) {
cube([12,10,1],center=true);
}
translate([0,9,48]) {
linear_extrude(height=6,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,52.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
}
}
}

translate([70,124,0]) {
translate([-0.0,74.5,13.0]) {
rotate([90,0,0]) {
difference() {
union() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
rotate([90,0,90]) linear_extrude(height=12,center=true) polygon([[5.2,51],[13,51],[13,55.2],[1,55.2]]);
}
translate([0,9,52.75]) {
cylinder(d=6.5,h=3.7,center=true,$fn=64);
}
}
}
}
}

translate([140,124,0]) {
translate([-0.0,-76.5,15.399999999999999]) {
rotate([-90,0,0]) {
union() {
difference() {
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([-24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,14.2,71.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,81.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
}
translate([-12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([-12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
}
}
}
}

translate([0,186,0]) {
translate([-0.0,76.5,13.0]) {
rotate([90,0,0]) {
intersection() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
translate([0,-10,76.5]) {
cube([60,6,48],center=true);
}
}
}
}
}

}

if(part=="assembly") assembled(); else if(part=="print_layout") print_layout();

else if(part=="01_body_shell") {
translate([-0.0,27.0,17.0]) {
rotate([90,0,0]) {
difference() {
union() {
difference() {
translate([0,0,27]) {
rotate([90,0,0]) {
linear_extrude(height=34.0,center=true) offset(r=3,$fn=64) square([44.0,28.0],center=true);
}
}
translate([0,2.4,27]) {
rotate([90,0,0]) {
linear_extrude(height=34,center=true) offset(r=1.5,$fn=64) square([42.2,26.2],center=true);
}
}
}
translate([-21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([-21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,14]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
translate([21,12.5,40]) {
rotate([90,0,0]) {
cylinder(d=6.0,h=9.0,center=true,$fn=64);
}
}
}
translate([-21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,14]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([21,13.0,40]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([24,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.4,h=6,center=true,$fn=64);
}
}
translate([-24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([24,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=6,center=true,$fn=64);
}
}
translate([0,9,43]) {
cube([10.5,8.5,4],center=true);
}
translate([0,-16.9,28.5]) {
rotate([90,0,0]) {
linear_extrude(height=0.9,center=true) offset(r=2,$fn=64) square([31,16],center=true);
}
}
translate([-10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([10,-16.9,40]) {
rotate([90,0,0]) {
linear_extrude(height=1.0,center=true) offset(r=0.5,$fn=64) square([6.0,0.19999999999999996],center=true);
}
}
translate([0,17,12.0]) {
cube([10,6,4],center=true);
}
translate([0,-2.5,44]) {
linear_extrude(height=5,center=true) offset(r=1.2,$fn=64) square([15.6,9.6],center=true);
}
}
}
}
}

else if(part=="02_body_back") {
translate([-0.0,-27.0,19.4]) {
rotate([-90,0,0]) {
difference() {
translate([0,18.2,27]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=3,$fn=64) square([44,28],center=true);
}
}
translate([-21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,14]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([21,18.2,40]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,18.2,24]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,28]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,32]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.8,$fn=64) square([16.4,0.19999999999999996],center=true);
}
}
translate([0,18.2,12]) {
cube([10,5,4],center=true);
}
}
}
}
}

else if(part=="03_track_left") {
translate([30.2,-0.0,-0.0]) {
rotate([0,0,0]) {
mirror([1,0,0]) {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}
}
}
}

else if(part=="04_track_right") {
translate([-30.2,-0.0,-0.0]) {
rotate([0,0,0]) {
union() {
difference() {
hull() {
translate([32,-16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
translate([32,16,8]) {
rotate([0,90,0]) {
cylinder(d=16,h=14,center=true,$fn=64);
}
}
}
translate([32,-14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,-3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,0.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,3.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,7.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,10.5,15.8]) {
cube([15,0.85,0.8],center=true);
}
translate([32,14.0,15.8]) {
cube([15,0.85,0.8],center=true);
}
difference() {
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,-14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,-14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,0,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,0,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
difference() {
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=11.0,h=1.4,center=true,$fn=64);
}
}
translate([38.7,14,8]) {
rotate([0,90,0]) {
cylinder(d=5.0,h=2,center=true,$fn=64);
}
}
}
translate([38.9,14,8]) {
rotate([0,90,0]) {
cylinder(d=1.8,h=1.2,center=true,$fn=64);
}
}
}
translate([23.4,-10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
translate([23.4,10,14]) {
rotate([0,90,0]) {
cylinder(d=4.0,h=4.0,center=true,$fn=64);
}
}
}
}
}
}

else if(part=="05_arm_left") {
translate([30.0,10.5,33.0]) {
rotate([0,-90,0]) {
mirror([1,0,0]) {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}
}
}
}

else if(part=="06_arm_right") {
translate([-30.0,10.5,33.0]) {
rotate([0,90,0]) {
union() {
translate([29.5,-7,31]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=2,$fn=64) square([3,14],center=true);
}
}
translate([28,-7,35]) {
rotate([0,90,0]) {
cylinder(d=7,h=6,center=true,$fn=64);
}
}
translate([23.75,-7,35]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=4.5,center=true,$fn=64);
}
}
translate([29.5,-8,22.5]) {
rotate([90,0,0]) {
linear_extrude(height=7,center=true) offset(r=1.2,$fn=64) square([4.6,2.6],center=true);
}
}
translate([27.2,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
translate([31.8,-13,21.6]) {
cube([2.4,9,3.2],center=true);
}
}
}
}
}

else if(part=="07_neck") {
translate([-0.0,-9.0,-41.0]) {
rotate([0,0,0]) {
union() {
translate([0,9,42.5]) {
cube([10,8,3],center=true);
}
translate([0,9,44.5]) {
cube([12,10,1],center=true);
}
translate([0,9,48]) {
linear_extrude(height=6,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,52.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
}
}
}

else if(part=="08_head_shell") {
translate([-0.0,74.5,13.0]) {
rotate([90,0,0]) {
difference() {
union() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
rotate([90,0,90]) linear_extrude(height=12,center=true) polygon([[5.2,51],[13,51],[13,55.2],[1,55.2]]);
}
translate([0,9,52.75]) {
cylinder(d=6.5,h=3.7,center=true,$fn=64);
}
}
}
}
}

else if(part=="09_head_back") {
translate([-0.0,-76.5,15.399999999999999]) {
rotate([-90,0,0]) {
union() {
difference() {
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([-24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,58.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([24,14.2,94.5]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,14.2,71.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
translate([0,14.2,81.5]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.7,$fn=64) square([16.6,0.20000000000000018],center=true);
}
}
}
translate([-12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([-12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,67.5]) {
cube([4,4.6,4],center=true);
}
translate([12,10.7,85.5]) {
cube([4,4.6,4],center=true);
}
}
}
}
}

else if(part=="10_fit_coupon") {
translate([-0.0,76.5,13.0]) {
rotate([90,0,0]) {
intersection() {
difference() {
intersection() {
union() {
difference() {
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
translate([0,0.85,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=24.5,center=true) offset(r=5.5,$fn=64) square([33.800000000000004,26.800000000000004],center=true);
}
}
translate([0,-12.5,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=5,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([-24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([-24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,58.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
translate([24,8.7,94.5]) {
rotate([90,0,0]) {
cylinder(d=5.2,h=8.6,center=true,$fn=64);
}
}
}
translate([0,0,76.5]) {
rotate([90,0,0]) {
linear_extrude(height=26.0,center=true) offset(r=5.8,$fn=64) square([42.4,31.4],center=true);
}
}
}
translate([-24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([-24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,58.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([24,9,94.5]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.2,center=true,$fn=64);
}
}
translate([0,-3.5,55.9]) {
cube([36,14.4,6.2],center=true);
}
}
translate([0,-10,76.5]) {
cube([60,6,48],center=true);
}
}
}
}
}