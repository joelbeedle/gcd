with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; -- Added for Integer inputs
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

procedure Aviation_Tools is

   -- Coordinate type
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

   -- Function to calculate airplane fuel range
   function Calculate_Fuel_Range(Fuel_Capacity : Float; Fuel_Consumption : Float; Speed : Float) return Float is
   begin
      return (Fuel_Capacity / Fuel_Consumption) * Speed;
   end Calculate_Fuel_Range;

   -- Main program variables
   Option : Integer;

begin
   Put_Line("Aviation Tools");
   Put_Line("--------------");
   Put_Line("Choose an option:");
   Put_Line("1: Great Circle Distance (GCD)");
   Put_Line("2: Airplane Fuel Range Calculator");
   Put("Enter your choice (1 or 2): ");
   Ada.Integer_Text_IO.Get(Option);

   if Option = 1 then
      -- Great Circle Distance
      declare
         Point1, Point2 : Coordinates;
         Distance       : Float;
      begin
         Put_Line("Great Circle Distance Calculator");
         Put_Line("--------------------------------");
         Put_Line("Enter the latitude and longitude of the first point (in degrees):");
         Put("Latitude: ");
         Ada.Float_Text_IO.Get(Point1.Latitude);
         Put("Longitude: ");
         Ada.Float_Text_IO.Get(Point1.Longitude);
         Put_Line("Enter the latitude and longitude of the second point (in degrees):");
         Put("Latitude: ");
         Ada.Float_Text_IO.Get(Point2.Latitude);
         Put("Longitude: ");
         Ada.Float_Text_IO.Get(Point2.Longitude);
         Distance := Haversine_Distance(Point1, Point2);
         Put("The great circle distance between the two points is: ");
         Put(Distance, Fore => 0, Aft => 2);
         Put_Line(" km");
      end;

   elsif Option = 2 then
      -- Airplane Fuel Range Calculator
      declare
         Fuel_Capacity    : Float;
         Fuel_Consumption : Float;
         Speed            : Float;
         Aircraft_Range   : Float;
      begin
         Put_Line("Airplane Fuel Range Calculator");
         Put_Line("--------------------------------");
         Put_Line("Enter the fuel capacity of the airplane (in liters):");
         Ada.Float_Text_IO.Get(Fuel_Capacity);
         Put_Line("Enter the fuel consumption rate (in liters per hour):");
         Ada.Float_Text_IO.Get(Fuel_Consumption);
         Put_Line("Enter the cruising speed of the airplane (in kilometers per hour):");
         Ada.Float_Text_IO.Get(Speed);
         Aircraft_Range := Calculate_Fuel_Range(Fuel_Capacity, Fuel_Consumption, Speed);
         Put("The maximum range of the airplane is: ");
         Put(Aircraft_Range, Fore => 0, Aft => 2);
         Put_Line(" km");
      end;

   else
      Put_Line("Invalid option. Please restart the program and choose 1 or 2.");
   end if;

end Aviation_Tools;
