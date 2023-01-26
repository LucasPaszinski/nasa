defmodule Nasa do
  @type action :: :launch | :land
  # In meters per second square
  @type gravity :: float()
  # In kilograms
  @type weight :: integer()
  @type path :: [{action(), gravity()}]

  @fuel_at_end 0

  @spec calculate_full_trip_fuel(weight(), path()) :: any
  def calculate_full_trip_fuel(mass, actions) do
    actions
    |> Enum.reverse() # Start calc backward, cause i have no fuel at the end.
    |> Enum.reduce(
      @fuel_at_end,
      fn {action, gravity}, previous_fuel ->
        new_mass_in_mg = mass + previous_fuel
        calculate_leg_fuel(action, new_mass_in_mg, gravity, previous_fuel)
      end
    )
  end

  @spec calculate_leg_fuel(action(), weight(), gravity(), weight()) :: weight()
  def calculate_leg_fuel(action, mass, gravity, acc_fuel \\ 0) do
    fuel_required = formula(action, mass, gravity)

    no_more_fuel_required? = fuel_required <= 0

    if no_more_fuel_required? do
      acc_fuel
    else
      calculate_leg_fuel(action, fuel_required, gravity, fuel_required + acc_fuel)
    end
  end

  defp formula(:launch, mass, gravity), do: floor(mass * gravity * 0.042 - 33)
  defp formula(:land, mass, gravity), do: floor(mass * gravity * 0.033 - 42)
end
