// SPDX-License-Identifier: CC-BY-SA-4.0
// Copyright (c) 2026 samaritan1998 and contributors
// Third-party character and trademark rights are not granted.
// Original Marvin-inspired desktop robot enclosure, units: millimetres.

// Keep the factory black case intact, landscape, USB/buttons down.

// Print the fit coupon before the complete head. Physical fit untested.

$fn=64;

part="assembly"; // [assembly,print_layout,01_head_front,02_head_back,03_body_shell,04_body_back,05_arm_left,06_arm_right,07_foot_left,08_foot_right,09_neck,10_fit_coupon,11_entry_gauge,12_trial_sleeve]

explode=0; // [0:25]

show_case=true;

module m_01_head_front() {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
}

module m_02_head_back() {
difference() {
union() {
union() {
intersection() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,29.5,70.0]) {
cube([100,30,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([-29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
intersection() {
translate([-10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([-10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
translate([-29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([-29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([0,22,66.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,74.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
}
}

module m_03_body_shell() {
difference() {
intersection() {
union() {
difference() {
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
}
}
translate([0,15,25]) {
rotate([90,0,0]) {
linear_extrude(height=12,center=true) offset(r=3.6,$fn=64) square([22.0,10.0],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([-10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([0,9,34.1]) {
cube([10.5,8.5,4.1],center=true);
}
translate([0,-8.8,27.5]) {
rotate([90,0,0]) {
linear_extrude(height=1.2,center=true) offset(r=2.0,$fn=64) square([8.0,1.0],center=true);
}
}
translate([0,-4,36.5]) {
cube([16,16,10],center=true);
}
}
}

module m_04_body_back() {
difference() {
translate([0,13.2,25]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5,$fn=64) square([22,10],center=true);
}
}
translate([-12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,13.2,34.1]) {
cube([10.5,4,4],center=true);
}
translate([0,13.2,23]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
translate([0,13.2,26]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
}
}

module m_05_arm_left() {
mirror([1,0,0]) {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}
}

module m_06_arm_right() {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}

module m_07_foot_left() {
mirror([1,0,0]) {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}
}

module m_08_foot_right() {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}

module m_09_neck() {
union() {
translate([0,9,34.5]) {
cube([10,8,3],center=true);
}
translate([0,9,36.5]) {
cube([12,10,1],center=true);
}
translate([0,9,38.5]) {
linear_extrude(height=3,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,41.5]) {
cylinder(d=6.2,h=3,center=true,$fn=64);
}
}
}

module m_10_fit_coupon() {
intersection() {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
translate([0,-12,70.0]) {
cube([60,6,48],center=true);
}
}
}

module m_11_entry_gauge() {
difference() {
translate([0,0,0]) {
linear_extrude(height=3,center=true) offset(r=3,$fn=64) square([47.6,41.6],center=true);
}
translate([0,0,0]) {
cube([47.6,41.6,5],center=true);
}
}
}

module m_12_trial_sleeve() {
difference() {
union() {
translate([0,-0.25,70.0]) {
cube([50.4,29.5,44.4],center=true);
}
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80,41.6],center=true);
}
translate([0,-14,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
translate([0,-4.5,46]) {
cube([36,16,16.2],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
}
}

module assembled() {

color("#E4E6E8") translate([0*explode,0*explode,1*explode]) m_01_head_front();

color("#E4E6E8") translate([0*explode,1*explode,1*explode]) m_02_head_back();

color("#E4E6E8") translate([0*explode,0*explode,0*explode]) m_03_body_shell();

color("#E4E6E8") translate([0*explode,1*explode,0*explode]) m_04_body_back();

color("#E4E6E8") translate([-1*explode,0*explode,0*explode]) m_05_arm_left();

color("#E4E6E8") translate([1*explode,0*explode,0*explode]) m_06_arm_right();

color("#E4E6E8") translate([-1*explode,0*explode,0*explode]) m_07_foot_left();

color("#E4E6E8") translate([1*explode,0*explode,0*explode]) m_08_foot_right();

color("#636B73") translate([0*explode,0*explode,0.35*explode]) m_09_neck();

if(show_case) color("#15191D") translate([0,0,explode]) stock_case_preview();
}

module stock_case_preview() {
translate([0,-3.9000000000000004,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=19.0,center=true) offset(r=7.5,$fn=64) square([29.200000000000003,22.200000000000003],center=true);
}
}
}

module print_layout() {

translate([0,0,0]) {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
}
}
}

translate([82,0,0]) {
translate([-0.0,-70.0,24.0]) {
rotate([-90,0,0]) {
difference() {
union() {
union() {
intersection() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,29.5,70.0]) {
cube([100,30,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([-29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
intersection() {
translate([-10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([-10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
translate([-29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([-29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([0,22,66.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,74.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
}
}
}
}

translate([164,0,0]) {
translate([-0.0,25.0,9.0]) {
rotate([90,0,0]) {
difference() {
intersection() {
union() {
difference() {
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
}
}
translate([0,15,25]) {
rotate([90,0,0]) {
linear_extrude(height=12,center=true) offset(r=3.6,$fn=64) square([22.0,10.0],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([-10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([0,9,34.1]) {
cube([10.5,8.5,4.1],center=true);
}
translate([0,-8.8,27.5]) {
rotate([90,0,0]) {
linear_extrude(height=1.2,center=true) offset(r=2.0,$fn=64) square([8.0,1.0],center=true);
}
}
translate([0,-4,36.5]) {
cube([16,16,10],center=true);
}
}
}
}
}

translate([0,70,0]) {
translate([-0.0,-25.0,14.399999999999999]) {
rotate([-90,0,0]) {
difference() {
translate([0,13.2,25]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5,$fn=64) square([22,10],center=true);
}
}
translate([-12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,13.2,34.1]) {
cube([10.5,4,4],center=true);
}
translate([0,13.2,23]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
translate([0,13.2,26]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
}
}
}
}

translate([82,70,0]) {
translate([24.9,-2.5,27.5]) {
rotate([0,-90,0]) {
mirror([1,0,0]) {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}
}
}
}

translate([164,70,0]) {
translate([-24.9,-2.5,27.5]) {
rotate([0,90,0]) {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}
}
}

translate([0,140,0]) {
translate([11.0,4.0,-0.0]) {
rotate([0,0,0]) {
mirror([1,0,0]) {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}
}
}
}

translate([82,140,0]) {
translate([-11.0,4.0,-0.0]) {
rotate([0,0,0]) {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}
}
}

translate([164,140,0]) {
translate([-0.0,-9.0,-33.0]) {
rotate([0,0,0]) {
union() {
translate([0,9,34.5]) {
cube([10,8,3],center=true);
}
translate([0,9,36.5]) {
cube([12,10,1],center=true);
}
translate([0,9,38.5]) {
linear_extrude(height=3,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,41.5]) {
cylinder(d=6.2,h=3,center=true,$fn=64);
}
}
}
}
}

translate([0,210,0]) {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
intersection() {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
translate([0,-12,70.0]) {
cube([60,6,48],center=true);
}
}
}
}
}

translate([82,210,0]) {
translate([-0.0,-0.0,1.5]) {
rotate([0,0,0]) {
difference() {
translate([0,0,0]) {
linear_extrude(height=3,center=true) offset(r=3,$fn=64) square([47.6,41.6],center=true);
}
translate([0,0,0]) {
cube([47.6,41.6,5],center=true);
}
}
}
}
}

translate([164,210,0]) {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
difference() {
union() {
translate([0,-0.25,70.0]) {
cube([50.4,29.5,44.4],center=true);
}
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80,41.6],center=true);
}
translate([0,-14,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
translate([0,-4.5,46]) {
cube([36,16,16.2],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
}
}
}
}

}

if(part=="assembly") assembled(); else if(part=="print_layout") print_layout();

else if(part=="01_head_front") {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
}
}
}

else if(part=="02_head_back") {
translate([-0.0,-70.0,24.0]) {
rotate([-90,0,0]) {
difference() {
union() {
union() {
intersection() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,29.5,70.0]) {
cube([100,30,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([-29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([-37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
hull() {
translate([29.5,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
translate([37.0,16.5,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=4.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
intersection() {
translate([-10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([-10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,61.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
intersection() {
translate([10,15.15,79.0]) {
cube([4,13.5,4],center=true);
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
}
}
translate([-29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([29.5,19.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=13,center=true,$fn=64);
}
}
translate([-29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([-29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([29.5,22.0,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.0,h=7.0,center=true,$fn=64);
}
}
translate([0,22,66.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
translate([0,22,74.0]) {
rotate([90,0,0]) {
linear_extrude(height=10,center=true) offset(r=0.7,$fn=64) square([10.6,0.20000000000000018],center=true);
}
}
}
}
}
}

else if(part=="03_body_shell") {
translate([-0.0,25.0,9.0]) {
rotate([90,0,0]) {
difference() {
intersection() {
union() {
difference() {
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=3.6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=3.6,$fn=48);
}
}
}
translate([0,15,25]) {
rotate([90,0,0]) {
linear_extrude(height=12,center=true) offset(r=3.6,$fn=64) square([22.0,10.0],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=6.2,h=6.0,center=true,$fn=64);
}
}
}
intersection() {
translate([0,3,25]) {
hull() {
translate([-11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([-11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,-6.0,5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,-5.0]) {
sphere(r=6,$fn=48);
}
translate([11.0,6.0,5.0]) {
sphere(r=6,$fn=48);
}
}
}
translate([0,-18,25]) {
cube([60,60,60],center=true);
}
}
}
translate([-12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,19]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([12,9,31]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=6.3,center=true,$fn=64);
}
}
translate([-15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([15,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.6,h=7,center=true,$fn=64);
}
}
translate([-10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([10,2,15.7]) {
cylinder(d=6.5,h=4,center=true,$fn=64);
}
translate([0,9,34.1]) {
cube([10.5,8.5,4.1],center=true);
}
translate([0,-8.8,27.5]) {
rotate([90,0,0]) {
linear_extrude(height=1.2,center=true) offset(r=2.0,$fn=64) square([8.0,1.0],center=true);
}
}
translate([0,-4,36.5]) {
cube([16,16,10],center=true);
}
}
}
}
}

else if(part=="04_body_back") {
translate([-0.0,-25.0,14.399999999999999]) {
rotate([-90,0,0]) {
difference() {
translate([0,13.2,25]) {
rotate([90,0,0]) {
linear_extrude(height=2.4,center=true) offset(r=5,$fn=64) square([22,10],center=true);
}
}
translate([-12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([-12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,19]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([12,13.2,31]) {
rotate([90,0,0]) {
cylinder(d=2.4,h=4,center=true,$fn=64);
}
}
translate([0,13.2,34.1]) {
cube([10.5,4,4],center=true);
}
translate([0,13.2,23]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
translate([0,13.2,26]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=0.6,$fn=64) square([8.8,0.19999999999999996],center=true);
}
}
}
}
}
}

else if(part=="05_arm_left") {
translate([24.9,-2.5,27.5]) {
rotate([0,-90,0]) {
mirror([1,0,0]) {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}
}
}
}

else if(part=="06_arm_right") {
translate([-24.9,-2.5,27.5]) {
rotate([0,90,0]) {
difference() {
union() {
translate([21.5,3,31]) {
sphere(r=4.5,$fn=64);
}
hull() {
translate([21.5,3,29.5]) {
sphere(r=3.5,$fn=48);
}
translate([23.5,3,21.5]) {
sphere(r=3.5,$fn=48);
}
}
translate([23.5,2,17.8]) {
hull() {
translate([-1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([-1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,-1.5,0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,-0.5]) {
sphere(r=3,$fn=48);
}
translate([1.0,1.5,0.5]) {
sphere(r=3,$fn=48);
}
}
}
translate([15.8,3,31]) {
rotate([0,90,0]) {
cylinder(d=4.2,h=5.6,center=true,$fn=64);
}
}
}
translate([21.9,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
translate([25.1,-2.3,17.8]) {
cube([0.6,1.0,3.6],center=true);
}
}
}
}
}

else if(part=="07_foot_left") {
translate([11.0,4.0,-0.0]) {
rotate([0,0,0]) {
mirror([1,0,0]) {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}
}
}
}

else if(part=="08_foot_right") {
translate([-11.0,4.0,-0.0]) {
rotate([0,0,0]) {
difference() {
union() {
translate([11.0,-4,5]) {
hull() {
translate([-5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([-5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,-15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,-0.5]) {
sphere(r=4.5,$fn=48);
}
translate([5.5,15.5,0.5]) {
sphere(r=4.5,$fn=48);
}
}
}
translate([10,2,11.0]) {
cylinder(d=7.4,h=5.0,center=true,$fn=64);
}
translate([10,2,13]) {
cylinder(d=8.8,h=2,center=true,$fn=64);
}
translate([10,2,15.5]) {
cylinder(d=6.2,h=3.0,center=true,$fn=64);
}
}
translate([11.0,-24.0,5.2]) {
rotate([90,0,0]) {
linear_extrude(height=2.8,center=true) offset(r=0.3,$fn=64) square([12.4,0.050000000000000044],center=true);
}
}
}
}
}
}

else if(part=="09_neck") {
translate([-0.0,-9.0,-33.0]) {
rotate([0,0,0]) {
union() {
translate([0,9,34.5]) {
cube([10,8,3],center=true);
}
translate([0,9,36.5]) {
cube([12,10,1],center=true);
}
translate([0,9,38.5]) {
linear_extrude(height=3,center=true) offset(r=1,$fn=64) square([6,4],center=true);
}
translate([0,9,41.5]) {
cylinder(d=6.2,h=3,center=true,$fn=64);
}
}
}
}
}

else if(part=="10_fit_coupon") {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
intersection() {
difference() {
difference() {
union() {
difference() {
union() {
intersection() {
difference() {
difference() {
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
intersection() {
translate([0,0,70.0]) {
scale([39.6,39.6,27.6]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.1,70.0]) {
cube([100,35.0,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([0,-14.0,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
intersection() {
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([34.0,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
intersection() {
translate([0,0,70.0]) {
scale([42.0,42.0,30.0]) {
translate([0,0,0]) {
sphere(r=1,$fn=128);
}
}
}
translate([0,4.5,70.0]) {
cube([100,39,100],center=true);
}
}
translate([0,-15.5,70.0]) {
cube([100,60,100],center=true);
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80.0,41.6],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([0,-4.5,46.0]) {
cube([36,16.0,16.2],center=true);
}
}
translate([0,9,43.3]) {
linear_extrude(height=6.6,center=true) offset(r=1.5,$fn=64) square([9.0,7.0],center=true);
}
}
translate([0,9,41.8]) {
cylinder(d=6.5,h=3.8,center=true,$fn=64);
}
}
translate([5,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([10,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([15,-4,100]) {
cube([2.8,12,28],center=true);
}
translate([-40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([-40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,65.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,70.0]) {
cube([38,10,2.4],center=true);
}
translate([40,-4.5,75.0]) {
cube([38,10,2.4],center=true);
}
}
translate([0,-12,70.0]) {
cube([60,6,48],center=true);
}
}
}
}
}

else if(part=="11_entry_gauge") {
translate([-0.0,-0.0,1.5]) {
rotate([0,0,0]) {
difference() {
translate([0,0,0]) {
linear_extrude(height=3,center=true) offset(r=3,$fn=64) square([47.6,41.6],center=true);
}
translate([0,0,0]) {
cube([47.6,41.6,5],center=true);
}
}
}
}
}

else if(part=="12_trial_sleeve") {
translate([-0.0,70.0,15.0]) {
rotate([90,0,0]) {
difference() {
union() {
translate([0,-0.25,70.0]) {
cube([50.4,29.5,44.4],center=true);
}
hull() {
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([-24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
hull() {
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
translate([24.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=5.6,h=8.5,center=true,$fn=64);
}
}
}
}
translate([0,26.6,70.0]) {
cube([47.6,80,41.6],center=true);
}
translate([0,-14,70.0]) {
rotate([90,0,0]) {
linear_extrude(height=4,center=true) offset(r=5.1,$fn=64) square([26.3,20.900000000000002],center=true);
}
}
translate([0,-4.5,46]) {
cube([36,16,16.2],center=true);
}
translate([-29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([-29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,64.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
translate([29.5,10.25,76.0]) {
rotate([90,0,0]) {
cylinder(d=1.7,h=8.8,center=true,$fn=64);
}
}
}
}
}
}