// QD Motor Cradle - Pass 2 PROTOTYPE
// Source specification: V1_CRADLE_SPEC_PASS_2.md @ 05e382b
// PROTOTYPE - NOT ROVER_INTERFACE_VERIFIED. May earn CRADLE_STRUCTURE_VERIFIED on the fixture only.
// Units = mm. Choose the part to render with the "part" variable, then F5/F6/F7 to export STL.
// Rev-B tuning: change ONLY the PASS-2 block. The INHERITED block is FIT_VERIFIED - do not change.

part = "cradle";   // "cradle" | "strap" | "fixture" | "all"

// ===== INHERITED - Rev-A FIT_VERIFIED (FROZEN) =====
body_OD      = 24.79;
boss_D       = 6.93;
boss_H       = 2.42;
hole_offset  = 16.63/2;   // 8.315
cup_ID       = 25.14;     // C_cup 0.35 diametral
C_hole       = 3.4;
pocket_D     = 7.73;
pocket_depth = 2.82;
T_plate      = 4.0;
shaft_hole_D = 5.0;
saddle_len   = 22;
saddle_wall  = 3.0;
cup_OD       = cup_ID + 2*saddle_wall;   // 31.14

// ===== NEW - Pass-2 structural (tunable) =====
strap_gap      = 1.0;    // retention play - strap ceiling above motor
strap_boss_top = 4.0;    // boss height above equator = HARD COMPRESSION STOP
strap_boss_Y   = 17.0;
strap_boss_D   = 8.0;
strap_bar_w    = 12;
strap_thick    = 4.0;
strap_bolt_D   = 3.4;    // M3 clearance in strap feet
strap_insert_D = 4.2;    // M3 heat-set insert bore in bosses (tune to your inserts)
foot_thick     = 5.0;
foot_ear_Y     = 28;
foot_hole_Y    = 25;
foot_hole_D    = 3.4;
block_halfY    = 22;

// ===== derived =====
motor_r   = body_OD/2;                 // 12.395
bar_under = motor_r + strap_gap;       // 13.395  <- strap ceiling (compression-stop chain)
foot_botX = -(cup_OD/2 + foot_thick);  // -20.57
boss_z0 = 6; boss_z1 = 16; boss_zc = (boss_z0+boss_z1)/2;   // strap-boss span / center
fz1 = 3; fz2 = saddle_len - 3;                              // foot hole Z
fixture_thk = 8; fixture_Y = foot_ear_Y + 8;
$fn = 96;

module rrect(x,y,r){ hull() for(sx=[-1,1]) for(sy=[-1,1]) translate([sx*(x/2-r), sy*(y/2-r)]) circle(r); }

// ---------- CRADLE ----------
module cradle(){
  difference(){
    union(){
      // main body block: X foot_botX..0, Y +-block_halfY, Z -T_plate..+saddle_len
      translate([foot_botX, -block_halfY, -T_plate])
        cube([-foot_botX, 2*block_halfY, T_plate + saddle_len]);
      // foot ears (bottom slab widened in Y for accessible mounting)
      translate([foot_botX, -foot_ear_Y, 0])
        cube([foot_thick, 2*foot_ear_Y, saddle_len]);
      // strap-mount bosses (rise +X from equator to the hard-stop face)
      for(sy=[-1,1])
        translate([0, sy*strap_boss_Y - strap_boss_D/2, boss_z0])
          cube([strap_boss_top, strap_boss_D, boss_z1 - boss_z0]);
    }
    // motor bore -> 180 deg trough (block only exists for X<0)
    translate([0,0,-0.01]) cylinder(h=saddle_len+0.02, r=cup_ID/2);
    // datum-face features
    translate([0,0,-T_plate-0.01]) cylinder(h=T_plate+0.02, d=shaft_hole_D);      // shaft
    translate([0,0,-pocket_depth]) cylinder(h=pocket_depth+0.02, d=pocket_D);      // boss pocket
    for(sy=[-1,1]) translate([0, sy*hole_offset, -T_plate-0.01])                   // 2x M3
      cylinder(h=T_plate+0.02, d=C_hole);
    // strap insert bores (down -X into each boss)
    for(sy=[-1,1]) translate([strap_boss_top+0.01, sy*strap_boss_Y, boss_zc])
      rotate([0,-90,0]) cylinder(h=6, d=strap_insert_D);
    // foot mount holes (through the ears, +X)
    for(sy=[-1,1]) for(zz=[fz1,fz2])
      translate([foot_botX-0.01, sy*foot_hole_Y, zz]) rotate([0,90,0])
        cylinder(h=foot_thick+0.02, d=foot_hole_D);
    // L identification (recessed, +Y ear top)
    translate([foot_botX+foot_thick-0.6, foot_hole_Y, saddle_len/2])
      linear_extrude(0.8) text("L", size=6, halign="center", valign="center");
    // keying notch (asymmetric - +Y ear only)
    translate([foot_botX-0.01, foot_ear_Y-3, saddle_len-3])
      cube([foot_thick+0.02, 4, 4]);
  }
}

// ---------- STRAP (removable retention, compression-limited) ----------
module strap(){
  difference(){
    union(){
      // top bar underside at X = bar_under (the fixed ceiling over the motor)
      translate([bar_under, -(strap_boss_Y+strap_boss_D/2), boss_zc - strap_bar_w/2])
        cube([strap_thick, 2*(strap_boss_Y+strap_boss_D/2), strap_bar_w]);
      // two feet: from boss top (hard stop) up to the bar
      for(sy=[-1,1])
        translate([strap_boss_top, sy*strap_boss_Y - strap_boss_D/2, boss_zc - strap_bar_w/2])
          cube([bar_under - strap_boss_top + 0.01, strap_boss_D, strap_bar_w]);
    }
    // bolt holes through feet + bar into boss inserts
    for(sy=[-1,1]) translate([strap_boss_top-0.01, sy*strap_boss_Y, boss_zc])
      rotate([0,90,0]) cylinder(h=bar_under - strap_boss_top + strap_thick + 0.02, d=strap_bolt_D);
  }
}

// ---------- FIXTURE (rigid stand-in for the skeleton; prototype rig) ----------
module fixture(){
  difference(){
    translate([foot_botX - fixture_thk, -fixture_Y, -8])
      cube([fixture_thk, 2*fixture_Y, saddle_len + 16]);
    // insert/tapped holes matching the foot ears
    for(sy=[-1,1]) for(zz=[fz1,fz2])
      translate([foot_botX+0.01, sy*foot_hole_Y, zz]) rotate([0,90,0])
        cylinder(h=fixture_thk+0.02, d=strap_insert_D);
    // vise-grip relief slots (optional clamp points)
    for(sy=[-1,1]) translate([foot_botX - fixture_thk-0.01, sy*(fixture_Y-4), saddle_len/2])
      rotate([0,90,0]) cylinder(h=fixture_thk+0.02, d=6);
  }
}

if (part=="cradle") cradle();
else if (part=="strap") strap();
else if (part=="fixture") fixture();
else { // "all" - preview only, do NOT export as one STL
  cradle();
  color("orange") strap();
  color("gray") translate([-6,0,0]) fixture();
}
