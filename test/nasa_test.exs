defmodule NasaTest do
  use ExUnit.Case
  doctest Nasa

  describe "calculate_leg_fuel/3" do
    test "Apollo 11: land on earth" do
      assert Nasa.calculate_leg_fuel(:land, 28_801, 9.807) == 13_447
    end
  end

  describe "calculate_full_trip_fuel/2" do
    test "Apollo 11: launch Earth, land Moon, launch Moon, land Earth" do
      assert Nasa.calculate_full_trip_fuel(28_801, [
               {:launch, 9.807},
               {:land, 1.62},
               {:launch, 1.62},
               {:land, 9.807}
             ]) == 51_898
    end

    test "Mission on Mars: launch Earth, land Mars, launch Mars, land Earth" do
      assert Nasa.calculate_full_trip_fuel(14_606, [
               {:launch, 9.807},
               {:land, 3.711},
               {:launch, 3.711},
               {:land, 9.807}
             ]) == 33_388
    end

    test "Passenger ship: launch Earth, land Moon, launch Moon, land Mars, launch Mars, land Earth" do
      assert Nasa.calculate_full_trip_fuel(75432, [
               {:launch, 9.807},
               {:land, 1.62},
               {:launch, 1.62},
               {:land, 3.711},
               {:launch, 3.711},
               {:land, 9.807}
             ]) == 212_161
    end
  end
end
