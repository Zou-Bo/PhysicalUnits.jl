# PhysicalUnits.jl

`PhysicalUnits.jl` is a Julia package that provides a minimal way to work with physical constants and units. 
Each physical constants and units are just `Float64`. One only need to apply the units when defining the system and 
when read the values of computed quantities. 

For example, define the system with `a = 1nm` and `B = 14Tesla` at the begining.
Then in the calculation, you can use `ElectronMass` and other physical constants.
After the calculation is finished, instead of reading out the result energy `E` directly, read `E/meV`.
In this example, `nm`, `Tesla`, `ElectronMass`, and `meV` are all `Float64`.

It does not provide any dimension-match check. It is your responsibility to make sure your formula are physically meaningful.

It allows you to choose from different unit "modes", where each mode defines a set of physical constants and units as 1. This is particularly useful when natural units are often used.

## Installation

You can install it with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:
```
pkg> add PhysicalUnits
```
Or, just from the Julia REPL:
```julia
import Pkg
Pkg.add("PhysicalUnits")
```

## Usage

There are three main ways to use `PhysicalUnits.jl`:

### 1. Using a specific mode directly (Most Recommended)

This is the recommended approach if you only need one set of units for your project. It is fast and safe because all constants are `const`.

```julia
using PhysicalUnits.ħkB4πϵ0_meVnm

energy = 10meV
temperature = 300Kelvin
# Notice that the value itself has no physical meaning; you need to divide it by the unit.
println("energy = $energy = $(energy/meV)meV, temperature = $temperature = $(temperature/Kelvin)K")
```

### 2. Choose the mode at runtime

This approach is flexible and allows you to choose the unit mode at run time. However, this flexibility comes at a performance cost because the physical constants and units are not `const`.

```julia
using PhysicalUnits

# everything is zero before choosing a mode
@show len = 5nm;

PhysicalUnit(:ħkB4πϵ0_meVnm)
# Notice that the value itself has no physical meaning; you need to divide it by the unit.
println("speed of light in vaccum: ", SpeedOfLight)
println("speed of light in vaccum with unit: ", SpeedOfLight/(Meter/Second), "m/s")

PhysicalUnit(:ħkB4πϵ0c_eV)
# Notice that the value itself has no physical meaning; you need to divide it by the unit.
println("speed of light in vaccum: ", SpeedOfLight) # This will be different
println("speed of light in vaccum with unit: ", SpeedOfLight/(Meter/Second), "m/s")
```

### 3. Using the `@with_units` macro 

This is a powerful approach that combines performance and flexibility. It allows you to define a block of code where all physical constants are set to a specific mode. Inside the block, the constants are defined as local variables.

```julia
using PhysicalUnits

@with_units :ħkB4πϵ0_meVnm begin
    energy = 10 * meV
    len = 5 * nm
    println("Energy: $energy, Length: $len")
end

@with_units :ħkB4πϵ0c_eV begin
    # In this block, the constants are from the ħkB4πϵ0c_eV mode
    energy = 0.5e6 * eV # 0.5 MeV
    println("Energy in eV: ", energy)
end
```

### A Note on Switching Modes

While this package offers the flexibility to switch between modes at runtime (Usage 2), this practice is highly discouraged in production code. When you switch modes, the numerical values of the unit variables (like `nm`, `eV`, etc.) change. This can lead to unexpected behavior and hard-to-find bugs. For example:

```julia
using PhysicalUnits

PhysicalUnit(:ħkB4πϵ0_meVnm)
a = 5 * nm # Here nm has a certain value
println("a = $a = $(a/nm)nm")

PhysicalUnit(:ħkB4πϵ0c_eV)
# Now nm has a different value, and the numerical value of 'a' is no longer 5 times the new 'nm'.
# This can make your code confusing and error-prone.
println("a = $a = $(a/nm)nm")
```

**Recommendation**: For any given project or script, it is highly recommended to **clarify the unit mode at the beginning and stick to it**.

*   **For projects and libraries**: Use **Usage 1** (`using PhysicalUnits.YourMode`) to ensure type stability and prevent accidental mode changes.
*   **For interactive exploration in the REPL**: **Usage 2** (`PhysicalUnit(:YourMode)`) is provided for convenience, especially when you are not sure which mode to use at the beginning of your session.
*   **For specific blocks of code**: If you need to work with different unit systems in the same file, use **Usage 3** (`@with_units`) to create lexically scoped blocks with well-defined units.

## Available Modes

*   `:ħkB4πϵ0_meVnm`: Natural units where `ħ=1`, `k_B=1`, `4πϵ₀=1`. The base units are `meV` for energy and `nm` for length.
*   `:ħkB4πϵ0c_eV`: Natural units where `ħ=1`, `k_B=1`, `4πϵ₀=1`, `c=1`. The base unit is `eV` for energy.

## API Reference

*   `PhysicalUnit(mode::Symbol)`: Set the physical units to a specific mode globally.
*   `@with_units mode ex`: Execute a block of code `ex` with the physical constants from the given `mode`.
*   `current_mode()`: Print the current mode explanation and return its symbol.

*   `PhysicalUnits.symbol_list::Vector{Symbol}`: List of available physical constants and units.
*   `PhysicalUnits.mode_list::Vector{Symbol}`: List of available unit modes.

## Adding New Modes

You can easily add your own modes.

1.  Create a new `.jl` file in the `src/` directory (e.g., `src/MyModes.jl`).
2.  In this file, define a new module for your mode, following the structure of the modules in `src/BasicModes.jl`.
3.  Include your new file in `src/PhysicalUnits.jl`.
4.  Add the symbol of your new mode to the `mode_list` in `src/PhysicalUnits.jl`.

You are welcome to share your unit modes by PR.

## Important Considerations

*   **No Physical Unit Checking**: This package provides a convenient way to manage numerical values of physical constants in different unit systems. However, it does **not** perform dimensional analysis or check for the physical meaningfulness of your calculations. It is your responsibility to ensure that your formulas and expressions are physically correct.
*   **Precision**: All physical constants and units are defined as `Float64`. This is suitable for most applications, but it may not be appropriate for ultra-precise calculations where arbitrary-precision arithmetic is required.

## License

This package is licensed under the MIT License. See the `LICENSE` file for details.