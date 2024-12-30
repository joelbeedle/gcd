with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

procedure Great_Circle_Distance is

   type Coordinates is record
      Latitude  : Float; -- In degrees
      Longitude : Float; -- In degrees
   end record;

   Earth_Radius_KM : constant Float := 6371.0; -- Earth's radius in kilometers

   -- Function to convert degrees to radians
   function To_Radians(Degrees : Float) return Float is
   begin
      return Degrees * (Pi / 180.0);
   end To_Radians;

   -- Function to calculate the great circle distance
   function Haversine_Distance(A, B : Coordinates) return Float is
      Lat1_Rad   : constant Float := To_Radians(A.Latitude);
      Lat2_Rad   : constant Float := To_Radians(B.Latitude);
      Delta_Lat  : constant Float := To_Radians(B.Latitude - A.Latitude);
      Delta_Lon  : constant Float := To_Radians(B.Longitude - A.Longitude);

      haversine_a : constant Float :=
        Sin(Delta_Lat / 2.0)**2 +
        Cos(Lat1_Rad) * Cos(Lat2_Rad) * Sin(Delta_Lon / 2.0)**2;

      c : constant Float := 2.0 * Arctan(Sqrt(haversine_a) / Sqrt(1.0 - haversine_a));
   begin
      return Earth_Radius_KM * c;
   end Haversine_Distance;

   -- User input coordinates
   Point1, Point2 : Coordinates;

begin
   Put_Line("Great Circle Distance Calculator");
   Put_Line("--------------------------------");

   -- Input for first point
   Put_Line("Enter the latitude and longitude of the first point (in degrees):");
   Put("Latitude: ");
   Get(Point1.Latitude);
   Put("Longitude: ");
   Get(Point1.Longitude);

   -- Input for second point
   Put_Line("Enter the latitude and longitude of the second point (in degrees):");
   Put("Latitude: ");
   Get(Point2.Latitude);
   Put("Longitude: ");
   Get(Point2.Longitude);

   -- Calculate and display the distance
   Put_Line("Calculating the great circle distance...");
   declare
      Distance : constant Float := Haversine_Distance(Point1, Point2);
   begin
      Put("The great circle distance between the two points is: ");
      Put(Distance, Fore => 0, Aft => 2);
      Put_Line(" km");
   end;

end Great_Circle_Distance;
