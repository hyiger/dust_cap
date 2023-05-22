/*
Metric Male or Female Dustcaps
Uses threads library from: https://www.thingiverse.com/thing:1686322
*/

$fa = 1;
$fs = 0.4;

include <threads.scad>

diameter = 54;
height = 6;
thickness = 4;
pitch = 0.75;
type = "male";

if (type == "male")
    difference()
    {
        ScrewThread(outer_diam = diameter, height = height, pitch = pitch);
        translate([ 0, 0, -1 ]) cylinder(h = height + 2, r = (diameter - thickness) / 2);
    }
else
    ScrewHole(outer_diam = diameter, height = height * 2, pitch = pitch)
        cylinder(h = height, r = diameter / 2 + thickness);

cap_diameter = type == "male" ? diameter ^ 2 / (diameter + thickness) : diameter + thickness;

cap(cap_diameter, thickness);
label(str("M", diameter), diameter / 4, 1);

module cap(diameter, thickness)
{
    translate([ 0, 0, -thickness ]) linear_extrude(thickness) for (i = [0:32])
    {
        rotate(i * 5, [ 0, 0, 1 ]) rounded_square(width = diameter - thickness, r = 2);
    }
}

module label(string, size, height, font = "Liberation Sans", halign = "center", valign = "center")
{
    linear_extrude(height)
    {
        text(text = string, size = size, font = font, halign = halign, valign = valign, $fn = 64);
    }
}

module rounded_square(width, r)
{
    hull()
    {
        translate([ -width / 2 + r, -width / 2 + r, 0 ]) circle(r);
        translate([ -width / 2 + r, width / 2 - r, 0 ]) circle(r);
        translate([ width / 2 - r, -width / 2 + r, 0 ]) circle(r);
        translate([ width / 2 - r, width / 2 - r, 0 ]) circle(r);
    }
}