module PhysicalUnits

include("BasicModes.jl")

export ReducedPlanckConstant, BoltzmannConstant
export SpeedOfLight, VacuumElectricPermittivity
export ElectronMass, ElementaryCharge, BohrMagneticMoment
export meV, nm, eV, Meter, cm
export Voltage, ns, Second
export Tesla, Kelvin, Joule, Watt
export InverseFineStructureConstant, Gram, kg

export @with_units, PhysicalUnit, current_mode


ReducedPlanckConstant::Float64 = 0.0
BoltzmannConstant::Float64 = 0.0
SpeedOfLight::Float64 = 0.0
VacuumElectricPermittivity::Float64 = 0.0
ElectronMass::Float64 = 0.0
ElementaryCharge::Float64 = 0.0
BohrMagneticMoment::Float64 = 0.0
meV::Float64 = 0.0
nm::Float64 = 0.0
eV::Float64 = 0.0
Meter::Float64 = 0.0
cm::Float64 = 0.0
Voltage::Float64 = 0.0
ns::Float64 = 0.0
Second::Float64 = 0.0
Tesla::Float64 = 0.0
Kelvin::Float64 = 0.0
Joule::Float64 = 0.0
Watt::Float64 = 0.0
InverseFineStructureConstant::Float64 = 0.0
Gram::Float64 = 0.0
kg::Float64 = 0.0

symbol_list = [
    # Physical constants
    :ReducedPlanckConstant,
    :BoltzmannConstant,
    :SpeedOfLight,
    :VacuumElectricPermittivity,
    :ElectronMass,
    :ElementaryCharge,
    :BohrMagneticMoment,
    :InverseFineStructureConstant,
    # Units
    :meV, :nm, :eV, :Meter, :cm,
    :Voltage, :ns, :Second,
    :Tesla, :Kelvin, :Joule, :Watt,
    :Gram, :kg
]

mode_list = [
    :ħkB4πϵ0_meVnm,
    :ħkB4πϵ0c_eV
]

current_mode_is::Symbol = :NoMode

"""
    current_mode()::Symbol

Print the current mode of the physical units and its documentation, and return the symbol of the current mode.
The mode is set by the `PhysicalUnit` function.
"""
function current_mode()::Symbol 
    mode_module = getfield(@__MODULE__, current_mode_is)
    println("Current mode is $current_mode_is: ", getfield(mode_module, :doc))
    current_mode_is
end

"""
    PhysicalUnit(mode::Symbol)

Set the physical units to a specific mode. The available modes are defined in the `mode_list`.
"""
function PhysicalUnit(mode::Symbol)
    @assert mode ∈ mode_list "Available modes are: $mode_list."
    global current_mode_is = mode
    mode_module = getfield(@__MODULE__, mode)
    for s in symbol_list
        val = getfield(mode_module, s)
        Core.eval(@__MODULE__, :($s = $val))
    end
end

"""
    @with_units mode ex

Execute a block of code `ex` with the physical constants from the given `mode`.
The constants are defined as local variables within the block.

# Example
```julia
@with_units :Unit_ħkB4πϵ0_meVnm begin
    energy = 10 * meV
    magnetic_field = 5 * Tesla
    println("Energy: \$(energy/meV)meV, Magnetic Field: \$(magnetic_field/Tesla)T.")
end
```
"""
macro with_units(mode, ex)
    if !(mode isa QuoteNode)
        error("Usage: @with_units :mode begin ... end")
    end
    mode_sym = mode.value
    if !(mode_sym in mode_list)
        error("Mode $mode_sym not found. Available modes: $mode_list")
    end

    mode_module = getfield(@__MODULE__, mode_sym)
    assignments = []
    for s in symbol_list
        val = getfield(mode_module, s)
        push!(assignments, :($(esc(s)) = $val))
    end

    return quote
        let
            $(assignments...)
            $(esc(ex))
        end
    end
end

end