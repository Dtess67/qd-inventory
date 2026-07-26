// QD Motor Cradle - Coupon Rev A (fit test)
// Traces to V1_CRADLE_SPEC_PASS_1.md @ f6377c7
// Units = millimeters. To tune for Rev B, change only the numbers in the
// "PROVISIONAL" block below, then re-export the STL.

// ---------- MEASURED (fixed - do not change) ----------
body_OD     = 24.79;      // motor body outer diameter
boss_D      = 6.93;       // center brass hub diameter
boss_H      = 2.42;       // center brass hub height
hole_offset = 16.63 / 2;  // half the M3 face-hole spacing = 8.315

// ---------- PROVISIONAL (tune these for Rev B) ----------
C_cup        = 0.35;               // saddle clearance, DIAMETRAL
C_hole       = 3.4;                // M3 through-hole diameter
D_pocket     = 0.40;               // boss pocket radial clearance
H_pocket     = 0.40;               // boss pocket axial clearance
T_plate      = 4.0;                // face-wall thickness
shaft_hole_D = 5.0;                // clearance hole for the 4mm shaft
saddle_len   = 22;                 // how far the trough runs
saddle_wall  = 3.0;                // trough wall thickness

// ---------- derived (leave alone) ----------
cup_ID       = body_OD + C_cup;        // 25.14
cup_OD       = cup_ID + 2*saddle_wall; // 31.14
pocket_D     = boss_D + 2*D_pocket;    // 7.73
pocket_depth = boss_H + H_pocket;      // 2.82
fp_x = 36; fp_y = 32; fillet = 3;
$fn = 96;

module rrect(x, y, r) {
  hull() for (sx=[-1,1]) for (sy=[-1,1])
    translate([sx*(x/2-r), sy*(y/2-r)]) circle(r);
}

difference() {
  union() {
    // face wall (sits flat on the bed)
    linear_extrude(T_plate) rrect(fp_x, fp_y, fillet);
    // saddle trough (half-pipe, opens upward), rises off the wall
    translate([0,0,T_plate])
      linear_extrude(saddle_len)
        difference() {
          circle(d=cup_OD);
          circle(d=cup_ID);
          translate([cup_OD/2,0]) square([cup_OD, cup_OD], center=true);
        }
  }
  // central shaft clearance hole
  translate([0,0,-0.1]) cylinder(h=T_plate+0.2, d=shaft_hole_D);
  // boss pocket (opens up on the motor-mating face)
  translate([0,0,T_plate-pocket_depth]) cylinder(h=pocket_depth+0.1, d=pocket_D);
  // two M3 through-holes
  for (sy=[-1,1]) translate([0, sy*hole_offset, -0.1]) cylinder(h=T_plate+0.2, d=C_hole);
  // recessed "L" for left-hand identification
  translate([-fp_x/2+5, 0, -0.1]) linear_extrude(0.8)
    text("L", size=6, halign="center", valign="center");
}
