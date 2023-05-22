$fa = 1;
$fs = 0.4;

include <threads.scad>

diameter = 54;
height = 6;
thickness = 4;
pitch = 0.75;
type = "female";

if (type == "male")
    difference()
    {
        ScrewThread(outer_diam = diameter, height = height, pitch = pitch);
        cylinder(h = height + 1, r = (diameter - thickness) / 2);
    }
else
    ScrewHole(outer_diam = diameter, height = height * 2, pitch = pitch)
        cylinder(h = height, r = diameter / 2 + thickness);

cap(diameter, thickness);
label(str("M", diameter), diameter / 4, 1);

module cap(diameter, thickness)
{
    translate([ 0, 0, -thickness ]) linear_extrude(thickness) for (i = [0:32])
    {
        rotate(i * 5, [ 0, 0, 1 ]) rounded_square(width = diameter - thickness, r_c = 2);
    }
}

module label(string, size, height, font = "Liberation Sans", halign = "center", valign = "center")
{
    linear_extrude(height)
    {
        text(text = string, size = size, font = font, halign = halign, valign = valign, $fn = 64);
    }
}

module rounded_square(width, r_c)
{
    hull()
    {
        translate([ -width / 2 + r_c, -width / 2 + r_c, 0 ]) circle(r_c);
        translate([ -width / 2 + r_c, width / 2 - r_c, 0 ]) circle(r_c);
        translate([ width / 2 - r_c, -width / 2 + r_c, 0 ]) circle(r_c);
        translate([ width / 2 - r_c, width / 2 - r_c, 0 ]) circle(r_c);
    }
}